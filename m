Return-Path: <linux-wireless+bounces-24070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A515EAD6FCA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C36178AEA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7512367BC;
	Thu, 12 Jun 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyddZAyY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC722F432A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730299; cv=none; b=X5jAQ6iC+zch9sz3Fm9PVas9rOV4Imt5An5ELpT98b5c33oUBF49LNXXbniegvxnNncw3DyfRkY7OlkTxQtHWif7osx6xhy3vAvbzVvo8RIreekQax5CDDZlTPzu9d9In8LoO4ge6c9/noVKuXZv1W212dLaltcOdF8GZnRkwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730299; c=relaxed/simple;
	bh=gUNupGepM1WVSMap8KXNT9bP2CjzqWLKV0ztkGjCTRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iYdSozXlZlaRgXIfYMWI0wK3uLy+o2JCfPuCC67aYB/LbOYHm5sA3W52gi7kcNrFMp2EIJUtB1BEXbNFLEics08NC9btYlUl7i8JknSHDAO7WgqxAnaCZd/hlECYtSKuUqIBY7m3lvTI5dpZxZ5WcljAHbep1B2AvM4QvwjuQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QyddZAyY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8pSlU029716
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=a+4rMuTii1JkiDDuWIDdg9QzjymHuS15HI2nOtnUfsg=; b=Qy
	ddZAyY4nPPb/gW4HBt+8hD5fEypoSGPhNEPSnP+6kcunJ3XGOCiKv4oaouWlPXze
	ezDe+FP3+XuEx0+TR6UUcxA7LeHH0N0kxEJFjw4PKul4A/G5HMnlnuMTKUE19Iqe
	eGRLsNC45sZsQs+jp73H/rFXltTGLicEJVDpE4IHd877wvtruVjX5cAv5PcDc2v3
	N+qfI+ydl5sIi9jOpaAJjLCfa28ak5nuOMmIUaQl6g+28/9uUJ4T5tvjGHfIsKwo
	DEaKXo0mMhfyJAp107Oo+cHclceho0vNuCj0RrPFnRB0E2JQFBvgVG8/LGIeAiJU
	NXXX37/xzkaTkS644NiQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474d128efs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7391d68617cso1659140b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 05:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730294; x=1750335094;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+4rMuTii1JkiDDuWIDdg9QzjymHuS15HI2nOtnUfsg=;
        b=K/ur9wBaAFL56ptplKbrr/5Lm/eWS92KuK7Hd/xf3TJs5ycDjaImyD0cThFZIbMlHB
         A6ji5nxbK0i8gvqJ4b5kxKvG7wjvPNeWOZzxEjuIhNbhUSaqPGoChzsDsQqRyCBbDhDh
         LRMTrgcbjoxdo8xfXFew0uDyf6m5NNSkNeQoDMubGuRXspEowc47S0xuo/YvGtPkFK5l
         xpyzEsg0CwP1NHMSeYZyKEHfea+WSV9t2QhJuXiK86vtMgdwcKUZIQPb97JGVnIzZMFC
         ktrWWuEC2E8HbAw/ubToVUm3z1juApIChDkKTg4H1JwkAdWc7drR/8uHI+oDQ5SVgNnY
         lthA==
X-Gm-Message-State: AOJu0Yw+UFCAF5P948r3HuSqGHzdb2NgAu8rVTW7HnaQy1s+XxSXhqHP
	JI1z5f3CPVgEKVbfWw3a/2+z7vh+YPrZimkxfb4Uh2J7yV9+zlUVe0A0cRzbtAxDzmYzmFqrIcB
	JF0+4dZp/WdVNcm++0Ptt/0AlNAbUCBNybU16iWYT4EmdlvOu2RzEgVY3lHLdaUNT3PyuQXzkqD
	D/Wg==
