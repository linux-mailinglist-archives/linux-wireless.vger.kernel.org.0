Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53727CC923
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjJQQxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjJQQxU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 12:53:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A393F2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 09:53:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7757f2d3956so584209185a.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697561594; x=1698166394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdC6f/0RISrkZHEAKH+5CZTGnVyKGsE2Z88IX3z9ySc=;
        b=hBOMl7ShnGQU2LkbTHwNgB1EGJhN2E/w3pzqQS25pyp0wXfkSN7/HVD7vCa+nSu4lF
         7ij0Bk9yvY5WlC8LVUJvlFDgrAvG0qC+lK4XRO22TUq1OlUl/PvOuTUOFBv0Ax+m/Vaf
         DzSxRFD0a2uNEqVVP+sbRgD48Q3cWvwpo+azgJxb/gvRotgfNePIz81ePzQSH2skT09Q
         dDhywu4MgJJd4ggwcHzi277fu8wdfn7NxjJLWOQtftbnH13N6Z9WTKj9TUSNdJPwYNSM
         LqIBcqG59CykmlpYufBLcyjIXhWoShQGZakfPJgb6J0cgHCAlZFYyyJnajxyZD00KBf1
         vNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561594; x=1698166394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdC6f/0RISrkZHEAKH+5CZTGnVyKGsE2Z88IX3z9ySc=;
        b=jnI93I9SpY1L9/vUhAQOBkYMe/OmzTh1K7WGKpx+e1De3g5ZRn9GBtnOUOWfgjfLen
         r80SsYQ+XrzmOV0scRCe7h3X8GLLcXGchNGjD0dOUJeJhQXogWuH38xfwb/6rQQj5/gA
         /OA/0HzbNe5NlD1v19xT1LBil5Gxxje6sbPHnd9XXwsP0SVwGAQs+tiSEG3+Z9lCs/hB
         jRNipVIoEUHuyju6VxcLpRPvh1la99XACitvFFM461sLzZsJiBm6+HumIiK/sv5S5h6r
         HYCqFdwlvJqRdrRgq9l89X3L5nz97OCyif7+bhLX0E3qY97U8BfJ0B71QsfI15pboyxX
         XwLg==
X-Gm-Message-State: AOJu0YyIpXI87gwHplHNBxhONbhqScGznuW++F2JkXVdpRrvwynz9NhT
        fh5HpKfyEro3l4JTf5RetpjOpNeQgRE=
X-Google-Smtp-Source: AGHT+IFpSkuGkkRNb8fMp15E99wkn4DsFqtaa7QkuPmkRjA5sOegzcPD17BuSm2QjBrl1zeDGwLWYw==
X-Received: by 2002:a0c:dd11:0:b0:65b:1744:55d4 with SMTP id u17-20020a0cdd11000000b0065b174455d4mr2985914qvk.3.1697561594559;
        Tue, 17 Oct 2023 09:53:14 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r13-20020a0ccc0d000000b0064906cfe430sm690058qvk.135.2023.10.17.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:53:14 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] wifi: ath10k: add support to allow broadcast action from RX
Date:   Tue, 17 Oct 2023 09:53:06 -0700
Message-Id: <20231017165306.118779-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Advertise support for multicast frame registration and update the RX
filter with FIF_MCAST_ACTION to allow broadcast action frames to be
received. Broadcast action frames are needed for the Device
Provisioning Protocol (DPP) for Presence and PKEX Exchange requests.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 03e7bc5b6c0b..932ace5b900b 100644
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
 
@@ -6020,6 +6020,7 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 	FIF_OTHER_BSS |				\
 	FIF_BCN_PRBRESP_PROMISC |		\
 	FIF_PROBE_REQ |				\
+	FIF_MCAST_ACTION |			\
 	FIF_FCSFAIL)
 
 static void ath10k_configure_filter(struct ieee80211_hw *hw,
@@ -10121,6 +10122,8 @@ int ath10k_mac_register(struct ath10k *ar)
 	wiphy_ext_feature_set(ar->hw->wiphy,
 			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
+	wiphy_ext_feature_set(ar->hw->wiphy,
+			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 
 	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map) ||
 	    test_bit(WMI_SERVICE_HTT_MGMT_TX_COMP_VALID_FLAGS, ar->wmi.svc_map))
-- 
2.25.1

