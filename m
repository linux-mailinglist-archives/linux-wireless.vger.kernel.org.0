Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312344E8DA1
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 07:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiC1F7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiC1F7T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 01:59:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D87951584
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 22:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648447059; x=1679983059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RVYlVHjwfF7ezNm1v6K6Oq6FySdDFVnygc9rKgQEDsc=;
  b=sDRuYqbubb1S6Sq3IzoHVt/kWNZbdclX5rvLv7+ahM+m+1gF5gXi6SCr
   EjzPvJR4QGRoNV62Exg4659YrgMnQXLuREUxwfiyajsHBYAS9h4UQ3Vta
   Rm2AaNKroKOsdpH1n7BJqXiYf4Noy4KAi+QPHzfmVspqoDoekSJTxR0df
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Mar 2022 22:57:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 22:57:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:38 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:37 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 0/5] Refactor PCI code to support WCN6750
Date:   Mon, 28 Mar 2022 11:27:09 +0530
Message-ID: <20220328055714.6449-1-quic_mpubbise@quicinc.com>
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

Unlike other ATH11K PCIe devices which are enumerated by APSS
processor (Application Processor SubSystem), WCN6750 gets
enumerated by the WPSS Q6 processor (Wireless Processor SubSystem);
In simple terms, though WCN6750 is PCIe device, it is not attached
to the APSS processor, APSS will not know of such a device being
present in the system and therefore WCN6750 will be registered as
a platform device to the kernel core like other supported AHB
devices.

WCN6750 needs both AHB and PCI APIs for it's operation, it uses
AHB APIs for device probe/boot and PCI APIs for device setup and
register accesses. Because of this nature, it is referred as a
hybrid bus device.

Refactor PCI code to support hybrid bus devices like WCN6750.

Manikanta Pubbisetty (5):
  ath11k: PCI changes to support WCN6750
  ath11k: Refactor PCI code to support WCN6750
  ath11k: Choose MSI config based on HW revision
  ath11k: Refactor MSI logic to support WCN6750
  ath11k: Remove core PCI references from PCI common code
---
V3:
 - Patch series with 19 patches is split in 2 patch series, this is the first one
 - Rebased on ToT SHAID: 7316a74e54318d0cd648242b18ea83cdef6dda96
 - Changed the PCI common code file name from pci_cmn.* to pcic.*
 - Added ath11k_pcic_* prefix to all APIs in PCI common code
 - Added pci_ops instead of having the chip specific PCI ops in bus_params

V2:
 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/Makefile |   2 +-
 drivers/net/wireless/ath/ath11k/core.c   |   6 -
 drivers/net/wireless/ath/ath11k/core.h   |  34 +
 drivers/net/wireless/ath/ath11k/hw.h     |   2 +-
 drivers/net/wireless/ath/ath11k/mhi.c    |  30 +-
 drivers/net/wireless/ath/ath11k/pci.c    | 978 ++++-------------------
 drivers/net/wireless/ath/ath11k/pci.h    |  28 +-
 drivers/net/wireless/ath/ath11k/pcic.c   | 741 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/pcic.h   |  46 ++
 9 files changed, 1013 insertions(+), 854 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/pcic.c
 create mode 100644 drivers/net/wireless/ath/ath11k/pcic.h

-- 
2.35.1

