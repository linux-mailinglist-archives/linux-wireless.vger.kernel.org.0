Return-Path: <linux-wireless+bounces-26265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80075B20BC4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5D43A8852
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A823717C;
	Mon, 11 Aug 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/ra64HY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E3233D64
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922165; cv=none; b=D3dGvoq+pxSlzBKD3ZRXVmUiiDGXbzhblnXZS2S18dx6VoSLCkTwWq1W3JNS9JtkXkmi1DbF4lXjOncX2CUGr+tpw38RoU/X4Lde/k8bVS9Y4PlghANV+4MX9gUHXi5AIPYzVgYJU605y4cKWkY1l93Wequ8iC+PZNW0WAQb/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922165; c=relaxed/simple;
	bh=SqkZNS/ry9IiOFLpkF0FTQ3M6L9ZG+FwE5w/Gqse7+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQRViXcLLqXWaK70M+Y+BNUn5zfMCoZAaOAMUcvKOcvX5Mlllb1hmZPMcX3TNjlRIS+5GxNKBAXFz82NXNPZsz9O3pSTXVXmNL3wcxp70fB9rvEpWziKu+CiE1cGgZXGfmXtdadA02fgUbx1TQWUQQebhmJl9S/lBinSB5U279s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/ra64HY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af92d6c7d15so67378866b.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754922162; x=1755526962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpi7BNJrX5eGL/LP8Vw57x6AIlZH4fDFCd+pMNqQ6kQ=;
        b=V/ra64HYdBGzuHM5uKw5Y1hawcEGs+Ja61RkLJld6vlk1PqcbheowTvUw6Z9/QsGrC
         C8Rqjb76QbRzJPQ+ZatZ2kb2IRVwgbNcWKHIrzXpV/Jc1zYXxiyLTeaAYKF1Vod74vkl
         GNWqXAhpNja/OuLmsa0GbnwwKt0NR2zFMCpzQSXUSwTL56pIQn7Dn1i7mywBA7DAXCEI
         LbQATczS4RNEjPakAZ2ZyRWtOVWl/7/s9Pd7ouu5NZ7I63cPhFo1CUve1zNHwbApSjz6
         ixGSIGRQv9zbxYO08lZlYLcbBkxgvxsrZH7wfEyzw6S9PsC2VvsQuKDEIRlB05gPLO0t
         68aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922162; x=1755526962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xpi7BNJrX5eGL/LP8Vw57x6AIlZH4fDFCd+pMNqQ6kQ=;
        b=aMJBAp4VQ4DeKag4rHIJXBPNitZwM1w3Yw0eDMLTR7qX3r2UzfHIDnywvvwCq6GOhB
         gCxrV1bazqAbmJUq28bGzUecFDO0tR+L5Rb3bi5+e3YGaO4X0ifbgmRam+0fQGKJQw9d
         9z4kKqo+tVk32cJ48dPkjcLDkjUUk1xWliI7LNen2N+ZwOI2Hy7wk5wNpKEhiT1oaUn0
         3fJXtHn15Lede0EvoifIMIqY0hPWEpYJD1NwSWHODQO23GLzWLBdpr5pKDp9UwD8aV82
         H8KSoWqC7fCQhu8YA6EWUmWH7H27tqpkq29xHXrhSLF9Jl3VuBdUgbH1y6tFGrRYN65X
         4NSg==
X-Forwarded-Encrypted: i=1; AJvYcCVuNAmI4LbD/VoTAAMHgE6vf+a9M+T9PjAYsW7a12rBlzSwlSeCmNcQjifVLWnZA18ohsKvG9iyajIqfIoRow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmfHC0PjN9vZS8zfen6b3dTq5+TYea/QP0058STXv9Iafvq0T
	c/rlKqAFuTZ2yTkx5X76EUxDYJiMsmycVJOSx9ztDySWL5hoVk2MHmJzKpL90uVfmP0=
