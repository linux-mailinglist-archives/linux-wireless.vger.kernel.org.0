Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8A48F362
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 01:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiAOAOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 19:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiAOAOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 19:14:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFACBC061574
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:14:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso9967422wmc.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/VlTdEJulPdJ5lhYnLqtXNudnIvNcxVXcQYjID5flM=;
        b=a8cQFTW6VWC9QOYCN0Nzwt9T08bC3H1lzH76U1ByiOYrQETOWY84iqH6Gv+BrM3ns6
         nwYxVDsebCc9jAB1FJ04dKfh+to1M4gek+oSWvI7olrVMVxFOehtGjW4ZziljjqwzZNY
         Cz2Zx8oQK5eQTlh5f7tUY3SRyklm0+OvMu4P8kcz2m4FBSBplV0pTX+5bFQg/SNvI6vd
         knmfVgsbWkN4T/06MiUxRee5sQhlPrsrRnIvSGQYrJFV34+aSG+eO7GMwmFgKrQBIAj8
         kh/nD/cPj9LKyyPyiSYofh74Y3gqUY9P54pX1CSqXa+uKk7vIdRmZmkzn7sJcY/HTZ0R
         ANuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/VlTdEJulPdJ5lhYnLqtXNudnIvNcxVXcQYjID5flM=;
        b=v3vJHnKrMrckMJC8dk6515M8ihQ4ob7GkDSj6b4nGdRY+/PoKlLSG6pWBBnIndjp1R
         eAM/2mtL2CoK4n4aw2PdJXKZfowpEMj01QOar2Y+J019Fz2wfePPCcXg2ku23e8ayFtc
         Ruod9d1Dde1wna/9x3EXY4ifrq+4MX9AUOSrIehR20VRjnzOZwVNdbihMEvBp0oSf9yR
         5FdzGCvqF3u8fUaqPg8BJepBPkytJGxl/jl66lOvn6iP1tKn5XYaaygIAoelung7C9PJ
         Two+/aE40/9mZ7TAvsdt6SJaxNB2ci92TRCr9pFqr2l7GDfNVjokZfIswbaDc2eMdQSr
         HCow==
X-Gm-Message-State: AOAM531v4sU0sQEvjQrkv+hW8A6HDDLtpttkhNTzpvotzs/+KzrA0WnM
        SfMPKaePIeHLF0zGshvFVw4m5w==
X-Google-Smtp-Source: ABdhPJzN+iY1z1u+pPRCLJ+OPIUmIRA6vbwtxm+oSXmMEjMqbYccp6DXHuOzdNwLvuRh5KFGonTnng==
X-Received: by 2002:a05:600c:354c:: with SMTP id i12mr10268814wmq.90.1642205677439;
        Fri, 14 Jan 2022 16:14:37 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15sm7379494wmq.6.2022.01.14.16.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:14:36 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 1/4] wcn36xx: Implement get_snr()
Date:   Sat, 15 Jan 2022 00:16:43 +0000
Message-Id: <20220115001646.3981501-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220115001646.3981501-1-bryan.odonoghue@linaro.org>
References: <20220115001646.3981501-1-bryan.odonoghue@linaro.org>
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

