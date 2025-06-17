Return-Path: <linux-wireless+bounces-24170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD5ADC174
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 07:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D22A7A9585
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEC921D00E;
	Tue, 17 Jun 2025 05:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RUTgSIMJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFC21B91F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137151; cv=none; b=cLwv1ORIdRNLoWj1+SUMJ/f0OZ0asoE5Qnv5JbZgZQ+sZ3BdbpjmICWUib2jYyksJJd4GPUf7hMLx3eWumIJwYYYUBeLGLrCY6a7xY+koEmw0IRGZL0qzQsVbCtN9dPlWykzmV1JirkQVf02Up2H1h3BU7FblDTY+u3UJwjrnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137151; c=relaxed/simple;
	bh=8f8TrwWbV9Ax/j8FcW3baGXlYmOAga+VqcyM+x7A16s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DyXu9YkoxKzzO9R1uFsHYu4/4x8CNXctp3Q5Bee8EA/VrUKWtns5aPz8wCS0DPYXAd+BUJDEI/LgNYlCA7kiL7g9MwIYzpovrw4QgJ2/rv5fr/6xA5JFtlyVTLkYdoybqNREeoMeSavfoXDJKUcNcf20bMRNBmqZ+aIPYalut+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RUTgSIMJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H1pQbT001757;
	Tue, 17 Jun 2025 05:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=L510TQuzBIUrKtxm/KC4ex
	EH3ybc39C++cWmw3do7uM=; b=RUTgSIMJPkyvm7fXLl9sJHWAO22LLlARhpkLX2
	vvpfDhk44pdW2L5bdvxnSWywBERyEbdAriRltdbIaHmLACn7U67F4RcWAS+p8ZFz
	9PMx6gzXDi29eMpdNZpovuqkrRVhPbuuKsMBMCWgTnn3Y8VsffOY8eAe7krSk7dW
	DGIb5kJ0Gb3MfvASbbXgxtb+/OoIcOMGvXNwxiHA6InDzpFhenbfI8NUHGQIfnPd
	N03tuTJWR/Oh2hMhl8TDenahAmymhPiBgCsvM0xhMd6FHuPmzi/sm14qQYoStCYQ
	EYvY/hKeQvto3hHtrfFd8zYTWnFR+zA0php4Ch6MV7pnpPRQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47akuwaagd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 05:12:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55H5CQl6030467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 05:12:26 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Jun 2025 22:12:25 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Support TDMA, MLO, RTT stats
Date: Tue, 17 Jun 2025 10:41:34 +0530
Message-ID: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kc15SquwV3BV6CRQ33JgL_6vbHA_xEX0
X-Authority-Analysis: v=2.4 cv=He0UTjE8 c=1 sm=1 tr=0 ts=6850f93b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=grKnNh-ejgdd-aMNrFYA:9
X-Proofpoint-GUID: kc15SquwV3BV6CRQ33JgL_6vbHA_xEX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAzOSBTYWx0ZWRfX33ATHOgaf/qy
 C0IoGiYa9BMGJlkl4rHIWVRX/G0l8gEzWft/EuP6BZZ37uenmTGk7VWVTWzwVW7X2szo/FlT5nL
 dSwBMhaT2XWk24D55IFBKGYRjQPTa1QItWuk+UjzT17QsWOL7ilAM+g/WlIRydURd1fJSXWtx8E
 a8+/Zrih8SKf6bTmWAoiLGIb8dRh2aUTw4AuIIP3g/JkhGcjUyEQYx52k5sovHONJpJAX8Cd3fe
 qfqRfOxoknLINSv8e/6wQueWwm1oszOSV9R+crMT8wzJP8I3uu6o7SFZoAakxqwX6hMcGlNkwdY
 lxlLV/xaFksJcH+ElHTOQ9jvyOOLWArn0QP4pD+7RZkzbPep2B7GyJIunFe1lxP6i1q57kas/5i
 DQMqDSi++810+JLPuShq8fyUFQsjBc2mZlw3lx2h9+mUl1nEB/vj6HxSLha1Y+02/QpI4OKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=707 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170039

Add support to request HTT stats type 57, 63, 64, 65 and 66 from
firmware. These stats give TDMA stats, MLO scheduled stats, MLO IPC
stats, RTT response stats and RTT initiator stats, respectively.

Maharaja Kennadyrajan (2):
  wifi: ath12k: Add support to TDMA and MLO stats
  wifi: ath12k: Add support to RTT stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 516 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 185 +++++++
 2 files changed, 701 insertions(+)


base-commit: 7fb79ce2693c94f8f74bf62ad25a97e4b61721b8
-- 
2.25.1


