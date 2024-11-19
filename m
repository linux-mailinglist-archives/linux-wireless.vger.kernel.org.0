Return-Path: <linux-wireless+bounces-15486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EC9D1F38
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 05:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ECC1F2212B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 04:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73516143C7E;
	Tue, 19 Nov 2024 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="THHYJBDq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8420E6;
	Tue, 19 Nov 2024 04:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990509; cv=none; b=pswg1ic/4Jb/gQuXkcKDP+tIpMydV7x1k8ugfnbkSXSWmEQtBagdm+/2/YKxiKxBll5ppDGEYlBsOn3O2x1fpUwM7OAUNcfCZ+KNHKuJTi1ncwNC77edErEH5N8bru7qFKIpAHKvG6TL54pdQgpeQtPC/6zTif4ZWbjjYyoRKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990509; c=relaxed/simple;
	bh=JrGvjhr/F1hJpWDT3LAA08gqAH+scdI/xHbkU8woSB8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PshlL83HjTWalY4GAAQWNaEmSqr7tlp9cR+oQ2nkjVlg8l4JObFFC0F+K9WGCrbmkedW7w2NkAPyfvQ4x31ek5LSJdovwkUjJxbqLrOuDqvwpRmexK5yL5urXgueXVY/yX/aN1PaxPpXGYY4VRAGjWhyMKIkbllY3nbxFzJdf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=THHYJBDq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGkxi031025;
	Tue, 19 Nov 2024 04:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hryCUBtmuaoQxsz3KLnNyv
	n3NWWFhCedieE5NUuWi6o=; b=THHYJBDq688XR5ob8oT/3pYecDbK4RG2hcn6Jj
	IAkm65YNUYWCMQ0kUv+uicgBdIxZFRpoJxeB0WsUGs+BDluqFeCFqYCsc/d1BjWJ
	UdqaRkMS43qiOyQAKL9pigpYEACUan/6DL15tXCK2+pm1XAs3Kx0gVWLuy8yWS3p
	2EY0H8VZFBc02NobdF55ISR8LYlTobpywLOqS1X+/EGvAuQUffy4qKLcXNRlJn/b
	d9CSO7AQIbFcRdxYVOnzjAU1S/ujwtlVGLxSU1fwDaoF9lYhxdzY8c+2DzR7k6Yp
	9h1oN+ZgtERWCu8twQn/HtKT4x2bnrF5s1zTs6KGUAaLQZVQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y91d20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 04:28:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ4SKHe029151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 04:28:20 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 20:28:18 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211/mac80211_hwsim: add mesh EHT 320 MHz
 support
Date: Tue, 19 Nov 2024 09:57:58 +0530
Message-ID: <20241119-mesh_320mhz_support-v1-0-f9463338d584@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4TPGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0NL3dzU4ox4YyOD3Iyq+OLSgoL8ohJdMzNDU1MzU8skC2MDJaDOgqL
 UtMwKsKnRsbW1AEg0A91lAAAA
X-Change-ID: 20241119-mesh_320mhz_support-66155659b830
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8NfZoD-VoIJRBRqbRtGL0TTLAN_Er3kk
X-Proofpoint-ORIG-GUID: 8NfZoD-VoIJRBRqbRtGL0TTLAN_Er3kk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=623 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190034

Currently, ieee80211_ie_build_he_oper() lacks support for 320 MHz handling
(already noted as a TODO). This is because 320 MHz is not included in
IEEE 802.11-ax. However, IEEE 802.11-be introduces 320 MHz support and if
the chandef indicates a 320 MHz bandwidth and is used directly as it is, it
will result in an incorrect HE Operation Information Element.

This series aims to add support for EHT 320 MHz in mesh mode. It also
extends mac80211_hwsim to support EHT 320 MHz mesh mode.

---
Aditya Kumar Singh (1):
      wifi: mac80211_hwsim: add 6 GHz EHT Mesh capabilities

Sathishkumar Muruganandam (1):
      wifi: mac80211: add EHT 320 MHz support for mesh

 drivers/net/wireless/virtual/mac80211_hwsim.c | 39 +++++++++++++++++++++++++++
 net/mac80211/util.c                           | 29 ++++++++++++--------
 2 files changed, 57 insertions(+), 11 deletions(-)
---
base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
change-id: 20241119-mesh_320mhz_support-66155659b830


