Return-Path: <linux-wireless+bounces-29659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D555CB5E94
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76444300942C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058763101AB;
	Thu, 11 Dec 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhjwDNYH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1QE0PD9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B730FF39
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456892; cv=none; b=hDGHqnpSDdYJHPMrleOXdFZ/BJnJAFzKlArFgQhtV0QIkPMxizlCGIODiyw+qhqIrvlH071gORWuSrV17ZD0cRaNc+RKk1PeZcVb2MI5jD+NHuW7EZJ6L4T769XMuHdgZyesIwl9PxChdtDRw54v8NpStuDKSAyte1n4TPLWN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456892; c=relaxed/simple;
	bh=sm9AT2U0Zwdsu6pBfHWibFnhgLvGY2ANsxNswkhWKqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OADVvf3MqMZud6P6gblCd75rUiiFwPnkxH123izPb76j3RCi+JJY60mA5I7jlOS9YEm8i9rEJcY0yk502o0s/Ce4MAn+Pvv1GPkfssBg+P1NTQOW8dg314znR6vxq2M+Ejnl7sXYe1Czt218tCBXMJBOmLFUET6PgxFOpRetLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhjwDNYH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1QE0PD9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBB4Z3n1956152
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ISc58PBgatmdYTthqZQYA3G9f4xlobem707CIgzRO8U=; b=AhjwDNYHP/LFHE/E
	zS35KOvVA2vhipzGxrwuvSajP4F+pGRwVtJIXgSeRUfR8Tb1wW9mQrX2Uq57inW6
	SLzb14v1wKY7M05pysZFPimrW5BkXb7EZDByWX7Tn5K7+83kCP26yS6gHQQLQxfo
	/jTgtr8wrsnHjBwGioDRN0zLYyDAefQbKOmtTMTiJWHvCWGCw/H50DM6WlBdQZQs
	mqSojzKN8uyBAaItaUdgEahIPXqhojUpWYwzv5PpEKUT3uRbBZ4iHP/+csawbFTO
	h1WZKcYoE9rn1JJdF0BWlm9LeT1/ISO8PtUHFlz/bhH7wQDcyMnMQvw04sJvMxd6
	aZ6slw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayvryg8uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7be94e1a073so16800b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456886; x=1766061686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISc58PBgatmdYTthqZQYA3G9f4xlobem707CIgzRO8U=;
        b=V1QE0PD9xp971N6r5RmznNCycKyon4YofiqHqQ9E5LlvS2qDSvPqd90NXrRcR2rqrV
         HmCzzItCVDkZlPk/4ln1oprHgHilbdSdfafoBqfmJxytFMAna4YNvQ1tGnavCOOHe3qd
         m/59Bnvx9MhsafRTZkM/qynP8YgYwKfm3VLC4voMAOT15m+U7I/n4AIMGhy6ktswIHdw
         GpAePumxkL0vn1HvcZAq7oyoXMkTNVh2GXlSXmj3zea6wZ3Fa9n9bGvsrU3lUAG+xN3Z
         LCcN1jVE2SVAnKrbZKN6yxX8VqSarQibXDtaAqFcX3i1Ievff3L84XIfkF8QAzYaL/WB
         /pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456886; x=1766061686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISc58PBgatmdYTthqZQYA3G9f4xlobem707CIgzRO8U=;
        b=vnF9bLk91ESzDQQXq5+c33xRkfuNW03MOzdOPL6YAEZVDeB4eF+5HfD8GLDDt0MEXm
         OWZs2nC04QKggFS6/B/pggN0IbYOOIJhnluWHGIyKQw/6zRlUhjDT/hVSjUirqPX/AN/
         I6rTwPRUcn3QSrEq/oD+ViZ7dxOpmx9UVzejWtsYjWz04a2EV6sPvNiYRTdtI5Xec4Z9
         737Q/l00eOTgZOVsbq1WK2jSFXwufB3j9lrTiE8Wz4+N+CVJN5NLzJA28VT8mhVLku4U
         Vk406vlo+zIfMeP9BTxhUKI2u+9/HHqbqC0LKz84Z9dW7Vtsd9rAtxwdUn3yOyxwcsc9
         sMLw==
X-Gm-Message-State: AOJu0Yyq+qHOQAS4SM0WyBHeCtP6QJW++j8Cy8lbu5hccyWY3/qLXRE0
	K1PeURoCkCVSiZpsYXCYph61YXsv6s00DG0gB7Y9cmVT8RLeXdiFgwSJaO+eQyiEcv+MpOdh9e6
	2aCYFuEA12VAFjs+N4Hqw78JlpNkdyfTm5gdOMN48BcAjU0KYbc+4vQT1haXtm4TiGbVldg==
