Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA77D7AE48E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 06:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjIZEaA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 00:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZE37 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 00:29:59 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B797
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 21:29:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bbac:0:640:58d8:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 131ED6004E;
        Tue, 26 Sep 2023 07:29:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jTGLcsCDSSw0-4UaAEcp1;
        Tue, 26 Sep 2023 07:29:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695702586; bh=b85toJbHwBNF/iEdHe74mERthDtnUyFA/5mRTA01URM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=iCNlqgJ40wcxruebqEcgqtrEm6LhmI0UUMlI3t02omH7OtoAzkLew46AWi97FwaRA
         VDktelNr2alggsl0LZyYJnHk3XJ4d82Aplxmgd+hYLLdiiXNgPjlUC9UYWvvL/QKfT
         BU5a0rIDc57TK0Zfg8W9tPinvdlt0JO0JX+lYkoU=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: ath11k: fix ath11k_mac_op_remain_on_channel() stack usage
Date:   Tue, 26 Sep 2023 07:29:04 +0300
Message-ID: <20230926042906.13725-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <30dfbf07-9ec9-4ac9-8199-9f08dbe03739@quicinc.com>
References: <30dfbf07-9ec9-4ac9-8199-9f08dbe03739@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When compiling with clang 16.0.6, I've noticed the following:

drivers/net/wireless/ath/ath11k/mac.c:8903:12: warning: stack frame
size (1032) exceeds limit (1024) in 'ath11k_mac_op_remain_on_channel'
[-Wframe-larger-than]
static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
           ^
68/1032 (6.59%) spills, 964/1032 (93.41%) variables

So switch to kzalloc()'ed instance of 'struct scan_req_params' like
it's done in 'ath11k_mac_op_hw_scan()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust ath11k_mac_op_remain_on_channel() exit path (Jeff Johnson)
---
 drivers/net/wireless/ath/ath11k/mac.c | 44 +++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6ed036b51dba..e3fc87a7c09e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8908,7 +8908,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct scan_req_params arg;
+	struct scan_req_params *arg;
 	int ret;
 	u32 scan_time_msec;
 
@@ -8940,27 +8940,31 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
 	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;
 
-	memset(&arg, 0, sizeof(arg));
-	ath11k_wmi_start_scan_init(ar, &arg);
-	arg.num_chan = 1;
-	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
-				GFP_KERNEL);
-	if (!arg.chan_list) {
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}
+	ath11k_wmi_start_scan_init(ar, arg);
+	arg->num_chan = 1;
+	arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
+				 GFP_KERNEL);
+	if (!arg->chan_list) {
+		ret = -ENOMEM;
+		goto free_arg;
+	}
 
-	arg.vdev_id = arvif->vdev_id;
-	arg.scan_id = ATH11K_SCAN_ID;
-	arg.chan_list[0] = chan->center_freq;
-	arg.dwell_time_active = scan_time_msec;
-	arg.dwell_time_passive = scan_time_msec;
-	arg.max_scan_time = scan_time_msec;
-	arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
-	arg.scan_flags |= WMI_SCAN_FILTER_PROBE_REQ;
-	arg.burst_duration = duration;
-
-	ret = ath11k_start_scan(ar, &arg);
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH11K_SCAN_ID;
+	arg->chan_list[0] = chan->center_freq;
+	arg->dwell_time_active = scan_time_msec;
+	arg->dwell_time_passive = scan_time_msec;
+	arg->max_scan_time = scan_time_msec;
+	arg->scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+	arg->scan_flags |= WMI_SCAN_FILTER_PROBE_REQ;
+	arg->burst_duration = duration;
+
+	ret = ath11k_start_scan(ar, arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
 
@@ -8986,7 +8990,9 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	ret = 0;
 
 free_chan_list:
-	kfree(arg.chan_list);
+	kfree(arg->chan_list);
+free_arg:
+	kfree(arg);
 exit:
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
-- 
2.41.0

