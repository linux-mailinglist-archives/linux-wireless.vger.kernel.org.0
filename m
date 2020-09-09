Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A562633B4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgIIRJG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbgIIPgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0BC0612F9
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so3409832wrn.13
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkVQqcl8Y72suOLVUyDLPMVLmKcAEdEBQttsVtZoFdc=;
        b=gn6su5lYht2SYy5qbVTDc4jr27USvSHy28HZjSXLv/oDPCOfMRfbMD0o7hCFPzrhsO
         R++1ZQNXvrcfjnPgKdLNBDbrzwK4RtQi78aI2Xo51+dE45MtIG/HQmSs83aq1le/uAto
         mqZgGA445sISsYdaG479J2XJIbnYyIcMIBjS22OBtASVNcigXLhDF6mw+R60v/VjAf3Q
         GUsaRmgKPU44wiK5Cv1/1hDkKWqYjOtyThnPFiZVTZLiRP+UUFp5/C+iHyWSzVDWExox
         l5CZPlHy6OfLYQS/UvP0CXU/pRp87Un7wnldhcuDs3T8kWrhjEznXpG5QpbEbMmpJ7CI
         enKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkVQqcl8Y72suOLVUyDLPMVLmKcAEdEBQttsVtZoFdc=;
        b=gd1HqpVME895QGHiGoh5S4KPA9zE8ayk0eoYcPpEotwtwWT2Nlcqt2peRjKRJ6jgFC
         mlM0YwBpJPhuEf+TlT/9emxvUT71HOCtt+QApSgaMOsc/2oulgZbTeQ3tc9Yn+wfxelv
         MM9pQNCnVz0MVxEsBFPdBK6fhswDcfcxmWvkDI9nO8maw0jqP6GljJjmwW96R3tjIoGT
         5McYrmuFEZJ4Ttg0Agj8jqdQ8Vj6fDV0NTQzvO8ZcNYNidvclKu0XuV53nyFsKbmWRbl
         ODhMzxy+6RlpgVEK36cLVnmt1ifzQzCCsW8vFbo/+rmPbv4IO+KuDuHUfhWAvQAKiArT
         w3ow==
X-Gm-Message-State: AOAM531TzoUrdRO26b6KbOT5ncN+ycOODLIieyexWopCLVivOOUFyvmK
        sa/1areUG30fjYnZhQmvbjQfQQ==
X-Google-Smtp-Source: ABdhPJzsy3kaOio6wjZFPiVINfDBnrMMD+GB7vYLVY8KiXYVFsojEqgPsKt5tJG/glBSeojqQppyTg==
X-Received: by 2002:adf:c3cc:: with SMTP id d12mr4482893wrg.399.1599665744654;
        Wed, 09 Sep 2020 08:35:44 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm4924871wrx.63.2020.09.09.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 5/7] wcn36xx: Add wcn36xx_smd_config_bss_v0
Date:   Wed,  9 Sep 2020 16:36:26 +0100
Message-Id: <20200909153628.2904888-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
References: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_config_bss_v0() as a step along the road of
functionally decomposing wcn36xx_smd_config_bss().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 7e3302ba97fa..e603e2d3be16 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1584,6 +1584,47 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
+int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta, const u8 *bssid,
+			      bool update)
+{
+	struct wcn36xx_hal_config_bss_req_msg *msg;
+	struct wcn36xx_hal_config_bss_params *bss;
+	struct wcn36xx_hal_config_sta_params *sta_params;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	INIT_HAL_MSG((*msg), WCN36XX_HAL_CONFIG_BSS_REQ);
+
+	bss = &msg->bss_params;
+	sta_params = &bss->sta;
+
+	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
+		    bss->bssid, bss->self_mac_addr, bss->bss_type,
+		    bss->oper_mode, bss->nw_type);
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "- sta bssid %pM action %d sta_index %d bssid_index %d aid %d type %d mac %pM\n",
+		    sta_params->bssid, sta_params->action,
+		    sta_params->sta_index, sta_params->bssid_index,
+		    sta_params->aid, sta_params->type,
+		    sta_params->mac);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+	kfree(msg);
+
+	return ret;
+}
+
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
-- 
2.27.0