X-Gm-Gg: ASbGncuCHBULad21utbtuWeNVVLFdpHZXsuFJzdv8my30DTceY08hT6RsOKPDtDz2sZ
	loTcespl4BG9UIdP4sGBj80oGDQQ1tr3SZvriTZffcmRbM7yiafna3xROjHZcvMYB6AgJWXPa7X
	JGmqFuk7aAATYFqYkpGxpAktS+/Xw3kPYFZ5icimS+tEkNsw1pyHo/F83SJYTPHcXnE223Af5dB
	i5AKEIfY4aueURy6GnWUfXaICLUDWeQZR9yO9Kpo5I8FsCPO2WRDpf0M0PjcznUsoy5f9p3AagG
	Pcr0HjVZCZsa1WjkAe2Y6mprbhBsiMOOCLkDtHYAFiDatJWrc87S5IFuKJyhuDXMGXRFj0pJfyH
	N0gbRIlCCEp+HRP6UXBOHgcTuwED9oCJJMQ==
X-Google-Smtp-Source: AGHT+IFR6gvCZMtGPXw/3s71dGGSGEyD8ct8+jDr+WVdUbYMQgrs6yK9zDhK/26/dPwO3Vy2/0MfaQ==
X-Received: by 2002:a17:907:c21:b0:af9:3d0a:f383 with SMTP id a640c23a62f3a-af9de9af9ccmr392714266b.6.1754922161904;
        Mon, 11 Aug 2025 07:22:41 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af9247845edsm1964216866b.46.2025.08.11.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:22:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Greer <mgreer@animalcreek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: nfc: ti,trf7970a: Drop 'db' suffix duplicating dtschema
Date: Mon, 11 Aug 2025 16:22:36 +0200
Message-ID: <20250811142235.170407-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=SqkZNS/ry9IiOFLpkF0FTQ3M6L9ZG+FwE5w/Gqse7+o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomfyrs3IvzolTjRXDoIBkLiYne/iELcXk9XA+Q
 XV6xBIVBiuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJn8qwAKCRDBN2bmhouD
 15/vD/9IjosQpIL8C9tvvtWJKszpR0UYClvFTFGiV330axZedFPmxIue81IxR2TIngDKnPViOxa
 jJ3WhZXH4F/QPyyHWIor94UiqkJSYIwCTXkTkArT2eKKtwD+O12E0+zzbbeadGstpv3/l1T3XkX
 A8c50TfEByOjntXwA78vAljKJhpmg11e5iNarwYs6HMrHqUO+KiWwCN/XbRKB/Cw6Qx9Txd27em
 iw26frpEVy2aFhq+Kw6VjTu4XKOau4Rrm4XJXBHxoUGlbkYxsMM3P7GHaicM10R41kqErhUuyAP
 4ZGepr4KfYXJwCbNBXXjbcxNm4hlzoyK3hfpknyaAl+oi3kJL8ty/QMxUa4oWelsJyArrx1wyXI
 T8VjPOsvVAzsX51MUySZLsufHzJqL+ZJrv2Y/SZflm32IJQLDlB1Cwz5mL2oR+YLZa10sG5oQTD
 bRGtFuzNU0iOvSelYGhUyE+z0lflpyyskOh+4oDWGVl4LumAtoDoT+dwxh4G5fVBAXByBX8Rp/g
 26jbp0zw5oTHqZsbuYA1c7s5qnyyWh53Cig9fC+XtV4GRzFLh4mVZf1DhEAKKsDnoO88GjcezT4
 ajb7kSCxPRpXd8GPhJ5xhkXrod+5ANKCEebkPl5gLUTrPrAtbz64b74blhs4VCVjWdUlCSPSR0n 803Gl7sYQobZmGw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

A common property unit suffix '-db' was added to dtschema, thus
in-kernel bindings should not reference the type.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index 5f49bd9ac5e6..783a85b84893 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -56,7 +56,6 @@ properties:
       Regulator for supply voltage to VIN pin
 
   ti,rx-gain-reduction-db:
-    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Specify an RX gain reduction to reduce antenna sensitivity with 5dB per
       increment, with a maximum of 15dB. Supported values: [0, 5, 10, 15].
-- 
2.48.1


