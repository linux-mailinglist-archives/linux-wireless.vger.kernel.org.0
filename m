Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055634E91C0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 11:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiC1Jun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiC1Juk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 05:50:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8F141625;
        Mon, 28 Mar 2022 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648460940; x=1679996940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nfLZnZnv6F/e43L9Jwi3byMAmfMA9I7QicGicA5g0bU=;
  b=wEg1q4whNQkViIGBqmSODPa03I0wdBDfq6OekEclx4vVc8VjR5ZLNmpr
   Q94oPcXtbkVf8H3PGDcMIlrkIjaDx9lD0d5aKBj29uj2xtfxmvgzR4bkG
   Pi1oF0VX/dVO54+Z8KunCufoD2qTi3UZ12FCrrxQcHTBYByFd8iBxb8db
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Mar 2022 02:48:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 02:48:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 28 Mar 2022 02:48:59 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 28 Mar 2022 02:48:57 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 00/12] add support for WCN6750
Date:   Mon, 28 Mar 2022 15:18:26 +0530
Message-ID: <20220328094838.14093-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

An important point to note is that though WCN6750 is a PCIe device,
it cannot be attached to any other platform except on Qualcomm
Snapdragon SoCs due to the aforementioned reasons.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Manikanta Pubbisetty (12):
  dt: bindings: net: add bindings of WCN6750 for ath11k
  ath11k: Add HW params for WCN6750
  ath11k: Add bus params for WCN6750
  ath11k: Add register access logic for WCN6750
  ath11k: Fetch device information via QMI for WCN6750
  ath11k: Add QMI changes for WCN6750
  ath11k: HAL changes to support WCN6750
  ath11k: Datapath changes to support WCN6750
  ath11k: Do not put HW in DBS mode for WCN6750
  ath11k: WMI changes to support WCN6750
  ath11k: Update WBM idle ring HP after FW mode on
  ath11k: Add support for WCN6750 device
---
Note:
*	Remoteproc driver changes for WCN6750 which takes care of
	downloading the FW and booting of Q6 processor are under
	upstream review.
	Link: https://patchwork.kernel.org/project/linux-remoteproc/cover/1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com/

*	Also dependent on Series "Refactor PCI code to support WCN6750"
	Link: https://patchwork.kernel.org/project/linux-wireless/cover/20220328055714.6449-1-quic_mpubbise@quicinc.com/

V3:
 - Patch series with 19 patches is split in 2 patch series, this is the second one
 - Rebased on ToT SHAID: 7316a74e54318d0cd648242b18ea83cdef6dda96
 - Addessed DT binding concerns
 - PCI common code is moved to ath11k.ko
 - Added a new HW param for WCN6750 which uses fixed firmware memory, this is
   needed to differentiate WCN6750 from other ATH11K chipsets
 - Modified the logic in patch "ath11k: Add support for WCN6750 device" based on the latest DT binding

V2:
 - Rebased on ToT
 - Addressed comments on DT binding

 .../bindings/net/wireless/qcom,ath11k.yaml    | 361 ++++++++++++------
 drivers/net/wireless/ath/ath11k/Makefile      |   5 +-
 drivers/net/wireless/ath/ath11k/ahb.c         | 162 +++++++-
 drivers/net/wireless/ath/ath11k/ahb.h         |   1 +
 drivers/net/wireless/ath/ath11k/ce.c          |   4 +-
 drivers/net/wireless/ath/ath11k/core.c        | 118 +++++-
 drivers/net/wireless/ath/ath11k/core.h        |   5 +
 drivers/net/wireless/ath/ath11k/hal.c         |  15 +-
 drivers/net/wireless/ath/ath11k/hal.h         |  15 +-
 drivers/net/wireless/ath/ath11k/hw.c          | 166 ++++++++
 drivers/net/wireless/ath/ath11k/hw.h          |  11 +
 drivers/net/wireless/ath/ath11k/pci.c         |   4 +
 drivers/net/wireless/ath/ath11k/pcic.c        |  76 ++--
 drivers/net/wireless/ath/ath11k/qmi.c         | 220 +++++++++--
 drivers/net/wireless/ath/ath11k/qmi.h         |  26 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  13 +-
 16 files changed, 976 insertions(+), 226 deletions(-)

-- 
2.35.1

