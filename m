Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08E261A51
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbgIHSep (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbgIHScq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FBC0617BA
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so274437wme.5
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaKj9UYwL9cF8yxrv9sO92SpT2Gzz1dlnqtTFbOc6oo=;
        b=Ac8uAcsVs78nGTpERZdQVEDRlMPFk9nHjRFW8vO3Q8BY19VU8uIVYp1C4MmQLbl5r6
         AfTE6qHyGR/yUSNBlYF3m5fpFYXNYSXbLf7dOOlPhUZQZXMzeTvW2j0hb9cnrGXdVnCh
         zVh3aK+L2yQlmZgyPeH10xOnHudgyMm7Kw5VBHYcLLIln6IRECY3iE0tw4MgxbKOx+26
         ovkg6SbIqzPaKUwYW+atKVSBp6JQB9PxmFJuEmXoWIT9010T+a6twRQgj7ZIRmf0pLqf
         65cq2eszl5i23tPZ03vS05vtjqWxUuoQ4MahTcGbNwxhG1yh7yDp4Qd40ShplOdHDkJs
         cQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaKj9UYwL9cF8yxrv9sO92SpT2Gzz1dlnqtTFbOc6oo=;
        b=Nst0OU3Fjt6tOa3E5uLnsEiTXfq+W4XtOfwDnmPt5TAYI8moXpUCt39+KeeFaJCYtI
         yRc4va58C+MWZzAHWfFwKW05BAjPH4i1aJk6KJBBOq6pC5wGUIUN9vf+SpodoscqI+lM
         Hs04Au22ik5brnWBIy9YpbJnWquPwNevArKR4lQwM4j2Q2O7oWLgdl3LtzO9tQqdyH1R
         Z/SqS67fPdfLZD3uWnAzy0zpJBdar1Fa/HHcDhEOnLJoPBa+SSDvLTgrQkK36ad+z6jM
         bCg9gPUhGQB6UCgayyE9+1f7rBN2yfFFW632b9pab/KvtvtzEY7bzw4yRn+cttz32WWV
         rtcQ==
X-Gm-Message-State: AOAM530AuaE0PLx5TsGa5jZYNl1aMBZw538M0DCTOGI5DRg2dhxFwed/
        NCbKrhBXJ6KWE+ORkZjbFYX+Cw==
X-Google-Smtp-Source: ABdhPJwlXJWV7nT0SRO18bDFGzIOQViaMDmTqbjdXHgk9AN6V0e8qIlRfPg44snTMzvu31CJU26oYA==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr347813wml.159.1599589469352;
        Tue, 08 Sep 2020 11:24:29 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm352447wrv.72.2020.09.08.11.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/5] wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
Date:   Tue,  8 Sep 2020 19:25:11 +0100
Message-Id: <20200908182514.2870410-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
References: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uses HW_VALUE_CHANNEL() to extract the channel number from a
struct ieee80211_channel->hw_value. Once done we can use the upper bits of
the hw_value to encode PHY related data.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 2bb1803ed06a..1496566ecb31 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -758,8 +758,10 @@ int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	msg_body->num_channel = min_t(u8, req->n_channels,
 				     sizeof(msg_body->channels));
-	for (i = 0; i < msg_body->num_channel; i++)
-		msg_body->channels[i] = req->channels[i]->hw_value;
+	for (i = 0; i < msg_body->num_channel; i++) {
+		msg_body->channels[i] =
+			HW_VALUE_CHANNEL(req->channels[i]->hw_value);
+	}
 
 	msg_body->header.len -= WCN36XX_MAX_SCAN_IE_LEN;
 
-- 
2.27.0

