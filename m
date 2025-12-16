Return-Path: <linux-wireless+bounces-29779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37059CC123C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C98E3064517
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177D34251F;
	Tue, 16 Dec 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMuOP9nk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jiP0jVKe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577634251C
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866456; cv=none; b=BrOjDny3XUOr/yLB0MXsBdEQpMQp7I25ljFHExXRNLwJC0qCh9QGLe0w8NXmjup0d3r9eWkiChV3n1Xhx8y3E3Enp5vilb0FYj+kpyOvKSTDhZQ/utbhqHERaHtLJlboWMEWLa6XPO81686/1FH8lAWXN9Xa0TMjZU9BC4UW6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866456; c=relaxed/simple;
	bh=Jw9mpvW3mjP90268PjPUkKKGlkRVlh0NzItssokHANY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4N8UMyHzBnzRku3G4OysHfRgX91Dxc4m4AXr6mE2oFzCFgOuXofb5eX4N8wbXK/9S7I4kKYLF+785RROjsyKhNM0P8A1Bv3Xdo18MG18gN6BrOu1+7Wqq/Stg9uhfjyXic7ZXruLLmE4uNjVWhxHu8j/UIorFpcxOSfXnheoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YMuOP9nk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jiP0jVKe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG2SCd51825473
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3t0Yf9SXf8V
	Y19f/unDHMnvFRUrL7lvitLF2NWS7myQ=; b=YMuOP9nk+JLqno86kwNTElzNf51
	e0bMvLy9nY/t4mUeWHCoNFYhnGJ9SDuxUDzEuNU8go6ARspj9VhR0UNKIxWAua4G
	D6xzlW1e/PfcaaX8FsjtGSoXwQI9OWoecth9+W5uKp73v5K7RBpAx847eCX04f8a
	bUv3LG7PilXthcORtlOyPKsC3vraHZBg0w1xwiuzcORJK65RyQDVVdzEPuNrQW2t
	Yd4ekv1PMGt6kKhLhL6GmwQnrATETLwjvYHDAusLSJSPUE6JRkAGAH8R424tdHS1
	mR8DVayUWQT0iDN5YWVeEhyJS4NCMSWi4GOCqXkFlWPaMs7wRUdjLb4uPgg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2p4f2dyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f8e6a5de4so38374025ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866443; x=1766471243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t0Yf9SXf8VY19f/unDHMnvFRUrL7lvitLF2NWS7myQ=;
        b=jiP0jVKe30Rvf6Pm/dUcmeN3vO2OlllZtYK9lX8boy0qB6mYo0BL3/V5MalyaFqsxj
         qDwayjxFasmLCQT0Urqt0YOiONiFu+y5nIOAEzPyJxks8zgd8pu0cbT01rIro0DlBIUD
         IXrRn+zFmk+Tr4pr1OOYxHE5Z/FFVqvLpDlygzQCu/bxdT1z4gQgoe9MQU2rPYQ1o+S0
         cksRuG3+/qcWVS0f903OKmaaW1dfoiz/85CecENNEzmU8yWwErRXe4W2p5tmtjRetoJq
         fyhS+p6eRGHYCmutRUYzGeEGVTQMUtIks2QKFx0dZrKEAAsb2IeddRGBRZJ275uYkjHB
         qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866443; x=1766471243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3t0Yf9SXf8VY19f/unDHMnvFRUrL7lvitLF2NWS7myQ=;
        b=m9wux81nR6Ik1QdO0Wg/1mWR8u3b870+4NrQn+h6nsa1yHcNxVwohZkyva2HwYAR4c
         uLraeCHBZTDJpmd2dctEcIiHCeHhzwCCzmxA0mJfgLO995ih/JNBxLrIGv7I9tj7w4zZ
         5kowv/J0UNJUK9wnf4EH3p53QarR9yLK9LJ9qhZE5JR8pJOdOQOuR09JXnZ4E8XljkDW
         iTs26fczg6lz5ulgtrpvPwffEWi7RrI0qVgtxmKdf1VFbJuzgd8KzsXBGA/qWTQP6yzZ
         Bi4CPMof69AbruNZ4fE9Z3WeoFgwPVS5AXuUZIGTu/vU9z4RC1rtItl85Q07V4K37tI3
         bO/Q==
X-Gm-Message-State: AOJu0Yxv4HKH5aOrDqgy0r42MDhf4LBU1zofzHX1IjAv6Hq1NfOB3HIR
	HnqiMR5M0FJanlrN6v97f9fTro4QxdMCDAKFnSASALYBhFn6mKBniaFSwoSffzjwa4FvrZaGI69
	mPqkzWOBfo7r5a2C+Yx26+HvwUVMim4a7wuv7KeUIWMaUi+UBqJbHFJBpyKZuMYN2H3mupA==
