Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5456BAE2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiGHNce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiGHNcb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 09:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E711B2F390
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657287149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fiqEigVON0EX2+Io7XzvpJmaokF5cBbC+Hrru1BMVcY=;
        b=LnFFjRMMf1Sj8MGBvLLbYSYqx+OzeKXfxj3DCJsh4hkmK4n7e0T3MZmE3K3xFDgB2080kd
        y6xyUlC0DcC71tVbKVpJNHpupkthIpFKp+aa+GWB8pOBEgUz+imldzrFHp8hNbTxrUiMZr
        FAr7hXtACScBpA/Ju19LFq9MAZHZ2WM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-_CLE_gbxPRqeLEAp4ucytA-1; Fri, 08 Jul 2022 09:32:25 -0400
X-MC-Unique: _CLE_gbxPRqeLEAp4ucytA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13AC91019C89;
        Fri,  8 Jul 2022 13:32:25 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBC9E492C3B;
        Fri,  8 Jul 2022 13:32:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH 1/2] brcmfmac: Add brcmf_c_set_cur_etheraddr() helper
Date:   Fri,  8 Jul 2022 15:32:22 +0200
Message-Id: <20220708133223.101558-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a little helper to send "cur_etheraddr" commands to the interface
and to handle the error reporting of it in a single place.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../broadcom/brcm80211/brcmfmac/common.c       | 18 +++++++++++++-----
 .../broadcom/brcm80211/brcmfmac/common.h       |  1 +
 .../broadcom/brcm80211/brcmfmac/core.c         |  8 ++------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index fe01da9e620d..dccd8f4ca1d0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -190,6 +190,17 @@ static int brcmf_c_process_clm_blob(struct brcmf_if *ifp)
 	return err;
 }
 
+int brcmf_c_set_cur_etheraddr(struct brcmf_if *ifp, const u8 *addr)
+{
+	s32 err;
+
+	err = brcmf_fil_iovar_data_set(ifp, "cur_etheraddr", addr, ETH_ALEN);
+	if (err < 0)
+		bphy_err(ifp->drvr, "Setting cur_etheraddr failed, %d\n", err);
+
+	return err;
+}
+
 int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
@@ -204,12 +215,9 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 
 	if (is_valid_ether_addr(ifp->mac_addr)) {
 		/* set mac address */
-		err = brcmf_fil_iovar_data_set(ifp, "cur_etheraddr", ifp->mac_addr,
-					       ETH_ALEN);
-		if (err < 0) {
-			bphy_err(ifp->drvr, "Setting cur_etheraddr failed, %d\n", err);
+		err = brcmf_c_set_cur_etheraddr(ifp, ifp->mac_addr);
+		if (err < 0)
 			goto done;
-		}
 	} else {
 		/* retrieve mac address */
 		err = brcmf_fil_iovar_data_get(ifp, "cur_etheraddr", ifp->mac_addr,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 15accc88d5c0..7329eb751945 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -65,6 +65,7 @@ void brcmf_release_module_param(struct brcmf_mp_device *module_param);
 
 /* Sets dongle media info (drv_version, mac address). */
 int brcmf_c_preinit_dcmds(struct brcmf_if *ifp);
+int brcmf_c_set_cur_etheraddr(struct brcmf_if *ifp, const u8 *addr);
 
 #ifdef CONFIG_DMI
 void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 87aef211b35f..bd164a0821f9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -233,16 +233,12 @@ static int brcmf_netdev_set_mac_address(struct net_device *ndev, void *addr)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct sockaddr *sa = (struct sockaddr *)addr;
-	struct brcmf_pub *drvr = ifp->drvr;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
 
-	err = brcmf_fil_iovar_data_set(ifp, "cur_etheraddr", sa->sa_data,
-				       ETH_ALEN);
-	if (err < 0) {
-		bphy_err(drvr, "Setting cur_etheraddr failed, %d\n", err);
-	} else {
+	err = brcmf_c_set_cur_etheraddr(ifp, sa->sa_data);
+	if (err >= 0) {
 		brcmf_dbg(TRACE, "updated to %pM\n", sa->sa_data);
 		memcpy(ifp->mac_addr, sa->sa_data, ETH_ALEN);
 		eth_hw_addr_set(ifp->ndev, ifp->mac_addr);
-- 
2.36.0

