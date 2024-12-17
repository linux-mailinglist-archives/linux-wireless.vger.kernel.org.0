Return-Path: <linux-wireless+bounces-16507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435759F57B2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 21:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1F516651A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDC1F9EC8;
	Tue, 17 Dec 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1f67aaR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2D1F9EDD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467184; cv=none; b=EE4WvTrEdbopxq/k6uDhTx/INkrWHiwbrM8MMlRhhrrBOetXdAx1Qla9mM6GnYwKChsBZPkwwlB2SXtPLIPUHVKRaloQhkNFvfSfVA0GwWqjCIuuGn2qjkQ2H47QXKIfGniIRvl0gbFj+841aMUauwZl3Wrtm7Gkqd/X82+fDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467184; c=relaxed/simple;
	bh=F/8ASNPPjOaxz0JijoyrX+VIjLjW8UFlW6ev+Y8FGTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYwc4mXRUKZ4OFu91btu+JVyATjx/+aeTYKaalk+cUfWUcqt+DlwwRG0+5WYeLzgv4VAHRffGPel8955TAbb/pdPiWEJLUzSyV1+EVFBaAo+DwPjRg7eqI40GtOO3/Fp9XHfjaLfzEC9By9B6JkUqD0WWeO0jHBWtPH6f4TCj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1f67aaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08203C4CED3;
	Tue, 17 Dec 2024 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467184;
	bh=F/8ASNPPjOaxz0JijoyrX+VIjLjW8UFlW6ev+Y8FGTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1f67aaRc2+G2cWv7Q17OgeduFtKjphATL9FgXJQonasr3bN6IylUu+JOOZKsy5hg
	 XCx+ESMXTIAvMERTz4IjKNHlkmK7hNPoINqKNbQl7vVsHcgK3CEXIjs+zVrVm91mUI
	 c1pdh1dOVGT88OGUnnvx1O1Ksh3KECJKuKvEWeFFUGXJcgyqYh6PRx/lGpuL6EnZ6s
	 Nzt5rHvJNMONSsdLWxoCGoPpdOGAzoigOIl5zKOpIlw5AVMAAjeTWkvaLbDZftVUDe
	 ye8t8RfJZAQYKEOoTiaI3ZpbOnj9sL91xgWow1uoF3N8/RmqVESW8oAW9J58rH4Hdh
	 pmauThGAi5rNw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage
Date: Tue, 17 Dec 2024 22:26:18 +0200
Message-Id: <20241217202618.1329312-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217202618.1329312-1-kvalo@kernel.org>
References: <20241217202618.1329312-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Building the ath12k driver with llvm-18.1.7-x86_64 produces the warning:

drivers/net/wireless/ath/ath12k/mac.c:5606:12: warning: stack frame size (1176) exceeds limit (1024) in 'ath12k_mac_op_sta_state' [-Wframe-larger-than]

ath12k_mac_op_sta_state() itself does not consume much stack, but it
calls ath12k_mac_handle_link_sta_state() which in turn calls
ath12k_mac_station_add(). Since those are both static functions with
only one caller, it is suspected that these both get inlined, and
their stack usage is reported for ath12k_mac_op_sta_state().

A major contributor to the ath12k_mac_station_assoc() stack usage is:

	struct ath12k_wmi_peer_assoc_arg peer_arg;

Avoid the excess stack usage by dynamically allocating peer_arg
instead of declaring it on the stack.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 10293e9c1d49..6f10813d9378 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4834,7 +4834,6 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	struct ieee80211_link_sta *link_sta;
 	int ret;
 	struct cfg80211_chan_def def;
@@ -4854,14 +4853,19 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	band = def.chan->band;
 	mask = &arvif->bitrate_mask;
 
-	ath12k_peer_assoc_prepare(ar, arvif, arsta, &peer_arg, reassoc);
+	struct ath12k_wmi_peer_assoc_arg *peer_arg __free(kfree) =
+		kzalloc(sizeof(*peer_arg), GFP_KERNEL);
+	if (!peer_arg)
+		return -ENOMEM;
 
-	if (peer_arg.peer_nss < 1) {
+	ath12k_peer_assoc_prepare(ar, arvif, arsta, peer_arg, reassoc);
+
+	if (peer_arg->peer_nss < 1) {
 		ath12k_warn(ar->ab,
-			    "invalid peer NSS %d\n", peer_arg.peer_nss);
+			    "invalid peer NSS %d\n", peer_arg->peer_nss);
 		return -EINVAL;
 	}
-	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
+	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
 			    arsta->addr, arvif->vdev_id, ret);
-- 
2.39.5


