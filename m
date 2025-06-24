Return-Path: <linux-wireless+bounces-24425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0FAE6560
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 14:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DEC4A5C47
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF729827D;
	Tue, 24 Jun 2025 12:48:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BF2951B3;
	Tue, 24 Jun 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769294; cv=none; b=GO+1qn5gpgXEcIjteNQtdWFXIzu9hD4sV5kkIlfQpnSe0/nqlyfmrGBGlOKWWmJgGSvo29LcxQi4FtpLc03to5Lnw6C5g3banqZwaPv26ZlxR5p71vHO3feWu2xEBmPmohAyjrGFSJkgxIf0K1EJtqmu6FqrIIS1FHlrjEC1YaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769294; c=relaxed/simple;
	bh=GDg7794sHBbkt+MM1DfT6KRSx7x6z575w6eN9ITIxXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fgo28bYBqCDH9VGNtAcWSJ1w2cTNEB2nvd6ngq8wM2F1WVQv6BP0UguPCYiDMlzP8DA+0jzHGhnn0zyDTm1KM6JgcK/niw/VykconLRZRvwLh3PVrYwP4YvMNupHbORwfiW8byJTaXFLLJvY2mKCvH+g5ogL163kClhmLDpW8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 14:43:03 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Tue, 24 Jun 2025 14:43:03 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1uU2zO-00BgGz-35;
	Tue, 24 Jun 2025 14:43:02 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mgreer@animalcreek.com>, <krzk@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>
Subject: [PATCH v2 1/2] dt-bindings: net/nfc: ti,trf7970a: Add ti,rx-gain-reduction option
Date: Tue, 24 Jun 2025 14:42:46 +0200
Message-ID: <20250624124247.2763864-2-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250624124247.2763864-1-paul.geurts@prodrive-technologies.com>
References: <20250624124247.2763864-1-paul.geurts@prodrive-technologies.com>
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
index d0332eb76ad2..066a7abc41e0 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -55,6 +55,12 @@ properties:
     description: |
       Regulator for supply voltage to VIN pin
 
+  ti,rx-gain-reduction:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify a RX gain reduction to reduce antenna sensitivity with 5dB per
+      increment, with a maximum of 15dB.
+
 required:
   - compatible
   - interrupts
@@ -95,5 +101,6 @@ examples:
             irq-status-read-quirk;
             en2-rf-quirk;
             clock-frequency = <27120000>;
+            ti,rx-gain-reduction = <3>;
         };
     };
-- 
2.39.2


