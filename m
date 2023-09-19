Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8E7A64E8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjISN3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjISN3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 09:29:41 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF6F5
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 06:29:29 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5832:0:640:8bcc:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id AB43346CC5;
        Tue, 19 Sep 2023 16:29:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QTlJnZTDZOs0-J5GmdyWw;
        Tue, 19 Sep 2023 16:29:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695130167; bh=4yp2iCShVS3vulN3ZUG+UEzce0JYaxgrASZzsgFA1ao=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=mXJ6xJV5J+HhA50TF7BJWLDUhxkE5VgaLk1WmX6bX/T2lVaTj0BiV3dAOslFqnW/p
         rBEC0LXgR8hYs5nvlWGdeOSh15EPFn+wAUC4EcaOFKvpSWBo4Lm0Y4v8zM6Om/z/PG
         RmHx82iSju96bktmZpu9QKx8BiF0YsoFRCNPnZP0=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: mwifiex: simplify PCIE write operations
Date:   Tue, 19 Sep 2023 16:27:59 +0300
Message-ID: <20230919132804.73340-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
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

Since 'mwifiex_write_reg()' just issues void 'iowrite32()',
convert the former to 'void' and simplify all related users
(with the only exception of 'read_poll_timeout()' which
explicitly requires a non-void function argument).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 290 +++++---------------
 1 file changed, 66 insertions(+), 224 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 6697132ecc97..88f632b9dd93 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -222,12 +222,19 @@ static void mwifiex_unmap_pci_memory(struct mwifiex_adapter *adapter,
 /*
  * This function writes data into PCIE card register.
  */
-static int mwifiex_write_reg(struct mwifiex_adapter *adapter, int reg, u32 data)
+static inline void
+mwifiex_write_reg(struct mwifiex_adapter *adapter, int reg, u32 data)
 {
 	struct pcie_service_card *card = adapter->card;
 
 	iowrite32(data, card->pci_mmap1 + reg);
+}
 
+/* Non-void wrapper needed for read_poll_timeout(). */
+static inline int
+mwifiex_write_reg_rpt(struct mwifiex_adapter *adapter, int reg, u32 data)
+{
+	mwifiex_write_reg(adapter, reg, data);
 	return 0;
 }
 
@@ -658,12 +665,12 @@ static int mwifiex_pm_wakeup_card(struct mwifiex_adapter *adapter)
 	 * appears to ignore or miss our wakeup request, so we continue trying
 	 * until we receive an interrupt from the card.
 	 */
-	if (read_poll_timeout(mwifiex_write_reg, retval,
+	if (read_poll_timeout(mwifiex_write_reg_rpt, retval,
 			      READ_ONCE(adapter->int_status) != 0,
 			      500, 500 * N_WAKEUP_TRIES_SHORT_INTERVAL,
 			      false,
 			      adapter, reg->fw_status, FIRMWARE_READY_PCIE)) {
-		if (read_poll_timeout(mwifiex_write_reg, retval,
+		if (read_poll_timeout(mwifiex_write_reg_rpt, retval,
 				      READ_ONCE(adapter->int_status) != 0,
 				      10000, 10000 * N_WAKEUP_TRIES_LONG_INTERVAL,
 				      false,
@@ -705,14 +712,8 @@ static int mwifiex_pm_wakeup_card_complete(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_disable_host_int(struct mwifiex_adapter *adapter)
 {
-	if (mwifiex_pcie_ok_to_access_hw(adapter)) {
-		if (mwifiex_write_reg(adapter, PCIE_HOST_INT_MASK,
-				      0x00000000)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "Disable host interrupt failed\n");
-			return -1;
-		}
-	}
+	if (mwifiex_pcie_ok_to_access_hw(adapter))
+		mwifiex_write_reg(adapter, PCIE_HOST_INT_MASK, 0x00000000);
 
 	atomic_set(&adapter->tx_hw_pending, 0);
 	return 0;
@@ -731,15 +732,9 @@ static void mwifiex_pcie_disable_host_int_noerr(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_enable_host_int(struct mwifiex_adapter *adapter)
 {
-	if (mwifiex_pcie_ok_to_access_hw(adapter)) {
+	if (mwifiex_pcie_ok_to_access_hw(adapter))
 		/* Simply write the mask to the register */
-		if (mwifiex_write_reg(adapter, PCIE_HOST_INT_MASK,
-				      HOST_INTR_MASK)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "Enable host interrupt failed\n");
-			return -1;
-		}
-	}
+		mwifiex_write_reg(adapter, PCIE_HOST_INT_MASK, HOST_INTR_MASK);
 
 	return 0;
 }
@@ -1312,12 +1307,8 @@ static int mwifiex_clean_pcie_ring_buf(struct mwifiex_adapter *adapter)
 		/* write pointer already set at last send
 		 * send dnld-rdy intr again, wait for completion.
 		 */
-		if (mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
-				      CPU_INTR_DNLD_RDY)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "failed to assert dnld-rdy interrupt.\n");
-			return -1;
-		}
+		mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
+				  CPU_INTR_DNLD_RDY);
 	}
 	return 0;
 }
@@ -1429,7 +1420,6 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 	u32 wrindx, num_tx_buffs, rx_val;
-	int ret;
 	dma_addr_t buf_pa;
 	struct mwifiex_pcie_buf_desc *desc = NULL;
 	struct mwifiex_pfu_buf_desc *desc2 = NULL;
@@ -1498,13 +1488,8 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 
 		rx_val = card->rxbd_rdptr & reg->rx_wrap_mask;
 		/* Write the TX ring write pointer in to reg->tx_wrptr */
-		if (mwifiex_write_reg(adapter, reg->tx_wrptr,
-				      card->txbd_wrptr | rx_val)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "SEND DATA: failed to write reg->tx_wrptr\n");
-			ret = -1;
-			goto done_unmap;
-		}
+		mwifiex_write_reg(adapter, reg->tx_wrptr,
+				  card->txbd_wrptr | rx_val);
 
 		/* The firmware (latest version 15.68.19.p21) of the 88W8897 PCIe+USB card
 		 * seems to crash randomly after setting the TX ring write pointer when
@@ -1521,13 +1506,8 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 			adapter->data_sent = false;
 		} else {
 			/* Send the TX ready interrupt */
-			if (mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
-					      CPU_INTR_DNLD_RDY)) {
-				mwifiex_dbg(adapter, ERROR,
-					    "SEND DATA: failed to assert dnld-rdy interrupt.\n");
-				ret = -1;
-				goto done_unmap;
-			}
+			mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
+					  CPU_INTR_DNLD_RDY);
 		}
 		mwifiex_dbg(adapter, DATA,
 			    "info: SEND DATA: Updated <Rd: %#x, Wr:\t"
@@ -1538,24 +1518,12 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 			    "info: TX Ring full, can't send packets to fw\n");
 		adapter->data_sent = true;
 		/* Send the TX ready interrupt */
