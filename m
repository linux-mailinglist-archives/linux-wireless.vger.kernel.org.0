Return-Path: <linux-wireless+bounces-29858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE6CC9DA4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 00:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 109193098F9E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 23:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0AF3314B8;
	Wed, 17 Dec 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg/yH8mS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDA2D5410;
	Wed, 17 Dec 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015818; cv=none; b=l0zrG2Foxve5oe1wmDm/hiEcPdzs6WURlWUvTX7wnHU/rAfEsi+HwxKrnORICulAxjoeqToECCK24Z1aGf8PEObftMIhPu4O5zj0p89AWuHLT36lgz1bMDO9DiCqhmAo0/4vbUXE0U9GvRIjP2azNQo61VTfjepavOC5B0JNxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015818; c=relaxed/simple;
	bh=C/ueUWFjCyD/VD4TdJXJVaQRqT2VnOEHgebnD6XjxSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmWTbQOTsBHhWYM+b/LTe41HKc5QAPYZrHVnYGbZT3P0gfN/v1PG5UXloYMAAjFLpSjQw/IH4mPwWFaqpMojsi2CSEcOPN8Zp41QP1QAt+wQgt8SFlnI7G3SC2/iK8KLHjA1XXj3yG8yXw18nBhFc1KthIoEFP9/C3vd1y7kz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg/yH8mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C34DCC2BCB2;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766015817;
	bh=C/ueUWFjCyD/VD4TdJXJVaQRqT2VnOEHgebnD6XjxSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gg/yH8mSTYgUD0T/tb9Qn8AnGrVQ+rAYC8pBAFGF7ftrpEX2XZQUbfirwx+vmcLih
	 tFh8Q6/US+tG7h1R1anTB6ieiEfr/wD0QA2agVqjwkhbhse+uAbFwgfEffUfV5LadX
	 hRcecHQ0+EuOWurSpHdDfwwEeA52bxZrT3Ra2f/YnUofrFJLW8rpFGUgTMUrnOPTIY
	 7B97cGDQk9R2+pS8L0Fq8ZTWPCga7GeoKQht5ZpN33KugPiNc+EcuEkuXe0ZOu1I+8
	 foACkM0NkgB1FkOWnDJf5xNpVeyxkhw8EZo8syxIfGiIgqYS7nl5CCKQP1f1Jk4WQh
	 H/BaUrLo+encg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B454FD68BCA;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 00:56:42 +0100
Subject: [PATCH v3 6/6] wifi: ath12k: Add support for disabling rfkill via
 devicetree
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-surface-sp11-for-next-v3-6-875afc7bd3b7@gmail.com>
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
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766015816; l=1265;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=mcMjGRXAT6QkIO3PWrqFYRB9BASEzAi+bYp6SS6IoLc=;
 b=wXvPF3j03/LWNZD75iE4hFwXKHz7tgopfmBGylHmu1LBrffKpaZf4z3HFwaYucG5rmnNBA0TC
 +3IEZJkayLkDTe1BOcdFdQoiRfnRjfoDmZPUZW4J2nyHcsYVTGtyd+H
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

Add a devicetree property that allows us to disable the rfkill feature.

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



