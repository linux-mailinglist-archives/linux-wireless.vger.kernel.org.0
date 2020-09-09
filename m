Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3100C2633D1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgIIRKv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgIIPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28CC0612EE
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so2725701wmi.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIyFTjtZqqz1/a9JDLpNoneKVIe4xiF8cj2LgmPKQKo=;
        b=p1F1j9GBStbqTAuf9N1+OYnjS5Oeo1GPYEvtZT/s0ZGkdaAvZxEXQyHqiJd5ztC2Pm
         G5HJASnm2OzOyhKv2IikPx3E79fI0HNY5/F6GcN4fqFQPJ7Mq3Gg6kVLljpJ9SCpylGi
         cKoZ1eyKPCmuUWR0VPD+uLqqHcZ2ZbMS614LUaKGBNcRdU80dCeHxHlqukYcqVxPyv/H
         5eS27dXazUDRzlydUeQ2Vy/k5d3cgbflfbDvFQBYz67A0VVXOY8vYvl60AuNgbfje4ax
         hCg+dQyi5TRlAIUPgOSvQAocGm2AJ0eP6xgDOo2BigtjCIktuClHQ3C+t87Brh+skky6
         BC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIyFTjtZqqz1/a9JDLpNoneKVIe4xiF8cj2LgmPKQKo=;
        b=WbNOSrc8IPRU0HOFm7CiQEmokO3ggeKJNsv9ikbVRFRGRKIYbnGsbTCuUo5lXEEA1G
         9EjLOkLYkA0GiXYjNKRgGxtatuadlpCybL23LIDzaE9tmeL2rd24AxcPsPn0JByMvS2w
         4BbboZDQOoceb+qDwcpKKQtIzgHBTs5dRWHxrfD87hWO2UaCMqDywUT6Fa27He4v5Iye
         ZRFVvB7y8efTThucluO7tb38z7S91E/Day2aCeC6JoGqo1tFi1e2tcyQkcvVabqZkV6t
         2zq/iRMXTZP+ICFqvysEPEltZlpGhtNCsVqUGnJKqWZD/M+B74LkCvx+FbYeUEFxPuLa
         55zQ==
X-Gm-Message-State: AOAM530hrRxnWMAlDd7WHXI1WF4PwTJ+A49txabEjSou9G3mJVSYonjP
        yOMedUPMX5ljLVbIcGE8uoC/mw==
X-Google-Smtp-Source: ABdhPJxNiriAaCOg+apnSefnPK1mEOT1tfsjULdTzgfgzopBVsitxkGSivSiuQfyBLa1YDrjJ3HmQw==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr4147993wmb.138.1599665727018;
        Wed, 09 Sep 2020 08:35:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2sm4473335wrw.96.2020.09.09.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 7/7] wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()
Date:   Wed,  9 Sep 2020 16:36:07 +0100
Message-Id: <20200909153607.2904822-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
References: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds a wrapper function wcn36xx_smd_set_sta_params_v1() which
calls into wcn36xx_smd_set_sta_params() and then subsequently sets
version-1 specific parameters.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index fa6f5943a43d..f434c355d32d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1249,6 +1249,31 @@ static void wcn36xx_smd_convert_sta_to_v1(struct wcn36xx *wcn,
 	v1->p2p = orig->p2p;
 }
 
+void
+wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct wcn36xx_hal_config_sta_params_v1 *sta_par)
+{
+	struct wcn36xx_sta *sta_priv = NULL;
+	struct wcn36xx_hal_config_sta_params sta_par_v0;
+
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, &sta_par_v0);
+	wcn36xx_smd_convert_sta_to_v1(wcn, &sta_par_v0, sta_par);
+
+	if (sta) {
+		sta_priv = wcn36xx_sta_to_priv(sta);
+		wcn36xx_smd_set_sta_vht_params(wcn, sta, sta_par);
+		wcn36xx_smd_set_sta_ht_ldpc_params(sta, sta_par);
+		memcpy(&sta_par->supported_rates, &sta_priv->supported_rates,
+		       sizeof(sta_par->supported_rates));
+	} else {
+		wcn36xx_set_default_rates_v1(&sta_par->supported_rates);
+		wcn36xx_smd_set_sta_default_vht_params(wcn, sta_par);
+		wcn36xx_smd_set_sta_default_ht_ldpc_params(wcn, sta_par);
+	}
+}
+
 static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_sta *sta,
 				      void *buf,
-- 
2.27.0

