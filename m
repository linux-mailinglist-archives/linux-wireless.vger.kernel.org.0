Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B52A44E7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 13:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgKCMQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 07:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKCMQm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 07:16:42 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04134C0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 04:16:42 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a9so18281169wrg.12
        for <linux-wireless@vger.kernel.org>; Tue, 03 Nov 2020 04:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtYobGQeIsOA41x9xn4O9D84Sqas95KTsM7EDwW2NZ8=;
        b=bqSQSaSzFf2lIASC3v6o/0ubrIkOy+WrVQu6Zj5VP3mjYYKf6qsyFAIHwbqDtzTIPl
         q2eCzOTTPup91Qg/J6h/fcn585CWG4TgI3bbPzKUL7rWWpd21TayPVv7kX4tS8Id5/26
         1AWAOnRcq/jwRRkvqrQ91703Adf6LYsbmIFSDwmigCeaFA60DSdD32LU25EhdeDElmf4
         n0nTV4BIGYnwngGCRsJiE6gYp56wFSNsrgzDiVizpsHP4/DzKPaK0xbss0k4KEMVEknD
         Z0ORxG8eFHKkCHUvqWI5PhD5ZQdf0XDEAFosaius6KQbc+31s60CE6wZhOAf3JSQKv85
         V+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtYobGQeIsOA41x9xn4O9D84Sqas95KTsM7EDwW2NZ8=;
        b=eePNvyQhv+8v8twdJtkbneuWW1/KrKsKRHt+9dV4ckdQezY5Y2t7CTrWoAGNV7wEfl
         YQLSqasWcrX6u3XZqmgPSKf8Fc3UBtdc7ljWfxFx7LPpvz0T0VgRq+9m/F1UH4nlB46I
         RusIWD1f8Be1yS3Fe44OVNrTlvTMbdiz0fbhqRKO/yk9rdoRABoUmpG6Z/uxD9QvOk2N
         NTpySSHJeWralxsasBBhSi04iI+WH+xyUWCVipOX/zI06uRzz3chQ7kNKjeU6MYtH4oS
         mWs85B1WX53SPmYKEZNk2gHFC9eFYXvPzPf/Ux7oBJGqsBE2X5diNknTNA9jc02lswLn
         1pzw==
X-Gm-Message-State: AOAM531b4F00kuuU6F79tWeisVjujCCGJxBBpFznxIyCPIkC+YTorEAD
        dMX7tEVZt9bGNBYGb2yQc+83Ag==
X-Google-Smtp-Source: ABdhPJznFL0l7GIBMTCL4s6H9JUgbutaU6Aeb9w2VyMeeYMzIAJ8ITqnX8Wpee2NPWJUppf0Bh4rgg==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr27881738wrc.105.1604405800755;
        Tue, 03 Nov 2020 04:16:40 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z6sm2678210wmi.1.2020.11.03.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 04:16:40 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 2/3] wcn36xx: Enable firmware link monitoring
Date:   Tue,  3 Nov 2020 12:17:34 +0000
Message-Id: <20201103121735.291324-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103121735.291324-1-bryan.odonoghue@linaro.org>
References: <20201103121735.291324-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch switches on CONNECTION_MONITOR. Once done it is up to the
firmware to send keep alive and to monitor the link state.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 706728fba72d..e924cc4acde0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1246,6 +1246,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 	ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
 
 	wcn->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 		BIT(NL80211_IFTYPE_AP) |
-- 
2.28.0

