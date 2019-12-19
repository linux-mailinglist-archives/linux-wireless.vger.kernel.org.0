Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64F125DDF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 10:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLSJml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 04:42:41 -0500
Received: from mx4.wp.pl ([212.77.101.12]:52671 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfLSJmk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 04:42:40 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 04:42:40 EST
Received: (wp-smtpd smtp.wp.pl 7145 invoked from network); 19 Dec 2019 10:35:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1576748159; bh=AE+LglZCX1HGB/kt8zZ+gmT8IHNvwf9mnsXe9cNYMb4=;
          h=From:To:Cc:Subject;
          b=FEAw4UrpdfEi1YhkVwoQC0DOg928a8hJ4yTeKP6milXu0o7WoSXxiOcVtnwlifaGI
           NpXyMRfflOuvYGmVi046XbivNL5ukUGBEp/FTJ4ZImM8UAF62oiY9isrpq3lawL95X
           4OsepFOageI5vKAZ7aqkdBc9yBz3M0inaKCws4lU=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <kvalo@codeaurora.org>; 19 Dec 2019 10:35:59 +0100
Date:   Thu, 19 Dec 2019 10:35:59 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH v2] MAINTAINERS: change Gruszka's email address
Message-ID: <20191219093559.GB14003@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-WP-MailID: 88c07c351f8b3b52e04c520f91ed72dc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [sVKA]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My RedHat email address does not work any longer. Change to my private one.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
v2:
- update to latest wireless-drivers tree
- reflect current state in the changelog

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e34488f7baae..096a982c860c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8563,7 +8563,7 @@ S:	Maintained
 F:	drivers/platform/x86/intel-vbtn.c
 
 INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy)
-M:	Stanislaw Gruszka <sgruszka@redhat.com>
+M:	Stanislaw Gruszka <stf_xl@wp.pl>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/intel/iwlegacy/
@@ -13817,7 +13817,7 @@ S:	Maintained
 F:	arch/mips/ralink
 
 RALINK RT2X00 WIRELESS LAN DRIVER
-M:	Stanislaw Gruszka <sgruszka@redhat.com>
+M:	Stanislaw Gruszka <stf_xl@wp.pl>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-- 
2.13.5

