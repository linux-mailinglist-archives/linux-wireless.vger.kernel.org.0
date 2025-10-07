Return-Path: <linux-wireless+bounces-27851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D3BC090E
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 10:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A13B18882BF
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622C258EED;
	Tue,  7 Oct 2025 08:11:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C82550AF;
	Tue,  7 Oct 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824696; cv=none; b=V5+MGVqb1kZJaA1GNVqjeJpPCOhXpRBAc6qN8svvtE5DcsJv6OXqua3IgOtwNjpRqL8VDwfvLD2JrJGW9yTOefXVaB6U4bETr13Z2KyuFVgHMOszUBXHEzGrrbxEWkQDYtmdO/LmIwYYBXIhUzsGIW6bHAz/Fsrskb6HAkd6yCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824696; c=relaxed/simple;
	bh=Zgzq1p3L1CDxfbkdFz0MtUhMwlBzhL5HCmT/wDBTlB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCvWl9kExJQC0uRgrPXBELsMPnvC8VfEEgCc0qSyZyYhq8w37Z2L1J46tpKCtsYRH1mPN0KvIiDVvthxPEFhvm1ZMynswOvTM00Zg0r08TMzgPx9ZNx+l6wISfPFhQZFFvOZz6/J6j/zINBwF4Vej0nhyyajUvvpWWkPw5BBLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300c597021aE00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:9702:1ae0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id EEDE0FA130;
	Tue,  7 Oct 2025 10:11:32 +0200 (CEST)
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Tue, 07 Oct 2025 10:11:14 +0200
Subject: [PATCH mt76 v3 1/3] dt-bindings: net: wireless: mt76: Document
 power-limits country property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-backoff-table-support-v3-1-fd6e2684988f@simonwunderlich.de>
References: <20251007-backoff-table-support-v3-0-fd6e2684988f@simonwunderlich.de>
In-Reply-To: <20251007-backoff-table-support-v3-0-fd6e2684988f@simonwunderlich.de>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=Zgzq1p3L1CDxfbkdFz0MtUhMwlBzhL5HCmT/wDBTlB0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBlPTuuuL2D80DAl4bZujOTXE2xvT79bf/3NN8fGo2eFG
 iUSZyUUd5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8pyP4Sfjdda7jx7NUuwV
 f7WkIThrful8sSlhTNfq/998Xazwsj2HkeEFe/aKzy+2f9lencT3izNB45Y0V4+LSv3NvRvSpMV
 alnMDAA==
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
 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index eabceb849537..82b224c2f6f7 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -151,6 +151,12 @@ properties:
               - ETSI
               - JP
 
+          country:
+            $ref: /schemas/types.yaml#/definitions/string
+            pattern: '^[A-Z]{2}$'
+            description:
+              ISO 3166-1 alpha-2 country code for power limits
+
         patternProperties:
           "^txpower-[256]g$":
             type: object

-- 
2.47.3