X-Gm-Gg: ASbGncvgRDAa9sSJKVrkxMiiZ5Zlh0swUd9UPO/U6ZTJQEaGz7hxAltZRDXlb6cKQVp
	WHpvwK0Wr8XLVK2yhz2xoob8F5SV9PFdqRVR+B3IdP43VQv4AKZR6xhfkUBCaJWQvg5jOiHfvQ6
	oGjdrzwKhJeNSr+A3p5kw5rSNPNsOTOGLSwjpM9xQa41Kof5NYiSgICXfvI9MvqQN2M7f4HAlcw
	7BECnYo6hyBsgWGOSbSKZfKC74TfFVbLQL7XDodDs3qej+XSW4me2YYCAa06xXYlYgfoZkntjak
	F4YIsU340h3BQXEHrqwSq0BeuYG0FHYwkMyLdaAQzcSoYg+JK5h4lpVLNWGQutXEKmtI3dLEthl
	2eLREMPx6Sxz8buBokBfCvPMU6O4K8uvM0hEGwX4mXC1Ymi5a0lHK6ETr
X-Received: by 2002:a05:6a00:1742:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-7487cf337c0mr4142703b3a.12.1749730293882;
        Thu, 12 Jun 2025 05:11:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRbHr9q5jfCMz8iUPZ42irQlsWj9BNXo8BttjPRQ167qDe4cEZSXvdGPwf/UPvkR3kTmGO+Q==
X-Received: by 2002:a05:6a00:1742:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-7487cf337c0mr4142665b3a.12.1749730293435;
        Thu, 12 Jun 2025 05:11:33 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd6376366sm1189405a12.68.2025.06.12.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 05:11:33 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 1/2] wifi: mac80211: update ieee80211_rx_status::freq documentation for multi-radio
Date: Thu, 12 Jun 2025 17:41:26 +0530
Message-Id: <20250612121127.1960948-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: IqFtav6J-hlVePDvoDXS5Xfvvizbdm1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA5MyBTYWx0ZWRfX02OUd8rz8VB4
 pTqRZAlJ4jSuPxXasbef/vc637qZCEo9DS01R1dXtmz0uKavpQDAGLyGMt4CseYJGnZksD5VCFM
 YvA+ycz6tfB3GnqSaiMDlWcohhaILQK/vyL3u+OUraNnTYKbNxypnxWpA2PpHNdpYfZaOz2ndYm
 tj/ebcWG9MPBVRNXpXhKxbNQfAaSZy9AUqyF9SAE2i/yJEUSOD+yD4doTez2mu4+7/j3wzb9ldO
 IxuLZp7fXQgtVXKz8NJFF1Q6wExm26szRrEM0ZZg31q41Hq/VRuZP5nAeSF1qv5b75CwHc/Jl8G
 LVsF2u6SK+Q32FAX6speCywTulv8oDVuXfHglp/i0YnuaCXNNVeuh1QqS7luMOgA9qhdObhFO9H
 Z1cfzk/0s9BmdgxidNs70WAi1JCy8wTNFp743na9feQ9pBCEcCWz0jMV3Z2nMU5nxRrkPI8J
X-Authority-Analysis: v=2.4 cv=GYkXnRXL c=1 sm=1 tr=0 ts=684ac3f7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=G3GIQwjkmUm1iQ8NZroA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: IqFtav6J-hlVePDvoDXS5Xfvvizbdm1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120093
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

With multi-radio device, it has been observed that the group-addressed
management/data Rx frames, which are actually received on one band, are
getting processed on an interface running on a different band.

This occurs because there is currently no check to ensure that the sdata is
running on the same band as the frames are received on before start
processing those frames.

Update the documentation of ieee80211_rx_status::freq to make it
mandatory for group-addressed data frames in multi-radio device.

Drivers such as ath12k and mediatek(mt76) are currently supporting
multi-radio and report ieee80211_rx_status::freq in their Rx frame
indication to the mac80211 driver.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 include/net/mac80211.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 82617579d910..9212c2089638 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1612,8 +1612,10 @@ enum mac80211_rx_encoding {
  *	it but can store it and pass it back to the driver for synchronisation
  * @band: the active band when this frame was received
  * @freq: frequency the radio was tuned to when receiving this frame, in MHz
- *	This field must be set for management frames, but isn't strictly needed
- *	for data (other) frames - for those it only affects radiotap reporting.
+ *	This field must be set for management frames, also for group
+ *	addressed data frames in case of multi-radio device, but otherwise
+ *	this isn't strictly needed for data (other) frames - for those it
+ *	only affects radiotap reporting.
  * @freq_offset: @freq has a positive offset of 500Khz.
  * @signal: signal strength when receiving this frame, either in dBm, in dB or
  *	unspecified depending on the hardware capabilities flags
-- 
2.17.1


