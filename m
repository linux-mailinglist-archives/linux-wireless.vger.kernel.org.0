Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFE258EE34
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiHJOXn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiHJOXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 10:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B852D12755
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660141418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NN8mGs9CVjPhlyEkk12AePnxmaCw3LzKZ48WcNkXywM=;
        b=WOctxfcIYYStSRVz5F+9IDuozEZPeSX8AgpGuGmXTGkaxrkjFuLCIUDIxMH7IzieqnUzfT
        9UCWV22QMsMh/jAEcDhSSetlaZKh7gKsy2lk0/EMMxNo3iU6p6gK+gnqL/EQWRhGEgbUL+
        p+EMWjlqroNFfU0oltwSKdFhQ8Bn38I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-sUTKTEecMFeMkzZ8_mfXKA-1; Wed, 10 Aug 2022 10:23:35 -0400
X-MC-Unique: sUTKTEecMFeMkzZ8_mfXKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F8FA1C0BC67;
        Wed, 10 Aug 2022 14:23:30 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 361AF40679C0;
        Wed, 10 Aug 2022 14:23:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH] brcmfmac: Use ISO3166 country code and rev 0 as fallback on 43430
Date:   Wed, 10 Aug 2022 16:23:28 +0200
Message-Id: <20220810142328.141030-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Since linux-firmware has moved to the new cyfmac43430-sdio.bin +
cyfmac43430-sdio.clm_blob firmware files this no longer works and
43430 devices using e.g. an X2 ccode fail to connect to an AP on
channel 13.

Add the 43430 chip-id to the list of chips for which to use the ISO3166
country code + rev 0 as fallback in brcmf_translate_country_code() to
fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 605206abe424..5fe075fc22af 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7480,6 +7480,7 @@ int brcmf_cfg80211_wait_vif_event(struct brcmf_cfg80211_info *cfg,
 static bool brmcf_use_iso3166_ccode_fallback(struct brcmf_pub *drvr)
 {
 	switch (drvr->bus_if->chip) {
+	case BRCM_CC_43430_CHIP_ID:
 	case BRCM_CC_4345_CHIP_ID:
 	case BRCM_CC_43602_CHIP_ID:
 		return true;
-- 
2.37.1

