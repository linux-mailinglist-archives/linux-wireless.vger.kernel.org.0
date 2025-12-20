Return-Path: <linux-wireless+bounces-30008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A63CD23BB
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 01:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB5E6302017C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 00:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F61DF980;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpLXOGja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712721BD9D0;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190157; cv=none; b=JEU6ZbG00oTQGOKrfwFID03cMPCd/Lpc66V+fZri0isqOeivbdsRdZvhE5xJ9PnVoFLpOTCwnfi+s4VACebR4c/xLIadjvYwuwv0ZmO59GGfoIYRBof1wSvmVS8dTBhS1R/cpndIOkxn3gO3NPDryxAvqKv5CIXAYghYckEoDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190157; c=relaxed/simple;
	bh=3gL46iKOHV7A9GULm4RsQF6Ghf1ihX4Z2cVWKSJEzAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pT2ynH4CYA+Jl12Gp2A+PgfMnsHBqZEgAFyIDyjBx6T0f2+7Lp9lg0W6LoXukO0IwZXYrRhJ5VGOcLG1EHByW1g8Mz9WxkylxLCjuL8GLM+PgDm9fRUjje+M8eT4Spj33u/NBB9/Gm4WkO9KreAgIh9rk5kPFA+Xwv2jFYis9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpLXOGja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10D35C116C6;
	Sat, 20 Dec 2025 00:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766190157;
	bh=3gL46iKOHV7A9GULm4RsQF6Ghf1ihX4Z2cVWKSJEzAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BpLXOGjaF44VnGOvcfCiiM+paSgHyQFDmaxrbdiVQlZYcVrMzR9C908oGSEMm3v5o
	 0c2F8cMfAQCgoMN0LPkEbmcTdaNJukRbFnzZjgIOSw53yOaSYsA/t8142SV0EwwrCu
	 Cj5beMrAJye6yBncMNsl5HOFWdXGptm2IfsD/9DdniN2VAMbZojzrk93iXgYnLjaKX
	 06bEhB5WKbSDgn11Eg8kllVlsxyc4AXhV74mSTIpJZaI+oRaoVKiPknVF5racBT+G1
	 WHlYfoQOMGEw3wXUsghoRKz3m+2c0+fBYm3Y8yO5Y2XFDX1NzMsVjLy/amh3ObupUo
	 LKXqBLl5fvdJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1749E668AA;
	Sat, 20 Dec 2025 00:22:36 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Sat, 20 Dec 2025 01:21:59 +0100
Subject: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766190155; l=1434;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=UsivquG+u5XDfL84mTTPzxSnboH8akBZuwYgTwNKJ2E=;
 b=cBW+jT4ifdDwOyelBETbQYtlzG12/o3A9UFELZzrjKCYjeemAre13mAG6Pj1Y/xsqzZYiIdsf
 3Ps6S09CFvQA27d1Lgu75ZY4EPm/EFnvu3E5h6dz90t2mvLjZMntpE/
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=DcPD9n3oDMsPkt+12tU96swmGb5H86cxt+yiEVcUEGk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20251217
 with auth_id=580
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Reply-To: jerome.debretagne@gmail.com

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

For some devices, Wi-Fi is entirely hard blocked by default making
the Wi-Fi radio unusable, except if rfkill is disabled as expected
on those models.

Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
disabling specific features based on ACPI bitflag") added a way to
support features set via ACPI, including the DISABLE_RFKILL bit.

Add a disable-rfkill property to expose the DISABLE_RFKILL bit
equivalent for devices described by a Devicetree instead of ACPI.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
--- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
@@ -29,6 +29,12 @@ properties:
       different 5 GHz subbands. Using them incorrectly could not work or
       decrease performance noticeably
 
+  disable-rfkill:
+    type: boolean
+    description:
+      Disable rfkill for some devices on which Wi-Fi would be entirely hard
+      blocked by default otherwise
+
 additionalProperties: true
 
 examples:

-- 
2.47.3



