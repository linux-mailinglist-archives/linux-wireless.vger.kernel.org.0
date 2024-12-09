Return-Path: <linux-wireless+bounces-16061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D59E9A88
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8D8161EE3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115DB1E9B0E;
	Mon,  9 Dec 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px+03AIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D61BEF7D;
	Mon,  9 Dec 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758238; cv=none; b=gQ1mVA8yeDxGFfhJNWr92oWkOtElQn8LSSGPQ3Rppl1AQ5AVnE06+zbOyqfeV9btdvWdlGmw6cGnUlpcxWG2vwyJFl9G3GXSfA5eZ6H3wNSY7tn8WbWu9XOO+TOXn3b+owzh8VtxZzoTH/JUmUqx10S/aprAX/z+1OjummDnfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758238; c=relaxed/simple;
	bh=I/SQkPW7UvDlEYoReU9WDUhS/0OXih8QMkx7sMylOaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iELlsoe/1YXjEqgH7m1sX+YCTdOTTyZzLfWLId8hEyvg9MtwDs7eR6hst+EQb4cnR1zRZ4lfi7Ug6byYTv89yS1rML0fJIGen3CofGQEwomSdl2ybPP7CX2rW7NG9mpVs5MxlBq49MP/LlWTfpqLAFdCG6eyfUaEX2hrUA1Uaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px+03AIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96292C4CEDE;
	Mon,  9 Dec 2024 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758237;
	bh=I/SQkPW7UvDlEYoReU9WDUhS/0OXih8QMkx7sMylOaU=;
	h=From:To:Cc:Subject:Date:From;
	b=px+03AIpFDcyKsX6s5ZF6dwBk1rQeNTrTEdJomQFvAUnEFmz8C2+aigN65c8xFTc9
	 UXwSGqg0n/y4AK5j7Wn2iVHoGtrhuL3CEeaHlRATZzjgreEXHbZRub8E4WigWHX+jK
	 fIb8dPVjQrgjTH/qYXHI8mHY2cQAbDT6WNqRv621wo1mRzOSl37RdH07VcBCBZ9d33
	 iUlqqAIM7vELuoca2Je/HceeQqXKOwaQryKVt933O2G/6lUEy8cqxVKsJDF1HY8GuR
	 IktEAD0MSxuVZpSyhyfYQoGaLXWNKYQHMlGHxWK6iAV759Kzz0o5SEzaCCTFDDPU7b
	 csKlu5zTampbQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/8] wifi: ath12k: MLO support part 7
Date: Mon,  9 Dec 2024 17:30:26 +0200
Message-Id: <20241209153034.50558-1-kvalo@kernel.org>
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

The only changes from the RFC are Jeff's email address and using flag instead of bool.

This patchset applies to ath.git main branch. Please review.

Kalle

v2:

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

 .../net/wireless/qcom,ath12k-wsi.yaml         | 205 +++++++++++++
 drivers/net/wireless/ath/ath12k/core.c        | 256 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h        |  18 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  13 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 142 +++++++++
 drivers/net/wireless/ath/ath12k/mac.h         |   3 +
 drivers/net/wireless/ath/ath12k/qmi.c         | 283 ++++++++++++++----
 drivers/net/wireless/ath/ath12k/qmi.h         |   1 +
 drivers/net/wireless/ath/ath12k/wmi.c         | 180 +++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h         |  49 +++
 10 files changed, 1073 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml


base-commit: 400568fb3b022247c1603fdbdd6444b3ef14ffce
-- 
2.39.5


