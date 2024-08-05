Return-Path: <linux-wireless+bounces-10905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B022A94740F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FD4B2107B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 04:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DCA13D52F;
	Mon,  5 Aug 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="nzXRbmHB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801F812;
	Mon,  5 Aug 2024 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830507; cv=none; b=IDC5FK/bzw/zvfpUeLt4w45BgQuMoGhgb8KEOCDkPxhvhMf68Vq8bwk4gDMkMFysUSmP55RogDvS0TtuWPiJAxvPOCOySF+J7SmULBiTjv2p4pgfRg+9lCBdhn9WAPY2CDbergrSkULJ2ZUArv4ckJ3R8N2em+5svrA/Ghm62S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830507; c=relaxed/simple;
	bh=NwbbvYiTkO8UJhdcu9vdhxysntPQqnTHajX7xaC4W2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CM/L9j+LwUPX2ZPZKFppI7ilvXv0TDKN/cyUhPSD0KvGZ6SP3SdGvKJqhzkmpS7khCdfKt8mjBgjDLgnivMM53ZF9t/h6PyZYdiwqog0T6l+dJ//1cMy5ALGwmiG2b6qprLYmV9zH1d+4wSDcOemvGzTF38sWhl++bikH/TbhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=nzXRbmHB; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B36C7C006A;
	Mon,  5 Aug 2024 00:02:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1722830524; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=l3cuotyN38rBLBVNrb5zCID87Jk8YGr65Mi1E0X895E=;
	b=nzXRbmHBiUmB1HYgHeiK9EeiD/k6qC32hdmBpDSg5bIbMGs0uV9kTzAUP0hEU9v3TewzJ3
	lDGajk0Nfg8jTsTZFoEdQKYJrDbaQoUSEJ9lsGcs0+M6jVqnW1lcjJFJOHyuHByqUtlrQP
	u+xbioa63ZyS7MTGK0LHy4hnUOWYmow=
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
Subject: [PATCH 1/4] mmc: sdio: add Qualcomm QCA9379-3 SDIO id
Date: Mon,  5 Aug 2024 00:01:28 -0400
Message-ID: <20240805040131.450412-2-felix@kaechele.ca>
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

Adds the id for Qualcomm QCA9379-3 SDIO based cards such as
the LITEON WCBN3510A and Silex SX-SDMAC2.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 include/linux/mmc/sdio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f57..63000a8f4b13 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -52,6 +52,7 @@
 #define SDIO_DEVICE_ID_ATHEROS_AR6004_19	0x0419
 #define SDIO_DEVICE_ID_ATHEROS_AR6005		0x050A
 #define SDIO_DEVICE_ID_ATHEROS_QCA9377		0x0701
+#define SDIO_DEVICE_ID_ATHEROS_QCA9379		0x0801
 
 #define SDIO_VENDOR_ID_BROADCOM			0x02d0
 #define SDIO_DEVICE_ID_BROADCOM_NINTENDO_WII	0x044b
-- 
2.45.2


