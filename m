Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAA308B4D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jan 2021 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhA2RR4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jan 2021 12:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232463AbhA2RPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611940462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VEZe0PYUvvqJZcjfeapjJ+WDBnyr8d5weQk4MFfmHK8=;
        b=fbrXiXcQ4nBGBL+lxq5jipVNvWe7ZpfZEV+x7bEu+xJi1UxqA/T9n+yAqnAy+CKtgQtsyr
        Cyd4MPB+eq1NiHCK+vV1bTGea/E7Vh0pJ6BHgNdWG+iC2UMUPNpIWuL4HALjP3PFNdHxB8
        39KE9odV77QsXuR3xNQF74VeNGO6Qes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-wnDjvP9NOIWB5ygWWHm7fw-1; Fri, 29 Jan 2021 12:14:18 -0500
X-MC-Unique: wnDjvP9NOIWB5ygWWHm7fw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650F11800D41;
        Fri, 29 Jan 2021 17:14:16 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-174.ams2.redhat.com [10.36.115.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48DBB101E581;
        Fri, 29 Jan 2021 17:14:14 +0000 (UTC)
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
Subject: [PATCH 1/2] brcmfmac: Add DMI nvram filename quirk for Predia Basic tablet
Date:   Fri, 29 Jan 2021 18:14:12 +0100
Message-Id: <20210129171413.139880-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Predia Basic tablet contains quite generic names in the sys_vendor and
product_name DMI strings, without this patch brcmfmac will try to load:
brcmfmac43340-sdio.Insyde-CherryTrail.txt as nvram file which is a bit
too generic.

Add a DMI quirk so that a unique and clearly identifiable nvram file name
is used on the Predia Basic tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 4aa2561934d7..824a79f24383 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -40,6 +40,10 @@ static const struct brcmf_dmi_data pov_tab_p1006w_data = {
 	BRCM_CC_43340_CHIP_ID, 2, "pov-tab-p1006w-data"
 };
 
+static const struct brcmf_dmi_data predia_basic_data = {
+	BRCM_CC_43341_CHIP_ID, 2, "predia-basic"
+};
+
 static const struct dmi_system_id dmi_platform_data[] = {
 	{
 		/* ACEPC T8 Cherry Trail Z8350 mini PC */
@@ -111,6 +115,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&pov_tab_p1006w_data,
 	},
+	{
+		/* Predia Basic tablet (+ with keyboard dock) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			/* Mx.WT107.KUBNGEA02 with the version-nr dropped */
+			DMI_MATCH(DMI_BIOS_VERSION, "Mx.WT107.KUBNGEA"),
+		},
+		.driver_data = (void *)&predia_basic_data,
+	},
 	{}
 };
 
-- 
2.29.2

