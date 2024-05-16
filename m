Return-Path: <linux-wireless+bounces-7729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976E28C703A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 04:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8FB283AF4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 02:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA415CB;
	Thu, 16 May 2024 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oD9xn1p+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3384A15
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715825960; cv=none; b=jVCqS+uqq7wR5pDKzxk2w3jzLei/ObMpj+oJNyTO+p7l9WgBfD7mQ7DORGwYLhLEoOo5gUd8QFW2dIGFjJnOzpKsxcGh1WWTUWjls1+fYVWl1FTPEHBEvMzWVHTIZFEqMa+0/lnVLKJE/9oy9h/X811EklHIAnoWpx+zGW8AtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715825960; c=relaxed/simple;
	bh=tnrDp2z+4xhAY1PA8LZlcw5xYs4Yr2XBRXKYPRiXxiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjQBMgySkL8wks8lV+Gjf8mEy27NZ5TM6c2leQZvRBE3srCsmwlKjHHHon/J/hSi6izpjYb7GsHPPezmqrkZCuVIBvO/0mwBf2lSEObQ87AS/2U3n3IshWy9Z0jYtjKftPSvHxwpXj5akTHi7GtZSUP0EcvxIXbZjpuLhjRowls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oD9xn1p+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FMom36027349;
	Thu, 16 May 2024 02:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Qs+JeCy9wW1EoDcZfzFyM0509IjCC53cLa2OzcW8YNk=; b=oD
	9xn1p+O7A7e/w/hqW6zfH//3l9A6LaNy19DxB2vTK0cGHyJcuYU1YRilX6S//8pG
	SEt2NiA9lwfSoFRuME4lYjvDN4p7OKX8GPQIE4cxVsLw9eO/UN0PUDXXVhRtPS4D
	agvZxbc89BY72GAffJZX0P57Ak9SpnGFMM1V+FRvaK/dB0fbLi28e5pDtGMqySwY
	ftCfVIe8gkUoWGS0xyLHGzegy1C+JZTotwL+phcSROJA6T9FuBeY/fBLk1uLRcpX
	EMrn+WZIQh9Klwnml1x2Re8LzAdeeoG//81rJ7qpOoS5AX7XB2SVsA8UBeO/fflI
	0dazlFoyWr6GUSbeUcCA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kvw22a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:19:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G2J7uQ024910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:19:07 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 19:19:06 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 1/2] wifi: mac80211: fix the issue that checks the size of Spatial Reuse IE data
Date: Thu, 16 May 2024 10:18:53 +0800
Message-ID: <20240516021854.5682-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516021854.5682-1-quic_lingbok@quicinc.com>
References: <20240516021854.5682-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yxSSQSgglY9JtltViEUGLmKd8AbDhEAT
X-Proofpoint-ORIG-GUID: yxSSQSgglY9JtltViEUGLmKd8AbDhEAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160014

Currently, the way to check the size of Spatial Reuse IE data in the
ieee80211_parse_extension_element() is incorrect.

This is because the len variable in the ieee80211_parse_extension_element()
function is equal to the size of Spatial Reuse IE data minus one and the
value of returned by the ieee80211_he_spr_size() function is equal to
the length of Spatial Reuse IE data. So the result of the
len >= ieee80211_he_spr_size(data) statement always false.

To address this issue and make it consistent with the logic used elsewhere
with ieee80211_he_oper_size(), change the
"len >= ieee80211_he_spr_size(data)" to
“len >= ieee80211_he_spr_size(data) - 1”.

Fixes: 9d0480a7c05b ("wifi: mac80211: move element parsing to a new file")
Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 net/mac80211/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 55e5497f8978..055a60e90979 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -111,7 +111,7 @@ ieee80211_parse_extension_element(u32 *crc,
 		if (params->mode < IEEE80211_CONN_MODE_HE)
 			break;
 		if (len >= sizeof(*elems->he_spr) &&
-		    len >= ieee80211_he_spr_size(data))
+		    len >= ieee80211_he_spr_size(data) - 1)
 			elems->he_spr = data;
 		break;
 	case WLAN_EID_EXT_HE_6GHZ_CAPA:
-- 
2.34.1


