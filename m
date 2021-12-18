Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C72479C37
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhLRS44 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 13:56:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbhLRS44 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 13:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639853815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8+rxNfb5lIjHhirsy0gZDZDRdBHmphgN9atXRdplpBU=;
        b=bal0fIGBxM9qtG8kcDGVx+B+QmWtAdyD5bT+odUZfp7lbgNVtHzyoGP5dguKpITGmzrySk
        U3Cnx1XzL2TlcGEAR92dKxyswGMrdB76YvvNP85JaQy05g970TLLfMwsGv4+Tl3qLRf9x/
        xZFY2rY9Pr0Ow9WehSTjTsnhe4kAJhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-qt2XW4EgP6624jQloYsALA-1; Sat, 18 Dec 2021 13:56:54 -0500
X-MC-Unique: qt2XW4EgP6624jQloYsALA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59D18102CC32;
        Sat, 18 Dec 2021 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4108A2B05E;
        Sat, 18 Dec 2021 18:56:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Shawn Guo <shawn.guo@linaro.org>,
        Soeren Moch <smoch@web.de>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] brcmfmac: use ISO3166 country code and 0 rev as fallback on some devices
Date:   Sat, 18 Dec 2021 19:56:43 +0100
Message-Id: <20211218185643.158182-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a second attempt at honering the country code send out by access
points. This was first added in commit b0b524f079a2 ("brcmfmac: use
ISO3166 country code and 0 rev as fallback").

Subsequently this was reverted in commit 151a7c12c4fc ("Revert "brcmfmac:
use ISO3166 country code and 0 rev as fallback""), because it was causing
issues with AP mode on some brcmfmac models (specifically on BCM4359/9).

Many devices ship with a nvram ccode value of X2/XT/XU/XV/ALL which are
all special world-wide compatibility ccode-s. Most of these world-wide
ccode-s allow passive scan mode only for 2.4GHz channels 12-14,
only enabling them when an AP is seen on them.

But at least on brcmfmac43455 devices this is not working correctly, these
do not see accesspoints on channels 12-14 unless the ccode is changes to
a country where these channels are allowed.

Translating received country codes to an ISO3166 country code and 0 rev
ccreq fixes devices using a brcmfmac43455 with a X2/XT/XU/XV/ALL ccode
not seeing accesspoints on channels 12-14.

To avoid this causing issues on other brcmfmac models again, the
fallback is limited to only brcmfmac4345* chips this time.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Soeren Moch <smoch@web.de>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fb727778312c..c10ac839dd26 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -16,6 +16,7 @@
 #include <brcmu_utils.h>
 #include <defs.h>
 #include <brcmu_wifi.h>
+#include <brcm_hw_ids.h>
 #include "core.h"
 #include "debug.h"
 #include "tracepoint.h"
@@ -7455,6 +7456,16 @@ int brcmf_cfg80211_wait_vif_event(struct brcmf_cfg80211_info *cfg,
 				  vif_event_equals(event, action), timeout);
 }
 
+static bool brmcf_use_iso3166_ccode_fallback(struct brcmf_pub *drvr)
+{
+	switch (drvr->bus_if->chip) {
+	case BRCM_CC_4345_CHIP_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static s32 brcmf_translate_country_code(struct brcmf_pub *drvr, char alpha2[2],
 					struct brcmf_fil_country_le *ccreq)
 {
@@ -7463,18 +7474,28 @@ static s32 brcmf_translate_country_code(struct brcmf_pub *drvr, char alpha2[2],
 	s32 found_index;
 	int i;
 
-	country_codes = drvr->settings->country_codes;
-	if (!country_codes) {
-		brcmf_dbg(TRACE, "No country codes configured for device\n");
-		return -EINVAL;
-	}
-
 	if ((alpha2[0] == ccreq->country_abbrev[0]) &&
 	    (alpha2[1] == ccreq->country_abbrev[1])) {
 		brcmf_dbg(TRACE, "Country code already set\n");
 		return -EAGAIN;
 	}
 
+	country_codes = drvr->settings->country_codes;
+	if (!country_codes) {
+		if (brmcf_use_iso3166_ccode_fallback(drvr)) {
+			brcmf_dbg(TRACE, "No country codes configured for device, using ISO3166 code and 0 rev\n");
+			memset(ccreq, 0, sizeof(*ccreq));
+			ccreq->country_abbrev[0] = alpha2[0];
+			ccreq->country_abbrev[1] = alpha2[1];
+			ccreq->ccode[0] = alpha2[0];
+			ccreq->ccode[1] = alpha2[1];
+			return 0;
+		}
+
+		brcmf_dbg(TRACE, "No country codes configured for device\n");
+		return -EINVAL;
+	}
+
 	found_index = -1;
 	for (i = 0; i < country_codes->table_size; i++) {
 		cc = &country_codes->table[i];
-- 
2.33.1

