Return-Path: <linux-wireless+bounces-29855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF010CC9D77
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 00:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658A7305483C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 23:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66F30F54C;
	Wed, 17 Dec 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVe6bKBp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845F274652;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015818; cv=none; b=o87wL4Wc68pAw/uq1R07BIZDfUFeXJoot+zdLA+8fxqVNZ5TcM5QWIOG6oZgxcvPVDzNu4OqJQAH6K5TJUdGj0PPgxxpBn4QKXwE3TmVzNkPG9cBo5Sfb2rLMLdokPIAFu0n1AOrvwo5Ztpdj8g0hiVUcVzA4I28BTHt/RAezpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015818; c=relaxed/simple;
	bh=vYWy4tIF0oImarVkvgA+J57CDTRRyXKFwzAaZ9x3bZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGirRkABsdlU0NA3Xyfb4Zy8SLTc9tLCUy7PoiDbN/Wt8HB5gzbwwGX3VKJGWtF72FonqaTra5zQGOusBkBK4k7Gf5z0rITfOIKyQxITxstTdlbLp96mHsBfo4Dc0tM97uZ2qsCIBSaTyPfCMlXTehgtTcw1wv8PGyrYwPth8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVe6bKBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83561C4AF09;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766015817;
	bh=vYWy4tIF0oImarVkvgA+J57CDTRRyXKFwzAaZ9x3bZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KVe6bKBpTyt87/LKfAwyJ4lLg4FTuB2VhdYJn4JEsVeVuCF5sH6uiNHOSepqNAl+J
	 BlE9K1oOF6RUbJpTS5FEYD61KWJc0XcrOugMwUwCB3moi51gc0cDOgf8tHIKW7kum8
	 kfzVsoUn4Wi2xysPdDqjLi10Q++S3nE3PDoC+asKpAglWiz1sbGshyhO1MWWCJXseZ
	 sccGMfAj+Wn3YDtKcTGphW00hrU+MeFl6oCy5yjvwrP5GNkkorbNbXloi4yEsH/BD/
	 qEKvAGe5UXwphSWRnc94O2MulTMaIwojQlzHVSFiNXJF3yxlZVk90oSsVcwbDK+X6g
	 MO7a5Tz86WzzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7484ED68BC4;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 00:56:38 +0100
Subject: [PATCH v3 2/6] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-surface-sp11-for-next-v3-2-875afc7bd3b7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766015816; l=1478;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=B9SXON9447NJlyUwxvW/LOflPUSy2K70Poc9F3eFNw8=;
 b=lfYTLElkmqTEh/CmzNAY2sL4elUcnq30On0LHA/2KpqAGgkgieJvcRNYvEaSxTLsda3lQGjGI
 yDkaIb+j6OIBNLu5oADBLWdkHKsTmoEUWsodYfbEtLqOEbPFpXeo61o
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

Tested-by: Dale Whinham <daleyo@gmail.com>
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



