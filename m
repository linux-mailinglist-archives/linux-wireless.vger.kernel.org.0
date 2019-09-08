Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF9ACA28
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 02:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfIHA5Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Sep 2019 20:57:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45442 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfIHA5Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Sep 2019 20:57:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so6866747pfb.12
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bPq/4t69TRbTrMCPtzqiFbtZoY8oWm8dFvyqL6hbl4o=;
        b=LWZ0iH+a1tNSHUqeXKTcBg3tMamoZsndQ0BHMAgzPg2icEltbFcSIY07Qd2WErPski
         27fzPCNQXN1O2HT81d8E0GDO6fRflYWVCZ/7J0xDiGFDUky/0kNKPuSLFhqjtIKyaDzl
         PsvhjOm3qfT+cIFJ6zwpclK2in9dQDqw6oCUezQPsCCHUhw4blmTwhsp82rcZqQxew5R
         JaRBDpte5wARB4pXCpm+ZHF5aw7cTJEmV9tPxo7E5YajVpVzmiNAb15ZpDlYPDXLH8dN
         WSKZheNPMPtyLl/LPeQbRGewiL4WFPCP9JTgOO4aCYetf9fyGQeGSR6PmSTds1d9aXRc
         x1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bPq/4t69TRbTrMCPtzqiFbtZoY8oWm8dFvyqL6hbl4o=;
        b=Z0EN1xTFk3Iac362w0qNxbkInH+vkQqCy4iGS8WIwA1JY+crGGLF1omXZWNzRFvzXA
         QYoUKohfW+hYb7Qw40XXQVKgjWRpKbHB9gRu8rZsF6vySktuzor/T+yYWi+H97Sjj2lv
         k3oW8sjKq9V60obz0J+RJr6OSEy4q4Qvc5yJQgBlAQ/qAJ9iJyKeySyJTM63XnB5V0Dp
         TPktDprPQD6jBWkKqV6yEtGsxPxV/KS8oM8QTwokywnht+Bw/QzXXNK/dS1abZpL52MY
         0veQ2/2IkN6lnXO0bpiqSlCcx4PEV3/PEnYkj2d3Sy03T6iJ06V4FuV9IoVNFyclBj46
         77NA==
X-Gm-Message-State: APjAAAVk1TUhvFdATgwkfdCu/x1dr0V2A0YBmL+MZzsAKPobengrinQ4
        aeab0ekuS/5KfcC25enNM5Y=
X-Google-Smtp-Source: APXvYqzN3cL1Sdovp7VJX0cVIotkpZS0N2b/K/BWbg3r56YqowrHfZ4i770L/tHZmrhC9Dz1WybqSA==
X-Received: by 2002:aa7:94af:: with SMTP id a15mr19517570pfl.157.1567904243988;
        Sat, 07 Sep 2019 17:57:23 -0700 (PDT)
Received: from gtx1600.flets-east.jp ([2409:11:53c0:1f00:6859:dd0a:96bf:4dec])
        by smtp.gmail.com with ESMTPSA id e3sm9237033pjr.9.2019.09.07.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 17:57:23 -0700 (PDT)
From:   Masashi Honma <masashi.honma@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, dan.carpenter@oracle.com,
        Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH] nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds
Date:   Sun,  8 Sep 2019 09:56:53 +0900
Message-Id: <20190908005653.17433-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

commit 1222a16014888ed9733c11e221730d4a8196222b "nl80211: Fix possible
Spectre-v1 for CQM RSSI thresholds" requires one more fix to prevent
accessing to rssi_thresholds[n]. Because user can control
rssi_thresholds[i] values to make i reach to n. For example,
rssi_thresholds = {-400, -300, -200, -100} when last is -34.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3e30e18d1d89..773b22654c23 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10805,9 +10805,11 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	hyst = wdev->cqm_config->rssi_hyst;
 	n = wdev->cqm_config->n_rssi_thresholds;
 
-	for (i = 0; i < n; i++)
+	for (i = 0; i < n; i++) {
+		i = array_index_nospec(i, n);
 		if (last < wdev->cqm_config->rssi_thresholds[i])
 			break;
+	}
 
 	low_index = i - 1;
 	if (low_index >= 0) {
-- 
2.17.1

