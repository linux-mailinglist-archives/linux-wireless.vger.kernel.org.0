Return-Path: <linux-wireless+bounces-30404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F19CCF9151
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26F130AB4A6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8F345733;
	Tue,  6 Jan 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8kWbLGE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NzfeyEgJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F13345731
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713125; cv=none; b=sgQd31wmTQwveaPg8NrxRLB/MrCgcMa77xSpXmcOreG8LeWrOvRjq8d0hQBKpkltvzR9CHawflq6wQcpIvHDxI4D11L3BGxRXQSPEWkt3gUHqT2nmsp4AgD+j54n3TcvELWv5c3MrZ6XMdB+XeJCOt3pXiSK8bBGJGDJ/wO07Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713125; c=relaxed/simple;
	bh=svNzjMNjb8Mqaf3eVANV15nBqPBed3pMqotiUZ2VDBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVQb+N1J2EuImGXnACzDox1hnO6WG64HIxM7o1iaaMxrQ5soBw0hMC6y3xAdzK89yYRLuC6MZgu0CxZ2bg4K64NVZonTKT5oIwNcc6mg8XiqixE4WUXqxAYFxo6mEFCuLZp/B1ErfVBiBaBY6lu8VSe2DRT/Pty1w7yFA28Kg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8kWbLGE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NzfeyEgJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606Aiu853271952
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=clR2v4v3SzD
	h7FiaefSEqRWAogVMdXmSoly/ZmH279g=; b=M8kWbLGE1ErZ0aE/06Zitt7zL0w
	En0llzIddVPfEREaLV9g+Me0SVPXUHAGMGdWBdc/8H4ZrqKLwcYLwKtkYh2RsYYp
	nzH5vrfwtTdTTFzAnQzuFU5UuUsoul0YNihONUpCXDyepjJI/USHNhj+xLnzJrtH
	D4b348ol8d/XOXEFD4u0X2JgnTzKbIZejIpQ07mP6S91ir6tkmStiGFzs6sUNU5G
	5c1h2YnYAP4dWugr7bivEar0RUmDrC9saexf1FYzpsTzgAACNIZg6V5SQt7HqvYh
	4dVmGX3BX5Kyovhw7ZmYgI8u69wDyJLv3YGqqukQ2wkTKqp/eoeOf7Qrk4w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv03r4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a13cd9a784so11023585ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713122; x=1768317922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clR2v4v3SzDh7FiaefSEqRWAogVMdXmSoly/ZmH279g=;
        b=NzfeyEgJ3t1xlmizlp1NJ8kpOu1zjN8j2CuY23zuZNOYA/Ed6FFhy7+XTw6oJcbzQE
         kgLTMY7eR99MeeIO28hESSYfFlDZwGKy90K5yNpIGEmZ40/uq9o/rAfPTANceIDv/Ehs
         LZtN38wp2NqAiRziIL+flwXpzenglAFcDU536HCySPgUB75ySgrMaGDPn1W/sAMmX6gX
         WRTewoHr+chLSZtqnaB8t2cBrjEz0oKW16cu5kX1PcI7JWsr9yyhk7K4fMO//zeBb8Wi
         jBbWGZ6ev287osUyb/oE1GbrthY9/owhhdlpYuvj3/0ecVwZFk+ze8gk0xiLl/qUJe+B
         1ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713122; x=1768317922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clR2v4v3SzDh7FiaefSEqRWAogVMdXmSoly/ZmH279g=;
        b=iUW8paTT0/tAq6yNWKFpf7PxGRKE4/8fVjFSfBCtOoIUjGbAeOiY1aEnxEIsa+GfUT
         +KDnLozkMOeYdC0+CfPQta653Mry4aWhWBJ1TrjyCTlfx2Eg8LYU+lQa+w1eeeHWOfmd
         yo6qW6clcZ9w5/aqgzjLdoc2NxQkWSWDuYjg5eqDxUIwI7QyK9CvuEH1YyHnotRM47Xh
         0vCI+hK8ZtVN0iNOcoL6/U8YZ8ufFaLwYRWs29mgukMUd3AxBfxK/1QR5qjfIxziEKIB
         oyxO7NEA2BkY/1erxs8tPe8UT0yRrwH79BXoW9wzMsVfezDPOghFtYhpP1skgoeFBQUg
         TRRQ==
