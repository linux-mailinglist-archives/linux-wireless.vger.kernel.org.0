Return-Path: <linux-wireless+bounces-30013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F99CD2412
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 01:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D81C93065034
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 00:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C123314B;
	Sat, 20 Dec 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+JEHBqw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDB1D9A5F;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190157; cv=none; b=WINM5FvYcjDU3vEnSCNsUPzftaTtoaI8lnU5zhbHcaitmTxjrZyhzouPUYe+gkmJZCXwnqfiG2wlK7QCN0vP0gXHzuNhf5wFDkGRDIqQ2eRFp42TGnobxIPs9zv3fthaoYWpiKMTEangn2JH8F84Sb+Xi9QtNQNQyxb23Xyo8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190157; c=relaxed/simple;
	bh=rlWIfYfoikdm2g+ig1MLpFeBTAhiwN72iY5iv6kr7aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ded1lIV8TFsstZ/M4sIGkEhBJ6tO2L+SWMkT3Q5EcLsP7tsMQWWk9wMNhRrFMpSmToxXeHzaxbqJE1mQ+DXNp/TcwwssHDmh3GECZN5/G4bBflL8TpRj+7JKOs8NZALZ1uyf4MJgov6fABi9cZc4xcnM+Gpj+k3WGIxSooqUBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+JEHBqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AB26C4AF0F;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766190157;
	bh=rlWIfYfoikdm2g+ig1MLpFeBTAhiwN72iY5iv6kr7aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e+JEHBqw+6wq5N/ZpR3D1POXI/9/I4ODlmM/3Sy/pwXBHMlu6wIBMrdfJcRL4dP7b
	 7q3dBmSBVp+13Qkdg5+nd5AyVRgPRrjfWjBgahDC8kjUlGfflrmb7PM8AVOCiI86ue
	 nCtZSJXh/WY/LTfyHb7Q4IKH1TY9SEPnCcWRGTCdcyF0JrhpqZe4bZxTD0uQGODEAP
	 EZ/Y/qr9jlUbLmH5+hXP4gkNwQmMZmqr+eolMjcGeDpJXrD91z4+PQN3KnJaGK7VJa
	 pwmLgR3AYjGtPMAmtHSMWQCk4jcGAjzZaItQrbH08fiOqGvMOpEc2+WoBpUODa+pfZ
	 Ji7sgg3TXwKvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C7E668AE;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Sat, 20 Dec 2025 01:22:01 +0100
Subject: [PATCH v5 4/7] firmware: qcom: scm: allow QSEECOM on Surface Pro
 11
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-surface-sp11-for-next-v5-4-16065bef8ef3@gmail.com>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
In-Reply-To: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Dale Whinham <daleyo@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766190155; l=997;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=CNbXWtuQ7AggDKzwaLKJE5TiiiPe100NQahuSnOowsU=;
 b=ekWgYqaKP7EjU9lwdtb3rgAIV8UQxvoJ2yREJfvy1Co58tmpBXF5fW0VgGbUebmHht3Fe0osN
 bunbE/BezRVD2bxia+JaDQty15ro+fSWlBPwikL5erL6UusNpJutg1L
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=DcPD9n3oDMsPkt+12tU96swmGb5H86cxt+yiEVcUEGk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20251217
 with auth_id=580
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Reply-To: jerome.debretagne@gmail.com

From: Dale Whinham <daleyo@gmail.com>

Enables access to EFI variables on this machine.

Signed-off-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 1a6f85e463e06a12814614cea20719c90a371b69..3dabb04094f91811a430e84998d3c6c759b5c747 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2007,6 +2007,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "lenovo,yoga-slim7x" },
 	{ .compatible = "microsoft,arcata", },
 	{ .compatible = "microsoft,blackrock" },
+	{ .compatible = "microsoft,denali", },
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
 	{ .compatible = "qcom,hamoa-iot-evk" },

-- 
2.47.3



