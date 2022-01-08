Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366944884D3
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 18:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiAHRIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 12:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiAHRIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 12:08:53 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C97C061401
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 09:08:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v6so17600397wra.8
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jan 2022 09:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/VlTdEJulPdJ5lhYnLqtXNudnIvNcxVXcQYjID5flM=;
        b=QJYB9XYsufCwqDX4iKyzyZ+wxXIxWnYX5U8roG8H1vzkeEf4Fkp8AdWhPUABwpGp11
         F9wHOljEL4BEBwai52mzd3ZuE+4W6M7mPXcrB2RShexn1PQVIDlUcHLbl8xlafZtoNRI
         7oEeLSusxwKJ43h1EXgn99YoScnKdS27FUx7MWpWpkBWa/sAxElLDZO+sOZcqZoZ11Z9
         3OzWr9SqyOsl00hxRekzrsBlJqFSn9RjM+n6qDgyymMDj+Jp3MGf/e2GOIWwtjWQn7ZF
         uQd7tAt3YL1P+iVva1mcBhMZMY/tyH9ppPFOGrj3QbTaCbOa7spMc2bmRwaRRY89edkV
         HQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/VlTdEJulPdJ5lhYnLqtXNudnIvNcxVXcQYjID5flM=;
        b=pCuUa1i6+rqjCC3wNd0Ta167ssG373fQLTbNrU3qubhEzjHozPy8o3T3uqvcVEZ8rq
         rjkfHcaoyNJwQAUU7ZnaR6Gq55BLuuksYtPwDTjrI8BGwTbw8lhrxL8hstHlay+mjMHI
         /EItGffunRaV765Xu6vlOpk55mVgg3/JurLEch/+L1BdQQDv5qxeW10SB+HFZKvsnUxe
         tOdlr2WbC3swdshoVoUK+tVezwxmO089DEwBiw0x9cLATIPlEQHNaWkkytaRL+Tv4ovG
         bddMBNy/2f+esCbn9lLf+v/c3deZ/nu0Ou33HV/bGWOSC6pXTgzuXzT2KqonHUN9pBSi
         9DYw==
X-Gm-Message-State: AOAM530h4nF7N73uM9AIxgDAZiXcpa4vdIVqWPk+k8iCaowHGqmIine+
        VB5Gi1GZpTOaEwsHTtKBmS6NDQ==
X-Google-Smtp-Source: ABdhPJz3koEVvQiwIhz7g3BEN4/5yS4O6x481mffkrC8jEppRjy0XjSJCDh5Hmvlyl4fWASVvExQZA==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr2335465wrv.175.1641661731747;
        Sat, 08 Jan 2022 09:08:51 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d22sm2154727wrb.83.2022.01.08.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:08:51 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 1/4] wcn36xx: Implement get_snr()
Date:   Sat,  8 Jan 2022 17:10:54 +0000
Message-Id: <20220108171057.1823315-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
References: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The wcn36xx BD phy descriptor returns both Received Signal Strength
Information (RSSI) and Signal To Noise Ratio (SNR) with each delivered BD.

The macro to extract this data is a simple-one liner, easily imported from
downstream. This data will be useful to us when implementing
mac80211-ops->get_survey().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index ed4e8f201f510..a3eb476c2cbc4 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -23,6 +23,11 @@ static inline int get_rssi0(struct wcn36xx_rx_bd *bd)
 	return 100 - ((bd->phy_stat0 >> 24) & 0xff);
 }
 
+static inline int get_snr(struct wcn36xx_rx_bd *bd)
+{
+	return ((bd->phy_stat1 >> 24) & 0xff);
+}
+
 struct wcn36xx_rate {
 	u16 bitrate;
 	u16 mcs_or_legacy_index;
-- 
2.33.0

