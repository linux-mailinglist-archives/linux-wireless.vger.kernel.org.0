Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C29BBC64
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 21:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502382AbfIWTte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 15:49:34 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42088 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfIWTtd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 15:49:33 -0400
Received: by mail-wr1-f43.google.com with SMTP id n14so15314567wrw.9
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkWW93VozEz14AiNPO1yGBR7cePQrOV3NZ94jN8016A=;
        b=nkJynhx+vwQ0RhTfTBsO2m56l3r8vY/SrUOX/dZeE8TiM5/QM5w0u1bkm4Vv9RcHk/
         xlVnP/V5h/5+CNqvoZZorJX1/9JOn0IHChkyAYdp6SWULMAOX86w9gZlaCz2Nr2VW21O
         ERBQwKZTDf4iwAvpj5TaRRbcLhs6EPhJ3cQzCqviZJCQHtkdgVQefY4BEg1/YqNb58BW
         cO6S6mSbS3jUqsP4GBuWJ+AcMBLoBLgyexTV5TtmV5vXkzaXDMGCpmNtYG3va0N0aSwU
         wcvjkO56Cp5HA+9jLIJEEcHJUlwMGW8N8H5jDS9RKyvfXMJbooiduXk/nwubJCRkos3X
         yrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkWW93VozEz14AiNPO1yGBR7cePQrOV3NZ94jN8016A=;
        b=EIQuPoV0gT3VaVTHD4To9Pmt3ioNMjcJJnHvrMsNwdasRAD3ppvBc76xSck4LXvIWw
         a34obSrJEc/Hq1+6wq4yvlA1QRbTv7Q5+3HaWC/zTSf0YtSQ2V0k1jQ9AXu54O6R8c/8
         xbNL3RIAyQHCPZn2IjSVLZgG+JobVTQDLKugQn6qKblZ1YB7eq2Ye7nc1MWGeTASQ4gD
         ndbwuf6OeNHfO9/sOookL1PzZf9EAtkY4sBH5sVKNuGbpw5vAKNnivYEKkcg3pRAnq9H
         jPiH0g4yswVP2q3v4xVpDHfJ87T0fC1ffLR4q1flOxu7Mx8h2295BiPbTtYG/cJupyHK
         cT9w==
X-Gm-Message-State: APjAAAVKW5iu4ViWfJOFG8b50Yeuep+6JchOFH3Pcp6Quq+70bFKW1Ki
        VFX+bAhCWH7M21O4qPsA1h7MrSXi
X-Google-Smtp-Source: APXvYqxLULFakI4c/RH3kHp+oLCsg5q8vI+kXh2wJM7CGtIFBiOne5ZxU9/T7iUVXVtSASPTFJLmHA==
X-Received: by 2002:adf:ab57:: with SMTP id r23mr786240wrc.222.1569268170984;
        Mon, 23 Sep 2019 12:49:30 -0700 (PDT)
Received: from localhost.localdomain ([31.147.208.18])
        by smtp.googlemail.com with ESMTPSA id o188sm25108013wma.14.2019.09.23.12.49.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 12:49:30 -0700 (PDT)
