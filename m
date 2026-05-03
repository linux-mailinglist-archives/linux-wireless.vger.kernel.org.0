Return-Path: <linux-wireless+bounces-35777-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKliGGOn9mmYXQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35777-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 03:39:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E924B3FFF
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 03:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 056D6300372D
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C56246BCD;
	Sun,  3 May 2026 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6TYdVQ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322821771B
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772371; cv=none; b=pamdbKV3ZzK8M3sP+X6J1Ny1cSVOaWFvaLUP9mPLrNUNIpuDUqzZa8HJGOcMK3H6fKiIV3vj0/XjAWCI7WCBR7e9mkwVUpEZIJeB6Q4zpyC5khsorM87Y7FN3LgRoqOErwtqApKVJr/9Twoi5gAXK3aynWr02IXgz/hKJ4nx01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772371; c=relaxed/simple;
	bh=7uwJxgvTxpOn6gNEIOPNEioHiEozfkGob7zPtdELUWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=opIMbjg5l+QSUmk9VGMXJq/tWvhDltkYJF7ulGKZEQ2zEeLz0TGEooRusEBmsp1d3HDwbWzQN/gX5u2r+go3Yf+i3UttyJA57i3LnGlyZa3K2KLkkfAe+TnQdVt44CQQ+sH6r9Xl/Z2lG8FPD0EjL4xUuH9L3AxY1zhM6MLYC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6TYdVQ6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so502248366b.1
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777772368; x=1778377168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCD/2g9DiH7IGmCylqgN8SVqRAlReG1YJkLOG3TO9pw=;
        b=Z6TYdVQ67nfpyM+Eky4qqdjd4e497GCIMbYd4QHCVjZ6qs01j1aYs6VUHihBfs22sX
         9M5m/ZrQwC+YCE7X09PIrjZOYgS1Q9foAsm6n/AKPzfLe6TuwDKH+Q7h1WIINYGIBGrC
         CQOUeEYYeL682Np0WzDsw5iRytj7XeK+vtzf1qYuK6OVSYdspCeRuPDd6ImpDBHwvwAb
         MkvTJUviwS0m4Txd+0U4OzZFMOedbM/aereboqo7dDWT5NZhoI8hoJhSBvHzmksk3EAE
         8oRORoxChAnGp3Wn8dbYSEDrJOxECSJtCzG88fPA+6ctaKhcbLRDP3u8PXyld7ncHT1o
         inkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777772368; x=1778377168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCD/2g9DiH7IGmCylqgN8SVqRAlReG1YJkLOG3TO9pw=;
        b=qmrl1MYLrtO83oviKHjLQL46JFLobtYGpGtn7Twe2iLLeLnMxG3BaUv6pMr2x2oRjW
         XUurrhqn3PMZqTRV7xYBlzgRlswd5EHAHV3n3xu4dhefB86jFXQkt+A0AGTSsYyF/VvJ
         FSnGIr4qxDR9RsRv7Zb7dm6BmnqDU0rSoEk2vE+FXqItDh0YuMoSmIhasc5jexwYRnsJ
         CdQWKeCTtxE5oOkZ93pS5BdLMCd0w5hI7NBc/T+B+R5S/bvB3c8UgsnSCXdphP9ptCh3
         4oWhXuWcVXF+1Vv3TjdaYiekzETJldEZamR87sDpyerBWDpFFYfinkR1y3fH/N86pIMk
         HAxA==
X-Gm-Message-State: AOJu0Ywgk9GDPoowCLx7MERW2Blh5/cpdzjGJT90OdxOLW/ASCujOUVF
	oFqCfMiUqj409WxfOStIWgTc2nDTf63okbPbpEguzsKHqOxthF5yGFDa
X-Gm-Gg: AeBDiesM82zcMZr8/hrDTsssmjxR5QX/e4fVNi2iQNHHmeGl0IxKV5qs0Yk2Zo5drQQ
	4PKxC08Ynj4JwBXfsqRYKc1nB0E7pjNVgJDexKoU2q5UKXFtS+U1w53Ah42e9HonRBIbUlnHk/G
	Xm9IMyUFQff4EE2CRO+m3w5mJqAtdBO97+a/tyXbXbEQfTVMIl2cJjf0q2FLIyieMZvtEvyfiiw
	nvSuX2SsXk0PIInbm7wkE7aE0o+gJ9ltN2TTCh6mUR9DBqrQkXid+hnwsYwuWUhtKbfw0kaPdVn
	6e1ZDXusaioVt3l65SKdrPeKQ0Sj9n8McbdO73vvGwwkfrYjXIsAZ1b4lzRTJCgip3yAAklCxP1
	fUSaq4gtWG8TfQW3EYhCgbmR2R6YFb3mVCfMrnvBV1cyrzlJq+CsLrOd3AblzRS/bE6q6oYsuts
	s4UQMFQmlSw9w7T4sn/65LuiHlVFSL5TVbMhe6iGKF8iqKuUyK1wEmzVtyyE5EseHELF3Uokdkg
	JrWLay3o/Oy9cL7PZNaxwQ9y/8M
X-Received: by 2002:a17:907:198c:b0:b9e:8e4:8765 with SMTP id a640c23a62f3a-bbffb23fe1amr237176266b.10.1777772368030;
        Sat, 02 May 2026 18:39:28 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-39-71-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.71.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1671c1d3esm24796466b.42.2026.05.02.18.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 18:39:27 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
