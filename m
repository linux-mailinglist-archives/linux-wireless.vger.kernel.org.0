Return-Path: <linux-wireless+bounces-29657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8ECCB5E82
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5312430021D8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4930FF39;
	Thu, 11 Dec 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LlIRoUdc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TkT8FtJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E430FF36
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456885; cv=none; b=WElNzT35bt4O+JJThOEqdykqsQ1o0D5aVPg4NmZaYZj6sBkUDVhyOWzvPuaRMTfpKftb8ekne83uS4twYG18wlYhbwT55UEAyu5PiyV8jNvlSMaZchlKBWR/8QotZx+WnJ3gb/I98On2Zm+Mtls1zRnCApG0/6WJTnU5X1vysLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456885; c=relaxed/simple;
	bh=X6nu1r26NB05O+329bxahYj+ZGWu1EJbLuzDYoppvrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNDH5ASAERIANz/cx3khTUnmst0hI1qYH7HT5MG2wUVVkmMFvGd9XoJJvBhlS9fnOFm96KU7e62Uuehw8vGaypqFl2puOuleSJr7I8K0atz64F0Vw85cGOGSqvvsabLVMycYJeH3+B4CjTMTeGoOwLpJjifZPPuZalYh9iQR3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LlIRoUdc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TkT8FtJm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXu0M1775341
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l0OaRCDMq/dlFgDEa4nM6ocp8H3Fx3zBua1VwKSRdoQ=; b=LlIRoUdcR8C767XP
	EE6X0qRZT9NAs48CzZI/micwRg08/xUOzY0u5uvyod4LhDlhxNW/HGmLfIilERv0
	JwRw6z5yKE7X5Vgx1GC4aPfMRnAzPZHdz2ca7y7Z0wuiRHxzgn4ClKURVHszdkrb
	IZGjkxCLUcL8ts8yEkog37LIxx+Ayz36QMuRRjRedopSr0iQuUdodfWDueUKKRRS
	5vzI+iBN/skYkdQu9kwmFqXgRrX4xEJSiEcugb1PZNclnG/IJaVhQUZjLDy3JKyi
	wcaKho92GFvhtArPe47IUWHQZhmhLIYaBUed8ksCz5kfn4oamDGP+nLYqRgtR6tJ
	rO1OLQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayt708uyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:22 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7d481452732so27727b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456881; x=1766061681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0OaRCDMq/dlFgDEa4nM6ocp8H3Fx3zBua1VwKSRdoQ=;
        b=TkT8FtJmL7rz59Bpx0/lYzKcRgSmyacyoqsjmjGzOTzFtl1RNUIN4wE/o7zSVloeKH
         7q50EvgYfk2UA4hGR+dICTgA8GvnvlIWgLef7/DMggUeBnSdQk+c352THcQQtUJWNrb4
         5uDaVl2NEC3sW755nMFHVXGV0Blr7dMVlk2+89KrJNYnd/nJuR8GWVxFeP7C4hvby5r8
         hYtxYCXmoJkMStFR/vZIeHA9l/8YO7qEbBmSjhuqeg3iWZDiYOLLfGkrrG97i2vlG9Rg
         zh3h192pXp7qDlVQYc8F3HkZNqb4ssYcxzOtBrJXOVH+LUOmb8DP1xnPvex0XbNiTDDr
         HYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456881; x=1766061681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0OaRCDMq/dlFgDEa4nM6ocp8H3Fx3zBua1VwKSRdoQ=;
        b=L42wA+SWgxuvDKscDkdaws9eTrh8C0FTBiR95xGKMSJ9lkpkFjcm4WC7JYzU9SUJH6
         z1uJyMEudAhvVQDK3NDlQk8t1geLS4I637MNHCFZ65cC6MePgr07yq0AnW95xwaBYf/i
         l4UAkm6OIxlvW+4pzlrQZ0jMO/FW6YVSxC1JosrI/a/iFxxsQUzB9EnAWg5qzS4pQwxd
         jFJdf5Tjt5ea0gGbfYn4OORvpUrvVO1TBqbgihM+7y9rEHzXvElvwfwyu8hSochwRjKc
         RBGS2hhGhrG9ZMC0hhjAPSkDAdxz3oaMG6DZLAi+NIfjWAoH5IWfZeuF+jhHGXztXy98
         UOdg==
X-Gm-Message-State: AOJu0YwFpFvxK9exlapY6oG6i/Q7lYSFYaARf5T34xGCeJige3/Xiqll
	AecsN1/Pyj9K4VRPINgZjL/AJD6DFHHw662f8Ln/bVmFSh8mygMv/BLbMQig2w5Kxu6zywxn+2C
	VpVgnHcjZGp2ntZRd8BA0MvJH0ECMsVmxPqXdUzS1QCODEZyhyG7Go4AONwedCrWqRjgkYw==
