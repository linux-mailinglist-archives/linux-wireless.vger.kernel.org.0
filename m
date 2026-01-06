Return-Path: <linux-wireless+bounces-30403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6FECF90B4
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43C74301F3C0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845333F39B;
	Tue,  6 Jan 2026 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QlwkIRiW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqC7pFEo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B4345753
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713121; cv=none; b=cYIL/zDgRZ8NSPsZr8t6344cGLzNSmxBmhCOyL1+CfoS/9ShkA9mACWgdQ8GxtXUzXWDiPnuGshtB744iFqlWv8aX6IrttcZbzqVzZCYkQlFesINg2sLTzIBwrpVEgPxjFYrC2T9Gy0wc5YpIzWaqis8XLgz+ilJ4JAEywEUqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713121; c=relaxed/simple;
	bh=84zqECf+2cCwe1xfCyE5Ocbh6kpDZai6vUViJD5wAEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws8aDZhwurxngAt3x4PLB4V5vRX7yPBdX/SXds8T4rNdXScjdRNTUBxnJNwJ9zgTwQdsW4MOJoVL6VeWZaZXFaQxEdG8nWDhfiuCqGfUYdc/ebBdKPPB8EDJOFKNWg6IVAI3OR1vt79TkjZFUsTAa1O4tS7HDkHgv6FX91848mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QlwkIRiW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqC7pFEo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606EfkLC322876
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QlDNjj7M0DuTFDuEnE3mXGP/nRXMqxQXD5r1RMWOAfo=; b=QlwkIRiWmOqjmBQ/
	nZZESCVdCy/VhWSU015TgnKGG62d00/wYJqPgAreZXt/chxJdSbBxkZ2lElwSGAG
	zwaxOc20AJvPNYbO5+iAbPNA3Qpt1xah4clONzVZpOZK8GVr3eiQ8H6OP+iHGAMJ
	W59m0x86ds56URJr9B6Xa9pkDCZ0JLcLVdKIw08A6vqte4+ed//CPk2onwTqI292
	QbU+rHRfb147/EUvHBsDdffw3JAxGQighPDQoYNWWgEsuKbHXCx4csCLNvKuOYP0
	gbforqlaCpa46AY/zK0cOiG0Pgajx35BaOpyOOFKe1lapcDGlS/TIdHWjoqmWt67
	Laz1Pw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh4crg4cn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0c495fc7aso14408725ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713119; x=1768317919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlDNjj7M0DuTFDuEnE3mXGP/nRXMqxQXD5r1RMWOAfo=;
        b=JqC7pFEodKtLnabwgPT5SqhXZqrdNJrJHu+LbdMyNceNSIdbjmEMaeWe1yKZyHJYy+
         bLp9lDncVd29LijSF1vkMwWr3Ff9p+qEHxHvUt/fUTvwq3P9B7xzDaEkN9vhvHLhR20Y
         9SgwzNj0iQL++4bCVhVVNNoFawepyI5I2ZAZ8f4K9OYXYRzQK/1CPBKuigwrwBXVuXOs
         6ob4JrrVXeXxmSgglo7jmHJ6bp38DYxYGfbDHkO8uL0Ev4+9RDSaGA0RutvXDsKNDtvT
         FjknHsyrARM9aTkZbYqMYhBOUmJkqg7lehyYVE/wY/9C5+FWIMBmGHXHnoMvdm2KYOuj
         zh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713119; x=1768317919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlDNjj7M0DuTFDuEnE3mXGP/nRXMqxQXD5r1RMWOAfo=;
        b=Lcv/OZ9SHyJcnSGh0q9OK3aejembiSkZ9iztlbKDhoRmxZSg2o+cEaUve02skPGH6G
         1R9m9rLdqFU9fBDULVrwm+NOBtD0C1ANMVyBJYkEuiDOv+Jdda3XuWqABzxNfIHapdFj
         yyWBA6UYt3Y5E30HjShHgedud8qXgfw9wHpSiP1FDEJgtm8pmqnPmmk69H6BMGwwOk4V
         jxm1Cee7rFVFEdLTQAycTtZOkHVPBCyXnB3xlrejkOIUqYrVnQEAmPJR//bWlMSqleNl
         vac0hhgBvlXk0NGpdcvo+Vq7OBIuK8uVwuSXpBGC9FreQCLljrcVrT1MllIREQWsCgJQ
         eSMw==
