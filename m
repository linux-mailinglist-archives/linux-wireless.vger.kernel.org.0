Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F58252A39
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgHZJgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHZJfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:35:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40623C061367
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w13so1096081wrk.5
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmeKWj6ihDtxXg7mmV0g02PkzMbJUwVy4vUADq1jq3Y=;
        b=lHkQ9kbI4YiHrMG+5c1O2DA0EUdgjZyvLmV+8YExFcXi1gdFNdZna7wI1C7eYgwRYz
         9Xk1+KxSEYrXF/zIdSTSg24AIl/kZzSC8uzCISjmVpPb5WPvkYGGet2Msnt5AYRohb/9
         tdTLogHLdCjhAebO1xjCBX6weShNPfIwXefOeUNOsk4XydWW3Dg3BLWF1dKUkFyUxjFH
         89+MNPaKS6ACrOuzatrjQoAYZCgN2RoMGXmYGEZ8aYPqTCfAjVCfkJdUGw7QdeinfKnR
         fQiS/5nY5m8XV04zepMGobk9n7MVwie/ajSLslD2eTM/u2MZs63wJfpm38MbNLDGKajP
         esjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmeKWj6ihDtxXg7mmV0g02PkzMbJUwVy4vUADq1jq3Y=;
        b=HB/+pB1LxAC+ZLZlYdgz8DrPM0+C5Kh1BIWhwtwno2y2E4ZT+3yRQ8f19JNbMauO47
         tv6NaxaXAv1fnHWfvUasYaZcnpFJpRl0g0rqDiNxewWv2VPKcP0i0udk5l8C5gb0aJYD
         NO2+QI5JlJd+pOADUb1V8NNQxn07u+WUIZywb5+Ju6eN36Golg9nexWgHduTfRxFCRZL
         3fSAAI7+WdxtQctm0d2NNHdOkz6u5SAhUGqT9bTxHv7xaCnhVDXCfcXKlN9JZKn8ZJ1I
         Vid0e/d6A/rI55W7xg/QudSbilk1s4he7N4G08CJjfyRL6c3xD+8JMTQ1CI/Ljyfka/1
         o1Xg==
X-Gm-Message-State: AOAM530O+PclvNJn9eTcTl1XnghT39DcW9PABnLDpOwglTgYwYpK6jXN
        v4TZE3N+fbXDcuEf+9OjnAPxr+8DRBgTbA==
X-Google-Smtp-Source: ABdhPJysAlZ5GN6k56EGB8IkpZjoW4o5OuDOadTyLk2UwIoJAbWs4p5DNd4oDWJVopFCUT4nSOwAVg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr477311wrr.105.1598434480972;
        Wed, 26 Aug 2020 02:34:40 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 29/30] wireless: broadcom: brcm80211: phytbl_lcn: Remove unused array 'dot11lcnphytbl_rx_gain_info_rev1'
Date:   Wed, 26 Aug 2020 10:34:00 +0100
Message-Id: <20200826093401.1458456-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c:1510:33: warning: ‘dot11lcnphytbl_rx_gain_info_rev1’ defined but not used [-Wunused-const-variable=]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c
index be703be34616a..7526aa441de11 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c
@@ -1507,19 +1507,6 @@ const struct phytbl_info dot11lcnphytbl_rx_gain_info_rev0[] = {
 	,
 };
 
-static const struct phytbl_info dot11lcnphytbl_rx_gain_info_rev1[] = {
-	{&dot11lcn_gain_tbl_rev1,
-	 ARRAY_SIZE(dot11lcn_gain_tbl_rev1), 18,
-	 0, 32}
-	,
-	{&dot11lcn_aux_gain_idx_tbl_rev0,
-	 ARRAY_SIZE(dot11lcn_aux_gain_idx_tbl_rev0), 14, 0, 16}
-	,
-	{&dot11lcn_gain_idx_tbl_rev0,
-	 ARRAY_SIZE(dot11lcn_gain_idx_tbl_rev0), 13, 0, 32}
-	,
-};
-
 const struct phytbl_info dot11lcnphytbl_rx_gain_info_2G_rev2[] = {
 	{&dot11lcn_gain_tbl_2G,
 	 ARRAY_SIZE(dot11lcn_gain_tbl_2G), 18, 0,
-- 
2.25.1

