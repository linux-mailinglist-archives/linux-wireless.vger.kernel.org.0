Return-Path: <linux-wireless+bounces-26431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C89B29EED
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 12:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA657A2D5A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5103112A3;
	Mon, 18 Aug 2025 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VtAVZIVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30C2701C3
	for <linux-wireless@vger.kernel.org>; Mon, 18 Aug 2025 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512410; cv=none; b=Ww1+q2lqFSOXokT7mpdInPduEu3CMqIrIHnm7bIlnGlZAxKP+bfkh9O8tZy/4ojUwnkq3CttW48SDOt59MdlerXK/nXcY7TOSYdLn16WKeICgXPXabtOhjpeJUpYhBG9oyH3RKjHfyGx+13Wj6O4/2U6qTepInT5OdtbycPyM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512410; c=relaxed/simple;
	bh=lxAKNva3Ji+M0xfmn+ytMfL7bDMlYixZ4EtNxFDyj8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LZ8r8/YG1viLfoOzSiYxa3mpCbCM6LVARZ3HCr97pw3kl3IOU9GuPjhR9AilV0gjBFkPk1cRofjJVJAJinkpXfM27YBYeUxF1jFC2ao9p6RBwIVnTpoN6QoBmsSFuFvebj4JMsQHRS2YJ2EFQaF7VuGmGNR03nzanoeUrylVWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VtAVZIVe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7V4uQ026360;
	Mon, 18 Aug 2025 10:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jAKleLGoQaryB93XZQPjQ+
	j9PKw0ynsfn5UEisLjHB4=; b=VtAVZIVe2VhUAzbYGw02TJdHml9uKyhkeMkWAy
	hBRGkrKOM4fn5Zos6HzO/OFhXzlGe9O7GarQacYN/1xEUrrNf/8R9zQOFOA8f2nt
	CNCq8uEiZjGUtm3gSgmkoAx49jdNTrjdaEityBnUbA93o0OFAFnWOKPcKIBpPJgf
	DlGcJh8f865Dnm+sZWhIn1OaSs9aGCcLO7Pqphcx1N0U6NZhJPNrcv3RIwAmNV03
	qKosr2n4pc7j5tC7BXGU9x385v9zRU5ptkck5sFJUK9ZaDbgXFGjQs31Itnn0ig2
	CSGWBFyo5Z8g4EA7W8G8Z1D63WYqhO2wW+RTZukDWEMM28aw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunrgj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57IAK3Df016751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:03 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 03:20:01 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>
Subject: [PATCH wireless-next 0/3] wifi: cfg80211/mac80211: add support to handle incumbent signal detected event
Date: Mon, 18 Aug 2025 15:49:44 +0530
Message-ID: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jP0kUeg1UEfNJF5Njv8c0cBjMLCtmscg
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a2fe54 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=bg1tv6u6hkGMVcEzmNAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX9NzH6AnfxSOy
 FnphzeNjGXtB0jNsACdn5uQMajhHX/BXqCm48Sx8fohHsB+xtSeKJL9LWSI2h0yubXtijfkrMIp
 VCRovZO0LeYsPKxQl1/60jLpW2zS9UEaVQdJ4vENWMK5AKO6YtFKMaolD9bxwkMVYR4hTc/ajM/
 +n1UFwopemLru9FP9P6CMtZ0AAqWMGZDzQM7RgEiQxD6Q8bRm5otojugvkQVRGjEz1MeIJYkB2O
 ULVrbYFUYJFKduZrNAl2+CDkk2ocI2odH/YDs3XFRb/Fds14nmRssBGn8UcODSMdBKWxKWISUpn
 API/v/hMr7L50w/yHjeT68tbM6k8raQ7JFE3XfE3qJLOxoecx8bW9f5qHO4wMjOjiyu3LOiZ746
 opK/moSh
X-Proofpoint-ORIG-GUID: jP0kUeg1UEfNJF5Njv8c0cBjMLCtmscg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

This patch series adds support to handle incumbent signal interference
detected event in 6 GHz band. When an incumbent signal is detected by an
AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
vacate the channels affected by it.

Driver is expected to call the newly introduced API with required
information to notify the interference detection. This information will be
ultimately sent to user space via NL command. User space is expected to
process it and take further action - vacate the channel, or reduce the
bandwidth.

Aditya Kumar Singh (1):
  wifi: mac80211_hwsim: add incumbent signal interference detection
    support

Hari Chandrakanthan (2):
  wifi: cfg80211: add support to handle incumbent signal detected event
    from mac80211/driver
  wifi: mac80211: add support to handle incumbent signal detected event
    from driver

 drivers/net/wireless/virtual/mac80211_hwsim.c | 33 ++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  4 ++
 include/net/cfg80211.h                        | 17 ++++++++
 include/net/mac80211.h                        | 18 +++++++++
 include/uapi/linux/nl80211.h                  | 16 ++++++++
 net/mac80211/ieee80211_i.h                    |  5 +++
 net/mac80211/main.c                           |  3 ++
 net/mac80211/trace.h                          | 26 +++++++++++++
 net/mac80211/util.c                           | 39 +++++++++++++++++++
 net/wireless/mlme.c                           | 12 ++++++
 net/wireless/nl80211.c                        | 35 +++++++++++++++++
 net/wireless/nl80211.h                        |  4 ++
 12 files changed, 212 insertions(+)


base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.34.1


