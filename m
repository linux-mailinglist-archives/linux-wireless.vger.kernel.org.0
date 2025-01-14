Return-Path: <linux-wireless+bounces-17512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8683A11289
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 21:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86161889AE0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C921207643;
	Tue, 14 Jan 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WY+3jOhe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAD232428
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888056; cv=none; b=IUfJBfnnti6ogh3qvDv0C9XsQfvStk1s9vIQuut6r8G7pw66j0nUrWGjkcXVIhQLG0ss4FaOqUSGJZN7JihkWUI/Ihn2YwzrAhES8fjE6Am/1iB3JcljFBcHvi8YLREhA9TjbOXSrV+1X0eKx81iMoPWXY77aFDkawrWY6wZCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888056; c=relaxed/simple;
	bh=Cw8MdOgeh/1kyY3VYUakK7ID472ye/9vOwtJjk3JVYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kObbHSJpgQ8PqYV468BfGZRbmbC50FfNBh5+uIrA0bA+/02HrNqo8ahdFSHOHbmR/T0uZQTFPR7BXso0xUpH0TzfR2Tt778ab+nc3CkbhmYYLh+ml9jNN1D8KZIfZP53lFkfwvXoVQ189qQ63PaEzcVaoK8+KFiikFWRA9+FBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WY+3jOhe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EA2bbA005895
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 20:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rSzsf5GHYJVFifVSYbpjTRWf1wVywB5kddjOvlnWrW4=; b=WY+3jOhevpCVr2+B
	NsCUsKZm8vjq1cGT05TZc8k7hkiogRFGEIrWWk3iRCyN0xwWL+lEqX+y7QKFWFft
	Dad83qrPgVQEAynTIf23TYAiUHv9TfcwQRrhoqLA1BkKassO+VQLDVcyKYDCEfGR
	Cp7kDfPszmgOBpFAiAPc9+tWvPMdornNxfZh/XIbwbqH5m9gXDnppHEiQBU/cD7i
	/e+He11czY594aSg7rXySWDUQivxxaFG2tpOkiaASfKOXM4r027RGEkFMoqR3uxw
	F/C2yPp3wjZUgmZxcu2WAOMU7zSUSsi5OkP4Ri0IL2WX5wy6K4Dci3u22hSEeWYA
	QXD1rA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445ntx9ebt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 20:54:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso16673397a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 12:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888052; x=1737492852;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSzsf5GHYJVFifVSYbpjTRWf1wVywB5kddjOvlnWrW4=;
        b=NaV6fTcwLB3UtBMKJK/cmv1tnhEefX8Wu58cEWK5msqtlMd8eR7qTY9TptpDxLI70e
         N9eivUj12MLcypAoZ2cdftUDq4fgdC/OaL8q7dsvJ09VNAOjAtQUMcFXjcgLg5r14eiW
         iJFJMv5RZjGws0N41jdP3+O+Xf3WFqMvQZo+AUANItwjZkJAFME3NgQN1sUAFEdGa7DZ
         0cKbj0x2NMYfBhxvp2Bik2N3rfbrV3DqTK6IJY0Nubt/3qyzGjJxhSf8LA7gJNLvpr4a
         /s0rNPfEQlPZZzOrRi7Nwv1VekUnaPeA3vSL0E57YpdKAxJQpkP1Gae9DtkKenPWwmGN
         ACzA==
X-Gm-Message-State: AOJu0YzuiR85TmPAHQl/q9zsh+Nlt4GlyKQIJ9Mkc5Tq8kEX90h7iHaH
	1EvaS0XI5AWCA63Ie/XZuUcsI0gNxfWpLK7VtzW1Sz4gR7J5pODuTN8rhNb+AFuDHHtibNl6BvR
	mc0U9X0GwW0CXzEPKeZ7yMKL9gIcS6p/ydW2SzM1U6YSUJa8sVnLdqj2iualPVElsxg==
X-Gm-Gg: ASbGncvPCEAx9ZnfIreeHjPRkp+3YxcvsVhc9IKqiuob3RSPNObct0h9siMyLu75rDn
	M5AW4RD0AUP6PSjIUmSlXdWZZVW6nkY5TiWRtZBCYuvR7KKLc0trYs3odophhcdW7wat/36Ahoo
	N4f8BKDHR6ZBCtm/Vi0Hsc9StrcwPm38+vamq8qhjS7q+s9d2yCQ6nergnprKhSDMpZm89g045Z
	1Y/6E6M0Rt+EUPJYIzJAfZD5LHuK/iumEPeHIOFRRuM/Q7ldiy6Lfw2dkwg1Ryf/WTltq0mK2wT
	NIWxkJ6G4HxTuqvJRQ==
X-Received: by 2002:a17:90b:538e:b0:2ee:c4f2:a76d with SMTP id 98e67ed59e1d1-2f548f59a46mr34824927a91.21.1736888052571;
        Tue, 14 Jan 2025 12:54:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyum94fkerAe34rcqee9zya3zT22ZWhlH6+QOJIs82IS+WVRink3onr9PAiSGGBm5M7gq2uw==
X-Received: by 2002:a17:90b:538e:b0:2ee:c4f2:a76d with SMTP id 98e67ed59e1d1-2f548f59a46mr34824909a91.21.1736888052186;
        Tue, 14 Jan 2025 12:54:12 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad3b7sm12138463a91.31.2025.01.14.12.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:54:11 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
Subject: Re: [PATCH v4 0/4] wifi: ath12k: Fix the static checker warning
Message-Id: <173688805162.2759377.8404061947249707120.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jan 2025 12:54:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: cxcA4qR64ktDkO44Ox0C_ySAy9dd5hnE
X-Proofpoint-GUID: cxcA4qR64ktDkO44Ox0C_ySAy9dd5hnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=625 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140158


On Sun, 12 Jan 2025 12:46:26 +0530, Karthikeyan Periyasamy wrote:
> This patch series fix the below Smatch static checker warnings
> 
> Warnings:
> mac.c:10941 ath12k_mac_destroy() error: we previously assumed 'ab' could be null (see line 11348)
> mac.c:11007 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
> mac.c:11013 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: Refactor ath12k_hw set helper function argument
      commit: 21261e4d564e866bdae810b4fb5278a3a6a1a6ed
[2/4] wifi: ath12k: Refactor the ath12k_hw get helper function argument
      commit: 812a30271d48cff5edc39aeb436b3bebd558f5cf
[3/4] wifi: ath12k: Remove ath12k_get_num_hw() helper function
      commit: 54fcdcf07baa9cb34359094f1b829b29d0845cb6
[4/4] wifi: ath12k: Fix uninitialized variable access in ath12k_mac_allocate() function
      commit: 4aae869847ce50da902005ce4d84505d54e739c9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


