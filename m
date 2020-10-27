Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7229A5CE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 08:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508250AbgJ0Hu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 03:50:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57280 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728742AbgJ0Hu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 03:50:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kXJks-002hg8-5T; Tue, 27 Oct 2020 09:50:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 27 Oct 2020 09:50:53 +0200
Message-Id: <20201027075053.2717839-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH] iw: update wikipage URL
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The URL in the README file was still the old one, which leads to
non-existing page.  Update it with the new one.

Change-Id: I9b0a3c73bfb7ea42daa68c0fdc3a02db272d8e75
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 1d0eaae6e036..113bf3851722 100644
--- a/README
+++ b/README
@@ -9,7 +9,7 @@ to find libnl.
 
 'iw' is currently maintained at http://git.sipsolutions.net/iw.git/,
 some more documentation is available at
-http://wireless.kernel.org/en/users/Documentation/iw.
+https://wireless.wiki.kernel.org/en/users/Documentation/iw
 
 Please send all patches to Johannes Berg <johannes@sipsolutions.net>
 and CC linux-wireless@vger.kernel.org for community review.
-- 
2.28.0

