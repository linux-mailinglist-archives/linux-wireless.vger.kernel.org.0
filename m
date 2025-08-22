Return-Path: <linux-wireless+bounces-26550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C4EB30DCE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B1E5E7977
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 05:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A7150997;
	Fri, 22 Aug 2025 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ju9ehLqc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AD29CEB
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838952; cv=none; b=o7Z2MzfY2n1L5zatmJWpK214ogMAy/LsQYo5yZmFz2VY3CEsEoCD+FpNQFGJeYUZzwXxB/a33vNb3fBirqVCewXlAQ9vlQaOca10P26JNEP3qa1HKCDTgehPkN15og9EeC48d8D4NaSilN/eUmRIrAFODNtmh+NEn6SR1I6GXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838952; c=relaxed/simple;
	bh=Z5WG72TmzxaH59DiiRQq6a/CdXVP47XSWLC21+Wyjyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uK9H05+JZc45+0045EfKiy81iUfw6rZJz/NwvNi0AJvCLq7C6nRoeyLMgPJ9luQ4Jj0lceTnvjIrUlPieoe34jvHyOd3EoKPgjB/XJXfU6AeOKyi7CpwIIH0bWTf92B65h8qaVXMkbs+tpzkOcjY4OGVGdBzW0ECG7kQ3w44Gww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ju9ehLqc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9Ou9002961;
	Fri, 22 Aug 2025 05:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q63FUOEhTErn/sTKAU4Tav
	VmuYnMZhfjEktpdLdicYY=; b=ju9ehLqc9se94nEpke5qsMWK/Nr5BUHYhF/Yy9
	8ZC+KQP4rrAAAdIeE3ZReU5APkyP3aG8Lwq8Ltct5ANrC5hUVvMEwgg+OaZwZwBh
	kuLwWDzAZHMw7OIOShl+pU0HynQnzNDuJiro/Zvh9KMuBMqFAqFu/koj0FoG4Qz/
	uEddGA43qNy5JxEz5EYDbbswu8A08xTKwtqrhwvRNbkdk47kKdkKeDPaqA0x3NhJ
	l9Or9KfRtLlnsjp+FsdEfCs+94Eg1dNIuJMP5VigNheycGouExVLcQUasYw0q0wc
	YhQqvEl0yghQWW8Ap5bGca9pl6hSfulQpmpe2a/D+QrVTyUQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdnq01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:02:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57M52Ms0016962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:02:22 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 21 Aug 2025 22:02:21 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next] wifi: cfg80211: Increase netlink buffer size to 4096 bytes in nl80211_get_station()
Date: Fri, 22 Aug 2025 10:32:04 +0530
Message-ID: <20250822050204.476919-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a7f9df cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=lozDUKNB1K4zCaANDOEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pmSswkvxnZm1siHC9x0VCUwglpCxkmrv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX6P3Nu7wnv9jv
 RGh63s7L4JyWNa585ar7MFfXyGMMrVzMErkkPQuOtIJi933bYR6gS+Okku3Kh/9cMjS6lVzCD7a
 q5+85/RptiNux2Gc1MTEEV9gccgGvEAWJ6WKeJZPAjA2TX1Fl/OdPMIO9evAriS6WsP6He6m7eK
 n8qHFksE5RcduoMx58TDPX6SLU5/peXSMOp9TlU4DDnEuhu8QfPteQ79H62jaCLqjk41YZ5bBcb
 MvWtcoDxJgPg9otA96N6IGImih9Jl84LtvNo8WkkK65hUgA2i8aGDRu0GptvMqaOkrur9cWrtAi
 utCAdOKu0nCogTofVHJKJ+i7BCbQTfFwEE8gKJUTFAPpCOpgF0X/pS79Y7V0HEQ0f/O6DhNezzB
 pJc4Esxkm3iTnHCDnWLZavzzVvCTBw==
X-Proofpoint-ORIG-GUID: pmSswkvxnZm1siHC9x0VCUwglpCxkmrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

Currently, the buffer size allocated for the get_station command in
nl80211_get_station is NLMSG_DEFAULT_SIZE, which, in some cases, is
insufficient to send complete output to user space and results in
"no buffer space available" error. This is especially evident in
setups with 3 links, where the amount of station info exceeds the
default allocation, leading to underflows and incomplete netlink
messages.

To fix this, increase the buffer size to 4096 bytes. This ensures
that the nl80211_get_station() command can return complete station
information for up to 3 links without allocation failure.

Fixes: 82d7f841d9bd ("wifi: cfg80211: extend to embed link level statistics in NL message")
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
While this static increase is a practical short-term solution, it is
not scalable for configurations with more than 3 links. To address
this, planning to introduce a mechanism where user space can
optionally pass a specific link ID to request link-level statistics.
If no link ID is provided, only MLD-level (Multi-Link devices)
statistics will be returned. If user space requires data for
multiple links, it can invoke the get_station command multiple times,
each time specifying a different link ID. This approach keeps
individual message sizes manageable, avoids excessive memory
allocation, and provides fine-grained control over the data retrieved.
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 89519aa52893..042cfff78bb3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7624,7 +7624,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	msg = nlmsg_new(4096, GFP_KERNEL);
 	if (!msg) {
 		cfg80211_sinfo_release_content(&sinfo);
 		return -ENOMEM;

base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.34.1


