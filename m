Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBF5561C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbfFYRlF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 13:41:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732360AbfFYRlD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 13:41:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so9279993pgr.13
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rry4kw1YZatw9+7hKy8VC0jCisBB8sOOG4UIR2BMnbc=;
        b=nwRuN/Hg5HTvKsuYNRkLQnSZX+hMz8CC0kZ+QZMLCOgGJHiET8GTAh7jqPwwtHoddV
         j4AbwdiSx8tyNWW3IOU9+gHvDnesb8AH9V1Eens8h721kLLsZcwEPFo8KTUl/KGofRQ4
         XpWg6oIjK4XErhiOiKku2YzTozru/N9v+jNpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rry4kw1YZatw9+7hKy8VC0jCisBB8sOOG4UIR2BMnbc=;
        b=LYUHa/eMLZBitdm/Y3vdwnOHPzXUkjpGTNmWcokBCNaKzbu+aL3RoVGCF71mgdN50d
         sDO5/zvqdxSb7mief/33Km7u1w0Zp4zt2O3McrCK+vdmas9UZJ6ets5+O6cPU3OLob+f
         7aMxeP2zOOB6c60ha3r/u8JWLMHrFV6GuWPNzaZrPWyn07x1rmB3HNCehUorbtkCVSyK
         bI95lEu4qiqCwTXDQyjMsreZomaz+RxYz70dWlExv7Rb9ASDoeQnD1zN26gEhg9o7gj8
         aQfyKxMOwQIvaueTJuIdg1RbQnAMoigSVyDwYqRzjtFnC3sGi2r7vn9x5CFrrXdYZPD4
         lSrA==
X-Gm-Message-State: APjAAAVPmbNX2E4VeWZ1M3Ce9VA7bby2GHrLKqRFLbKMfHE52svDJreU
        IgFrSLShZUOcRpJ7KFo3GMUyCA==
X-Google-Smtp-Source: APXvYqzsyOc4WAbjCr7P6/swRagPf1YuHyFvl3jdgXZtDEK0fJoZThYEbYJ+E+rPr19TWh23QC38VQ==
X-Received: by 2002:a65:638a:: with SMTP id h10mr41496581pgv.64.1561484459905;
        Tue, 25 Jun 2019 10:40:59 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 85sm20872129pfv.130.2019.06.25.10.40.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 10:40:58 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/2] mwifiex: don't disable hardirqs; just softirqs
Date:   Tue, 25 Jun 2019 10:40:45 -0700
Message-Id: <20190625174045.125223-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190625174045.125223-1-briannorris@chromium.org>
References: <20190625174045.125223-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

main_proc_lock and int_lock (in mwifiex_adapter) are the only spinlocks
used in hardirq contexts. The rest are only in task or softirq contexts.

Convert every other lock from *_irq{save,restore}() variants to _bh()
variants.

This is a mechanical transformation of all spinlock usage in mwifiex
using the following:

Step 1:
I ran this nasty sed script:

    sed -i -E '/spin_lock_irqsave|spin_unlock_irqrestore/ {
      /main_proc_lock|int_lock/! {
        s:(spin_(un|)lock)_irq(save|restore):\1_bh: ;
        # Join broken lines.
        :a /;$/! {
          N;
          s/\s*\n\s*//;
          ba
        }
        /,.*\);$/ s:,.*\):\):
      }
    }' drivers/net/wireless/marvell/mwifiex/*

Step 2:
Manually delete the flags / ra_list_flags args from:

  mwifiex_send_single_packet()
  mwifiex_11n_aggregate_pkt()
  mwifiex_send_processed_packet()

which are now unused.

Step 3:
Apply this semantic patch (coccinelle) to remove the unused 'flags'
variables:

// <smpl>
@@
type T;
identifier i;
@@

(
extern T i;
|
- T i;
  ... when != i
)
// </smpl>

(Usage is something like this:

  make coccicheck COCCI=./patch.cocci MODE=patch M=drivers/net/wireless/marvell/mwifiex/

although this skips *.h files for some reasons, so I had to massage
stuff.)

Testing: I've played with a variety of stress tests, including download
stress tests on the same APs which caught regressions with commit
5188d5453bc9 ("mwifiex: restructure rx_reorder_tbl_lock usage"). I've
primarily tested on Marvell 8997 / PCIe, although I've given 8897 / SDIO
a quick spin as well.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2:
 * add new Step 2, because I missed a few functions that were passing
   along the IRQ flags as arguments (fixes "used but not set" warnings,
   because these flags were no longer really in use, but were getting
   passed along as args still)
---
 drivers/net/wireless/marvell/mwifiex/11n.c    |  53 ++++-----
 drivers/net/wireless/marvell/mwifiex/11n.h    |   5 +-
 .../net/wireless/marvell/mwifiex/11n_aggr.c   |  26 ++---
 .../net/wireless/marvell/mwifiex/11n_aggr.h   |   2 +-
 .../wireless/marvell/mwifiex/11n_rxreorder.c  |  86 ++++++--------
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  35 +++---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  76 +++++-------
 drivers/net/wireless/marvell/mwifiex/init.c   |  32 ++---
 drivers/net/wireless/marvell/mwifiex/main.c   |  29 ++---
 drivers/net/wireless/marvell/mwifiex/scan.c   |  58 ++++------
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   5 +-
 .../net/wireless/marvell/mwifiex/sta_event.c  |  10 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c   |  68 ++++-------
 drivers/net/wireless/marvell/mwifiex/txrx.c   |   5 +-
 .../net/wireless/marvell/mwifiex/uap_txrx.c   |  10 +-
 drivers/net/wireless/marvell/mwifiex/usb.c    |  10 +-
 drivers/net/wireless/marvell/mwifiex/util.c   |  15 +--
 drivers/net/wireless/marvell/mwifiex/wmm.c    | 109 +++++++-----------
 18 files changed, 256 insertions(+), 378 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 5d75c971004b..e435f801bc91 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -84,17 +84,15 @@ mwifiex_get_ba_status(struct mwifiex_private *priv,
 		      enum mwifiex_ba_status ba_status)
 {
 	struct mwifiex_tx_ba_stream_tbl *tx_ba_tsr_tbl;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
 		if (tx_ba_tsr_tbl->ba_status == ba_status) {
-			spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock,
-					       flags);
+			spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 			return tx_ba_tsr_tbl;
 		}
 	}
-	spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 	return NULL;
 }
 
@@ -516,13 +514,12 @@ void mwifiex_11n_delete_all_tx_ba_stream_tbl(struct mwifiex_private *priv)
 {
 	int i;
 	struct mwifiex_tx_ba_stream_tbl *del_tbl_ptr, *tmp_node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 	list_for_each_entry_safe(del_tbl_ptr, tmp_node,
 				 &priv->tx_ba_stream_tbl_ptr, list)
 		mwifiex_11n_delete_tx_ba_stream_tbl_entry(priv, del_tbl_ptr);
-	spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 
 	INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr);
 
@@ -539,18 +536,16 @@ struct mwifiex_tx_ba_stream_tbl *
 mwifiex_get_ba_tbl(struct mwifiex_private *priv, int tid, u8 *ra)
 {
 	struct mwifiex_tx_ba_stream_tbl *tx_ba_tsr_tbl;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
 		if (ether_addr_equal_unaligned(tx_ba_tsr_tbl->ra, ra) &&
 		    tx_ba_tsr_tbl->tid == tid) {
-			spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock,
-					       flags);
+			spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 			return tx_ba_tsr_tbl;
 		}
 	}
-	spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 	return NULL;
 }
 