-		if (mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
-				      CPU_INTR_DNLD_RDY))
-			mwifiex_dbg(adapter, ERROR,
-				    "SEND DATA: failed to assert door-bell intr\n");
+		mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
+				  CPU_INTR_DNLD_RDY);
 		return -EBUSY;
 	}
 
 	return -EINPROGRESS;
-done_unmap:
-	mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
-	card->tx_buf_list[wrindx] = NULL;
-	atomic_dec(&adapter->tx_hw_pending);
-	if (reg->pfu_enabled)
-		memset(desc2, 0, sizeof(*desc2));
-	else
-		memset(desc, 0, sizeof(*desc));
-
-	return ret;
 }
 
 /*
@@ -1675,13 +1643,8 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 
 		tx_val = card->txbd_wrptr & reg->tx_wrap_mask;
 		/* Write the RX ring read pointer in to reg->rx_rdptr */
-		if (mwifiex_write_reg(adapter, reg->rx_rdptr,
-				      card->rxbd_rdptr | tx_val)) {
-			mwifiex_dbg(adapter, DATA,
-				    "RECV DATA: failed to write reg->rx_rdptr\n");
-			ret = -1;
-			goto done;
-		}
+		mwifiex_write_reg(adapter, reg->rx_rdptr,
+				  card->rxbd_rdptr | tx_val);
 
 		/* Read the RX ring Write pointer set by firmware */
 		if (mwifiex_read_reg(adapter, reg->rx_wrptr, &wrptr)) {
@@ -1724,43 +1687,18 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 	/* Write the lower 32bits of the physical address to low command
 	 * address scratch register
 	 */
-	if (mwifiex_write_reg(adapter, reg->cmd_addr_lo, (u32)buf_pa)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: failed to write download command to boot code.\n",
-			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
-		return -1;
-	}
+	mwifiex_write_reg(adapter, reg->cmd_addr_lo, (u32)buf_pa);
 
 	/* Write the upper 32bits of the physical address to high command
 	 * address scratch register
 	 */
-	if (mwifiex_write_reg(adapter, reg->cmd_addr_hi,
-			      (u32)((u64)buf_pa >> 32))) {
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: failed to write download command to boot code.\n",
-			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
-		return -1;
-	}
+	mwifiex_write_reg(adapter, reg->cmd_addr_hi, (u32)((u64)buf_pa >> 32));
 
 	/* Write the command length to cmd_size scratch register */
-	if (mwifiex_write_reg(adapter, reg->cmd_size, skb->len)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: failed to write command len to cmd_size scratch reg\n",
-			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
-		return -1;
-	}
+	mwifiex_write_reg(adapter, reg->cmd_size, skb->len);
 
 	/* Ring the door bell */
-	if (mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
-			      CPU_INTR_DOOR_BELL)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: failed to assert door-bell intr\n", __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
-		return -1;
-	}
+	mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT, CPU_INTR_DOOR_BELL);
 
 	return 0;
 }
