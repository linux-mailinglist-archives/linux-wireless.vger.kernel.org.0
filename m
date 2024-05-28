Return-Path: <linux-wireless+bounces-8179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF28D171D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC624285C04
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AED73474;
	Tue, 28 May 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G46LM79b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222E13F45F;
	Tue, 28 May 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887894; cv=none; b=QjMIZi0iQzj1b8ni2oTdEcVKqOVxJ317vobRX184mMeuH5tqOh0jJrllo9s2b/Kqodp8RMzF5kO2uiq7hPA5x6G1GKHrU7LILHqn1qqVWPlaRRe3cTS/mwbN8hjB1eEEisZOiVHEizXwDu0HirGXaazc3Y1qzLDkLVQ2XjgExTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887894; c=relaxed/simple;
	bh=kU7Tlob7aqdGJVIIlB2bJ3z2njJBaj2p/U8Kna4zyH4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NoYjLgKhx4OXZLxuvsjDCRT8/khLAKu1Icda6HzjLuizsyV6iDg+yniZ/TS5r13NJZ50YuIVNwTqKkN0zK/ub/aYG2O10+aT5tnDTB3+Dny0XUXG1Y95pZWRRlw65963wuOchHbK+epSH3Bo8vlPyvpIZfvkquJ9IyTpRR5xI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G46LM79b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HuHTw1gCK5bIqEGyLd+i4Kr0r9K90c+aiGJ17Pw8vbU=; b=G46LM79b8M0SP5b+iCpqhb5V7B
	A2WAZcJT6h6PibIaAF2k9PAN1xtw7Hu2YYb6pRGG/QzUiBSXW5v4w8ee0dHHRni/0E8OAtCI5xQ/T
	tlrP2ur1oZ6LCx9V584NEhZ9Y/Fxl+Fb4fxa/B7DAaN8edsAF4giYneMYeGYik5JKUYdxoek9P9fs
	mVjOGCfw3HQF4XUTXIgiEgP9Gx0Aipkhe0GWpKxMbPv1uGSvJkyUNN8VVFEWlOIhJ4p4k/1APQkqG
	L5OaM1gP8bo3Z2bh1rYOcsjRoGosxgDvMNF+rWMjQw/JB0zJXZyPT/MTvnBR6NDcA3iFKCazmdSac
	6cyLXfbA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43036 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsy5-0004YI-0I;
	Tue, 28 May 2024 10:18:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsy7-00E8vu-Nc; Tue, 28 May 2024 10:18:07 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 6/8] wifi: wlcore: add pn16 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsy7-00E8vu-Nc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:18:07 +0100

TI Wl18xx firmware adds a "pn16" field for AES and TKIP keys as per
their patch:

https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0023-wlcore-Fixing-PN-drift-on-encrypted-link-after-recov.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7

Add support for this, but rather than requiring the field to be
present (which would break existing firmwares), make it optional.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wlcore/cmd.c      |  9 +++
 drivers/net/wireless/ti/wlcore/main.c     | 89 +++++++++++++++++++++--
 drivers/net/wireless/ti/wlcore/wlcore_i.h |  4 +
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index a939fd89a7f5..0d1fcdca3869 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -332,6 +332,14 @@ int wl12xx_allocate_link(struct wl1271 *wl, struct wl12xx_vif *wlvif, u8 *hlid)
 			wl->fw_status->counters.tx_lnk_free_pkts[link];
 	wl->links[link].wlvif = wlvif;
 
