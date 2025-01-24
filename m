Return-Path: <linux-wireless+bounces-17913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE656A1BC36
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 19:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40C31886CF1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372071D88BF;
	Fri, 24 Jan 2025 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHodCmzg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB91D7E50
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743760; cv=none; b=HmW6ucOFfw4r9jPVNMQahiCMl9QC2ZT7pTKXw17uj+UkX0DtHfy7fs8+djIvhLsG9JK91OKN4yCWJTxeLQcjLFx9BJJtBxzCfTdglkhzDyhC6xqgy6WSskOHzDeXs7KVxShDgc/WBFoukJ810LEBh2Ix3GSMk0+U6mpEeponXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743760; c=relaxed/simple;
	bh=hUe5OoMnb67u5YUI4h/HSv3LyQlvHgG+tgbXO5/l9Lw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HIEvTaG0NVGNbGwEpZWR37Uc6F+5dk6D+UsPYulhYeMV/qyvtMqRIlJu5y6QJw4kyjDRbULIbbicH0DWyZ3/9TCF7ixRdV/p9GILNNhPzVfPoOTIFUtH2tMhuqM003oy80oKK2o0j38UrpbigooPvnI3S01jgUvGKhbxRds+0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHodCmzg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OAgw6Y015692
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 18:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wHmAIxqURVXWtdtTWYEcXbv3gCxvkUyRVlPDzDmVyjk=; b=oHodCmzgTliH4ghh
	1mhL0NjWEj9oV+k58d7KvuhIkaqs0wkgSveQHTB9ybWiGc4hw2vmAjfc4U8kQ70d
	U4G8dW/DVk/JKLM0bXB8i5pY3raGzXTCtdF1tm6FK8IdZI4CkioVgm9S8uCm2FVK
	9B36dxtXRb2UvGhVSA4CFP6VzBn9tpjXEAAsQFgBKOUVPgjWEQKJyKX4IpdTd/VZ
	jGp4f5ghMDjFB7o2h3oo9Esdy4z7Vq/vnCpSKl86XaF90RaTDBZ5ZZMIjGfrwYcl
	8Xx/zvoDE8Tn2paER7KpR1ZqcFD7BsHtH7C2zkLSxX18KopphnnP6Cyr4Yrm2lkY
	RPzwcg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c9bt153t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 18:35:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso6535255a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 10:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737743756; x=1738348556;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHmAIxqURVXWtdtTWYEcXbv3gCxvkUyRVlPDzDmVyjk=;
        b=FXeYZXeOas42nW0Rne5z9+0wtAE2EpE2JlZXxmtM9K7Dms3Z6IsM7qPCtIAMoZBWoT
         FVWtmlaWewFNHXU744txRCNU43y7zbqfbW3ZGJri5/lKDhrGqX5K8/YgeJZR8XmzGF5a
         K3sZ5uB1/WPa59WVkTpkZElEq0IlsmjcoBFJPrIyjyyDUJ7NOPl0kCdh1V+UtDHxsY/y
         Sw7k6KzlCUrxQm9wzYQ00r/MFcIdx3oVaY4mQFOMddOtGUUjApBCQAlwq6lTk1zHWN7U
         Gq3niaWqHdm97cVSodXMS3i5OTYFaJx2MWDmZxAlB10PlBjJvbFebMjBhM7Ln30sAIRd
         h68A==
X-Forwarded-Encrypted: i=1; AJvYcCVQC3hK6SWiKg8fvbP8QqTYZW7DVWiCloOkDaHHSnfb+xtVNIxaSyJfHORnNHHKwbmr7MaWB3dCUBp+7wJ73w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UEWAHAuWh9WspHCLduHkA7RG5EggRGGnJ5m6fxs7LMbzQGJF
	R0ne3UlORhFbrfQrPKmwRZAEonaDDsd8pYIBdF4fPm8M8leL4fF8BGvejbt31IPnykNmjEBWZ5e
	dhIwK3toUKDQEDQOIrRCK9LlKB1bM5eCI3woicy1T5K129HwEKmCuBp311lySFUVQYg==
X-Gm-Gg: ASbGncs5wz8L1xlr72jp4cxHelc4RmVK/AMXvKcMDMx7Kpxegfw6wNmyrgYaOzZ+Rxq
	wY3puPHj3zvPZ/Rl0rP8S5LYhfhH/ZYeVXgC7vFcr6+5p6cRcYEfl9V3NuqR6Bv8vzyX8rQmZDu
	Ka6fJ0GKnLdW0LZ5k3nBLXa7QyelU/hb24PBKzXXC12ndjzyBcOq9nWi2x7u1JS3OVuPFj1XMnW
	Gb5bnO+mG3kxm7vgWT3GXcvF2WvGbtDtGn7PYuT0OUtSo6PZwYvYu3aKORRmiB4PhwLb3PDiR+v
	IYvgBxYMgs3aE0sO5DLIsPpZ8YwLZD8=
X-Received: by 2002:a17:90a:e185:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f7f172999dmr14059620a91.1.1737743755976;
        Fri, 24 Jan 2025 10:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2A5sqwh+G2JHyQhuyZNUQRQ8vdz2Rq12cJrIzFyu4bBH6D0M7Vb1nVgglQOkkMw1p2+8+Sw==
X-Received: by 2002:a17:90a:e185:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f7f172999dmr14059586a91.1.1737743755629;
        Fri, 24 Jan 2025 10:35:55 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa83f8fsm2049632a91.49.2025.01.24.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 10:35:55 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250123-fix_6ghz_rules_handling-v1-1-d734bfa58ff4@oss.qualcomm.com>
References: <20250123-fix_6ghz_rules_handling-v1-1-d734bfa58ff4@oss.qualcomm.com>
Subject: Re: [PATCH for-current] wifi: ath12k: fix handling of 6 GHz rules
Message-Id: <173774375451.3015659.10376753884780529993.b4-ty@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 10:35:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: bG1zN9bkg1GfpuUgD6aHnrh37wibl_nV
X-Proofpoint-GUID: bG1zN9bkg1GfpuUgD6aHnrh37wibl_nV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=786 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240127


On Thu, 23 Jan 2025 21:51:38 +0530, Aditya Kumar Singh wrote:
> In the US country code, to avoid including 6 GHz rules in the 5 GHz rules
> list, the number of 5 GHz rules is set to a default constant value of 4
> (REG_US_5G_NUM_REG_RULES). However, if there are more than 4 valid 5 GHz
> rules, the current logic will bypass the legitimate 6 GHz rules.
> 
> For example, if there are 5 valid 5 GHz rules and 1 valid 6 GHz rule, the
> current logic will only consider 4 of the 5 GHz rules, treating the last
> valid rule as a 6 GHz rule. Consequently, the actual 6 GHz rule is never
> processed, leading to the eventual disabling of 6 GHz channels.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix handling of 6 GHz rules
      commit: 64a1ba4072b34af1b76bf15fca5c2075b8cc4d64

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


