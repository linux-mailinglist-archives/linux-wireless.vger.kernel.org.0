Return-Path: <linux-wireless+bounces-25170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CDAFF888
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 07:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BE65A4284
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 05:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC55F2853EF;
	Thu, 10 Jul 2025 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVGMJl0a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBB284B56
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125686; cv=none; b=AanbdVv0pvrEScVM4n14bgNOfOgD9h92EkAb4sS1LXH4PtdDqf+FL/SVVqvEdK/ss8KEDlkw9D5Og9j1+vwvu1X5Wjc4za6ElctLoO/fzqWVgd3hVAM/tdvwEZv1J05Pf47vjYrhOGcd/i//RgPu7DuQhKQ+Qy0N41Uty9hYTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125686; c=relaxed/simple;
	bh=TdkwTNIzAwUJoAPXjj02yqITZherri+LDBhfwYcnBn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tz02vBpDVt7Z0bP8mAn2fgeohSz/F384eGZQQecqBhPuh1GUBHAq73EP36DrS451/IWr9lCPnti9G/IPT2J9XVczhQPBtCLQDr02uLZQWNKbtkGkdHG7Ni189zaw4mgIeyrQ66e4PbiEmYdOuw+G+tEYOhEs5Nl9AAM/x2IxzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVGMJl0a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A10Gfl015336
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=; b=YVGMJl0aYIazx205
	TfnfO8Ym46e1okVefOv84OJvWQQA8baC4GICAU9TMiIbAdTeh8qhoAjSPqGv7Lcg
	5LO7ZKLBMvPg0hPUVbQa8ama5A56+ZWh16PQbaTaKVTRu2rHPsSynpZCnRD96xVS
	aDspfTGMAICzayWOxb/xS38ZjLiz1jUjGiVQBvr8H52QupYKjdsp7NFFYFblDLg7
	xaP0NCKRb+ws2b4vcydBHhUgQ2TIbno77wyMSz05VcupTPWWwDkkFxLHltJoEaTR
	RFhFaLeEa5nwh5q+gZoQu6/Dke6dStqweShwdzE6pHw2Qh/I9xw0lLcEmaZeMejv
	bVqWWQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b14hce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so519482a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 22:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752125683; x=1752730483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=;
        b=RlxzhjpT1RkjxZXhFyslDZ4qNlpneYMu7Nb1tLgpgx5ovih0sHW02SVcE0MR0a/7Vz
         nRmZMilZwyCljnhmGekC4tOR3JsVrU/10Lci77SCtmWpzJ2pLLSGY+4Zx4aytPH+PLS4
         t/LPEMKnWT/zRd0+Xe6ASNJ1U1SCefifSot8HCDRvhzUgN9r52OsbYw4bFeK7H6IhIfX
         to0gQIrzGCUqzzJL6Gl/ioaxlkcZVlNarXQrjVy6TgVKElNFMdnjaHcfIYvsU1skLdv6
         +aPxjsxlz+ZaR1GUGGMxdkWELo9vyCIa3ur675u5I9L5l4WVpnxrGKMRQqeW0ikWJ0sX
         3l9g==
X-Gm-Message-State: AOJu0Yy2giTekgfuJ7HgmIoxL27azqZWhJ9vvYcHTpisExuQGA6lJ1Xy
	vylPWy1fM5q1NcQt+ni3D4B2O1oQ8UsFR7U3VF5PSdWxx/vihwqizqtkbO342p0F60yKcKe/WHT
	azvQIjgb+2zxQ0MlwrCd1WcR70Geo/Nt7AVRJZ/3X5BmZJ3eag2HjKIVbtllb1t76O/sZGQ==
