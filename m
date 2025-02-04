Return-Path: <linux-wireless+bounces-18391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39CA26CB1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94821166CD5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629632063FC;
	Tue,  4 Feb 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xj+UsbR9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF22066FF
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654567; cv=none; b=Smd+fFkghy7h4t33qn9ofBDzgSyslgEzCT0Ma8K8POOYNYkrjJsxJRcMVgbtxpkWlfqQAkCu9Cpo0xd2L/qd9g1HPVF5K/022k2BgDfWu8p+ockkG49rpaRXuizqwRKKBs3diqZHECvwCM9UNIuHDvovDD1ql7bSDYROJCyJSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654567; c=relaxed/simple;
	bh=ZhAq/oxK7dZj5M54Prtq8LP12WzijO6jogbZrQoKxB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RB168WBn1LCCQKeNB3v/QCq8WFRIWOe+fKguYCezb+TvhNAtvzxLfS5abPqM+HdCOIBsbs1oEgNOxMLNno8f4tptbHmE5BE20UDpjgpEWqxv0jtYYRCa4gWGHmfmsm06kAt1MBGiB8cI61HKTliF9VuYguhKLZGxOc0LPX58VQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xj+UsbR9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5146O6Ta016484
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 07:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jwe9hhdmFgTmkl8rrqNn5Zm+ObxsRt3ZsPNu0jCzhXA=; b=Xj+UsbR9k9T9qio1
	Vth8Rn0GKSe5dC4Kn9pQ5/OJUXK371OuWVaANA/vBwemipTwqaD3zoAGKL3OkcD4
	/DLhB4sW1M0L2ISbPyPR2/5YUDa7cadcGnlKHsSnvFDKgHWJFPOPdUPFTfjE0gs1
	dRzSFTCaSoRq2SfYOAgfR7tpInQeQZqsCwF4fhu6VsqWkWNVQmQwfrBPEH9wdQRW
	RmqtZjf0rWE+3/P4q5QCMFxYba/tLphH2RJ0fyN0QU61BnG1/Cf+0fFMFPBJt6P/
	8UBG2S71uDW1rif0MkQBa6LjBDSsaFHXRDTzP0gkyvCu9TJA+tWnSV8sMXLRtfk8
	r3VjxQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kdk884xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:36:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21dcc9f3c8aso82427895ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 23:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654564; x=1739259364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwe9hhdmFgTmkl8rrqNn5Zm+ObxsRt3ZsPNu0jCzhXA=;
        b=vniFo3tmhBaNDbdplYyHOMKskiuudegh5uaGp4gj/OVyzH++mgYLDSnP5GcXcnTXAS
         WZDCcQRKXgjCEFy4hqoWBeIjB+SxRhAM/WC1pu2XBBFQLyakSBaLvXLa8nl4PqzT7NPd
         sWyDew1Bsv6EX6sQqYJ1BtzLZdVb/VZafhX+3d/+nQwPH0XTd7khH0pqLIblRX1bVINX
         bMjhJ2moy+d6QKMpXeHWxlBeUqrGBTdHw+G57S81Ml90gCUvSZcwylEEUiHXLKKhpRtQ
         txdg4pLBcRj9CkT4DMUz7UJZ6qQKqOZrbXdizlb0PPcdhUEsyAw6dyXSpgluXJCvmjHY
         riow==
X-Gm-Message-State: AOJu0YxcZ1lEXl7J5eXQINcrJmbvKwsSCJmkqLQcBjAJdAI7bRajz30k
	+UESGxPUePZAjW5lMTERtYLem6icxqce59FNlSMh8WXa83/icoxxP7WYYp5CtOlLRI7mKTzF1Pf
	CI/m+STGufyF5VJNxuqW9N+bqkxy+/1yTS8hBYEgtJQitbNvvn2a8ijT5nAo3HPtMLg==
X-Gm-Gg: ASbGncvoQzQb8o/ubxGXeOtnEm5OTYf2EmHABIjXpEiGC/iJBkhKJTgvJ37UaBqBnwh
	pPAKDsB03Ls3CN+huIEIznx6U2cJ480okkXj6wUT2749TNAYMD21g5mJNsn9A8fVvvAA8VHzD6P
	XFgtK783yngQubTDmwyPO3aWvQzONcgp3mk9aInzfpGRSHcwkVxnJUnpG2K/fSe13zuUJHV301E
	m7NuGOjA+DTiglwdPDhpeVOkq5ZrRn67G4eGmTtOGy1pG/1lS31k6cFH9XJFw0dOlhjb5CvcJRO
	STUwpZsdJCiEB9rsvRK3eNmGgfKA+DXi7EypOTfGtU4qb0s=
X-Received: by 2002:a17:902:d545:b0:216:3b31:56c2 with SMTP id d9443c01a7336-21dd7e0ac70mr463120295ad.53.1738654564097;
        Mon, 03 Feb 2025 23:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq8LKo+cMyNzoWSHXi6DI8qCtmjVVFkX0lFaNK27TM/hf807aX/YBH8bXI2KOygnXzpPA3Pg==
X-Received: by 2002:a17:902:d545:b0:216:3b31:56c2 with SMTP id d9443c01a7336-21dd7e0ac70mr463120035ad.53.1738654563719;
        Mon, 03 Feb 2025 23:36:03 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f6f4bsm88244035ad.73.2025.02.03.23.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 23:36:03 -0800 (PST)
Message-ID: <b38ab288-bce3-db76-5ba5-f1a69f575291@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 13:05:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/8] wifi: ath12k: remove redundant logic for initializing
 arvif
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v1-4-675bd4cea339@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-4-675bd4cea339@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0jlIqx_lgTRZn81mGUAS5A23z2xKJjPj
X-Proofpoint-ORIG-GUID: 0jlIqx_lgTRZn81mGUAS5A23z2xKJjPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=851 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040059



On 2/4/2025 9:53 AM, Aditya Kumar Singh wrote:
> The current logic for initializing arvif is present in both the add
> interface operation callback and ath12k_mac_assign_link_vif(). The former
> handles deflink initialization, while the latter is responsible for other
> links. This redundancy could be avoided by using a common helper function.
> 
> Hence, add a new helper ath12k_mac_init_arvif() which initializes a
> given arvif.
> 
> Since synchronizing rcu is not required after adding a rcu pointer, remove
> that now.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

