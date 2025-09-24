Return-Path: <linux-wireless+bounces-27637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03981B9AB37
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 17:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4B43A7073
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB219313281;
	Wed, 24 Sep 2025 15:34:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E831282B;
	Wed, 24 Sep 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728069; cv=none; b=dqQqAEvNTOgir4VK56N3spH93/XxH53TXP3UyJTVhYWppA45s2LHiL2AxIK7Y9N1sxIRqUNvkge4VOStMamVqfPCUwJNP/Uqz+qBMh/6wGhOvqy/JnsSqdOAxNXf9uCqQXepU+FErKr0Oa7uYGUTfbprKdR9Vh0TqJF0QXx8CA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728069; c=relaxed/simple;
	bh=uBaOvLBEYw6cM2ZE3ZNKPKFL8pnovauxKrJogvIVOw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhgvW8NKgortffwjTuDZa/8A2L4o2E6EPDjkEXeKgaldDFh6RhRP1bomofBRfXJLHZo7iJg93WD5su/wvNOL/ZFDMgE9LbuuaaB3tc5ipXfVZm4IRaqQrS078ysw2FX6jE+bsgDWcU/hmQYNrxPn9H2Om+8ndlOCDBk4Dj9jx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300c597296Be00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:9729:6be0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 1DD0DFA184;
	Wed, 24 Sep 2025 17:34:20 +0200 (CEST)
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Wed, 24 Sep 2025 17:33:10 +0200
Subject: [PATCH 2/3] dt-bindings: net: wireless: mt76: introduce backoff
 limit properties
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-backoff-table-support-v1-2-20e50fbc59de@simonwunderlich.de>
References: <20250924-backoff-table-support-v1-0-20e50fbc59de@simonwunderlich.de>
In-Reply-To: <20250924-backoff-table-support-v1-0-20e50fbc59de@simonwunderlich.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3962; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=uBaOvLBEYw6cM2ZE3ZNKPKFL8pnovauxKrJogvIVOw0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBlX+BOtF5cppdqdDdoyofRg+lKtvE7HAw3X+VLevNlsm
 HZFmaOqo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRG4cY/hdccZZcEDKZzd1i
 jtnl5YdLrc+8nzpLtOkYc6tI4Qb2V7cYGS5y3dyhsV/hUGbVxIo089urX009qrkgVeD11Z3qv+q
 U/dkB
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

Introduce path backoff limit properties in mt76 binding in order to specify
beamforming and non-beamforming backoff limits for 802.11n/ac/ax.

Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
---
 .../bindings/net/wireless/mediatek,mt76.yaml       | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index f8f72f3f1b1dd185b4797be38b87c621ef3eac08..0b06455ce955c38b324efebf8c7762bee33b57f6 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -215,6 +215,66 @@ properties:
                       minItems: 13
                       maxItems: 13
 
+                  paths-cck:
+                    $ref: /schemas/types.yaml#/definitions/uint8-array
+                    minItems: 4
+                    maxItems: 4
+                    description:
+                      4 half-dBm backoff values (1 - 4 antennas, single spacial
+                      stream)
+
+                  paths-ofdm:
+                    $ref: /schemas/types.yaml#/definitions/uint8-array
+                    minItems: 4
+                    maxItems: 4
+                    description:
+                      4 half-dBm backoff values (1 - 4 antennas, single spacial
+                      stream)
+
+                  paths-ofdm-bf:
+                    $ref: /schemas/types.yaml#/definitions/uint8-array
+                    minItems: 4
+                    maxItems: 4
+                    description:
+                      4 half-dBm backoff values for beamforming
+                      (1 - 4 antennas, single spacial stream)
+
+                  paths-ru:
+                    $ref: /schemas/types.yaml#/definitions/uint8-matrix
+                    description:
+                      Sets of half-dBm backoff values for 802.11ax rates for
+                      1T1ss (aka 1 transmitting antenna with 1 spacial stream),
+                      2T1ss, 3T1ss, 4T1ss, 2T2ss, 3T2ss, 4T2ss, 3T3ss, 4T3ss
+                      and 4T4ss.
+                      Each set starts with the number of channel bandwidth or
+                      resource unit settings for which the rate set applies,
+                      followed by 10 power limit values. The order of the
+                      channel resource unit settings is RU26, RU52, RU106,
+                      RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.
+                    minItems: 1
+                    maxItems: 7
+                    items:
+                      minItems: 11
+                      maxItems: 11
+
+                  paths-ru-bf:
+                    $ref: /schemas/types.yaml#/definitions/uint8-matrix
+                    description:
+                      Sets of half-dBm backoff (beamforming) values for 802.11ax
+                      rates for 1T1ss (aka 1 transmitting antenna with 1 spacial
+                      stream), 2T1ss, 3T1ss, 4T1ss, 2T2ss, 3T2ss, 4T2ss, 3T3ss,
+                      4T3ss and 4T4ss.
+                      Each set starts with the number of channel bandwidth or
+                      resource unit settings for which the rate set applies,
+                      followed by 10 power limit values. The order of the
+                      channel resource unit settings is RU26, RU52, RU106,
+                      RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.
+                    minItems: 1
+                    maxItems: 7
+                    items:
+                      minItems: 11
+                      maxItems: 11
+
                   txs-delta:
                     $ref: /schemas/types.yaml#/definitions/uint32-array
                     description:

-- 
2.47.3


