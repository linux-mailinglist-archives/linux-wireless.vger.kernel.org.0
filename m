Return-Path: <linux-wireless+bounces-27923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A3BCAE56
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 23:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68118427FFA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B8281366;
	Thu,  9 Oct 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QuenW8jI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF620272E41
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044636; cv=none; b=EO+uzFPq0ZDSPtXmE2L3mR0HHkDDfWsFfGi+WpVfUaBiw/08y+1K/D/3RI8r+yMrnxTddavLuWtYLstTQar3kwm9bWjII/b20t3R49cRBqH54eZHtByzwo6BTgvYX0/bXIs4xFldQDJPkQx7W69Bc/Kn9TdV0VlcA638dtoXyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044636; c=relaxed/simple;
	bh=vUCasEW+/DVBL3Ek5AVexL4nmggQlp+phhiQ7SNozKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k57yxmsNJxLv5K4k3zkjZP/Xd6N9N17oSvea4oOkNpf1FpzbjEJZAtCWe4MWDEut4EbG/ohGjz/1wiSe/nS30S+aYfWGLxGwRxJdDVJEhOrbR7t1oGH1umRXg0tp4eun5dX++fHt3HHERu0HFjLpt0oY4PQGHvmGx/s8VbsaC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QuenW8jI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EeR9P029031;
	Thu, 9 Oct 2025 21:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xUWZDQzLZsCVvhUanKwQxX
	c+w/D6CQx/9IWXS2PFdxI=; b=QuenW8jITSWjKPTmSewxzkUZXgGTZiSOG2cxeo
	R1PKnmOMxz0MShRNa1WVtvYoYzsBsKgWv66tL3xLraoApLsLspTBnVBPs1JTj9qM
	KrOSA7vJ4ssd5kwM2PR8pVhWkGl6AFLcCybfpn0+/MAdE0ZmFmU2bNvrvIaRN1yL
	lFQ0ajUgHj1lM+J8kcIA3LZJFOJ+ORaoW6srz1h/3TQ9YzgP1Yn+lgTxxeCtAmRb
	QLav3i9Q1d15wAUdUJ/5ZOo/w+rUW6lvEjd9DuuRgji7Gh8ZrQ3pMzXBUya1Wl0b
	PWygOZD2CXhZWpnqvyf/0kf8DUAiBZh52rrakLl4ors5LM5A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kvb9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 21:17:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599LHAae000375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 21:17:10 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 14:17:07 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH ath-next V17 0/2] wifi: ath12k: fix TX and RX MCS configurations in VHT and HE modes
Date: Thu, 9 Oct 2025 14:16:54 -0700
Message-ID: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxX5sFjyJ3VUx
 RlI09i/eZs9u497IW98JpwNeJv3kJiwIPstcYASiD38HwtaeyxolRVI8MIRStHU61aEzOVMYZZw
 nc0jrWfFiNzdwcdvyYF1yR4b5q/4WIvA7LqpmoLbdCx8vU+Slx71OOPKvcITnPxNMqA+GMvlVDw
 0VlhmePuGZBma/bha92AxHdcpeUh0IgbZbp8TC+1MW98clmR1k9m91SHweLKO2CEwQQDsO2vKc0
 DXC5HuRtsoB52ARhLrXPEqLNTG8FAiEAFxNaPoslB2ki683sj96ZxNuNu9IUKYJkeB2ok3Jm0FY
 tDH7M5FDwm6Ww+x7DxM/G1cNM+4oRyT7QF043WppehwtjApP4YyUUgPMMpg8NL8LJGt7twbvAB4
 z2mmEA3GcaYOAki91ZOVBDYEBXBr3A==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e82657 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=LuIi66ol2zLzsDA9yAAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pBz_DdcMcIzSQZ9c_bY3oajpa_QJOmEE
X-Proofpoint-ORIG-GUID: pBz_DdcMcIzSQZ9c_bY3oajpa_QJOmEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

This is revision version for patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/

changes in v17:
 - fix spelling in description.
 - change wmi.c wmi.h copy right per guidelines.
 - fix missing recalculation of v for TX MCS 160 in patch 2/2.

changes in v16:
 - remove patches in series which hare accepted already
   https://patchwork.kernel.org/project/linux-wireless/list/?series=977538&state=*
 - Fix review comment on last revision https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
 - Add similar VHT related changes into separate patch.

Baochen Qiang (1):
  wifi: ath12k: fix VHT MCS assignment

Pradeep Kumar Chitrapu (1):
  wifi: ath12k: fix TX and RX MCS rate configurations in HE mode

 drivers/net/wireless/ath/ath12k/mac.c | 12 +++++-------
 drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
 drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
 3 files changed, 14 insertions(+), 11 deletions(-)


base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
-- 
2.43.0