X-Gm-Gg: AY/fxX4Q8TPwkYsS8IM8BTsrA75btUqBZYOv/A16y3+Jo34K2O2KYKpRF7y8QgyGoSr
	PkftRxkFqt50pnT+z5eTYAyeVX1wMtiE9/7KeILZ835a+IQN6LyrjFao0wR3A+xTff2PB7eSEmt
	XiX5ipXkilg9GNTWWQNapiiEsqaPSuUi0NSTcHT+YgR3ADcyvjLey3hmlaBsvAgT3j1i4P9oEGK
	KM7cZdcoDOiUCNNG/6yzYcbQSCT6yPH+foE+EvmVdSo5PyY+C9fhdlO3K943r6xcU8902vzm+Hx
	P7DoyM7Jhj5bzAHHPKh1CCABNvCkBecf89Av9V1x3PCA8y10K2sXuTEvVO03Wa7Ze7OYbIvuP5p
	908Yrl9RQuapoq9NdgiozzvHH1cO12kAkAG5jn003uQ==
X-Received: by 2002:a05:6a20:918f:b0:342:fa4f:5843 with SMTP id adf61e73a8af0-366e299c7e0mr6413624637.43.1765456886451;
        Thu, 11 Dec 2025 04:41:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUk70dKK7zVNJYexf9nc5oRnuHRG5hoKhcORHiP2NodLYJEyJsyv1d+E+ZgGs3ZynBDG97tg==
X-Received: by 2002:a05:6a20:918f:b0:342:fa4f:5843 with SMTP id adf61e73a8af0-366e299c7e0mr6413597637.43.1765456885915;
        Thu, 11 Dec 2025 04:41:25 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:25 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 05/14] =?UTF-8?q?wifi:=20mac80211:=20allow?= =?UTF-8?q?=20key=20installation=20before=20association=20in=20non?= =?UTF-8?q?=E2=80=91AP=20STA=20mode?=
Date: Thu, 11 Dec 2025 18:10:42 +0530
Message-Id: <20251211124051.3094878-6-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P9g3RyAu c=1 sm=1 tr=0 ts=693abbf7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=NJNI8byFtPwFAtEfovoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: bVdhQMm7vRfw0gO8znBLZGhvF1oPzeuU
X-Proofpoint-ORIG-GUID: bVdhQMm7vRfw0gO8znBLZGhvF1oPzeuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX9fxrYdiKIEhh
 XgLQ5hGTG98Afl5bY6bQ0dtPRtzPgoMdi0zEZxUvnTRShzPvQ/veaY3q9COaXJch60J/JJHA1sp
 gqxQ5+V3KIOoSaR1w7E5LEXa+Wrq5CFmF+/f4aDowuIhgBP2XO/Db8p01mrJeiTsGtkEqJjDh22
 hHVNeccBzoyTEuEi3oFPBWk2EwNrIlASOdrWlG4KS00PHmsmDOxP9hKnEOQBbmLwj7IPAjAAv3r
 ve7/Eg53MTGWPhE19aD1Fuiu7OAYhibOvxuZYTQqjF9ucHoqcQ78D3VFeKsW5sp7vrVc24wssct
 uH1fuNUBSf9nODsOiaShcicv454yv/OjZmlnUofDoD0DabZHLkrxHPO5qRDE4Qiao0k4ewVkz/U
 3DB5okpbfZA+yaDkS+LkE3G0hVS4TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

Currently, in non‑AP STA mode, mac80211 permits key installation only
after association is complete. However, Enhanced Privacy Protection Key
Exchange (EPPKE) requires key installation before association to enable
encryption and decryption of (Re)Association Request and Response frames.

Add support to install keys immediately after authentication, prior to
association, when encryption and decryption of (Re)Association Request
and Response frames is required in non‑AP STA mode.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b51c2c8584ae..2044eeedfa8b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -680,12 +680,29 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		 * association has completed, this rejects that attempt
 		 * so it will set the key again after association.
 		 *
+		 * With (re)association frame encryption enabled, cfg80211
+		 * may deliver keys to mac80211 before the station has
+		 * associated. In that case, accept the key if the station
+		 * is in Authenticated state in non‑AP STA mode.
+		 * If (re)association frame encryption support is not present,
+		 * cfg80211 will not allow key installation in non‑AP STA mode.
+		 *
 		 * TODO: accept the key if we have a station entry and
-		 *       add it to the device after the station.
+		 *	 add it to the device after the station associates.
 		 */
-		if (!sta || !test_sta_flag(sta, WLAN_STA_ASSOC)) {
-			ieee80211_key_free_unused(key);
-			return -ENOENT;
+		if (!sta)
+			goto fail;
+
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_STATION:
+			if (!test_sta_flag(sta, WLAN_STA_AUTH) &&
+			    !test_sta_flag(sta, WLAN_STA_ASSOC))
+				goto fail;
+			break;
+		default:
+			if (!test_sta_flag(sta, WLAN_STA_ASSOC))
+				goto fail;
+			break;
 		}
 	}
 
@@ -729,6 +746,10 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		err = 0;
 
 	return err;
+
+fail:
+	ieee80211_key_free_unused(key);
+	return -ENOENT;
 }
 
 static struct ieee80211_key *
-- 
2.34.1


