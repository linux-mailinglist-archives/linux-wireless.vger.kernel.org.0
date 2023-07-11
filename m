Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15FF74F017
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjGKN3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGKN3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 09:29:17 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3AAE77
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 06:29:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3922:0:640:7af7:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id D41AE60034;
        Tue, 11 Jul 2023 16:29:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8TZOrUgWlqM0-zhFRwTC0;
        Tue, 11 Jul 2023 16:29:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689082149;
        bh=+R3xNct0BbU6sWtdyx97XJ911yLAQrPJ7LG8jmcnBj8=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=nqbxROciNAkBrMwqNLPa5NZmQyuNa/kjZo3aXjIrUtmx68JvACYSfGe9O5s27fS+q
         RGpeIHYMvEOEpH/v+qos17ef8Hshlu8si8Jwtc40RznSjSOnIv2nFvsPp94Ypi9yBb
         qmhEzhaN6uQd2WNGRt3tV5HAWqIUZUxDVpoiU8N0=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: unify PCI and SNOC interfaces to CE pipes
Date:   Tue, 11 Jul 2023 16:28:26 +0300
Message-ID: <20230711132850.116267-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unify 'struct ath10k_snoc_pipe' and 'struct ath10k_pci_pipe'
into (smaller and simpler) 'struct ath10k_pipe', drop relevant
leftovers and adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/ce.h   | 12 ++++++
 drivers/net/wireless/ath/ath10k/pci.c  | 51 +++++++++++---------------
 drivers/net/wireless/ath/ath10k/pci.h  | 19 +---------
 drivers/net/wireless/ath/ath10k/snoc.c | 43 +++++++++-------------
 drivers/net/wireless/ath/ath10k/snoc.h | 12 +-----
 5 files changed, 52 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 666ce384a1d8..8a32dfaf2a61 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -130,6 +130,18 @@ struct ath10k_ce_pipe {
 	const struct ath10k_ce_ops *ops;
 };
 
+/* Per-pipe state used in both PCI and SNOC interfaces. */
+struct ath10k_pipe {
+	/* Handle of an underlying Copy Engine. */
+	struct ath10k_ce_pipe *ce_hdl;
+
+	/* Index of this pipe in pipe_info arrays. */
+	u8 pipe_num;
+
+	/* Pipe buffer size. */
+	size_t buf_sz;
+};
+
 /* Copy Engine settable attributes */
 struct ce_attr;
 
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a7f44f6335fb..910aae83ae1d 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -761,11 +761,11 @@ static inline const char *ath10k_pci_get_irq_method(struct ath10k *ar)
 	return "legacy";
 }
 
-static int __ath10k_pci_rx_post_buf(struct ath10k_pci_pipe *pipe)
+static int __ath10k_pci_rx_post_buf(struct ath10k_pipe *pipe)
 {
-	struct ath10k *ar = pipe->hif_ce_state;
-	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_pipe = pipe->ce_hdl;
+	struct ath10k *ar = ce_pipe->ar;
+	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct sk_buff *skb;
 	dma_addr_t paddr;
 	int ret;
@@ -800,12 +800,12 @@ static int __ath10k_pci_rx_post_buf(struct ath10k_pci_pipe *pipe)
 	return 0;
 }
 
