Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF9958EE36
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiHJOY2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHJOXn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 10:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EEB112D1E
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660141422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tSvIAHfeGPfFrnzIzOe6epo/8qtxfItStAKthgi78/I=;
        b=H9ILpwidMJl6JCEhGtut74ElAf8KCkcSfpZW30wsHQRjcemcD8LbfqbFafcNM140CBRxE7
        T/4aZATclFbTRKGUb/UxWk+WdaORA1/zR4gY7eKyhyOvcQYzRq2DWlBKzxGdsmawe8B18K
        3+TYAfggqbKP2ub2TCs2TzRMN4kcnLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-NeQE8oGJNa6GrhUuwhFSWQ-1; Wed, 10 Aug 2022 10:23:37 -0400
X-MC-Unique: NeQE8oGJNa6GrhUuwhFSWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCE8C811E81;
        Wed, 10 Aug 2022 14:23:35 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98EC42026D4C;
        Wed, 10 Aug 2022 14:23:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH] brcmfmac: Add DMI nvram filename quirk for Chuwi Hi8 Pro tablet
Date:   Wed, 10 Aug 2022 16:23:33 +0200
Message-Id: <20220810142333.141044-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Chuwi Hi8 Pro tablet contains quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
"brcmfmac43430a0-sdio.Default string-Default string.txt" as nvram file
which is way too generic.

The Chuwi Hi8 Pro uses the same Ampak AP6212 module as the Chuwi Vi8 Plus
and the nvram for the Vi8 Plus is already in linux-firmware, so point
the new DMI nvram filename quirk to the Vi8 Plus nvram file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/dmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 0af452dca766..86ff174936a9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -24,6 +24,13 @@ static const struct brcmf_dmi_data acepc_t8_data = {
 	BRCM_CC_4345_CHIP_ID, 6, "acepc-t8"
 };
 
+/* The Chuwi Hi8 Pro uses the same Ampak AP6212 module as the Chuwi Vi8 Plus
+ * and the nvram for the Vi8 Plus is already in linux-firmware, so use that.
+ */
+static const struct brcmf_dmi_data chuwi_hi8_pro_data = {
+	BRCM_CC_43430_CHIP_ID, 0, "ilife-S806"
+};
+
 static const struct brcmf_dmi_data gpd_win_pocket_data = {
 	BRCM_CC_4356_CHIP_ID, 2, "gpd-win-pocket"
 };
@@ -75,6 +82,17 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "MRD"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "05/10/2016"),
+		},
+		.driver_data = (void *)&chuwi_hi8_pro_data,
+	},
 	{
 		/* Cyberbook T116 rugged tablet */
 		.matches = {
-- 
2.37.1

