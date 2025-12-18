Return-Path: <linux-wireless+bounces-29912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DCCCDCB4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D197304A8E9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CA730B52C;
	Thu, 18 Dec 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYyDU3e1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496C2F4A10;
	Thu, 18 Dec 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096534; cv=none; b=D0ge6wuYTmXN9yfufO14khZET14dedJJL0PJHXamJUMjE/qRkuOiT/Sw6kC6jl0l98oP8YtFGpssZPaEAJ56B5oKWjcD2rhA3ijEeVsA6x7NSL3fBPA0UhmRnU7T+ZqA7twhj2159QBSpsrag1pewXXc3pDVIuoTjIv6ltBMvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096534; c=relaxed/simple;
	bh=rlWIfYfoikdm2g+ig1MLpFeBTAhiwN72iY5iv6kr7aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWUEPoAxHHR1qjZPPpaYrJVowMq+lgnbTyEVVcZAe4UTcQRXVqptONhU+2Xa8lVc85ydz/uaAf1YKKF+rr4qO0WrsTAzLwABHT2cAaS9Y884fIBA53ZI8RvJVQTCl8tepYbpbDQOea+AG9Db0Cm5gyJTIJRsGjObJVrfpyzONK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYyDU3e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB60BC19421;
	Thu, 18 Dec 2025 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766096533;
	bh=rlWIfYfoikdm2g+ig1MLpFeBTAhiwN72iY5iv6kr7aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EYyDU3e1s5fMDoSRZhdb16hxOf1br0W5bzTPAxyYjZbNIyKioyKZV5ar+5jDIPTWp
	 XIfCiZFbT2OxbmpnbMza/DZdj/xyA1GbMfJQFoSJyEC+ETLm3px/W+j8vmAZ9CV0Jw
	 AdBK94WsfL7pqpbJwQP+23EEToCE3L6y6WWr/IAtBjdISECyGNWbcu4RiOektrNgQC
	 +cM0nsadnIcLt42RvVA/m70DadaiBCE62kJQtINu0xWj1FKz0DBuW/Ij5bApdQOEl1
	 RCOWeXNOzZpPDX2iBX/gDKhrrpeRhSgqdf85nHRjbxk8ODFTGbCnqyVqOBTDWRS5OH
	 gZRHuTnl9adbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD17CD711C7;
	Thu, 18 Dec 2025 22:22:13 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 23:22:09 +0100
Subject: [PATCH v4 3/6] firmware: qcom: scm: allow QSEECOM on Surface Pro
 11
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-surface-sp11-for-next-v4-3-7bcf83c1504a@gmail.com>
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
In-Reply-To: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
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
 Dale Whinham <daleyo@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766096532; l=997;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=CNbXWtuQ7AggDKzwaLKJE5TiiiPe100NQahuSnOowsU=;
 b=ukGSOm6Yhnzn4fVlQUSYSDNAlfu0Q+iv4RNSF77UjwOzEthoR+JuEYZ+9OWzsL5JAfT4hmL8E
 cANL6zf/U/rBAIzcrET958KJkgBiaisDANcffxgLhEsPf25tggBysUY
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



