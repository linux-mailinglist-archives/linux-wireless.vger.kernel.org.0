Return-Path: <linux-wireless+bounces-24622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5DBAEBDEE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66396A0AE0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4692E9ED4;
	Fri, 27 Jun 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HYfomrs0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CD29DB6E
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043553; cv=none; b=Mbq7j1PJCEnU6V9vWR1a4QHPpC7+s6nrltPDAcyQOfMB0SN3izhIpBo72MMsa0yT3eYb5RBji41y1EtCeXsUvzeD77brjM7by0dHf0kuk0sF5mO/oEHx/w3IRB5TcvJhgNSzPIJPVN/2d/tE5xglel9JFfGHhbfEiVCEIUx9hTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043553; c=relaxed/simple;
	bh=an2W5gOm4nfS1nA/OKzOOdD4IS6d5GW9TmCLCk+APjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hqRFkumrJ/rO5u6VPzZ5OR012v8qi9bhjxcNOvwOgJErH3rJZZ+bg50xa/wgGN8UphU9dMRumebq9GQD36S7jgSdplqLhwiu8NehIwIJYbIaLkmv6q2dmazTFPkjOTiHJONlVAKlsHWh5S+ZHpaI4/Zfg4kiNeHDk4G+Penva0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HYfomrs0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCDxHN028733;
	Fri, 27 Jun 2025 16:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eZVIlOOELhJQzEKemWMy3E
	rmixMvAEr0fI+jXTV8LUM=; b=HYfomrs0Enpycic6js/SChbPzo+r3iYjZ5cxHp
	XtlXKrohM7a4bZ0a1s6plRr+Q4+nzzLAASjZB0444U6wgMaeLn77QGF41v2aB1mc
	WXj2/IkahAR+62HgFHN8vBhe9tVPlTSexgECRhiCXKTrZ8mFYCXatsJYfAWEyWbm
	niVTryGzPoPglIXB/rzAal/YJmGm68RZA1N7JJSiprDbn824+1XQ2F0LvpvdP5BW
	Pghe8+3nfUGD6Xt4MfAQkTZ9W4xmhahriTtMYB+IPnsd3+wKN7z8hSdSm3Mg/VyZ
	etAg8raJh5j9kh7X70ZqILtk4XyUlaxKbtgkF2EnP2k3CFBA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa50tt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:59:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55RGx7kD012421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:59:07 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Jun 2025 09:59:05 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v6 0/5] ath12k: add support to fill link statistics of multi-link station
Date: Fri, 27 Jun 2025 22:28:43 +0530
Message-ID: <20250627165848.3178339-1-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685ecddb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=kYzkSp3CTHGy5h0v6O0A:9
X-Proofpoint-GUID: JiFn5MrJ66fyuAPjBpeu5ftODDNbUgZx
X-Proofpoint-ORIG-GUID: JiFn5MrJ66fyuAPjBpeu5ftODDNbUgZx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzNyBTYWx0ZWRfX3FPoZotFNT73
 VKUVkaF2fjJ2aJw4TvgNQvSulzEyAE9tZOS2YZyfHN7K/q5lR85h33zJ4YU3nnRbHqYI4AH2WuC
 CirJDVloCdgHU1Xqso4J0AGonbqsWRYrWdan8dJ8G98Yl1oYTaxmdBirHzFOq1pr60jWDrz+TKw
 q9E/KduQHvt5GxBu8QbL9vMDsm6pT1XR0mzZTSIkn6MYpSXTnvT4CY5cg8ZDqa979SNwcUB6g/P
 EfuIINhm5CNJonE8++/YyXaZsZWOvkyEtaE8o9RRpSWo0ge9rE3CBz2F3yifcw49j4Hve2ojEfL
 RKUvF9WMUYns6+lz8NrJyxte5UANBzMHRSPgnPGKH7ExE8ozZ6FI6WJCATF43xExsFPUEIK44wr
 QR2abTdeesKnzGAaFcKuxpUUEAydLynOVcRRFACB6Ez+3asaAfZS0zSjN8vUQnXK4FEe/oL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=614
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270137

Currently, station statistics are filled at deflink for both non-ML and
multi-link(ML) station.

Hence, add support to fill station statistics for the corresponding
link of station.

V6:
 - Remove dependent cfg80211 patch- as merged.
 - Change the code according to  design change of cfg80211 patch series.

V5:
 - Removed mac80211 patch from this series and included in dependent series.

V4:
 - Removed driver patches.
 - Added branch tree tag.
 
V3:
 - Fix kernel test robot build error

v2:
 - Convert RFC patch to actual PATCH with each patch bisectable.
 - Add new patch to update bw for ofdma packets.
 - Add new patch to fetch tx_retry and tx_failed packets.

Sarika Sharma (5):
  wifi: ath12k: fill link station statistics for MLO
  wifi: ath12k: add link support for multi-link in arsta
  wifi: ath12k: add EHT support for TX rate
  wifi: ath12k: correctly update bw for ofdma packets
  wifi: ath12k: fetch tx_retry and tx_failed from
    htt_ppdu_stats_user_cmpltn_common_tlv

 drivers/net/wireless/ath/ath12k/core.h   |  2 +
 drivers/net/wireless/ath/ath12k/dp.h     |  2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c | 22 ++++--
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 48 ++++++++++---
 drivers/net/wireless/ath/ath12k/mac.c    | 88 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.h   | 26 +++++++
 6 files changed, 173 insertions(+), 15 deletions(-)


base-commit: 4fb98d37afdac11db1f82c1d662e0fd3d209afaa
-- 
2.34.1


