Return-Path: <linux-wireless+bounces-14898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C030E9BBE5A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66251B2156A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944621D31A0;
	Mon,  4 Nov 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Np0AX/vl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E811D0950;
	Mon,  4 Nov 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750446; cv=none; b=mWbVPHg/xiD+KJPdLzpno7HxgDV3K3CtMhhQAMQXYgMCw5BCnSkSlUzNrNlH57EGwdInbowFqaYX3cFLu1CbHehq5PojxWl77O2/mex1wo/jINQM7mBdVDhcFQDei6NQB0lixYUj9oMxmdimNZzH+tIKipc8Unrx/uZstq5JK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750446; c=relaxed/simple;
	bh=LMJJhS0B7Tu7Sjw+WkfMFQhL7fYVUHwQBXpICSx8Zs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rQV8FlzHlk0vJEg/2Pk4+y8k4z4VOcXfVtXDIV2B/Np8YB4FVhrmaPigOe+kgecc63LjctctbFb6bdiY/gTt/lqhqN/Bo908BqaRT2TkJfZdfrqplT2mvFiW5ZGNzw/K06U7h3OWbXFMQ8RdZLDJKIZtI4WPA/145LjcgqVhzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Np0AX/vl; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (254C1906.nat.pool.telekom.hu [37.76.25.6])
	by mail.mainlining.org (Postfix) with ESMTPSA id 0445EE45BA;
	Mon,  4 Nov 2024 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730750436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VEYwU/POjkkE8kPomxxrGDNVJZLsEN8GDg8+PJbI0Hw=;
	b=Np0AX/vlaaE0IA3OznjAXqy0IKrp4PDRyLVDUyWoKB5FbX1gPU2IXj+FTrFfGAniM6owzc
	8jjo4f0WDwWCdNbpWrhh/GdeySCOGpwWuJp6ZhPdrknRpdpteAJ5E3X5gPwn+qbBcdP11e
	xy2hqIZP8TyVHyF6JUftRixMP62rlmbhUI550GyZ2fDVvqjTnlDOfNw8xFlcPIWGZR9jAi
	q8wNDx2La5ZRywjv7iK5gwa2zoH3DAqHXC6hs+AeilxMER0Wj94wu60QaJus4m1/2X2nSr
	n92ntB2GdGmHAJfBmzqJcHE1mNHq0MintJlFfp13ZjDRirHQ53DVbuLpDODBTA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 04 Nov 2024 21:00:35 +0100
Subject: [PATCH] wifi: wcn36xx: fix channel survey memory allocation size
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAOInKWcC/x3MQQqDMBBG4avIrDuQmCBtr1JchPhrBzQpiWhEv
 Luhy7f43kkZSZDp3ZyUsEmWGGroR0P+68IElqE2taq1WivLuw+mK4UXLDEd7OY5erdWxU9lYGE
 GvFxH1f8SRin/96e/rhvloHs8awAAAA==
X-Change-ID: 20241104-wcn36xx-memory-allocation-803e4e3de9a6
To: Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, wcn36xx@lists.infradead.org, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730750435; l=1436;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=LMJJhS0B7Tu7Sjw+WkfMFQhL7fYVUHwQBXpICSx8Zs0=;
 b=Kp02AfBbGzi07hAP7ZTjvPJl7LCM/96kH3UbqHtzIS37rFrJIrku/jTSxlYtcFqQ/A3U6j2G2
 hHeY8f+tq/vBbWkonhXW82ile08SRNIgb7KBNp6gCD0104IRxZnSDh/
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

KASAN reported a memory allocation issue in wcn->chan_survey
due to incorrect size calculation.
This commit uses kcalloc to allocate memory for wcn->chan_survey,
ensuring proper initialization and preventing the use of uninitialized
values when there are no frames on the channel.

Fixes: 29696e0aa413 ("wcn36xx: Track SNR and RSSI for each RX frame")
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 408776562a7e56da3017aa074396bcd241d62f8c..cd36cab6db75d300f4f6617a6a9e1550f62921c7 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1590,7 +1590,10 @@ static int wcn36xx_probe(struct platform_device *pdev)
 	}
 
 	n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
-	wcn->chan_survey = devm_kmalloc(wcn->dev, n_channels, GFP_KERNEL);
+	wcn->chan_survey = devm_kcalloc(wcn->dev,
+					n_channels,
+					sizeof(struct wcn36xx_chan_survey),
+					GFP_KERNEL);
 	if (!wcn->chan_survey) {
 		ret = -ENOMEM;
 		goto out_wq;

---
base-commit: 1ffec08567f426a1c593e038cadc61bdc38cb467
change-id: 20241104-wcn36xx-memory-allocation-803e4e3de9a6

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


