Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D14457798
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhKSUHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 15:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhKSUHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 15:07:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E5C061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 12:04:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso11355045wms.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YT8AkCkropj2MudxrKGPLWrAwxEDNGN+WH0+jujAC2c=;
        b=BTW4p9q0RDEDOpqRPfjRlg9Jomspagmfth6sPj5wQSa4IxVgHBlBU7MpPvU5QbvMi0
         IP4j4DgxiRzZGav2QBHCsUNJFgpuMeMku1sDt2j60TB2y15+6J/HO9SdLXWlfIjLj4eE
         oPwqwpGHQr4l56/4HBvbhUONCZZ3O9505ULbbw1Ba8wZ0hkfQjLamQoPpaDb22fh5+rj
         qeJu0gt2Onw9T8m+Ck/a3jLDXX2J7jCdFPXDI7DTyZEB7WsqfLmnumTMhRsYxZIgTuuw
         TkjBJRqWiWCQ1Y9ksfNY54S4PX99qb41sgPetfWDpiruUmvfkxJem9gcGrH5e1KsTNvI
         NoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YT8AkCkropj2MudxrKGPLWrAwxEDNGN+WH0+jujAC2c=;
        b=UtJg1z9FY4HPT9O1kX3myBXXFiFTGAy3g2tSiSAT1d0YzhbGFhvFRp7KjGki3FSsDS
         rmXbsyDQNSg3rGPWIDG/AEJW0AY098K+jl7KVBRNsZXgmuR6Vp70MiNahruwy35+ZVwk
         eJeLeaBGihJAuvS3jW6n3N6eoxwlylSfVEZiROs63ZpS6KNuFyEAajN0o3csXWpWVgB5
         mcxOlOL1wRJBFUp/V+jx44HztDtFJdNOZuePZvow1rGlrvdtYGFePZ1RtLbZPkFVF1r+
         cbBA4NgOjqKn3f9RhRJT/FwlUArmUQtWSTMkCxcRTWQzuCdeG3HFXSQmvOMLxJ4nly2P
         p2Yw==
X-Gm-Message-State: AOAM532o+zzNfYwzP8qcoOIdGnL24W7cJSZjgRbbsZLDqDmlpFWGjA1N
        ps2IR807yRTbI88TWSQUxwI=
X-Google-Smtp-Source: ABdhPJw8Wx4irVqNaKm1cayl/qfYIVRpEbXS/5Esn4PzR8j5FSrpjfHygKbaKdJv6voaGPPnpwc6Bw==
X-Received: by 2002:a1c:43c1:: with SMTP id q184mr2880415wma.153.1637352256124;
        Fri, 19 Nov 2021 12:04:16 -0800 (PST)
Received: from baligh-ThinkCentre-M720q.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.googlemail.com with ESMTPSA id be3sm12716741wmb.1.2021.11.19.12.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:04:15 -0800 (PST)
From:   gasmibal@gmail.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, Baligh Gasmi <gasmibal@gmail.com>
Subject: [PATCH] mac80211: remove useless ieee80211_vif_is_mesh() check
Date:   Fri, 19 Nov 2021 21:04:13 +0100
Message-Id: <20211119200413.1236482-1-gasmibal@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baligh Gasmi <gasmibal@gmail.com>

We check ieee80211_vif_is_mesh() at the top if() block,
there's no need to check for it again.
---
 net/mac80211/sta_info.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 51b49f0d3ad4..b979778c6d76 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -364,8 +364,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 			goto free;
 		sta->mesh->plink_sta = sta;
 		spin_lock_init(&sta->mesh->plink_lock);
-		if (ieee80211_vif_is_mesh(&sdata->vif) &&
-		    !sdata->u.mesh.user_mpm)
+		if (!sdata->u.mesh.user_mpm)
 			timer_setup(&sta->mesh->plink_timer, mesh_plink_timer,
 				    0);
 		sta->mesh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
-- 
2.34.0

