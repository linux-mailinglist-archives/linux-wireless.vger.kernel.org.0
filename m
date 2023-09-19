Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3968B7A64EB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjISN3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjISN3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 09:29:53 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E19F5
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 06:29:45 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5832:0:640:8bcc:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 3A3A241C7B;
        Tue, 19 Sep 2023 16:29:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QTlJnZTDZOs0-qK8imHbu;
        Tue, 19 Sep 2023 16:29:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695130167; bh=PafDetJBrI5cJywRGWSBpWZHsncyYB4HFMw07lLI0O4=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=DUJezDaEbnoIifWDN3uSh7lGWtvNomZbYVOpCIFhIOOrYCJGdNEmu5z0lRk07oyDd
         hclok3KQD1xsFjsloUvkXbcsRMk/jRwBqdAhwF2OYTrD05if3eRb3ivg4dwke9XzT2
         kqL++IBy8VG4+KdZu8isdXcfZ36dZ9uE7KEOikP0=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: mwifiex: followup PCIE and related cleanups
Date:   Tue, 19 Sep 2023 16:28:00 +0300
Message-ID: <20230919132804.73340-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919132804.73340-1-dmantipov@yandex.ru>
References: <20230919132804.73340-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a few more (PCIE and generic interface related)
cleanups which becomes reasonable after the previous patch.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/main.h |  4 +--
 drivers/net/wireless/marvell/mwifiex/pcie.c | 28 +++++----------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 7bdec6c62248..d263eae6078c 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -834,12 +834,12 @@ struct mwifiex_if_ops {
 	void (*cleanup_mpa_buf) (struct mwifiex_adapter *);
 	int (*cmdrsp_complete) (struct mwifiex_adapter *, struct sk_buff *);
 	int (*event_complete) (struct mwifiex_adapter *, struct sk_buff *);
-	int (*init_fw_port) (struct mwifiex_adapter *);
+	void (*init_fw_port)(struct mwifiex_adapter *adapter);
 	int (*dnld_fw) (struct mwifiex_adapter *, struct mwifiex_fw_image *);
 	void (*card_reset) (struct mwifiex_adapter *);
 	int (*reg_dump)(struct mwifiex_adapter *, char *);
 	void (*device_dump)(struct mwifiex_adapter *);
-	int (*clean_pcie_ring) (struct mwifiex_adapter *adapter);
+	void (*clean_pcie_ring)(struct mwifiex_adapter *adapter);
 	void (*iface_work)(struct work_struct *work);
 	void (*submit_rem_rx_urbs)(struct mwifiex_adapter *adapter);
 	void (*deaggr_pkt)(struct mwifiex_adapter *, struct sk_buff *);
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 88f632b9dd93..28b08f4898b1 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -710,18 +710,12 @@ static int mwifiex_pm_wakeup_card_complete(struct mwifiex_adapter *adapter)
  * The host interrupt mask is read, the disable bit is reset and
  * written back to the card host interrupt mask register.
  */
-static int mwifiex_pcie_disable_host_int(struct mwifiex_adapter *adapter)
+static void mwifiex_pcie_disable_host_int(struct mwifiex_adapter *adapter)
 {
 	if (mwifiex_pcie_ok_to_access_hw(adapter))
 		mwifiex_write_reg(adapter, PCIE_HOST_INT_MASK, 0x00000000);
 
 	atomic_set(&adapter->tx_hw_pending, 0);
-	return 0;
-}
-
-static void mwifiex_pcie_disable_host_int_noerr(struct mwifiex_adapter *adapter)
-{
-	WARN_ON(mwifiex_pcie_disable_host_int(adapter));
 }
 
 /*
@@ -1298,7 +1292,7 @@ static int mwifiex_pcie_delete_sleep_cookie_buf(struct mwifiex_adapter *adapter)
  * This function defined as handler is also called while cleaning TXRX
  * during disconnect/ bss stop.
  */
-static int mwifiex_clean_pcie_ring_buf(struct mwifiex_adapter *adapter)
+static void mwifiex_clean_pcie_ring_buf(struct mwifiex_adapter *adapter)
 {
 	struct pcie_service_card *card = adapter->card;
 
@@ -1310,7 +1304,6 @@ static int mwifiex_clean_pcie_ring_buf(struct mwifiex_adapter *adapter)
 		mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
 				  CPU_INTR_DNLD_RDY);
 	}
-	return 0;
 }
 
 /*
@@ -1706,7 +1699,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 /* This function init rx port in firmware which in turn enables to receive data
  * from device before transmitting any packet.
  */
-static int mwifiex_pcie_init_fw_port(struct mwifiex_adapter *adapter)
+static void mwifiex_pcie_init_fw_port(struct mwifiex_adapter *adapter)
 {
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
@@ -1714,8 +1707,6 @@ static int mwifiex_pcie_init_fw_port(struct mwifiex_adapter *adapter)
 
 	/* Write the RX ring read pointer in to reg->rx_rdptr */
 	mwifiex_write_reg(adapter, reg->rx_rdptr, card->rxbd_rdptr | tx_wrap);
-
-	return 0;
 }
 
 /* This function downloads commands to the device
@@ -2001,7 +1992,6 @@ static int mwifiex_pcie_event_complete(struct mwifiex_adapter *adapter,
 {
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
-	int ret = 0;
 	u32 rdptr = card->evtbd_rdptr & MWIFIEX_EVTBD_MASK;
 	u32 wrptr;
 	struct mwifiex_evt_buf_desc *desc;
@@ -2057,9 +2047,7 @@ static int mwifiex_pcie_event_complete(struct mwifiex_adapter *adapter,
 
 	mwifiex_dbg(adapter, EVENT,
 		    "info: Check Events Again\n");
-	ret = mwifiex_pcie_process_event_ready(adapter);
-
-	return ret;
+	return mwifiex_pcie_process_event_ready(adapter);
 }
 
 /* Combo firmware image is a combination of
@@ -2192,11 +2180,7 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 		    "info: Downloading FW image (%d bytes)\n",
 		    firmware_len);
 
-	if (mwifiex_pcie_disable_host_int(adapter)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: Disabling interrupts failed.\n", __func__);
-		return -1;
-	}
+	mwifiex_pcie_disable_host_int(adapter);
 
 	skb = dev_alloc_skb(MWIFIEX_UPLD_SIZE);
 	if (!skb) {
@@ -3265,7 +3249,7 @@ static struct mwifiex_if_ops pcie_ops = {
 	.register_dev =			mwifiex_register_dev,
 	.unregister_dev =		mwifiex_unregister_dev,
 	.enable_int =			mwifiex_pcie_enable_host_int,
-	.disable_int =			mwifiex_pcie_disable_host_int_noerr,
+	.disable_int =			mwifiex_pcie_disable_host_int,
 	.process_int_status =		mwifiex_process_int_status,
 	.host_to_card =			mwifiex_pcie_host_to_card,
 	.wakeup =			mwifiex_pm_wakeup_card,
-- 
2.41.0

