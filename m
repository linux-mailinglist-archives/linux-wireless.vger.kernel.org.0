Return-Path: <linux-wireless+bounces-25169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A94AFF886
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 07:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7C31C84314
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF254284B4C;
	Thu, 10 Jul 2025 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nn1eqoyr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37196284670
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125684; cv=none; b=UjaXsddmCJbGe46C5Q3HsCRCCfQIz6r/xdezd3ENN+sEULLTvmWNDFyHsMI2NrcT54UMlMcnjUsNCgctP7OCNIMlPtINF/HLjYkxYFiWuWxnn96tBbhI2038sM8BTyJ8QSjCo/6IVnLKPIJsFHfWVMG6KEPwghwa0LNbQHbi0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125684; c=relaxed/simple;
	bh=KdhOmcqZw17rfbyHNFm0oN3Z6N7aipfZaCObSJQDtFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhN3bc6pTQMR4EdoKpHcrgb2FVOXfkG7DtPZHdjbfqHmTdJ4eOpytzqveaI19iR/dGxFCHooc2rW20DtLkRAsLhMZkdLFkt2XUh5CT6GCrJgAy2jlHAHLhRiu0SsncB4H8qdaGK5FN1HCAbYlEVr5khmhD1DjwrD7pb9XuPjutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nn1eqoyr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A1N3m9010003
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cG0txvja0S3tG5mbOE4vdGeMWc8J0yoXe8fr4obx5Qg=; b=nn1eqoyrdesHGWVk
	l3BYuzfjV6l6WSsL3GwwQCHWfhq3MuINouIB/ncuBr63ZucNH+NjgmWglYjlUOGz
	/JEVzRa59tqW18RZQ1UbE8fUVCHwqCCwMxpyPndekTY4ChE0Gm5nTsNf/0oQBhcF
	xo/Z1KOwOzEV73AsLKKfTPutjCSqnfQeQYj3Bxe8znYl1JV/myxI4QUCT07y2IMV
	40wYgBB1ZkFAitaU7xGLb9aqM+LTAZsUacnAkEC0YZ0XCQ7DJAtjEhFK/Qve9QIa
	W8VCNqwb6KzapeFSUjLCLwLK37Te16GaUy1TwvmtAPxQcJd/GKC8cCvPjgGCTII9
	pjdQkg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9q3kry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-749177ad09fso272039b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 22:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752125681; x=1752730481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG0txvja0S3tG5mbOE4vdGeMWc8J0yoXe8fr4obx5Qg=;
        b=lUkIrq0ObEsy737jslEh3OVdCbKJehGm4Ar5rhOQ9gExFEdKZBiKo9mI1f8N3yXIpl
         xY1Bz/kR6udQY64GcfTLP0CatqDA/PIbuN7uQNkjHaq6dgtd8GOprtMki6NEnvQ43Gvw
         9AHJnEKQMbkv6naIH5DeFX4fQnO+AryViIUnNEQZ5no2u28S8csYq5l8BkbXm73qO90R
         CH4hDh6oZPPbNzYJ0KjTsc7U3wa74bxfUklKegTgruqyB89P9yIU/UL2h0OcPdZIzNkp
         KkzeNGNJKKWcGzo8bxTGjDIJT+j732z6yhapIryjoKnrmXXvW7Y8HaVtGfgBg05LkEt8
         hIaw==
X-Gm-Message-State: AOJu0YwtplbUn0FtRLfzeed69mnBUYY95sugIY7bzXlylztbTGuwMOaK
	5JwKGYhUf3hPJ/regBbIY3xbfUFMznzlcRoVtKKOjiNN9WdsZKC13fpdrKvtf9zX6GamEdwNr2C
	muSkxrRdxi7W71BRsH6D9+2MydbW+aUFY0Snga0projWQlNOa91ufp+eQcIBi7oX3Y26wQJXOEm
	X6Ig==
X-Gm-Gg: ASbGnctCgNWmdpq76ALfjoqNWtaHeri61UY6C7R9cs25yAVWyZpPse+s8QfNLlyJO47
	c1DBj2M2e6X/e9Lm0LcmotWfX9hi+OIG/TJoNmgVAmLB/xxC8a7EC9yoOXb/s8zi6SGS9MLVrFJ
	60tl/4lqzPYn0lsIC4lDLpSwp+WTBDJtE2H4L1f5WExLnFIpRbwWT56g9CamAz1SJilmWyEYSim
	x+bg14x7o6kqrWonDVYMoC5FTfOzNBrfpwGDr+LtXYVJguYzSz4X7qqUWQ+1atKMYQcCkDP7ZS+
	sOOPkStEaSfwmSrRczvhwjr2TYz3nEGYjgwdf/Vq35ln9lbP/DUsBs6Pzyz0pjeO3QYJliF7tvw
	WraqxWdEYi/AjdNphpqrCFFbyxLY4DIS63TtH2tbtfQj1L1Y=
X-Received: by 2002:a05:6a20:2451:b0:222:1802:2ddb with SMTP id adf61e73a8af0-22fb85cdbcfmr4752812637.8.1752125681275;
        Wed, 09 Jul 2025 22:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/1Rcg4fjjKZRHzzSG/rGYx8KGtmURVnMVRfuCyePM1sTlj7t7mM3dkEPhKA9W247oKkPfYA==