X-Gm-Gg: ASbGnctu7RtF8gW2R2qxWlzOdghSzZ0WI9cVEgHvpUFor9lfmZHr8LCC9pldPanXK5p
	ocE8N4OnpesEmDj0R+7kK1rQn3k8TSbgIeiYmU1Z1RvzKiShT2yd3hQJ8PfymzbTR+K+gbiLOfb
	XJ35ub5bPMDvTpjbbvDGYDX7HgDHHjyCm1wpjJgunccVhPfET5W2AfaPoFO28snfyh8h3aUK7qs
	Mbc51SDrN5zLRTkGZmymNGFdBUNwzedBexJ92U3G8OD8/msNHz72qOlKkBNvF8uPGwtlAiBOGaP
	SvvnjFgEbIgCXMi/Eh+xiHOcl9xHcNW6sBa9JRM7IYUAnLE7Wj3N6NmzyBD6/tNxxbpErLDw2Nw
	uaJ6H8+WhZ2056vJHaUsxcJ6fCjYHgRsomssu/1r6f2EqXzw=
X-Received: by 2002:a05:6a21:33a1:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-22cd5bff24emr8481487637.10.1752125683378;
        Wed, 09 Jul 2025 22:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg8seO7i6KNpDs6X6DiLrB9L4Yaf86lhSFTop+1D/GBVnAJAqrD2tlTFsRBoCy4upa5ILMxg==
X-Received: by 2002:a05:6a21:33a1:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-22cd5bff24emr8481453637.10.1752125682971;
        Wed, 09 Jul 2025 22:34:42 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5b0201sm1014043a12.31.2025.07.09.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 22:34:42 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 11:04:28 +0530
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: parse unsolicited
 broadcast probe response data
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-update_unsol_bcast_probe_resp-v2-2-31aca39d3b30@oss.qualcomm.com>
References: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
In-Reply-To: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686f50f4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GDPEl8sVpxXbRvpnLXsA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0NSBTYWx0ZWRfX5eG6i3/bYiF7
 hFlLcTjr6c577M8Bm3pKCkm81ipewCyJAuQbfXq8SuyMkwSHX0HUXcnsSHEnxICmJZhvjzccQoD
 V2b/jQymTKABdkuv8GUNHAJgpF/Bba+XWOVNV49jT7cMo1f+96ggp8PZAvS2vLYcjUAgn74yxlI
 /kvZQlCqPN4KFWWkz4ZwbdsRIAi1DcnXJYAZyMl446pfTshV+3QTq8dSOa8Zke6BBpQRrEe/TEP
 yPaRZHDFO7v5mFnoaLQHtC3FltDfUVGVg/8++dcxBgEbuQH1Co0DZJijddL62e9adxEerKfSDSo
 LKMtf76XHdI9cdpUgdkkcplvSzxWTTj5fR/wZwcOl67aUvffbPT1f/Xrhc9qMVHYl0PnS6tCVqw
 2hWJgJJT6ksaiwP31Swjq0cz3apFJXed2Kx58Ia0ZKXAjpjp/Hu0gTnI47EipHz3USoyXRny
X-Proofpoint-GUID: J1G7zvfGW055mHG61ZaoT4lAcFiPxeEz
X-Proofpoint-ORIG-GUID: J1G7zvfGW055mHG61ZaoT4lAcFiPxeEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100045

From: Yuvarani V <quic_yuvarani@quicinc.com>

During commands like channel switch and color change, the updated
unsolicited broadcast probe response template may be provided. However,
this data is not parsed or acted upon in mac80211.

Add support to parse it and set the BSS changed flag
BSS_CHANGED_UNSOL_BCAST_PROBE_RESP so that drivers could take further
action.

Signed-off-by: Yuvarani V <quic_yuvarani@quicinc.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed786c37f946f9c4af820c15b5922d..cdecda1bd07b31cb7d8bd76eed074ecc2a828eb1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4173,6 +4173,12 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link_data, link_conf, &changed);
+	if (err)
+		goto out;
+
 	chanctx = container_of(conf, struct ieee80211_chanctx, conf);
 
 	ch_switch.timestamp = 0;
@@ -5114,6 +5120,12 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link, link_conf, &changed);
+	if (err)
+		goto out;
+
 	err = ieee80211_set_color_change_beacon(link, params, &changed);
 	if (err)
 		goto out;

-- 
2.34.1


