Return-Path: <linux-wireless+bounces-21553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE0A8A16E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 16:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941314411B9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C229A3C9;
	Tue, 15 Apr 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEuWt0Nd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3F296D0D
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728197; cv=none; b=Qg3qlS+qj3pOon4A2gGvag+1Pmr3nctuJLiz2wW8bJULWDTYhDHXdDYG/aoqAPbE23GgEcZiAONJtlDqIMmiccgUrEs+kxQPmeEiGKL/B51gN460xQ4S6NfxKFUFIJv2v5ImaxNJNFI+1VknGn2ksk3aEq3JH2Bj0tPi4J66la4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728197; c=relaxed/simple;
	bh=c5a7ZyeEl9+091MU9wjzxsxvx5f4RLGE34b/+73AcwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TszU/GsQXM/Mu3OYxQy20fzwG5x+OrMCv1Oh0PTd79blyMR1XvNAwyBXHcWGYFiqOldZqHkGQoumkUHu3MviNYJqmYQfMD4KPfbSJuS+Wtt+Rj9gZm60Kx6wRcd4wnphMP98amhOWxzjXY2IK3ferbdNL3GJ8pvBy2O8WfSNLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cEuWt0Nd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tG50019617
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 14:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YXlkgyW/d2uW7tyDlPRx3ZyerxZ0v0AnHxvv95MSB/Q=; b=cEuWt0Ndp91TSISE
	3zZUh5lJYe+myL1NT1Av3LDu9L+iAFGp+fRZ92VUb8LvstPNC9LjBMnoqDNu42V5
	cD07C7aM0cgWpDNFKjh42qaVPTn2KCoZ2zLq0+R5EnmH7nPpiWzA7tx1VDJAUqOk
	nFxwaB5PfpPe6vrqp1h7W7dPemcCCds9Sk0d1V9Zrj5BMlBSYKFzgCL3jG0fHjD2
	cIwkuEXeWlM7LOIYnpX03fTn+SbZcKrkKD7wcj4wNqIaPaCyi6Md2FPgkA9OY+/3
	RT79xDHRSyRmP/rAAd4mIS91acCWFdyz4/S1hYESgfMaX9j7QbGze+UKSCVJ1Mze
	8UOd3Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfd0bpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 14:43:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-afd3f1adff7so4756738a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 07:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728193; x=1745332993;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXlkgyW/d2uW7tyDlPRx3ZyerxZ0v0AnHxvv95MSB/Q=;
        b=D0vZ0/nDIQYOrq1JxJaFZhGDzC0jD/OWCh3dbluDmv/GjtfM55cnGGkAjtS8G353aR
         WXL80ZsKpzh6jsrQgok708V+qb3pMZw+u8LndiqVjuFBsCw+ZVT2g2YutTxuIuWR8+in
         qJridc5Ya1s1FWpfTx2T5da5Q78MMgUn7Aa2ScDXihAPnzIjWIA6qS4M5DvTV6Xmo2nj
         9OWY2FT4tZ5I49q5zAdw3C+KRanVdv2RCPxrM9ZU3v/pnk/Y38BlVM+oPJeg/LIsO+iF
         sl0FzAbIqNwZLQqhA8kQ34seG62B4G9NCl7ecLpu33vrXxr6iUDmsoRfUvE8hZNKt2OB
         p5KQ==
X-Gm-Message-State: AOJu0YypouYCRgzVgBHyKCdWN0RVT6c5HUmLwTcGYdg1ehzTtFnhVNqx
	r7E+nmYaSaSn3MaNauo8x6340mvSClT0LksDx6MHqfy0s5c+XzEUNsjrymwXT4j+TUQtnMe6zYI
	9W6eqO+xQpwHbNPCemRh6n5U00rFiZZOutNNfy00T3jJB7u6RBy1wbH4bb0Fc1yWffg==
X-Gm-Gg: ASbGncv6pv9nD//yziPTuAxxm5ey0yuEOYUjN0TERFnhIZJm2FWHZ5IUYA/9UOgAaHk
	maG7THh/8iGmFYYaCBLfDlW1nrSGaiu7+du6/FTlbvSR52sm6hmJX9WkShged4YPdcJrYpQEdPM
	PPJ349n1nJo/FW6WWaEDll5VNbU5fPEE/4gQ1IFulOajdJutOLQVrvfpz6icGsAWoWrkQc9MIj1
	9ZdxFP7Xwv3aD0BxFXYLqmhs5XSHch1FPEJtqZE7i1RgkhAN52d8rWsHQr2qg2hyttAWKHcOC1l
	waInCI/0LV6MOwEEEV8/srUjieQnsNBISq+9B03WP2akBKWj
X-Received: by 2002:a17:902:c40f:b0:216:4676:dfb5 with SMTP id d9443c01a7336-22c249bcf31mr43502515ad.21.1744728192910;
        Tue, 15 Apr 2025 07:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ/NVm2J2Frp2qVIu7jmM70y1rV0QM3EVe7tEZI159lNxP+rZoD1H+NG3PgRpb5VDwglxtyg==
X-Received: by 2002:a17:902:c40f:b0:216:4676:dfb5 with SMTP id d9443c01a7336-22c249bcf31mr43502085ad.21.1744728192475;
        Tue, 15 Apr 2025 07:43:12 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb5484sm118444955ad.183.2025.04.15.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 07:43:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Handle of key_cipher in MLD
 AP
Message-Id: <174472819184.1897624.3961835732025439774.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 07:43:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fe7081 cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=FZy-mCtp5WpF6d4t7MsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: D_xM2z_Zdu0QkOzecqjf0gBnWWn9eHDD
X-Proofpoint-ORIG-GUID: D_xM2z_Zdu0QkOzecqjf0gBnWWn9eHDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=646 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150103


On Thu, 03 Apr 2025 13:52:05 +0530, Aaradhana Sahu wrote:
> This patch series ensures the correct handling of key_cipher, which
> represents the group cipher of the MLD AP.
> 
> Aaradhana Sahu (2):
>   wifi: ath12k: Resolve multicast packet drop by populating key_cipher
>     in ath12k_install_key()
>   wifi: ath12k: Introduce check against zero for ahvif->key_cipher in
>     ath12k_mac_op_tx()
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Resolve multicast packet drop by populating key_cipher in ath12k_install_key()
      commit: d61c0b3c63462d17e63e5a2b4815e0f1ad17f57e
[2/2] wifi: ath12k: Introduce check against zero for ahvif->key_cipher in ath12k_mac_op_tx()
      commit: 4f4b067dd61695e860f97cae6ed6589a3a7dfba3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


