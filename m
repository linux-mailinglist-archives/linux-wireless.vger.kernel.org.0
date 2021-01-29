Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A24308B4E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jan 2021 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhA2RSF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jan 2021 12:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230389AbhA2RP6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611940471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efmTMLOeM+i6jTSBInz91CbTaryKB5itJPA8N9uo2Ms=;
        b=WCeqQboZc4zZ2uLpv+VuijQ1xy8UEALaw7lecgaxjfAvZXOO7tr8HpO3oaYTiLTHx8bSE5
        4blsvRhjvfwWprCj8gzwRgoVJD7N6gmyFRhsgr/XUJSdzvNtWcVI4y4+QP2/fZpsJ/GF4P
        dlWVgHzJwceClY/fUX5SYVPhCxKD6E4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-3g8rGFNVPJSHWr0rbpKKgQ-1; Fri, 29 Jan 2021 12:14:22 -0500
X-MC-Unique: 3g8rGFNVPJSHWr0rbpKKgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACBB2911E3;
        Fri, 29 Jan 2021 17:14:18 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-174.ams2.redhat.com [10.36.115.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABE7710023AB;
        Fri, 29 Jan 2021 17:14:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH 2/2] brcmfmac: Add DMI nvram filename quirk for Voyo winpad A15 tablet
Date:   Fri, 29 Jan 2021 18:14:13 +0100
Message-Id: <20210129171413.139880-2-hdegoede@redhat.com>
In-Reply-To: <20210129171413.139880-1-hdegoede@redhat.com>
References: <20210129171413.139880-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Voyo winpad A15 tablet contains quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
rcmfmac4330-sdio.To be filled by O.E.M.-To be filled by O.E.M..txt
as nvram file which is a bit too generic.

Add a DMI quirk so that a unique and clearly identifiable nvram file name
is used on the Voyo winpad A15 tablet.

While preparing a matching linux-firmware update I noticed that the nvram
is identical to the nvram used on the Prowise-PT301 tablet, so the new DMI
quirk entry simply points to the already existing Prowise-PT301 nvram file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/dmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 824a79f24383..6d5188b78f2d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -44,6 +44,14 @@ static const struct brcmf_dmi_data predia_basic_data = {
 	BRCM_CC_43341_CHIP_ID, 2, "predia-basic"
 };
 
+/* Note the Voyo winpad A15 tablet uses the same Ampak AP6330 module, with the
+ * exact same nvram file as the Prowise-PT301 tablet. Since the nvram for the
+ * Prowise-PT301 is already in linux-firmware we just point to that here.
+ */
+static const struct brcmf_dmi_data voyo_winpad_a15_data = {
+	BRCM_CC_4330_CHIP_ID, 4, "Prowise-PT301"
+};
+
 static const struct dmi_system_id dmi_platform_data[] = {
 	{
 		/* ACEPC T8 Cherry Trail Z8350 mini PC */
@@ -125,6 +133,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&predia_basic_data,
 	},
+	{
+		/* Voyo winpad A15 tablet */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "11/20/2014"),
+		},
+		.driver_data = (void *)&voyo_winpad_a15_data,
+	},
 	{}
 };
 
-- 
2.29.2

