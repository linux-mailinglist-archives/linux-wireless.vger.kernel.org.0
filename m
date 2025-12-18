Return-Path: <linux-wireless+bounces-29905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69F9CCCDF9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 17:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FD59302C5FF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59A0327BE0;
	Thu, 18 Dec 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt4gPY4Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6833984F;
	Thu, 18 Dec 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076709; cv=none; b=VgYOEHMgj1CHe+Q6uj79VVkhH1GItJ/vf+CcSY/LbPzOteJbvaYEbIyOKvXarl0mZhRq7B4iiNgcEAz+krIgO+N6OismX+wKG4xz/nzIFiOhzRHQuUlPHuovtXdQ3V7J0XnGRKTE92mNmas6zddjE7yGufNkqyXfKOjDgEkAM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076709; c=relaxed/simple;
	bh=NWdJvH9yOqg1eTTYzzMYejBHNkyExdCjfVBKS/HDM44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EQwh1jSJGxjhS9kv2RVXuEthquFt4x+Mn5qlwtTFusznetwpGekxSMbkmv+mlwqEv5dLU4Xjmn6uu/zHzvLddJgVCp97RXB+st4YDHls+fjIE8+6ZFYF1dgQztfrmTp0umBwEyrb3BzLEhc0OejsaXPG3AwnyShOibpB3ApT228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt4gPY4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E7C6C4CEFB;
	Thu, 18 Dec 2025 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766076708;
	bh=NWdJvH9yOqg1eTTYzzMYejBHNkyExdCjfVBKS/HDM44=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dt4gPY4QoL+iquIEKaMU8FXDPaXWNEPoR76qyDRHf8BHEABOmmGqtldjowawYsjxR
	 SfbmUrNxL0bSRyi70P4EZ6VZ21E8aaqF9juKg/aGPGjIv3uKE5OkphBJ+Ft/cgHlI8
	 nCX+083XK2NvLNffoypKwGZF1KMWhz4ZP/D1vyvnoopUTLd7y5p1cxigFS8xImbp5O
	 2TVzL3mGpf2FGU7b4uyMvuBffHeZSE7gfkY+/yJchtnFkTvEkmgWTh0eF0wulIRahs
	 YpVJtAsI9LsXJxdTg9nA/ewkkOn67614r/CHh5inurQ1zuS9diPae1+Sm4fCzoKoFX
	 cppHZOlVDrNsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7FDD6ACF9;
	Thu, 18 Dec 2025 16:51:48 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/2] net: qrtr: Drop the MHI 'auto_queue' feature
Date: Thu, 18 Dec 2025 22:21:43 +0530
Message-Id: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8xRGkC/22MQQ6CMBBFr0Jm7ZBOFa2uvIdh0bSDNBEqLRIN6
 d0dWbv5yXv5eStkToEzXKoVEi8hhzgK6F0FrrfjnTF4YdBKN6TphFOaE3bhjU41Rpw3nizI/Zl
 Y9Ja6tcJ9yHNMn6280M/+iSyECrsjHbTdszt7c40519PLPlwchloG2lLKFxUi2w6nAAAA
X-Change-ID: 20251217-qrtr-fix-c058251d8d1a
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>, 
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 ath12k@lists.infradead.org, netdev@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Chris Lew <quic_clew@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=NWdJvH9yOqg1eTTYzzMYejBHNkyExdCjfVBKS/HDM44=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpRDEi+Khc2ZOmm08ikV3hNuslUf4Bh48CandeI
 RWNP6g/wIqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUQxIgAKCRBVnxHm/pHO
 9cemB/4vwlTSkc1bcE9+WVu8UZBpxkiHP576YpiTakv5EZxlkFChtASnSg5UjtwhIOXzyOgFQy2
 pEEenMNY623MJgBh7dLPRFliZcUk5vqRoynw9xyZoFq0N6+a/Wl9StpbTruRRUlKCZjV45RTnF5
 DPEocovrNLBl0IOuhO2IaNLl28iwB47Rijj/8/14ZY5n7SuWdm6C+s/SX72/nLlSvghNYhlikR/
 GoWwVOwRzqgutCV9wESS0ljwkenQpfx+gNiQv4hbEG7rCIPWPNwzOROxvllQTFCimCsVVbthY/h
 etHKiqG93rCOK9WO1mHhSY/l8rE53ViVBptce8Tt1ed0goJG
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series intends to fix the race between the MHI stack and the MHI client
drivers due to the MHI 'auto_queue' feature. As it turns out often, the best
way to fix an issue in a feature is to drop the feature itself and this series
does exactly that.

There is no real benefit in having the 'auto_queue' feature in the MHI stack,
other than saving a few lines of code in the client drivers. Since the QRTR is
the only client driver which makes use of this feature, this series reworks the
QRTR driver to manage the buffer on its own.

Testing
=======

Tested on Qcom X1E based Lenovo Thinkpad T14s laptop with WLAN device.

Merge Strategy
==============

Since this series modifies many subsystem drivers, I'd like to get acks from
relevant subsystem maintainers and take the series through MHI tree.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Used mhi_get_free_desc_count() to queue the buffers
- Collected tags
- Link to v1: https://lore.kernel.org/r/20251217-qrtr-fix-v1-0-f6142a3ec9d8@oss.qualcomm.com

---
Manivannan Sadhasivam (2):
      net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels
      bus: mhi: host: Drop the auto_queue support

 drivers/accel/qaic/mhi_controller.c   | 44 -------------------
 drivers/bus/mhi/host/init.c           | 10 -----
 drivers/bus/mhi/host/internal.h       |  3 --
 drivers/bus/mhi/host/main.c           | 81 +----------------------------------
 drivers/bus/mhi/host/pci_generic.c    | 20 +--------
 drivers/net/wireless/ath/ath11k/mhi.c |  4 --
 drivers/net/wireless/ath/ath12k/mhi.c |  4 --
 include/linux/mhi.h                   | 14 ------
 net/qrtr/mhi.c                        | 69 ++++++++++++++++++++++++-----
 9 files changed, 62 insertions(+), 187 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251217-qrtr-fix-c058251d8d1a

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