X-Gm-Gg: AY/fxX6dS8ntM41fJ3va2QNMZg1piZpfYISWJIzAp7mPvBPUUW69ahTS/xOgTgaKG5I
	2/sUL+EMZJAfbi9fyAFu1IxhEk5mfN5o1d0sCApTwcagaQv/l+q5Cmyl8LVnupYLvU8dBud/Tc+
	JxrJzLgFCGKUZz6WicEL0qtvLqKCUDb5sEI5Z0kx7WoRSeo5JdbB8Ydl7UEy9jWAhKUOkNWMw/i
	4f//MLhG9byeXjiW58DNhtmj7l06ay1+y4ZeCu9y2+iacI+Nz2VePf6qVRZbBzSn20/wQ2862bw
	f1E9Mf8CyjgZS9UGFKfrOFfP7feBjY9L8dUA2XaUv5KeLIB35uJsl6NTgwwqBD+kDgPkojAKiv8
	ABrkT76OKlH83YXdjazTQGwzqt9cWGXAYIHYLsemNcw==
X-Received: by 2002:a05:6a20:6a03:b0:351:d6ff:dcf5 with SMTP id adf61e73a8af0-366e1216423mr6193380637.34.1765456881457;
        Thu, 11 Dec 2025 04:41:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyQ3cxBlF7Q5UqmRjUoIL7NawE89pXOfeVPLNR1uUvgRvhIayYHSbQZSk98d9HTvxltjDHKA==
X-Received: by 2002:a05:6a20:6a03:b0:351:d6ff:dcf5 with SMTP id adf61e73a8af0-366e1216423mr6193355637.34.1765456880947;
        Thu, 11 Dec 2025 04:41:20 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:20 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 03/14] wifi: cfg80211: add feature flag for (re)association frame encryption
Date: Thu, 11 Dec 2025 18:10:40 +0530
Message-Id: <20251211124051.3094878-4-kavita.kavita@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfXzyAc7hepi7Vu
 yFYTBQQHQ6UEUEjA+gJ2TE2avxJdrdJnSRZZm+TAgYMCy7ZnmrZ5jL3qgV+VFV5rQokH1OnAZgA
 GwkLJu/TjcnjP6alR3pcFv8mAkHnx+LXnaL+mvmnQiXMJWIvLchUiY+dQ4fu9K8yAyalxZlo2Lk
 +RA8q495COn3L0atKARXuAdF6zqgd49jq5QO7iAz5XIzQo+4oU1dNrG6rP8JeeRiuJJwGfHXoVZ
 QR+wBvwPt+jCPOWIaYIOSszgVhWHgTIwm1oFT8a8Pmrq4S3IeV9dDPYeMKGooTUoE9sfXKraxQg
 Xjtr2YzIsyy8rwiMH/f9oVwdA1fOgzFQkgg3nvfLn4NYPT6XyM+33AHqTggt6ZeRSk25uXNi9R3
 2GjhjFxGpC5zFgw04zi/HFy9S9UDiw==
X-Authority-Analysis: v=2.4 cv=WYIBqkhX c=1 sm=1 tr=0 ts=693abbf2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2qxbCeB2wogS41fK6WcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: BHG9ZcrY9mjXK4CU6tH8t8X47-s4WaBn
X-Proofpoint-ORIG-GUID: BHG9ZcrY9mjXK4CU6tH8t8X47-s4WaBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

From: Ainy Kumari <ainy.kumari@oss.qualcomm.com>

Introduce an extended feature flag that allows drivers to signal
support for encryption of (Re)Association Request and Response frames
in both non‑AP STA and AP mode, as specified in specification
"IEEE P802.11bi/D3.0, 12.16.6".

Signed-off-by: Ainy Kumari <ainy.kumari@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 371249a2f0b0..5c33486c6380 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6750,6 +6750,11 @@ enum nl80211_feature_flags {
  *	Key Exchange (EPPKE) with user space SME (NL80211_CMD_AUTHENTICATE)
  *	in non-AP STA mode.
  *
+ * @NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION: This specifies that the
+ *	driver supports encryption of (Re)Association Request and Response
+ *	frames in both non‑AP STA and AP mode as specified in
+ *	"IEEE P802.11bi/D3.0, 12.16.6".
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6827,6 +6832,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 	NL80211_EXT_FEATURE_EPPKE,
+	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.34.1


