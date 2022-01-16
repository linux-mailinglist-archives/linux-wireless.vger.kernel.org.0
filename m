Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF948FCE2
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiAPMry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:47:54 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61521 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiAPMrv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642337271; x=1673873271;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AbfsfCOVDuXh5vKdXW2w9adMJ3MJqk3dtkubUcVuTTY=;
  b=ckXCskbmrv/mVI9yNMLAnEXffjRKeR9EtuKBnL2rxThRHRTAetTtWum5
   D4o1mRRttYrppQ4GAZ7LeC4XnmMdz06oESlzDYIvfrJRzN9LfLX4SQVrq
   3t1novDQYalrIxFooDK8CwgvhyZbezC491qis8DiiO4e+OsOXje5oRyTH
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 04:47:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 04:47:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:28 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:26 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 00/19] add support for WCN6750
Date:   Sun, 16 Jan 2022 18:16:56 +0530
Message-ID: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN6750 is non-DBS 2x2 11AX chipset. Unlike QCA6390/WCN6855 which
are DBS (dual band simultaneous) solutions (2 LMACs), WCN6750 has a
single LMAC supporting 2G, 5G and 6G bands. It can be operated only
on one band at any given point.

WCN6750 is a PCIe device. Unlike other supported ATH11K PCIe devices
which are directly attached to APSS (Application Processor SubSystem),
WCN6750 is not attached to APSS, it is attached to the WPSS
(Wireless Processor SubSystem) Q6 processor, the FW which runs on the
Q6 processor will enumerate the PCIe device. Since APSS is unaware of
such a device, it has to be registered as a platform device(AHB) to the
kernel for device probing. Like other AHB devices, remoteproc APIs are
used to boot up or shutdown of WCN6750.

WCN6750 uses both AHB and PCIe ATH11K APIs for it's operation.
It uses AHB APIs for device probe and booting of the remote processor.
Once device is booted up, it uses ATH11K PCIe APIs for initialization
and register access. Hence, it is referred as hybrid bus device in
the rest of this series.

Since the chip is enumerated by WPSS Q6, device information like
BAR and BAR size is not known to the APSS processor. A new QMI message
called device info QMI request will be sent to the target for fetching
these details.

STA and AP modes are supported; Basic connectivity and ping are
verified in both the modes.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Note:
*	Remoteproc driver changes for WCN6750 which takes care of
	downloading the FW and booting of Q6 processor are under
	upstream review.
	Link: https://patchwork.kernel.org/project/linux-remoteproc/list/?series=582475

Manikanta Pubbisetty (19):
  ath11k: PCI changes to support WCN6750
  ath11k: Refactor PCI code to support hybrid bus devices
  ath11k: Choose MSI config based on HW revision
  ath11k: Refactor MSI logic
  ath11k: Remove core PCI references from PCI common code
  ath11k: Add HW params for WCN6750
  ath11k: Add bus params for WCN6750
  ath11k: Add register access logic for WCN6750
  ath11k: Fetch device information via QMI for WCN6750
  ath11k: Add QMI changes for WCN6750
  ath11k: HAL changes to support WCN6750
  ath11k: Datapath changes to support WCN6750
  ath11k: Fix RX de-fragmentation issue on WCN6750
  ath11k: Do not put HW in DBS mode for WCN6750
  ath11k: WMI changes to support WCN6750
  ath11k: Update WBM idle ring HP after FW mode on
  ath11k: Add support for WCN6750 device
  ath11k: Add support for targets without trustzone
  dt: bindings: net: add bindings of WCN6750 for ath11k
---
V2:
 - Rebased on ToT
 - Addressed comments on DT binding

 .../bindings/net/wireless/qcom,ath11k.yaml         | 365 ++++++---
 drivers/net/wireless/ath/ath11k/Makefile           |   4 +-
 drivers/net/wireless/ath/ath11k/ahb.c              | 331 +++++++-
 drivers/net/wireless/ath/ath11k/ahb.h              |  10 +
 drivers/net/wireless/ath/ath11k/ce.c               |   4 +-
 drivers/net/wireless/ath/ath11k/core.c             | 114 ++-
 drivers/net/wireless/ath/ath11k/core.h             |  35 +
 drivers/net/wireless/ath/ath11k/hal.c              |  15 +-
 drivers/net/wireless/ath/ath11k/hal.h              |  17 +-
 drivers/net/wireless/ath/ath11k/hw.c               | 175 +++-
 drivers/net/wireless/ath/ath11k/hw.h               |  13 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |  16 +-
 drivers/net/wireless/ath/ath11k/pci.c              | 898 +++------------------
 drivers/net/wireless/ath/ath11k/pci.h              |  28 +-
 drivers/net/wireless/ath/ath11k/pci_cmn.c          | 726 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci_cmn.h          |  47 ++
 drivers/net/wireless/ath/ath11k/qmi.c              | 217 ++++-
 drivers/net/wireless/ath/ath11k/qmi.h              |  26 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  13 +-
 19 files changed, 2055 insertions(+), 999 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/pci_cmn.c
 create mode 100644 drivers/net/wireless/ath/ath11k/pci_cmn.h

-- 
2.7.4

