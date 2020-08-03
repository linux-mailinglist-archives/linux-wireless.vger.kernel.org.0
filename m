Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF69A239DB0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHCDLG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgHCDLF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86452C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so32762332wrh.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtjPUnCQUJ2Xqmf1HBNfL/7o3eTpGJ7VqulMTNQ/Ev0=;
        b=KC6bgnUX94nR12VYj/AbBBrbijB1bxi+D66PsiUbvfpTkrjg4Hhe7I1Pg20yJQvE5g
         55oSJ8HXXp0zG/Jso1ZfJf233vNTiHX+Sl6MqGfGhHGFTl84gUpk9ve3n72ZRhEEarr8
         Cm9mQV86Q6/NE9ZdAH5WyOHtEzVOeFGEsiijHiKSwh8hK8EL6Mwh067fJ9u3IiSRv9Cs
         bBxEQW4b0CDETjtCYsku7a8laxPT64EKI982qdvxoSmtcYA/p1/0DGI2gpqCLJsu0L4x
         yVLce1lf1Ebuv+lGvnx16th/cOwc7NatSWcSe4JbHGCiYWCBZQZxSypTA9v4i6I/Nvvd
         WF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtjPUnCQUJ2Xqmf1HBNfL/7o3eTpGJ7VqulMTNQ/Ev0=;
        b=t+fQlC3wqsXguFeZ64WAtCVSWYxiJ48Webg91B545eD6ENvLaqGYWgYz0mCupsylVy
         8J/Jannovvof17V3AnEUASz3HYNnlE39/hMeWMu5xj1I4YdJ+Xb1pxPX6E/q5jSasFzK
         FuNs7E++79R6/Nn6EYBmggp8FUc+GLAvmLHCb0EQCqZwv6WahFC0Z7GHniBxf6co0+wJ
         daDEbDOIOhigXGP8XSK9r7LSOhYRhIhCSGUP7MYIJq4gEdjbI/sPC3NxI4LsrpLfCGmI
         KfUVTrLskXzn6Pjn605niXiIKc4YGs+aG+oNBzbwAztKAemg2G7GDf/vtTKbZW6Y7UIa
         Hsig==
X-Gm-Message-State: AOAM533kOh//51rIgiD57JTjM2mZek8lQFRyUwCPSMVQWnNrQYYi/o9s
        hnEBCm0zvFbNoIv6ODZ2yCIjkA==
X-Google-Smtp-Source: ABdhPJwIRMQpJ85MGX0gR8olJhcaCWEYMI/m9vI5J6ToPa3D/6Ed4YM3oCvuQEpN7ABDcG3wAppqtQ==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr12882764wrx.212.1596424264279;
        Sun, 02 Aug 2020 20:11:04 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 16/36] wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
Date:   Mon,  3 Aug 2020 04:11:12 +0100
Message-Id: <20200803031132.1427063-17-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds a routine to allow setting the LDPC bit for HT parameter passing
inside the version 1 STA parameters data structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 2632ea2ad9fa..8bb24fe9bde3 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -188,6 +188,15 @@ static void wcn36xx_smd_set_sta_vht_params(struct ieee80211_sta *sta,
 	}
 }
 
+static void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (sta->ht_cap.ht_supported) {
+		sta_params->ht_ldpc_enabled =
+			is_cap_supported(sta->ht_cap.cap, IEEE80211_HT_CAP_LDPC_CODING);
+	}
+}
+
 static void wcn36xx_smd_set_sta_default_ht_params(
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