@@ -563,7 +558,6 @@ void mwifiex_create_ba_tbl(struct mwifiex_private *priv, u8 *ra, int tid,
 {
 	struct mwifiex_tx_ba_stream_tbl *new_node;
 	struct mwifiex_ra_list_tbl *ra_list;
-	unsigned long flags;
 	int tid_down;
 
 	if (!mwifiex_get_ba_tbl(priv, tid, ra)) {
@@ -584,9 +578,9 @@ void mwifiex_create_ba_tbl(struct mwifiex_private *priv, u8 *ra, int tid,
 		new_node->ba_status = ba_status;
 		memcpy(new_node->ra, ra, ETH_ALEN);
 
-		spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 		list_add_tail(&new_node->list, &priv->tx_ba_stream_tbl_ptr);
-		spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 	}
 }
 
@@ -599,7 +593,6 @@ int mwifiex_send_addba(struct mwifiex_private *priv, int tid, u8 *peer_mac)
 	u32 tx_win_size = priv->add_ba_param.tx_win_size;
 	static u8 dialog_tok;
 	int ret;
-	unsigned long flags;
 	u16 block_ack_param_set;
 
 	mwifiex_dbg(priv->adapter, CMD, "cmd: %s: tid %d\n", __func__, tid);
@@ -612,10 +605,10 @@ int mwifiex_send_addba(struct mwifiex_private *priv, int tid, u8 *peer_mac)
 	    memcmp(priv->cfg_bssid, peer_mac, ETH_ALEN)) {
 		struct mwifiex_sta_node *sta_ptr;
 
-		spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+		spin_lock_bh(&priv->sta_list_spinlock);
 		sta_ptr = mwifiex_get_sta_entry(priv, peer_mac);
 		if (!sta_ptr) {
-			spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+			spin_unlock_bh(&priv->sta_list_spinlock);
 			mwifiex_dbg(priv->adapter, ERROR,
 				    "BA setup with unknown TDLS peer %pM!\n",
 				    peer_mac);
@@ -623,7 +616,7 @@ int mwifiex_send_addba(struct mwifiex_private *priv, int tid, u8 *peer_mac)
 		}
 		if (sta_ptr->is_11ac_enabled)
 			tx_win_size = MWIFIEX_11AC_STA_AMPDU_DEF_TXWINSIZE;
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 	}
 
 	block_ack_param_set = (u16)((tid << BLOCKACKPARAM_TID_POS) |
@@ -687,9 +680,8 @@ int mwifiex_send_delba(struct mwifiex_private *priv, int tid, u8 *peer_mac,
 void mwifiex_11n_delba(struct mwifiex_private *priv, int tid)
 {
 	struct mwifiex_rx_reorder_tbl *rx_reor_tbl_ptr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_for_each_entry(rx_reor_tbl_ptr, &priv->rx_reorder_tbl_ptr, list) {
 		if (rx_reor_tbl_ptr->tid == tid) {
 			dev_dbg(priv->adapter->dev,
@@ -700,7 +692,7 @@ void mwifiex_11n_delba(struct mwifiex_private *priv, int tid)
 		}
 	}
 exit:
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 }
 
 /*
@@ -729,9 +721,8 @@ int mwifiex_get_rx_reorder_tbl(struct mwifiex_private *priv,
 	struct mwifiex_ds_rx_reorder_tbl *rx_reo_tbl = buf;
 	struct mwifiex_rx_reorder_tbl *rx_reorder_tbl_ptr;
 	int count = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_for_each_entry(rx_reorder_tbl_ptr, &priv->rx_reorder_tbl_ptr,
 			    list) {
 		rx_reo_tbl->tid = (u16) rx_reorder_tbl_ptr->tid;
@@ -750,7 +741,7 @@ int mwifiex_get_rx_reorder_tbl(struct mwifiex_private *priv,
 		if (count >= MWIFIEX_MAX_RX_BASTREAM_SUPPORTED)
 			break;
 	}
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	return count;
 }
@@ -764,9 +755,8 @@ int mwifiex_get_tx_ba_stream_tbl(struct mwifiex_private *priv,
 	struct mwifiex_tx_ba_stream_tbl *tx_ba_tsr_tbl;
 	struct mwifiex_ds_tx_ba_stream_tbl *rx_reo_tbl = buf;
 	int count = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
 		rx_reo_tbl->tid = (u16) tx_ba_tsr_tbl->tid;
 		mwifiex_dbg(priv->adapter, DATA, "data: %s tid=%d\n",
@@ -778,7 +768,7 @@ int mwifiex_get_tx_ba_stream_tbl(struct mwifiex_private *priv,
 		if (count >= MWIFIEX_MAX_TX_BASTREAM_SUPPORTED)
 			break;
 	}
-	spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 
 	return count;
 }
@@ -790,16 +780,15 @@ int mwifiex_get_tx_ba_stream_tbl(struct mwifiex_private *priv,
 void mwifiex_del_tx_ba_stream_tbl_by_ra(struct mwifiex_private *priv, u8 *ra)
 {
 	struct mwifiex_tx_ba_stream_tbl *tbl, *tmp;
-	unsigned long flags;
 
 	if (!ra)
 		return;
 
-	spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 	list_for_each_entry_safe(tbl, tmp, &priv->tx_ba_stream_tbl_ptr, list)
 		if (!memcmp(tbl->ra, ra, ETH_ALEN))
 			mwifiex_11n_delete_tx_ba_stream_tbl_entry(priv, tbl);
-	spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 
 	return;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/11n.h b/drivers/net/wireless/marvell/mwifiex/11n.h
index ea0fa68b9913..33268ce2cd82 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.h
+++ b/drivers/net/wireless/marvell/mwifiex/11n.h
@@ -147,11 +147,10 @@ mwifiex_find_stream_to_delete(struct mwifiex_private *priv, int ptr_tid,
 	int tid;
 	u8 ret = false;
 	struct mwifiex_tx_ba_stream_tbl *tx_tbl;
-	unsigned long flags;
 
 	tid = priv->aggr_prio_tbl[ptr_tid].ampdu_user;
 
-	spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 	list_for_each_entry(tx_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
 		if (tid > priv->aggr_prio_tbl[tx_tbl->tid].ampdu_user) {
 			tid = priv->aggr_prio_tbl[tx_tbl->tid].ampdu_user;
@@ -160,7 +159,7 @@ mwifiex_find_stream_to_delete(struct mwifiex_private *priv, int ptr_tid,
 			ret = true;
 		}
 	}
-	spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
index 042a1d07f686..088612438530 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
@@ -155,7 +155,7 @@ mwifiex_11n_form_amsdu_txpd(struct mwifiex_private *priv,
 int
 mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 			  struct mwifiex_ra_list_tbl *pra_list,
-			  int ptrindex, unsigned long ra_list_flags)
+			  int ptrindex)
 			  __releases(&priv->wmm.ra_list_spinlock)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
@@ -168,8 +168,7 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 
 	skb_src = skb_peek(&pra_list->skb_head);
 	if (!skb_src) {
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		return 0;
 	}
 
@@ -177,8 +176,7 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 	skb_aggr = mwifiex_alloc_dma_align_buf(adapter->tx_buf_size,
 					       GFP_ATOMIC);
 	if (!skb_aggr) {
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		return -1;
 	}
 
@@ -208,17 +206,15 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 		pra_list->total_pkt_count--;
 		atomic_dec(&priv->wmm.tx_pkts_queued);
 		aggr_num++;
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		mwifiex_11n_form_amsdu_pkt(skb_aggr, skb_src, &pad);
 
 		mwifiex_write_data_complete(adapter, skb_src, 0, 0);
 
-		spin_lock_irqsave(&priv->wmm.ra_list_spinlock, ra_list_flags);
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 		if (!mwifiex_is_ralist_valid(priv, pra_list, ptrindex)) {
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       ra_list_flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 			return -1;
 		}
 
@@ -232,7 +228,7 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 
 	} while (skb_src);
 
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, ra_list_flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 
 	/* Last AMSDU packet does not need padding */
 	skb_trim(skb_aggr, skb_aggr->len - pad);
@@ -265,10 +261,9 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 	}
 	switch (ret) {
 	case -EBUSY:
-		spin_lock_irqsave(&priv->wmm.ra_list_spinlock, ra_list_flags);
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
 		if (!mwifiex_is_ralist_valid(priv, pra_list, ptrindex)) {
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       ra_list_flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 			mwifiex_write_data_complete(adapter, skb_aggr, 1, -1);
 			return -1;
 		}
@@ -286,8 +281,7 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 		atomic_inc(&priv->wmm.tx_pkts_queued);
 
 		tx_info_aggr->flags |= MWIFIEX_BUF_FLAG_REQUEUED_PKT;
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		mwifiex_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
 		break;
 	case -1:
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_aggr.h b/drivers/net/wireless/marvell/mwifiex/11n_aggr.h
index 0cd2a3eb6c17..8279b159da7c 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_aggr.h
+++ b/drivers/net/wireless/marvell/mwifiex/11n_aggr.h
@@ -27,7 +27,7 @@ int mwifiex_11n_deaggregate_pkt(struct mwifiex_private *priv,
 				struct sk_buff *skb);
 int mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 			      struct mwifiex_ra_list_tbl *ptr,
-			      int ptr_index, unsigned long flags)
+			      int ptr_index)
 			      __releases(&priv->wmm.ra_list_spinlock);
 
 #endif /* !_MWIFIEX_11N_AGGR_H_ */
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 77bdf16d6573..05a3c61ac603 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -113,10 +113,9 @@ mwifiex_11n_dispatch_pkt_until_start_win(struct mwifiex_private *priv,
 	struct sk_buff_head list;
 	struct sk_buff *skb;
 	int pkt_to_send, i;
-	unsigned long flags;
 
 	__skb_queue_head_init(&list);
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 
 	pkt_to_send = (start_win > tbl->start_win) ?
 		      min((start_win - tbl->start_win), tbl->win_size) :
@@ -140,7 +139,7 @@ mwifiex_11n_dispatch_pkt_until_start_win(struct mwifiex_private *priv,
 	}
 
 	tbl->start_win = start_win;
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	while ((skb = __skb_dequeue(&list)))
 		mwifiex_11n_dispatch_pkt(priv, skb);
@@ -161,10 +160,9 @@ mwifiex_11n_scan_and_dispatch(struct mwifiex_private *priv,
 	struct sk_buff_head list;
 	struct sk_buff *skb;
 	int i, j, xchg;
-	unsigned long flags;
 
 	__skb_queue_head_init(&list);
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 
 	for (i = 0; i < tbl->win_size; ++i) {
 		if (!tbl->rx_reorder_ptr[i])
@@ -187,7 +185,7 @@ mwifiex_11n_scan_and_dispatch(struct mwifiex_private *priv,
 	}
 	tbl->start_win = (tbl->start_win + i) & (MAX_TID_VALUE - 1);
 
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	while ((skb = __skb_dequeue(&list)))
 		mwifiex_11n_dispatch_pkt(priv, skb);
@@ -203,19 +201,18 @@ static void
 mwifiex_del_rx_reorder_entry(struct mwifiex_private *priv,
 			     struct mwifiex_rx_reorder_tbl *tbl)
 {
-	unsigned long flags;
 	int start_win;
 
 	if (!tbl)
 		return;
 
-	spin_lock_irqsave(&priv->adapter->rx_proc_lock, flags);
+	spin_lock_bh(&priv->adapter->rx_proc_lock);
 	priv->adapter->rx_locked = true;
 	if (priv->adapter->rx_processing) {
-		spin_unlock_irqrestore(&priv->adapter->rx_proc_lock, flags);
+		spin_unlock_bh(&priv->adapter->rx_proc_lock);
 		flush_workqueue(priv->adapter->rx_workqueue);
 	} else {
-		spin_unlock_irqrestore(&priv->adapter->rx_proc_lock, flags);
+		spin_unlock_bh(&priv->adapter->rx_proc_lock);
 	}
 
 	start_win = (tbl->start_win + tbl->win_size) & (MAX_TID_VALUE - 1);
@@ -224,16 +221,16 @@ mwifiex_del_rx_reorder_entry(struct mwifiex_private *priv,
 	del_timer_sync(&tbl->timer_context.timer);
 	tbl->timer_context.timer_is_set = false;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_del(&tbl->list);
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	kfree(tbl->rx_reorder_ptr);
 	kfree(tbl);
 
-	spin_lock_irqsave(&priv->adapter->rx_proc_lock, flags);
+	spin_lock_bh(&priv->adapter->rx_proc_lock);
 	priv->adapter->rx_locked = false;
-	spin_unlock_irqrestore(&priv->adapter->rx_proc_lock, flags);
+	spin_unlock_bh(&priv->adapter->rx_proc_lock);
 
 }
 
@@ -245,17 +242,15 @@ struct mwifiex_rx_reorder_tbl *
 mwifiex_11n_get_rx_reorder_tbl(struct mwifiex_private *priv, int tid, u8 *ta)
 {
 	struct mwifiex_rx_reorder_tbl *tbl;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_for_each_entry(tbl, &priv->rx_reorder_tbl_ptr, list) {
 		if (!memcmp(tbl->ta, ta, ETH_ALEN) && tbl->tid == tid) {
-			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
-					       flags);
+			spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 			return tbl;
 		}
 	}
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	return NULL;
 }
@@ -266,21 +261,19 @@ mwifiex_11n_get_rx_reorder_tbl(struct mwifiex_private *priv, int tid, u8 *ta)
 void mwifiex_11n_del_rx_reorder_tbl_by_ta(struct mwifiex_private *priv, u8 *ta)
 {
 	struct mwifiex_rx_reorder_tbl *tbl, *tmp;
-	unsigned long flags;
 
 	if (!ta)
 		return;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_for_each_entry_safe(tbl, tmp, &priv->rx_reorder_tbl_ptr, list) {
 		if (!memcmp(tbl->ta, ta, ETH_ALEN)) {
-			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
-					       flags);
+			spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 			mwifiex_del_rx_reorder_entry(priv, tbl);
-			spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+			spin_lock_bh(&priv->rx_reorder_tbl_lock);
 		}
 	}
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	return;
 }
@@ -294,18 +287,16 @@ mwifiex_11n_find_last_seq_num(struct reorder_tmr_cnxt *ctx)
 {
 	struct mwifiex_rx_reorder_tbl *rx_reorder_tbl_ptr = ctx->ptr;
 	struct mwifiex_private *priv = ctx->priv;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	for (i = rx_reorder_tbl_ptr->win_size - 1; i >= 0; --i) {
 		if (rx_reorder_tbl_ptr->rx_reorder_ptr[i]) {
-			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
-					       flags);
+			spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 			return i;
 		}
 	}
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	return -1;
 }
@@ -353,7 +344,6 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 	int i;
 	struct mwifiex_rx_reorder_tbl *tbl, *new_node;
 	u16 last_seq = 0;
-	unsigned long flags;
 	struct mwifiex_sta_node *node;
 
 	/*
@@ -377,7 +367,7 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 	new_node->init_win = seq_num;
 	new_node->flags = 0;
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 	if (mwifiex_queuing_ra_based(priv)) {
 		if (priv->bss_role == MWIFIEX_BSS_ROLE_UAP) {
 			node = mwifiex_get_sta_entry(priv, ta);
@@ -391,7 +381,7 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 		else
 			last_seq = priv->rx_seq[tid];
 	}
-	spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+	spin_unlock_bh(&priv->sta_list_spinlock);
 
 	mwifiex_dbg(priv->adapter, INFO,
 		    "info: last_seq=%d start_win=%d\n",
@@ -423,9 +413,9 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 	for (i = 0; i < win_size; ++i)
 		new_node->rx_reorder_ptr[i] = NULL;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_add_tail(&new_node->list, &priv->rx_reorder_tbl_ptr);
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 }
 
 static void
@@ -481,18 +471,17 @@ int mwifiex_cmd_11n_addba_rsp_gen(struct mwifiex_private *priv,
 	u32 rx_win_size = priv->add_ba_param.rx_win_size;
 	u8 tid;
 	int win_size;
-	unsigned long flags;
 	uint16_t block_ack_param_set;
 
 	if ((GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA) &&
 	    ISSUPP_TDLS_ENABLED(priv->adapter->fw_cap_info) &&
 	    priv->adapter->is_hw_11ac_capable &&
 	    memcmp(priv->cfg_bssid, cmd_addba_req->peer_mac_addr, ETH_ALEN)) {
-		spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+		spin_lock_bh(&priv->sta_list_spinlock);
 		sta_ptr = mwifiex_get_sta_entry(priv,
 						cmd_addba_req->peer_mac_addr);
 		if (!sta_ptr) {
-			spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+			spin_unlock_bh(&priv->sta_list_spinlock);
 			mwifiex_dbg(priv->adapter, ERROR,
 				    "BA setup with unknown TDLS peer %pM!\n",
 				    cmd_addba_req->peer_mac_addr);
@@ -500,7 +489,7 @@ int mwifiex_cmd_11n_addba_rsp_gen(struct mwifiex_private *priv,
 		}
 		if (sta_ptr->is_11ac_enabled)
 			rx_win_size = MWIFIEX_11AC_STA_AMPDU_DEF_RXWINSIZE;
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 	}
 
 	cmd->command = cpu_to_le16(HostCmd_CMD_11N_ADDBA_RSP);
@@ -687,7 +676,6 @@ mwifiex_del_ba_tbl(struct mwifiex_private *priv, int tid, u8 *peer_mac,
 	struct mwifiex_tx_ba_stream_tbl *ptx_tbl;
 	struct mwifiex_ra_list_tbl *ra_list;
 	u8 cleanup_rx_reorder_tbl;
-	unsigned long flags;
 	int tid_down;
 
 	if (type == TYPE_DELBA_RECEIVE)
@@ -721,9 +709,9 @@ mwifiex_del_ba_tbl(struct mwifiex_private *priv, int tid, u8 *peer_mac,
 			ra_list->amsdu_in_ampdu = false;
 			ra_list->ba_status = BA_SETUP_NONE;
 		}
-		spin_lock_irqsave(&priv->tx_ba_stream_tbl_lock, flags);
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
 		mwifiex_11n_delete_tx_ba_stream_tbl_entry(priv, ptx_tbl);
-		spin_unlock_irqrestore(&priv->tx_ba_stream_tbl_lock, flags);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
 	}
 }
 
@@ -809,17 +797,16 @@ void mwifiex_11n_ba_stream_timeout(struct mwifiex_private *priv,
 void mwifiex_11n_cleanup_reorder_tbl(struct mwifiex_private *priv)
 {
 	struct mwifiex_rx_reorder_tbl *del_tbl_ptr, *tmp_node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_for_each_entry_safe(del_tbl_ptr, tmp_node,
 				 &priv->rx_reorder_tbl_ptr, list) {
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+		spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 		mwifiex_del_rx_reorder_entry(priv, del_tbl_ptr);
-		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+		spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	}
 	INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr);
-	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
 	mwifiex_reset_11n_rx_seq_num(priv);
 }
@@ -831,7 +818,6 @@ void mwifiex_update_rxreor_flags(struct mwifiex_adapter *adapter, u8 flags)
 {
 	struct mwifiex_private *priv;
 	struct mwifiex_rx_reorder_tbl *tbl;
-	unsigned long lock_flags;
 	int i;
 
 	for (i = 0; i < adapter->priv_num; i++) {
@@ -839,10 +825,10 @@ void mwifiex_update_rxreor_flags(struct mwifiex_adapter *adapter, u8 flags)
 		if (!priv)
 			continue;
 
-		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, lock_flags);
+		spin_lock_bh(&priv->rx_reorder_tbl_lock);
 		list_for_each_entry(tbl, &priv->rx_reorder_tbl_ptr, list)
 			tbl->flags = flags;
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, lock_flags);
+		spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 	}
 
 	return;
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index e11a4bb67172..96eef3083f14 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -876,13 +876,13 @@ static int mwifiex_deinit_priv_params(struct mwifiex_private *priv)
 		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
 	}
 
-	spin_lock_irqsave(&adapter->rx_proc_lock, flags);
+	spin_lock_bh(&adapter->rx_proc_lock);
 	adapter->rx_locked = true;
 	if (adapter->rx_processing) {
-		spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+		spin_unlock_bh(&adapter->rx_proc_lock);
 		flush_workqueue(adapter->rx_workqueue);
 	} else {
-	spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+	spin_unlock_bh(&adapter->rx_proc_lock);
 	}
 
 	mwifiex_free_priv(priv);
@@ -934,9 +934,9 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 	adapter->main_locked = false;
 	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
 
-	spin_lock_irqsave(&adapter->rx_proc_lock, flags);
+	spin_lock_bh(&adapter->rx_proc_lock);
 	adapter->rx_locked = false;
-	spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+	spin_unlock_bh(&adapter->rx_proc_lock);
 
 	mwifiex_set_mac_address(priv, dev, false, NULL);
 
@@ -1827,7 +1827,6 @@ mwifiex_cfg80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct mwifiex_sta_node *sta_node;
 	u8 deauth_mac[ETH_ALEN];
-	unsigned long flags;
 
 	if (!priv->bss_started && priv->wdev.cac_started) {
 		mwifiex_dbg(priv->adapter, INFO, "%s: abort CAC!\n", __func__);
@@ -1845,11 +1844,11 @@ mwifiex_cfg80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 
 	eth_zero_addr(deauth_mac);
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 	sta_node = mwifiex_get_sta_entry(priv, params->mac);
 	if (sta_node)
 		ether_addr_copy(deauth_mac, params->mac);
-	spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+	spin_unlock_bh(&priv->sta_list_spinlock);
 
 	if (is_valid_ether_addr(deauth_mac)) {
 		if (mwifiex_send_cmd(priv, HostCmd_CMD_UAP_STA_DEAUTH,
@@ -3852,15 +3851,14 @@ mwifiex_cfg80211_tdls_chan_switch(struct wiphy *wiphy, struct net_device *dev,
 				  struct cfg80211_chan_def *chandef)
 {
 	struct mwifiex_sta_node *sta_ptr;
-	unsigned long flags;
 	u16 chan;
 	u8 second_chan_offset, band;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 	sta_ptr = mwifiex_get_sta_entry(priv, addr);
 	if (!sta_ptr) {
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 		wiphy_err(wiphy, "%s: Invalid TDLS peer %pM\n",
 			  __func__, addr);
 		return -ENOENT;
@@ -3868,18 +3866,18 @@ mwifiex_cfg80211_tdls_chan_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	if (!(sta_ptr->tdls_cap.extcap.ext_capab[3] &
 	      WLAN_EXT_CAPA4_TDLS_CHAN_SWITCH)) {
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 		wiphy_err(wiphy, "%pM do not support tdls cs\n", addr);
 		return -ENOENT;
 	}
 
 	if (sta_ptr->tdls_status == TDLS_CHAN_SWITCHING ||
 	    sta_ptr->tdls_status == TDLS_IN_OFF_CHAN) {
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 		wiphy_err(wiphy, "channel switch is running, abort request\n");
 		return -EALREADY;
 	}
-	spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+	spin_unlock_bh(&priv->sta_list_spinlock);
 
 	chan = chandef->chan->hw_value;
 	second_chan_offset = mwifiex_get_sec_chan_offset(chan);
@@ -3895,23 +3893,22 @@ mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
 					 const u8 *addr)
 {
 	struct mwifiex_sta_node *sta_ptr;
-	unsigned long flags;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 	sta_ptr = mwifiex_get_sta_entry(priv, addr);
 	if (!sta_ptr) {
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 		wiphy_err(wiphy, "%s: Invalid TDLS peer %pM\n",
 			  __func__, addr);
 	} else if (!(sta_ptr->tdls_status == TDLS_CHAN_SWITCHING ||
 		     sta_ptr->tdls_status == TDLS_IN_BASE_CHAN ||
 		     sta_ptr->tdls_status == TDLS_IN_OFF_CHAN)) {
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 		wiphy_err(wiphy, "tdls chan switch not initialize by %pM\n",
 			  addr);
 	} else {
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 		mwifiex_stop_tdls_cs(priv, addr);
 	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 133b03d7daf9..e8788c35a453 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -61,19 +61,18 @@ static struct cmd_ctrl_node *
 mwifiex_get_cmd_node(struct mwifiex_adapter *adapter)
 {
 	struct cmd_ctrl_node *cmd_node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&adapter->cmd_free_q_lock, flags);
+	spin_lock_bh(&adapter->cmd_free_q_lock);
 	if (list_empty(&adapter->cmd_free_q)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "GET_CMD_NODE: cmd node not available\n");
-		spin_unlock_irqrestore(&adapter->cmd_free_q_lock, flags);
+		spin_unlock_bh(&adapter->cmd_free_q_lock);
 		return NULL;
 	}
 	cmd_node = list_first_entry(&adapter->cmd_free_q,
 				    struct cmd_ctrl_node, list);
 	list_del(&cmd_node->list);
-	spin_unlock_irqrestore(&adapter->cmd_free_q_lock, flags);
+	spin_unlock_bh(&adapter->cmd_free_q_lock);
 
 	return cmd_node;
 }
@@ -117,8 +116,6 @@ static void
 mwifiex_insert_cmd_to_free_q(struct mwifiex_adapter *adapter,
 			     struct cmd_ctrl_node *cmd_node)
 {
-	unsigned long flags;
-
 	if (!cmd_node)
 		return;
 
@@ -128,9 +125,9 @@ mwifiex_insert_cmd_to_free_q(struct mwifiex_adapter *adapter,
 	mwifiex_clean_cmd_node(adapter, cmd_node);
 
 	/* Insert node into cmd_free_q */
-	spin_lock_irqsave(&adapter->cmd_free_q_lock, flags);
+	spin_lock_bh(&adapter->cmd_free_q_lock);
 	list_add_tail(&cmd_node->list, &adapter->cmd_free_q);
-	spin_unlock_irqrestore(&adapter->cmd_free_q_lock, flags);
+	spin_unlock_bh(&adapter->cmd_free_q_lock);
 }
 
 /* This function reuses a command node. */
@@ -183,7 +180,6 @@ static int mwifiex_dnld_cmd_to_fw(struct mwifiex_private *priv,
 	struct host_cmd_ds_command *host_cmd;
 	uint16_t cmd_code;
 	uint16_t cmd_size;
-	unsigned long flags;
 
 	if (!adapter || !cmd_node)
 		return -1;
@@ -223,9 +219,9 @@ static int mwifiex_dnld_cmd_to_fw(struct mwifiex_private *priv,
 					 cmd_node->priv->bss_num,
 					 cmd_node->priv->bss_type));
 
-	spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+	spin_lock_bh(&adapter->mwifiex_cmd_lock);
 	adapter->curr_cmd = cmd_node;
-	spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 
 	/* Adjust skb length */
 	if (cmd_node->cmd_skb->len > cmd_size)
@@ -276,9 +272,9 @@ static int mwifiex_dnld_cmd_to_fw(struct mwifiex_private *priv,
 			adapter->cmd_wait_q.status = -1;
 		mwifiex_recycle_cmd_node(adapter, adapter->curr_cmd);
 
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		adapter->curr_cmd = NULL;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 
 		adapter->dbg.num_cmd_host_to_card_failure++;
 		return -1;
@@ -697,7 +693,6 @@ mwifiex_insert_cmd_to_pending_q(struct mwifiex_adapter *adapter,
 {
 	struct host_cmd_ds_command *host_cmd = NULL;
 	u16 command;
-	unsigned long flags;
 	bool add_tail = true;
 
 	host_cmd = (struct host_cmd_ds_command *) (cmd_node->cmd_skb->data);
@@ -719,12 +714,12 @@ mwifiex_insert_cmd_to_pending_q(struct mwifiex_adapter *adapter,
 		}
 	}
 
-	spin_lock_irqsave(&adapter->cmd_pending_q_lock, flags);
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
 	if (add_tail)
 		list_add_tail(&cmd_node->list, &adapter->cmd_pending_q);
 	else
 		list_add(&cmd_node->list, &adapter->cmd_pending_q);
-	spin_unlock_irqrestore(&adapter->cmd_pending_q_lock, flags);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
 
 	atomic_inc(&adapter->cmd_pending);
 	mwifiex_dbg(adapter, CMD,
@@ -749,8 +744,6 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 	struct cmd_ctrl_node *cmd_node;
 	int ret = 0;
 	struct host_cmd_ds_command *host_cmd;
-	unsigned long cmd_flags;
-	unsigned long cmd_pending_q_flags;
 
 	/* Check if already in processing */
 	if (adapter->curr_cmd) {
@@ -759,13 +752,12 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 		return -1;
 	}
 
-	spin_lock_irqsave(&adapter->mwifiex_cmd_lock, cmd_flags);
+	spin_lock_bh(&adapter->mwifiex_cmd_lock);
 	/* Check if any command is pending */
-	spin_lock_irqsave(&adapter->cmd_pending_q_lock, cmd_pending_q_flags);
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
 	if (list_empty(&adapter->cmd_pending_q)) {
-		spin_unlock_irqrestore(&adapter->cmd_pending_q_lock,
-				       cmd_pending_q_flags);
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, cmd_flags);
+		spin_unlock_bh(&adapter->cmd_pending_q_lock);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 		return 0;
 	}
 	cmd_node = list_first_entry(&adapter->cmd_pending_q,
@@ -778,17 +770,15 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: cannot send cmd in sleep state,\t"
 			    "this should not happen\n", __func__);
-		spin_unlock_irqrestore(&adapter->cmd_pending_q_lock,
-				       cmd_pending_q_flags);
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, cmd_flags);
+		spin_unlock_bh(&adapter->cmd_pending_q_lock);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 		return ret;
 	}
 
 	list_del(&cmd_node->list);
-	spin_unlock_irqrestore(&adapter->cmd_pending_q_lock,
-			       cmd_pending_q_flags);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
 
-	spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, cmd_flags);
+	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 	ret = mwifiex_dnld_cmd_to_fw(priv, cmd_node);
 	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 	/* Any command sent to the firmware when host is in sleep
@@ -822,7 +812,6 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 	uint16_t orig_cmdresp_no;
 	uint16_t cmdresp_no;
 	uint16_t cmdresp_result;
-	unsigned long flags;
 
 	if (!adapter->curr_cmd || !adapter->curr_cmd->resp_skb) {
 		resp = (struct host_cmd_ds_command *) adapter->upld_buf;
@@ -891,9 +880,9 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 			adapter->cmd_wait_q.status = -1;
 
 		mwifiex_recycle_cmd_node(adapter, adapter->curr_cmd);
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		adapter->curr_cmd = NULL;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 		return -1;
 	}
 
@@ -925,9 +914,9 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 
 		mwifiex_recycle_cmd_node(adapter, adapter->curr_cmd);
 
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		adapter->curr_cmd = NULL;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 	}
 
 	return ret;
@@ -1033,17 +1022,16 @@ void
 mwifiex_cancel_pending_scan_cmd(struct mwifiex_adapter *adapter)
 {
 	struct cmd_ctrl_node *cmd_node = NULL, *tmp_node;
-	unsigned long flags;
 
 	/* Cancel all pending scan command */
-	spin_lock_irqsave(&adapter->scan_pending_q_lock, flags);
+	spin_lock_bh(&adapter->scan_pending_q_lock);
 	list_for_each_entry_safe(cmd_node, tmp_node,
 				 &adapter->scan_pending_q, list) {
 		list_del(&cmd_node->list);
 		cmd_node->wait_q_enabled = false;
 		mwifiex_insert_cmd_to_free_q(adapter, cmd_node);
 	}
-	spin_unlock_irqrestore(&adapter->scan_pending_q_lock, flags);
+	spin_unlock_bh(&adapter->scan_pending_q_lock);
 }
 
 /*
@@ -1057,9 +1045,8 @@ void
 mwifiex_cancel_all_pending_cmd(struct mwifiex_adapter *adapter)
 {
 	struct cmd_ctrl_node *cmd_node = NULL, *tmp_node;
-	unsigned long flags, cmd_flags;
 
-	spin_lock_irqsave(&adapter->mwifiex_cmd_lock, cmd_flags);
+	spin_lock_bh(&adapter->mwifiex_cmd_lock);
 	/* Cancel current cmd */
 	if ((adapter->curr_cmd) && (adapter->curr_cmd->wait_q_enabled)) {
 		adapter->cmd_wait_q.status = -1;
@@ -1068,7 +1055,7 @@ mwifiex_cancel_all_pending_cmd(struct mwifiex_adapter *adapter)
 		/* no recycle probably wait for response */
 	}
 	/* Cancel all pending command */
