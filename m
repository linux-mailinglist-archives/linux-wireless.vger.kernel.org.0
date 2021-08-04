Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7323DFCFC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhHDIeT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbhHDIeQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 04:34:16 -0400
Received: from canardo.mork.no (canardo.mork.no [IPv6:2001:4641::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F950C0613D5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 01:34:03 -0700 (PDT)
Received: from miraculix.mork.no ([IPv6:2a01:799:95f:ef0a:7f0c:624e:2eac:9b4])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 1748XjiF002649
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 4 Aug 2021 10:33:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1628066025; bh=XvqZG4OZOMKZ3OCyYeCAI3eOAwCQRcikbumRB+Ngy6M=;
        h=From:To:Cc:Subject:Date:Message-Id:From;
        b=BbjE1jT+KNAIUMvUucaBZoWdAL0i8qwx2cAhAsSgpPUZcn4s0QgY1Ywe99y3qRAs2
         LEqPXc81kEYqrP2YVxfBi+4LNx7qfZS1+41HfsQj/A9vFKcSUl3oDIJqAOy5gaSg0I
         YlC3fw/McNV+PkztutEPNtTlQsSQ1duMn7sSA59s=
Received: from bjorn by miraculix.mork.no with local (Exim 4.94.2)
        (envelope-from <bjorn@miraculix.mork.no>)
        id 1mBCLM-0002JF-4A; Wed, 04 Aug 2021 10:33:40 +0200
From:   =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Norway (NO) on 6 and 60 GHz
Date:   Wed,  4 Aug 2021 10:33:37 +0200
Message-Id: <20210804083337.8833-1-bjorn@mork.no>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Norwegian regulatory authority (NKOM) has updated the existing
regulations.

WiFi 6E is now allowed with the same restrictions as in many/most
EU/EEA countries - i.e 200 mW indoor and 25 mW outdoor, Using the
DE entry as a template for now, until this dual entry can be
described in the database.

The update also extended the 60 GHz band to 71 GHz.

The official announcement of the regulation changes:
https://lovdata.no/dokument/LTI/forskrift/2021-06-29-2312

The existing reference in the database has been updated with these
changes, so no new reference is needed.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 db.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index debd878f83c7..e7b11cff28b2 100644
--- a/db.txt
+++ b/db.txt
@@ -1198,8 +1198,10 @@ country NO: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	# WiFi 6E
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
-	(57000 - 66000 @ 2160), (40)
+	(57000 - 71000 @ 2160), (40)
 
 country NP: DFS-JP
 	(2402 - 2482 @ 40), (20)
-- 
2.30.2

