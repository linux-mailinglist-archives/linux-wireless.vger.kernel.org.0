Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F79209F3C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404945AbgFYNJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404944AbgFYNI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424D2C08C5DD
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRcc-00BrnC-HO; Thu, 25 Jun 2020 15:08:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7/9] wmediumd: add the ability to write a pcapng file
Date:   Thu, 25 Jun 2020 15:08:42 +0200
Message-Id: <20200625150754.554b7fc226a1.I14409b6cb5998e7bd087c1329952fbfa1a30d45e@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625130844.22893-1-johannes@sipsolutions.net>
References: <20200625130844.22893-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add the ability to write a pcapng file containing all the data.
The radiotap header is currently very minimal with only the
frequency and the signal strength.

---
 wmediumd/wmediumd.c | 119 +++++++++++++++++++++++++++++++++++++++++++-
 wmediumd/wmediumd.h |   2 +
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index afc4f16d9ae9..5304931fbf74 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -36,6 +36,7 @@
 #include <limits.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <endian.h>
 #include <usfstl/loop.h>
 #include <usfstl/sched.h>
 #include <usfstl/schedctrl.h>
@@ -309,6 +310,48 @@ static void wmediumd_notify_frame_start(struct usfstl_job *job)
 	}
 }
 
+static void log2pcap(struct wmediumd *ctx, struct frame *frame, uint64_t ts)
+{
+	struct {
+		uint8_t it_version;
+		uint8_t it_pad;
+		uint16_t it_len;
+		uint32_t it_present;
+		struct {
+			uint16_t freq, flags;
+		} channel;
+		uint8_t signal;
+	} __attribute__((packed)) radiotap_hdr = {
+		.it_len = htole16(sizeof(radiotap_hdr)),
+		.it_present = htole32(1 << 3 /* channel */ |
+				      1 << 5 /* signal dBm */),
+		.channel.freq = htole16(frame->freq),
+		.signal = frame->signal,
+	};
+	struct {
+		uint32_t type, blocklen, ifidx, ts_hi, ts_lo, caplen, pktlen;
+	} __attribute__((packed)) blockhdr = {
+		.type = 6,
+		.ts_hi = ts / (1ULL << 32),
+		.ts_lo = ts,
+		.caplen = frame->data_len + sizeof(radiotap_hdr),
+		.pktlen = frame->data_len + sizeof(radiotap_hdr),
+	};
+	static const uint8_t pad[3];
+	uint32_t sz, align;
+
+	sz = blockhdr.caplen + sizeof(blockhdr) + sizeof(uint32_t);
+	blockhdr.blocklen = (sz + 3) & ~3;
+	align = blockhdr.blocklen - sz;
+
+	fwrite(&blockhdr, sizeof(blockhdr), 1, ctx->pcap_file);
+	fwrite(&radiotap_hdr, sizeof(radiotap_hdr), 1, ctx->pcap_file);
+	fwrite(frame->data, frame->data_len, 1, ctx->pcap_file);
+	fwrite(pad, align, 1, ctx->pcap_file);
+	fwrite(&blockhdr.blocklen, sizeof(blockhdr.blocklen), 1, ctx->pcap_file);
+	fflush(ctx->pcap_file);
+}
+
 static void queue_frame(struct wmediumd *ctx, struct station *station,
 			struct frame *frame)
 {
@@ -438,6 +481,29 @@ static void queue_frame(struct wmediumd *ctx, struct station *station,
 		}
 	}
 
+	if (ctx->pcap_file) {
+		log2pcap(ctx, frame, target);
+
+		if (is_acked && !noack) {
+			struct {
+				struct frame frame;
+				uint16_t fc;
+				uint16_t dur;
+				uint8_t ra[6];
+			} __attribute__((packed, aligned(8))) ack = {
+				.fc = htole16(0xd4),
+				.dur = htole16(ack_time_usec),
+			};
+
+			memcpy(&ack.frame, frame, sizeof(ack.frame));
+			ack.frame.data_len = 10;
+			memcpy(ack.ra, frame->data + 10, 6);
+
+			log2pcap(ctx, &ack.frame,
+				 target + send_time - ack_time_usec);
+		}
+	}
+
 	target += send_time;
 
 	frame->duration = send_time;
@@ -1141,10 +1207,58 @@ static void print_help(int exval)
 	printf("  -u socket       expose vhost-user socket, don't use netlink\n");
 	printf("  -a socket       expose wmediumd API socket\n");
 	printf("  -n              force netlink use even with vhost-user\n");
+	printf("  -p FILE         log packets to pcapng file FILE\n");
 
 	exit(exval);
 }
 
+static void init_pcapng(struct wmediumd *ctx, const char *filename)
+{
+	struct {
+		uint32_t type, blocklen, byte_order;
+		uint16_t ver_maj, ver_min;
+		uint64_t seclen;
+		uint32_t blocklen2;
+	} __attribute__((packed)) blockhdr = {
+		.type = 0x0A0D0D0A,
+		.blocklen = sizeof(blockhdr),
+		.byte_order = 0x1A2B3C4D,
+		.ver_maj = 1,
+		.ver_min = 0,
+		.seclen = -1,
+		.blocklen2 = sizeof(blockhdr),
+	};
+	struct {
+		uint32_t type, blocklen;
+		uint16_t linktype, reserved;
+		uint32_t snaplen;
+		struct {
+			uint16_t code, len;
+			uint8_t val, pad[3];
+		} opt_if_tsresol;
+		struct {
+			uint16_t code, len;
+		} opt_endofopt;
+		uint32_t blocklen2;
+	} __attribute__((packed)) idb = {
+		.type = 1,
+		.blocklen = sizeof(idb),
+		.linktype = 127, // radiotap
+		.snaplen = -1,
+		.opt_if_tsresol.code = 9,
+		.opt_if_tsresol.len = 1,
+		.opt_if_tsresol.val = 6, // usec
+		.blocklen2 = sizeof(idb),
+	};
+
+	if (!filename)
+		return;
+
+	ctx->pcap_file = fopen(filename, "w+");
+	fwrite(&blockhdr, sizeof(blockhdr), 1, ctx->pcap_file);
+	fwrite(&idb, sizeof(idb), 1, ctx->pcap_file);
+}
+
 int main(int argc, char *argv[])
 {
 	int opt;
@@ -1174,7 +1288,7 @@ int main(int argc, char *argv[])
 	unsigned long int parse_log_lvl;
 	char* parse_end_token;
 
-	while ((opt = getopt(argc, argv, "hVc:l:x:t:u:a:n")) != -1) {
+	while ((opt = getopt(argc, argv, "hVc:l:x:t:u:a:np:")) != -1) {
 		switch (opt) {
 		case 'h':
 			print_help(EXIT_SUCCESS);
@@ -1218,6 +1332,9 @@ int main(int argc, char *argv[])
 		case 'n':
 			force_netlink = true;
 			break;
+		case 'p':
+			init_pcapng(&ctx, optarg);
+			break;
 		case '?':
 			printf("wmediumd: Error - No such option: "
 			       "`%c'\n\n", optopt);
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index 6319bb70c8f6..8619e28cbe9a 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -227,6 +227,8 @@ struct wmediumd {
 	u8 log_lvl;
 
 	u32 need_start_notify;
+
+	FILE *pcap_file;
 };
 
 struct hwsim_tx_rate {
-- 
2.26.2

