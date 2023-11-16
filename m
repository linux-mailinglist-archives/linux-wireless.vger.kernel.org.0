Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6547EE5FA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 18:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjKPRc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 12:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKPRcz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 12:32:55 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39CC181
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 09:32:51 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1f055438492so553374fac.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700155971; x=1700760771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhrTZXBGF+X2MMIUf+fkrZJsJ9KiVh9phIYWrQEPVwU=;
        b=WXve5avXV3+xxK+cw5NfXwxrgLpZPxxhBc6Vs1lYg/m3JzlCfd8bCD4JXYXZYXfq0I
         P98vxHjGRNEuIFjpMuUfPs/PsVwJ218HHX0AFE2H6a49l53pZOFS3moK3Ocy2RUKhXWw
         O20I3a7kNHFzr+uRr8skPYPjvyxHgVBGxnUSR04CAnR+9IZf/mjLT9DntFXjEvKlGFHv
         Qr9/6C8OmfebzenR+mbN5oUdPcBRg8DUpE4K9v4yZMP+JpHr0g2kxotnnwjyPzT6sjSp
         2DXtDssHuVzRBdHfGkF4xfKvgTALyB5h+qWUC5yAjwRg7kMeH3jPy6lNpdj6Mq2Ze2j5
         kPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700155971; x=1700760771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhrTZXBGF+X2MMIUf+fkrZJsJ9KiVh9phIYWrQEPVwU=;
        b=C1n0CkzBpStnEj/l/WF9noQq7909/Qhx/TUWjkmr/fljxfqu0xAJXzHzx0opoENze3
         VmWmlFR0Z5HTMxvFQdudrw5kQqEMoVeMT9HHX4kwtRFeF2P8RtIgHTf9al1J9c2zwX+t
         QVZr6vMAMkjl37uqKJbfGVZuAG4tSGZXidVeM5Ax7c9PMmbGhEvI52UhKugUH9qoKGol
         EE3lvwImsaHRODWdM5mokElnGTdYdAu5/bWjbZIszoga4XfOJ9vE8aWJmHkA9tS6D30o
         o4u+s1MCuaJ8n5Xy6ihHiL9xzWVCtioKmLWB4gSfobp1ddqtH+JUbZlEHA8Q1sGapJra
         oyOA==
X-Gm-Message-State: AOJu0YxIDNK3jKtYv47SFohwjwT4ZGyROl3LqssHYYSjTo9un+Aeb5eL
        QigCn4xRJYgihK2LumuspjdKFxCd8U0=
X-Google-Smtp-Source: AGHT+IHKqhImXg/utDqMeQRq3OooGXVlqgCgVu24XbM6r1rVggdOizUwfFDQKgHeLvs3ZITECSsLMw==
X-Received: by 2002:a05:6870:169b:b0:1ef:bfd8:90d1 with SMTP id j27-20020a056870169b00b001efbfd890d1mr20225279oae.22.1700155970718;
        Thu, 16 Nov 2023 09:32:50 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i15-20020ac84f4f000000b004181d77e08fsm4482887qtw.85.2023.11.16.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 09:32:50 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] wifi: ath10k: add support to allow broadcast action frame RX
Date:   Thu, 16 Nov 2023 09:32:46 -0800
Message-Id: <20231116173246.40458-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Broadcast action frames are needed for the Device Provisioning
Protocol (DPP) for Presence and PKEX Exchange requests. Currently
just ath9k has this capability so this is being enabled for
ath10k (for at least one hardware variant).

Add a new capability flag in ath10k_hw_params to indicate support
for receiving multicast action frames. This bit is then checked
when configuring the RX filter and (if set) multicast action frame
registration is enabled.

Until more hardware can be tested only the "qca6174 hw3.2" variant
is enabling this feature.

Note: I went ahead and removed the 'changed_flags' mask operation
since it had no effect, that parameter was not being used anywhere.

Tested-on: QCA6174 hw3.2 WLAN.RM.4.4.1-00288-

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.c |  1 +
 drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
 drivers/net/wireless/ath/ath10k/mac.c  | 14 +++++++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

v2:
 * Add flag in ath10k_hw_params and only set FIF_MCAST_ACTION
   if that hardware allows it.

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5eb131ab916f..f2077756ffdf 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -381,6 +381,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.mcast_frame_registration = true,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 9643031a4427..2aeb52c7f189 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -639,6 +639,9 @@ struct ath10k_hw_params {
 	bool use_fw_tx_credits;
 
 	bool delay_unmap_buffer;
+
+	/* The hardware support multicast frame registrations */
+	bool mcast_frame_registration;
 };
 
 struct htt_resp;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index ec8d5b29bc72..0d0de3646d31 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1249,7 +1249,7 @@ static bool ath10k_mac_monitor_vdev_is_needed(struct ath10k *ar)
 	return ar->monitor ||
 	       (!test_bit(ATH10K_FW_FEATURE_ALLOWS_MESH_BCAST,
 			  ar->running_fw->fw_file.fw_features) &&
-		(ar->filter_flags & FIF_OTHER_BSS)) ||
+		(ar->filter_flags & (FIF_OTHER_BSS | FIF_MCAST_ACTION))) ||
 	       test_bit(ATH10K_CAC_RUNNING, &ar->dev_flags);
 }
 
@@ -6027,11 +6027,15 @@ static void ath10k_configure_filter(struct ieee80211_hw *hw,
 {
 	struct ath10k *ar = hw->priv;
 	int ret;
+	unsigned int supported = SUPPORTED_FILTERS;
 
 	mutex_lock(&ar->conf_mutex);
 
-	changed_flags &= SUPPORTED_FILTERS;
-	*total_flags &= SUPPORTED_FILTERS;
+	if (ar->hw_params.mcast_frame_registration)
+		supported |= FIF_MCAST_ACTION;
+
+	*total_flags &= supported;
+
 	ar->filter_flags = *total_flags;
 
 	ret = ath10k_monitor_recalc(ar);
@@ -10114,6 +10118,10 @@ int ath10k_mac_register(struct ath10k *ar)
 			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
 
+	if (ar->hw_params.mcast_frame_registration)
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
+
 	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map) ||
 	    test_bit(WMI_SERVICE_HTT_MGMT_TX_COMP_VALID_FLAGS, ar->wmi.svc_map))
 		wiphy_ext_feature_set(ar->hw->wiphy,
-- 
2.34.1

