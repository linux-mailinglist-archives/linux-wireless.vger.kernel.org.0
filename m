Return-Path: <linux-wireless+bounces-20365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785AA60802
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 05:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CF189751C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE613D26B;
	Fri, 14 Mar 2025 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbhyrKL3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BA38DD8
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925350; cv=none; b=VbhGxhY/XtJeMX8ngFe1QWsxA88lHk4xxEuwnqK3C61Y89N+pcWb2L2ou5Tmv/9+9IgDbXSd7Km6yIlQdG9tjoTqbAXwVq1iHcD1tpmdkPV87imA2cl1lJcacIjS4wit6txAnCnKcIlUQQJ0VA3TxnXlpRQD9iGJ41PbnAp6D0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925350; c=relaxed/simple;
	bh=2hm4oFuudjY3leJj97GYOrQEZdMR5g3oXtO6AH/CqLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dy7RFUiVtQj9UCxZI+FmoiQNeN/LxfdEDwUXajeTi6NGxH+fJ7UD5B5UxT2Ia30kQRygKfuNM2DeOTAOtqnRPedumLOtpoAOkY/O0XRpPSjNSgvWyP2gF7Hqs5HxH/+GTmH/D87z2rzUPCit2U7RSmgpZAxfiKA4wcB7YNpHud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbhyrKL3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKh0T4019098
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 04:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7HOztwl1BlNHje49xqIYzj
	ekECQIFNxDOobExn87Uhs=; b=nbhyrKL3cJe0R7usQ1kxDqxxHZJAajeJVRfp+/
	3s3uMhz5GojAUfrpNg+Otw6z5Ir2zW8dgoNobclmXZc22v63RB10Kh7fjNY4GfFW
	f9Yl/wxM1tj46SOmVxa28e2Ln5xR0By8ZCgYY4YCFTavctlnDtfVd4upkw80ic3m
	2dUbBrXGIUDtfQGWiKxqbR/do0lqIxPXa4+oxVS6pq48BNBT187DnzkF1/CQKO5x
	N/ppKSdaB4hTKi/OtzOjKV4g4Y5yneKvdcq0x8812aDFHW2gtV2Vkmv+YnezgXVS
	x2OR7bU3TRVWodmhpxXrmQ4sXWAUE7jal9pxjeVsouyXmfbw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p809v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 04:09:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-300fefb8e25so2839393a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 21:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741925344; x=1742530144;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HOztwl1BlNHje49xqIYzjekECQIFNxDOobExn87Uhs=;
        b=ede94h5v4RdbQCQX9217cesN3+ilmkS01tIyL2D6KtbNI1gCuiYa/2fX5czuuHCvaK
         7NkJTipF1Ixmi7FlsZ/qMii+0+q6XF0lbvBCOAErTdfzIHnqTknDORyZd0WbAGxYbXCh
         4MN8222Tfx/bA4gj58KZ/LHzfsCVEWhz9hzPYN4ptxT49u9W6ALRUkOwgLxkyRRDddPh
         VzkTIcQ8VNpNiRs7Qc+70qNDDzI38TZUlsR2xCll2zOrCSYz6nqFLBs2RTQ/ul6FZlV8
         V4j62/POJt14XJ+Uf2e+LCkjFE3EWVhf807heDg9mwssOLmGBVFZ6086Z3tIrw//d2nn
         sWpw==
X-Forwarded-Encrypted: i=1; AJvYcCUsVUKaa2sAJSriYJq9BgFfmwhX70bnnzqbtyC97lofh2UkgiaDohIHx4QbiQjpAhfky11Hg4/HSElmMdS4TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9qQEOdyZTEAY6SFncpaj5/YrcvheaQqbiAnYbh9oVyGnCwct
	25Y7OI8d9EFGdg9R5Wodj0E3ysYrP3MH8C4DO5MJTWSULrGUDl/C3RoKxlMZLFWLKSPC1Wwf7QB
	ox4IVPQBWVdsImurPalfbYtfv083KWpfJqFVRBRhIIVAGHGEjQnYB7NxXiuz1OKKCrQ==
