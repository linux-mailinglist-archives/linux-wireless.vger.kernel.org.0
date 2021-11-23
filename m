Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7216645ABAA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhKWSy0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:54:26 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:56980 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhKWSyZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693477; x=1669229477;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Aoj5xZMGGsq/OcrM79S2Dp1BTjBbNtteoCDCqtbWL1k=;
  b=QqaddglfPNHP2JYfCvCyYZaYqv9uRTS641Zm826TifuR7IhIrPtQlwEY
   2+wZY3ox+zKF4Jo5i84dlk7I5qfed1RuXXYcooKahU6yq6TnPbhqKHqXJ
   t/u3gq+7nFJVLBzR52Jf9mQYxrFqOxq8ksur3yk3pP+3MIWavaFuOIemm
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 Nov 2021 10:51:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:51:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:16 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:14 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 00/19] add support for WCN6750
Date:   Wed, 24 Nov 2021 00:20:15 +0530
Message-ID: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

 .../bindings/net/wireless/qcom,ath11k.yaml         | 333 +++++---
 drivers/net/wireless/ath/ath11k/Makefile           |   4 +-
 drivers/net/wireless/ath/ath11k/ahb.c              | 331 +++++++-
 drivers/net/wireless/ath/ath11k/ahb.h              |  10 +
 drivers/net/wireless/ath/ath11k/ce.c               |   4 +-
 drivers/net/wireless/ath/ath11k/core.c             | 104 ++-
 drivers/net/wireless/ath/ath11k/core.h             |  35 +
 drivers/net/wireless/ath/ath11k/hal.c              |  15 +-
 drivers/net/wireless/ath/ath11k/hal.h              |  17 +-
 drivers/net/wireless/ath/ath11k/hw.c               | 175 +++-
 drivers/net/wireless/ath/ath11k/hw.h               |  13 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |  16 +-
 drivers/net/wireless/ath/ath11k/pci.c              | 893 +++------------------
 drivers/net/wireless/ath/ath11k/pci.h              |  28 +-
 drivers/net/wireless/ath/ath11k/pci_cmn.c          | 720 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci_cmn.h          |  47 ++
 drivers/net/wireless/ath/ath11k/qmi.c              | 215 ++++-
 drivers/net/wireless/ath/ath11k/qmi.h              |  26 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  13 +-
 19 files changed, 2007 insertions(+), 992 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/pci_cmn.c
 create mode 100644 drivers/net/wireless/ath/ath11k/pci_cmn.h

-- 
2.7.4

