Return-Path: <linux-wireless+bounces-29856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C9CC9D80
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 00:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E7B63058849
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93E314D30;
	Wed, 17 Dec 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDXKDnpg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D327FB2A;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015818; cv=none; b=uUmGhNbi83l94KIm2f6n+/VKrmR3bcKtR5X4VA7ZRMTINNVp/r13hLkxOoR4XprxZXXEA1T5vSGU0lur/+pEUo7DQeVxJt1tl3VzigtWoEirZ3qWSjujdGqfnvEp11qYC0n3Ga+1KGQ2Tlq29WhTM1qfWo1KonYF344XiYjaXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015818; c=relaxed/simple;
	bh=rlWIfYfoikdm2g+ig1MLpFeBTAhiwN72iY5iv6kr7aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvT4oLWVLa5mXl5zbARxQVUA8HuMdPIslqY6D8gB+dCmeVJzmJC+3m33UbfP++J9Fh76lz8J+WOHMBzd0+zG5d6B0qxPOsiY9rmOMzPoQ+J3F4xSVTt7ipq/XhqCWCGukft9XnHFn3cZ+WnYeweH7fpItAl1oRnoprmyIFyYhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDXKDnpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96A45C116B1;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766015817;
	bh=rlWIfYfoikdm2g+ig1MLpFeBTAhiwN72iY5iv6kr7aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XDXKDnpgUDkeR8WT4yffOTSZFZvW+9wsF4gwjfIrQbICkD3tGWg9c4fB9AMFlkxbk
	 60XLL6RXk69wfjfTk2FsnLRx9WeHZvgImDj8d0XpUqkxYZufO+TUFEMnzaSl3lh54j
	 6I0cCIF9usmN6BXR8MxTUI5ZC9Ay5BJkco0LpaMSWt0owp5yjMwtjIK+pWkqyjXuX6
	 4nVVzi8XWqplDde1YjQugZOlqvJ2Zrizg+aNUyp7hLfnnQbzx07tSZhooyIyc66lBH
	 gR7wIEd0rihcUUBbELZYdfwO8HSYXO2UIQWuU5HMRqUwSLJg26+DdiH/DoDkp8Ct1p
	 MWregVYTpxRkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8542CD68BC8;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 00:56:39 +0100
Subject: [PATCH v3 3/6] firmware: qcom: scm: allow QSEECOM on Surface Pro
 11
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-surface-sp11-for-next-v3-3-875afc7bd3b7@gmail.com>
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
In-Reply-To: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766015816; l=997;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=CNbXWtuQ7AggDKzwaLKJE5TiiiPe100NQahuSnOowsU=;
 b=ak4eiXdD3Gj1n9PvRTLZx5cxnafhBsaEQ7uFQsZ6O4us4FlPY19pBpWHSKMmLSiOz0+8HBCif
 kucnKTend0DDnacObWYdDmoLUs7ioWO6fYGR13S27XlCrfXFMCLJCRu
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



