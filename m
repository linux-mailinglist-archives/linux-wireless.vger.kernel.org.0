Return-Path: <linux-wireless+bounces-29785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E482CC1175
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE6D33002164
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BE34403D;
	Tue, 16 Dec 2025 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gEl3Lwfl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X1dgw0Ce"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A95343201
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866467; cv=none; b=Mv8oXpBuv0Cf8SghbqyC72IByRiANIr5h0ofDw5QfNuoH0XbvSDsEZ6v894Uvg4o16f9+aiW4BEmHwP7ujh9O8kD2DFeaZU0bBhFmBn+HkhW1rp5ZRLA5B9f314CNkYitT+4kIc843e7GTuq72/eKRHszxwlQwJgblMfbnELDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866467; c=relaxed/simple;
	bh=DMMR5NBT17eH4rWZOqi9CDLjSEgSd81HJc8GSRWdUpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8OKdATBs18fz4cvVfo3D0dEkrto8+uWzoDw9NxfCvuZa/IQuJaYtJm7ql8ZhF9J30Mi2IeSHZVR+hQtCIRzO6dndcRaqjT1Bxh/q5BbsWURPjvKhKvv+shefF8XSEGcy3oX4nzWn68jdQW40OOJFzwatmWmBxHzqaUbK7xEwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gEl3Lwfl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X1dgw0Ce; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG2K5G31756306
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DaMNvrMhcOe
	QCXjXmJp4uJal/UvxkuEF0R76Cq5lpDs=; b=gEl3LwflD4tbuNED38wRnKRwxpW
	AXi0PgRZHCJSyjsakj8toSMwPRDkr2TVFMBe3rK6Nz/Hk1RH8qQALyQIKIvxDqZU
	NGRuucvxdpc6wb8HcialTE47wu44uEX38QYFMNSEhMYC4tpe2Fw6uDxUTejE1TWX
	A75V1X9RN615gvWYz7S1BNkPboEyxy0l2sNHC5DZeE9Ldi4PZM+CeeiGR/zG645r
	MRIReEelgm1xUudbgI4jpheu4SqH6qGrse/TTKjVMEsXxPrrUow0RqdXcEbudCY8
	dK0rUmt86ovjd/bYATwi8xKevEeUo4ikcmG5TUDF6GFuS6Cy9N1nNmSroEw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peractm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so5311162b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866457; x=1766471257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaMNvrMhcOeQCXjXmJp4uJal/UvxkuEF0R76Cq5lpDs=;
        b=X1dgw0Cey02b8wgkMgPFDPUMt0HAOVEXYTqWYpvNxBQdhMTEuxK8Zd8ZIiW8GKD21D
         BnFz64u8CH87+30g40aunPsoZ2+7pT+WAmonqQ3qZcsWIT8gSSqqVakMaeA69GAENOf2
         fwoLJL5H/Af7BOMz72qRov+5R8qenoYbshBtene4L6LCx0L/mNn0QXGu1m14RXdVMmma
         67Nw3wvJHGTqgRTpkdxnEE1ATb3jLRRnjW0sJU9+fvSDVUnlPWrQCt1H5hm2xvfS2PCU
         d7CoSI2aJdLMknhzRua6niOrJwJ0IMNhBKekKXHw8335p9vFaJTnjiUtd9wG63oLaYQd
         3KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866457; x=1766471257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DaMNvrMhcOeQCXjXmJp4uJal/UvxkuEF0R76Cq5lpDs=;
        b=HIyauF23Oa/tu9t6EWWX5srG7ggffvG+tcrYGle1Kh4gxoOGYUqVm4OBOOJvIh3OiA
         BnqdyYUHg2myaWAO1THU8yF3wxp97AJxEF/pcg9Db2s+g45o1QPehOOVX5uO9cbJrH+m
         f52gPRq2cDV0G4WMwpWj5TtrQtYyiDdOutm7mCCywc7sg0sNOR68FgelP2mPLiUqmKbh
         /XuqpY4zZc4IBBGPriNnCwEnFblTwMHIxkl5z6wP41nQrzXyroWreQRnfXJGArtUTjP1
         r7O+50kH8E6CbYocZRayJxtuQ1Lhl/F9P3kfEH5b6C0GGuhgmYIvd6sR4YW+E17dPHrH
         0SQA==