X-Gm-Gg: ASbGncvsX9cE6L2aqOGkFZMCE4fur5tJMLbrJ1mTmK7lgYWnqmcTshoIlNeWaM1+8M1
	BjWxVzUnoeuoAqsz8kytqG6Wdx07ThjDPzuLHmsOzkAFORdtsPNfX8mj2BNhObCj/mP9BV/upWy
	USByelN1h1JQkUmaWYtu1KzYn18sxKk8wTmPhHIGm6tZBR5v9X1LZtAE71guVRPlOeYfaAmycxd
	h55cKat82D12rODD4DtTeZYtmdek64Ebev0yRB1Iz6uA9gUeQvZCSm/7kfr1cy19ZWHHs4m6i46
	JGHH8kwJDKW6+uo93zlk/pk5b0PheyzRDga+MfkZhGBT48XeC8++4B4aDjaalW59/2DoFa7JBk6
	csDkQCmJBsh03LqRWXBFmgZNT1lDvf6g9rX9QC/I4
X-Received: by 2002:a17:90b:4fcc:b0:2ee:964e:67ce with SMTP id 98e67ed59e1d1-30151cb5a28mr1471463a91.3.1741925344411;
        Thu, 13 Mar 2025 21:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnybzZypWMeFwM4ZeXpdlnGb8H7ZML9GDt2ImhbrZ9r6HLWFnqOnJw24uJpeF5wfbscxSBA==
X-Received: by 2002:a17:90b:4fcc:b0:2ee:964e:67ce with SMTP id 98e67ed59e1d1-30151cb5a28mr1471433a91.3.1741925344051;
        Thu, 13 Mar 2025 21:09:04 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015364ecf9sm245239a91.48.2025.03.13.21.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 21:09:03 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 09:38:53 +0530
Subject: [PATCH wireless-next] wifi: nl80211: store chandef on the correct
 link when starting CAC
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-fix_starting_cac_during_mlo-v1-1-3b51617d7ea5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANSr02cC/43NTQ6CMBAF4KuQri1hyk+sK+9hDGnLAE2AagcQQ
 7i7lZULY9xMZjIv31sZobdI7BStzONsybohHHCImGnV0CC3VbiZSESepEnOa7uUNCo/2qEpjTJ
 lNfn32neO19pkkGaZSLVkQbh5DPFdv7CH9dghER9wGdk1vFtLo/PPvXuGPfRXzQwceIV5kYMGm
 aI6O6L4PqnOuL6Pw9j5WXyQIH6TIpBSSGOqo5a6gC/ktm0vNLiIjS8BAAA=
X-Change-ID: 20250305-fix_starting_cac_during_mlo-fbc4134423b9
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=HP/DFptv c=1 sm=1 tr=0 ts=67d3abe1 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=akwbo0E0F4SoT0UnkgEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: seFLvVQrBOcR1LCJlSLT_WWE0abS-SQR
X-Proofpoint-GUID: seFLvVQrBOcR1LCJlSLT_WWE0abS-SQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140030

Link ID to store chandef is still being used as 0 even in case of MLO which
is incorrect. This leads to issue during CAC completion where link 0 as well
gets stopped.

Fixes: 0b7798232eee ("wifi: cfg80211/mac80211: use proper link ID for DFS")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index aee49d43cf862de684194e8f7b40dbc6a1654707..90baa19f4e845443669d9476c49faf426a3bcc77 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10177,7 +10177,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		wdev->links[0].ap.chandef = chandef;
+		wdev->links[link_id].ap.chandef = chandef;
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		wdev->u.ibss.chandef = chandef;

---
base-commit: 54be64fdf3ba6dbad2f5c48e466e1db43ad74bca
change-id: 20250305-fix_starting_cac_during_mlo-fbc4134423b9


