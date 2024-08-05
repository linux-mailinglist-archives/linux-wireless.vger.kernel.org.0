Return-Path: <linux-wireless+bounces-10907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C7947417
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A721281594
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D1B14290C;
	Mon,  5 Aug 2024 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="OF1LGJsi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5157639;
	Mon,  5 Aug 2024 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830508; cv=none; b=ep+nZc6WERgg7IMr9VVdZL5r7kX8Jhh7EJaUz/H/Q/h85w0ufjcB38usCd+xR24bbvM4Lvugs2A/wnqo+o/08upXQ8idRgIfuS9cXcI5ubfx28iO8BuRzlscHt8uRUIiX5utRqYsl0mJk1seDTG1hwV4rBMSO8hQ5IK//GEJHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830508; c=relaxed/simple;
	bh=07+1FVUgYC9ex4rTFJDQlLyNZWVcelgysbLKsmkJBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rzxpd93TIDsv4bAdO1PSS0Z0J6sVFOZOFjH0oTWvv6hth1m6weVsXFT3FWhMzneBwwk1XheEJtKAB4rBFPuLQEHS4gmO69MQBhdKIWIoV62fOUNzAEwlGA350VqYKzC7k0d/ko6LsN2w0lJNuz6XjY3iMH651ecNDsKgwsk4YSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=OF1LGJsi; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5067C005F;
	Mon,  5 Aug 2024 00:01:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1722830523; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=GsQnhxsqicayvGUucI+ZWGDAQY9dTcFVmUnm38tQ6lo=;
	b=OF1LGJsioPiIYWkr11cBsPOSimABMCK3Nb9UjZA9q7p+f4fuNp1OSYFbfH+eCe1GuquS5l
	QphP3P0i1ItRDdVDOSbD7Ura+z9RehCwow5JcrQIQ6vssHQu2TG0gwSMwIW+8glWEj4uZP
	kPTuSBdtFG6YP4zWIO8zmeRPMemZzBU=
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
Subject: [PATCH 0/4] Add support for QCA9379 hw1.0 SDIO WiFi/BT
Date: Mon,  5 Aug 2024 00:01:27 -0400
Message-ID: <20240805040131.450412-1-felix@kaechele.ca>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for Qualcomm QCA9379-3 SDIO based adapters.

The Bluetooth part is straightforward. It simply adds a DT compatible
string to the existing driver.

The WiFi part is a followup to the RFC I sent back in February [0], that
didn't receive any comments.

Since then I aligned the patch closer to what the driver does for the
QCA6174 rather than the QCA9377, as the latter hasn't been touched in a
while.
With that the driver no longer throws errors for non-existent calibration
data.

The roaming and group re-keying issues still persist, but may not be
specific to this chipset, as this (or a similar issue) is apparently seen
on other chipsets as well [1].
The user impact of this issue is an intermittent loss of connectivity
while the adapter re-associates. Other than that the connection is
stable.

I have tested this patch on a Lenovo ThinkSmart View (CD-18781Y) that
comes with a LITEON WCBN3510A module. The firmware and boardfile used for
testing was pulled from the original Android image. A file at
/modem/verinfo/ver_info.txt on the Android image identifies the WiFi
part as "WLAN.NPL.1.6-00163-QCANPLSWPZ-1" and the Bluetooth part as
"BTFM.NPL.1.0.4-00002-QCABTFMSWPZ-1".

No firmware files are currently available from public repositories, but
they should available from the vendor website [2] for customers that have
the according access.

I can submit the boardfile to the ath10k list once this patch is
accepted. The one that is included with the Android system image has a
sha256sum of 65767cca6a1ff88a9899235acdeeed1e9447a2f16f41d38052202835d5bda7d4.

If someone from Qualcomm could add both the WiFi and BT firmwares to the
linux-firmware repositories that would be much appreciated.
I'm happy to test any firmware before submission, if desired.

Thanks,
Felix

[0]: https://lore.kernel.org/ath10k/20240229032700.414415-1-felix@kaechele.ca/T/
[1]: https://lore.kernel.org/ath10k/c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com/T/
[2]: https://www.qualcomm.com/products/technology/wi-fi/qca9379#Software

Felix Kaechele (4):
  mmc: sdio: add Qualcomm QCA9379-3 SDIO id
  wifi: ath10k: add support for QCA9379 hw1.0 SDIO
  dt-bindings: net: bluetooth: qualcomm: add QCA9379 compatible
  Bluetooth: hci_qca: add compatible for QCA9379

 .../net/bluetooth/qualcomm-bluetooth.yaml     |  2 +
 drivers/bluetooth/hci_qca.c                   |  1 +
 drivers/net/wireless/ath/ath10k/core.c        | 37 +++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h          | 10 +++++
 drivers/net/wireless/ath/ath10k/pci.c         |  2 +
 drivers/net/wireless/ath/ath10k/sdio.c        |  5 ++-
 drivers/net/wireless/ath/ath10k/targaddrs.h   |  3 ++
 include/linux/mmc/sdio_ids.h                  |  1 +
 8 files changed, 60 insertions(+), 1 deletion(-)


base-commit: aefacd7c75edfaf6690819c1990b851f4c7b50cf
-- 
2.45.2


