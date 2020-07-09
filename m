Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD22198A2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2020 08:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgGIG14 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jul 2020 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgGIG14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jul 2020 02:27:56 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550F8C061A0B;
        Wed,  8 Jul 2020 23:27:56 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id E82AFBC070;
        Thu,  9 Jul 2020 06:27:53 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] SONICS SILICON BACKPLANE DRIVER (SSB): Replace HTTP links with HTTPS ones
Date:   Thu,  9 Jul 2020 08:27:47 +0200
Message-Id: <20200709062747.23948-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/ssb/driver_chipcommon.c     | 4 ++--
 drivers/ssb/driver_chipcommon_pmu.c | 2 +-
 drivers/ssb/sprom.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/driver_chipcommon.c b/drivers/ssb/driver_chipcommon.c
index 3861cb659cb9..85542bfd7715 100644
--- a/drivers/ssb/driver_chipcommon.c
+++ b/drivers/ssb/driver_chipcommon.c
@@ -238,7 +238,7 @@ static void chipco_powercontrol_init(struct ssb_chipcommon *cc)
 	}
 }
 
-/* http://bcm-v4.sipsolutions.net/802.11/PmuFastPwrupDelay */
+/* https://bcm-v4.sipsolutions.net/802.11/PmuFastPwrupDelay */
 static u16 pmu_fast_powerup_delay(struct ssb_chipcommon *cc)
 {
 	struct ssb_bus *bus = cc->dev->bus;
@@ -255,7 +255,7 @@ static u16 pmu_fast_powerup_delay(struct ssb_chipcommon *cc)
 	}
 }
 
-/* http://bcm-v4.sipsolutions.net/802.11/ClkctlFastPwrupDelay */
+/* https://bcm-v4.sipsolutions.net/802.11/ClkctlFastPwrupDelay */
 static void calc_fast_powerup_delay(struct ssb_chipcommon *cc)
 {
 	struct ssb_bus *bus = cc->dev->bus;
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index 0f60e90ded26..888069e10659 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -513,7 +513,7 @@ static void ssb_pmu_resources_init(struct ssb_chipcommon *cc)
 		chipco_write32(cc, SSB_CHIPCO_PMU_MAXRES_MSK, max_msk);
 }
 
-/* http://bcm-v4.sipsolutions.net/802.11/SSB/PmuInit */
+/* https://bcm-v4.sipsolutions.net/802.11/SSB/PmuInit */
 void ssb_pmu_init(struct ssb_chipcommon *cc)
 {
 	u32 pmucap;
diff --git a/drivers/ssb/sprom.c b/drivers/ssb/sprom.c
index 42d620cee8a9..7cd553127861 100644
--- a/drivers/ssb/sprom.c
+++ b/drivers/ssb/sprom.c
@@ -186,7 +186,7 @@ int ssb_fill_sprom_with_fallback(struct ssb_bus *bus, struct ssb_sprom *out)
 	return get_fallback_sprom(bus, out);
 }
 
-/* http://bcm-v4.sipsolutions.net/802.11/IsSpromAvailable */
+/* https://bcm-v4.sipsolutions.net/802.11/IsSpromAvailable */
 bool ssb_is_sprom_available(struct ssb_bus *bus)
 {
 	/* status register only exists on chipcomon rev >= 11 and we need check
-- 
2.27.0