@@ -1775,12 +1713,8 @@ static int mwifiex_pcie_init_fw_port(struct mwifiex_adapter *adapter)
 	int tx_wrap = card->txbd_wrptr & reg->tx_wrap_mask;
 
 	/* Write the RX ring read pointer in to reg->rx_rdptr */
-	if (mwifiex_write_reg(adapter, reg->rx_rdptr, card->rxbd_rdptr |
-			      tx_wrap)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "RECV DATA: failed to write reg->rx_rdptr\n");
-		return -1;
-	}
+	mwifiex_write_reg(adapter, reg->rx_rdptr, card->rxbd_rdptr | tx_wrap);
+
 	return 0;
 }
 
@@ -1791,7 +1725,6 @@ mwifiex_pcie_send_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 {
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
-	int ret = 0;
 	dma_addr_t cmd_buf_pa, cmdrsp_buf_pa;
 	u8 *payload = (u8 *)skb->data;
 
@@ -1841,63 +1774,29 @@ mwifiex_pcie_send_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		cmdrsp_buf_pa = MWIFIEX_SKB_DMA_ADDR(card->cmdrsp_buf);
 		/* Write the lower 32bits of the cmdrsp buffer physical
 		   address */
-		if (mwifiex_write_reg(adapter, reg->cmdrsp_addr_lo,
-				      (u32)cmdrsp_buf_pa)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "Failed to write download cmd to boot code.\n");
-			ret = -1;
-			goto done;
-		}
+		mwifiex_write_reg(adapter, reg->cmdrsp_addr_lo,
+				  (u32)cmdrsp_buf_pa);
+
 		/* Write the upper 32bits of the cmdrsp buffer physical
 		   address */
