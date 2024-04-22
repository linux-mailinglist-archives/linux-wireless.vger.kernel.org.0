Return-Path: <linux-wireless+bounces-6614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B68AC2E9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1143A1F21012
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D91EADB;
	Mon, 22 Apr 2024 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P4yH3BIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B84D272
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713755186; cv=none; b=EmKM64j2jZg+BHiITKu0pmLLf8cCPDKlGgIiYYHTkRjyBKlmK5eWTl9CY/8Jth4ubzzB1XFHWeTzPGaUavW96hJnMCokFz/NIQXWrIAPDO8ODPaV2pcu8Q+ojGOCWg9T6dzzQdUYp5TUgeiCH5pdc3VQbYZ9ehk9g0dJWQ73PAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713755186; c=relaxed/simple;
	bh=8REUxDQf2j5Bf3ZQNz2laUR1ibnPzQ4TGK947P8Y+AM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVjzMK3OItyabGSVWN8LjfPLDNCZDWnomYGezLEQsGAvERhC6dRwzOVX7OuWMLnC7I3XJ3gTX8yzdAmqVnstgX90KbmfK/M2gfaS8ZESdCu7AAQBHV/QkbbBedxyqOHTYOST5WlZi5mOW3j50jh7MpAdRyOW8f1ipe6mmoBMjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P4yH3BIS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M1v9e5022983;
	Mon, 22 Apr 2024 03:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=gC092vL
	AKRCg/+PH+1ODnSkrEKPuqA1zs8qvECLZ7/w=; b=P4yH3BISQMpJlaZ/kfMEMm1
	iDMOC0sYsNugQAuTX+YmuMGRewgJvE5Gh0p0TUabxltTBie63bZMb/vQoPQqySGb
	K4aI4b94AA+OrL+NnPNCoi3yRBAJo+hl2yT2CqOvm7N2jYefiZA6RhCtU1b4Lvza
	MzyTqzAXMUySOnoKyw3T68Iq6qqJxFBGt98qC/XfBl4xUHeBg5ZgIdkMGSTyvj69
	vjgmzK6XNf2vKw25JyLIZY1twIU+6G+jHLpEK73Cn5YgyU5PlLw38NCZaDd2otJh
	5/nQCXqIo5XNXw+/PWY1nFA4hpJ6S46YsCIFXT8CBFlot6/Dv/CZdoc26wNCV4g=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm63a324c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:06:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M366GD010778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:06:06 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 20:06:03 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v9 0/4] wifi: ath12k: ACPI support
Date: Mon, 22 Apr 2024 11:05:40 +0800
Message-ID: <20240422030545.954-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T6Od-M2v5qoL_Qg8ZtK8YI1PvDwPYRU9
X-Proofpoint-ORIG-GUID: T6Od-M2v5qoL_Qg8ZtK8YI1PvDwPYRU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_22,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=386 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220014

v9:

* update the Copyright of acpi.h and acpi.c

v8:

* rebase to ath-202404181528
* rewrite commit messages
* cleanup and improvements all over to match the ath12k style, including
  error handling, naming and so on
* locate new place to call ath12k_acpi_[start|stop]()
* move wmi functions up in wmi.c file
* consolidate WMI functions using WMI_PDEV_SET_BIOS_INTERFACE_CMDID into ath12k_wmi_set_bios_cmd()
* ath12k_acpi_stop(): don't call acpi_remove_notify_handler() if we never installed the handler

v7: https://patchwork.kernel.org/project/linux-wireless/cover/20231013114434.81648-1-quic_lingbok@quicinc.com/

* adjust the length of line
* add cpu_to_le32()

v6:

* remove code that is not called

v5:

* rebase to the latest tag

v4:

* revise commit log using imperative voice
* delete guid_is_null()

v3:

* remove unnecessary cpu_to_le32()
* adjust the order of the macros
* apply jeff's advice

v2:

* put <linux/acpi.h> in the include guard

Lingbo Kong (4):
  wifi: ath12k: ACPI TAS support
  wifi: ath12k: ACPI SAR support
  wifi: ath12k: ACPI CCA threshold support
  wifi: ath12k: ACPI band edge channel power support

 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/acpi.c   | 394 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h   |  76 +++++
 drivers/net/wireless/ath/ath12k/core.c   |   7 +
 drivers/net/wireless/ath/ath12k/core.h   |  18 ++
 drivers/net/wireless/ath/ath12k/hw.c     |  10 +
 drivers/net/wireless/ath/ath12k/hw.h     |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 143 ++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  41 +++
 9 files changed, 693 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h


base-commit: c416602943dd36fbd13af7496430723935c867a3
-- 
2.34.1


