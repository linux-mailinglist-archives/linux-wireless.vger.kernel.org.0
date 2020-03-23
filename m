Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7360718F885
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCWPZx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:53 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49302 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgCWPZu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxY-002WVN-4P; Mon, 23 Mar 2020 16:25:48 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/7] wmediumd: add a unix-domain control socket
Date:   Mon, 23 Mar 2020 16:25:39 +0100
Message-Id: <20200323162245.21851c824363.I8d19588ecaf6c86037de2bdc098ee678eba49602@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323152542.68696-1-johannes@sipsolutions.net>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a control socket that - right now - can be used to also
transmit/receive frames, actually carrying netlink messages;
however, for that a register/unregister is provided so that
we can extend the protocol to a pure control protocol in the
future.

---
 wmediumd/api.h      |  41 +++++++++++++++++
 wmediumd/wmediumd.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
 wmediumd/wmediumd.h |   4 ++
 3 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 wmediumd/api.h

diff --git a/wmediumd/api.h b/wmediumd/api.h
new file mode 100644
index 000000000000..6ecaa7bd94b9
--- /dev/null
+++ b/wmediumd/api.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _WMEDIUMD_API_H
+#define _WMEDIUMD_API_H
+
+enum wmediumd_message {
+	/* invalid message */
+	WMEDIUMD_MSG_INVALID,
+
+	/* ACK, returned for each message for synchronisation */
+	WMEDIUMD_MSG_ACK,
+
+	/*
+	 * Register/unregister for frames, this may be a pure control
+	 * socket which doesn't want to see frames.
+	 */
+	WMEDIUMD_MSG_REGISTER,
+	WMEDIUMD_MSG_UNREGISTER,
+
+	/*
+	 * netlink message, the data is the entire netlink message,
+	 * this is used to communicate frame TX/RX in the familiar
+	 * netlink format, to avoid having a special format
+	 */
+	WMEDIUMD_MSG_NETLINK,
+};
+
+struct wmediumd_message_header {
+	/* type of message - see enum wmediumd_message */
+	uint32_t type;
+	/* data length */
+	uint32_t data_len;
+
+	/* variable-length data according to the message type */
+	uint8_t data[];
+};
+
+#endif /* _WMEDIUMD_API_H */
diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 39797e58f277..a1e16defd144 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -39,10 +39,12 @@
 #include <usfstl/sched.h>
 #include <usfstl/schedctrl.h>
 #include <usfstl/vhost.h>
+#include <usfstl/uds.h>
 
 #include "wmediumd.h"
 #include "ieee80211.h"
 #include "config.h"
+#include "api.h"
 
 USFSTL_SCHEDULER(scheduler);
 
@@ -381,6 +383,7 @@ static void wmediumd_send_to_client(struct wmediumd *ctx,
 				    struct client *client,
 				    struct nl_msg *msg)
 {
+	struct wmediumd_message_header hdr;
 	size_t len;
 	int ret;
 
@@ -395,6 +398,15 @@ static void wmediumd_send_to_client(struct wmediumd *ctx,
 		usfstl_vhost_user_dev_notify(client->dev, HWSIM_VQ_RX,
 					     (void *)nlmsg_hdr(msg), len);
 		break;
+	case CLIENT_API_SOCK:
+		len = nlmsg_total_size(nlmsg_datalen(nlmsg_hdr(msg)));
+		hdr.type = WMEDIUMD_MSG_NETLINK;
+		hdr.data_len = len;
+		write(client->loop.fd, &hdr, sizeof(hdr));
+		write(client->loop.fd, (void *)nlmsg_hdr(msg), len);
+		/* read the ACK back */
+		read(client->loop.fd, &hdr, sizeof(hdr));
+		break;
 	}
 }
 
@@ -758,6 +770,93 @@ static const struct usfstl_vhost_user_ops wmediumd_vu_ops = {
 	.disconnected = wmediumd_vu_disconnected,
 };
 
