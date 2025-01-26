Return-Path: <linux-wireless+bounces-17974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D5A1CD7C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA9166679
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6C158558;
	Sun, 26 Jan 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZzYpvTS7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE7517E00E
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917109; cv=none; b=MznqBrHE1WAx31Kr/+kSpS8gxINwCuv6fj3WPYeH3hOTDu81yBvNkfIOc4UeAz97WaCyVl2N1ofg3FVq60Ubm9jIK1U2J3tp+gC4j+4Q+OHsn1rYvakCWEDZ21aBOQOekXkQd9I4NeDey5UIzYGlwyOvhVXUz78+D5t5uRnrSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917109; c=relaxed/simple;
	bh=Dq9n0s44RalUa+RyVlFSOGX35Qj5RnxLqm+XsAxaeFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c2DOmc1VPGifDs0N5vpgNPh7EQV12hz5gK6tF0lnWZjoAxcvEYEKMzrIi+5suucKmVY1SBYNjiIr7NSVJmc0P7ux50nlkudJcTf2sC1nK4skWnPX7QvEKz9VHNYGNweVX3LORvZy436nfN800isB62T5hA8/U1sHuhYLpkmS4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZzYpvTS7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QI0dg4022680
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgY+/s28TKm8p+bojgsh6n3sGw4PHtPdS4xv23k5Hpk=; b=ZzYpvTS70UjVGww4
	UxOIa8JnymnHrKVlPrRFah2h84ezPWJtTbiHHZnsMfgtMUOdEsfejTbr+Jeg4nV8
	u7btmA0+cGmZMtsk3UJX7ssdY1s9xA9Cnd6isPWvIotrA8USkCTfcPulk1bcp2hp
	ycXV8Rf4mv5dKLApq/3reXiA0KdOjR1OQBSVWJQUz/1aVOU6lEOSXGJu4qXS2ojb
	Ho8PxrGcvvKBwuNc1UX4+GI7gwIrAvFDnRBptL/0UGofnNn45shv5auPlsrZIM3d
	33ThpNkOaScrl9hzOj1DO1kfFhOWdYUBE6IArAGwnE4T1qVA2SsU8rvRvarxuHAc
	wgs2vQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs4jt5w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so6765789a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917100; x=1738521900;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgY+/s28TKm8p+bojgsh6n3sGw4PHtPdS4xv23k5Hpk=;
        b=Yq2/ZPV/fstgUTAw+M/p3c0B/Zq8u/6IYiurE055shLKLMSK/Wo1j6wJ7jLRk8sxwJ
         RWo3DsFK5tO1AnS0an6Mg3cw1/758+bqgoUcEuXaKD2et9qF6ecJTHRAPXO5kfz79BYP
         +MqCpdpZsqFf+rNQHL5TuLv20/uDlCfBtNQQoqHBHRTulxBrHgYiL2vg9atgNM1u5jaZ
         o3/ovi9I2tz7EHULpXIcgulOMAVwt0ItMrEIQ/6/+qYWgVl4vf/a+ZNS+Kcpd/Km8mce
         x8Q7v76eA3XEotdScGDm2GasjdZydhPfQ/ClC9qjs+s1lQpCfO+Uzo0GhNM0CybYkm6W
         g2wg==
X-Gm-Message-State: AOJu0YzidVGERdOmbiWwv6R9GTcAZ86ay0tnvAHYx7W/+ynMD3voKhLy
	YjljNqlhJj5iQkfFNnOgbKt86uITzS7KXgKrPNqaZGFa8YTYpIrnV9WQlPsTy9IElqlCRE6Sq2t
	2jbY2+xJLVQQqlhKpu/FgJJPRwGghN0puTvQpL2h1BVSzUAAJa4gvICzehU7/YmjwtQ==
X-Gm-Gg: ASbGnctnbcQUbNOXGISU82L9rTQwnMzkM8VwHdbENv0HGF4xXjXK35fqxT9fjEV4KKr
	a0RyxY00m26UyTzcbpL+u8aSrM47jBJY6Wv3T+6CXttRj7WLkNWdaSx0RHWScdkSOwoaaXF/ytv
	r428BNxTLDQDbAgDmhbyV6CXJCRwYhw0IOpjpPK8rNK+oRi5ByF2Re8aT4EadylunwR0lqOJght
	lac7eMJQ0R4+GOYG9yEyARqnP0JOkYJ/Y5QPG4ZrzNwJAA+T+1I8g+34W2HeaEdPeslS7dMGtCx
	Kgsw2gYTkMZmlGqOT4YCRM7kZhe94ODs3q5OYeonKw==
X-Received: by 2002:a17:90b:1f8e:b0:2ef:114d:7bf8 with SMTP id 98e67ed59e1d1-2f782c4ff33mr49493140a91.6.1737917100318;
        Sun, 26 Jan 2025 10:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3oAEzIzYvonxibX9+diJDX7rPGJxl3m/popd/TdiF+TVSE8ji9fLK99N0V+pwcHlbL585ZQ==
X-Received: by 2002:a17:90b:1f8e:b0:2ef:114d:7bf8 with SMTP id 98e67ed59e1d1-2f782c4ff33mr49493125a91.6.1737917099948;
        Sun, 26 Jan 2025 10:44:59 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44cb8sm5414795a91.6.2025.01.26.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:44:59 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250115063537.35797-1-quic_lingbok@quicinc.com>
References: <20250115063537.35797-1-quic_lingbok@quicinc.com>
Subject: Re: [PATCH v10 0/3] wifi: ath12k: report station mode stats
Message-Id: <173791709932.2935553.18007437105924407173.b4-ty@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:44:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: nxZ7JuesNg0i9kjUGDOXZ6K-FmndXPUs
X-Proofpoint-ORIG-GUID: nxZ7JuesNg0i9kjUGDOXZ6K-FmndXPUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501260150


On Wed, 15 Jan 2025 14:35:34 +0800, Lingbo Kong wrote:
> Currently, the transmit rate, the receive rate and signal strength of "iw
> dev xxx station dump" always show an invalid value.
> 
> This is because ath12k has no logic to handle this relevant information.
> 
> To solve this issue, ath12k parses the information passed by the firmware
> and passes it to mac80211.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: report station mode transmit rate
      commit: 8a9c06b40882ebea45563059ddc5d57acdec9dda
[2/3] wifi: ath12k: report station mode receive rate for IEEE 802.11be
      commit: 5e73276c814fc1a5a1bce6be743e1a07baa6d4bc
[3/3] wifi: ath12k: report station mode signal strength
      commit: 79e7b04b5388c13290ae6d64f930b096c2f465c9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


