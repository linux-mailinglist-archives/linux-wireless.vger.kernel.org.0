Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750365B050
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 12:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjABLMm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 06:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjABLMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 06:12:40 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73362F5
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 03:12:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso18364128wmb.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jan 2023 03:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndOJzTDBqP1IyqfQR11CAwaWwpSVOFyyal0RlMp5iQk=;
        b=CvNb2HXqKBYVLZZKnqfYRzGzAhecqe/Q0ur3fL1yrMi15bFSQrIKg3kRjtRFMOxp7u
         R0VQD9bdjh0UYbeTpYXuMeFHkAnIrrm5HDiQNlJZnCiDINevoMRZaObM7GteK5MKfY3M
         9aWrcjVX7bw4aKfoORU646D+vW650FVy93J1ZwARGgpO4yL47Oa4b962++eQ7HCwn062
         KoeRw2mkB5lgrjWUoBnaMUZxYPXfGybjaEIbG4ohNdZ6WrzKPtTgkfeEIo3ELEDFd5pY
         lNTvnbVKltiobx07XOEAzCD441LisdjyDrSoHw9BffhfNaoaf3UPYkPotHl6nXzGzpl2
         ahSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndOJzTDBqP1IyqfQR11CAwaWwpSVOFyyal0RlMp5iQk=;
        b=29FQsf4VCD4qL/rnfhgSiE3IJobtSJc6B6TjorgYDmjfWEFO013QyffQ2p0CNf3Cnm
         9dpthgDx4aw5NF0OyVNDllRcUv7PhW08sup9lBAWrNWKdmlnwLPVRnXZqYb5hsVg+MrY
         6GTaSx9+zBStuSaJApzPTT8MoycdstJnXXyLgHq8h7PqQ+Ffb0zYzL3EICCR8oUYRZiE
         vnVKLvOTpO79S/4qle83VxpP7OBcRmKTxgd3StYkqb9dQ4MC6zKpdxkhqAC3ssFKcASK
         Ll+n3CTIkcezj7k6JbOtbLjEW/AozdkKrPoCF559DkccwKCaOtq23i0hP1DQEv/J8YFO
         YBZQ==
X-Gm-Message-State: AFqh2kqimkO1oT37PR842bhzc32EpcYQYBP0xxnpQw0dWUUZnV8LWtby
        AhdFuR3bSTznsexni49CBQAfQlGe+5cDUuJ7WDU=
X-Google-Smtp-Source: AMrXdXsuWJV6cAqHKFdm26fqNUHeQmkv2k0wQBFSOlRCLZAmaYlPkr4DwCAbQ4XVU1v8jLAQKDGmIw==
X-Received: by 2002:a1c:3887:0:b0:3d2:26cd:3b1e with SMTP id f129-20020a1c3887000000b003d226cd3b1emr28102311wma.28.1672657955219;
        Mon, 02 Jan 2023 03:12:35 -0800 (PST)
Received: from debian-hp-1.fritz.box (213.211.137.251.static.edpnet.net. [213.211.137.251])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b003b47e75b401sm46491258wmo.37.2023.01.02.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 03:12:34 -0800 (PST)
From:   =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
Subject: [PATCH v2 1/1] iw: add support for retrieving keys
Date:   Mon,  2 Jan 2023 12:12:13 +0100
Message-Id: <20230102111213.77129-1-raphael.melotte@mind.be>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20220822074318.291949-2-raphael.melotte@mind.be>
References: <20220822074318.291949-2-raphael.melotte@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For debugging purposes, it can be useful to be able to retrieve keys.

Add a "iw key get" command, to be able to retrieve keys when the key
index is known. A new "key" section is also introduced, in preparation
for future key-related commands.

Example retrieving a pairwise key:
iw dev wlan0 key get 0 02:02:03:04:05:06

Example retrieving a group key:
iw dev wlan0 key get 1

Note that only the outer ATTR_KEY_DATA (and seq) is reported, the
nested KEY_DATA (and seq) within ATTR_KEY is not.

Signed-off-by: Raphaël Mélotte <raphael.melotte@mind.be>
---
Changes v1 -> v2:
  - Introduce a 'key' section and update commit message
  - Fix documentation (and remove pairwise flag)
  - Return error when MAC is invalid
  - Rebase on master
 keys.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 keys.c

diff --git a/keys.c b/keys.c
new file mode 100644
index 0000000..37abc94
--- /dev/null
+++ b/keys.c
@@ -0,0 +1,80 @@
+#include <errno.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+#include "nl80211.h"
+#include "iw.h"
+
+SECTION(key);
+
+static int print_keys(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[NL80211_ATTR_MAX + 1];
+
+	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!tb[NL80211_ATTR_KEY_IDX]) {
+		fprintf(stderr, "KEY_IDX missing!\n");
+		return NL_SKIP;
+	}
+
+	if (!tb[NL80211_ATTR_KEY_DATA]) {
+		fprintf(stderr, "ATTR_KEY_DATA missing!\n");
+		return NL_SKIP;
+	}
+
+	iw_hexdump("Key", nla_data(tb[NL80211_ATTR_KEY_DATA]),
+		   nla_len(tb[NL80211_ATTR_KEY_DATA]));
+
+	if (!tb[NL80211_ATTR_KEY_SEQ]) {
+		fprintf(stderr, "ATTR_KEY_SEQ missing!\n");
+		return NL_SKIP;
+	}
+
+	iw_hexdump("Key seq", nla_data(tb[NL80211_ATTR_KEY_SEQ]),
+		   nla_len(tb[NL80211_ATTR_KEY_SEQ]));
+
+	return NL_OK;
+}
+
+static int handle_get_key(struct nl80211_state *state,
+			  struct nl_msg *msg, int argc, char **argv,
+			  enum id_input id)
+{
+	char *end;
+	unsigned char mac[6];
+
+	/* key index */
+	if (argc) {
+		nla_put_u8(msg, NL80211_ATTR_KEY_IDX, strtoul(argv[0], &end, 10));
+		argv++;
+		argc--;
+	}
+
+	/* mac */
+	if (argc) {
+		if (mac_addr_a2n(mac, argv[0]) == 0) {
+			NLA_PUT(msg, NL80211_ATTR_MAC, 6, mac);
+			argv++;
+			argc--;
+			nla_put_u32(msg, NL80211_ATTR_KEY_TYPE, NL80211_KEYTYPE_PAIRWISE);
+		} else {
+			return -EINVAL;
+		}
+	} else {
+		nla_put_u32(msg, NL80211_ATTR_KEY_TYPE, NL80211_KEYTYPE_GROUP);
+	}
+
+	register_handler(print_keys, NULL);
+	return 0;
+
+ nla_put_failure:
+	return -ENOSPC;
+}
+COMMAND(key, get, "<key index> <MAC address>",
+	NL80211_CMD_GET_KEY, 0, CIB_NETDEV, handle_get_key,
+	"Retrieve a key and key sequence.\n");
-- 
2.38.1