-		if (mwifiex_write_reg(adapter, reg->cmdrsp_addr_hi,
-				      (u32)((u64)cmdrsp_buf_pa >> 32))) {
-			mwifiex_dbg(adapter, ERROR,
-				    "Failed to write download cmd to boot code.\n");
-			ret = -1;
-			goto done;
-		}
+		mwifiex_write_reg(adapter, reg->cmdrsp_addr_hi,
+				  (u32)((u64)cmdrsp_buf_pa >> 32));
 	}
 
 	cmd_buf_pa = MWIFIEX_SKB_DMA_ADDR(card->cmd_buf);
+
 	/* Write the lower 32bits of the physical address to reg->cmd_addr_lo */
-	if (mwifiex_write_reg(adapter, reg->cmd_addr_lo,
-			      (u32)cmd_buf_pa)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Failed to write download cmd to boot code.\n");
-		ret = -1;
-		goto done;
-	}
+	mwifiex_write_reg(adapter, reg->cmd_addr_lo, (u32)cmd_buf_pa);
+
 	/* Write the upper 32bits of the physical address to reg->cmd_addr_hi */
-	if (mwifiex_write_reg(adapter, reg->cmd_addr_hi,
-			      (u32)((u64)cmd_buf_pa >> 32))) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Failed to write download cmd to boot code.\n");
-		ret = -1;
-		goto done;
-	}
+	mwifiex_write_reg(adapter, reg->cmd_addr_hi,
+			  (u32)((u64)cmd_buf_pa >> 32));
 
 	/* Write the command length to reg->cmd_size */
-	if (mwifiex_write_reg(adapter, reg->cmd_size,
-			      card->cmd_buf->len)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Failed to write cmd len to reg->cmd_size\n");
-		ret = -1;
-		goto done;
-	}
+	mwifiex_write_reg(adapter, reg->cmd_size, card->cmd_buf->len);
 
 	/* Ring the door bell */
-	if (mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
-			      CPU_INTR_DOOR_BELL)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Failed to assert door-bell intr\n");
-		ret = -1;
-		goto done;
-	}
-
-done:
-	if (ret)
-		adapter->cmd_sent = false;
+	mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT, CPU_INTR_DOOR_BELL);
 
 	return 0;
 }
@@ -1941,13 +1840,9 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 						   MWIFIEX_SKB_DMA_ADDR(skb),
 						   MWIFIEX_SLEEP_COOKIE_SIZE,
 						   DMA_FROM_DEVICE);
-			if (mwifiex_write_reg(adapter,
-					      PCIE_CPU_INT_EVENT,
-					      CPU_INTR_SLEEP_CFM_DONE)) {
-				mwifiex_dbg(adapter, ERROR,
-					    "Write register failed\n");
-				return -1;
-			}
+			mwifiex_write_reg(adapter,
+					  PCIE_CPU_INT_EVENT,
+					  CPU_INTR_SLEEP_CFM_DONE);
 			mwifiex_delay_for_sleep_cookie(adapter,
 						       MWIFIEX_MAX_DELAY_COUNT);
 			mwifiex_unmap_pci_memory(adapter, skb,
@@ -1980,18 +1875,11 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 		/* Clear the cmd-rsp buffer address in scratch registers. This
 		   will prevent firmware from writing to the same response
 		   buffer again. */
-		if (mwifiex_write_reg(adapter, reg->cmdrsp_addr_lo, 0)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cmd_done: failed to clear cmd_rsp_addr_lo\n");
-			return -1;
-		}
+		mwifiex_write_reg(adapter, reg->cmdrsp_addr_lo, 0);
+
 		/* Write the upper 32bits of the cmdrsp buffer physical
 		   address */
-		if (mwifiex_write_reg(adapter, reg->cmdrsp_addr_hi, 0)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cmd_done: failed to clear cmd_rsp_addr_hi\n");
-			return -1;
-		}
+		mwifiex_write_reg(adapter, reg->cmdrsp_addr_hi, 0);
 	}
 
 	return 0;