+static void wmediumd_api_handler(struct usfstl_loop_entry *entry)
+{
+	struct client *client = container_of(entry, struct client, loop);
+	struct wmediumd *ctx = entry->data;
+	struct wmediumd_message_header hdr;
+	enum wmediumd_message response = WMEDIUMD_MSG_ACK;
+	struct nl_msg *nlmsg;
+	unsigned char *data;
+	ssize_t len;
+
+	len = read(entry->fd, &hdr, sizeof(hdr));
+	if (len != sizeof(hdr))
+		goto disconnect;
+
+	/* safety valve */
+	if (hdr.data_len > 1024 * 1024)
+		goto disconnect;
+
+	data = malloc(hdr.data_len);
+	if (!data)
+		goto disconnect;
+
+	len = read(entry->fd, data, hdr.data_len);
+	if (len != hdr.data_len)
+		goto disconnect;
+
+	switch (hdr.type) {
+	case WMEDIUMD_MSG_REGISTER:
+		if (!list_empty(&client->list)) {
+			response = WMEDIUMD_MSG_INVALID;
+			break;
+		}
+		list_add(&client->list, &ctx->clients);
+		break;
+	case WMEDIUMD_MSG_UNREGISTER:
+		if (list_empty(&client->list)) {
+			response = WMEDIUMD_MSG_INVALID;
+			break;
+		}
+		list_del_init(&client->list);
+		break;
+	case WMEDIUMD_MSG_NETLINK:
+		if (!nlmsg_ok((const struct nlmsghdr *)data, len)) {
+			response = WMEDIUMD_MSG_INVALID;
+			break;
+		}
+
+		nlmsg = nlmsg_convert((struct nlmsghdr *)data);
+		if (!nlmsg)
+			break;
+
+		_process_messages(nlmsg, ctx, client);
+
+		nlmsg_free(nlmsg);
+		break;
+	default:
+		response = WMEDIUMD_MSG_INVALID;
+		break;
+	}
+
+	/* return a response */
+	hdr.type = response;
+	hdr.data_len = 0;
+	len = write(entry->fd, &hdr, sizeof(hdr));
+	if (len != sizeof(hdr))
+		goto disconnect;
+
+	return;
+disconnect:
+	usfstl_loop_unregister(&client->loop);
+	wmediumd_remove_client(ctx, client);
+}
+
+static void wmediumd_api_connected(int fd, void *data)
+{
+	struct wmediumd *ctx = data;
+	struct client *client;
+
+	client = calloc(1, sizeof(*client));
+	client->type = CLIENT_API_SOCK;
+	client->loop.fd = fd;
+	client->loop.data = ctx;
+	client->loop.handler = wmediumd_api_handler;
+	usfstl_loop_register(&client->loop);
+	INIT_LIST_HEAD(&client->list);
+}
+
 /*
  * Register with the kernel to start receiving new frames.
  */
@@ -862,6 +961,7 @@ static void print_help(int exval)
 	printf("  -x FILE         set input PER file\n");
 	printf("  -t socket       set the time control socket\n");
 	printf("  -u socket       expose vhost-user socket, don't use netlink\n");
+	printf("  -a socket       expose wmediumd API socket\n");
 	printf("  -n              force netlink use even with vhost-user\n");
 
 	exit(exval);
@@ -873,7 +973,7 @@ int main(int argc, char *argv[])
 	struct wmediumd ctx = {};
 	char *config_file = NULL;
 	char *per_file = NULL;
-	const char *time_socket = NULL;
+	const char *time_socket = NULL, *api_socket = NULL;
 	struct usfstl_sched_ctrl ctrl = {};
 	struct usfstl_vhost_user_server vusrv = {
 		.ops = &wmediumd_vu_ops,
@@ -896,7 +996,7 @@ int main(int argc, char *argv[])
 	unsigned long int parse_log_lvl;
 	char* parse_end_token;
 
-	while ((opt = getopt(argc, argv, "hVc:l:x:t:u:n")) != -1) {
+	while ((opt = getopt(argc, argv, "hVc:l:x:t:u:a:n")) != -1) {
 		switch (opt) {
 		case 'h':
 			print_help(EXIT_SUCCESS);
@@ -934,6 +1034,9 @@ int main(int argc, char *argv[])
 		case 'u':
 			vusrv.socket = optarg;
 			break;
+		case 'a':
+			api_socket = optarg;
+			break;
 		case 'n':
 			force_netlink = true;
 			break;
@@ -1004,6 +1107,9 @@ int main(int argc, char *argv[])
 			w_logf(&ctx, LOG_NOTICE, "REGISTER SENT!\n");
 	}
 
+	if (api_socket)
+		usfstl_uds_create(api_socket, wmediumd_api_connected, &ctx);
+
 	while (1) {
 		if (time_socket) {
 			usfstl_sched_next(&scheduler);
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index 06b356516a15..1d0392616d83 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -150,6 +150,7 @@ struct station {
 enum client_type {
 	CLIENT_NETLINK,
 	CLIENT_VHOST_USER,
+	CLIENT_API_SOCK,
 };
 
 struct client {
@@ -163,6 +164,9 @@ struct client {
 
 	/* for vhost-user */
 	struct usfstl_vhost_user_dev *dev;
+
+	/* for API socket */
+	struct usfstl_loop_entry loop;
 };
 
 struct wmediumd {
-- 
2.25.1

