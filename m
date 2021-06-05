Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753C239C4C6
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFEBNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:13:04 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33677 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhFEBND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:13:03 -0400
Received: by mail-wm1-f53.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so1757854wme.0
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLMm42vbhhJfEr1YusZj6a9pUhQGgeXnCkgivBEicng=;
        b=rQLK9H+MJ59HObzhdh/xwfHDLupQCkerOaBa/97GTHRZ4U16+mlKcTtr7pswOVoUTP
         HP+f7PFaxK0Y3aOFT8d3QdNX4nIm9JUM67stAmns7eMymnZ4/eLE8y9L8T2JBkttDpJ5
         ULZ6APjys2oDppHTN6/QyGelT1997u4RHm04lo2+xQjF06DYIHTvnGQ3jEtpieKPlSNQ
         RAK30jI+fyyOMXLPy5nt7Q3bmTMmNSdpl1ndsMB1IbSdImJUjt7JgMxDXKj/57WtBSX+
         sb+XH44V1lW8KOhF6u8HuLLq334vmv8dq8iVUrLeKU/AvGQVxFih1Um7VRNkUFcioFW8
         FGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLMm42vbhhJfEr1YusZj6a9pUhQGgeXnCkgivBEicng=;
        b=h2FBeIX6/4P2laJWtFSRKNJJqiWYUGRNUzTTB+m3e/X/xzVvLfaoxKHaMu7DxO+4NL
         LdQM3P/CZHxJHsVVcFk5iF/pT3sBjp2wt0SJJzyOPKwd5UQp9110+XwSoB/fAgSn31QT
         tBmLs1sdfc4FSAd8/F8Rz4Bv+ittePxzRas7oVqepFn06rbQYBOAtz3h9UQBEU3bpjJS
         4kC9iJ2Upjj0Cl1pEa9xgW8bh2a3v8CzVTbUp53ktQob40IjYgaiLRh+aKN+3oAG0HCD
         RbQM1hcaz9GrBoeCPOWZf5gnQ0WN7nxuLEF1p+sTB0IC7BgaDDMi8Khf4tcLDU/Qk1cO
         qyCA==
X-Gm-Message-State: AOAM533ddb/3oUjCQm/+gFVCq1tnX/rDgm+lLqJtA5nQx16RdUofLwID
        lZpz7jhSWPlMbwO49XZ5eYVG6g==
X-Google-Smtp-Source: ABdhPJy1oSyb2DFpBzaeU4Q/O3EDX3kJdJsVKCLEGEitpiv2BoUqmJ+/AuEF1plQQ/l6c7Vp4R35Pw==
X-Received: by 2002:a1c:d5:: with SMTP id 204mr5896682wma.144.1622855404466;
        Fri, 04 Jun 2021 18:10:04 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 08/12] wcn36xx: Add GTK offload to WoWLAN path
Date:   Sat,  5 Jun 2021 02:11:36 +0100
Message-Id: <20210605011140.2004643-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using previously set GTK KCK and KEK material this commit adds GTK rekeying
to the WoWLAN suspend/resume path. A small error in the packing of the
up to now unused command structure is fixed as we go.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c |  4 +++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 39 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 3b949b0b3792..1f3c2e840232 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -4905,7 +4905,7 @@ struct wcn36xx_hal_gtk_offload_req_msg {
 	u64 key_replay_counter;
 
 	u8 bss_index;
-};
+} __packed;
 
 struct wcn36xx_hal_gtk_offload_rsp_msg {
 	struct wcn36xx_hal_msg_header header;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index ec32b8b0067d..db1528a14757 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1119,6 +1119,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_ipv6_ns_offload(wcn, vif, true);
+		if (ret)
+			goto out;
+		ret = wcn36xx_smd_gtk_offload(wcn, vif, true);
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
@@ -1139,6 +1142,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_gtk_offload(wcn, vif, false);
 		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
 	}
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 4a50e5f8456a..4063888e3f03 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2856,6 +2856,44 @@ int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 }
 #endif
 
+int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			    bool enable)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct wcn36xx_hal_gtk_offload_req_msg msg_body;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_GTK_OFFLOAD_REQ);
+
+	if (enable) {
+		memcpy(&msg_body.kek, vif_priv->rekey_data.kek, NL80211_KEK_LEN);
+		memcpy(&msg_body.kck, vif_priv->rekey_data.kck, NL80211_KCK_LEN);
+		msg_body.key_replay_counter =
+			le64_to_cpu(vif_priv->rekey_data.replay_ctr);
+		msg_body.bss_index = vif_priv->bss_index;
+	} else {
+		msg_body.flags = WCN36XX_HAL_GTK_OFFLOAD_FLAGS_DISABLE;
+	}
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
+	if (ret) {
+		wcn36xx_err("Sending host_offload_arp failed\n");
+		goto out;
+	}
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("host_offload_arp failed err=%d\n", ret);
+		goto out;
+	}
+out:
+	mutex_unlock(&wcn->hal_mutex);
+	return ret;
+}
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
@@ -2905,6 +2943,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_START_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
+	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index e03ab7878432..cdf4231efe26 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -153,4 +153,7 @@ int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 				bool enable);
 
+int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			    bool enable);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

