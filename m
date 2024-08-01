Return-Path: <linux-wireless+bounces-10778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C54943C3E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3647C1F23BE3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC7A1BBBD3;
	Thu,  1 Aug 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqOfXuf2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D01B29AD;
	Thu,  1 Aug 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471401; cv=none; b=dnFfsabN3hiBJwtIFucxujj1RFgOR/JOsVCw42U4YAuXVixSi+fr2Rw3Q696tmrXvlj/VOBTUymfVdE+rzoHCuEV1qWD2DITaMnhoIMCqRi7nUcBM2CiF8fBlM+uC9Gh8eHp+19gOJeMXdgpm2V1hwtHK7RI22im/l8wXTmpccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471401; c=relaxed/simple;
	bh=UR3INt0/72J9XTSXmIIA4ENQUx98eBliSrcf4LK3lvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc7Li2Mex0KxQAfIA0NfIFuoSwpBUQw3wQtPmdH5Q47sOD8tM15shWCdciC9YILlocJEglaF8My2da7OHymDht7rOFzfEAW4FQxZ0Dx5xx6PF9SZEQ3ejgn2FOOzm4FW1KLO/2GPo725RrhLWtIw2BPjXWjqE7btnPmh2yHrzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqOfXuf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51EAC32786;
	Thu,  1 Aug 2024 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471401;
	bh=UR3INt0/72J9XTSXmIIA4ENQUx98eBliSrcf4LK3lvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqOfXuf2IFV3G5UD72AQ/tB5dCMoKZEfb5LUOQD8Bhj9sT0P1Bfo5GqYqtQqm+lWA
	 lh8lxNDCx4xWYl+1gs+gYkdQUWVa0Ow8OcBgFb73B3fXibz3v/Dxz01gskS/t7hdB9
	 T3NaQVms0s8wJbuJVXRlqXiwa1ypGrbTezDKfNaiVV6k4Bcj0lteK87hvMZEr98MEy
	 fmqBvenImhAL13Hd5rPt1fTeW5eFEdFx3uYOPw/JeYow4qYvu+LyiF9PHBlCjfmo4N
	 zrKKv3+aScigXnSQzUqxlETJ26cKXpxTwmAKvKPtVakgoz8ajqhIEPJSbHEO94YSGf
	 LH8EAvmtGBZaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajith C <quic_ajithc@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 087/121] wifi: ath12k: fix firmware crash due to invalid peer nss
Date: Wed, 31 Jul 2024 20:00:25 -0400
Message-ID: <20240801000834.3930818-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ajith C <quic_ajithc@quicinc.com>

[ Upstream commit db163a463bb93cd3e37e1e7b10b9726fb6f95857 ]

Currently, if the access point receives an association
request containing an Extended HE Capabilities Information
Element with an invalid MCS-NSS, it triggers a firmware
crash.

This issue arises when EHT-PHY capabilities shows support
for a bandwidth and MCS-NSS set for that particular
bandwidth is filled by zeros and due to this, driver obtains
peer_nss as 0 and sending this value to firmware causes
crash.

Address this issue by implementing a validation step for
the peer_nss value before passing it to the firmware. If
the value is greater than zero, proceed with forwarding
it to the firmware. However, if the value is invalid,
reject the association request to prevent potential
firmware crashes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ajith C <quic_ajithc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240613053528.2541645-1-quic_ajithc@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 678a08ab22f03..f328b650059ad 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3847,6 +3847,11 @@ static int ath12k_station_assoc(struct ath12k *ar,
 
 	ath12k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
 
+	if (peer_arg.peer_nss < 1) {
+		ath12k_warn(ar->ab,
+			    "invalid peer NSS %d\n", peer_arg.peer_nss);
+		return -EINVAL;
+	}
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-- 
2.43.0


