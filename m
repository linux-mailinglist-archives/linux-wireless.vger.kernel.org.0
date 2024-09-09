Return-Path: <linux-wireless+bounces-12678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B2971D9F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07128B23465
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E11C683;
	Mon,  9 Sep 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="kVoQM5LI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927251CD3F;
	Mon,  9 Sep 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894593; cv=none; b=YH6xnx8sWLzBdfLBppPKnwY0yrnaxXQSa25SZtbWAfNFCDe38xb8qKJRpRa+3eFJUekBDxXOLbNH//9eCEp6CVd/jrFmaIWjKtV8ti9erbdkrzPq0TTF16Kf0eYOWQ4C4Zd9o3y6Jl0O8GMxRYyZJANmdo2qHApVVgxwgokFwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894593; c=relaxed/simple;
	bh=j0YQ1JsT6Sl6v2u3HZJN1LUN5o+6fe/pgLKSj6VCpHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMJfmoCuK+Q5Qb5OJcJ1/ynaBzn+4W/ilUzh0lBBvhRjJqoNISdEkBdeRUKe8fx0P81hn2/Otsk0SQTNMBVs/4Ka/nFfBZeaVteg5gFRRyvBbxm+1fjP2e80B5laQypObbT8BW2EnDQ6wgZFu2NZkHr40CXWaHrJmQyooG5qMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=kVoQM5LI; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id DE719F96D6A8A;
	Mon,  9 Sep 2024 18:09:41 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UotMJwDW5c-o; Mon,  9 Sep 2024 18:09:41 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id B1366F96D6A8E;
	Mon,  9 Sep 2024 18:09:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru B1366F96D6A8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1725894581;
	bh=qSyQ4pSfZEnrTREXFvnropqxg0UKjf2Lm16mH1Y1mlc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=kVoQM5LIZeuKaFX+8V0CIgPFP8tp6Xzg+KdSRB5Ws0aZAx7HkpIX6ksZMyyM3sQ0N
	 FaXsOHy+WWpe+pK7oNnI9IT2qF2wmX13bRQL9my6D5QuosNnuo2X/Xyh7k9XYwfEbS
	 6+7HTgEX/G8A7e1QR3WpI8zE8MtMjFX37puTP7TSCrhKK93PMK0Nhsdy2SPCPF11i+
	 ZM3r67zof3Md0EoqlXvVVCO0HaujJ9gKcjx8EP3qwkWr5/b3SPIxWcVNyLdpUaBynh
	 ItlN9woC0zk9vr4WvyauXBPOumvz0Cm0pz9tUlvo8QWaX8z+AS8so5AgWJ1ZrGsEqT
	 YuWjoJe2lW5iQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IhIZLQJ360Z7; Mon,  9 Sep 2024 18:09:41 +0300 (MSK)
Received: from localhost.localdomain (unknown [213.87.137.230])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id D52C1F96D6A8A;
	Mon,  9 Sep 2024 18:09:40 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Kalle Valo <kvalo@kernel.org>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Jeff Johnson <jjohnson@kernel.org>,
	Govindaraj Saminathan <quic_gsamin@quicinc.com>,
	Miles Hu <milehu@codeaurora.org>,
	Sven Eckelmann <seckelmann@datto.com>,
	Rajkumar Manoharan <rmanohar@codeaurora.org>,
	John Crispin <john@phrozen.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ath11k: modify null check logic in ath11k_ce_rx_post_pipe()
Date: Mon,  9 Sep 2024 11:08:20 -0400
Message-ID: <20240909150824.28195-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The previous logic in ath11k_ce_rx_post_pipe() incorrectly required both=20
dest_ring and status_ring to be NULL in order to exit the function.=20
This caused the function to continue even if only one of the pointers=20
was NULL, potentially leading to null pointer dereferences in=20
ath11k_ce_rx_buf_enqueue_pipe().

Fix the condition by modifying the logic so that the function returns=20
early if either dest_ring or status_ring is NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/net/wireless/ath/ath11k/ce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/=
ath/ath11k/ce.c
index e66e86bdec20..9d4246d65d68 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -324,7 +324,7 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pi=
pe *pipe)
 	dma_addr_t paddr;
 	int ret =3D 0;
=20
-	if (!(pipe->dest_ring || pipe->status_ring))
+	if (!pipe->dest_ring || !pipe->status_ring)
 		return 0;
=20
 	spin_lock_bh(&ab->ce.ce_lock);
--=20
2.43.0


