Return-Path: <linux-wireless+bounces-23439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308E1AC4A6D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF8F189535E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA09E248F65;
	Tue, 27 May 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b4e3XCc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACB2405F6;
	Tue, 27 May 2025 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335333; cv=none; b=EfiDhrAx4nQO+lRKUHdacBQq07A3Nb6kYeZqpIuN4/Cj9iRFCyIAvZCv24LilkjQkTz9yWs+NWiZ3gnZTZCk7/czHgltdnsdlCx8vkyWPNfqfDTcVeKBlBgbkC3wvAw9lMMSuJrh3hoFThbRuaHfMbbTDYyd25IdSXCNjVXww5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335333; c=relaxed/simple;
	bh=LJY0CHjEcus0vSGwLPR2uSy8OFr3DZQCKunHLlP0jTk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hMNC4SOJ9ayLyOeQzGpdHQvvZqGKzWP+uNbgkyI39e5yAIcu+S7uFB555SwJ4NBm7MkHMY1tAzsOHF6xwap7Kgi96alVYlIiUqzQT2jigI+DF6QjNc3d4U59oWHR66M+Rv2mcm3y0bpB4RNXCxPKSUoA1pNwn++hDI8bGEsXB+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b4e3XCc/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R4K3dq012741;
	Tue, 27 May 2025 08:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2ZzsST5W+NlsSGj6Asj9v0
	G7U7bQnVL/UVuPCuV/xoQ=; b=b4e3XCc/PUnLDCpMqDK65J/7LizXnGVwIVUJxd
	7HX2GLbfOtlNNcvqwGxfBxi7v545peGWtzKB6O86obENn0CJMP4EMb/21LeLT+E9
	Amyy5QhAryOxaeZV/sreiE0QzxSbfcSRhfuMiEgoKx+ilvp2K7ZczgK1FXskSpy9
	eKSHrYhZzx6G+J8nwgK/PblCvGliChEly9cJG1uqB53RtJnk7jUk38W6Alw6JK+X
	PvuUpzLZAmf2JdlXDlwPvtEdUd52BUb0Ek9AW75ymfCrdxO4qyrTnhO6GZ2ok8v3
	FtPE5TK8COxMCs1lPodEtLafXF16CnwwJ29SBKPnIucIofHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w6918krh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54R8g5VB005576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:05 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 01:42:03 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH wireless-next v2 0/3] wifi: cfg80211/mac80211: Handle
 simultaneous scan and DFS operations on different radios
Date: Tue, 27 May 2025 14:11:42 +0530
Message-ID: <20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZ6NWgC/22NzQ6CMBCEX4Xs2TXQH1FPvofh0LSLbAJFu4gYw
 rvbcPb4ZWa+WUEoMQlcixUSzSw8xgzqUIDvXHwQcsgMqlS2tJXBoR8xtILOC2od6nAhckbXkBf
 PRC0vu+0OH07UkwhGWiZoctyxTGP67l9ztZf+aucKS6wNGeWsPWt/ur3e7Dn6ox8HaLZt+wEe6
 8ANtwAAAA==
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
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=68357ade cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=Lk2AThpSkLnqzM6nTBMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Q53NwelZPsT9tqSp-QhRu4F983CYpAwA
X-Proofpoint-ORIG-GUID: Q53NwelZPsT9tqSp-QhRu4F983CYpAwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA3MCBTYWx0ZWRfX/FJh2LWHtqB2
 mhbhq18XYwXFRhkQzMpcuEU6BDTk4geSWa0DN8GDGww05UhBGySrSZWphcjtc7bOVZ/4i+tMx8l
 jY4eDTeHBeQ/DDOcAhfNnkeE+r9mNpmWeThEmBkQr8pGY4brGG89+6bapwaMr5ADAxEo8Q4hS19
 lGBXA1q8oGEWhLbl1k0ORymzckG5P1ZViaLXcD39GA0I6XYOo4jD74Ode8lcxwozwWCnhb5pXso
 TYVpYsurjtf6rf+mhmMGBZBZ/DvTT5n5S1QR/LqOgtX1xWQHwQ1V0TTDozuH+RHCl0lv+6IOVtf
 pK+i44+NYPk4o4Sp6UGfl7JjsWd0GbDtR5NDLVFI6YDyXKJXq5C7kqVO0w4zWw4kAaIOAdTA8of
 NbaY//CZTdu8RhBIR2XVNMcnRmc3lwiUn2sFv+dboP0EG732voSaSPr9sqkyYMsSDztmZwGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=425 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270070

This patch series addresses the intersection of scan and DFS operations
with multi-radio wiphy case. The changes allow for more flexible handling
of scan and DFS operations when both operations are on different radios
within a same wiphy.

---
Changes in v2:
- Half-open interval ([start, end[) frequency range check added for API:
  cfg80211_get_radio_idx_by_chan().
- In API ieee80211_is_radio_idx_in_scan_req(), WARN_ON() and abort logic
  added for unexpected case.
- Function __ieee80211_is_scan_ongoing() renamed to
  ieee80211_is_scan_ongoing().
- The logic to handle ongoing roc work and scan with multi-radio wiphy is
  simplified in the function- ieee80211_is_scan_ongoing().
- Patch re-ordering is done.
- Link to v1: https://lore.kernel.org/r/20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com

---
Aditya Kumar Singh (1):
      wifi: mac80211: Allow DFS/CSA on a radio if scan is ongoing on another radio

Raj Kumar Bhagat (1):
      wifi: mac80211: Allow scan on a radio while operating on DFS on another radio

Vasanthakumar Thiagarajan (1):
      wifi: cfg80211: Add utility API to get radio index from channel

 include/net/cfg80211.h     | 11 ++++++++++
 net/mac80211/cfg.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++--
 net/mac80211/chan.c        | 30 +++++++++++++++++++++++---
 net/mac80211/ieee80211_i.h |  6 +++++-
 net/mac80211/offchannel.c  |  5 ++++-
 net/mac80211/scan.c        | 20 +++++++++++------
 net/mac80211/util.c        | 27 +++++++++++++++++++++++
 net/wireless/util.c        | 24 +++++++++++++++++++++
 8 files changed, 163 insertions(+), 14 deletions(-)
---
base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
change-id: 20250514-mlo-dfs-acs-33d7d9eea437


