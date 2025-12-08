Return-Path: <linux-wireless+bounces-29589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106DCACE1E
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601AB300E3C8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B662E972B;
	Mon,  8 Dec 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="NDJzF6Sh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47622DF125;
	Mon,  8 Dec 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189950; cv=none; b=Vy+UotTW1Q/tHHrHBXlXIMgZ4G8yzyA67GYnBbB/G7vuPsYnAbV3/xi2HxdH4HIOYtumg775P2JsdMFzl81JY3r3/mnqxDFgG9T9aYRFcLtT+oagrnnMUmwh0NIZLEy9qWky8MZbPiLfvHx7fX9zojoz/+6JyrJ8G2hJ5drO3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189950; c=relaxed/simple;
	bh=r+2jMQFzU9+NoNZmLEzpEBGBeob89jC8EU4XtkCLq78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6Yu9OOaBu7tZbpk4VA1M/fncKzqL8unLiY+1jmwQpuw2RM9K/4YxsxYNmeWqDjYx9z7h64nvw68C8WvHLBeWSSZ5PKj0dwxZdwwXYWXi6JOFVnre2VmRN4efy7GTwqtIiVSyu+Oc0q0KIj1iq5Y0Q3XKTUj6H94/dEPFl2zYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=NDJzF6Sh; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=145192da8d=os@dev.tdt.de>)
	id 1vSYXL-00EEcV-7c; Mon, 08 Dec 2025 11:32:11 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <os@dev.tdt.de>)
	id 1vSYXJ-00DfeR-SF; Mon, 08 Dec 2025 11:32:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1765189929;
	bh=V2LuImD69vBgHSzkMExG2GJJ4r6pVKhCiiWXxSYDJBM=;
	h=From:To:Cc:Subject:Date:From;
	b=NDJzF6ShOuTsWdFh433cFknxb8sDj2TU/2Z6Dr0zQUDR+uRxFpl5mz65hop2gavNo
	 gCASGNlPQ282V1shzC6B6zj9xoriIPaXVr9vgZP5gvM98OjpavNULE47iIKMH2o5Gr
	 0x6ZjonLMFBbZqXCMMUKQb5rDI4Sib3oBcfJN61sdTd2o63CuzLRWMI+gpzb2XkwA6
	 895zPZcCTUX3pDIWTHdjT1T/rI027hFmJVcwLfGObKuDhFq5R3U+wxcYzwPOs32laX
	 NFkgl0ixssUP2hmWmuSIRqz4m26/G3RAy5t6NFszYEvhPJ1xUoVnqsktn2mbb9LDV8
	 tPJX3oGiO8s2g==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5974F240040;
	Mon,  8 Dec 2025 11:32:09 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 53377240036;
	Mon,  8 Dec 2025 11:32:09 +0100 (CET)
Received: from osedlbauer1.dev.tdt.de (unknown [10.2.3.165])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 1FCAA215E8;
	Mon,  8 Dec 2025 11:32:05 +0100 (CET)
From: Oliver Sedlbauer <os@dev.tdt.de>
To: stable@vger.kernel.org
Cc: quic_rajkbhag@quicinc.com, Oliver Sedlbauer <os@dev.tdt.de>,
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0"
Date: Mon,  8 Dec 2025 11:31:52 +0100
Message-ID: <20251208103152.236840-1-os@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1765189930-3B70406F-E4D17473/0/0
X-purgate: clean
X-purgate-type: clean

This reverts commit 3b5e5185881edf4ee5a1af575e3aedac4a38a764.

The REO queue lookup table feature was enabled in 6.12.y due to an
upstream backport, but it causes severe RX performance degradation on
QCN9274 hw2.0 devices.

With this feature enabled, the vast majority of received packets are
dropped, reducing throughput drastically and making the device nearly
unusable.

Reverting this change restores full RX performance.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: 3b5e5185881e ("wifi: ath12k: Enable REO queue lookup table feature=
 on QCN9274 hw2.0")
Signed-off-by: Oliver Sedlbauer <os@dev.tdt.de>
---
Note:
This commit reverts a backport that was not a fix. The backported change
breaks previously working behavior on QCN9274 hw2.0 devices and should
not have been applied to the 6.12.y stable kernel.

 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/=
ath/ath12k/hw.c
index 057ef2d282b2..e3eb22bb9e1c 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1084,7 +1084,7 @@ static const struct ath12k_hw_params ath12k_hw_para=
ms[] =3D {
 		.download_calib =3D true,
 		.supports_suspend =3D false,
 		.tcl_ring_retry =3D true,
-		.reoq_lut_support =3D true,
+		.reoq_lut_support =3D false,
 		.supports_shadow_regs =3D false,
=20
 		.num_tcl_banks =3D 48,
--=20
2.39.5


