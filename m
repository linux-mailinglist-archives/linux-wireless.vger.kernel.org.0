Return-Path: <linux-wireless+bounces-18775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B7A3100A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA421686E7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEDE253B41;
	Tue, 11 Feb 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OqAoVPam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21904253B5C
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288680; cv=none; b=JaSeHq//UqPNWMCoheiUtcUqzOqimFdhYaqAxk7VrpWQa+TM6P6d5JMVxdQC7fEjAdbxLqKpZBFhM3ZLnBXVV4Uct2MuiEK5wO77AoqAaEyG4o0NnOe/FosfKobY3giVIfg2zS/g2KVlxw25mUWYcTxYfVT81FywdbcRa+UMGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288680; c=relaxed/simple;
	bh=+wCMONy8d3z+rw7HxAuBOURPs1Ih3S5cFck0S5GDvxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=paWsIOJkVphuCgOtY5Gt7cgOG7OPrKP+qGnuGpNKCwjbb+/ZuNdJwf+z+sGz5lok4LmXFdWWlgt5bo/KmMKrOWjcFfiMSXOyGMAhudwC5Yagh2heipBhKJ4KJAiWS/Ar1h8xURw7SSbFFoRzedF3EblfinjaT4wnyShHJSFoYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OqAoVPam; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BBHpnF026413
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fHGQoHUJJ3M9GYONPJLmi/IU0ZcLFQQCbg/fH6vJgZs=; b=OqAoVPamUppvlOUY
	MqmRUCUgKF4o6k/e5d11M89k8ZYJICq6LYlWzks1ChwBgeEFo72YHCnQyhyR3Fzg
	gmKYstnjUCIbPYj5iT+e5YW1lBa1AtqH48j+5O+30+8vlg2B7D+oFdlsF/vElgsc
	6M7I3qrZxAqnsWM+f+vK9HWmulRTmwMZ2RonZmrm90nHyA08ZGzuthC6n+n6J6OS
	W3f3H7Po+mRuqTzhZJg+Mb+Wqkq2XjihfafrGAc+2i2gk2F5oG/x4S8eYT9wpGdi
	EMg7QD8+zRQ7hofqrvJID2sOZYDeyoiLPjQAmcec4HGGMsRxAfXOOgomMAU97Blq
	atyoLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j58s3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f7671a821so60546965ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288676; x=1739893476;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHGQoHUJJ3M9GYONPJLmi/IU0ZcLFQQCbg/fH6vJgZs=;
        b=GkH3HCQRukrFvUIwnFKdHuSfMi9Xd692lWEweesQIJqUDM/qMFqP8cW23iWw0ko0Ph
         WoovkSbAbeZ5qJp5cHibbqCHz0xVLAFrhUUfcd07M+hELAbiL3dDIOxroYVK6/zhMg1N
         ZzZ9h2WEP6xT86F/0UlPg8iEOGrRpvUfQX/1hPDT0ZuAwjye5uVasG8OqUzfzZ42/ano
         7K2pwyxCoIWfczsQNTZiFTNNuqAs+ve5JlWuLoQqn9+BDlBPufKtDkMGNSgEOWu1gXOD
         WA4IMw8dz1AkT9sY0zU5vASKasgPBwikzEiRl8AEeks8xIlR6ZQuDFEZdCt0SzDt9pCZ
         89iA==
X-Gm-Message-State: AOJu0YyXDu1/u8Y7SI3SsKRiRtv1gHX8BZFZMAgdFvuIZOQYE5j50Pcb
	cFTcLUosM6SCYkhE5E95Cp252hIDFnphSxNyXpdn1M7pk7H1dDcgNecIWU9m6/SxUTxDmk062jJ
	SbjrbyJBgrQHlHkJ2OfgXd7WZ+W8sE7y7pnA913RVZL9+ekrK6FPQMFb5UayntuU4kMAR8/zxTg
	==
X-Gm-Gg: ASbGnct5Eat/zVlolvURkiwDHJ+I12ZS0wpEgsMghzJKvvlUec+E3/fsNxwoPVIoyMB
	rmXmbnPnUBb9zHjADXU4XKJX1qEBTOlcd5Yr2cU9y+L3OcInPQxvWWQ8ieElIWQ12BpXDxM/YKy
	uyjl0dTXzpdHJPc7sS0k+0/Cg1Zr6ebbsqY5jcI4Ca0AazgU+cdMSKtF0XcKcaXzLcx956UGCUb
	knkvGG6Mwbcauu15z9+3ZXiIqcwd+JRkXwYmzxIUt8WilsKj3jswd+AwwvDz5T1oKo/wd/qpjnC
	gYkjhGnSTiXOrNrMg15/a2+fljFB1UPJcHIe+Z4R6A==
X-Received: by 2002:a17:902:ec82:b0:21f:61a5:67a5 with SMTP id d9443c01a7336-21f61a569b8mr220994135ad.42.1739288676352;
        Tue, 11 Feb 2025 07:44:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuZkvfQ9erC2HYKuju8RR1NUPF5+PChkcju26ygV2u22Mw86GTThdGbqeZaAuS/iwNJ1FJJw==
X-Received: by 2002:a17:902:ec82:b0:21f:61a5:67a5 with SMTP id d9443c01a7336-21f61a569b8mr220993805ad.42.1739288675964;
        Tue, 11 Feb 2025 07:44:35 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:35 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Kang Yang <quic_kangyang@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241219110531.2096-1-quic_kangyang@quicinc.com>
References: <20241219110531.2096-1-quic_kangyang@quicinc.com>
Subject: Re: [PATCH v4 0/2] wifi: ath11k: fix full monitor mode for QCN9074
Message-Id: <173928867460.1115150.6118883106228249215.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: lrh4LRCgDxbAnWk6MVX4fzsIGSmFaXtw
X-Proofpoint-GUID: lrh4LRCgDxbAnWk6MVX4fzsIGSmFaXtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110104


On Thu, 19 Dec 2024 19:05:29 +0800, Kang Yang wrote:
> Fix a warning and a bug for full monitor mode. With these two fixes,
> full monitor mode can work properly to capture packets on QCN9074.
> 
> v4: explain why change the srng definition and initialization.
> v3:
>     1. add fix tag for all patches.
>     2. typo error: occurr/occur.
>     3. delete unnecessary Unicode characters in patch #1.
> v2:
>     1. delete duplicate commit message in patch #1.
>     2. explain this fix is for QCN9074.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath11k: fix RCU stall while reaping monitor destination ring
      commit: 16c6c35c03ea73054a1f6d3302a4ce4a331b427d
[2/2] wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode
      commit: 63b7af49496d0e32f7a748b6af3361ec138b1bd3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


