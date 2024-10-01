Return-Path: <linux-wireless+bounces-13347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B89F98B2B4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 05:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31380B21630
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 03:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04A193412;
	Tue,  1 Oct 2024 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jV0gkQSV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA3193401;
	Tue,  1 Oct 2024 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727753488; cv=none; b=WgTj6Tb7FKPh9taHqsFiv3cYWJhPF27BpsJ17f6Z7+hgzDrpveeW70nJy4Z6NBZhhNZeZNeUorlzm0doKYc8JXOe6Nywd9dbeS83J+etislLJXpQajHs2bZ9fAQKlXq25kAnGucx2FwPhhat5gV6unp86IiHylI4n2ZpnR9/OnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727753488; c=relaxed/simple;
	bh=b0L6JJPpppqY1shg9ElFVlPW+ZopgEIqzTKKsySnFoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dxm3e3FFBHXMsWXdMZXAe0iODECChni/lyy0gsy+lxtBCR5etj8XqwVFlckzT/3beMGZcv+v3qByxsxvYPGIpJKbcWgt2UEi/gcXsuqKaFZoBeLJ1uqWFKNAoMd8kCa9RSU7LUARbhg3IdMbzeUSRsppTD/24OxV9Gg15vEn5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jV0gkQSV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UMvelc008791;
	Tue, 1 Oct 2024 03:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aERLxCnZBoiTjW9/f3SsgB
	85s84JsQsKyh9ZiNxQSw8=; b=jV0gkQSVqiL9sOwzBFSOFcjMdl8nA/NEOyw4Y3
	IOyyySQLkyqDh1TXs8vBvyPUY90IHyLdjSav5TfbbgYVPKnprvPJp7Zwug7Mm8XD
	wT8LEyfDGBkA8b8fJnYozcjzi+d+spAMV+BeCfL7R/8hob1MUK3X7Dew1jmeNq0x
	o3uBVNqZJPx8ZfKwHhjzRVS7r+4ZGN8CobX+CJHB6X641KSpOHKG7K7CtDJyarsJ
	EQYCIaDI0rPRNSzFBRX8as5dAtjE7w04k2q60rIOfnt/noJA86h58plNGaJtWnHP
	rpgN2hB4SAQQlhSj8bN1Ru/rv6qfpbydxTOoHnahIygIjc8g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x7ge70ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 03:31:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4913VKRU028856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 03:31:20 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 20:31:18 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH 0/2] add firmware-name device tree property for ath11k
Date: Tue, 1 Oct 2024 11:30:50 +0800
Message-ID: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zHbVF5GGiXIMC2qwiXgIZ2r_NLWt-hte
X-Proofpoint-GUID: zHbVF5GGiXIMC2qwiXgIZ2r_NLWt-hte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=839 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010023

QCA6698AQ uses different firmware/bdf/regdb with existing WCN6855
firmware, which is customized for IoE platforms. And the 'pci-device-id +
soc-hw-version + soc-hw-sub-version' may not be enough to identify the
correct firmware directory path.

The device tree allows "firmware-name" to define the firmware path,
    wifi@c000000 {
        firmware-name = "QCA6698AQ";
        status = "okay";
    };

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---

Miaoqing Pan (2):
  dt-bindings: net: wireless: ath11k: add firmware-name property
  wifi: ath11k: add firmware-name device tree property

 .../bindings/net/wireless/qcom,ath11k.yaml           |  7 +++++++
 drivers/net/wireless/ath/ath11k/core.c               | 12 ++++++++++++
 drivers/net/wireless/ath/ath11k/core.h               | 11 +++--------
 3 files changed, 22 insertions(+), 8 deletions(-)


base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
-- 
2.25.1


