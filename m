Return-Path: <linux-wireless+bounces-26295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3FB21F6C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 09:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF517A391C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1142E284C;
	Tue, 12 Aug 2025 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdltTWNy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34202E267A
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983431; cv=none; b=XwRUsnWJEFpadt7as2dGRCW/iKScU9O1CHXRimPJuhV4+xppqiQY0Bvvh6KT791tuiZgLAQkTdCXtql7aaDBm4EI40qc8pJQx/D9aRbesOZ68YMBubt1/ty3nl3Vat0/BuZ5JLKUhPihSP8epQVw1RdN0DjWg6fiyBlVn2qBQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983431; c=relaxed/simple;
	bh=sXf/tzHPxiEkmS3fi5HIa7z0JKn7aB250VO7t0cEATU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yf3z7Bj48T7ysGOFjEmm4/kxHHm0YKKGsbNOuPvxndLQbW++Y/UIw4vCsIHAhgCWTd8m5So1vw1hxTVp0TfV+nTD1s3LucIDhi1ZkFQdS4f3aESpzcif3JpU9xucSuCDXnq5QsxrSKhEg8QD5CvL1ZZQtzwTEnaBjRJD2Kfh7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdltTWNy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5YK89018311
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGEZ67kEmAoqpjitMp3Ll7+BdbW0GOjiSQsfDHXAo68=; b=HdltTWNykpnMGAnK
	PMUVu4Iw/wQoJjMbHQogvgyAqiPWwL5e3EO/ALuhT91iIxj9qQnLq4nPHKHGp2mb
	A981Z/AvdtCnsCa29HwLyRiPcaEGQC5hY6NygmrTW0sY5U1lF4vC7hyylhJLfNVM
	idGe28OpW81/bg+H69Ud3Qbm2ebnhawCVMYdj5gj1zP0THasVPhJPUNcWGB+LkFg
	Mfohv8WJQLW4kbib932MFKEyj29qLol4rWsDIioULw0kCeWHGjQFpNcxZ439nsAo
	iZQvYhk70NzoGlC08CYHK+b6i5Ni/SBHwWPhLUEcYHyJNAQs6L5oEiWBuxR1joFV
	Opz6Og==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g75rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so4968884b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 00:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983428; x=1755588228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGEZ67kEmAoqpjitMp3Ll7+BdbW0GOjiSQsfDHXAo68=;
        b=lM2MUx1YcTh72y1mLcwca6UEly8MfZlUA7tvN2vo6urM0Mc5o+v6ZpCUy2iqEkLPEj
         xwJpdztywyGRxJiyKvSwg9REu9kEu1IDZKo7o6y7FiRsxQ9rYEVVFrwQIUYNROMU0fWu
         HrMoLrmIpn+7cvStrYpnX/79SbhHB6dH5eAkbpz2fRxwHvybyZhfwh204ar77cRyhTZj
         38v0b0DPp6Yq7mLuEl6YkIgb5PUrmppk9op9nuXfjKAAjFx0531axpCH8BhR5jc1wOx8
         CdarCpvPgz7jGSj4NHC26PtzGEATXuetjx5BHPk7X+fneSqj28e1x/Fz8e/ftOBgUdjA
         u5ow==
X-Forwarded-Encrypted: i=1; AJvYcCWCIveBip/CtPm87vwOxWRQiynqRgXw5du6WbJ+aLbqsvisYJHg6NkqLRWo4+u56E2nooa7b5x/4JisxHetlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PRG7J4gfqyTmE537njTM3wSs8idK2K5ziH6BBNugIDj4v8Mf
	TBqtkS9nfEZR323K3lWtsODzmeoQI2ZGQh9740NDYfPPpZctvwA3HcJSdFiWx7TYjADRtPydAvx
	9ezuJVl+iti+wxExXXn15u9qGwNcArjJoNA/p0PkkKglo6g6sDtwq/ZM6kR6HdMmJ0XzpScccf4
	wHBw==
X-Gm-Gg: ASbGncuqXgBxEeFpBWPPcAXeJsNtBGrylcxzzF/JnN2zd8p1SscfOc5kv8ai/+KsCzo
	WT1s+T6YZoLBGFEOOapDgLu4eR53POwQYc2zxfL2b4M2FRfCYQuWaV/bM1lVxvdL9P6Dnufvmu4
	dexvqyemxTi1dDdXqUKNi0Ay5kgZos+gedJfvXRbX9dmEra+1BnGzNHFEqgfsrwtednn0NIGQmG
	Ywl0DNbOd5fD7b0wOXtsYoEA5lgybjGcPde06WuG68IrHrzIHlEfO3F0FN/4H1plAFS49+A263B
	N9Kt183LzXWuE113GT7R/WfL3D0so0IkGhI4NOMjth0uqz85QAW11lqTdK1F8l0GbpfKRh3v5dk
	K+BxZ+ZMxlVZwsRKtndpS0y4HEvW2eWVeGSmBuv4TqeVLrBFrnkOSJA28kiDoVhyo
