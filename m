Return-Path: <linux-wireless+bounces-10415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76A9383CC
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2024 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D21C20A8A
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2024 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB08801;
	Sun, 21 Jul 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UEpSI4Sk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715D33E1;
	Sun, 21 Jul 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721547669; cv=none; b=A6sOkvdfQzk6TieYo9pBPX6wh8pOAU9iulomkrTY9SY+pT8iP1OcpiwRwuic8oapJVAtdeMTDSJ9x1gp1/dZaLBUo2VaeZNKq0SY8rpZOmM9k63NPaL2UPtSnId+YhmoM1XCKWgPZpg7l5VFybXJ5LQqf8Mm2M+av6uu+8hIl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721547669; c=relaxed/simple;
	bh=myooTmdDYWi3w4/BwipOyDPWqNI6T+1/xT+G+yICZtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auJ+B1LOMKHcZztwivXT5F2AkT5+TrdfDUCksY7TNWPBvxuxucjz0l6x7CD6se6R8+nXP/iet+08KNQgnRJU/uhusObu+eMP3py9P6f+JgfsFoR8OcPNWrO/Vl96/c3zkh5mDeMiUYDVMvjOhqLPH/YBZnI5ShR+naA/zlMQpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UEpSI4Sk; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id VRBmsszGLnYGvVRBms5oUi; Sun, 21 Jul 2024 09:41:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721547662;
	bh=0P+L+Gugv+wzdGvctc9kSUn+nQDPgO6wIWj+dXDwk3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UEpSI4SkWxFHkRylyVr6QtXi3vte6IoJivFq98RMQvM8JZwomp6PtWnn/Bb2ad/Cb
	 aU9RPvVRMpAN0yY91hhL3H+DmcHhw+pm/s0D7gEs9tKc5LCZ3sfvTe2PTfgNDe0SZ6
	 RkymXfA3zeoqpbolNNxytKP9KaUZzRSr5+NME56azOgS2VOT92Hto8Hcta8TSQVZXj
	 8nmIdcH+6/VBBLW8sHFkKjJYPo9KFaN53q8i/rC1OFSaSjzUaxPfI4cQAkMdxIRsas
	 NHGCVnblCOiC+wbJhV/F92ywA/edxhfW+xSWPdvexiSPyXPHTJ/JB9QW+755GJt/FJ
	 4hCfIC9prkVQQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2024 09:41:02 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH v2] brcmfmac: fwsignal: Use struct_size() to simplify brcmf_fws_rxreorder()
Date: Sun, 21 Jul 2024 09:40:19 +0200
Message-ID: <f4ca6b887ca1290c71e76247218adea4d1c42442.1721547559.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the "struct brcmf_ampdu_rx_reorder", change the 'pktslots' field into
flexible array.

It saves the size of a pointer when the memory is allocated and avoids
an indirection when the array is used.
It also removes the usage of a pointer arithmetic and saves a few lines of
code.

Finally, struct_size() can be used. It is not a must have here, because
it is easy to see that buf_size can not overflow, but still, it is a good
practice.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Compile tested only

Changes in v2:
  - fix description of the 'pktslots' field   [Arend van Spriel]
  - add A-b tag

v1: https://lore.kernel.org/all/bd3ad239c4d1c49b94c1ba93e48c09df98ef86cb.1720951805.git.christophe.jaillet@wanadoo.fr/
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h   | 4 ++--
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c   | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index ea76b8d33401..39226b9c0fa8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -48,20 +48,20 @@
 /**
  * struct brcmf_ampdu_rx_reorder - AMPDU receive reorder info
  *
- * @pktslots: dynamic allocated array for ordering AMPDU packets.
  * @flow_id: AMPDU flow identifier.
  * @cur_idx: last AMPDU index from firmware.
  * @exp_idx: expected next AMPDU index.
  * @max_idx: maximum amount of packets per AMPDU.
  * @pend_pkts: number of packets currently in @pktslots.
+ * @pktslots: array for ordering AMPDU packets.
  */
 struct brcmf_ampdu_rx_reorder {
-	struct sk_buff **pktslots;
 	u8 flow_id;
 	u8 cur_idx;
 	u8 exp_idx;
 	u8 max_idx;
 	u8 pend_pkts;
+	struct sk_buff *pktslots[];
 };
 
 /* Forward decls for struct brcmf_pub (see below) */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 36af81975855..0949e7975ff1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -1673,7 +1673,6 @@ void brcmf_fws_rxreorder(struct brcmf_if *ifp, struct sk_buff *pkt)
 	struct sk_buff_head reorder_list;
 	struct sk_buff *pnext;
 	u8 flags;
-	u32 buf_size;
 
 	reorder_data = ((struct brcmf_skb_reorder_data *)pkt->cb)->reorder;
 	flow_id = reorder_data[BRCMF_RXREORDER_FLOWID_OFFSET];
@@ -1708,15 +1707,13 @@ void brcmf_fws_rxreorder(struct brcmf_if *ifp, struct sk_buff *pkt)
 	}
 	/* from here on we need a flow reorder instance */
 	if (rfi == NULL) {
-		buf_size = sizeof(*rfi);
 		max_idx = reorder_data[BRCMF_RXREORDER_MAXIDX_OFFSET];
 
-		buf_size += (max_idx + 1) * sizeof(pkt);
-
 		/* allocate space for flow reorder info */
 		brcmf_dbg(INFO, "flow-%d: start, maxidx %d\n",
 			  flow_id, max_idx);
-		rfi = kzalloc(buf_size, GFP_ATOMIC);
+		rfi = kzalloc(struct_size(rfi, pktslots, max_idx + 1),
+			      GFP_ATOMIC);
 		if (rfi == NULL) {
 			bphy_err(drvr, "failed to alloc buffer\n");
 			brcmf_netif_rx(ifp, pkt);
@@ -1724,7 +1721,6 @@ void brcmf_fws_rxreorder(struct brcmf_if *ifp, struct sk_buff *pkt)
 		}
 
 		ifp->drvr->reorder_flows[flow_id] = rfi;
-		rfi->pktslots = (struct sk_buff **)(rfi + 1);
 		rfi->max_idx = max_idx;
 	}
 	if (flags & BRCMF_RXREORDER_NEW_HOLE)  {
-- 
2.45.2


