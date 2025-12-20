Return-Path: <linux-wireless+bounces-30012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D71CD2415
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 01:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0024230656D6
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 00:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA97233721;
	Sat, 20 Dec 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnXWV5mR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7C1E5B9E;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190157; cv=none; b=IeXdvzNHLVYgF+pjK8szh13w6gFnFkwQ1HNLIITe4NVsNs6Ks9kDTuV3IMImqQHBZtW3sK28gRG6iKz8vllRMnfz19MrqYvOsiDLlWBMT0ma6nP2SHAUUb74DV1ZqlqK30z+vuO75Lo1Mx45T4W+XNkLwgeHyL46ZqbPbSkKOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190157; c=relaxed/simple;
	bh=y8uwgejRLp1483O4zbHXfsEQl2sOPvQtaBL89zBQ1kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drMtLZbH0GZ+3WX3O2PH4xFKAWKl7qfNjIinu0v4Wp3y1JnaGafFsG+7Ndc8Bs+5+VDVRuc31SVJU4etjbtqkn9g0qKhTnt4fj8RlW0SvKsViaaJtyFYmhQwgUsfWN7pv/2Kv343UZtSvslvgpgKQ5ghHC80t/lWjVOmU2gRM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnXWV5mR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 592A3C2BCF4;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766190157;
	bh=y8uwgejRLp1483O4zbHXfsEQl2sOPvQtaBL89zBQ1kE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mnXWV5mRKRRUfDdw9x2ga5stBtxvwMTOuDfi/jmKjJdRi8IljK575suHkEKY1OuXN
	 h0y1f21+ieFohGoFZrSVZB48CoN0BYOaHQQnn5S2elXX7p8GV52sbmR5g7R9b5NOqS
	 ikwne+5/5E6LMO6S8Jq6yabsLTdz9QiGaT47crvJokSpfTOtJpBTkgkVZiv7RBWahl
	 JjtJXNKt0wcz1LFU1Tc2Rnq+H0hSF2BX7oETJfHG+gYhfkB7PoSuKmEm9h7BFxmRuK
	 mrnhYktOXUSiOsLl3BUZNN8zIgykWNKUkf6KNjARVKZ8QlVKILgQkif9n1IYmsCeMz
	 ymylJ00jHrrAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B0E668A7;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Sat, 20 Dec 2025 01:22:04 +0100
Subject: [PATCH v5 7/7] wifi: ath12k: Add support for disabling rfkill via
 devicetree
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-surface-sp11-for-next-v5-7-16065bef8ef3@gmail.com>
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
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766190155; l=1262;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=o+2ygO1zvLsftpDj/dtrdmFTDVzHA+1Wm5SG6mbwRZw=;
 b=puDEyDrH298j7z4liMYX0YwZHegBdP1BrcSrveoBtN/lv9OuK3kUHcpM/2uU2GVvU40DhCqw6
 1GNpYHPLvfhAJCNhfYU+0CILuvsG9oupHPmzIdL8kdaKQqgxheKFzbq
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=DcPD9n3oDMsPkt+12tU96swmGb5H86cxt+yiEVcUEGk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20251217
 with auth_id=580
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Reply-To: jerome.debretagne@gmail.com

From: Dale Whinham <daleyo@gmail.com>

Some devices (e.g. Microsoft Surface Pro 11) indicate that the rfkill
feature should be disabled by means of an ACPI bitflag.

If ACPI is not being used (i.e. booting using a devicetree) then this
property will not be read and therefore rfkill may be enabled and
the ath12k will be hard-blocked with no way to disable it.

Add a devicetree property that allows to disable the rfkill feature.

Signed-off-by: Dale Whinham <daleyo@gmail.com>
Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index cc352eef1939937ce902bee2fbd9737ca3ab5993..e10073bb975cfd2e9ee418edcc49d0d51cf93de1 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -77,6 +77,9 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 	if (ath12k_acpi_get_disable_rfkill(ab))
 		return 0;
 
+	if (of_property_read_bool(ab->dev->of_node, "disable-rfkill"))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 

-- 
2.47.3



