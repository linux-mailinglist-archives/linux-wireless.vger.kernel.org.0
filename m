Return-Path: <linux-wireless+bounces-30814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B2FD1E5B3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789A930026BA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63636A027;
	Wed, 14 Jan 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="atL7i+5M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YVrh0wgU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE638A9AA
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389570; cv=none; b=kYL36r/fqEGyTPeuMLspwMiKBxAvoaLFuahcpwd3ZbWBGFNUWWLPAOLzQtKDTuIlF8sOALkouC5NJuwDwi2RSzIphkRPXQ2O/mg00z14RDyKTOChGzogFK0Ry2dMIVrup86Ru6mfxUi03YxJ0UwELChra5/beo9NciYfMp/heZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389570; c=relaxed/simple;
	bh=J9ecL5EApgzTETY+82Ra05XnSfGwmWRkD59Yn0eytKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKt8Hu8lVFVJI6oM12z8Ssljju4tGxTEYEz6BTMtERiLFozEppgAfgkmxSeP4xf21kSrFMEO6w/sX2VIC+wdnmbnGX95VIQADdTjEQccto+TrLuxsciP2pty6HD17KocvxUtZsy4oHBmqHLapZD8xNLsDsCortnksoCrxIH9ZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=atL7i+5M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YVrh0wgU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EB2aJA3416166
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Y0SVBXhMSMO
	EQcdfLCK13E9c99zZwFGZLdFB80Z//PM=; b=atL7i+5MJ16cjp0cfRatfA3OgRF
	VxC5X6QvwMcS30t5n4XW1JJyl4R/yKXRiPhro2Qn85gn4xIIeOMnk0X61FAq7xbh
	N8SBvmL4yyfpoC8Dr3nsUTVS2nwGAUVyA8YfXXs0Bvl6sOV2jgRVGWwPIPoC0rbq
	4nW+8dWE/BkFKqTvBQsvJng6VMPby1e0FShefCHMIiQXxnEW9wiASrtf1R3X5nkl
	I/SgTeW9kJdWbi4Ef31B/CdSQh5/KV9zl2MZAiSV2zyrcVs0sRtD27ABvI1tvjFR
	prtQFimIRih3Q2+swZelAN4pvEjtDVLH002lM/QUs989CoFTFACbINSSJhA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp9x2g1sw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f4822f77so168952775ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389567; x=1768994367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0SVBXhMSMOEQcdfLCK13E9c99zZwFGZLdFB80Z//PM=;
        b=YVrh0wgUW2479TSRYY/9P+FeRGfxKxnHZq3QK9oUv7YvjVS2T2lxCCAnF0KDp6NjgO
         dFlEQ6S3786+VJehEz5OvWunLDYUC6lXi8bamh28avgBa+KluNKzR29ZcrrugkeTqlj9
         bh6tsq+LVnX9p6R5uxpxKwK6hm/SrGZHLeo0S6ZUu2QT51zPpBMSgqMwkg2UJ+ZePZW2
         6lJRhnIFIL4lqos2B4WUuc2cSR2ld3ulRP5v1Vx+tJ4YYVRSOZ7rkEJpBd+PPKWq9Tl1
         8S0ylHceVy1Foru8qXw6Z5s6vd8ySKnBPXcYCb37GnKVz9yTIhoidnClsFqcSL+u8b4K
         HobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389567; x=1768994367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0SVBXhMSMOEQcdfLCK13E9c99zZwFGZLdFB80Z//PM=;
        b=tbDguAhPCBnVQM46/l7HsDMH8wcyCFwVPYLeCk3zQaveFqmAH2TH5y/eFi6LAyZzYw
         4POwC02grS40cTuW2LxtGDUBQCeBhjsMBPMHhJuxflq307/zbhjyVqV77lCs5mKVk2gC
         My5GAtzLd6wi5qwKwm5b5v/0HVohXWZPe6aXDBUHQB92krehsn+ba+U0KN7/Z5rLQGkB
         3jLmGtWk5vZE4g8+wNjPoq3ol3JkWmA48nk637h1jOvtHJe545PAq3ZbhqwdFavbhmvU
         wFIyry8E0L+K9oUre13wUTlBU1JVPKbCcNmfaEkImYKfbDC+3GHBgW3+UeFnxq9eIJeE
         3SmA==
