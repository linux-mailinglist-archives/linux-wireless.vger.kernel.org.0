Return-Path: <linux-wireless+bounces-26553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB2B30E01
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7B7680604
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9612E1F05;
	Fri, 22 Aug 2025 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ir0dA6Z9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9E29E10F
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840775; cv=none; b=FU7RgG7gyN1jaSCx/H8KSjfNT+HTFq4eF5PPoi/xTbxBW4h4yE2vD1aWTBxZD3kGPkXOs3iQpE3cSHkrhEgDjZGWx/wfu8GcrzGdY7sb3KQiJYEYxOmXQQTpd2StLvwtMW9L8xRgGENi2SlTmbh9JRMwyHWQeDBTsDwXKlPZPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840775; c=relaxed/simple;
	bh=jN2wr65rKkf91A3BOEk9khhPdE8JD2JtqWPRui0uY5Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tPW/04Id4KXgGifLz4tj9G3zsx2dDznUEEoG+L/brFn0QlLTKmLWFl6HUDkwZuDA/KN6j0cj5+YDSi03wM1NrJb7ihNlXmrkYtpsqtrfY3B5SO1GAwhlEtFI2QpVINkX85mMittS8F7g/463llnonWDvDFAOBpoa0kd4z2iSvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ir0dA6Z9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI93Ad029780;
	Fri, 22 Aug 2025 05:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9npfb/Ff4NPoMCHh7BhT87
	xsdTa1iBG63GLUAugDgYI=; b=ir0dA6Z9UzpXUn0Ch3ODcl5Uv4MI2qrD+/gR54
	zIj3frmupT3jh1vnDvRVgJn1wByf8jQ0tt32yZ15jaoYlkksDyvGZOewBW39H9VW
	zYKBnEOSwHM+D9SFbWjT3d9XHrFc1Qtr3utSydpYU8CKjictV9i7KuAlWcuYR+/i
	cjqvGpKlh5Rod4iHFwA/BszxEQ9Tj5Oz78Vhd2oYm3RyhC4X7sAa5bfW2gvMXliu
	gDcb9vS8VW4KqXIykgI9tfEquhufj492rzu2AYE8Xg1aLvwyjyacrjbgxNPaS9tc
	0Z8l23OqoNDkdDBj8vBWM2RCaFseTkDSULaHy183hT75Oe8A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a7yws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:32:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57M5WkEO001897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:32:46 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 21 Aug 2025 22:32:44 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next] wifi: mac80211: fix reporting of all valid links in sta_set_sinfo()
Date: Fri, 22 Aug 2025 11:02:29 +0530
Message-ID: <20250822053229.519836-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a800fe cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=jKj4B1-UR3WfVeMF5ukA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OT99gsWjLuq9m0duGcBcNhGrObiC468g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXwRDHNNR32Lm3
 zZjnIhKEOgzyoiyQ+onT8b4nsZRS7VxgDHx5VrvRTcMmuiooeK1IZct1XEPk9CiLdRGjyc5PlTc
 HHqrgSe4wYRr2UlErcd7DcsUSAxyP9yBAl6OCs2+83vmy9MHIP9Ey52cWgSoTbzKe/aZvqPJ3OE
 t0EKMKpNM7Wqf3F5rfE1qD0rJ5+ZxDXIgLLtmkz56j0DDlNyNRw6O2Y8S46ZM2Fo/ewxuAdOzyP
 K4q9iQK74RXoN5dz+/hQSAt1YJI5mTu3LWSWRasFZJt8AUGcWO0KguOYCJodVcX20sbDxhucFEL
 Hro0jzMA0KePH3S4lWHw7uchSPsOgbtmWrYrWYAC70zHgHn5D/w+6qD13UyfUME1pk8n1vTM+GG
 L1MwFGMYnfZ3Aqvjw8d5Q0af7v/WGQ==
X-Proofpoint-GUID: OT99gsWjLuq9m0duGcBcNhGrObiC468g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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

base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.34.1