-	spin_lock_irqsave(&adapter->cmd_pending_q_lock, flags);
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
 	list_for_each_entry_safe(cmd_node, tmp_node,
 				 &adapter->cmd_pending_q, list) {
 		list_del(&cmd_node->list);
@@ -1077,8 +1064,8 @@ mwifiex_cancel_all_pending_cmd(struct mwifiex_adapter *adapter)
 			adapter->cmd_wait_q.status = -1;
 		mwifiex_recycle_cmd_node(adapter, cmd_node);
 	}
-	spin_unlock_irqrestore(&adapter->cmd_pending_q_lock, flags);
-	spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, cmd_flags);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 
 	mwifiex_cancel_scan(adapter);
 }
@@ -1097,11 +1084,10 @@ static void
 mwifiex_cancel_pending_ioctl(struct mwifiex_adapter *adapter)
 {
 	struct cmd_ctrl_node *cmd_node = NULL;
-	unsigned long cmd_flags;
 
 	if ((adapter->curr_cmd) &&
 	    (adapter->curr_cmd->wait_q_enabled)) {
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, cmd_flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		cmd_node = adapter->curr_cmd;
 		/* setting curr_cmd to NULL is quite dangerous, because
 		 * mwifiex_process_cmdresp checks curr_cmd to be != NULL
@@ -1112,7 +1098,7 @@ mwifiex_cancel_pending_ioctl(struct mwifiex_adapter *adapter)
 		 * at that point
 		 */
 		adapter->curr_cmd = NULL;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, cmd_flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 
 		mwifiex_recycle_cmd_node(adapter, cmd_node);
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 673e89dff0b5..6c0e52eb8794 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -36,7 +36,6 @@ static int mwifiex_add_bss_prio_tbl(struct mwifiex_private *priv)
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct mwifiex_bss_prio_node *bss_prio;
 	struct mwifiex_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
-	unsigned long flags;
 
 	bss_prio = kzalloc(sizeof(struct mwifiex_bss_prio_node), GFP_KERNEL);
 	if (!bss_prio)
@@ -45,9 +44,9 @@ static int mwifiex_add_bss_prio_tbl(struct mwifiex_private *priv)
 	bss_prio->priv = priv;
 	INIT_LIST_HEAD(&bss_prio->list);
 
-	spin_lock_irqsave(&tbl[priv->bss_priority].bss_prio_lock, flags);
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
 	list_add_tail(&bss_prio->list, &tbl[priv->bss_priority].bss_prio_head);
-	spin_unlock_irqrestore(&tbl[priv->bss_priority].bss_prio_lock, flags);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
 
 	return 0;
 }
@@ -344,11 +343,9 @@ void mwifiex_set_trans_start(struct net_device *dev)
 void mwifiex_wake_up_net_dev_queue(struct net_device *netdev,
 					struct mwifiex_adapter *adapter)
 {
-	unsigned long dev_queue_flags;
-
-	spin_lock_irqsave(&adapter->queue_lock, dev_queue_flags);
+	spin_lock_bh(&adapter->queue_lock);
 	netif_tx_wake_all_queues(netdev);
-	spin_unlock_irqrestore(&adapter->queue_lock, dev_queue_flags);
+	spin_unlock_bh(&adapter->queue_lock);
 }
 
 /*
@@ -357,11 +354,9 @@ void mwifiex_wake_up_net_dev_queue(struct net_device *netdev,
 void mwifiex_stop_net_dev_queue(struct net_device *netdev,
 					struct mwifiex_adapter *adapter)
 {
-	unsigned long dev_queue_flags;
-
-	spin_lock_irqsave(&adapter->queue_lock, dev_queue_flags);
+	spin_lock_bh(&adapter->queue_lock);
 	netif_tx_stop_all_queues(netdev);
-	spin_unlock_irqrestore(&adapter->queue_lock, dev_queue_flags);
+	spin_unlock_bh(&adapter->queue_lock);
 }
 
 /*
@@ -506,7 +501,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 	struct mwifiex_private *priv;
 	u8 i, first_sta = true;
 	int is_cmd_pend_q_empty;
-	unsigned long flags;
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
 
@@ -547,9 +541,9 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 		}
 	}
 
-	spin_lock_irqsave(&adapter->cmd_pending_q_lock, flags);
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
 	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
-	spin_unlock_irqrestore(&adapter->cmd_pending_q_lock, flags);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
 	if (!is_cmd_pend_q_empty) {
 		/* Send the first command in queue and return */
 		if (mwifiex_main_process(adapter) != -1)
@@ -574,7 +568,6 @@ static void mwifiex_delete_bss_prio_tbl(struct mwifiex_private *priv)
 	struct mwifiex_bss_prio_node *bssprio_node, *tmp_node;
 	struct list_head *head;
 	spinlock_t *lock; /* bss priority lock */
-	unsigned long flags;
 
 	for (i = 0; i < adapter->priv_num; ++i) {
 		head = &adapter->bss_prio_tbl[i].bss_prio_head;
@@ -586,7 +579,7 @@ static void mwifiex_delete_bss_prio_tbl(struct mwifiex_private *priv)
 			    priv->bss_type, priv->bss_num, i, head);
 
 		{
-			spin_lock_irqsave(lock, flags);
+			spin_lock_bh(lock);
 			list_for_each_entry_safe(bssprio_node, tmp_node, head,
 						 list) {
 				if (bssprio_node->priv == priv) {
@@ -598,7 +591,7 @@ static void mwifiex_delete_bss_prio_tbl(struct mwifiex_private *priv)
 					kfree(bssprio_node);
 				}
 			}
-			spin_unlock_irqrestore(lock, flags);
+			spin_unlock_bh(lock);
 		}
 	}
 }
