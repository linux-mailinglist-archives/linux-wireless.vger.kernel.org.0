Return-Path: <linux-wireless+bounces-26326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1724CB22EB1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E034E1A25ECA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5A2BEC2F;
	Tue, 12 Aug 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kcx5xD/K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83252FAC07
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018760; cv=none; b=gRP8p7nWrWK+RRUEOCuo48EoxxEiF2823USSFyfzMgPpisRvjq91NSJK3bcfBrZQGJ0zoHuxVuVt6lt9Eups4wmZS9aufl9nT/nmtCjLEN4HKuYW7fRcucfUg/MEIgxvCLcaCEyZ6qsoxTUlIE8lETMqAqNy5/N008RmiIIRnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018760; c=relaxed/simple;
	bh=jhZB4udDGfRa540uoN5tnmGBAb8Dy/LJcUUb+BgCtDc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SyFYyW6k07gB4JqxFsHw27jdvv+bW/wsMSIJrfnZ14yNnM9BUCpWU9yadYiM/hhCzXjeWRyDN7zglZ1lmUktcCmYiCGWgEFne9+lpbMWriXbid8uOJXh42QrzRio2I/sAYD08AUluchtPgRAmyqux0s+st3RVjI87Q5of1k4FwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kcx5xD/K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CH6UQb010804;
	Tue, 12 Aug 2025 17:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c4GTwShWUYy0uuN4WMoUAU
	veoiRhxQ7tbF2xPnkuxDU=; b=kcx5xD/KnvfDD/qkK9Xlqt91L2btkUPgcN4vYF
	jxyeLeLhN1wbYa59v9z+FBwlicjlkttsPx/5BFVYDIQqIYQhyTWtMuzg7BIODMsq
	IKhbd9N0XixO80E6XVuB33hzB7D9EaTXYRz+xuBC1CB5OlBtclM68qkw/qPIUer2
	O5avBsKfFR8vEif0gGTutIJ3bCwYfiUicq4sLIHfo+O4WQckY9jPQMllvkEJW2Px
	JY098KkF5JTKmsYvKHsIXpFbFrIgE1Q3n2FJOq66vdQ5SjIzc6syWWNsn01cGbRb
	keo6qvd0VYMSOwFN79dIGjwdIINdcHRR8f/U8yiiB7Id2MFA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9r0gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCYRg010243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:34 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:33 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Subject: [PATCH ath12k-ng 00/13] wifi: ath12k: Ath12k modularization
 changes
Date: Tue, 12 Aug 2025 22:39:26 +0530
Message-ID: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZ1m2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Mj3cSSDEOjbN3c/BTdpBQDA0NTs5Q0oKQSUENBUWpaZgXYsGglqLq
 8dKXY2loAvipOVmcAAAA=
X-Change-ID: 20250812-ath12k-mod-bd00156df202
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689b7603 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=ULihl7S45PbkGyYbBi0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xKqW3gbTLEbGZBOgst_e6HAWJcnWoKRU
X-Proofpoint-ORIG-GUID: xKqW3gbTLEbGZBOgst_e6HAWJcnWoKRU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX8KT922IAQ7gh
 ZMSVczKQ6a2gPWhdvqbi00BC14ALTzu1b0Z6hAN39Hjk5dSOQAVDYSFuCfiau+y7nWqzGhkwfyi
 d1mZPQeqAkvEm1tGezH/wTpPb13VEv2YBTDlLCPvuKNFRET9cTXra33s0OaruplolyprsJXJA/D
 C4LtAybjUTk8nadHv+x9qebDQBfm1gfwoAfReykcfqazk++Tvx4M2XRnyvKDXd6WgPggII/i/lB
 dxj7TA3x5XHC30WzCRkIh7C1w6Op9JKysPE/8nyLZkXvKIcwhutxRNq+wHAdlKIYlpqSDxszrJh
 845kyUutwdw1/Sv/xsaecOHhLv0+EAo60+PClLfP3u/EoOrQ4E9Z4CsSxPFHcJhI0I01J1FPYz9
 bvgPm2Zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Current ath drivers have separate implementations for different
classes of devices. For example, ath11k supports WiFi-6 devices,
while ath12k supports Wi-Fi 7 devices. However, there is significant
common functionality across these generations due to shared firmware
and hardware architecture. In the existing driver code, this leverage
is achieved through code duplication. As a result, when a new driver
is introduced, many features are missed, and new additions require
porting across different generation drivers.

To improve reuse and maintainability, ath12k should be split into common
and device-specific modules. Common code can be shared across multiple
architectures, enabling better leverage for future hardware generations.
generation drivers.