X-Received: by 2002:a05:6a20:a121:b0:240:1a3a:d7ed with SMTP id adf61e73a8af0-24055200eb1mr23629430637.41.1754983428035;
        Tue, 12 Aug 2025 00:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhSrnMBPSIIBJ3L8/BeBaB8z/thQRvfAUKzIFAMBHroJSoaanlapaoH1eJeKq/MvA30JdaOA==
X-Received: by 2002:a05:6a20:a121:b0:240:1a3a:d7ed with SMTP id adf61e73a8af0-24055200eb1mr23629404637.41.1754983427572;
        Tue, 12 Aug 2025 00:23:47 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm24547338a12.52.2025.08.12.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:23:47 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:53:30 +0530
Subject: [PATCH wireless-next v4 3/3] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-3-383ffb6da213@oss.qualcomm.com>
References: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
In-Reply-To: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689aec05 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dNCVw_J0pHFwvOnBF_QA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX17YA0hBF/xJS
 uxR0kf1v4uNf1KrBA3ygWOSBMDRQY+dUkAKZw/25McfnKfw9CQ7HarWkI1UBYr7ksHVXWo3NHjX
 jUFnRuIMVSZoqhRz3xkL5nCrl6vOrJQ42lSrZK/4LNvvsUWsaG4IxJ3HZ02o3yfET7EZNj5nxlB
 I5kw2GC0jb0e776xbT/4kciV5avRaRO51sv9KCqjhKtcmiHflpC/PpzUq+UnRKv7lHfC44926Wg
 399t3ED4umbhZWSA6tqCFJXgv8OoAT5IGiNKinmQBw20xlBjyrjSOEhdRpae32A0GYCknzXkRUD
 ve9QEIpMkxYs/Ncn7mwtYN8DBz7QHmVif8GmqQYPRVKMG7CxJBl+gC0096ofoba8LQAI55PhcFG
 JZ/9SMoJ
X-Proofpoint-GUID: 6bZdKUOd6xRyQPF6zuIGHe4EyRP5YsK7
X-Proofpoint-ORIG-GUID: 6bZdKUOd6xRyQPF6zuIGHe4EyRP5YsK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

Commit 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan request
during MLO") introduced a check that rejects scan requests if any link is
already beaconing. This works fine when all links share the same radio, but
breaks down in multi-radio setups.

Consider a scenario where a 2.4 GHz link is beaconing and a scan is
requested on a 5 GHz link, each backed by a different physical radio. The
current logic still blocks the scan, even though it should be allowed. As a
result, interface bring-up fails unnecessarily in valid configurations.

Fix this by checking whether the scan is being requested on the same
underlying radio as the beaconing link. Only reject the scan if it targets
a link that is already beaconing and the NL80211_FEATURE_AP_SCAN is not
set. This ensures correct behavior in multi-radio environments and avoids
false rejections.

Fixes: 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d4100d046442a51a0baf42d6ab3b921302d307f7..fc39a5bc2ccbd0e6fd1128c6cd422f8b2c3c987b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3001,6 +3001,9 @@ static int ieee80211_scan(struct wiphy *wiphy,
 			  struct cfg80211_scan_request *req)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
+	struct ieee80211_channel *chan;
+	int radio_idx;
 
 	sdata = IEEE80211_WDEV_TO_SUB_IF(req->wdev);
 
@@ -3028,10 +3031,20 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (ieee80211_num_beaconing_links(sdata) &&
-		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
-		     !(req->flags & NL80211_SCAN_FLAG_AP)))
-			return -EOPNOTSUPP;
+		for_each_link_data(sdata, link) {
+			/* if the link is not beaconing, ignore it */
+			if (!sdata_dereference(link->u.ap.beacon, sdata))
+				continue;
+
+			chan = link->conf->chanreq.oper.chan;
+			radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
+
+			if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
+							       radio_idx) &&
+			    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
+			     !(req->flags & NL80211_SCAN_FLAG_AP)))
+				return -EOPNOTSUPP;
+		}
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:

-- 
2.34.1