X-Received: by 2002:a05:6a20:2451:b0:222:1802:2ddb with SMTP id adf61e73a8af0-22fb85cdbcfmr4752771637.8.1752125680883;
        Wed, 09 Jul 2025 22:34:40 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5b0201sm1014043a12.31.2025.07.09.22.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 22:34:40 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 11:04:27 +0530
Subject: [PATCH wireless-next v2 1/2] wifi: cfg80211: parse attribute to
 update unsolicited probe response template
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-update_unsol_bcast_probe_resp-v2-1-31aca39d3b30@oss.qualcomm.com>
References: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
In-Reply-To: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Ioc8NJ2ItgSJfJh1x-r6sq7rjFTX3Dtt
X-Proofpoint-ORIG-GUID: Ioc8NJ2ItgSJfJh1x-r6sq7rjFTX3Dtt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0NSBTYWx0ZWRfX6dwQolkbUVIo
 NSerXQy1PVv27VRvFUnpX/W+J3yVALwHQwX3IHzAPF4UGOZTHnCbvGUJX3Ry9gceRh0UYfCDa3p
 iCFcVbsWDE0UPJ4S6VES1PFmOnO3KJpBCJNS2DJLdvN2IY30UCCmrLdkzYrlYAZmoQqf1JAwrbR
 mANULxQVOjbXGfzR06LjL4EeFSzO15dpBixr8sNjSCbA4mz0Cb3uetnHQGCoU4FDsbofu2xUeoh
 +jsAuttloWduG01WHf/WiETsfYfXrRz/ciQoxjMBCkdUefdBdScFcHuPeq5NttjGIJ6KpEeKf+P
 irtXCMleBclIFjdLeFAty2aVd6P2OzuCUSKJKFw6JK5c/VtUi3MtN7qLyCGLia2M7R3qux4TUd1
 5FvC04a4PR+E2WvhKLC+TVMH2aiVEF7OrUZ+MoeM6E0ImIENXNV/gDYoB2w0YvshUoJOciey
X-Authority-Analysis: v=2.4 cv=BM+zrEQG c=1 sm=1 tr=0 ts=686f50f2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=E4CoA09qZ1gvW9aZS_EA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100045

From: Yuvarani V <quic_yuvarani@quicinc.com>

At present, the updated unsolicited broadcast probe response template is
not processed during userspace commands such as channel switch or color
change. This leads to an issue where older incorrect unsolicited probe
response is still used during these events.

Add support to parse the netlink attribute and store it so that
mac80211/drivers can use it to set the BSS_CHANGED_UNSOL_BCAST_PROBE_RESP
flag in order to send the updated unsolicited broadcast probe response
templates during these events.

Signed-off-by: Yuvarani V <quic_yuvarani@quicinc.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6ec9a8865b8b082e235493ca64adf0fc60ec0175..08eec6fc820aa50d09d9bb047ee7dc96e256bc70 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1526,6 +1526,7 @@ struct cfg80211_ap_update {
  * @n_counter_offsets_beacon: number of csa counters the beacon (tail)
  * @n_counter_offsets_presp: number of csa counters in the probe response
  * @beacon_after: beacon data to be used on the new channel
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @radar_required: whether radar detection is required on the new channel
  * @block_tx: whether transmissions should be blocked while changing
  * @count: number of beacons until switch
@@ -1540,6 +1541,7 @@ struct cfg80211_csa_settings {
 	unsigned int n_counter_offsets_beacon;
 	unsigned int n_counter_offsets_presp;
 	struct cfg80211_beacon_data beacon_after;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	bool radar_required;
 	bool block_tx;
 	u8 count;
@@ -1555,6 +1557,7 @@ struct cfg80211_csa_settings {
  * @counter_offset_beacon: offsets of the counters within the beacon (tail)
  * @counter_offset_presp: offsets of the counters within the probe response
  * @beacon_next: beacon data to be used after the color change
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @count: number of beacons until the color change
  * @color: the color used after the change
  * @link_id: defines the link on which color change is expected during MLO.
@@ -1565,6 +1568,7 @@ struct cfg80211_color_change_settings {
 	u16 counter_offset_beacon;
 	u16 counter_offset_presp;
 	struct cfg80211_beacon_data beacon_next;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	u8 count;
 	u8 color;
 	u8 link_id;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 05538312bdadc7545b771f22d8aee14cd1edf5a0..0468464fa49fcb73f88099f8c4f66b54e8adbe09 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10992,6 +10992,16 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CH_SWITCH_BLOCK_TX])
 		params.block_tx = true;
 
+	if ((wdev->iftype == NL80211_IFTYPE_AP ||
+	     wdev->iftype == NL80211_IFTYPE_P2P_GO) &&
+	    info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto free;
+	}
+
 	params.link_id = link_id;
 	err = rdev_channel_switch(rdev, dev, &params);
 
@@ -16794,6 +16804,14 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		params.counter_offset_presp = offset;
 	}
 
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto out;
+	}
+
 	params.link_id = nl80211_link_id(info->attrs);
 	err = rdev_color_change(rdev, dev, &params);
 

-- 
2.34.1


