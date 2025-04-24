Return-Path: <linux-wireless+bounces-21978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71360A9AD80
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF0F464AD9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1C27B500;
	Thu, 24 Apr 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P4o+m+0G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E127A92E
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497948; cv=none; b=gxAjol9v75KCNOG65qj6qfyh+Xz3yqTq9lo+CPf2gHlQHkCvdrPMpdkaq9wczT6ZJnf+fM35CSkEOtrskaknJTNLE7/4tc+6bCCb9tirYXcdWByapvatVczClo63rpowb55+MyFSy0+xoPSDDwduda4MI8Ra+JG6/5vcO5EGhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497948; c=relaxed/simple;
	bh=ol9nrlnpejJEhOlmHwzS5aDVTj5QqmPiCD5MWOOxZYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OO6QN2v3rnYQM/xO9xMq2syP3O/WnzbDtDCfp9qcHzS9+GSqilXxcLY9SbuXAdmzf+oR/azzWJtm5FxgmC9x5FpqzV1eDJ0oJNFrlr+etqHn9l59l7Tz909gyZ4ycna8YW4z1uT/q7Q7CKg7Kf3ovfXibRU6L3MMTYYo/LhB2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P4o+m+0G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OC3IOR011699;
	Thu, 24 Apr 2025 12:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UTRvcQ+fQc0FSBayEils1u
	CV7BAeQFoRdQqPdDv3EWY=; b=P4o+m+0G7p4+nHr9p+pLV+npVc+kSfGfgMvUbM
	hC2xuJFdzqlfDSx9w+BQVR6BXPjAw1GyEZf22W2DEkUvG+1rGvRfAev8pytz+5lK
	/nyV97qwtYTvH1j8BGzY3sYMZv8qIwzCxKr6jxG5PWvi/HbA3BwRn6NRSJZqxR/l
	o5ktuIvVny8unWNk88AKOPpeQ0LwlixpoEn8f2PN/eQI5mizGhZvCbxOllFiulgG
	QD3X3QkFFiPAw1e82OWb3Xewi1tIzopZ7x5WZEkukEAaf7wVRCf+/C1hRovYE/1K
	qvNhOc8c4+x+lbrHoUKFqWQNhnXG9Mt6t0TQu1UhiSA8azFg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1njk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 12:32:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OCWMiW026811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 12:32:22 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Apr 2025 05:32:20 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Date: Thu, 24 Apr 2025 18:01:42 +0530
Subject: [PATCH wireless] wifi: cfg80211: fix out-of-bounds access during
 multi-link element defragmentation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250424-fix_mle_defragmentation_oob_access-v1-1-84412a1743fa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC0vCmgC/x2NUQqDMBAFryL73YBJk0J7lVJCzK52QZOSFSuId
 +/Sz4E38w4QakwCj+6ARhsL16JgLx3kdyoTGUZlcL0LvXfejLzHZaaINLY0LVTWtKoTax1iypl
 EzC3cg0WP12QRNPRppNb/5AlfbjTrCl7n+QPeZgvufgAAAA==
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Veerendranath Jakkam
	<quic_vjakkam@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dqHXGJAJTNrUT9vQysqEFtzsucZ2hRaK
X-Proofpoint-ORIG-GUID: dqHXGJAJTNrUT9vQysqEFtzsucZ2hRaK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA4NCBTYWx0ZWRfX8tNCRz0TZogX Thq8wN1h5+nuK3OeFji0TvRlDqZwSSJh2BZm4LCo7TGdbQ/DlJcBbMmSlVmdDzs1AcM3ApBg+9k wUV6HULv0aTQApGTqSiMEHY2c7dBfwQsH4K1IIkQL1iQX7m9XG7DzapUDMWeGbZiS04fWldvw6Y
 r22VXA13SKsod4gspGqit3ze71UHFBm5Fa0luIDZ4rNHJcV61gkZreNQcaza6xeO4WTp2bSkRzV a5zo8J+QbWgqaSEx8bVJeh+v2crz7fJYzNRFbe6biuopzuF6Uer7SyjaHU2u6kNwuADzjxcjNmT uvycJO/N694D1IQKefl2W6Bc7rie7YJPNIUw/dAp1IX2pL05fogWWSP3M8QQLKpLbr4PEygvVUx
 u7q+xESmRWf4UqP/DIoI1a+9eRKevHrVrVWoQNAu8YzxI4huZWRM97sKT2nF3YXmR7CQhNCR
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=680a2f57 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=ErFaxs6tVtXXMqI3DZgA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 mlxlogscore=946 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240084

Currently during the multi-link element defragmentation process, the
multi-link element length added to the total IEs length when calculating
the length of remaining IEs after the multi-link element in
cfg80211_defrag_mle(). This could lead to out-of-bounds access if the
multi-link element or its corresponding fragment elements are the last
elements in the IEs buffer.

To address this issue, correctly calculate the remaining IEs length by
deducting the multi-link element end offset from total IEs end offset.

Fixes: 2481b5da9c6b ("wifi: cfg80211: handle BSS data contained in ML probe responses")
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 9865f305275d..ddd3a97f6609 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2681,7 +2681,7 @@ cfg80211_defrag_mle(const struct element *mle, const u8 *ie, size_t ielen,
 	/* Required length for first defragmentation */
 	buf_len = mle->datalen - 1;
 	for_each_element(elem, mle->data + mle->datalen,
-			 ielen - sizeof(*mle) + mle->datalen) {
+			 ie + ielen - mle->data - mle->datalen) {
 		if (elem->id != WLAN_EID_FRAGMENT)
 			break;
 

---
base-commit: 175e69e33c66904dfe910c5f43edfe5c95b32f0c
change-id: 20250424-fix_mle_defragmentation_oob_access-65951d4d3a1d