@@ -2098,12 +1986,8 @@ static int mwifiex_pcie_process_event_ready(struct mwifiex_adapter *adapter)
 		   we need to find a better method of managing these buffers.
 		*/
 	} else {
-		if (mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
-				      CPU_INTR_EVENT_DONE)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "Write register failed\n");
-			return -1;
-		}
+		mwifiex_write_reg(adapter, PCIE_CPU_INT_EVENT,
+				  CPU_INTR_EVENT_DONE);
 	}
 
 	return 0;
@@ -2169,12 +2053,7 @@ static int mwifiex_pcie_event_complete(struct mwifiex_adapter *adapter,
 		    card->evtbd_rdptr, wrptr);
 
 	/* Write the event ring read pointer in to reg->evt_rdptr */
-	if (mwifiex_write_reg(adapter, reg->evt_rdptr,
-			      card->evtbd_rdptr)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "event_complete: failed to read reg->evt_rdptr\n");
-		return -1;
-	}
+	mwifiex_write_reg(adapter, reg->evt_rdptr, card->evtbd_rdptr);
 
 	mwifiex_dbg(adapter, EVENT,
 		    "info: Check Events Again\n");
@@ -2471,21 +2350,12 @@ mwifiex_check_fw_status(struct mwifiex_adapter *adapter, u32 poll_num)
 	u32 tries;
 
 	/* Mask spurios interrupts */
-	if (mwifiex_write_reg(adapter, PCIE_HOST_INT_STATUS_MASK,
-			      HOST_INTR_MASK)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Write register failed\n");
-		return -1;
-	}
+	mwifiex_write_reg(adapter, PCIE_HOST_INT_STATUS_MASK, HOST_INTR_MASK);
 
 	mwifiex_dbg(adapter, INFO,
 		    "Setting driver ready signature\n");
