Return-Path: <linux-wireless+bounces-12629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59199704AF
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 03:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238FD1F21F8A
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 01:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4A9474;
	Sun,  8 Sep 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="HXorXizU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1602BA3D;
	Sun,  8 Sep 2024 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725759487; cv=none; b=VFpOPHz7hQH3xuHdRGDyw0VZl3hg5Y+b9tLSps4qWTnC1Ma+hzLLvA0BZvobYWG6rf+pAoo8mWp6r9yaWU2DxNbgjp7w8eI1qEp49lWrntHjcpXdPQkJwZZRcs/RIvu6TX3RrEnxm1kv/ezWZSQfuzrIXJxrtNylNRU/xWO4jLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725759487; c=relaxed/simple;
	bh=V3zHCBNELPVBed+DVwCUNhUj9yDbdLN/H1eYKxmSlI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6n3xJTVQyNN2QmCZlcihCFcCo209ns7hNE3fXGK9uAzh7MYH51cmMgjzFvxh9M3NZ5w5fr73PWXnzrPlxDw0Ib9yyxr+aWMWpXR5qb2d8BWvk3K52NhZwL5PL11y62Tiu2ELrFw5If9SRRVL3zf+Yk2cs3nIujAaxqxS5/MtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=HXorXizU; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCFCAC006A;
	Sat,  7 Sep 2024 21:34:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1725759257; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kdQb/9hCxaHr8mRRViUSPfdsAO3V7TaCw9s5qABgzn4=;
	b=HXorXizUKOcIEr/PPQC66giENmlP8DC7/xzzKBuctk1LfFAxxCA1y/D40CgR0IooDMkM9E
	CvLAa64zlxIB43VDvqvDT7wnZR6BfGdN+4sU4vtR3HydJVC2nNZJguJOr+M2cVSL0qT4O8
	bXIYaBWcy7TLBsm3/54VmTsOz+OJlJo=
From: Felix Kaechele <felix@kaechele.ca>
To: ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/2] mmc: sdio: add Qualcomm QCA9379-3 SDIO id
Date: Sat,  7 Sep 2024 21:32:43 -0400
Message-ID: <20240908013244.496382-2-felix@kaechele.ca>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908013244.496382-1-felix@kaechele.ca>
References: <20240908013244.496382-1-felix@kaechele.ca>
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
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
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
2.46.0


