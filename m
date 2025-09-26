Return-Path: <linux-wireless+bounces-27673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D28FBA3491
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 12:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB56A624B30
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED252BF3DB;
	Fri, 26 Sep 2025 10:05:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5F286D64;
	Fri, 26 Sep 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881155; cv=none; b=lanHE0ZEqFIHe+Y6GHlL0usdFT6KvOmuxTAiSPCznCyMppXeoFsMC7JUZYzJ5CREhRyJ2DoXvCez0OdAuuv399zpA04GZoaTd8YXKYri1GWlIvV3OgFI3X9cl28X939cB9WCbujKiw6ghyoSdQzPnAFaWVMuHLFAI342awGhPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881155; c=relaxed/simple;
	bh=pa03GJbD9ITiVTNCYJUKaELBwKC4tTy/GDvazBnS/g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fn8EbiX4PpgU4O1yCmMqlx1a9D/LO0EHp0d6ro5K3TYOVbIZXNq4k9HFXbu8UylmV6tV/VhtuYGp07Wf8Db+0ti71FxNPoh1U3pxHBj0tUrBniFN2UGIkRRyFnWxqSXHXCV0DujI4eFLgPnbLWGPneTiyFNNjjyKfL+BZYLYlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300c597166BE00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:9716:6be0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 9B90EFA130;
	Fri, 26 Sep 2025 12:05:51 +0200 (CEST)
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Fri, 26 Sep 2025 12:04:52 +0200
Subject: [PATCH mt76 v2 1/3] dt-bindings: net: wireless: mt76: Document
 power-limits country property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-backoff-table-support-v2-1-16d3726646c4@simonwunderlich.de>
References: <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
In-Reply-To: <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org, 
 "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=pa03GJbD9ITiVTNCYJUKaELBwKC4tTy/GDvazBnS/g0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBnXUst5eepFFq/ad+KQhsRpjx9CvNFtV8XDe1dVNl2x3
 HCAQ2pxRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiC1MY/oq19QrVPlg0K/vc
 n1MTTfSd8qLjC6XOzGSdV/HuSZSi3EWGf8ZpGx4rrGS+sM41Ly3o+FTPi2FZrOLPnkdMeuC6/ZS
 FJQsA
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

The commit 22b980badc0f ("mt76: add functions for parsing rate power limits
from DT") added filtering of the power limits based on two properties:

* regdomain
* country

If either the country or the regdomain matches, the power limits are
applied and the search is aborted. If none of the two is defined for the
power limit, it is a global (or "fallback") power limit. The last
"fallback" power limit in the list will be returned when not matching
regdomain or country was found.

The idea is here to allow to specify "overwriting" country limits in front
of the list - just in case a regdomain is shared but a country has
additional limitations.

But this property was forgotten to be defined in commit 2de6ccebe0e7
("dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node").

Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
---
 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index eabceb849537c418650697da86682ef04c979193..f8f72f3f1b1dd185b4797be38b87c621ef3eac08 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -151,6 +151,11 @@ properties:
               - ETSI
               - JP
 
+          country:
+            $ref: /schemas/types.yaml#/definitions/string
+            description:
+              ISO 3166-1 alpha-2 country code for power limits
+
         patternProperties:
           "^txpower-[256]g$":
             type: object

-- 
2.47.3


