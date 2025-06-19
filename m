Return-Path: <linux-wireless+bounces-24265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C542DADFF6B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 10:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA59F188C02F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CD241CAF;
	Thu, 19 Jun 2025 08:06:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCC195B1A;
	Thu, 19 Jun 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320379; cv=none; b=S4ygnWOtIMDigFGzc7RJGzKZ1HbZYRU+A7U2GoNuZXNhIHpZWhPxlkfvk45+Stln3TRCUxRmlqcGL+DOJAOY8UxOAZkPZWeZrv/CQjDMSfhmOit7SN1ZQs3vrtUDhiK0xGI6p3lY0qIv4jhr3n93ycndqGNjexdcSmf05YYkFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320379; c=relaxed/simple;
	bh=etHDW7g1zWUaEHtig4iT8cXADS3mcF4cPIsw4O+OVSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMf6oHjn6/qLhU6/GumskiHA1kk/WIWGnUHiNca9ZHbacFCP+63rHb9PFNI/YbZ+hAtsfKzoMWkSuCO5y3RGfh8asxr5r9t8EDHtJvS7vSIq5RUC6bmJpU0vTf/EBwPruIZXaFQQr/DNBFePpupvyX2MHydqM1meSmi5ZKfMRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J303qS024439;
	Thu, 19 Jun 2025 01:05:44 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47c8728ajy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Jun 2025 01:05:44 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 19 Jun 2025 01:05:29 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 19 Jun 2025 01:05:27 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <johannes@sipsolutions.net>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] wifi: cfg80211: Prevent comparison with invalid registered dev scan req
Date: Thu, 19 Jun 2025 16:05:26 +0800
Message-ID: <20250619080526.899000-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <684ba12f.a00a0220.279073.0009.GAE@google.com>
References: <684ba12f.a00a0220.279073.0009.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA2OCBTYWx0ZWRfX6+QoV88cxwnR gWXcWosrAY0C15rESqV5xBk+NCdAErCu4qGqifirw0iBsdoFo2pGigHt6jdQVEBVNDCrr9u2c6X g1lb1bRzhahs5y/CvORA08J/C5ZlOo++cR7wUvoYPxcY0RUkrfzjXM7e/RG0HJS7pyOvX0wpT/X
 fefGS21yh9U+n1JVjLtwealyrcnGZPEGVD7vwiZaBQmt28EfwDBKxoNBK5LM+dqQ1Nay3WqreYw OY+Ift0AlurSrHkDwYh1EWvhh6M2xGATQjVaJgR/P4LdQcREXsNGhNcQy5L5evRVjp+L6jrmZdx OBvNI9CZ8yopyUZnRnNOp40EAb4PLz1y72KvjCRxtIwmlAZdsIoG8TpHKGFH3Bnr+cOzCJlAmhE
 xDo8hX75Xf4aMtOyVk/7M8W/RO9qlh5jozUD7P+HL+wpIotFxg27Sqt2DsE+1iTurNbwcrlL
X-Proofpoint-GUID: tBn3wSONFwH17hfwHhu2bSOh7bGluJwn
X-Proofpoint-ORIG-GUID: tBn3wSONFwH17hfwHhu2bSOh7bGluJwn
X-Authority-Analysis: v=2.4 cv=RpXFLDmK c=1 sm=1 tr=0 ts=6853c4d8 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=6IFa9wvqVegA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=Q5VghSMrqH2S0C6_oRoA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=673
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506190068

The scan req of a registered device may have been released, so it should
be checked to be valid before comparing it with the current req.

Reported-by: syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=189dcafc06865d38178d
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 net/wireless/scan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index e8a4fe44ec2d..bfd40797e608 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1176,10 +1176,14 @@ void cfg80211_scan_done(struct cfg80211_scan_request *request,
 			struct cfg80211_scan_info *info)
 {
 	struct cfg80211_scan_info old_info = request->info;
+	struct cfg80211_scan_request *rdev_req, *rdev_int_req;
+
+	rdev_req = wiphy_to_rdev(request->wiphy)->scan_req;
+	rdev_int_req = wiphy_to_rdev(request->wiphy)->int_scan_req;
 
 	trace_cfg80211_scan_done(request, info);
-	WARN_ON(request != wiphy_to_rdev(request->wiphy)->scan_req &&
-		request != wiphy_to_rdev(request->wiphy)->int_scan_req);
+	WARN_ON((rdev_req && request != rdev_req) &&
+		(rdev_int_req && request != rdev_int_req));
 
 	request->info = *info;
 
-- 
2.43.0