X-Gm-Message-State: AOJu0YzsLfuHSXeVayTsk/w1TGIXZxbItvE2tZ2YSr7WeAJ7OGn+05od
	AJq6GSrKpbe5ToSslgOzav9b9C6HjonW4GvDT//jv+OKOnpng4QZIY8136hJQJw1czw3iLohwdR
	WW+PTuzCq3caUZGBvKrQrY5Q8byecClaBQCnPrHCNC0g4KDGRpWT0xV82kOVfBVYLht24Zg==
X-Gm-Gg: AY/fxX4INF2I98BXnfQN+Ili1eY9HEQE/T/77D2CHab4fpyt9iN/nS2qskaIgmfYdTB
	ZxqdtdoSmj8Clk5srjPhKPTJ67VnpneIwBLik1dHEsT9TUUcg5/Ba4GIk4pE0+HfpmzPwG2iT8i
	DcP5HGN2BBTxClFZafWRZA9PJedIpjvvlou+r9HmbMcdRpJfCcJ8Rcm853zHSF9wg/Bd1Tco96G
	CEu8nbJTDYNh0tVCR8cNX9o7udvIVZtedituR7qm1asgiK4zOr/HSW1NAz7wG1uFYV1u44cUsZU
	ug0H5TneWTjwCKmy1mbFfHe8ZgAOoEZ20mHTd6Daq8yGz860ODK0MCaqRUnBC+NZSKpe0oRQ22I
	H+aqgdOFpg5W+oonhQP5V1ujF3Tnxwr81vTpeH2YQgA==
X-Received: by 2002:a17:903:1c2:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a3e2cf848amr26337645ad.34.1767713118841;
        Tue, 06 Jan 2026 07:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc9U3y815bwni1DfxwyJ1Dl0VoTNUVcvPlqYKw9Qds/1vIDYRz6BSDY7Q6YKcf0xH6yV8IFA==
X-Received: by 2002:a17:903:1c2:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a3e2cf848amr26337375ad.34.1767713118299;
        Tue, 06 Jan 2026 07:25:18 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:18 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 2/9] wifi: cfg80211: add feature flag for (re)association frame encryption
Date: Tue,  6 Jan 2026 20:54:56 +0530
Message-Id: <20260106152503.223216-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V9FwEOni c=1 sm=1 tr=0 ts=695d295f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2WscfWFMoDXKbaco21QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 24m_wYtohcyXC6yLd9hiCJxax9afBJv5
X-Proofpoint-GUID: 24m_wYtohcyXC6yLd9hiCJxax9afBJv5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX/dg+CCKYSiH+
 4HAL+KH/qbWQ6ifrMkn97bi9FME1EGI5U8M4P+QekLm4nFaGdvmbRQYZnCgMNiYxPq1zt8MJfeA
 XKxdq/9Yomoy3YhZdbGaDRQDa+1q6M1gEv8xH6Iv6PUF911JuQO1qKLbttnac6DgS++kknF+Bwf
 G9zPaCDKWhYGMNqfG72JW0mgt2p7DVRYKekD5FfK8AWJAGW/GGvZ6J6y3J+rvRmbi18f9A7L72C
 SC1zb5ertk5DH8A9Q+leJxZhGJ5RYMY5YlOs84GQCeqiKWK5VCE0I0JJ/QtYpg3GjYgdpAIf5X0
 yR8UcDly4jfycZuJgNrRHMyeV5UK+VQX13XieTWaa5BrlzZYoqthjJl+rgHzitTc6lKVoB4TT0K
 X/1JxOT/n+nZNV8OEtkiFsJuvlhhROqBpH3xQYmbyYrqEsCJ+tNXxkTqDYraA8dlp3GpWsBa78J
 6moenoxBjRvRohmkH9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060134

From: Ainy Kumari <ainy.kumari@oss.qualcomm.com>

Introduce an extended feature flag that allows drivers to signal
support for encryption of (Re)Association Request and Response frames
in both non-AP STA and AP mode, as specified in specification
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