From:   =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, ath10k@lists.infradead.org
Subject: [PATCH 3/5] ath10k: print supported MCS rates within service ready event
Date:   Mon, 23 Sep 2019 21:49:23 +0200
Message-Id: <1569268165-1639-3-git-send-email-pozega.tomislav@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
References: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add vht_supp_mcs argument to service ready structure and print
supported MCS rates in WMI service ready debug message.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.h    |    1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |    1 +
 drivers/net/wireless/ath/ath10k/wmi.c     |    6 +++++-
 drivers/net/wireless/ath/ath10k/wmi.h     |    1 +
 4 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 2a0a008..153c4a2 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -964,6 +964,7 @@ struct ath10k {
 	u32 hw_eeprom_rd;
 	u32 ht_cap_info;
 	u32 vht_cap_info;
+	u32 vht_supp_mcs;
 	u32 num_rf_chains;
 	u32 max_spatial_stream;
 	/* protected by conf_mutex */
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index bda52ca..2432a74 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1201,6 +1201,7 @@ static int ath10k_wmi_tlv_op_pull_svc_rdy_ev(struct ath10k *ar,
 	arg->max_tx_power = ev->hw_max_tx_power;
 	arg->ht_cap = ev->ht_cap_info;
 	arg->vht_cap = ev->vht_cap_info;
+	arg->vht_supp_mcs = ev->vht_supp_mcs;
 	arg->sw_ver0 = ev->abi.abi_ver0;
 	arg->sw_ver1 = ev->abi.abi_ver1;
 	arg->fw_build = ev->fw_build_vers;
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index b7b8072..2d43adf 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5357,6 +5357,7 @@ static int ath10k_wmi_alloc_host_mem(struct ath10k *ar, u32 req_id,
 	arg->max_tx_power = ev->hw_max_tx_power;
 	arg->ht_cap = ev->ht_cap_info;
 	arg->vht_cap = ev->vht_cap_info;
+	arg->vht_supp_mcs = ev->vht_supp_mcs;
 	arg->sw_ver0 = ev->sw_version;
 	arg->sw_ver1 = ev->sw_version_1;
 	arg->phy_capab = ev->phy_capability;
@@ -5398,6 +5399,7 @@ static int ath10k_wmi_alloc_host_mem(struct ath10k *ar, u32 req_id,
 	arg->max_tx_power = ev->hw_max_tx_power;
 	arg->ht_cap = ev->ht_cap_info;
 	arg->vht_cap = ev->vht_cap_info;
+	arg->vht_supp_mcs = ev->vht_supp_mcs;
 	arg->sw_ver0 = ev->sw_version;
 	arg->phy_capab = ev->phy_capability;
 	arg->num_rf_chains = ev->num_rf_chains;
@@ -5449,6 +5451,7 @@ static void ath10k_wmi_event_service_ready_work(struct work_struct *work)
 	ar->hw_max_tx_power = __le32_to_cpu(arg.max_tx_power);
 	ar->ht_cap_info = __le32_to_cpu(arg.ht_cap);
 	ar->vht_cap_info = __le32_to_cpu(arg.vht_cap);
+	ar->vht_supp_mcs = __le32_to_cpu(arg.vht_supp_mcs);
 	ar->fw_version_major =
 		(__le32_to_cpu(arg.sw_ver0) & 0xff000000) >> 24;
 	ar->fw_version_minor = (__le32_to_cpu(arg.sw_ver0) & 0x00ffffff);
@@ -5563,11 +5566,12 @@ static void ath10k_wmi_event_service_ready_work(struct work_struct *work)
 
 skip_mem_alloc:
 	ath10k_dbg(ar, ATH10K_DBG_WMI,
-		   "wmi event service ready min_tx_power 0x%08x max_tx_power 0x%08x ht_cap 0x%08x vht_cap 0x%08x sw_ver0 0x%08x sw_ver1 0x%08x fw_build 0x%08x phy_capab 0x%08x num_rf_chains 0x%08x eeprom_rd 0x%08x low_2ghz_chan %d high_2ghz_chan %d low_5ghz_chan %d high_5ghz_chan %d num_mem_reqs 0x%08x\n",
+		   "wmi event service ready min_tx_power 0x%08x max_tx_power 0x%08x ht_cap 0x%08x vht_cap 0x%08x vht_supp_mcs 0x%08x sw_ver0 0x%08x sw_ver1 0x%08x fw_build 0x%08x phy_capab 0x%08x num_rf_chains 0x%08x eeprom_rd 0x%08x low_2ghz_chan %d high_2ghz_chan %d low_5ghz_chan %d high_5ghz_chan %d num_mem_reqs 0x%08x\n",
 		   __le32_to_cpu(arg.min_tx_power),
 		   __le32_to_cpu(arg.max_tx_power),
 		   __le32_to_cpu(arg.ht_cap),
 		   __le32_to_cpu(arg.vht_cap),
+		   __le32_to_cpu(arg.vht_supp_mcs),
 		   __le32_to_cpu(arg.sw_ver0),
 		   __le32_to_cpu(arg.sw_ver1),
 		   __le32_to_cpu(arg.fw_build),
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 9ccaeb7..d9d53e5 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6863,6 +6863,7 @@ struct wmi_svc_rdy_ev_arg {
 	__le32 max_tx_power;
 	__le32 ht_cap;
 	__le32 vht_cap;
+	__le32 vht_supp_mcs;
 	__le32 sw_ver0;
 	__le32 sw_ver1;
 	__le32 fw_build;
-- 
1.7.0.4

