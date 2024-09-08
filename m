Return-Path: <linux-wireless+bounces-12630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 725B99704B0
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 03:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188001F2206D
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C22D2FA;
	Sun,  8 Sep 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="GJ+eiKKW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1640C149;
	Sun,  8 Sep 2024 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725759487; cv=none; b=iTTo7mS4PgoDPVmKjzeCF2QvIjmyy1WzmN5Oj2nHbv2/E+g5ezSK2qEKNVGLBdRn3Ww0Bg9UvR3ZsGI6TAb/jAZlZjZ+xvD/xojS78jg4TQX6ykrse9mQscoDNqOJj6l9IQWZ7MBJ8b0yO73BPTNIJN2DsPJwyPw3eLqA1761Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725759487; c=relaxed/simple;
	bh=G46Ex+F/8ZHg97nRtR+EGgOTFqxOOlyYNVajFUsPjEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCo1ZnNik3WnIW/P/PfZ2oP6sOs3xnClMOI2JhBnqaLVpOGun8HzAgTJb4cZTW5UoKt8i7qTrzX5GssRh/ICGuuoLpdJBJXoayeV7UnA5HS01bRMv9o3CI2ZEncgY6V2wPbuTNHMuiVZ7mwJZAKSBYU5dCW1RQNMzj6ohCTFiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=GJ+eiKKW; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 808D1C005F;
	Sat,  7 Sep 2024 21:34:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1725759257; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=XwgZYkd4DV1KyYKyYVmxxWQxVs2YbXyF6CWMKyfm8ec=;
	b=GJ+eiKKWcNzPHw3LZQAu5w/JQibXBCNKkFtvM8B8ec6CLGYNQUqjVbjNAAS1HaxGckcxy4
	FWGg78+hvYMQRUBi8R95QP2dyqpNU+vjp20GXrx1mPOJsv8O4BDlwBYieWR5XLDNvV7WyO
	JbyTriVUgLqFVSP4mC8PieKGMp+LrhY=
From: Felix Kaechele <felix@kaechele.ca>
To: ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for QCA9379 hw1.0 SDIO WiFi
Date: Sat,  7 Sep 2024 21:32:42 -0400
Message-ID: <20240908013244.496382-1-felix@kaechele.ca>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This is a v2 of the following patchset: https://lore.kernel.org/ath10k/20240805040131.450412-1-felix@kaechele.ca/T/

Changes in v2:
- drop Bluetooth part of the patch which mainly consisted with introducing
  a new compatible string into the driver
- added Acked-By given by Ulf Hansson on the SDIO id addition

Thanks,
Felix

Felix Kaechele (2):
  mmc: sdio: add Qualcomm QCA9379-3 SDIO id
  wifi: ath10k: add support for QCA9379 hw1.0 SDIO

 drivers/net/wireless/ath/ath10k/core.c      | 37 +++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h        | 10 ++++++
 drivers/net/wireless/ath/ath10k/pci.c       |  2 ++
 drivers/net/wireless/ath/ath10k/sdio.c      |  5 ++-
 drivers/net/wireless/ath/ath10k/targaddrs.h |  3 ++
 include/linux/mmc/sdio_ids.h                |  1 +
 6 files changed, 57 insertions(+), 1 deletion(-)


base-commit: 903aaf66edc97dd5b9e3118d19677291051a9c40
-- 
2.46.0


