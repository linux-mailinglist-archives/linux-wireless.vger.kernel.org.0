Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE84806B2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Dec 2021 07:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhL1GVB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Dec 2021 01:21:01 -0500
Received: from smtp3.infineon.com ([217.10.52.24]:15922 "EHLO
        smtp3.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbhL1GVB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Dec 2021 01:21:01 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Dec 2021 01:21:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1640672461; x=1672208461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L3s2mwSFCzUfxuU/h61njUXVurdft7CpPxym2NVUx4U=;
  b=DyrDA1bfj1LbWLSZPdhHyk3tW9ps57CXgMwngZDuNqIEoXq5y2wuRv43
   Om7LAwzt0FlhBHSzFkXnxvu9Z7llS/uBaOrtA1R/Nk1UqD0YXjp4awCFW
   qgvNrqvSq9XZGs96c7Xb6iNhDRtPuam7e9By5hp8iitzMH4V7rRjQaVIm
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="158977067"
X-IronPort-AV: E=Sophos;i="5.88,241,1635199200"; 
   d="scan'208";a="158977067"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 28 Dec 2021 07:13:52 +0100
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 28 Dec 2021
 00:13:50 -0600
Received: from iot-wlan-dev-u01.aus.cypress.com (iot-wlan-dev-u01
 [10.248.81.191])       by inf2.aus.cypress.com (Postfix) with ESMTP id D79FB100243;
        Tue, 28 Dec 2021 00:13:50 -0600 (CST)
Received: by iot-wlan-dev-u01.aus.cypress.com (Postfix, from userid 38255)      id
 C72151AC562; Tue, 28 Dec 2021 00:13:50 -0600 (CST)
From:   Wright Feng <wright.feng@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>
Subject: [PATCH] MAINTAINERS: update maintainer list for Infineon
Date:   Tue, 28 Dec 2021 00:13:15 -0600
Message-ID: <20211228061315.11126-1-wright.feng@infineon.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chi-Hsien Lin <chi-hsien.lin@infineon.com>

Add new maintainer and remove old maintainers.

Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Wright Feng <wright.feng@infineon.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ebfc9de0caf..845058803f95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3759,9 +3759,9 @@ BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
 M:	Arend van Spriel <aspriel@gmail.com>
 M:	Franky Lin <franky.lin@broadcom.com>
 M:	Hante Meuleman <hante.meuleman@broadcom.com>
-M:	Chi-hsien Lin <chi-hsien.lin@infineon.com>
 M:	Wright Feng <wright.feng@infineon.com>
-M:	Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
+M:	Double Lo <double.lo@infineon.com>
+M:	Kurt Lee <kurt.lee@infineon.com>
 L:	linux-wireless@vger.kernel.org
 L:	brcm80211-dev-list.pdl@broadcom.com
 L:	SHA-cyfmac-dev-list@infineon.com
-- 
2.25.0

