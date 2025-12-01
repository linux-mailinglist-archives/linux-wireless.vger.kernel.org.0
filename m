Return-Path: <linux-wireless+bounces-29447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F779C97E71
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 15:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E74E159A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878B314B88;
	Mon,  1 Dec 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="pB/VkOnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7A23D7C2;
	Mon,  1 Dec 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600597; cv=none; b=of86UyGn4f7dca0JbfkGb2EQtSOUSmUgLETLrHYnn9gZ7zwvLNblJ/UGUMo0EKmxydZQEJnYl25ObOoE/YAF2xtY7VgoIgrQUb+wJljpxjnmmw6ii3C2DWtw85FpWnbKtQW93UAWt85+1DepQgsFPrqzr6199fYg2rtaDrM1wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600597; c=relaxed/simple;
	bh=7RZAnM0u/6Lq6J6wVPRlV/t5KSNgEJuY0qeQpWU0Ms0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUzs+wo8wOKCVj57Uye47ocY1rEsUEN6xlFxxY3Vprl30PJ8xU9LtxGY9HROTQ7xYYQOCdqUOhVCbRTBQoEJceQQhGt7PZznw3wft5XW0wUmr6rKle3+APhbagsmUB1OqEE8ph7tni1U2eoz4BqfysXS5x0iA/M8MPDIJZHWuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=pB/VkOnf; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=144439612d=os@dev.tdt.de>)
	id 1vQ4yK-007EZZ-PB; Mon, 01 Dec 2025 15:33:48 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <os@dev.tdt.de>)
	id 1vQ4yJ-007SVb-Bx; Mon, 01 Dec 2025 15:33:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1764599625;
	bh=9I8JJfsEgB/9wcRxt2JdeIQlFusUaFYKdjq8kR3UnK4=;
	h=From:To:Cc:Subject:Date:From;
	b=pB/VkOnfHNPBcLV3L8l2MGMtPL00jDUWM+rF8V6SQORz7MywM3f8Eka9/cS8Teyni
	 r14s6g8fh1ap1kXChEdonQmW9zMHPCsS+tqc6y2nddOQuKEbSC5frUncUoH3yljyI5
	 QGk+Q0BhF1J0syEGsB8aN1WqIoKS5iuR2mE0SP1hzhxVEo2XFGdRC2ceG/jTfqo8+k
	 IVC86+Xy6buVECj3Ch4koMOmk/CnI9qffLYOjG/5isazYkUiA7N5d2N9QaBjzA9N34
	 pTBhhbIziDraX8I64FmhUE3LqI8+XLEKpfJw9c4ztwwzW+LuuHh8EfYDBQkUkbgRvs
	 Q5cZ3/PbMEPlw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 98EF3240040;
	Mon,  1 Dec 2025 15:33:45 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 89540240036;
	Mon,  1 Dec 2025 15:33:45 +0100 (CET)
Received: from osedlbauer1.dev.tdt.de (unknown [10.2.3.165])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id F1F3120F9D;
	Mon,  1 Dec 2025 15:33:44 +0100 (CET)
From: Oliver Sedlbauer <os@dev.tdt.de>
To: stable@vger.kernel.org
Cc: Sarika Sharma <quic_sarishar@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Oliver Sedlbauer <os@dev.tdt.de>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: correctly handle mcast packets for clients
Date: Mon,  1 Dec 2025 15:33:16 +0100
Message-ID: <20251201143316.198269-1-os@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1764599628-04C2CCC1-FC92CC53/0/0

From: Sarika Sharma <quic_sarishar@quicinc.com>

[ Upstream commit 4541b0c8c3c1b85564971d497224e57cf8076a02 ]

Currently, RX is_mcbc bit is set for packets sent from client as
destination address (DA) is multicast/broadcast address, but packets
are actually unicast as receiver address (RA) is not multicast address.
Hence, packets are not handled properly due to this is_mcbc bit.

Therefore, reset the is_mcbc bit if interface type is AP.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qua=
lcomm.com>
Link: https://patch.msgid.link/20250411061523.859387-3-quic_sarishar@quic=
inc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
[ Adjust context ]
Signed-off-by: Oliver Sedlbauer <os@dev.tdt.de>
---
Context:
The issue was introduced in 6.12.y by the backport of commit f66971c608c4
("wifi: ath12k: using msdu end descriptor to check for rx multicast packe=
ts"),
which was part of a patchset:
https://lore.kernel.org/all/20250411061523.859387-1-quic_sarishar@quicinc=
.com/

That commit, without this follow-up patch, causes mac80211 to drop encryp=
ted
ARP request frames.
As a result, ARP resolution fails, and connectivity from a station to an =
AP does
not work reliably until traffic is initiated by the AP.

This follow-up commit is necessary to restore correct network functionali=
ty for
ath12k clients on 6.12.y.

Note:
The patch has been modified to apply cleanly, including adjustments for
API changes.
The copyright header change has been omitted.


 drivers/net/wireless/ath/ath12k/dp_rx.c | 5 +++++
 drivers/net/wireless/ath/ath12k/peer.c  | 3 +++
 drivers/net/wireless/ath/ath12k/peer.h  | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wirele=
ss/ath/ath12k/dp_rx.c
index eebdcc16e8fc..1c0d796ffc7a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2214,6 +2214,11 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 	spin_lock_bh(&ar->ab->base_lock);
 	peer =3D ath12k_dp_rx_h_find_peer(ar->ab, msdu);
 	if (peer) {
+		/* resetting mcbc bit because mcbc packets are unicast
+		 * packets only for AP as STA sends unicast packets.
+		 */
+		rxcb->is_mcbc =3D rxcb->is_mcbc && !peer->ucast_ra_only;
+
 		if (rxcb->is_mcbc)
 			enctype =3D peer->sec_type_grp;
 		else
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireles=
s/ath/ath12k/peer.c
index 19c0626fbff1..461749b0f732 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -331,6 +331,9 @@ int ath12k_peer_create(struct ath12k *ar, struct ath1=
2k_vif *arvif,
 		arvif->ast_idx =3D peer->hw_peer_id;
 	}

+	if (arvif->vif->type =3D=3D NL80211_IFTYPE_AP)
+		peer->ucast_ra_only =3D true;
+
 	peer->sec_type =3D HAL_ENCRYPT_TYPE_OPEN;
 	peer->sec_type_grp =3D HAL_ENCRYPT_TYPE_OPEN;

diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireles=
s/ath/ath12k/peer.h
index 7b3500b5c8c2..05d4fdd3f82d 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -47,6 +47,8 @@ struct ath12k_peer {

 	/* protected by ab->data_lock */
 	bool dp_setup_done;
+
+	bool ucast_ra_only;
 };

 void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
--
2.39.5