Firmware interfaces and core initialization sequences are typically common
across different device families. In contrast, hardware register offsets, copy
engine mappings, and HAL configurations are usually hardware-specific.

Common components include:
      - mac80211 interface: Control path operations are mostly common across
        different ATH hardware and will be shared as much as possible.
      - Firmware interface (WMI, HTT, HTC, QMI): Firmware messaging and
        sequences are common and maintained with backward/forward compatibility
        using TLVs.
      - Datapath: Data path files are also separated similarly. More information
        will be provided in later patches.
      - Core initialization, reset, and recovery sequences: These will be part
        of the shared code.

Device-specific code includes:
      - Hardware capabilities, configurations, HAL, and other
        architecture-specific logic.

The original ath12k.ko is split into these two modules as depicted below.

                                      +-----------------+
                                      |                 |
                                      |   ath12k.ko     |
                                      |    (common)     |
    +---------------+                 |                 |
    |               |                 +-----------------+
    |   ath12k.ko   | ===========>
    |               |                 +------------------+
    +---------------+                 |                  |
                                      | ath12k_wifi7.ko  |
                                      | (wifi7 family)   |
                                      |                  |
                                      +------------------+

The ath12k.ko module will serve as the common component, while ath12k_wifi7.ko
will be the architecture-specific module for WiFi-7 devices.

After this modular separation, adding support for a new device will
primarily involve implementing device-specific code, while reusing the
majority of the shared common components.

---
Kiran Venkatappa (13):
      wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
      wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
      wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
      wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
      wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
      wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
      wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
      wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
      wifi: ath12k: Move hw_init invocation to target-specific probe
      wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
      wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
      wifi: ath12k: Remove HAL defines from shared PCI code
      wifi: ath12k: Remove HAL define dependencies from shared AHB code
 
 drivers/net/wireless/ath/ath12k/Makefile         |   4 +-
 drivers/net/wireless/ath/ath12k/ahb.c            | 139 ++--
 drivers/net/wireless/ath/ath12k/ahb.h            |  27 +-
 drivers/net/wireless/ath/ath12k/ce.c             | 301 -------
 drivers/net/wireless/ath/ath12k/ce.h             |   5 +-
 drivers/net/wireless/ath/ath12k/core.c           |  38 +-
 drivers/net/wireless/ath/ath12k/core.h           |   7 +
 drivers/net/wireless/ath/ath12k/debug.c          |   4 +
 drivers/net/wireless/ath/ath12k/dp_rx.c          |   3 +
 drivers/net/wireless/ath/ath12k/hal.c            |   4 +
 drivers/net/wireless/ath/ath12k/htc.c            |   2 +
 drivers/net/wireless/ath/ath12k/hw.h             |   2 -
 drivers/net/wireless/ath/ath12k/mhi.c            | 130 ---
 drivers/net/wireless/ath/ath12k/mhi.h            |   4 +-
 drivers/net/wireless/ath/ath12k/pci.c            | 215 ++---
 drivers/net/wireless/ath/ath12k/pci.h            |  28 +-
 drivers/net/wireless/ath/ath12k/peer.c           |   2 +
 drivers/net/wireless/ath/ath12k/wifi7/Makefile   |  10 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c      |  71 ++
 drivers/net/wireless/ath/ath12k/wifi7/ahb.h      |  20 +
 drivers/net/wireless/ath/ath12k/wifi7/ce.c       | 973 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/ce.h       |  22 +
 drivers/net/wireless/ath/ath12k/wifi7/core.c     |  44 +
 drivers/net/wireless/ath/ath12k/{ => wifi7}/hw.c | 798 +++----------------
 drivers/net/wireless/ath/ath12k/wifi7/hw.h       |  13 +
 drivers/net/wireless/ath/ath12k/wifi7/mhi.c      | 138 ++++
 drivers/net/wireless/ath/ath12k/wifi7/mhi.h      |  11 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.c      | 188 +++++
 drivers/net/wireless/ath/ath12k/wifi7/pci.h      |  12 +
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c      | 105 +++
 drivers/net/wireless/ath/ath12k/wifi7/wmi.h      |  15 +
 drivers/net/wireless/ath/ath12k/wmi.c            |  97 ---
 drivers/net/wireless/ath/ath12k/wmi.h            |   4 -
 33 files changed, 1956 insertions(+), 1480 deletions(-)
---
base-commit: d9104cec3e8fe4b458b74709853231385779001f
change-id: 20250812-ath12k-mod-bd00156df202


