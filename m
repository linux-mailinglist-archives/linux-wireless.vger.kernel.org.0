Return-Path: <linux-wireless+bounces-851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C38157EF
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 07:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A728BB23BEE
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 06:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D81156C1;
	Sat, 16 Dec 2023 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b4oM5xMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B614A8A
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG5xIB8032516;
	Sat, 16 Dec 2023 06:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=rZK/Xcn
	jk3L8biv7FoNRD0CQnCUzAoYQp6lNN+mJEx0=; b=b4oM5xMIfnPpIPW59pIX13R
	Kn4D0TCmP7jaTrD29NsZ0rNGug8QIxSIONun2s/uOt3Ky0OYECxng+otm3Kw3hgl
	ZSUem8EsKNiA1esghYfllMYZXjWmsF6ih6bue6OpT61nLYW/vuKH46IFPI/2xazp
	lNzWR92jC/5tqkgPv0CjaaHPzqp/OkRYcEQRa23SIbJx6KK+J4x7kCfvyecEWALy
	9IcS8mCEWzTkR7HUPda9R/IAaSTFqSeQzLoyi210o0Op26kV2BwMeRoo/KHMdN5s
	YuVIFklhhh8S1221Zaki0bGqWa5HFmJqvuKrmk1Bnwv7Ee1nJhRNhAY95bO8pPw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v152q833p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG62A5M029858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 06:02:10 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 22:02:09 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: ath12k: support some new strings while searching board/regdb data in board-2.bin
Date: Sat, 16 Dec 2023 14:01:35 +0800
Message-ID: <20231216060140.30611-1-quic_bqiang@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mMxWL8-8kDm5zu8F_0idAb7YN2sqlcj9
X-Proofpoint-GUID: mMxWL8-8kDm5zu8F_0idAb7YN2sqlcj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=688
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160042

board-2.bin may be encoded with much detailed information such as
vendor ID, device ID, subsystem vendor ID and subsystem device ID
to distinguish different chips. So add support to do precise match
while searching board/regdb in it.

On the other hand board-2.bin may only contain general information
such as bus type etc, so add fallback method to avoid boot failure.

Baochen Qiang (1):
  wifi: ath12k: support default regdb while searching board-2.bin for
    WCN7850

Wen Gong (4):
  wifi: ath12k: add string type to search board data in board-2.bin for
    WCN7850
  wifi: ath12k: add fallback board name without variant while searching
    board-2.bin
  wifi: ath12k: remove unused ATH12K_BD_IE_BOARD_EXT
  wifi: ath12k: add support to search regdb data in board-2.bin for
    WCN7850

 drivers/net/wireless/ath/ath12k/core.c | 196 ++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/core.h |  14 ++
 drivers/net/wireless/ath/ath12k/hw.h   |  20 ++-
 drivers/net/wireless/ath/ath12k/pci.c  |  10 ++
 drivers/net/wireless/ath/ath12k/qmi.c  |   3 +-
 5 files changed, 203 insertions(+), 40 deletions(-)


base-commit: fc91263c01cc01cccb5da15a82fa11b288e8f5cb
-- 
2.25.1