-static void ath10k_pci_rx_post_pipe(struct ath10k_pci_pipe *pipe)
+static void ath10k_pci_rx_post_pipe(struct ath10k_pipe *pipe)
 {
-	struct ath10k *ar = pipe->hif_ce_state;
+	struct ath10k_ce_pipe *ce_pipe = pipe->ce_hdl;
+	struct ath10k *ar = ce_pipe->ar;
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
-	struct ath10k_ce_pipe *ce_pipe = pipe->ce_hdl;
 	int ret, num;
 
 	if (pipe->buf_sz == 0)
@@ -1193,7 +1193,7 @@ static void ath10k_pci_process_rx_cb(struct ath10k_ce_pipe *ce_state,
 {
 	struct ath10k *ar = ce_state->ar;
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
-	struct ath10k_pci_pipe *pipe_info =  &ar_pci->pipe_info[ce_state->id];
+	struct ath10k_pipe *pipe_info =  &ar_pci->pipe_info[ce_state->id];
 	struct sk_buff *skb;
 	struct sk_buff_head list;
 	void *transfer_context;
@@ -1236,7 +1236,7 @@ static void ath10k_pci_process_htt_rx_cb(struct ath10k_ce_pipe *ce_state,
 {
 	struct ath10k *ar = ce_state->ar;
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
-	struct ath10k_pci_pipe *pipe_info =  &ar_pci->pipe_info[ce_state->id];
+	struct ath10k_pipe *pipe_info =  &ar_pci->pipe_info[ce_state->id];
 	struct ath10k_ce_pipe *ce_pipe = pipe_info->ce_hdl;
 	struct sk_buff *skb;
 	struct sk_buff_head list;
@@ -1351,7 +1351,7 @@ int ath10k_pci_hif_tx_sg(struct ath10k *ar, u8 pipe_id,
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
-	struct ath10k_pci_pipe *pci_pipe = &ar_pci->pipe_info[pipe_id];
+	struct ath10k_pipe *pci_pipe = &ar_pci->pipe_info[pipe_id];
 	struct ath10k_ce_pipe *ce_pipe = pci_pipe->ce_hdl;
 	struct ath10k_ce_ring *src_ring = ce_pipe->src_ring;
 	unsigned int nentries_mask;
@@ -1969,18 +1969,14 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
 	return 0;
 }
 
-static void ath10k_pci_rx_pipe_cleanup(struct ath10k_pci_pipe *pci_pipe)
+static void ath10k_pci_rx_pipe_cleanup(struct ath10k_pipe *pci_pipe)
 {
-	struct ath10k *ar;
-	struct ath10k_ce_pipe *ce_pipe;
-	struct ath10k_ce_ring *ce_ring;
+	struct ath10k_ce_pipe *ce_pipe = pci_pipe->ce_hdl;
+	struct ath10k_ce_ring *ce_ring = ce_pipe->dest_ring;
+	struct ath10k *ar = ce_pipe->ar;
 	struct sk_buff *skb;
 	int i;
 
-	ar = pci_pipe->hif_ce_state;
-	ce_pipe = pci_pipe->ce_hdl;
-	ce_ring = ce_pipe->dest_ring;
-
 	if (!ce_ring)
 		return;
 
@@ -2001,18 +1997,14 @@ static void ath10k_pci_rx_pipe_cleanup(struct ath10k_pci_pipe *pci_pipe)
 	}
 }
 
-static void ath10k_pci_tx_pipe_cleanup(struct ath10k_pci_pipe *pci_pipe)
+static void ath10k_pci_tx_pipe_cleanup(struct ath10k_pipe *pci_pipe)
 {
-	struct ath10k *ar;
-	struct ath10k_ce_pipe *ce_pipe;
-	struct ath10k_ce_ring *ce_ring;
+	struct ath10k_ce_pipe *ce_pipe = pci_pipe->ce_hdl;
+	struct ath10k_ce_ring *ce_ring = ce_pipe->src_ring;
+	struct ath10k *ar = ce_pipe->ar;
 	struct sk_buff *skb;
 	int i;
 
-	ar = pci_pipe->hif_ce_state;
-	ce_pipe = pci_pipe->ce_hdl;
-	ce_ring = ce_pipe->src_ring;
-
 	if (!ce_ring)
 		return;
 
@@ -2044,7 +2036,7 @@ static void ath10k_pci_buffer_cleanup(struct ath10k *ar)
 	int pipe_num;
 
 	for (pipe_num = 0; pipe_num < CE_COUNT; pipe_num++) {
-		struct ath10k_pci_pipe *pipe_info;
+		struct ath10k_pipe *pipe_info;
 
 		pipe_info = &ar_pci->pipe_info[pipe_num];
 		ath10k_pci_rx_pipe_cleanup(pipe_info);
@@ -2105,8 +2097,8 @@ int ath10k_pci_hif_exchange_bmi_msg(struct ath10k *ar,
 				    void *resp, u32 *resp_len)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
-	struct ath10k_pci_pipe *pci_tx = &ar_pci->pipe_info[BMI_CE_NUM_TO_TARG];
-	struct ath10k_pci_pipe *pci_rx = &ar_pci->pipe_info[BMI_CE_NUM_TO_HOST];
+	struct ath10k_pipe *pci_tx = &ar_pci->pipe_info[BMI_CE_NUM_TO_TARG];
+	struct ath10k_pipe *pci_rx = &ar_pci->pipe_info[BMI_CE_NUM_TO_HOST];
 	struct ath10k_ce_pipe *ce_tx = pci_tx->ce_hdl;
 	struct ath10k_ce_pipe *ce_rx = pci_rx->ce_hdl;
 	dma_addr_t req_paddr = 0;
@@ -2487,7 +2479,7 @@ static void ath10k_pci_override_ce_config(struct ath10k *ar)
 int ath10k_pci_alloc_pipes(struct ath10k *ar)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
-	struct ath10k_pci_pipe *pipe;
+	struct ath10k_pipe *pipe;
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	int i, ret;
 
@@ -2495,7 +2487,6 @@ int ath10k_pci_alloc_pipes(struct ath10k *ar)
 		pipe = &ar_pci->pipe_info[i];
 		pipe->ce_hdl = &ce->ce_states[i];
 		pipe->pipe_num = i;
-		pipe->hif_ce_state = ar;
 
 		ret = ath10k_ce_alloc_pipe(ar, i, &ar_pci->attr[i]);
 		if (ret) {
diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index 480cd97ab739..633c64e53a89 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -76,23 +76,6 @@ struct pcie_state {
 /* PCIE_CONFIG_FLAG definitions */
 #define PCIE_CONFIG_FLAG_ENABLE_L1  0x0000001
 
-/* Per-pipe state. */
-struct ath10k_pci_pipe {
-	/* Handle of underlying Copy Engine */
-	struct ath10k_ce_pipe *ce_hdl;
-
-	/* Our pipe number; facilitates use of pipe_info ptrs. */
-	u8 pipe_num;
-
-	/* Convenience back pointer to hif_ce_state. */
-	struct ath10k *hif_ce_state;
-
-	size_t buf_sz;
-
-	/* protects compl_free and num_send_allowed */
-	spinlock_t pipe_lock;
-};
-
 struct ath10k_pci_supp_chip {
 	u32 dev_id;
 	u32 rev_id;
@@ -114,7 +97,7 @@ struct ath10k_pci {
 	/* Operating interrupt mode */
 	enum ath10k_pci_irq_mode oper_irq_mode;
 
-	struct ath10k_pci_pipe pipe_info[CE_COUNT_MAX];
+	struct ath10k_pipe pipe_info[CE_COUNT_MAX];
 
 	/* Copy Engine used for Diagnostic Accesses */
 	struct ath10k_ce_pipe *ce_diag;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 26214c00cd0d..c228000a6e0f 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -488,10 +488,10 @@ static u32 ath10k_snoc_read32(struct ath10k *ar, u32 offset)
 	return val;
 }
 
-static int __ath10k_snoc_rx_post_buf(struct ath10k_snoc_pipe *pipe)
+static int __ath10k_snoc_rx_post_buf(struct ath10k_pipe *pipe)
 {
 	struct ath10k_ce_pipe *ce_pipe = pipe->ce_hdl;
-	struct ath10k *ar = pipe->hif_ce_state;
+	struct ath10k *ar = ce_pipe->ar;
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct sk_buff *skb;
 	dma_addr_t paddr;
@@ -527,12 +527,12 @@ static int __ath10k_snoc_rx_post_buf(struct ath10k_snoc_pipe *pipe)
 	return 0;
 }
 
-static void ath10k_snoc_rx_post_pipe(struct ath10k_snoc_pipe *pipe)
+static void ath10k_snoc_rx_post_pipe(struct ath10k_pipe *pipe)
 {
-	struct ath10k *ar = pipe->hif_ce_state;
+	struct ath10k_ce_pipe *ce_pipe = pipe->ce_hdl;
+	struct ath10k *ar = ce_pipe->ar;
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
-	struct ath10k_ce_pipe *ce_pipe = pipe->ce_hdl;
 	int ret, num;
 
 	if (pipe->buf_sz == 0)
@@ -572,7 +572,7 @@ static void ath10k_snoc_process_rx_cb(struct ath10k_ce_pipe *ce_state,
 {
 	struct ath10k *ar = ce_state->ar;
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
-	struct ath10k_snoc_pipe *pipe_info =  &ar_snoc->pipe_info[ce_state->id];
+	struct ath10k_pipe *pipe_info =  &ar_snoc->pipe_info[ce_state->id];
 	struct sk_buff *skb;
 	struct sk_buff_head list;
 	void *transfer_context;
@@ -688,7 +688,7 @@ static int ath10k_snoc_hif_tx_sg(struct ath10k *ar, u8 pipe_id,
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
-	struct ath10k_snoc_pipe *snoc_pipe;
+	struct ath10k_pipe *snoc_pipe;
 	struct ath10k_ce_pipe *ce_pipe;
 	int err, i = 0;
 
@@ -836,18 +836,14 @@ static inline void ath10k_snoc_irq_enable(struct ath10k *ar)
 	ath10k_ce_enable_interrupts(ar);
 }
 
-static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
+static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_pipe *snoc_pipe)
 {
-	struct ath10k_ce_pipe *ce_pipe;
-	struct ath10k_ce_ring *ce_ring;
+	struct ath10k_ce_pipe *ce_pipe = snoc_pipe->ce_hdl;
+	struct ath10k_ce_ring *ce_ring = ce_pipe->dest_ring;
+	struct ath10k *ar = ce_pipe->ar;
 	struct sk_buff *skb;
-	struct ath10k *ar;
 	int i;
 
-	ar = snoc_pipe->hif_ce_state;
-	ce_pipe = snoc_pipe->ce_hdl;
-	ce_ring = ce_pipe->dest_ring;
-
 	if (!ce_ring)
 		return;
 
@@ -868,18 +864,14 @@ static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
 	}
 }
 
-static void ath10k_snoc_tx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
+static void ath10k_snoc_tx_pipe_cleanup(struct ath10k_pipe *snoc_pipe)
 {
-	struct ath10k_ce_pipe *ce_pipe;
-	struct ath10k_ce_ring *ce_ring;
+	struct ath10k_ce_pipe *ce_pipe = snoc_pipe->ce_hdl;
+	struct ath10k_ce_ring *ce_ring = ce_pipe->src_ring;
+	struct ath10k *ar = ce_pipe->ar;
 	struct sk_buff *skb;
-	struct ath10k *ar;
 	int i;
 
-	ar = snoc_pipe->hif_ce_state;
-	ce_pipe = snoc_pipe->ce_hdl;
-	ce_ring = ce_pipe->src_ring;
-
 	if (!ce_ring)
 		return;
 
@@ -900,7 +892,7 @@ static void ath10k_snoc_tx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
 static void ath10k_snoc_buffer_cleanup(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
-	struct ath10k_snoc_pipe *pipe_info;
+	struct ath10k_pipe *pipe_info;
 	int pipe_num;
 
 	del_timer_sync(&ar_snoc->rx_post_retry);
@@ -1374,7 +1366,7 @@ static int ath10k_snoc_setup_resource(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
-	struct ath10k_snoc_pipe *pipe;
+	struct ath10k_pipe *pipe;
 	int i, ret;
 
 	timer_setup(&ar_snoc->rx_post_retry, ath10k_snoc_rx_replenish_retry, 0);
@@ -1383,7 +1375,6 @@ static int ath10k_snoc_setup_resource(struct ath10k *ar)
 		pipe = &ar_snoc->pipe_info[i];
 		pipe->ce_hdl = &ce->ce_states[i];
 		pipe->pipe_num = i;
-		pipe->hif_ce_state = ar;
 
 		ret = ath10k_ce_alloc_pipe(ar, i, &host_ce_config_wlan[i]);
 		if (ret) {
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index d4bce1707696..e29788201347 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -23,16 +23,6 @@ struct snoc_state {
 	u32 svc_to_pipe_map;
 };
 
-struct ath10k_snoc_pipe {
-	struct ath10k_ce_pipe *ce_hdl;
-	u8 pipe_num;
-	struct ath10k *hif_ce_state;
-	size_t buf_sz;
-	/* protect ce info */
-	spinlock_t pipe_lock;
-	struct ath10k_snoc *ar_snoc;
-};
-
 struct ath10k_snoc_target_info {
 	u32 target_version;
 	u32 target_type;
@@ -69,7 +59,7 @@ struct ath10k_snoc {
 	dma_addr_t mem_pa;
 	struct ath10k_snoc_target_info target_info;
 	size_t mem_len;
-	struct ath10k_snoc_pipe pipe_info[CE_COUNT_MAX];
+	struct ath10k_pipe pipe_info[CE_COUNT_MAX];
 	struct ath10k_snoc_ce_irq ce_irqs[CE_COUNT_MAX];
 	struct ath10k_ce ce;
 	struct timer_list rx_post_retry;
-- 
2.41.0

