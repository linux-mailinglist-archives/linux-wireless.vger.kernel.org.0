Return-Path: <linux-wireless+bounces-24774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4300AF5E8C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 18:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B359B5246B0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC62EAB98;
	Wed,  2 Jul 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LCSlulK2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD42DCF49
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473582; cv=none; b=HSoaz8HLXiQhMBZGZKayce2LJXUgBdbLDQzwsXg1LeVu8+o8tpE/DGr7egQwzK+cbcbE2jSmMR0oqUbhpHkdzQ8yuQOElwiaaW8iZSLNYDYi7stxSrlHHp9ZrmUZgs7oM6ek8Jxq0QvT2Iqi+5a9Dpl7cKuFsZsVW4b0piWVN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473582; c=relaxed/simple;
	bh=bsuARaHLIx81zc1ZPLPoieL2sy+uOWjt1XltEhXcUI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9Ti3b+ef2DVJ03ZohU2OkV8AIDqJR5SvL5yjxgAdEpUVJ1ABjZF+rFZqoCy1Mrf59w5cm9903f/9yDy6ozcDneyABfwKB8Epih3UqL1PzGjCxby240oTui2odam8U/jHzpXvCtkxSqKISSZVul9Gowjit3VFwD0vnSjw9AJZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LCSlulK2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562DQrIZ007048;
	Wed, 2 Jul 2025 16:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jqi40C8hYPxl42uo0lEWj9
	ktjuIsSW31TaVae7aPj5I=; b=LCSlulK2SnWSmNvN9plVF3j9ZA4Svvea9IXfeY
	Ke0iqT0yNSFtjniZzkkeK+Zalw+2aOjitxb4OSkVXs6Z/jpkImTJeZ22rM4NYLVs
	jor3DD4iEUY49S2jb25YW5SEOD3z2PXCCIK4lzzRvRgd/avvrNl5iHnkbwuzk0Ql
	lm0iC4MASbvJcuQoZ6D7GKxXt30d1gWTHT6PcwzPGgjuB246NLSVzpmK4ALk6tBD
	C0rgESWjJn6bTCIlZ/iZdPDfJtm4dbpuLvs0BMubg6eKgKEwSb0mHgJ2tQ16VsZj
	Zvy86oMU7MuqBT9Zv/1BLFV0awPb5+1j5E32FwMGNEtlyW4Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jhq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 16:26:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 562GQ7M2025445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 16:26:07 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 2 Jul 2025 09:25:53 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        <syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com>
Subject: [PATCH wireless-next] wifi: cfg80211: Nullify freed pointers in cfg80211_sinfo_release_content()
Date: Wed, 2 Jul 2025 21:55:31 +0530
Message-ID: <20250702162531.2705566-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=68655da0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=KKAkSRfTAAAA:8 a=hSkVLCK3AAAA:8 a=COk6AnOGAAAA:8 a=2JIM1VG7Q4nqncfnODgA:9
 a=cvBusfyB2V15izCimMoJ:22 a=cQPPKAXgyycSBL8etih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: j9L1xaSvOxDKhyxDmLxubWXBQv0ZYZJ8
X-Proofpoint-GUID: j9L1xaSvOxDKhyxDmLxubWXBQv0ZYZJ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEzNSBTYWx0ZWRfX8VWlHa/+zu0c
 MLOeasXoNP1OU2a+lpWDibg/cPPo4gVIIIcsdzI39NbknZT2v2Pfmn7FQRTIsnvf7X2Iv84qruf
 9//vHZ+0ZM63H7AvlvngOLkuTW5mLkK0C65XlSpfYBsmamP2qhJ8R/koxCGx0SI7P7qQjG5S0b7
 DfqpeUgd/Mk6Fr9GKVs1qDN4KGg3qbwKFCszHHn/soV7VfVOEpCxKx2lU5eYvyf3+EAoWcFDqh5
 r2nkLEvoVSVganoYnYZgFvEslCvpDUnBpb2Z7ge69cPfvZUP9bCC0KRTWng+XfmTB7EGwpxMOyz
 OMXm3iSGLlT3Ggg5elApsScDhE803CjUS3ZZwhTtZ/c1ZLu0RQE8CqeUP5NOc91qhDf8alN4afv
 ght5rcLecChXa89tVuqZMPKDdxIjLlgf9b2Tny3mEtoiD5kZv0XZwxKbXfFEYHPurx2ifSoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=3 lowpriorityscore=0 phishscore=0
 clxscore=1011 mlxlogscore=990 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020135

Currently, cfg80211_sinfo_release_content() frees dynamically
allocated memory but does not reset the associated pointers.
This results in double free issues in nl80211_dump_station(),
where both link_sinfo and link_sinfo->pertid are released twice,
once after the send_station() call and again in the error handling path.

Hence, to fix accidental dereferencing of dangling pointers, explicitly
set the freed pointers to NULL.

Fixes: 49e47223ecc4 ("wifi: cfg80211: allocate memory for link_station info structure")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/81f30515-a83d-4b05-a9d1-e349969df9e9@sabinyo.mountain/
Reported-by: syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68655325.a70a0220.5d25f.0316.GAE@google.com
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4a092da3a9de..27b3e1517aa1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8612,11 +8612,13 @@ int cfg80211_link_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo,
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
 	kfree(sinfo->pertid);
+	sinfo->pertid = NULL;
 
 	for (int link_id = 0; link_id < ARRAY_SIZE(sinfo->links); link_id++) {
 		if (sinfo->links[link_id]) {
 			kfree(sinfo->links[link_id]->pertid);
 			kfree(sinfo->links[link_id]);
+			sinfo->links[link_id] = NULL;
 		}
 	}
 }

base-commit: 28aa52b6189f1cc409f96910c63fa1b99370b99e
-- 
2.34.1


