Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886344A6D4F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245258AbiBBIuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:09 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37944 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245237AbiBBIuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:08 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL4-0004v8-LX;
        Wed, 02 Feb 2022 10:50:07 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:44 +0200
Message-Id: <iwlwifi.20220202104617.330d03623b08.Idda91cd6f1c7bd865a50c47d408e5cdab0fd951f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/14] cfg80211: pmsr: remove useless ifdef guards
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This isn't a header file, I guess I must've copied from
the header file and forgotten to remove the guards.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/pmsr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 328cf54bda82..2bc647720cda 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -2,8 +2,6 @@
 /*
  * Copyright (C) 2018 - 2021 Intel Corporation
  */
-#ifndef __PMSR_H
-#define __PMSR_H
 #include <net/cfg80211.h>
 #include "core.h"
 #include "nl80211.h"
@@ -661,5 +659,3 @@ void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid)
 	}
 	spin_unlock_bh(&wdev->pmsr_lock);
 }
-
-#endif /* __PMSR_H */
-- 
2.34.1

