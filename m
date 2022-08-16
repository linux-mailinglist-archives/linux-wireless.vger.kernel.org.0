Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407B4595E87
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiHPOqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiHPOqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 10:46:33 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED71647D3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 07:46:26 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27GEkGCt018475;
        Tue, 16 Aug 2022 23:46:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Tue, 16 Aug 2022 23:46:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27GEkFcS018451
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Aug 2022 23:46:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7acfa1be-4b5c-b2ce-de43-95b0593fb3e5@I-love.SAKURA.ne.jp>
Date:   Tue, 16 Aug 2022 23:46:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: [PATCH v2] ath9k: avoid uninit memory read in ath9k_htc_rx_msg()
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <000000000000c98a7f05ac744f53@google.com>
 <cd4287be-5434-039e-59ba-2a9cb2ab5185@I-love.SAKURA.ne.jp>
 <e0bcd6d4-4029-4ab3-0405-054d26262f64@I-love.SAKURA.ne.jp>
 <87edxgwarp.fsf@toke.dk>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87edxgwarp.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot is reporting uninit value at ath9k_htc_rx_msg() [1], for
ioctl(USB_RAW_IOCTL_EP_WRITE) can call ath9k_hif_usb_rx_stream() with
pkt_len = 0 but ath9k_hif_usb_rx_stream() uses
__dev_alloc_skb(pkt_len + 32, GFP_ATOMIC) based on an assumption that
pkt_len is valid. As a result, ath9k_hif_usb_rx_stream() allocates skb
with uninitialized memory and ath9k_htc_rx_msg() is reading from
uninitialized memory.

Since bytes accessed by ath9k_htc_rx_msg() is not known until
ath9k_htc_rx_msg() is called, it would be difficult to check minimal valid
pkt_len at "if (pkt_len > 2 * MAX_RX_BUF_SIZE) {" line in
ath9k_hif_usb_rx_stream().

We have two choices. One is to workaround by adding __GFP_ZERO so that
ath9k_htc_rx_msg() sees 0 if pkt_len is invalid. The other is to let
ath9k_htc_rx_msg() validate pkt_len before accessing. This patch chose
the latter.

Note that I'm not sure threshold condition is correct, for I can't find
details on possible packet length used by this protocol.

Link: https://syzkaller.appspot.com/bug?extid=2ca247c2d60c7023de7f [1]
Reported-by: syzbot <syzbot+2ca247c2d60c7023de7f@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Update patch description.

 drivers/net/wireless/ath/ath9k/htc_hst.c | 43 +++++++++++++++---------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 994ec48b2f66..ca05b07a45e6 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -364,33 +364,27 @@ void ath9k_htc_txcompletion_cb(struct htc_target *htc_handle,
 }
 
 static void ath9k_htc_fw_panic_report(struct htc_target *htc_handle,
-				      struct sk_buff *skb)
+				      struct sk_buff *skb, u32 len)
 {
 	uint32_t *pattern = (uint32_t *)skb->data;
 
-	switch (*pattern) {
-	case 0x33221199:
-		{
+	if (*pattern == 0x33221199 && len >= sizeof(struct htc_panic_bad_vaddr)) {
 		struct htc_panic_bad_vaddr *htc_panic;
 		htc_panic = (struct htc_panic_bad_vaddr *) skb->data;
 		dev_err(htc_handle->dev, "ath: firmware panic! "
 			"exccause: 0x%08x; pc: 0x%08x; badvaddr: 0x%08x.\n",
 			htc_panic->exccause, htc_panic->pc,
 			htc_panic->badvaddr);
-		break;
-		}
-	case 0x33221299:
-		{
+		return;
+	}
+	if (*pattern == 0x33221299) {
 		struct htc_panic_bad_epid *htc_panic;
 		htc_panic = (struct htc_panic_bad_epid *) skb->data;
 		dev_err(htc_handle->dev, "ath: firmware panic! "
 			"bad epid: 0x%08x\n", htc_panic->epid);
-		break;
-		}
-	default:
-		dev_err(htc_handle->dev, "ath: unknown panic pattern!\n");
-		break;
+		return;
 	}
+	dev_err(htc_handle->dev, "ath: unknown panic pattern!\n");
 }
 
 /*
@@ -411,16 +405,26 @@ void ath9k_htc_rx_msg(struct htc_target *htc_handle,
 	if (!htc_handle || !skb)
 		return;
 
+	/* A valid message requires len >= 8.
+	 *
+	 *   sizeof(struct htc_frame_hdr) == 8
+	 *   sizeof(struct htc_ready_msg) == 8
+	 *   sizeof(struct htc_panic_bad_vaddr) == 16
+	 *   sizeof(struct htc_panic_bad_epid) == 8
+	 */
+	if (unlikely(len < sizeof(struct htc_frame_hdr)))
+		goto invalid;
 	htc_hdr = (struct htc_frame_hdr *) skb->data;
 	epid = htc_hdr->endpoint_id;
 
 	if (epid == 0x99) {
-		ath9k_htc_fw_panic_report(htc_handle, skb);
+		ath9k_htc_fw_panic_report(htc_handle, skb, len);
 		kfree_skb(skb);
 		return;
 	}
 
 	if (epid < 0 || epid >= ENDPOINT_MAX) {
+invalid:
 		if (pipe_id != USB_REG_IN_PIPE)
 			dev_kfree_skb_any(skb);
 		else
@@ -432,21 +436,30 @@ void ath9k_htc_rx_msg(struct htc_target *htc_handle,
 
 		/* Handle trailer */
 		if (htc_hdr->flags & HTC_FLAGS_RECV_TRAILER) {
-			if (be32_to_cpu(*(__be32 *) skb->data) == 0x00C60000)
+			if (be32_to_cpu(*(__be32 *) skb->data) == 0x00C60000) {
 				/* Move past the Watchdog pattern */
 				htc_hdr = (struct htc_frame_hdr *)(skb->data + 4);
+				len -= 4;
+			}
 		}
 
 		/* Get the message ID */
+		if (unlikely(len < sizeof(struct htc_frame_hdr) + sizeof(__be16)))
+			goto invalid;
 		msg_id = (__be16 *) ((void *) htc_hdr +
 				     sizeof(struct htc_frame_hdr));
 
 		/* Now process HTC messages */
 		switch (be16_to_cpu(*msg_id)) {
 		case HTC_MSG_READY_ID:
+			if (unlikely(len < sizeof(struct htc_ready_msg)))
+				goto invalid;
 			htc_process_target_rdy(htc_handle, htc_hdr);
 			break;
 		case HTC_MSG_CONNECT_SERVICE_RESPONSE_ID:
+			if (unlikely(len < sizeof(struct htc_frame_hdr) +
+				     sizeof(struct htc_conn_svc_rspmsg)))
+				goto invalid;
 			htc_process_conn_rsp(htc_handle, htc_hdr);
 			break;
 		default:
-- 
2.18.4