X-Gm-Message-State: AOJu0YyZ0vi2l7jQF6pqmWcLPKx4p62pB306Xys8NxHG3o6ugYZZyxNS
	hJR1AYbDzlhmN1K/BQ1rpUT2LrM7RRVItaS436GFTpUkJk+dRCXViZ0FzYiRE3/dGRz/K9gOXkf
	BAvfyll9iiJQdrXKDlhAwIJk+MUh0OcR/AWaU8HsGwaKv8HMv69/W4pnVWgmqz5beRv/iy8bknP
	beZg==
X-Gm-Gg: AY/fxX42vAVloLd/Re/DCLkBW844ZmAQplB37jZHQlEns0et5ZyjF4L8QovjkGlURf+
	uFBBkcoOwKbFq0zVtM31S6umirM8u6nhsi4gUtoFc8INC6aIeG0uocGKOV2OQz0O1SIwOU9mVuy
	js8zPDvV8qaH/rYW7ED19XUeCBjhlRwWAhtjSAPhxmI9A5cD3ZNQ6QEOL/dpAiJWwnLJ78qUNU2
	XfKBl4r4olOsnr7ZEoL5WckeY2vMAm9aJiXxgilaM+9iwIYmsM0igMO++6i/LCjArxX46V4xjX/
	KqYHWEQH4oEKF+U3SOBds+Yhx0Ao8nBmv5yIR/0FNXYfRGg7lBHZLmFpx78SdqBZt6nN71ZL8AQ
	GBQP0DviGhtOTypccljrV29/0uuHooCooaaLW3OfkExqSKS6H4lI4iA==
X-Received: by 2002:a05:6a20:7fa7:b0:366:14af:9bd6 with SMTP id adf61e73a8af0-369b00eaa64mr13362874637.76.1765866457328;
        Mon, 15 Dec 2025 22:27:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEWE021dX/3ouLgkvyqZgg62yr98C9TF1n0vqf5AvzRHCqmPrYAaM/VGYVk5rwrfLQRwRIng==
X-Received: by 2002:a05:6a20:7fa7:b0:366:14af:9bd6 with SMTP id adf61e73a8af0-369b00eaa64mr13362854637.76.1765866456819;
        Mon, 15 Dec 2025 22:27:36 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:36 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 11/13] wifi: mac80211: set UHR support flag in AP mode
Date: Tue, 16 Dec 2025 11:56:54 +0530
Message-Id: <20251216062656.1738022-12-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 26113rwqs17EuA1kvdUYIc74lAAZP-J1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX7wGpPJdhxVBp
 LKzq3RnCrYPMeyagYoaFpTFzA5+bi97XLA3T8H1rlI0VtIf4HSdA2Jgo7veOyOM5DFRE8pBcn9x
 2CJJUvRuvAvSZ76HX2PgnEdCfWsAh6o4Xp3RQkgxUObbqfUBFS5qKy3jUzAcOQjw8bfwZ8xI0wX
 WyeQVC8yxd9/XTrqP8HTJnAiDjXKoRMKDAJXzVjRSqvF9eZRj10JIHerOoktdD98/MPqZ0CGX1W
 53yfCbnXa6phh7UrNqP9/Nk8kv09qSq2IR7W6TPO1qZ+P3Lxfu1ptKXLAFq3UxVqwop27Deu4sP
 DEL7XtMC9wyhLTIl0+90pGfVrXhkI8UnbLlx8xpTFVag/GJ0pF5nIjSjLS+aBG9+MlFrS6MEiHm
 v7JsUWKFfofxBvHVK2z22hPhK7RL1A==
X-Proofpoint-GUID: 26113rwqs17EuA1kvdUYIc74lAAZP-J1
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbda cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=to7ywHymwA1z4aNaKGgA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Set 'uhr_support' flag if UHR operation is present.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 94ded4a44c4d..e16b0e9b40f5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1610,6 +1610,13 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		link_conf->eht_mu_beamformer = false;
 	}
 
+	if (params->uhr_oper) {
+		if (!link_conf->eht_support)
+			return -EOPNOTSUPP;
+
+		link_conf->uhr_support = true;
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
-- 
2.34.1