-	if (mwifiex_write_reg(adapter, reg->drv_rdy,
-			      FIRMWARE_READY_PCIE)) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Failed to write driver ready signature\n");
-		return -1;
-	}
+
+	mwifiex_write_reg(adapter, reg->drv_rdy, FIRMWARE_READY_PCIE);
 
 	/* Wait for firmware initialization event */
 	for (tries = 0; tries < poll_num; tries++) {
@@ -2571,12 +2441,7 @@ static void mwifiex_interrupt_status(struct mwifiex_adapter *adapter,
 		mwifiex_pcie_disable_host_int(adapter);
 
 		/* Clear the pending interrupts */
-		if (mwifiex_write_reg(adapter, PCIE_HOST_INT_STATUS,
-				      ~pcie_ireg)) {
-			mwifiex_dbg(adapter, ERROR,
-				    "Write register failed\n");
-			return;
-		}
+		mwifiex_write_reg(adapter, PCIE_HOST_INT_STATUS, ~pcie_ireg);
 	}
 
 	if (!adapter->pps_uapsd_mode &&
@@ -2671,13 +2536,9 @@ static int mwifiex_process_int_status(struct mwifiex_adapter *adapter)
 			}
 
 			if ((pcie_ireg != 0xFFFFFFFF) && (pcie_ireg)) {
-				if (mwifiex_write_reg(adapter,
-						      PCIE_HOST_INT_STATUS,
-						      ~pcie_ireg)) {
-					mwifiex_dbg(adapter, ERROR,
-						    "Write register failed\n");
-					return -1;
-				}
+				mwifiex_write_reg(adapter,
+						  PCIE_HOST_INT_STATUS,
+						  ~pcie_ireg);
 				if (!adapter->pps_uapsd_mode &&
 				    adapter->ps_state == PS_STATE_SLEEP) {
 					adapter->ps_state = PS_STATE_AWAKE;
@@ -2801,7 +2662,7 @@ mwifiex_pcie_reg_dump(struct mwifiex_adapter *adapter, char *drv_buf)
 static enum rdwr_status
 mwifiex_pcie_rdwr_firmware(struct mwifiex_adapter *adapter, u8 doneflag)
 {
-	int ret, tries;
+	int tries;
 	u8 ctrl_data;
 	u32 fw_status;
 	struct pcie_service_card *card = adapter->card;
@@ -2810,13 +2671,7 @@ mwifiex_pcie_rdwr_firmware(struct mwifiex_adapter *adapter, u8 doneflag)
 	if (mwifiex_read_reg(adapter, reg->fw_status, &fw_status))
 		return RDWR_STATUS_FAILURE;
 
-	ret = mwifiex_write_reg(adapter, reg->fw_dump_ctrl,
-				reg->fw_dump_host_ready);
-	if (ret) {
-		mwifiex_dbg(adapter, ERROR,
-			    "PCIE write err\n");
-		return RDWR_STATUS_FAILURE;
-	}
+	mwifiex_write_reg(adapter, reg->fw_dump_ctrl, reg->fw_dump_host_ready);
 
 	for (tries = 0; tries < MAX_POLL_TRIES; tries++) {
 		mwifiex_read_reg_byte(adapter, reg->fw_dump_ctrl, &ctrl_data);
@@ -2827,13 +2682,8 @@ mwifiex_pcie_rdwr_firmware(struct mwifiex_adapter *adapter, u8 doneflag)
 		if (ctrl_data != reg->fw_dump_host_ready) {
 			mwifiex_dbg(adapter, WARN,
 				    "The ctrl reg was changed, re-try again!\n");
-			ret = mwifiex_write_reg(adapter, reg->fw_dump_ctrl,
-						reg->fw_dump_host_ready);
-			if (ret) {
-				mwifiex_dbg(adapter, ERROR,
-					    "PCIE write err\n");
-				return RDWR_STATUS_FAILURE;
-			}
+			mwifiex_write_reg(adapter, reg->fw_dump_ctrl,
+					  reg->fw_dump_host_ready);
 		}
 		usleep_range(100, 200);
 	}
@@ -2852,7 +2702,6 @@ static void mwifiex_pcie_fw_dump(struct mwifiex_adapter *adapter)
 	u8 idx, i, read_reg, doneflag = 0;
 	enum rdwr_status stat;
 	u32 memory_size;
-	int ret;
 
 	if (!card->pcie.can_dump_fw)
 		return;
@@ -2906,12 +2755,8 @@ static void mwifiex_pcie_fw_dump(struct mwifiex_adapter *adapter)
 
 		if (memory_size == 0) {
 			mwifiex_dbg(adapter, MSG, "Firmware dump Finished!\n");
-			ret = mwifiex_write_reg(adapter, creg->fw_dump_ctrl,
-						creg->fw_dump_read_done);
-			if (ret) {
-				mwifiex_dbg(adapter, ERROR, "PCIE write err\n");
-				return;
-			}
+			mwifiex_write_reg(adapter, creg->fw_dump_ctrl,
+					  creg->fw_dump_read_done);
 			break;
 		}
 
@@ -3197,9 +3042,7 @@ static void mwifiex_cleanup_pcie(struct mwifiex_adapter *adapter)
 	if (fw_status == FIRMWARE_READY_PCIE) {
 		mwifiex_dbg(adapter, INFO,
 			    "Clearing driver ready signature\n");
-		if (mwifiex_write_reg(adapter, reg->drv_rdy, 0x00000000))
-			mwifiex_dbg(adapter, ERROR,
-				    "Failed to write driver not-ready signature\n");
+		mwifiex_write_reg(adapter, reg->drv_rdy, 0x00000000);
 	}
 
 	pci_disable_device(pdev);
@@ -3404,8 +3247,7 @@ static void mwifiex_pcie_down_dev(struct mwifiex_adapter *adapter)
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 	struct pci_dev *pdev = card->dev;
 
-	if (mwifiex_write_reg(adapter, reg->drv_rdy, 0x00000000))
-		mwifiex_dbg(adapter, ERROR, "Failed to write driver not-ready signature\n");
+	mwifiex_write_reg(adapter, reg->drv_rdy, 0x00000000);
 
 	pci_clear_master(pdev);
 
-- 
2.41.0