Date: Sun, 03 May 2026 04:38:30 +0300
Subject: [PATCH 1/2] wifi: mt76: mt792x: disable HW TX/RX encap offload to
 fix TDLS direct-link
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-mt7925-tdls-fixes-v1-1-dde847e21081@gmail.com>
References: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com>
In-Reply-To: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Soul Huang <Soul.Huang@mediatek.com>, 
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, ElXreno <elxreno@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4215; i=elxreno@gmail.com;
 h=from:subject:message-id; bh=7uwJxgvTxpOn6gNEIOPNEioHiEozfkGob7zPtdELUWI=;
 b=owJ4nJvAy8zAJXa0WDmKX5v/EeNptSSGzG/LfTNMDDbv83x9t8ziV+VZJeNKo5MB9cwrXz83n
 G6x792x7W4dpSwMYlwMsmKKLDzn9tbmLKtbMrmeKwNmDisTyBAGLk4BmEgYD8P/JKl3nJpLa/Ka
 bl5Idnp1ekbCjzrz/qdJrJfP1259uTL4GsP/7BX+oeF7w3Y+5euOWn36UPq8FvE7J+wZ5pQrrju
 6pUKAFQAL90r/
X-Developer-Key: i=elxreno@gmail.com; a=openpgp;
 fpr=0CCEBD7D6CA67EA4937F0A68C573235A0F2B0FE2
X-Rspamd-Queue-Id: 73E924B3FFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35777-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elxreno@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On MediaTek MT7925 (Connac3), QoS Data frames whose destination WCID
is a TDLS direct-link peer are silently dropped after submission to
firmware via the HW_80211_ENCAP TX path. The driver sees submit and
complete counts match (firmware reports success on TX queue
submission), but the frames never reach the PHY. iw counters show
tx_packets growing, tx_failed = 0, tx_retries low; on the air,
nothing.

This breaks TDLS direct-link as soon as a peer auto-initiates one
(Samsung phones do this aggressively when both peers share a BSS and
traffic exceeds a threshold). Pattern is:

  1. Any sustained direct traffic between two STAs sharing the BSS
     reaches the auto-TDLS threshold within ~1 s.
  2. Peer initiates TDLS; mac80211 routes data frames to the TDLS-peer
     WCID and the AP stops forwarding peer-to-peer traffic per the
     802.11z spec.
  3. Direct-link frames are accepted by firmware, completed in the TX
     descriptor pool, but never PHY-transmitted.
  4. TCP collapses; the peer eventually tears down the TDLS link with
     reason WLAN_REASON_TDLS_TEARDOWN_UNSPECIFIED. Cycle repeats.

Effective TCP throughput drops from ~300 Mbit/s (AP route) to ~6
Mbit/s with TDLS active.

Verified on mt7925e (PCIe) at 5 GHz HE NSS 2 MCS 11 80 MHz and at
2.4 GHz 802.11n HT NSS 2 MCS 15. With this patch, TDLS direct link
sustains ~750 Mbit/s and ~130 Mbit/s respectively.

mt76 advertises WIPHY_FLAG_SUPPORTS_TDLS via the shared
mt76_register_phy_helper() but does not provide TDLS-aware
firmware-facing peer setup: no CONNECTION_TDLS constant in
mt76_connac_mcu.h, no STA_REC_TDLS TLV, no TDLS bit in
mt76_wcid_flags, and no TDLS-specific code in
mt7925_mac_write_txwi_8023(). TDLS peers are registered as
CONNECTION_INFRA_STA with peer_addr set to the peer's MAC and
nothing else. The proprietary out-of-tree MediaTek driver carries an
explicit cfg80211_tdls.c (PTK/TK install paths, etc.) with no
in-tree equivalent. Whether the underlying gap is in the firmware
HW_ENCAP path or in mt76's missing TDLS-aware setup is unclear from
the kernel side; the software-encap path sidesteps it either way.

Work around the issue by not advertising SUPPORTS_TX_ENCAP_OFFLOAD
and SUPPORTS_RX_DECAP_OFFLOAD in mt792x_init_wiphy(). mac80211 then
takes the software 802.11 encap path, which submits already-formed
802.11 frames via a different firmware path that handles all WCIDs
correctly, including TDLS peers.

mt792x_init_wiphy() is shared with the Connac2 family (mt7921/22/20/02),
which uses the same firmware HW_ENCAP path; the disable is applied
globally to cover the likely-affected chips. If Connac2 is later
confirmed unaffected, the disable can be narrowed with is_mt7925().

Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
Cc: stable@vger.kernel.org
Signed-off-by: ElXreno <elxreno@gmail.com>
Assisted-by: Claude:claude-opus-4-7 bpftrace
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 152cfcca2f90..f9610c6c1597 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -681,8 +681,14 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
-	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
-	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	/* HW TX/RX 802.11 encap offload is intentionally NOT advertised:
+	 * the firmware HW_80211_ENCAP path silently drops QoS Data frames
+	 * whose destination WCID is a TDLS direct-link peer, breaking TDLS
+	 * data flow. The mac80211 software encap path submits already-formed
+	 * 802.11 frames, which the firmware handles correctly for all WCIDs.
+	 * Re-add SUPPORTS_TX_ENCAP_OFFLOAD / SUPPORTS_RX_DECAP_OFFLOAD here
+	 * once the firmware HW_ENCAP path is fixed.
+	 */
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);

-- 
2.53.0


