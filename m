Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E356BAE7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 15:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiGHNce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiGHNcd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 09:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6635C3057B
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657287151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xFmf3sfHdPk2cWGRZ8uPYle4j74mEPX+axZeRg0eW3A=;
        b=MO0YNRbCV4mjZPtL3hsqUso7cmEV03HDa7BfuG2J3VYDKxuC/cruvU3TR1S8LS2ef61j87
        aSpJDHmHzR+/SztfrJE5cBASm6WeuiLBEG6DQXmYINZHYKXi78P4OXCQ73uBeA+bCLq1Aq
        5utTCXRahFlODi+BunZoj0tfcFvfy1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-Hhfa7VjrPbyJGgEOP6ST3g-1; Fri, 08 Jul 2022 09:32:27 -0400
X-MC-Unique: Hhfa7VjrPbyJGgEOP6ST3g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CDC01019C89;
        Fri,  8 Jul 2022 13:32:26 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47D6D492C3B;
        Fri,  8 Jul 2022 13:32:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH 2/2] brcmfmac: Replace default (not configured) MAC with a random MAC
Date:   Fri,  8 Jul 2022 15:32:23 +0200
Message-Id: <20220708133223.101558-2-hdegoede@redhat.com>
In-Reply-To: <20220708133223.101558-1-hdegoede@redhat.com>
References: <20220708133223.101558-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On some boards there is no eeprom to hold the nvram, in this case instead
a board specific nvram is loaded from /lib/firmware. On most boards the
macaddr=... setting in the /lib/firmware nvram file is ignored because
the wifi/bt chip has a unique MAC programmed into the chip itself.

But in some cases the actual MAC from the /lib/firmware nvram file gets
used, leading to MAC conflicts.

The MAC addresses in the troublesome nvram files seem to all come from
the same nvram file template, so we can detect this by checking for
the template nvram file MAC.

Detect that the default MAC address is being used and replace it
with a random MAC address to avoid MAC address conflicts.

Note that udev will detect this is a random MAC based on
/sys/class/net/wlan0/addr_assign_type and then replace this with
a MAC based on hashing the netdev-name + the machine-id. So that
the MAC address is both guaranteed to be unique per machine while
it is still the same/persistent at each boot (assuming the
default Link.MACAddressPolicy=persistent udev setting).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../broadcom/brcm80211/brcmfmac/common.c      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index dccd8f4ca1d0..7485e784be2a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -201,6 +201,20 @@ int brcmf_c_set_cur_etheraddr(struct brcmf_if *ifp, const u8 *addr)
 	return err;
 }
 
+/* On some boards there is no eeprom to hold the nvram, in this case instead
+ * a board specific nvram is loaded from /lib/firmware. On most boards the
+ * macaddr setting in the /lib/firmware nvram file is ignored because the
+ * wifibt chip has a unique MAC programmed into the chip itself.
+ * But in some cases the actual MAC from the /lib/firmware nvram file gets
+ * used, leading to MAC conflicts.
+ * The MAC addresses in the troublesome nvram files seem to all come from
+ * the same nvram file template, so we only need to check for 1 known
+ * address to detect this.
+ */
+static const u8 brcmf_default_mac_address[ETH_ALEN] = {
+	0x00, 0x90, 0x4c, 0xc5, 0x12, 0x38
+};
+
 int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
@@ -226,6 +240,15 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 			bphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
 			goto done;
 		}
+
+		if (ether_addr_equal_unaligned(ifp->mac_addr, brcmf_default_mac_address)) {
+			bphy_err(drvr, "Default MAC is used, replacing with random MAC to avoid conflicts\n");
+			eth_random_addr(ifp->mac_addr);
+			ifp->ndev->addr_assign_type = NET_ADDR_RANDOM;
+			err = brcmf_c_set_cur_etheraddr(ifp, ifp->mac_addr);
+			if (err < 0)
+				goto done;
+		}
 	}
 
 	memcpy(ifp->drvr->mac, ifp->mac_addr, sizeof(ifp->drvr->mac));
-- 
2.36.0

