Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1C786912
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjHXHz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 03:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbjHXHz1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 03:55:27 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5F1709
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 00:55:25 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e2b:0:640:94b5:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id B236360021;
        Thu, 24 Aug 2023 10:54:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nsFdET9WwmI0-vGuxbnum;
        Thu, 24 Aug 2023 10:54:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692863693;
        bh=t8sVbi/v2uwfYixKvm61hfDLATHIxHUnHyobe5AgHLw=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=K1LAwCOjdjvrzVCuEoLpzlWiN0bVe/9cyzWGSfeCC99J0pOeoMdjWXAa1bMoqvrPc
         8mqPTroRt4HyekdyXGDwMoqqvr1tvId3aGe8anQioOOMt5S1DFa31jO3QbnvnUzkAc
         ZAzUvlxHxnj3Ha0VS5ltQEjkYQId4XenM5TC2jkw=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath11k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 5/5] wifi: ath11k: fix stack usage of ath11k_mac_op_remain_on_channel()
Date:   Thu, 24 Aug 2023 10:50:48 +0300
Message-ID: <20230824075121.121144-5-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824075121.121144-1-dmantipov@yandex.ru>
References: <20230824075121.121144-1-dmantipov@yandex.ru>
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

drivers/net/wireless/ath/ath11k/mac.c:8900:12: warning: stack frame
size (1032) exceeds limit (1024) in 'ath11k_mac_op_remain_on_channel'
[-Wframe-larger-than]
static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
           ^
68/1032 (6.59%) spills, 964/1032 (93.41%) variables

So switch to kzalloc()'ed instance of 'struct scan_req_params' and
adjust the function in subject accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/mac.c | 44 +++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2aadf2c387b6..3e2983d30a5a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8905,7 +8905,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
-	struct scan_req_params arg;
+	struct scan_req_params *arg;
 	int ret;
 	u32 scan_time_msec;
 
@@ -8937,27 +8937,31 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
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
 
@@ -8983,7 +8987,9 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
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