X-Gm-Message-State: AOJu0YyhDPLVe8PdkNCoU+qBazKcFGpadROd693Ij0nPfUcSJLu39/yY
	DY4vOtfjwq68qBSCW5rtvhwI1mlsyvYQyi7v6jeqPqHzsn6RkdEe8mcB/lh9k+NhfwdjBV9ECxe
	3viwHHUHJtV2UMSzOxmCIxeBU5BAmsfzA0i6ydRI8a61MGUv8mS5Wg2r1VcaTtP3uYKjgtg==
X-Gm-Gg: AY/fxX6Xu4jEkMAPy3Gmz44MwhAgyCqLCcwkYGxCzD9uiB2VgEPLmV0ZJ5dGHg9yFCv
	ZyxxsarAf3MhAIQ4MXdzVCJVCZn44HWdrh0C610bx0cDqVk0Rj8hojxMAY2Rr1gSbGvwICMmzKd
	cxN8gerr2nEfRpsphc+Aj/de4AyR7q/P5G+2gXza8CPDdkHV5cbjeBDsGIqt8253NYa664jUzls
	aJ5t4CO6kLrSuk2qHHH2/mmgtdkG07Jw82+Fz7s6JruMMQAc2EGNRC+leOUUTuaPpgvGzqQIGK/
	/S51PviUro1uEbVgKFoYVZILHn6cViz5nW8Kh91h3MAwi6mH4HL0qUboEvPiqVbN7mgwiluu7h5
	Qw29/SjMNyJkSRNmlkGPql5+MizEkg/4pJCq0YfHhTA==
X-Received: by 2002:a17:903:b83:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a599e121a4mr21905485ad.38.1768389567357;
        Wed, 14 Jan 2026 03:19:27 -0800 (PST)
X-Received: by 2002:a17:903:b83:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a599e121a4mr21905165ad.38.1768389566791;
        Wed, 14 Jan 2026 03:19:26 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:26 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 3/9] wifi: cfg80211: add support for key configuration before association
Date: Wed, 14 Jan 2026 16:48:54 +0530
Message-Id: <20260114111900.2196941-4-kavita.kavita@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: E7hPWcn4uuIfO2TmQr_vc84eE03wWXk-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX9HQhkB/NfUoM
 oQkeAiMo8ezxfd/InmThmH//vKKrgtj9Zzf0qNfua8JexR0K556ZwCo+viwyqFTTPkucxBqZ5Ym
 hNjjYbASdDa0RPCgqN5eH3i9/qST1axKqUT/eT5yDeizTM3O9x/i/4s+wNeRpLXagMSHFhKcbDp
 7+FnrCfJeHkwyvlu++u3kcXBsQKe1xYjdytmStZPujCORIfgyND1eGiBh2DXvdNc7bCAXjDT4Eg
 qgEXFcSnPdFoQT+9xekS/46slrjyO8MoSF5E84vPaKcY6kxq+Jg+uShMeX3K3aJJuK0qPM9kPpb
 F7kiHxAKFAPNZeAh1JgudGPC4qOp0d3znLMADiybSR21i0OFHsB65D05RAVE+pOANZJMZdi9OiM
 dIMWNCR/EybZ4qLsj76Z11hy7MQgL5aD35p8Pht42OLtgrCaCyHDMgVFqAZqvtmjNs7MqteWcWD
 fZiU/kIWiVKvAdKC18Q==
X-Authority-Analysis: v=2.4 cv=Fr0IPmrq c=1 sm=1 tr=0 ts=69677bc0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xf8xhSOHqnjMiTY4RNsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: E7hPWcn4uuIfO2TmQr_vc84eE03wWXk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093

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
index 8f3a27b7d4fd..df159a5f1816 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1678,7 +1678,9 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
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