@@ -630,7 +623,6 @@ mwifiex_shutdown_drv(struct mwifiex_adapter *adapter)
 {
 	struct mwifiex_private *priv;
 	s32 i;
-	unsigned long flags;
 	struct sk_buff *skb;
 
 	/* mwifiex already shutdown */
@@ -665,7 +657,7 @@ mwifiex_shutdown_drv(struct mwifiex_adapter *adapter)
 	while ((skb = skb_dequeue(&adapter->tx_data_q)))
 		mwifiex_write_data_complete(adapter, skb, 0, 0);
 
-	spin_lock_irqsave(&adapter->rx_proc_lock, flags);
+	spin_lock_bh(&adapter->rx_proc_lock);
 
 	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
 		struct mwifiex_rxinfo *rx_info = MWIFIEX_SKB_RXCB(skb);
@@ -678,7 +670,7 @@ mwifiex_shutdown_drv(struct mwifiex_adapter *adapter)
 		dev_kfree_skb_any(skb);
 	}
 
-	spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+	spin_unlock_bh(&adapter->rx_proc_lock);
 
 	mwifiex_adapter_cleanup(adapter);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 4c14b4865367..a9657ae6d782 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -173,30 +173,27 @@ EXPORT_SYMBOL_GPL(mwifiex_queue_main_work);
 
 static void mwifiex_queue_rx_work(struct mwifiex_adapter *adapter)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&adapter->rx_proc_lock, flags);
+	spin_lock_bh(&adapter->rx_proc_lock);
 	if (adapter->rx_processing) {
-		spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+		spin_unlock_bh(&adapter->rx_proc_lock);
 	} else {
-		spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+		spin_unlock_bh(&adapter->rx_proc_lock);
 		queue_work(adapter->rx_workqueue, &adapter->rx_work);
 	}
 }
 
 static int mwifiex_process_rx(struct mwifiex_adapter *adapter)
 {
-	unsigned long flags;
 	struct sk_buff *skb;
 	struct mwifiex_rxinfo *rx_info;
 
-	spin_lock_irqsave(&adapter->rx_proc_lock, flags);
+	spin_lock_bh(&adapter->rx_proc_lock);
 	if (adapter->rx_processing || adapter->rx_locked) {
-		spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+		spin_unlock_bh(&adapter->rx_proc_lock);
 		goto exit_rx_proc;
 	} else {
 		adapter->rx_processing = true;
-		spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+		spin_unlock_bh(&adapter->rx_proc_lock);
 	}
 
 	/* Check for Rx data */
@@ -219,9 +216,9 @@ static int mwifiex_process_rx(struct mwifiex_adapter *adapter)
 			mwifiex_handle_rx_packet(adapter, skb);
 		}
 	}
-	spin_lock_irqsave(&adapter->rx_proc_lock, flags);
+	spin_lock_bh(&adapter->rx_proc_lock);
 	adapter->rx_processing = false;
