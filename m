Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83916AA460
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 23:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjCCWbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 17:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjCCWbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 17:31:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D268A17145
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677882225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7mc4+fqbe3RrRLGBEBiPcnW0lYnOHGFeDqJS6xci69U=;
        b=QASXzI9uG+plZ0R2kg7kmQxqdTLoRsxXzdrBCqrX05jA+GNrkjTvgzP1LjO80zoCtIdKk4
        AvhDKx9idmB7EYHlyohHCz0OUi+yXrqP1l/O/m0IZjbBFRbZtDWajK+fU/aTOScA5Njncd
        JMB2DYoCSJAZ1ylQp/yyGfsxXWxtBXY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-7PRC6E22Ptq0779EheZYJQ-1; Fri, 03 Mar 2023 17:23:42 -0500
X-MC-Unique: 7PRC6E22Ptq0779EheZYJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9294E29ABA04;
        Fri,  3 Mar 2023 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 724221121315;
        Fri,  3 Mar 2023 22:23:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH] wifi: brcmfmac: Use ISO3166 country code and rev 0 as fallback on 4356
Date:   Fri,  3 Mar 2023 23:23:31 +0100
Message-Id: <20230303222331.285663-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Many devices ship with a nvram ccode value of X2/XT/XU/XV/ALL which are
all special world-wide compatibility ccode-s. Most of these world-wide
ccode-s allow passive scan mode only for 2.4GHz channels 12-14,
only enabling them when an AP is seen on them.

Since linux-firmware has moved to the new cyfmac4356-pci.bin +
cyfmac4356-pci.clm_blob firmware files this no longer works and
4356 devices using e.g. an X2 ccode fail to connect to an AP on
channel 13.

Add the 4356 chip-id to the list of chips for which to use the ISO3166
country code + rev 0 as fallback in brcmf_translate_country_code() to
fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b115902eb475..5b9bb4d07c2a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7763,6 +7763,7 @@ static bool brmcf_use_iso3166_ccode_fallback(struct brcmf_pub *drvr)
 	switch (drvr->bus_if->chip) {
 	case BRCM_CC_43430_CHIP_ID:
 	case BRCM_CC_4345_CHIP_ID:
+	case BRCM_CC_4356_CHIP_ID:
 	case BRCM_CC_43602_CHIP_ID:
 		return true;
 	default:
-- 
2.39.1

