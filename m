Return-Path: <linux-wireless+bounces-10908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C325094741A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004D31C21002
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4C5143899;
	Mon,  5 Aug 2024 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="XvgT7+Hh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60D1D540;
	Mon,  5 Aug 2024 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830508; cv=none; b=aYLde0xHTZmA6GMc3szFQGekL+Ji+WX/K3ZWU79zBwT8hbimdERlIG1uXDEbLGMjoh6FKX3z4xvlg/vLBaVlARryABSRb8D6t0NbtdKT1OX319NzECdd1qv+jajH3FP/Jk5YJt4alKHt64D9CM0gXId+tlSBHsuSj+aPHtSICks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830508; c=relaxed/simple;
	bh=wtAfLNo61IDj3fKY4HBATEJsbrhOhj3m33vUN9Wq2S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MycK34z5bbaCtUN4FVGaDVVWWbGQh6ly3MVqO/NbhaGfHrl7twtNekLReT/UH8cQ/fDaT6mXvFDWSLrSSINUTxELsK2AcRuPfqRYSM79h05VOwA45qzaH1bpyS1kWRsB2R6KgMV5JypoWcznAI4opPbgksbAzozqZpreeiDZlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=XvgT7+Hh; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1564BC006F;
	Mon,  5 Aug 2024 00:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1722830526; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZlzXcLpdIWh+ceUwvMyfQ1ubB1VnnClTDDzKPz0HlIE=;
	b=XvgT7+Hh79of3fxUqEs062oNTR0sChabKFL9U7f0h+3+yK7u+bFi566bnXmWZrkcB0KJvH
	KFpIpkeIXAbQxD94lYD5Pqil44cK3mqpjsDprTnPlUFMA03R8VcrYPQKcH4AciyVIU/toG
	D7BmNq1OSkiMvP764eUVX3JAa3+G+4w=
From: Felix Kaechele <felix@kaechele.ca>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: net: bluetooth: qualcomm: add QCA9379 compatible
Date: Mon,  5 Aug 2024 00:01:30 -0400
Message-ID: <20240805040131.450412-4-felix@kaechele.ca>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805040131.450412-1-felix@kaechele.ca>
References: <20240805040131.450412-1-felix@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Document that the QCA9379, as a member of the QCA6174 family, is
supported by the existing driver.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 68c5ed111417..f968b0d236e0 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,qca2066-bt
       - qcom,qca6174-bt
       - qcom,qca9377-bt
+      - qcom,qca9379-bt
       - qcom,wcn3988-bt
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
@@ -125,6 +126,7 @@ allOf:
             enum:
               - qcom,qca2066-bt
               - qcom,qca6174-bt
+              - qcom,qca9379-bt
     then:
       required:
         - enable-gpios
-- 
2.45.2


