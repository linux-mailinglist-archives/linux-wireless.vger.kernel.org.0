Return-Path: <linux-wireless+bounces-30817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C2D1E5A7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 288A23016930
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F72BE629;
	Wed, 14 Jan 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msdIqaF7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KgW2t562"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43B392B95
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389579; cv=none; b=ieCWBEiTijY0H8FY8DZYd+RB+HRG5qOHubqYW2bXwMOV+C5zVuVXN67kMgyO971eS3+42Mn/S/Uh0yMWgc8gKkPEnT+jGwt2WR81X49flnaRhWSm7Rz0MBDGF+Yl/yq+8GEZJYgdqoNrwV1wPAacHyljdKoW9lEEpLrJk0CylRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389579; c=relaxed/simple;
	bh=P933qCv4Ly3m50qfnl+y7qDthBh7WBpAo+lT8weg/0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZR/6UuX00zJ7YQYcJQG3GIo/AlPJcWxLTw5EakdgqfamQ6DhNydO2XFI6YPVcou454qgvgwJYmSqNh/YnBMoQpbaoECIQU9pMk+lNCHUh57uTAj3znJCoDuecbW1kqwNcvGtZ+mm1IqB1HnTJ1Jr/sobRjRINzSOv/SdDG512s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msdIqaF7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KgW2t562; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E85qhR1943072
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QA1WosboFIk
	TJBIBWbAIjlO/fInalGq803/kPppN7E0=; b=msdIqaF7sRGWHDCKQp/SpxGokUM
	NBibF8smdzBWkEqRTYOiaLkNszdGbVmCZgvDC+2P02u1HFmGdU2PGzT270IBXh2q
	oE85hGeEiEu1xy88wAoWhauGHq6vHdPlsh7YqhLvmXqQ4xfSBpJhqOk9gJvO54tS
	ZAG8F7pLK/tZvB/fv2iXg8akPANJXhwsGlzLXuSVOi7ddV1/XMef14uaaJhhtBJU
	k7M7ZczLtX9rWsBl56fNqgrsFRVC/EfKfU5lf1Q20KgmohHriDUJyv5fdVknyHuP
	2uPiqQXJ1qMBgDvSrFHEIo8vFf7DE2/JS8tsrT4BjT1U2h0YOAB8lI9Cd1Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp7b6rrys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c3501d784so7977245a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389576; x=1768994376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA1WosboFIkTJBIBWbAIjlO/fInalGq803/kPppN7E0=;
        b=KgW2t562ypN/gSJN+aFxs1CdktMesQ+hnJBOxFIt30nvHYSaUFK+00LiySEU/XRbIg
         dpWAJTu8NXE/V411uf1bIMFy/yJu6k1SaP0YYndDesbh8zCaHcFk+XeU0O0F1PQpRWIZ
         6nCKEXBZmQbCxKkpRZeZGnHc+pxGBG07GVRVxpUqp3n9D8lJ0WeWDXxUmKwXlDR4WQUU
         jQhrpkpccPVVXqZULhqVxP0VUHwIvCVHgRxTESXe0h7VsFaNcwvWqVoOndaGZUEjWNRa
         plyjhKjFMxkilrX4EEiOaS9eooaZUNkI7idZCmn17TiWGKPGp5TmtH2s5gETDluUGcRO
         wBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389576; x=1768994376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QA1WosboFIkTJBIBWbAIjlO/fInalGq803/kPppN7E0=;
        b=DCcxHTlG/XdRaIHrjjPBdZtC1XO4cw/Qhq5H4z4paJ2KrrnAq0lZbdJOVtSL8rjRwk
         lEdytkxCJ1iOwwd0JTX9AQxhqFUCIrOG+Y92wPNaGda44Wa7El0BJx+jP2YdTHZjyi8t
         pbzMM8YoqucuueCzLMfR7v5G0o98OvHi9PnQOt5uuzf3RNhzhCweARvGiSXCRyaB/rdc
         uDdKMvQCvwcRk/4Wpwy3RAwQBtEgcB78nhERSTnKjrNyre5z0735LU27DnIvbGhGPWac
         Xye7vfVdvqlbF/lXBwvGkAThd4UKmFtiGBuTa1wihAkH1LcLNNd0d15r88mnTB2+gk37
         C2UA==
X-Gm-Message-State: AOJu0YyG1kf2YMrXuQa9ICmDUDSsd+2lL+FV9NFz1QuhLzHuNiXUcF4t
	Hrs1SkqhFPNBY1u0jkb6i+pxrl676wUY/77yxubzYynX2Vi7jigkM4BwPeOBXA75izCoAjogOLB
	rP93r0fHSXSCnoMz14Sz81EIYQAoavY+lDSmauJKnw5JNIkWJyLOXr703x/+O45Or1Xxu+g==
