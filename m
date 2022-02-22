Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4754BEF50
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 03:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiBVCBX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 21:01:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiBVCBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 21:01:22 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 18:00:57 PST
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3551EECA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 18:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1645495258; x=1677031258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ezMtEZcANTH1YyKUbw34d7eEiWnZFgqtS0KkTq2cyR4=;
  b=O+xGXFu9b8Na9vdieGgweMQoI7yaYAvob0iECxs4HBZf2r1fOIC0AkpF
   fpyS01WDqbzN4UrWnQM4WGyASxYGx5WK9pI6p1NoJmrUPV9fOr3opmS71
   zgOQxA6Zzr6lNLwgBxJCP2M3YJbYrRwpfVFTC8U7koDlkT/4GDOOD6GhV
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="282770059"
X-IronPort-AV: E=Sophos;i="5.88,387,1635199200"; 
   d="scan'208";a="282770059"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 22 Feb 2022 02:59:53 +0100
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Mon, 21 Feb 2022
 19:59:50 -0600
Received: from aremote01.aus.cypress.com (aremote01 [10.248.81.40])     by
 inf2.aus.cypress.com (Postfix) with ESMTP id C339F1002EF;      Mon, 21 Feb 2022
 19:59:50 -0600 (CST)
Received: from aremote01.aus.cypress.com (localhost [127.0.0.1])        by
 aremote01.aus.cypress.com (8.14.4/8.14.4) with ESMTP id 21M1xoIw169537;        Mon,
 21 Feb 2022 19:59:50 -0600
Received: (from dblo@localhost) by aremote01.aus.cypress.com
 (8.14.4/8.14.4/Submit) id 21M1xoLM169536;      Mon, 21 Feb 2022 19:59:50 -0600
From:   Double Lo <double.lo@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Double Lo <double.lo@infineon.com>,
        Kurt Lee <kurt.lee@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <Double.Lo@infineon.com>
Subject: [PATCH] MAINTAINERS: change maintainer list for Infineon
Date:   Mon, 21 Feb 2022 19:59:47 -0600
Message-ID: <20220222015947.169224-1-double.lo@infineon.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <Double.Lo@infineon.com>

Chi-hsien Lin chi-hsien.lin@infineon.com
Wright Feng wright.feng@infineon.com
Chung-hsien Hsu chung-hsien.hsu@infineon.com
These email addresses no longer work, so remove them from MAINTAINERS.

Signed-off-by: Double Lo <Double.Lo@infineon.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31116f1d6617..fab3b6c68eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3821,9 +3821,7 @@ BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
 M:	Arend van Spriel <aspriel@gmail.com>
 M:	Franky Lin <franky.lin@broadcom.com>
 M:	Hante Meuleman <hante.meuleman@broadcom.com>
-M:	Chi-hsien Lin <chi-hsien.lin@infineon.com>
-M:	Wright Feng <wright.feng@infineon.com>
-M:	Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
+M:	Double Lo <Double.Lo@infineon.com>
 L:	linux-wireless@vger.kernel.org
 L:	brcm80211-dev-list.pdl@broadcom.com
 L:	SHA-cyfmac-dev-list@infineon.com
-- 
2.25.0

