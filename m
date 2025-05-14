Return-Path: <linux-wireless+bounces-22933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5EAB69F7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8429117ADEE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85972749EC;
	Wed, 14 May 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VIbbzvVf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059142A82;
	Wed, 14 May 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222125; cv=none; b=om8Aq0UfoYzjOjVfnM1XQ3CXtZTB9QS87G0Bty+tXQA4IfoROBxjzMr4djcLYOO74SIUPgfgOF74TNg8oL+kT975rIbAUKMn3x22pqsGVnEIdnQuqwTDkL5vqTzjZV+UPogk00KlM9cCkNFP+Gok4YiR+JHJbKrhICoJASuLSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222125; c=relaxed/simple;
	bh=xBG4QyV4+rA+oKFRd1wLGgxm7gt5WxraZSSGs/hrkew=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Incjd4cD9kQ7AdAaL6aTC7c2zetI1W0IEwiR9HBLsacGqthvsIfXTYAGurn74XIx1wb29M7w33kVsi7MG12vHEhGChkeeQ5nhokgVgouYr/Pr+h7oL6W4Z/D/3sUDkrBGrrFi9zeB0+CuqmgSY82P5q5tppaypBmfUbtz3LMMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VIbbzvVf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuei2020092;
	Wed, 14 May 2025 11:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9Mcy8ib5QnpBS9mCMiIen6
	57lSMzRB1/LhILlutt+G8=; b=VIbbzvVfIYTlCtOoGPo8QsMwR9837S4+GnFc2G
	+vZbNQp4gkig9AtIjscGqj1kQgWUzRcnsk81Dk5aV67E283rW7l6Sk1YTnjB67pc
	13qUSUtwqm8TpvDCxL8VsCPW0LpuXZwyfnsQAxkEuQ7D5QMTThtlN92J9GdhgZ+A
	1K9sO0wRqtpEcqemAvMF/97JVx8tP0bpiBMCwUgYHMbljPqoPnRNd/HqJFZV+9Ci
	5jiWn+1bUolbcI8pM2sXPK4Fmuq3HgA8XwFhOqpkxML24Hcx6Tx85DA3iVxnsDap
	5LXEmGpXU4pdlozOTaFLXXkI3LEZkI76rSoqE7PV/c5X7trA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnjgau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EBSdZb012735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:39 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 04:28:37 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH wireless-next 0/3] wifi: cfg80211/mac80211: Handle
 simultaneous scan and DFS operations on different radios
Date: Wed, 14 May 2025 16:58:21 +0530
Message-ID: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFV+JGgC/x3MwQpAQBRG4VfRXbuFIfEqspjMj1sMzRVK3t1k+
 S3OeUgRBEpt8lDAKSqbj8jThIbZ+gksLpqKrKiyKi95XTZ2o7IdlI1xtWsAW5qaYrEHjHL/t44
 uCVigyh73Qf37fomaNhNsAAAA
X-Change-ID: 20250514-mlo-dfs-acs-33d7d9eea437
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aB2SfLb3Q6G-Sp0FUS08T5kIyPIUE_MK
X-Authority-Analysis: v=2.4 cv=aIbwqa9m c=1 sm=1 tr=0 ts=68247e68 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=_Sb81030VibebUp7WJcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aB2SfLb3Q6G-Sp0FUS08T5kIyPIUE_MK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwMSBTYWx0ZWRfX+87rsl7KzHWq
 B/o4T+53IkNQFuEZhCyThMLKU5iIz7HGPTyoo0UBoHBuhQD2bSm23orCBY3hPAWeJmtVEw7uKi1
 7Et4eCMHnTcNaY9Jw4O5K1i49ugTdWMArDCJSp4NdrJ5wigLoxjG28HnZc3+Ca0brMHnL7+6jcY
 xTo/tqXQdWaNieFX+Log8TrIvYKQLSpEKyq/2IgSl0RBONiQB+AMDufg9xjbkKLlfULqUnwCUAl
 hLzDjbTMvGenTG7LEo+XAlDhOdJSfj3xhtz7fzrMDvFxddXf3dZV1kPFGQWI0Q4z8HptLIoOC+q
 TT9Nt4mXBddJCG0fI3kmlqIv5CTXnhIVPXENaJOSDO1KfKVKNk/EiBXVptnDBWbnxZ1T7aWTZfj
 ESHUrF2wXUYwTFimwrmDa8XscTsC4slLTdP13QYYKsFhkIsghW72Jit3yZuRsf40wDvB+P1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=500 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140101

This patch series addresses the intersection of scan and DFS operations
with multi-radio wiphy case. The changes allow for more flexible handling
of scan and DFS operations when both operations are on different radios
within a same wiphy.

---
Aditya Kumar Singh (1):
      wifi: mac80211: Allow DFS/CSA on a radio if scan is ongoing on another radio

Raj Kumar Bhagat (1):
      wifi: mac80211: Allow scan on a radio while operating on DFS on another radio

Vasanthakumar Thiagarajan (1):
      wifi: cfg80211: Add utility API to get radio index from channel

 include/net/cfg80211.h     | 11 ++++++++
 net/mac80211/cfg.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++--
 net/mac80211/chan.c        | 30 ++++++++++++++++++---
 net/mac80211/ieee80211_i.h |  6 ++++-
 net/mac80211/offchannel.c  |  5 +++-
 net/mac80211/scan.c        | 20 +++++++++-----
 net/mac80211/util.c        | 28 ++++++++++++++++++++
 net/wireless/util.c        | 24 +++++++++++++++++
 8 files changed, 176 insertions(+), 14 deletions(-)
---
base-commit: 63a9a727d373fa5b8ce509eef50dbc45e0f745b9
change-id: 20250514-mlo-dfs-acs-33d7d9eea437


