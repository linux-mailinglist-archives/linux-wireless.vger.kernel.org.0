Return-Path: <linux-wireless+bounces-24553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B80AEA00C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE4B7AADC1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD762E9751;
	Thu, 26 Jun 2025 14:12:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F82E92B8;
	Thu, 26 Jun 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947170; cv=none; b=AinhR44aE65VEjGn3+Ya52VhY/FDlSdKyLYaqyIUeTN08FjHdUVOfawX73TZRQn9s0LxZXuLBhW9LCkDnwZpwYoahH92owDMAxUa+n84uEUGvOakxm4wFNXjtE0+bLzciQIVJzLiH8MlDnHPj6/J+EkmraKE1fqA3TKsRWYHgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947170; c=relaxed/simple;
	bh=9RQMvFm40nwEAoBt2OyFHhYT6FVjtvjm06gXMraCEuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEfJpaos2mv2dnUQNLwRj4ZVckG0EFr0gYxIZtnotsjcyfhE+Ra6YG4SctbwXEwGCjRvlDx2F7ohg7PGkHSHdVHiUaIhDSFEn9qh2A8fk/Tr3v6tiGn8Fwerd7byBMZI/Tv0tr5yIWcQmlyuLzlMAkZKLd3z3+VKA+rt9AOgO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 16:12:43 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Thu, 26 Jun 2025 16:12:43 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1uUnLH-00FquB-0Q;
	Thu, 26 Jun 2025 16:12:43 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mgreer@animalcreek.com>, <krzk@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>
Subject: [PATCH v3 1/2] dt-bindings: net/nfc: ti,trf7970a: Add ti,rx-gain-reduction-db option
Date: Thu, 26 Jun 2025 16:12:41 +0200
Message-ID: <20250626141242.3749958-2-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
References: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add option to reduce the RX antenna gain to be able to reduce the
sensitivity.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index d0332eb76ad2..5f49bd9ac5e6 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -55,6 +55,12 @@ properties:
     description: |
       Regulator for supply voltage to VIN pin
 
+  ti,rx-gain-reduction-db:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify an RX gain reduction to reduce antenna sensitivity with 5dB per
+      increment, with a maximum of 15dB. Supported values: [0, 5, 10, 15].
+
 required:
   - compatible
   - interrupts
@@ -95,5 +101,6 @@ examples:
             irq-status-read-quirk;
             en2-rf-quirk;
             clock-frequency = <27120000>;
+            ti,rx-gain-reduction-db = <15>;
         };
     };
-- 
2.39.2