-	spin_unlock_irqrestore(&adapter->rx_proc_lock, flags);
+	spin_unlock_bh(&adapter->rx_proc_lock);
 
 exit_rx_proc:
 	return 0;
@@ -825,13 +822,12 @@ mwifiex_clone_skb_for_tx_status(struct mwifiex_private *priv,
 
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (skb) {
-		unsigned long flags;
 		int id;
 
-		spin_lock_irqsave(&priv->ack_status_lock, flags);
+		spin_lock_bh(&priv->ack_status_lock);
 		id = idr_alloc(&priv->ack_status_frames, orig_skb,
 			       1, 0x10, GFP_ATOMIC);
-		spin_unlock_irqrestore(&priv->ack_status_lock, flags);
+		spin_unlock_bh(&priv->ack_status_lock);
 
 		if (id >= 0) {
 			tx_info = MWIFIEX_SKB_TXCB(skb);
@@ -1354,12 +1350,11 @@ void mwifiex_init_priv_params(struct mwifiex_private *priv,
  */
 int is_command_pending(struct mwifiex_adapter *adapter)
 {
-	unsigned long flags;
 	int is_cmd_pend_q_empty;
 
-	spin_lock_irqsave(&adapter->cmd_pending_q_lock, flags);
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
 	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
-	spin_unlock_irqrestore(&adapter->cmd_pending_q_lock, flags);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
 
 	return !is_cmd_pend_q_empty;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 935778ec9a1b..d1515f5c1fba 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1481,7 +1481,6 @@ int mwifiex_scan_networks(struct mwifiex_private *priv,
 	u8 filtered_scan;
 	u8 scan_current_chan_only;
 	u8 max_chan_per_scan;
-	unsigned long flags;
 
 	if (adapter->scan_processing) {
 		mwifiex_dbg(adapter, WARN,
@@ -1502,9 +1501,9 @@ int mwifiex_scan_networks(struct mwifiex_private *priv,
 		return -EFAULT;
 	}
 
-	spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+	spin_lock_bh(&adapter->mwifiex_cmd_lock);
 	adapter->scan_processing = true;
-	spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 
 	scan_cfg_out = kzalloc(sizeof(union mwifiex_scan_cmd_config_tlv),
 			       GFP_KERNEL);
@@ -1532,13 +1531,12 @@ int mwifiex_scan_networks(struct mwifiex_private *priv,
 
 	/* Get scan command from scan_pending_q and put to cmd_pending_q */
 	if (!ret) {
-		spin_lock_irqsave(&adapter->scan_pending_q_lock, flags);
+		spin_lock_bh(&adapter->scan_pending_q_lock);
 		if (!list_empty(&adapter->scan_pending_q)) {
 			cmd_node = list_first_entry(&adapter->scan_pending_q,
 						    struct cmd_ctrl_node, list);
 			list_del(&cmd_node->list);
-			spin_unlock_irqrestore(&adapter->scan_pending_q_lock,
-					       flags);
+			spin_unlock_bh(&adapter->scan_pending_q_lock);
 			mwifiex_insert_cmd_to_pending_q(adapter, cmd_node);
 			queue_work(adapter->workqueue, &adapter->main_work);
 
@@ -1549,8 +1547,7 @@ int mwifiex_scan_networks(struct mwifiex_private *priv,
 				mwifiex_wait_queue_complete(adapter, cmd_node);
 			}
 		} else {
-			spin_unlock_irqrestore(&adapter->scan_pending_q_lock,
-					       flags);
+			spin_unlock_bh(&adapter->scan_pending_q_lock);
 		}
 	}
 
@@ -1558,9 +1555,9 @@ int mwifiex_scan_networks(struct mwifiex_private *priv,
 	kfree(scan_chan_list);
 done:
 	if (ret) {
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		adapter->scan_processing = false;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 	}
 	return ret;
 }
@@ -1696,7 +1693,6 @@ static int mwifiex_update_curr_bss_params(struct mwifiex_private *priv,
 {
 	struct mwifiex_bssdescriptor *bss_desc;
 	int ret;
-	unsigned long flags;
 
 	/* Allocate and fill new bss descriptor */
 	bss_desc = kzalloc(sizeof(struct mwifiex_bssdescriptor), GFP_KERNEL);
@@ -1711,7 +1707,7 @@ static int mwifiex_update_curr_bss_params(struct mwifiex_private *priv,
 	if (ret)
 		goto done;
 
-	spin_lock_irqsave(&priv->curr_bcn_buf_lock, flags);
+	spin_lock_bh(&priv->curr_bcn_buf_lock);
 	/* Make a copy of current BSSID descriptor */
 	memcpy(&priv->curr_bss_params.bss_descriptor, bss_desc,
 	       sizeof(priv->curr_bss_params.bss_descriptor));
@@ -1720,7 +1716,7 @@ static int mwifiex_update_curr_bss_params(struct mwifiex_private *priv,
 	 * in mwifiex_save_curr_bcn()
 	 */
 	mwifiex_save_curr_bcn(priv);
-	spin_unlock_irqrestore(&priv->curr_bcn_buf_lock, flags);
+	spin_unlock_bh(&priv->curr_bcn_buf_lock);
 
 done:
 	/* beacon_ie buffer was allocated in function
@@ -1974,15 +1970,14 @@ static void mwifiex_check_next_scan_command(struct mwifiex_private *priv)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct cmd_ctrl_node *cmd_node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&adapter->scan_pending_q_lock, flags);
+	spin_lock_bh(&adapter->scan_pending_q_lock);
 	if (list_empty(&adapter->scan_pending_q)) {
-		spin_unlock_irqrestore(&adapter->scan_pending_q_lock, flags);
+		spin_unlock_bh(&adapter->scan_pending_q_lock);
 
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		adapter->scan_processing = false;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 
 		mwifiex_active_scan_req_for_passive_chan(priv);
 
@@ -2006,13 +2001,13 @@ static void mwifiex_check_next_scan_command(struct mwifiex_private *priv)
 		}
 	} else if ((priv->scan_aborting && !priv->scan_request) ||
 		   priv->scan_block) {
-		spin_unlock_irqrestore(&adapter->scan_pending_q_lock, flags);
+		spin_unlock_bh(&adapter->scan_pending_q_lock);
 
 		mwifiex_cancel_pending_scan_cmd(adapter);
 
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		adapter->scan_processing = false;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 
 		if (!adapter->active_scan_triggered) {
 			if (priv->scan_request) {
@@ -2038,7 +2033,7 @@ static void mwifiex_check_next_scan_command(struct mwifiex_private *priv)
 		cmd_node = list_first_entry(&adapter->scan_pending_q,
 					    struct cmd_ctrl_node, list);
 		list_del(&cmd_node->list);
-		spin_unlock_irqrestore(&adapter->scan_pending_q_lock, flags);
+		spin_unlock_bh(&adapter->scan_pending_q_lock);
 		mwifiex_insert_cmd_to_pending_q(adapter, cmd_node);
 	}
 
@@ -2048,15 +2043,14 @@ static void mwifiex_check_next_scan_command(struct mwifiex_private *priv)
 void mwifiex_cancel_scan(struct mwifiex_adapter *adapter)
 {
 	struct mwifiex_private *priv;
-	unsigned long cmd_flags;
 	int i;
 
 	mwifiex_cancel_pending_scan_cmd(adapter);
 
 	if (adapter->scan_processing) {
-		spin_lock_irqsave(&adapter->mwifiex_cmd_lock, cmd_flags);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
 		adapter->scan_processing = false;
-		spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, cmd_flags);
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 		for (i = 0; i < adapter->priv_num; i++) {
 			priv = adapter->priv[i];
 			if (!priv)
@@ -2538,7 +2532,6 @@ int mwifiex_ret_802_11_scan_ext(struct mwifiex_private *priv,
 
 	struct host_cmd_ds_command *cmd_ptr;
 	struct cmd_ctrl_node *cmd_node;
-	unsigned long cmd_flags, scan_flags;
 	bool complete_scan = false;
 
 	mwifiex_dbg(adapter, INFO, "info: EXT scan returns successfully\n");
@@ -2573,8 +2566,8 @@ int mwifiex_ret_802_11_scan_ext(struct mwifiex_private *priv,
 			       sizeof(struct mwifiex_ie_types_header));
 	}
 
-	spin_lock_irqsave(&adapter->cmd_pending_q_lock, cmd_flags);
-	spin_lock_irqsave(&adapter->scan_pending_q_lock, scan_flags);
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	spin_lock_bh(&adapter->scan_pending_q_lock);
 	if (list_empty(&adapter->scan_pending_q)) {
 		complete_scan = true;
 		list_for_each_entry(cmd_node, &adapter->cmd_pending_q, list) {
@@ -2588,8 +2581,8 @@ int mwifiex_ret_802_11_scan_ext(struct mwifiex_private *priv,
 			}
 		}
 	}
-	spin_unlock_irqrestore(&adapter->scan_pending_q_lock, scan_flags);
-	spin_unlock_irqrestore(&adapter->cmd_pending_q_lock, cmd_flags);
+	spin_unlock_bh(&adapter->scan_pending_q_lock);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
 
 	if (complete_scan)
 		mwifiex_complete_scan(priv);
@@ -2761,13 +2754,12 @@ mwifiex_queue_scan_cmd(struct mwifiex_private *priv,
 		       struct cmd_ctrl_node *cmd_node)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
-	unsigned long flags;
 
 	cmd_node->wait_q_enabled = true;
 	cmd_node->condition = &adapter->scan_wait_q_woken;
-	spin_lock_irqsave(&adapter->scan_pending_q_lock, flags);
+	spin_lock_bh(&adapter->scan_pending_q_lock);
 	list_add_tail(&cmd_node->list, &adapter->scan_pending_q);
-	spin_unlock_irqrestore(&adapter->scan_pending_q_lock, flags);
+	spin_unlock_bh(&adapter->scan_pending_q_lock);
 }
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 24b33e20e7a9..20c206da0631 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -46,7 +46,6 @@ mwifiex_process_cmdresp_error(struct mwifiex_private *priv,
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct host_cmd_ds_802_11_ps_mode_enh *pm;
-	unsigned long flags;
 
 	mwifiex_dbg(adapter, ERROR,
 		    "CMD_RESP: cmd %#x error, result=%#x\n",
@@ -87,9 +86,9 @@ mwifiex_process_cmdresp_error(struct mwifiex_private *priv,
 	/* Handling errors here */
 	mwifiex_recycle_cmd_node(adapter, adapter->curr_cmd);
 
-	spin_lock_irqsave(&adapter->mwifiex_cmd_lock, flags);
+	spin_lock_bh(&adapter->mwifiex_cmd_lock);
 	adapter->curr_cmd = NULL;
-	spin_unlock_irqrestore(&adapter->mwifiex_cmd_lock, flags);
+	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 }
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 8b3123cb84c8..5fdffb114913 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -345,7 +345,6 @@ static void mwifiex_process_uap_tx_pause(struct mwifiex_private *priv,
 {
 	struct mwifiex_tx_pause_tlv *tp;
 	struct mwifiex_sta_node *sta_ptr;
-	unsigned long flags;
 
 	tp = (void *)tlv;
 	mwifiex_dbg(priv->adapter, EVENT,
@@ -361,14 +360,14 @@ static void mwifiex_process_uap_tx_pause(struct mwifiex_private *priv,
 	} else if (is_multicast_ether_addr(tp->peermac)) {
 		mwifiex_update_ralist_tx_pause(priv, tp->peermac, tp->tx_pause);
 	} else {
-		spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+		spin_lock_bh(&priv->sta_list_spinlock);
 		sta_ptr = mwifiex_get_sta_entry(priv, tp->peermac);
 		if (sta_ptr && sta_ptr->tx_pause != tp->tx_pause) {
 			sta_ptr->tx_pause = tp->tx_pause;
 			mwifiex_update_ralist_tx_pause(priv, tp->peermac,
 						       tp->tx_pause);
 		}
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 	}
 }
 
@@ -378,7 +377,6 @@ static void mwifiex_process_sta_tx_pause(struct mwifiex_private *priv,
 	struct mwifiex_tx_pause_tlv *tp;
 	struct mwifiex_sta_node *sta_ptr;
 	int status;
-	unsigned long flags;
 
 	tp = (void *)tlv;
 	mwifiex_dbg(priv->adapter, EVENT,
@@ -397,7 +395,7 @@ static void mwifiex_process_sta_tx_pause(struct mwifiex_private *priv,
 
 		status = mwifiex_get_tdls_link_status(priv, tp->peermac);
 		if (mwifiex_is_tdls_link_setup(status)) {
-			spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+			spin_lock_bh(&priv->sta_list_spinlock);
 			sta_ptr = mwifiex_get_sta_entry(priv, tp->peermac);
 			if (sta_ptr && sta_ptr->tx_pause != tp->tx_pause) {
 				sta_ptr->tx_pause = tp->tx_pause;
@@ -405,7 +403,7 @@ static void mwifiex_process_sta_tx_pause(struct mwifiex_private *priv,
 							       tp->peermac,
 							       tp->tx_pause);
 			}
-			spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+			spin_unlock_bh(&priv->sta_list_spinlock);
 		}
 	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 27779d7317fd..18e654dc34c6 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -33,12 +33,11 @@ static void mwifiex_restore_tdls_packets(struct mwifiex_private *priv,
 	struct list_head *tid_list;
 	struct sk_buff *skb, *tmp;
 	struct mwifiex_txinfo *tx_info;
-	unsigned long flags;
 	u32 tid;
 	u8 tid_down;
 
 	mwifiex_dbg(priv->adapter, DATA, "%s: %pM\n", __func__, mac);
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	skb_queue_walk_safe(&priv->tdls_txq, skb, tmp) {
 		if (!ether_addr_equal(mac, skb->data))
@@ -78,7 +77,7 @@ static void mwifiex_restore_tdls_packets(struct mwifiex_private *priv,
 		atomic_inc(&priv->wmm.tx_pkts_queued);
 	}
 
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 	return;
 }
 
@@ -88,11 +87,10 @@ static void mwifiex_hold_tdls_packets(struct mwifiex_private *priv,
 	struct mwifiex_ra_list_tbl *ra_list;
 	struct list_head *ra_list_head;
 	struct sk_buff *skb, *tmp;
-	unsigned long flags;
 	int i;
 
 	mwifiex_dbg(priv->adapter, DATA, "%s: %pM\n", __func__, mac);
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	for (i = 0; i < MAX_NUM_TID; i++) {
 		if (!list_empty(&priv->wmm.tid_tbl_ptr[i].ra_list)) {
@@ -111,7 +109,7 @@ static void mwifiex_hold_tdls_packets(struct mwifiex_private *priv,
 		}
 	}
 
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 	return;
 }
 
@@ -1070,7 +1068,6 @@ mwifiex_tdls_process_disable_link(struct mwifiex_private *priv, const u8 *peer)
 {
 	struct mwifiex_sta_node *sta_ptr;
 	struct mwifiex_ds_tdls_oper tdls_oper;
-	unsigned long flags;
 
 	memset(&tdls_oper, 0, sizeof(struct mwifiex_ds_tdls_oper));
 	sta_ptr = mwifiex_get_sta_entry(priv, peer);
@@ -1078,11 +1075,9 @@ mwifiex_tdls_process_disable_link(struct mwifiex_private *priv, const u8 *peer)
 	if (sta_ptr) {
 		if (sta_ptr->is_11n_enabled) {
 			mwifiex_11n_cleanup_reorder_tbl(priv);
-			spin_lock_irqsave(&priv->wmm.ra_list_spinlock,
-					  flags);
+			spin_lock_bh(&priv->wmm.ra_list_spinlock);
 			mwifiex_11n_delete_all_tx_ba_stream_tbl(priv);
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		}
 		mwifiex_del_sta_entry(priv, peer);
 	}
@@ -1100,7 +1095,6 @@ mwifiex_tdls_process_enable_link(struct mwifiex_private *priv, const u8 *peer)
 {
 	struct mwifiex_sta_node *sta_ptr;
 	struct ieee80211_mcs_info mcs;
-	unsigned long flags;
 	int i;
 
 	sta_ptr = mwifiex_get_sta_entry(priv, peer);
@@ -1145,11 +1139,9 @@ mwifiex_tdls_process_enable_link(struct mwifiex_private *priv, const u8 *peer)
 			    "tdls: enable link %pM failed\n", peer);
 		if (sta_ptr) {
 			mwifiex_11n_cleanup_reorder_tbl(priv);
-			spin_lock_irqsave(&priv->wmm.ra_list_spinlock,
-					  flags);
+			spin_lock_bh(&priv->wmm.ra_list_spinlock);
 			mwifiex_11n_delete_all_tx_ba_stream_tbl(priv);
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 			mwifiex_del_sta_entry(priv, peer);
 		}
 		mwifiex_restore_tdls_packets(priv, peer, TDLS_LINK_TEARDOWN);
@@ -1194,7 +1186,6 @@ int mwifiex_get_tdls_list(struct mwifiex_private *priv,
 	struct mwifiex_sta_node *sta_ptr;
 	struct tdls_peer_info *peer = buf;
 	int count = 0;
-	unsigned long flags;
 
 	if (!ISSUPP_TDLS_ENABLED(priv->adapter->fw_cap_info))
 		return 0;
@@ -1203,7 +1194,7 @@ int mwifiex_get_tdls_list(struct mwifiex_private *priv,
 	if (!(priv->bss_type == MWIFIEX_BSS_TYPE_STA && priv->media_connected))
 		return 0;
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 	list_for_each_entry(sta_ptr, &priv->sta_list, list) {
 		if (mwifiex_is_tdls_link_setup(sta_ptr->tdls_status)) {
 			ether_addr_copy(peer->peer_addr, sta_ptr->mac_addr);
@@ -1213,7 +1204,7 @@ int mwifiex_get_tdls_list(struct mwifiex_private *priv,
 				break;
 		}
 	}
-	spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+	spin_unlock_bh(&priv->sta_list_spinlock);
 
 	return count;
 }
@@ -1222,7 +1213,6 @@ void mwifiex_disable_all_tdls_links(struct mwifiex_private *priv)
 {
 	struct mwifiex_sta_node *sta_ptr;
 	struct mwifiex_ds_tdls_oper tdls_oper;
-	unsigned long flags;
 
 	if (list_empty(&priv->sta_list))
 		return;
@@ -1232,11 +1222,9 @@ void mwifiex_disable_all_tdls_links(struct mwifiex_private *priv)
 
 		if (sta_ptr->is_11n_enabled) {
 			mwifiex_11n_cleanup_reorder_tbl(priv);
-			spin_lock_irqsave(&priv->wmm.ra_list_spinlock,
-					  flags);
+			spin_lock_bh(&priv->wmm.ra_list_spinlock);
 			mwifiex_11n_delete_all_tx_ba_stream_tbl(priv);
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		}
 
 		mwifiex_restore_tdls_packets(priv, sta_ptr->mac_addr,
@@ -1256,12 +1244,11 @@ void mwifiex_disable_all_tdls_links(struct mwifiex_private *priv)
 int mwifiex_tdls_check_tx(struct mwifiex_private *priv, struct sk_buff *skb)
 {
 	struct mwifiex_auto_tdls_peer *peer;
-	unsigned long flags;
 	u8 mac[ETH_ALEN];
 
 	ether_addr_copy(mac, skb->data);
 
-	spin_lock_irqsave(&priv->auto_tdls_lock, flags);
+	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry(peer, &priv->auto_tdls_list, list) {
 		if (!memcmp(mac, peer->mac_addr, ETH_ALEN)) {
 			if (peer->rssi <= MWIFIEX_TDLS_RSSI_HIGH &&
@@ -1290,7 +1277,7 @@ int mwifiex_tdls_check_tx(struct mwifiex_private *priv, struct sk_buff *skb)
 			}
 		}
 	}
-	spin_unlock_irqrestore(&priv->auto_tdls_lock, flags);
+	spin_unlock_bh(&priv->auto_tdls_lock);
 
 	return 0;
 }
@@ -1298,33 +1285,31 @@ int mwifiex_tdls_check_tx(struct mwifiex_private *priv, struct sk_buff *skb)
 void mwifiex_flush_auto_tdls_list(struct mwifiex_private *priv)
 {
 	struct mwifiex_auto_tdls_peer *peer, *tmp_node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->auto_tdls_lock, flags);
+	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry_safe(peer, tmp_node, &priv->auto_tdls_list, list) {
 		list_del(&peer->list);
 		kfree(peer);
 	}
 
 	INIT_LIST_HEAD(&priv->auto_tdls_list);
-	spin_unlock_irqrestore(&priv->auto_tdls_lock, flags);
+	spin_unlock_bh(&priv->auto_tdls_lock);
 	priv->check_tdls_tx = false;
 }
 
 void mwifiex_add_auto_tdls_peer(struct mwifiex_private *priv, const u8 *mac)
 {
 	struct mwifiex_auto_tdls_peer *tdls_peer;
-	unsigned long flags;
 
 	if (!priv->adapter->auto_tdls)
 		return;
 
-	spin_lock_irqsave(&priv->auto_tdls_lock, flags);
+	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry(tdls_peer, &priv->auto_tdls_list, list) {
 		if (!memcmp(tdls_peer->mac_addr, mac, ETH_ALEN)) {
 			tdls_peer->tdls_status = TDLS_SETUP_INPROGRESS;
 			tdls_peer->rssi_jiffies = jiffies;
-			spin_unlock_irqrestore(&priv->auto_tdls_lock, flags);
+			spin_unlock_bh(&priv->auto_tdls_lock);
 			return;
 		}
 	}
@@ -1341,19 +1326,18 @@ void mwifiex_add_auto_tdls_peer(struct mwifiex_private *priv, const u8 *mac)
 			    "Add auto TDLS peer= %pM to list\n", mac);
 	}
 
-	spin_unlock_irqrestore(&priv->auto_tdls_lock, flags);
+	spin_unlock_bh(&priv->auto_tdls_lock);
 }
 
 void mwifiex_auto_tdls_update_peer_status(struct mwifiex_private *priv,
 					  const u8 *mac, u8 link_status)
 {
 	struct mwifiex_auto_tdls_peer *peer;
-	unsigned long flags;
 
 	if (!priv->adapter->auto_tdls)
 		return;
 
-	spin_lock_irqsave(&priv->auto_tdls_lock, flags);
+	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry(peer, &priv->auto_tdls_list, list) {
 		if (!memcmp(peer->mac_addr, mac, ETH_ALEN)) {
 			if ((link_status == TDLS_NOT_SETUP) &&
@@ -1366,19 +1350,18 @@ void mwifiex_auto_tdls_update_peer_status(struct mwifiex_private *priv,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&priv->auto_tdls_lock, flags);
+	spin_unlock_bh(&priv->auto_tdls_lock);
 }
 
 void mwifiex_auto_tdls_update_peer_signal(struct mwifiex_private *priv,
 					  u8 *mac, s8 snr, s8 nflr)
 {
 	struct mwifiex_auto_tdls_peer *peer;
-	unsigned long flags;
 
 	if (!priv->adapter->auto_tdls)
 		return;
 
-	spin_lock_irqsave(&priv->auto_tdls_lock, flags);
+	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry(peer, &priv->auto_tdls_list, list) {
 		if (!memcmp(peer->mac_addr, mac, ETH_ALEN)) {
 			peer->rssi = nflr - snr;
@@ -1386,14 +1369,13 @@ void mwifiex_auto_tdls_update_peer_signal(struct mwifiex_private *priv,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&priv->auto_tdls_lock, flags);
+	spin_unlock_bh(&priv->auto_tdls_lock);
 }
 
 void mwifiex_check_auto_tdls(struct timer_list *t)
 {
 	struct mwifiex_private *priv = from_timer(priv, t, auto_tdls_timer);
 	struct mwifiex_auto_tdls_peer *tdls_peer;
-	unsigned long flags;
 	u16 reason = WLAN_REASON_TDLS_TEARDOWN_UNSPECIFIED;
 
 	if (WARN_ON_ONCE(!priv || !priv->adapter)) {
@@ -1413,7 +1395,7 @@ void mwifiex_check_auto_tdls(struct timer_list *t)
 
 	priv->check_tdls_tx = false;
 
-	spin_lock_irqsave(&priv->auto_tdls_lock, flags);
+	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry(tdls_peer, &priv->auto_tdls_list, list) {
 		if ((jiffies - tdls_peer->rssi_jiffies) >
 		    (MWIFIEX_AUTO_TDLS_IDLE_TIME * HZ)) {
@@ -1448,7 +1430,7 @@ void mwifiex_check_auto_tdls(struct timer_list *t)
 					    tdls_peer->rssi);
 		}
 	}
-	spin_unlock_irqrestore(&priv->auto_tdls_lock, flags);
+	spin_unlock_bh(&priv->auto_tdls_lock);
 
 	mod_timer(&priv->auto_tdls_timer,
 		  jiffies + msecs_to_jiffies(MWIFIEX_TIMER_10S));
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index d848933466d9..e3c1446dd847 100644
--- a/drivers/net/wireless/marvell/mwifiex/txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
@@ -334,15 +334,14 @@ void mwifiex_parse_tx_status_event(struct mwifiex_private *priv,
 {
 	struct tx_status_event *tx_status = (void *)priv->adapter->event_body;
 	struct sk_buff *ack_skb;
-	unsigned long flags;
 	struct mwifiex_txinfo *tx_info;
 
 	if (!tx_status->tx_token_id)
 		return;
 
-	spin_lock_irqsave(&priv->ack_status_lock, flags);
+	spin_lock_bh(&priv->ack_status_lock);
 	ack_skb = idr_remove(&priv->ack_status_frames, tx_status->tx_token_id);
-	spin_unlock_irqrestore(&priv->ack_status_lock, flags);
+	spin_unlock_bh(&priv->ack_status_lock);
 
 	if (ack_skb) {
 		tx_info = MWIFIEX_SKB_TXCB(ack_skb);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 5ce85d5727e4..354b09c5e8dc 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -71,11 +71,10 @@ mwifiex_uap_del_tx_pkts_in_ralist(struct mwifiex_private *priv,
  */
 static void mwifiex_uap_cleanup_tx_queues(struct mwifiex_private *priv)
 {
-	unsigned long flags;
 	struct list_head *ra_list;
 	int i;
 
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	for (i = 0; i < MAX_NUM_TID; i++, priv->del_list_idx++) {
 		if (priv->del_list_idx == MAX_NUM_TID)
@@ -87,7 +86,7 @@ static void mwifiex_uap_cleanup_tx_queues(struct mwifiex_private *priv)
 		}
 	}
 
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 }
 
 
@@ -378,7 +377,6 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	struct rx_packet_hdr *rx_pkt_hdr;
 	u16 rx_pkt_type;
 	u8 ta[ETH_ALEN], pkt_type;
-	unsigned long flags;
 	struct mwifiex_sta_node *node;
 
 	uap_rx_pd = (struct uap_rxpd *)(skb->data);
@@ -413,12 +411,12 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 
 
 	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
-		spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+		spin_lock_bh(&priv->sta_list_spinlock);
 		node = mwifiex_get_sta_entry(priv, ta);
 		if (node)
 			node->rx_seq[uap_rx_pd->priority] =
 						le16_to_cpu(uap_rx_pd->seq_num);
-		spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+		spin_unlock_bh(&priv->sta_list_spinlock);
 	}
 
 	if (!priv->ap_11n_enabled ||
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index d445acc4786b..c2365eeb7016 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -1128,10 +1128,9 @@ static void mwifiex_usb_tx_aggr_tmo(struct timer_list *t)
 		from_timer(timer_context, t, hold_timer);
 	struct mwifiex_adapter *adapter = timer_context->adapter;
 	struct usb_tx_data_port *port = timer_context->port;
-	unsigned long flags;
 	int err = 0;
 
-	spin_lock_irqsave(&port->tx_aggr_lock, flags);
+	spin_lock_bh(&port->tx_aggr_lock);
 	err = mwifiex_usb_prepare_tx_aggr_skb(adapter, port, &skb_send);
 	if (err) {
 		mwifiex_dbg(adapter, ERROR,
@@ -1158,7 +1157,7 @@ static void mwifiex_usb_tx_aggr_tmo(struct timer_list *t)
 	if (err == -1)
 		mwifiex_write_data_complete(adapter, skb_send, 0, -1);
 unlock:
-	spin_unlock_irqrestore(&port->tx_aggr_lock, flags);
+	spin_unlock_bh(&port->tx_aggr_lock);
 }
 
 /* This function write a command/data packet to card. */
@@ -1169,7 +1168,6 @@ static int mwifiex_usb_host_to_card(struct mwifiex_adapter *adapter, u8 ep,
 	struct usb_card_rec *card = adapter->card;
 	struct urb_context *context = NULL;
 	struct usb_tx_data_port *port = NULL;
-	unsigned long flags;
 	int idx, ret;
 
 	if (test_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags)) {
@@ -1211,10 +1209,10 @@ static int mwifiex_usb_host_to_card(struct mwifiex_adapter *adapter, u8 ep,
 		}
 
 		if (adapter->bus_aggr.enable) {
-			spin_lock_irqsave(&port->tx_aggr_lock, flags);
+			spin_lock_bh(&port->tx_aggr_lock);
 			ret =  mwifiex_usb_aggr_tx_data(adapter, ep, skb,
 							tx_param, port);
-			spin_unlock_irqrestore(&port->tx_aggr_lock, flags);
+			spin_unlock_bh(&port->tx_aggr_lock);
 			return ret;
 		}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index f9b71539d33e..3b0d31827681 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -607,12 +607,11 @@ struct mwifiex_sta_node *
 mwifiex_add_sta_entry(struct mwifiex_private *priv, const u8 *mac)
 {
 	struct mwifiex_sta_node *node;
-	unsigned long flags;
 
 	if (!mac)
 		return NULL;
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 	node = mwifiex_get_sta_entry(priv, mac);
 	if (node)
 		goto done;
@@ -625,7 +624,7 @@ mwifiex_add_sta_entry(struct mwifiex_private *priv, const u8 *mac)
 	list_add_tail(&node->list, &priv->sta_list);
 
 done:
-	spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+	spin_unlock_bh(&priv->sta_list_spinlock);
 	return node;
 }
 
@@ -662,9 +661,8 @@ mwifiex_set_sta_ht_cap(struct mwifiex_private *priv, const u8 *ies,
 void mwifiex_del_sta_entry(struct mwifiex_private *priv, const u8 *mac)
 {
 	struct mwifiex_sta_node *node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 
 	node = mwifiex_get_sta_entry(priv, mac);
 	if (node) {
@@ -672,7 +670,7 @@ void mwifiex_del_sta_entry(struct mwifiex_private *priv, const u8 *mac)
 		kfree(node);
 	}
 
-	spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+	spin_unlock_bh(&priv->sta_list_spinlock);
 	return;
 }
 
@@ -680,9 +678,8 @@ void mwifiex_del_sta_entry(struct mwifiex_private *priv, const u8 *mac)
 void mwifiex_del_all_sta_list(struct mwifiex_private *priv)
 {
 	struct mwifiex_sta_node *node, *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+	spin_lock_bh(&priv->sta_list_spinlock);
 
 	list_for_each_entry_safe(node, tmp, &priv->sta_list, list) {
 		list_del(&node->list);
@@ -690,7 +687,7 @@ void mwifiex_del_all_sta_list(struct mwifiex_private *priv)
 	}
 
 	INIT_LIST_HEAD(&priv->sta_list);
-	spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+	spin_unlock_bh(&priv->sta_list_spinlock);
 	return;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 407b9932ca4d..0301bc33f554 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -138,7 +138,6 @@ void mwifiex_ralist_add(struct mwifiex_private *priv, const u8 *ra)
 	struct mwifiex_ra_list_tbl *ra_list;
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct mwifiex_sta_node *node;
-	unsigned long flags;
 
 
 	for (i = 0; i < MAX_NUM_TID; ++i) {
@@ -163,7 +162,7 @@ void mwifiex_ralist_add(struct mwifiex_private *priv, const u8 *ra)
 				ra_list->is_11n_enabled = IS_11N_ENABLED(priv);
 			}
 		} else {
-			spin_lock_irqsave(&priv->sta_list_spinlock, flags);
+			spin_lock_bh(&priv->sta_list_spinlock);
 			node = mwifiex_get_sta_entry(priv, ra);
 			if (node)
 				ra_list->tx_paused = node->tx_pause;
@@ -171,7 +170,7 @@ void mwifiex_ralist_add(struct mwifiex_private *priv, const u8 *ra)
 				      mwifiex_is_sta_11n_enabled(priv, node);
 			if (ra_list->is_11n_enabled)
 				ra_list->max_amsdu = node->max_amsdu;
-			spin_unlock_irqrestore(&priv->sta_list_spinlock, flags);
+			spin_unlock_bh(&priv->sta_list_spinlock);
 		}
 
 		mwifiex_dbg(adapter, DATA, "data: ralist %p: is_11n_enabled=%d\n",
@@ -583,11 +582,10 @@ static int mwifiex_free_ack_frame(int id, void *p, void *data)
 void
 mwifiex_clean_txrx(struct mwifiex_private *priv)
 {
-	unsigned long flags;
 	struct sk_buff *skb, *tmp;
 
 	mwifiex_11n_cleanup_reorder_tbl(priv);
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	mwifiex_wmm_cleanup_queues(priv);
 	mwifiex_11n_delete_all_tx_ba_stream_tbl(priv);
@@ -601,7 +599,7 @@ mwifiex_clean_txrx(struct mwifiex_private *priv)
 	if (priv->adapter->if_ops.clean_pcie_ring &&
 	    !test_bit(MWIFIEX_SURPRISE_REMOVED, &priv->adapter->work_flags))
 		priv->adapter->if_ops.clean_pcie_ring(priv->adapter);
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 
 	skb_queue_walk_safe(&priv->tdls_txq, skb, tmp) {
 		skb_unlink(skb, &priv->tdls_txq);
@@ -642,10 +640,9 @@ void mwifiex_update_ralist_tx_pause(struct mwifiex_private *priv, u8 *mac,
 {
 	struct mwifiex_ra_list_tbl *ra_list;
 	u32 pkt_cnt = 0, tx_pkts_queued;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	for (i = 0; i < MAX_NUM_TID; ++i) {
 		ra_list = mwifiex_wmm_get_ralist_node(priv, i, mac);
@@ -671,7 +668,7 @@ void mwifiex_update_ralist_tx_pause(struct mwifiex_private *priv, u8 *mac,
 		atomic_set(&priv->wmm.tx_pkts_queued, tx_pkts_queued);
 		atomic_set(&priv->wmm.highest_queued_prio, HIGH_PRIO_TID);
 	}
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 }
 
 /* This function updates non-tdls peer ralist tx_pause while
@@ -682,10 +679,9 @@ void mwifiex_update_ralist_tx_pause_in_tdls_cs(struct mwifiex_private *priv,
 {
 	struct mwifiex_ra_list_tbl *ra_list;
 	u32 pkt_cnt = 0, tx_pkts_queued;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	for (i = 0; i < MAX_NUM_TID; ++i) {
 		list_for_each_entry(ra_list, &priv->wmm.tid_tbl_ptr[i].ra_list,
@@ -716,7 +712,7 @@ void mwifiex_update_ralist_tx_pause_in_tdls_cs(struct mwifiex_private *priv,
 		atomic_set(&priv->wmm.tx_pkts_queued, tx_pkts_queued);
 		atomic_set(&priv->wmm.highest_queued_prio, HIGH_PRIO_TID);
 	}
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 }
 
 /*
@@ -748,10 +744,9 @@ void
 mwifiex_wmm_del_peer_ra_list(struct mwifiex_private *priv, const u8 *ra_addr)
 {
 	struct mwifiex_ra_list_tbl *ra_list;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	for (i = 0; i < MAX_NUM_TID; ++i) {
 		ra_list = mwifiex_wmm_get_ralist_node(priv, i, ra_addr);
@@ -767,7 +762,7 @@ mwifiex_wmm_del_peer_ra_list(struct mwifiex_private *priv, const u8 *ra_addr)
 		list_del(&ra_list->list);
 		kfree(ra_list);
 	}
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 }
 
 /*
@@ -818,7 +813,6 @@ mwifiex_wmm_add_buf_txqueue(struct mwifiex_private *priv,
 	u32 tid;
 	struct mwifiex_ra_list_tbl *ra_list;
 	u8 ra[ETH_ALEN], tid_down;
-	unsigned long flags;
 	struct list_head list_head;
 	int tdls_status = TDLS_NOT_SETUP;
 	struct ethhdr *eth_hdr = (struct ethhdr *)skb->data;
@@ -844,7 +838,7 @@ mwifiex_wmm_add_buf_txqueue(struct mwifiex_private *priv,
 
 	tid = skb->priority;
 
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 	tid_down = mwifiex_wmm_downgrade_tid(priv, tid);
 
@@ -864,8 +858,7 @@ mwifiex_wmm_add_buf_txqueue(struct mwifiex_private *priv,
 			break;
 		case TDLS_SETUP_INPROGRESS:
 			skb_queue_tail(&priv->tdls_txq, skb);
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 			return;
 		default:
 			list_head = priv->wmm.tid_tbl_ptr[tid_down].ra_list;
@@ -881,7 +874,7 @@ mwifiex_wmm_add_buf_txqueue(struct mwifiex_private *priv,
 	}
 
 	if (!ra_list) {
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		mwifiex_write_data_complete(adapter, skb, 0, -1);
 		return;
 	}
@@ -901,7 +894,7 @@ mwifiex_wmm_add_buf_txqueue(struct mwifiex_private *priv,
 	else
 		atomic_inc(&priv->wmm.tx_pkts_queued);
 
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 }
 
 /*
@@ -1092,7 +1085,6 @@ mwifiex_wmm_get_highest_priolist_ptr(struct mwifiex_adapter *adapter,
 	struct mwifiex_ra_list_tbl *ptr;
 	struct mwifiex_tid_tbl *tid_ptr;
 	atomic_t *hqp;
-	unsigned long flags_ra;
 	int i, j;
 
 	/* check the BSS with highest priority first */
@@ -1118,8 +1110,7 @@ mwifiex_wmm_get_highest_priolist_ptr(struct mwifiex_adapter *adapter,
 			hqp = &priv_tmp->wmm.highest_queued_prio;
 			for (i = atomic_read(hqp); i >= LOW_PRIO_TID; --i) {
 
-				spin_lock_irqsave(&priv_tmp->wmm.
-						  ra_list_spinlock, flags_ra);
+				spin_lock_bh(&priv_tmp->wmm.ra_list_spinlock);
 
 				tid_ptr = &(priv_tmp)->wmm.
 					tid_tbl_ptr[tos_to_tid[i]];
@@ -1134,9 +1125,7 @@ mwifiex_wmm_get_highest_priolist_ptr(struct mwifiex_adapter *adapter,
 						goto found;
 				}
 
-				spin_unlock_irqrestore(&priv_tmp->wmm.
-						       ra_list_spinlock,
-						       flags_ra);
+				spin_unlock_bh(&priv_tmp->wmm.ra_list_spinlock);
 			}
 
 			if (atomic_read(&priv_tmp->wmm.tx_pkts_queued) != 0) {
@@ -1158,7 +1147,7 @@ mwifiex_wmm_get_highest_priolist_ptr(struct mwifiex_adapter *adapter,
 	/* holds ra_list_spinlock */
 	if (atomic_read(hqp) > i)
 		atomic_set(hqp, i);
-	spin_unlock_irqrestore(&priv_tmp->wmm.ra_list_spinlock, flags_ra);
+	spin_unlock_bh(&priv_tmp->wmm.ra_list_spinlock);
 
 	*priv = priv_tmp;
 	*tid = tos_to_tid[i];
@@ -1182,24 +1171,23 @@ void mwifiex_rotate_priolists(struct mwifiex_private *priv,
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct mwifiex_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
 	struct mwifiex_tid_tbl *tid_ptr = &priv->wmm.tid_tbl_ptr[tid];
-	unsigned long flags;
 
-	spin_lock_irqsave(&tbl[priv->bss_priority].bss_prio_lock, flags);
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
 	/*
 	 * dirty trick: we remove 'head' temporarily and reinsert it after
 	 * curr bss node. imagine list to stay fixed while head is moved
 	 */
 	list_move(&tbl[priv->bss_priority].bss_prio_head,
 		  &tbl[priv->bss_priority].bss_prio_cur->list);
-	spin_unlock_irqrestore(&tbl[priv->bss_priority].bss_prio_lock, flags);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
 
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 	if (mwifiex_is_ralist_valid(priv, ra, tid)) {
 		priv->wmm.packets_out[tid]++;
 		/* same as above */
 		list_move(&tid_ptr->ra_list, &ra->list);
 	}
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 }
 
 /*
@@ -1236,8 +1224,7 @@ mwifiex_is_11n_aggragation_possible(struct mwifiex_private *priv,
  */
 static void
 mwifiex_send_single_packet(struct mwifiex_private *priv,
-			   struct mwifiex_ra_list_tbl *ptr, int ptr_index,
-			   unsigned long ra_list_flags)
+			   struct mwifiex_ra_list_tbl *ptr, int ptr_index)
 			   __releases(&priv->wmm.ra_list_spinlock)
 {
 	struct sk_buff *skb, *skb_next;
@@ -1246,8 +1233,7 @@ mwifiex_send_single_packet(struct mwifiex_private *priv,
 	struct mwifiex_txinfo *tx_info;
 
 	if (skb_queue_empty(&ptr->skb_head)) {
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		mwifiex_dbg(adapter, DATA, "data: nothing to send\n");
 		return;
 	}
@@ -1265,18 +1251,17 @@ mwifiex_send_single_packet(struct mwifiex_private *priv,
 	else
 		skb_next = NULL;
 
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, ra_list_flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 
 	tx_param.next_pkt_len = ((skb_next) ? skb_next->len +
 				sizeof(struct txpd) : 0);
 
 	if (mwifiex_process_tx(priv, skb, &tx_param) == -EBUSY) {
 		/* Queue the packet back at the head */
-		spin_lock_irqsave(&priv->wmm.ra_list_spinlock, ra_list_flags);
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 		if (!mwifiex_is_ralist_valid(priv, ptr, ptr_index)) {
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       ra_list_flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 			mwifiex_write_data_complete(adapter, skb, 0, -1);
 			return;
 		}
@@ -1286,8 +1271,7 @@ mwifiex_send_single_packet(struct mwifiex_private *priv,
 		ptr->total_pkt_count++;
 		ptr->ba_pkt_count++;
 		tx_info->flags |= MWIFIEX_BUF_FLAG_REQUEUED_PKT;
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 	} else {
 		mwifiex_rotate_priolists(priv, ptr, ptr_index);
 		atomic_dec(&priv->wmm.tx_pkts_queued);
@@ -1323,8 +1307,7 @@ mwifiex_is_ptr_processed(struct mwifiex_private *priv,
  */
 static void
 mwifiex_send_processed_packet(struct mwifiex_private *priv,
-			      struct mwifiex_ra_list_tbl *ptr, int ptr_index,
-			      unsigned long ra_list_flags)
+			      struct mwifiex_ra_list_tbl *ptr, int ptr_index)
 				__releases(&priv->wmm.ra_list_spinlock)
 {
 	struct mwifiex_tx_param tx_param;
@@ -1334,8 +1317,7 @@ mwifiex_send_processed_packet(struct mwifiex_private *priv,
 	struct mwifiex_txinfo *tx_info;
 
 	if (skb_queue_empty(&ptr->skb_head)) {
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		return;
 	}
 
@@ -1343,8 +1325,7 @@ mwifiex_send_processed_packet(struct mwifiex_private *priv,
 
 	if (adapter->data_sent || adapter->tx_lock_flag) {
 		ptr->total_pkt_count--;
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		skb_queue_tail(&adapter->tx_data_q, skb);
 		atomic_dec(&priv->wmm.tx_pkts_queued);
 		atomic_inc(&adapter->tx_queued);
@@ -1358,7 +1339,7 @@ mwifiex_send_processed_packet(struct mwifiex_private *priv,
 
 	tx_info = MWIFIEX_SKB_TXCB(skb);
 
-	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, ra_list_flags);
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 
 	tx_param.next_pkt_len =
 		((skb_next) ? skb_next->len +
@@ -1374,11 +1355,10 @@ mwifiex_send_processed_packet(struct mwifiex_private *priv,
 	switch (ret) {
 	case -EBUSY:
 		mwifiex_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
-		spin_lock_irqsave(&priv->wmm.ra_list_spinlock, ra_list_flags);
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
 
 		if (!mwifiex_is_ralist_valid(priv, ptr, ptr_index)) {
-			spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-					       ra_list_flags);
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 			mwifiex_write_data_complete(adapter, skb, 0, -1);
 			return;
 		}
@@ -1386,8 +1366,7 @@ mwifiex_send_processed_packet(struct mwifiex_private *priv,
 		skb_queue_tail(&ptr->skb_head, skb);
 
 		tx_info->flags |= MWIFIEX_BUF_FLAG_REQUEUED_PKT;
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		break;
 	case -1:
 		mwifiex_dbg(adapter, ERROR, "host_to_card failed: %#x\n", ret);
@@ -1404,10 +1383,9 @@ mwifiex_send_processed_packet(struct mwifiex_private *priv,
 	if (ret != -EBUSY) {
 		mwifiex_rotate_priolists(priv, ptr, ptr_index);
 		atomic_dec(&priv->wmm.tx_pkts_queued);
-		spin_lock_irqsave(&priv->wmm.ra_list_spinlock, ra_list_flags);
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
 		ptr->total_pkt_count--;
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock,
-				       ra_list_flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 	}
 }
 
@@ -1423,7 +1401,6 @@ mwifiex_dequeue_tx_packet(struct mwifiex_adapter *adapter)
 	int ptr_index = 0;
 	u8 ra[ETH_ALEN];
 	int tid_del = 0, tid = 0;
-	unsigned long flags;
 
 	ptr = mwifiex_wmm_get_highest_priolist_ptr(adapter, &priv, &ptr_index);
 	if (!ptr)
@@ -1433,14 +1410,14 @@ mwifiex_dequeue_tx_packet(struct mwifiex_adapter *adapter)
 
 	mwifiex_dbg(adapter, DATA, "data: tid=%d\n", tid);
 
-	spin_lock_irqsave(&priv->wmm.ra_list_spinlock, flags);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
 	if (!mwifiex_is_ralist_valid(priv, ptr, ptr_index)) {
-		spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		return -1;
 	}
 
 	if (mwifiex_is_ptr_processed(priv, ptr)) {
-		mwifiex_send_processed_packet(priv, ptr, ptr_index, flags);
+		mwifiex_send_processed_packet(priv, ptr, ptr_index);
 		/* ra_list_spinlock has been freed in
 		   mwifiex_send_processed_packet() */
 		return 0;
@@ -1455,12 +1432,12 @@ mwifiex_dequeue_tx_packet(struct mwifiex_adapter *adapter)
 			mwifiex_is_amsdu_allowed(priv, tid) &&
 			mwifiex_is_11n_aggragation_possible(priv, ptr,
 							adapter->tx_buf_size))
-			mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index, flags);
+			mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index);
 			/* ra_list_spinlock has been freed in
 			 * mwifiex_11n_aggregate_pkt()
 			 */
 		else
-			mwifiex_send_single_packet(priv, ptr, ptr_index, flags);
+			mwifiex_send_single_packet(priv, ptr, ptr_index);
 			/* ra_list_spinlock has been freed in
 			 * mwifiex_send_single_packet()
 			 */
@@ -1481,11 +1458,11 @@ mwifiex_dequeue_tx_packet(struct mwifiex_adapter *adapter)
 		if (mwifiex_is_amsdu_allowed(priv, tid) &&
 		    mwifiex_is_11n_aggragation_possible(priv, ptr,
 							adapter->tx_buf_size))
-			mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index, flags);
+			mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index);
 			/* ra_list_spinlock has been freed in
 			   mwifiex_11n_aggregate_pkt() */
 		else
-			mwifiex_send_single_packet(priv, ptr, ptr_index, flags);
+			mwifiex_send_single_packet(priv, ptr, ptr_index);
 			/* ra_list_spinlock has been freed in
 			   mwifiex_send_single_packet() */
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