+	/*
+	 * Take the last sec_pn16 value from the current FW status. On recovery,
+	 * we might not have fw_status yet, and tx_lnk_sec_pn16[] will be NULL.
+	 */
+	if (wl->fw_status->counters.tx_lnk_sec_pn16)
+		wl->links[link].prev_sec_pn16 =
+			le16_to_cpu(wl->fw_status->counters.tx_lnk_sec_pn16[link]);
+
 	/*
 	 * Take saved value for total freed packets from wlvif, in case this is
 	 * recovery/resume
@@ -360,6 +368,7 @@ void wl12xx_free_link(struct wl1271 *wl, struct wl12xx_vif *wlvif, u8 *hlid)
 
 	wl->links[*hlid].allocated_pkts = 0;
 	wl->links[*hlid].prev_freed_pkts = 0;
+	wl->links[*hlid].prev_sec_pn16 = 0;
 	wl->links[*hlid].ba_bitmap = 0;
 	eth_zero_addr(wl->links[*hlid].addr);
 
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 8f82666f379c..35d1114a28aa 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -379,6 +379,8 @@ static void wl12xx_irq_update_links_status(struct wl1271 *wl,
 
 static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
 {
+	struct wl12xx_vif *wlvifsta;
+	struct wl12xx_vif *wlvifap;
 	struct wl12xx_vif *wlvif;
 	u32 old_tx_blk_count = wl->tx_blocks_available;
 	int avail, freed_blocks;
@@ -410,23 +412,100 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
 		wl->tx_pkts_freed[i] = status->counters.tx_released_pkts[i];
 	}
 
+	/* Find an authorized STA vif */
+	wlvifsta = NULL;
+	wl12xx_for_each_wlvif_sta(wl, wlvif) {
+		if (wlvif->sta.hlid != WL12XX_INVALID_LINK_ID &&
+		    test_bit(WLVIF_FLAG_STA_AUTHORIZED, &wlvif->flags)) {
+			wlvifsta = wlvif;
+			break;
+		}
+	}
+
+	/* Find a started AP vif */
+	wlvifap = NULL;
+	wl12xx_for_each_wlvif(wl, wlvif) {
+		if (wlvif->bss_type == BSS_TYPE_AP_BSS &&
+		    wlvif->inconn_count == 0 &&
+		    test_bit(WLVIF_FLAG_AP_STARTED, &wlvif->flags)) {
+			wlvifap = wlvif;
+			break;
+		}
+	}
 
 	for_each_set_bit(i, wl->links_map, wl->num_links) {
+		u16 diff16, sec_pn16;
 		u8 diff, tx_lnk_free_pkts;
+
 		lnk = &wl->links[i];
 
 		/* prevent wrap-around in freed-packets counter */
 		tx_lnk_free_pkts = status->counters.tx_lnk_free_pkts[i];
 		diff = (tx_lnk_free_pkts - lnk->prev_freed_pkts) & 0xff;
 
-		if (diff == 0)
+		if (diff) {
+			lnk->allocated_pkts -= diff;
+			lnk->prev_freed_pkts = tx_lnk_free_pkts;
+		}
+
+		/* Get the current sec_pn16 value if present */
+		if (status->counters.tx_lnk_sec_pn16)
+			sec_pn16 = __le16_to_cpu(status->counters.tx_lnk_sec_pn16[i]);
+		else
+			sec_pn16 = 0;
+		/* prevent wrap-around in pn16 counter */
+		diff16 = (sec_pn16 - lnk->prev_sec_pn16) & 0xffff;
+
+		/* FIXME: since free_pkts is a 8-bit counter of packets that
+		 * rolls over, it can become zero. If it is zero, then we
+		 * omit processing below. Is that really correct?
+		 */
+		if (tx_lnk_free_pkts <= 0)
 			continue;
 
-		lnk->allocated_pkts -= diff;
-		lnk->prev_freed_pkts = tx_lnk_free_pkts;
+		/* For a station that has an authorized link: */
+		if (wlvifsta && wlvifsta->sta.hlid == i) {
+			if (wlvifsta->encryption_type == KEY_TKIP ||
+			    wlvifsta->encryption_type == KEY_AES) {
+				if (diff16) {
+					lnk->prev_sec_pn16 = sec_pn16;
+					/* accumulate the prev_freed_pkts
+					 * counter according to the PN from
+					 * firmware
+					 */
+					lnk->total_freed_pkts += diff16;
+				}
+			} else {
+				if (diff)
+					/* accumulate the prev_freed_pkts
+					 * counter according to the free packets
+					 * count from firmware
+					 */
+					lnk->total_freed_pkts += diff;
+			}
+		}
 
-		/* accumulate the prev_freed_pkts counter */
-		lnk->total_freed_pkts += diff;
+		/* For an AP that has been started */
+		if (wlvifap && test_bit(i, wlvifap->ap.sta_hlid_map)) {
+			if (wlvifap->encryption_type == KEY_TKIP ||
+			    wlvifap->encryption_type == KEY_AES) {
+				if (diff16) {
+					lnk->prev_sec_pn16 = sec_pn16;
+					/* accumulate the prev_freed_pkts
+					 * counter according to the PN from
+					 * firmware
+					 */
+					lnk->total_freed_pkts += diff16;
+				}
+			} else {
+				if (diff)
+					/* accumulate the prev_freed_pkts
+					 * counter according to the free packets
+					 * count from firmware
+					 */
+					lnk->total_freed_pkts += diff;
+			}
+		}
 	}
 
 	/* prevent wrap-around in total blocks counter */
diff --git a/drivers/net/wireless/ti/wlcore/wlcore_i.h b/drivers/net/wireless/ti/wlcore/wlcore_i.h
index eefae3f867b9..5fbed64302f1 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore_i.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore_i.h
@@ -151,6 +151,9 @@ struct wl_fw_status {
 		 */
 		u8 *tx_lnk_free_pkts;
 
+		/* PN16 of last TKIP/AES seq-num per HLID */
+		__le16 *tx_lnk_sec_pn16;
+
 		/* Cumulative counter of released Voice memory blocks */
 		u8 tx_voice_released_blks;
 
@@ -259,6 +262,7 @@ struct wl1271_link {
 	/* accounting for allocated / freed packets in FW */
 	u8 allocated_pkts;
 	u8 prev_freed_pkts;
+	u16 prev_sec_pn16;
 
 	u8 addr[ETH_ALEN];
 
-- 
2.30.2


