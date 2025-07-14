Return-Path: <linux-wireless+bounces-25356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90851B039BB
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C962B3B5EAC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215B1F3FC6;
	Mon, 14 Jul 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hIO97sXS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9B23A9B0
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482679; cv=none; b=ORSOalnmKBWjYt2Tk/QIUes9vFFZB0GT+EpLsVftl3fSWL4Elbu1PGpFLp+YuIh7FbSiZK9IFaDuq6yNwGf4JsvGev0L741MjNYtkdZDufIYM2ZgiLKO96FhCixuzoBc7az5Tzl7wXPIZeN/9QlFt4XNwlP9dumO0OkIXSsXQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482679; c=relaxed/simple;
	bh=lJSfkolDdXhKresxvEnJqFKOENg+a3980DEMm24S5rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SCTK0xJWE2DsaQEVe0Cd89377lkIznBXQ+ijh6eNm4JsstFiXI4PsP9CsOkL7veMkNbFTJAAMprUaonFHWAAtkUYI/zT3qybwDcIXTYzpu//CcSRRyEdzw+485TZ8r9PWdmRDotous69jICsFMPe0xkG+ISFjDkqSz/WuWyVM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hIO97sXS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E7Qscc008247;
	Mon, 14 Jul 2025 08:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+9TeC78v2SYBndiwfDUSQE
	XCetOO/+/nZQ0eNcPG0sU=; b=hIO97sXSJiW9zQFppl12W90QdX1u+b5rOcn76F
	GjjRIJpYDLIaruEuu14we9T5XkxzwbZdBzRWWImAiFprmUdiV/MUd7q3SUYqsB08
	0ENhu7b4aLqU/RGlOq7swElDaeZm60JMWlFZ4yDUXALubkpFDtddx5OpAcT4HkYb
	UJUm8eVKagJbRwg2rVLAnAP5/PzSVeipcZjTiJQfrbO29fXgU25ZIwCPyJJa18mQ
	7xqtnWOWoHzsxT8qJweIA9yoEnf8l88USyjZA+O34/WwgJGnTB4tT5tqDqCKIk9p
	DvgFCYByvPjrCVOJc6hTD5rchsZvcidkYYOd5pwEMKYb76rg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vwghg73y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:44:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56E8iPZa001199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:44:25 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 14 Jul 2025 01:44:23 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        <syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com>
Subject: [PATCH wireless-next v2] wifi: cfg80211: fix double free for link_sinfo in nl80211_station_dump()
Date: Mon, 14 Jul 2025 14:14:05 +0530
Message-ID: <20250714084405.178066-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EbLIQOmC c=1 sm=1 tr=0 ts=6874c369 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=KKAkSRfTAAAA:8 a=hSkVLCK3AAAA:8 a=COk6AnOGAAAA:8 a=LGBCXmjPTBdmNyd4FXgA:9
 a=cvBusfyB2V15izCimMoJ:22 a=cQPPKAXgyycSBL8etih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5EATKGf1lHS2rLSwkY8UMUzs7AKas3c3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA1MCBTYWx0ZWRfX4H6hjkxAtJmg
 345taAynzdF2e6PVkBNjD77WRs7TqgIT1AKBpeF0teOxNUOAfK/LFjELVnFYs9uZIOcd30mU7o+
 9PDnuWM/7cpWDNjy8FptoA7RekS3dapHcIYUoxKlV1sfifkmEOCLUp9XyvJlBMz+zbkfZd64jDS
 jqn34vIq26r6k7VRPatnLBUXLf6w0QA/KdYPnQMwo0uef2nntWonr6Y8xQtfL5vc5ZuhzIog2Rw
 gYkReYwEJsm93PKf6SnMrOHiuglc/tCDpI270f49YWoTBiwnJXv01GxhVaFiEhPTzc4LWSJqT+U
 dPXD+OGs2bBEeXmZmlF+jy0ILOX2nQhlYzVzBm8FXMzBZx6eoLs4ZAxI0TJOC43eFfsxKGEI3iT
 yjkjfydN+OmEXRykowdTJx2wCKYK38QLJ9z5+XmHPdLmfhVhJVqvT+ngYkxEgiXhgTz1pz6h
X-Proofpoint-ORIG-GUID: 5EATKGf1lHS2rLSwkY8UMUzs7AKas3c3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140050

Currently, the link_sinfo structure is being freed twice in
nl80211_dump_station(), once after the send_station() call and again
in the error handling path. This results in a double free of both
link_sinfo and link_sinfo->pertid, which might lead to undefined
behavior or kernel crashes.

Hence, fix by ensuring cfg80211_sinfo_release_content() is only
invoked once during execution of nl80211_station_dump().

Fixes: 49e47223ecc4 ("wifi: cfg80211: allocate memory for link_station info structure")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/81f30515-a83d-4b05-a9d1-e349969df9e9@sabinyo.mountain/
Reported-by: syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68655325.a70a0220.5d25f.0316.GAE@google.com

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
v2:
 - Change the logic to fix double free issue.
---
 net/wireless/nl80211.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4e6c0a4e2a82..0cdfdf007210 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7451,6 +7451,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	struct wireless_dev *wdev;
 	u8 mac_addr[ETH_ALEN];
 	int sta_idx = cb->args[2];
+	bool sinfo_alloc = false;
 	int err, i;
 
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
@@ -7479,6 +7480,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				err = -ENOMEM;
 				goto out_err;
 			}
+			sinfo_alloc = true;
 		}
 
 		err = rdev_dump_station(rdev, wdev->netdev, sta_idx,
@@ -7491,6 +7493,11 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		if (sinfo.valid_links)
 			cfg80211_sta_set_mld_sinfo(&sinfo);
 
+		/* reset the sinfo_alloc flag as nl80211_send_station()
+		 * always releases sinfo
+		 */
+		sinfo_alloc = false;
+
 		if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
@@ -7505,7 +7512,8 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	cb->args[2] = sta_idx;
 	err = skb->len;
  out_err:
-	cfg80211_sinfo_release_content(&sinfo);
+	if (sinfo_alloc)
+		cfg80211_sinfo_release_content(&sinfo);
 	wiphy_unlock(&rdev->wiphy);
 
 	return err;

base-commit: 0cad34fb7c5d12a9b61862744e7130e9ce3bc58f
-- 
2.34.1


