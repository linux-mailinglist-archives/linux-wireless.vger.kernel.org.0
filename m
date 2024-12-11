Return-Path: <linux-wireless+bounces-16246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894C9ECFCC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0067D188A260
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74013C8E8;
	Wed, 11 Dec 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH5Af9qx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216D13B2A9;
	Wed, 11 Dec 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931276; cv=none; b=Th3b9SfUDJKAfsy8AsbBpIEWqRKYq0U0lT5TBtlLwMaTJ1kNZr9ZorJx83Cw2hmqb9Rg09tjHItqeffbvkD5rlXlFZMY9ohQJUuh9OLpU0N81PXR2XYdsNxueh4umiD5T6Ej6o51KVU8LYGcYjtCKyCCPA/UoFF2suBXYsnNBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931276; c=relaxed/simple;
	bh=L7wzVvymBJg0eN3gAGAMtzo6S3quGzzL4FwBiMvbaVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrJOJpoklvjA+SPemOR39z/19igPjwEdGuY4c60bKkqGELT/Q7dGkIrM8f9CwRIFY16BSZP9kV6M0UTcORMdDxj2Zmdc94l8Bk6+v7hjJvJmrFpxFFQl+hV0vwhh7bLutR1detOHSJfJeSpx1FQeSuc9SaFI5l5lTg44LE0zTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH5Af9qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F9BC4CED2;
	Wed, 11 Dec 2024 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931275;
	bh=L7wzVvymBJg0eN3gAGAMtzo6S3quGzzL4FwBiMvbaVA=;
	h=From:To:Cc:Subject:Date:From;
	b=aH5Af9qxMczA7RImVZQQ3v97VuwhambD2XO/wI9quAbUk0khDM6TDhk0twy6S0B5b
	 N+usp0qBFTbnub3TCdMVCqczN/t9xkNWL64yXiau+0UdNAp2VhcbAkLE9vPkg9ceXb
	 cdTX4G5LUJSTbP3gGnYD8xdBBAoOf8CUd5ZeAXbkg21tq7JwR6XSWrx/r9tT92TxHP
	 YN80hBjOCDGOyzD7DCOGzacpXDyaQN65w67K1Z9x6oFJ4QlsSloTGLXe5xcLYFnbWI
	 unP65MqKjZ3PbKg3t02AgV613HjWgCj1+TsaJDShrfGBcTh76o/TmtMObR3I7Vgf0S
	 L0DghhQSLq35Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/8] wifi: ath12k: MLO support part 7
Date: Wed, 11 Dec 2024 17:34:24 +0200
Message-Id: <20241211153432.775335-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Implementing Multi-Link Operation (MLO) continues. Bindings document is added
to get WSI information from DT (patch 1) with the code parsing the information
(patch 2). Rest of the patches are about configuring MLO in firmware.

Device Tree bindings were reviewed as RFC earlier:

[RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k PCI module with WSI

https://lore.kernel.org/ath12k/20241105180444.770951-1-quic_rajkbhag@quicinc.com/

The only changes from the RFC are Jeff's email address, using flag instead of
bool and moving the WSI description to the beginning of the doc.

This patchset applies to ath.git main branch. Please review.

Kalle

v3:

* patch 1: move description of WSI to the beginning of the doc

v2: https://patchwork.kernel.org/project/linux-wireless/cover/20241209153034.50558-1-kvalo@kernel.org/

* patch 1: change qcom,wsi-controller from a boolean to a flag

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20241205203044.589499-1-kvalo@kernel.org/

Bhagavathi Perumal S (1):
  wifi: ath12k: Add MLO WMI setup and teardown functions

Karthikeyan Periyasamy (5):
  wifi: ath12k: send partner device details in QMI MLO capability
  wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
  wifi: ath12k: add support to allocate MLO global memory region
  wifi: ath12k: enable MLO setup and teardown from core
  wifi: ath12k: avoid redundant code in DP Rx error process

Raj Kumar Bhagat (2):
  dt-bindings: net: wireless: Describe ath12k PCI module with WSI
  wifi: ath12k: parse multiple device information from Device Tree

 .../net/wireless/qcom,ath12k-wsi.yaml         | 204 +++++++++++++
 drivers/net/wireless/ath/ath12k/core.c        | 256 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h        |  18 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  13 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 142 +++++++++
 drivers/net/wireless/ath/ath12k/mac.h         |   3 +
 drivers/net/wireless/ath/ath12k/qmi.c         | 283 ++++++++++++++----
 drivers/net/wireless/ath/ath12k/qmi.h         |   1 +
 drivers/net/wireless/ath/ath12k/wmi.c         | 180 +++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h         |  49 +++
 10 files changed, 1072 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml


base-commit: 400568fb3b022247c1603fdbdd6444b3ef14ffce
-- 
2.39.5


