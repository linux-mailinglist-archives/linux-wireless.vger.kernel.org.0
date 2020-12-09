Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688DD2D4CB3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbgLIVSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:18:16 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35632 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388115AbgLIVRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:17:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pX-003Drx-7d; Wed, 09 Dec 2020 23:16:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:11 +0200
Message-Id: <iwlwifi.20201209231352.bdd32f03a42f.I8f13a5689dd353825fb2b9bd5b6f0fbce92cb12b@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 07/47] iwlwifi: update MAINTAINERS entry
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Reflect the fact that the linuxwifi@intel.com address will disappear,
and that neither Emmanuel nor myself are really much involved with
the maintenance these days.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..cef21e97060d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9096,10 +9096,7 @@ S:	Supported
 F:	drivers/net/wireless/intel/iwlegacy/
 
 INTEL WIRELESS WIFI LINK (iwlwifi)
-M:	Johannes Berg <johannes.berg@intel.com>
-M:	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
 M:	Luca Coelho <luciano.coelho@intel.com>
-M:	Intel Linux Wireless <linuxwifi@intel.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
-- 
2.29.2

