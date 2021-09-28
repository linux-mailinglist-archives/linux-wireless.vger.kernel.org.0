Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6241B389
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbhI1QIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 12:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241443AbhI1QIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 12:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632845200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zAIFbXls77tGep+s4/UrFsPTQGUDVBFfEpxrZVmfB+8=;
        b=Qno1cv14DkNVawbFQk4ua82B0pzU0/zqrCz1Kq8eEld0hBl8CteZC9eLqLWNmGXtVZyj31
        RSZrhpdD5gCW2W5T0Vr/LvXP2NVzxqzj7cWh2UNqT5M7CYFGP7Mop1k/FJDwr3CQ6IDKF9
        795Cz5jeOZWx/JjBG6cVK8upwJtO1Q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-henqhXNiMFC5T9xv4EUdwg-1; Tue, 28 Sep 2021 12:06:38 -0400
X-MC-Unique: henqhXNiMFC5T9xv4EUdwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BDDB1006AA3;
        Tue, 28 Sep 2021 16:06:36 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE6918EF7;
        Tue, 28 Sep 2021 16:06:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH] brcmfmac: Add DMI nvram filename quirk for Cyberbook T116 tablet
Date:   Tue, 28 Sep 2021 18:06:33 +0200
Message-Id: <20210928160633.96928-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Cyberbook T116 tablet contains quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
"brcmfmac43455-sdio.Default string-Default string.txt" as nvram file which
is way too generic.

The nvram file shipped on the factory Android image contains the exact
same settings as those used on the AcePC T8 mini PC, so point the new
DMI nvram filename quirk to the acepc-t8 nvram file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 6d5188b78f2d..0af452dca766 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -75,6 +75,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* Cyberbook T116 rugged tablet */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "20170531"),
+		},
+		/* The factory image nvram file is identical to the ACEPC T8 one */
+		.driver_data = (void *)&acepc_t8_data,
+	},
 	{
 		/* Match for the GPDwin which unfortunately uses somewhat
 		 * generic dmi strings, which is why we test for 4 strings.
-- 
2.31.1

