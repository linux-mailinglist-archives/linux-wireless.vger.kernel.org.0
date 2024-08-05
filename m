Return-Path: <linux-wireless+bounces-10909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA36947426
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B3CB213CB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 04:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342E149C50;
	Mon,  5 Aug 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="H44bPviR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C581140397;
	Mon,  5 Aug 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830509; cv=none; b=njyBWBGvLho9yjkriipjtCUDEY3Gnasp9BD6MC1uqUXsjfeyzZpV5T/bmTxOeSXJeMh44WRJln3NuhAVhBZTfdWPDRuNwKtHsUQX/fUODTRQjWIyqj1G1mLRghXvcrTBAJWc5W5+fnCT7y0cTiHD8Dljj63IxGBX8ga43vSaR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830509; c=relaxed/simple;
	bh=18HtVMEp/nF3kNlJjM+WZDtQoUGZb+1VQXJHdkEbHWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKb9QjdxFkFLrPdFtAVkYxBoJ74Hm79763oKjJSChBceRKuSy4cCl0k40IOwCyEUPC8FzeZpV7ZcEDXLFiezlEAtJFgLYNtlaKNogscWO49bJs8m2PJ2IkDMxVaiVCbwFY2uKpUKhtnUgulsWJ4wIqYsDszw6gF4Xc7YQuNv5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=H44bPviR; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14BABC0070;
	Mon,  5 Aug 2024 00:02:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1722830527; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dVzuzpmdVrqMI5w9EIT5MwcsYd0C1S7U4DW6/blDxME=;
	b=H44bPviR4QaV9HO5Fx49j54ui8s5ZJTEPgjklEJq6QlSBpYbbJN3YPEKCMEG4XkKp24z+n
	aBAg68yuZsTpYugqOyTa+8cxyHpGpqCqENkgbwBhL9md7t4kqLx/R7GO2VufY+19nN5Bjj
	3dWx9SXBdmWUBYFs2NtpXpixzF1m7vs=
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
Subject: [PATCH 4/4] Bluetooth: hci_qca: add compatible for QCA9379
Date: Mon,  5 Aug 2024 00:01:31 -0400
Message-ID: <20240805040131.450412-5-felix@kaechele.ca>
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

The QCA9379 (Naples) is a WiFi and Bluetooth SoC in the QCA6174 (Rome)
family. As such it is supported by this driver.

According to the naming format defined in the code, the driver will
request the following firmware files for a QCA9379-3:
- nvm_00150100.bin
- rampatch_00150100.bin

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ca6466676902..06895bafd3b6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2690,6 +2690,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
 	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
 	{ .compatible = "qcom,qca9377-bt" },
+	{ .compatible = "qcom,qca9379-bt" },
 	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
-- 
2.45.2


