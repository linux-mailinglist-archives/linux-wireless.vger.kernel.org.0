Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5A7AD83A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIYMsp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIYMso (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 08:48:44 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85EC6
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 05:48:34 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a712:0:640:d986:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 17E116007E;
        Mon, 25 Sep 2023 15:48:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UmNdpL3WoqM0-zSSWkj5J;
        Mon, 25 Sep 2023 15:48:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695646111; bh=POl7DBe/kbY4KMY8bOL/W6S+I9oYpcnnUqBN8ZTrLXs=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=nUxDmEXXNK2EAUcFrvgauJ7KAkxhYPR9WkP1AOrQwNgr8T7/9ydJCZ8OvkJkrKInx
         CpUYBABEVpcD3ulGEetrPQzuJ9OViXU4iJ8Vuv6T2+Z/W/MMKuE8DprmbfTsaOg9LU
         Zos757IpJcUa8LmXy6WrsEIG6lhL0twez8+3Zli4=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: fix ath11k_mac_op_remain_on_channel() stack usage
Date:   Mon, 25 Sep 2023 15:46:09 +0300
Message-ID: <20230925124613.2452273-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/net/wireless/ath/ath11k/mac.c | 43 +++++++++++++++------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6ed036b51dba..c7d51f6aeede 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8908,7 +8908,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct scan_req_params arg;
+	struct scan_req_params *arg = NULL;
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
+		ret = -ENOMEM;
+		goto exit;
+	}
+	ath11k_wmi_start_scan_init(ar, arg);
+	arg->num_chan = 1;
+	arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
+				 GFP_KERNEL);
+	if (!arg->chan_list) {
 		ret = -ENOMEM;
 		goto exit;
 	}
 
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
 
@@ -8986,8 +8990,9 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	ret = 0;
 
 free_chan_list:
-	kfree(arg.chan_list);
+	kfree(arg->chan_list);
 exit:
+	kfree(arg);
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
-- 
2.41.0