X-Gm-Gg: AY/fxX7W3WCZ19TfLzFHUTWD/XdAVy0U/HyPgf1Dh/mQEYITtKIMoqJq+xw3ONbB72C
	Cc7B0yqJyZnbrLD7268w1Uum6Jb2JqY7e8bnBAy2gjslHYPVkSKONTw50DR+/tDa8oApBDn2FBh
	m9M84ufSba2K6XzgpyPipISVm8QLvYKldSw9eRtK+S0xQtw5WWNe/5gk1Yln2f6RjS/Do0JYVQV
	O//cxoJQFuVlShQw+YDvW64YiqwbRt/zj32DN9uxcV/Nm0gQVz/U5R+J9F84Ad1auRIzJF2Y3Ia
	SBK2BysPve3/o9vtSkZqPzOONa6Jt/s46S2NG/4zMTgyxGgkGm07DN1tWJ9P2WwgTvqgZd9FMVy
	cIirgzyoo1cdGdkhXhw/QWA7ALsPQ5lRHhBFShYP7dw==
X-Received: by 2002:a17:90b:1a8c:b0:343:684c:f8ad with SMTP id 98e67ed59e1d1-35109086397mr2097832a91.4.1768389575704;
        Wed, 14 Jan 2026 03:19:35 -0800 (PST)
X-Received: by 2002:a17:90b:1a8c:b0:343:684c:f8ad with SMTP id 98e67ed59e1d1-35109086397mr2097814a91.4.1768389575196;
        Wed, 14 Jan 2026 03:19:35 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:34 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 6/9] wifi: mac80211: Check for MLE before appending in Authentication frame
Date: Wed, 14 Jan 2026 16:48:57 +0530
Message-Id: <20260114111900.2196941-7-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WIlvn7KyVtoIcEIZtwqaeCLVdi-e0rkP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfXz5UEZSRu4TuK
 SwOh+j4xYMZukM65RDnso1IWEdLNPHgSQXk5IS8OSnjnWpakhKep/A2vIt7MFvBRyfTUlenGJEC
 sjk0hTont7UDrHx84itjtIKiZT7XRvvFJHm7XVUAwB+KJ+njE2AeFQexNoRjLiHCKjS9tFyuRLq
 0HppTZtbTbCe66f4lhm7PlrmMBP9zk6xCBHhgRr1UxjdWlJwJGTIDj0we+ae01FUrTGLuan6XgQ
 b4vFWSaKnL07qyS357x5OewGpPbLfTRyclm5zk6m9JZWQLvLMvAsOJF/2UUlq1wWFc2No0EyoG+
 ugMhmdd3e0Vsvnv92ainHjqR9n9s1ljK9TeVyT5GJ7PpYx1uMUmEDSRXTRGxbeaWn5V84FYsBCz
 YLWtFz/XwitZ8JLIaoJWHj73KgSKcYoSK1VJlc06uelyVH6mSMXrpyGQwzgW+CQiGkrIEhrL4pf
 2KDzj/sZ7JuxnX5uQJA==
X-Authority-Analysis: v=2.4 cv=W+w1lBWk c=1 sm=1 tr=0 ts=69677bc8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nsG_Zr0jnLD6Zk_6mugA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: WIlvn7KyVtoIcEIZtwqaeCLVdi-e0rkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140093

Currently, in MLO connections, userspace constructs most of the
Authentication frame body, excluding the Multi-Link element (MLE),
which mac80211 appends later in ieee80211_send_auth(). At present,
mac80211 always adds the MLE itself, since userspace
(e.g. wpa_supplicant) does not yet include it.

However, for new authentication protocols such as Enhanced Privacy
Protection Key Exchange (EPPKE), as specified in
"IEEE P802.11bi/D3.0 section 12.16.9", the MLE must be included in
userspace so that the Message Integrity Code (MIC) can be computed
correctly over the complete frame body. Table 9-71 specifies that
the MIC is mandatory. If mac80211 appends the MLE again, the
Authentication frame becomes invalid.

Add a check in ieee80211_send_auth() to detect whether the MLE is
already present in the Authentication frame body before appending.
Skip the append if the MLE exists, otherwise add it as before.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/util.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7d7650c91f4f..4d5680da7aa0 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1142,14 +1142,17 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 		.ml.control = cpu_to_le16(IEEE80211_ML_CONTROL_TYPE_BASIC),
 		.basic.len = sizeof(mle.basic),
 	};
+	bool add_mle;
 	int err;
 
-	memcpy(mle.basic.mld_mac_addr, sdata->vif.addr, ETH_ALEN);
+	add_mle = (multi_link &&
+		   !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+					   extra, extra_len));
 
 	/* 24 + 6 = header + auth_algo + auth_transaction + status_code */
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + IEEE80211_WEP_IV_LEN +
 			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN +
-			    multi_link * sizeof(mle));
+			    add_mle * sizeof(mle));
 	if (!skb)
 		return;
 
@@ -1166,8 +1169,11 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	mgmt->u.auth.status_code = cpu_to_le16(status);
 	if (extra)
 		skb_put_data(skb, extra, extra_len);
-	if (multi_link)
+
+	if (add_mle) {
+		memcpy(mle.basic.mld_mac_addr, sdata->vif.addr, ETH_ALEN);
 		skb_put_data(skb, &mle, sizeof(mle));
+	}
 
 	if (auth_alg == WLAN_AUTH_SHARED_KEY && transaction == 3) {
 		mgmt->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-- 
2.34.1


