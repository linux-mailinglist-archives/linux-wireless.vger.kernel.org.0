Return-Path: <linux-wireless+bounces-27004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E0B43904
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46881C27C43
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928ED2ED151;
	Thu,  4 Sep 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XdgXuLZC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9E5661
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982481; cv=none; b=fiZU3HzPcrfBKWly6nZhUCOf++TgFnee3SQxx47CXFkiqiXQ+A1y4AFGcVrn7MB+Qo87ShwY15zuPN7GVXZ8avgVqLx1ro5ZJbuAEJZJ4St0nNDL2JTU1y++CpmOMspPaB6MwwM3qoGCkERbndF5P7uKu4OvlzQqgQPt7GNQr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982481; c=relaxed/simple;
	bh=gdEtOpXMfCFwJeDZHvP3GAarY59iePMURXQuni+YSZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dd0DfoY7+uMVcqb443Z+zuRmnAPB4C+y1HkusesfIh1/50QtSTejUVGpIXefrsj23eyn2d6iBPQFw7TFkqcx2VSDxVBsZQ6HB6XBrqRiKbguxQDNtqBBCfXrk62wicn1mjrrfEQ2A6BMuYSZzvlY3oaJkOD8k4VvDsMXUKIurg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XdgXuLZC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8RG022986;
	Thu, 4 Sep 2025 10:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PjY4LtY7OKwHWG/TgHGW+/
	HXP0sxUn8IwZ2Lgf22kvw=; b=XdgXuLZCBbyUQMug9dA5/8rBZLAitR4QZb4QFA
	7k9NyLevMud1VabJD2Tb6B7F1kaaVpU4v9eEplbLL5bzpUt5BQpA4jXm8AssIKNr
	sqGrBfGnhjIOEBoKICRdYHSnVu4kKreIxkJjBHSdb21zv8kgKaLUWXJ6wl3NkyYV
	zaA5m3b12MsvIEt2bHqR/2dm+8O4Y+8SOj2ZYwX2nd1S8FpMjXUQrCxtAHWibTlA
	J1QK1DJcRiFNOyICQO66tr0yb0l+I5wzmvwCCY03PiwAsVgsJerUhJqX7DUapdOI
	cwk0zSkg2/bP66CE66hYe2+P8HwXxypm7eEUmrFDud1LhBVQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eqak2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:41:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 584AfEp8012380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 10:41:14 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 4 Sep 2025 03:41:13 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless v2] wifi: mac80211: fix reporting of all valid links in sta_set_sinfo()
Date: Thu, 4 Sep 2025 16:10:54 +0530
Message-ID: <20250904104054.790321-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: UTvjgbtYnQNODgZwtsxV8RffLoX4cnhE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXzOoC6mDKvqJ6
 tLn5TIOMIbF7mz+UVsVF3UzR5zc+dsgriYeTTHqLaZzho73RETn9Qab/+31Ayfo61ran5Q0TxXi
 FKCLeTtrfesx49Byaj7C3ZanV4Ds0JuMDpoPN+yxXtt9NCfZMyA3ETcy7zOYUmJJQp4u0Uj5SVH
 BnyXhZ+Dr7QBHHfjOTPlmIOvHZ952dcdG3mPhidbxXZuXfxEN0sM0BJy1vzNl0t59811+NDhocC
 qXPmtmCXW1KGmNKxsS2Cg4lq0MnG2PDHzLENpAloBMz5eemDTJ7AfHgDs/E9q4/fwER69DExjuJ
 zV/iqJYxxFMQeUltR3YlZ/cX4OfYS1Zp6jP0lRH7jxNUwh8srHB1Y8dlY2hMBjSCmMEThJAE5Hi
 rOLCDqsm
X-Proofpoint-ORIG-GUID: UTvjgbtYnQNODgZwtsxV8RffLoX4cnhE
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b96ccb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=jKj4B1-UR3WfVeMF5ukA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

Currently, sta_set_sinfo() fails to populate link-level station info
when sinfo->valid_links is initially 0 and sta->sta.valid_links has
bits set for links other than link 0. This typically occurs when
association happens on a non-zero link or link 0 deleted dynamically.
In such cases, the for_each_valid_link(sinfo, link_id) loop only
executes for link 0 and terminates early, since sinfo->valid_links
remains 0. As a result, only MLD-level information is reported to
userspace.

Hence to fix, initialize sinfo->valid_links with sta->sta.valid_links
before entering the loop to ensure loop executes for each valid link.
During iteration, mask out invalid links from sinfo->valid_links if
any of sta->link[link_id], sdata->link[link_id], or sinfo->links[link_id]
are not present, to report only valid link information.

Fixes: 505991fba9ec ("wifi: mac80211: extend support to fill link level sinfo structure")
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
V2:
 - Moving from wireless-next to wireless.
---
 net/mac80211/sta_info.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..d6854dd9549a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3205,6 +3205,10 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
 
+		/* currently assigning all valid links to sinfo in order
+		 * to iterate over all possible links
+		 */
+		sinfo->valid_links = sta->sta.valid_links;
 		ether_addr_copy(sinfo->mld_addr, sta->addr);
 		for_each_valid_link(sinfo, link_id) {
 			link_sta = wiphy_dereference(sta->local->hw.wiphy,
@@ -3212,10 +3216,10 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			link = wiphy_dereference(sdata->local->hw.wiphy,
 						 sdata->link[link_id]);
 
-			if (!link_sta || !sinfo->links[link_id] || !link)
+			if (!link_sta || !sinfo->links[link_id] || !link) {
+				sinfo->valid_links &= ~BIT(link_id);
 				continue;
-
-			sinfo->valid_links = sta->sta.valid_links;
+			}
 			sta_set_link_sinfo(sta, sinfo->links[link_id],
 					   link, tidstats);
 		}

base-commit: 27893dd6341b929f87d45fc4d65c5778179319dd
-- 
2.34.1


