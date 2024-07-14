Return-Path: <linux-wireless+bounces-10214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A5930983
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2024 12:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C33E281511
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AE449628;
	Sun, 14 Jul 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JGC3ZMva"
X-Original-To: linux-wireless@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B41643A;
	Sun, 14 Jul 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720951911; cv=none; b=JLMd995fANDW+36M1phGDVqPsl19pXC1KjBfD7zG9yU9kRGMIWLbqg4eIywPz8EeKmwXR6dNk5YA8cdEbi4k3q15a11Ki6xHffTgSLYA7s5eLDT6LJXs4OjNYXhXUXA90UA159JI4A9e4f4bMdehCSI7b4D1rCY/3UTEjwDowJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720951911; c=relaxed/simple;
	bh=kWCs+cEQtqbwjreHdj53o84/iX19kR9ct0q9z6sWyA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k63QWBEFBeu6mvZ0sJZNwfMaB+B2H++E6NZNYOKhQUDL2+tfr8lxI7SzQ7O5arOMdskqzg9Hp7lTSt3DNkRtFUT+5Tg7CqATKlcIUXKxpK9VeqONT0OXIJ3TPII3EzOGx4Tjn82bVfMc4zS2sl9foj6zFgrDI6WoB+YKHemeAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JGC3ZMva; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id SwBhsdxgbEfqMSwBhsYXFo; Sun, 14 Jul 2024 12:10:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720951838;
	bh=bcgYQd7qyMKezXOwUHato7KOe58Ug0yR7MvnLf1WWps=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JGC3ZMvaFCnKXsEO8GFmcJ9JjXIQt+LJOdnt3Tw5tUez4+8Hk0cpw3GN12XSxZPJp
	 eFHjU/jZwJV9XqShDr5bt1mm8QtnH/gMN2ZWbPHTreHNjMiDtz7fK8HytXWSOKy3sc
	 Hch5D5lg917TV9NTaEgs7/EpGwV9eQO4aEdt+p6MtllWI1q2ehmWldUMs0Jt0PU1fa
	 LP8+1iNFFQ2g+oWwSOuAZmqmmNAu7R09LC1G2n4LUZBkl57zsXaalmQKOIYchjUcBA
	 gtiqFBwxwTQ/akwG+27pOyle5nC37ixzWBb3XhypPbfJefKqW6YCqGp47sVKQiLcy/
	 +hVh7PAJAcXrw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jul 2024 12:10:38 +0200
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
Subject: [PATCH] brcmfmac: fwsignal: Use struct_size() to simplify brcmf_fws_rxreorder()
Date: Sun, 14 Jul 2024 12:10:33 +0200
Message-ID: <bd3ad239c4d1c49b94c1ba93e48c09df98ef86cb.1720951805.git.christophe.jaillet@wanadoo.fr>
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
---
Compile tested only
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h   | 4 ++--
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c   | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index ea76b8d33401..6ea2b677f047 100644
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
+ * @pktslots: dynamic allocated array for ordering AMPDU packets.
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