X-Gm-Message-State: AOJu0YxTlBcyNQUi01MFG6MT8EixKvCsRlEPtzxt9szXfCTQFB+J7xvH
	//N2DSYHtLsoQquBKOL9xhGOvzMMnTGFuZYTw9GHXo0AhyyZvTpkNuYAlUQeOsIw8tNzrEEHlZY
	OAHfs8uJT/rLR4ZxW9d236AOyTkfxDt3NP7JDIiCvhpqYh7XWuOHnXQwUCdLqYVIf2kohrg==
X-Gm-Gg: AY/fxX4gvVqjWl9NqZN0Xi3OJldSsk7OCkKUlSwSIKr7X4b+fCuf7zDWGd4FQSNviZZ
	/gRce8bmWpQk1akrniLfizQtJTFLYvCuvBwk8p9xInmijd1ismwzwFFq+dsUQPijFPfy3HPYFxJ
	B959O7zMyVbEyc3/BvRzs13E3Q9HVMLLNtFFJmEwaGrM1WF+/QIoMe8Sm1FTW5YKXdDPaqMzb9u
	Tgl4/14N+vy3ui3K8dST0oJGhVEUjUJaYqRswJq15mHze1M580Nw20OoAFDjqRDzgHbA+MODs/W
	gDGLtcOU4Uq3+tJPokMvUuWbD5Su+qiNwaH/gTP3UlJV3qwaFkE3d2qyawU3p4Lt4auLXzy7Ata
	tBY7x8J7b7lo/Ei1XWukQOUWKE37tanhjQVc5/WARaA==
X-Received: by 2002:a17:903:3585:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2a3e2e15ebemr32275915ad.47.1767713121451;
        Tue, 06 Jan 2026 07:25:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO8M9BiFErjiVdjacL/cc0ssqTzLekY1F+D6gQ6/E2P1vPc1+LM3IuuC9rrPcc6qmu8XkHyw==
X-Received: by 2002:a17:903:3585:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2a3e2e15ebemr32275685ad.47.1767713120922;
        Tue, 06 Jan 2026 07:25:20 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:20 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 3/9] wifi: cfg80211: add support for key configuration before association
Date: Tue,  6 Jan 2026 20:54:57 +0530
Message-Id: <20260106152503.223216-4-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695d2962 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xf8xhSOHqnjMiTY4RNsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 9ad_csxtuLQhpKrfuaW27-nYcx-K9tPB
X-Proofpoint-ORIG-GUID: 9ad_csxtuLQhpKrfuaW27-nYcx-K9tPB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfXyoI/1+bm8YZ3
 uORB1MpgmQBvBRKIkVLCWFi2XBQsA5mf1I+gcEGMW6gSJpi1/Y5UlEgUU69SXNUIGMARRqSGBAx
 WnJzi9in8tNlRv7lh8CqV8U3Sk8xxrh3PI411SDb8u3ykZx9+7YBwaQgdHYVlg9PxHVAFNxJB/7
 QBm6rQMjx24cWlD87+FfhNQTwdYtZMnd9VNk7m7AQNosbfi+VcuU+dv4l/buUSCmbcDrPordFjO
 gadBDcJ8cg948K6GHpIszDgiLrQ5tOUlqFJ9SfbccCsxzUKToEWAgX/3Zb+wcdBEGLTJU150kO9
 o5eHHN24aDk2jHkjKBAPkuGAGkr4kdkqJlgYmFz1pHAUveD8q5DX0Fg1SSulmvyCG0Riuh+8beG
 tVnyjJtvaMxJwywNzYZv68v82y76MTYFDJMw5PAKz+47tHIckt1sy+1xx6BJ0sspp0/7jQfIurM
 HEYQF5lU+QOVIu8MsUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060134

Currently, cfg80211 does not allow key installation, removal, or
modification prior to association in non-AP STA mode. However,
Enhanced Privacy Protection Key Exchange (EPPKE) requires encryption
keys to be managed before association.

Add support to manage keys before association in non-AP STA mode when
the NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION feature flag is set.
If the flag is not set, reject the encryption keys.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2ac31a1d4ce0..c464c449cb0b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1675,7 +1675,9 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 		return -ENOLINK;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		if (wdev->connected)
+		if (wdev->connected ||
+		    (wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION)))
 			return 0;
 		return -ENOLINK;
 	case NL80211_IFTYPE_NAN:
-- 
2.34.1