X-Gm-Gg: AY/fxX5m74lI3tXMKpKj6ToBycP2+YhqNTeKhvDYMUYhu3lY6atpLGTpU1UYEv1FT3x
	C5YOp4l4sAL/Dm17grR0ZA5g7ZtZJnftxGaGP66sInaZpHr1V1N0FK5IGVzGISLD8+DhKfIpRpa
	9grPy9tTzcIO4AeXRVrN/LjjVx8VNVXHWgay2TrQ9YfMwCrGDgu1+24ui83OdoGE7OLzJZmsBhN
	zZFiJTltIODPib92MZnNKcCDQzM+rXbrZBUSlfG2z2pMEfN6XCftBW6u75qJwsJOMS/3XLMLKqm
	gpnV8v8HbLySbO11FXtl9Vgon01+ygr/fPpTNuxKYex2rj5TikDx0Y/o3D+6yU1+dYc1mGzfyKO
	95JXxDeUr+EdrdB0KsyrPTBOWOYJBq0F2F66HiNrkIxmE79KIEY0N3w==
X-Received: by 2002:a17:903:1ac3:b0:297:d4c4:4d99 with SMTP id d9443c01a7336-29f23de4aacmr167126725ad.6.1765866443377;
        Mon, 15 Dec 2025 22:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA4EBslV/5zVimjIqTf9kW/cKR3PkV+I3cbsFaU9WdxxEOojfbqEI5cSrC+n03HqBs4UyH+g==
X-Received: by 2002:a17:903:1ac3:b0:297:d4c4:4d99 with SMTP id d9443c01a7336-29f23de4aacmr167126455ad.6.1765866442917;
        Mon, 15 Dec 2025 22:27:22 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:22 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 04/13] wifi: cfg80211: add a helper function to return the UHR interface capabilities
Date: Tue, 16 Dec 2025 11:56:47 +0530
Message-Id: <20251216062656.1738022-5-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _YQxIG5ERNnCWGApQizcAeW2zeH4LRtL
X-Authority-Analysis: v=2.4 cv=OK8qHCaB c=1 sm=1 tr=0 ts=6940fbcc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JsFJZuvHzJIkGu2yJvAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: _YQxIG5ERNnCWGApQizcAeW2zeH4LRtL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX1sw1qqaKJ5iX
 0I7hd+9aQz/O2YsvZZlgtnl9+AzZBoFNWsFkgC+4tzrePmLrOBOUdtWZFmbuTI9aPtKH1hS/FOH
 ZdLuQAgil5Gi9guTtmd/pGb/Mv8Y2IThj+3Bm/vWxfBvDxov5rB8DNnmW/mvZ5sw53/eNs4uBvJ
 OgFYF6wc+qfTWHV1k7xx6jLsh110uLXpYvkoo3ofVCEUUtI0BqZROAysF2LKS8nfCOL0ktGpEkl
 rkYO0CxVWh4C0F9zxkywRnItQPGfAXUEqzNoUNLC2zTlCoTw9K/POwSm6CvHnYDW/elDhfM9X/F
 cP7xtRRPFaLhdpC28Vyakf/xxKl//1GtEf+/XautJ9ljrHbohIBC9w5bt0s2PvCj0DyYafCxlKT
 n4M5XkojTbkV3e8zIUqpS0+eVuFfNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Introduce a helper function which returns the UHR capabilities based on the
interface type.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/cfg80211.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 378fd54c282c..7964dd1ee691 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -720,6 +720,26 @@ ieee80211_get_eht_iftype_cap(const struct ieee80211_supported_band *sband,
 	return NULL;
 }
 
+/**
+ * ieee80211_get_uhr_iftype_cap - return UHR capabilities for an sband's iftype
+ * @sband: the sband to search for the iftype on
+ * @iftype: enum nl80211_iftype
+ *
+ * Return: pointer to the struct ieee80211_sta_uhr_cap, or NULL if none found
+ */
+static inline const struct ieee80211_sta_uhr_cap *
+ieee80211_get_uhr_iftype_cap(const struct ieee80211_supported_band *sband,
+			     enum nl80211_iftype iftype)
+{
+	const struct ieee80211_sband_iftype_data *data =
+		ieee80211_get_sband_iftype_data(sband, iftype);
+
+	if (data && data->uhr_cap.has_uhr)
+		return &data->uhr_cap;
+
+	return NULL;
+}
+
 /**
  * wiphy_read_of_freq_limits - read frequency limits from device tree
  *
-- 
2.34.1


