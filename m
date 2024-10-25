Return-Path: <linux-wireless+bounces-14517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1C89AFF74
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF021C20AFA
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038B1D2F5F;
	Fri, 25 Oct 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hi9xEZ9o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260418A93F;
	Fri, 25 Oct 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850679; cv=none; b=sdFiqTj1bqzFAqX1DYhqJpzlbRGl+CxUjL2Y0xuWaln9CSKZao4JGd5c7Kqd5r8B2HONT5msQX5bFqQ8KLzAHp95YyNfldnSR+dznI8lwUL02Xw04jK0kSATDn674o+Ni0gsHiIfAdVORxQfc3vY5fwj9/6hvyMX994rdocPyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850679; c=relaxed/simple;
	bh=8q/071ntyfrzcchcXwbAm8VK6WPqpovoLaLg6mDtWik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDU8cFFF9w0TDwy0/xIZvMh4aHItERfpm16x5TILs9ttsDNDhs/98Rj6RM1/S0V2TFSIozbYZ41YGWSVpf5hImZnGrFoVsL/Xoxa6S8zZReDbXy5RNQrn+O7fh2ZcYknLZLNgbC1zhDkVKQChZdU4Td/O97Ro5Wp8BUsluXVYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hi9xEZ9o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OKhqhC031151;
	Fri, 25 Oct 2024 10:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3ltZHugAEqBbxalUKxyM6K
	zlwXFTfZrxwFi88WAyiyg=; b=Hi9xEZ9oVC5wEtYBw/r+K3xc9DZvtuHBnz/eUM
	OO3GgvJCSPa9+yfuu+mx6TnUQVSWrx4J1XMMqPS+KI379l4ioM5ykV7mnpsRNnBR
	tOtjH9SxSOEfTXoKQ7VvjdUYfAVZbIU4D9pCozMvUhiGHdBJ2Ls95rfsFkQXWva6
	neE3Tx5bXRwp/ZRAD1IyW1e8Y/3o8+GK/Ed/2uov8GoYvjn7thn4ciJAHkkFaOAN
	qWypA7KevImUvWYsHULZhzNwh50cwmkhBuacJ8MCuVgyjuz6LzBpESbxdSw+s0g0
	f5sv5VHiBUFtN/XiviD+pV6PocKX1ODPBHKNaIRsN+u3Gs9Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w0jxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:04:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PA4VTP012916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:04:31 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 25 Oct 2024 03:04:28 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath11k: support board-specific firmware overrides
Date: Fri, 25 Oct 2024 18:04:17 +0800
Message-ID: <20241025100419.2128604-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8tIPFE70zo7rTw4H13i03b5Xc5XHuiOE
X-Proofpoint-ORIG-GUID: 8tIPFE70zo7rTw4H13i03b5Xc5XHuiOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=903 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250077

QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
IPA, thermal, RAM size and etc, so new firmware files used. This change
allows board DT files to override the subdir of the firmware directory
used to lookup the amss.bin and m3.bin.

For example:

- ath11k/WCN6855/hw2.1/amss.bin,
  ath11k/WCN6855/hw2.1/m3.bin: main firmware files, used by default

- ath11k/WCN6855/hw2.1/qca6698aq/amss.bin,
  ath11k/WCN6855/hw2.1/qca6698aq/m3.bin

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
v2: follow the approach that has been defined in the commit
5abf259772df ("wifi: ath10k: support board-specific firmware
overrides").
v3: Use 'fw_name' instead of 'board_name', and rollback
ath11k_core_create_firmware_path() to inline function.
---

Miaoqing Pan (2):
  dt-bindings: net: wireless: ath11k-pci: add firmware-name property
  wifi: ath11k: support board-specific firmware overrides

 .../bindings/net/wireless/qcom,ath11k-pci.yaml      |  7 +++++++
 drivers/net/wireless/ath/ath11k/core.h              | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)


base-commit: cd4827fef2fd758a00012615f4529fd43a461dba
-- 
2.25.1


