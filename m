Return-Path: <linux-wireless+bounces-35268-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOOjHnw962mfKAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35268-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 11:53:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9945C8AF
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 11:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8038E3025915
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B048320A00;
	Fri, 24 Apr 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kveuvuCz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E6359A9F;
	Fri, 24 Apr 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024272; cv=none; b=j09UinxWhwr6kklNjbwUZ3fndGqJxvhACbhO7Wwyz+DZQ+KezxuFb8eYplWkEqSgH3BizQqva/GmlUFiKr1CZKBYWy0WYNCgvY/1xrzkneXA83gUmCcqti/a8eUv3deovoCZP4Jp6zQTCbk8RWJH0qi7FgxuI/bSpilkvlyXGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024272; c=relaxed/simple;
	bh=EK10yGwkXVQnZj51E7ttz818C88LRbsuydqLz2WzW7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JbCmrJIHVtGRT63YA185d11qEcljbghOlL4/8qdIfVQznY15zzP7oNXDf2oZ424RXEuZd81V3phSwdhcJfKozkruzczZBSJEocjLgDLpECdUSJiqyvf5twRzjLsSE1un2uTuh7Qme1c4ST5Tht2OUsaG3Tix43wZShIXKcDzSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kveuvuCz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777024262;
	bh=EK10yGwkXVQnZj51E7ttz818C88LRbsuydqLz2WzW7E=;
	h=From:Date:Subject:To:Cc:From;
	b=kveuvuCzBee3QivjhV4pxyXkhdCXE/uMSmzTYDnXm1Okw0XpA7Rw0eRuJRm0BHbJt
	 waNMq53DXKOv07GkSHHvb/Y+CSjJ303VMFfViyGEX1neYY+JrqpP8rSDnpE57hTfTV
	 GIT8wJtuUT+J5qI56X0S/Z6STIEQpTLbVZRPiJUrLtaT6T91YLWht+zn9zaQb3pGkd
	 1Rekms+ZEPrfgPr9YfODxcJNPGxRZo2Uf7Uiy+FNPwVzMUOKVU4Sg8AFGmJmZDUcVr
	 zW6wR7gFHAuyLVkD+0RIC6WPejzUb862/wsueuXLwZWEI0JhlRevhoxUdcDpXDIBti
	 3MO5NUbTu/HUA==
Received: from goku.local (unknown [100.64.0.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8928F17E13B2;
	Fri, 24 Apr 2026 11:51:02 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Fri, 24 Apr 2026 10:50:35 +0100
Subject: [PATCH v4] wifi: ath11k: fix peer resolution on rx path when
 peer_id=0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTW7CMBAF4KsgrzHyjJ0QWPUeFYvxTxpDiCM7C
 a1Q7o4DCyq1Eiyf9OZ7c2XJRe8S26+uLLrJJx+6HNR6xUxD3Zfj3ubMUGApJJachgbgxLuxbXn
 v8rHllxBPFMPYWV5iQYC7bQUaWDb66Gr/ffc/D4+cRn10ZljQpdH4NIT4c39ggqX37tYEHLgwW
 NtC5pO6+jChbUmHSBsTzmzZm/ApKiheiZhFJE1Oak0Gyv9E+VvcvhJlFq1QUiBWSlV/xHmeb7L
 xdM2EAQAA
X-Change-ID: 20260326-ath11k-null-peerid-workaround-625a129781b1
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
 Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: CCF9945C8AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35268-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,collabora.com:mid,infradead.org:email,msgid.link:url,qualcomm.com:email]

It has been observed that on certain chipsets a peer can be assigned
peer_id=0. For reception of non-aggregated MPDUs this is fine as
ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
based upon the source MAC address. On an aggregated link, the mpdu_start
header is only populated by hardware on the first sub-MSDU. This causes
the peer resolution to be skipped for the subsequent MSDUs and the
encryption type of these frames to be set to an incorrect value,
resulting in these MSDUs being dropped by ieee80211.

ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1

Remove the null peer_id checks in ath11k_dp_rx_h_find_peer() and
ath11k_hal_rx_parse_mon_status_tlv(), allowing peers with an assigned ID
of 0 to be resolved.

Fixes: 2167fa606c0f ("ath11k: Add support for RX decapsulation offload")
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
Changes in v4:
- Prefix subsystem with 'wifi:'.
- Added the 'Tested-by' and 'Fixes' trailers.
- Link to v3: https://patch.msgid.link/20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com

Changes in v3:
- Clarified that the mpdu_start header isn't populated by the h/w for
  all sub-MSDUs in the commit message.
- Fix second null-peer check in ath11k_hal_rx_parse_mon_status_tlv().
- Link to v2: https://patch.msgid.link/20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com

Changes in v2:

- Since peer_id=0 is a valid condition on some chips, remove the guard
  that prevented the peer lookup.
- Link to v1: https://patch.msgid.link/20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com

To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 3 +--
 drivers/net/wireless/ath/ath11k/hal_rx.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 49d959b2e148..ff2c78a4e5f3 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2215,8 +2215,7 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
 
 	lockdep_assert_held(&ab->base_lock);
 
-	if (rxcb->peer_id)
-		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
+	peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
 
 	if (peer)
 		return peer;
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 753bd93f0212..51e0840bc0d1 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1467,11 +1467,8 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 	case HAL_RX_MPDU_START: {
 		struct hal_rx_mpdu_info *mpdu_info =
 				(struct hal_rx_mpdu_info *)tlv_data;
-		u16 peer_id;
 
-		peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
-		if (peer_id)
-			ppdu_info->peer_id = peer_id;
+		ppdu_info->peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
 		break;
 	}
 	case HAL_RXPCU_PPDU_END_INFO: {

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1

Best regards,
--  
Matt


