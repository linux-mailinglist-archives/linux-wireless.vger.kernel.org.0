Return-Path: <linux-wireless+bounces-26290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D878B21E93
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6851892DD7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731121D3F5;
	Tue, 12 Aug 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="krhvnjPG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED9311C18
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981285; cv=none; b=f/Vem1Y4rnHLc4xABHYgPk2xohdEuh8QgQjhN+REPbBAfKeAY6SvXZR1DRNM65eZ3aPPB+MOlYbc2XuEtvKrce/wYkzAsEqBW/F1JZQGMmpwaorkYQJfgHzuKap+Z0L6uSJmqotTSikwZ9tkU2Hu72s5eES16/Bx7t/jl2DhUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981285; c=relaxed/simple;
	bh=geAyAmShKzFxpAmKUswRlpCbH1VYswO8YlupFkU0w7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt4UrPJg6Uo09GlczOYKnwR2GhA3JCI+7QGqOr0PlnokaDPLOU9T+ahRUTVphLlki1F5LRw0rl8iZJKf0DwtywCv1yiXdD9/u6h2K2RBM38L2a2AFQu7wESKvSa3G3N29JVGHmbmf5VYKL82hjEiuyUe8oG2N6qN7nDnBMdCwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=krhvnjPG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5KxTK021654
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1X7uUXq+zJMT+hUeogVDygthzbLkkY0vCz42E7ikQoc=; b=krhvnjPG/RU93tKD
	03J7hpsgFH5/gZUAXsYAs0B7vBKKLXIwGtqqoXAYksihcBb7RV6wvgQDpFwaS56f
	ij2nj6PvEDbjIvMFuPUYNCSzQIB3sAc+/gxxpvpgGEXvjhje81EGgix0xHN37rXf
	u4b8v0/WHaR7BOoz0LLDwQ1fcvK0OP7XlMLvwnE1iu9hTgvvnrMXQK+NLETRjKsM
	kMk/Bl3kppuRiVi77eOKnza2WE8ponCB/EmLgYBEb/LjpwvSnwS3Nv/+U8Jr6Uy+
	y/F5dqB4ISxNvZOTu6my6VD4ibgq9ybkniJe33UOpzdLfzBH2WfcNmyG5qYK5Ibz
	IMDV/A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj473y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:48:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bfab12672so10421006b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754981282; x=1755586082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1X7uUXq+zJMT+hUeogVDygthzbLkkY0vCz42E7ikQoc=;
        b=u3ol5Bn6Cg9DxE25gy4k+IXC1pSP/mYMiWXXfc+NOR1tuIfNGfh1ZEVKSOYC6lqIBh
         Oo33MLML5VPv0mN+28TeholmHs8uHRXmkVRvCSiEFC/9GkZz7Obqm6FxHPdT888CuHuR
         sqDI8DHPhl5AVk0Xncjd9Lt9RLWxY27MSlgoIQuL2E5+W/m8erUM+jkwoz0a8AYNGpHr
         fQDw0T/bPmkNXtq8ZhgwFtJJDVXJTpD7nrqpkbsqXZmHx9XHAFljKct6vgfxgGgWgtZU
         Kfh9GKwVdgXYO5maHcadVVSS160K9eRBmO8LSHa7X/G9JGOsgsQz48a9PwvTcieBkYyv
         NE2g==
X-Gm-Message-State: AOJu0Ywt9wsrOKmVVlW7gkOeSOOhreBL1qCaYNujCIKjGm9LNFW+3iaB
	Anjxy5at0j+bbnzrStl1vyQSNPJ+A7z7V2JaeBmK0ii1EPbU7s31UZYQiyXKBCu5BvGSpd/VH+k
	NhEOvLp/g9rUWDWArm0Gt07NOYqojXpSpziH6wAU008sCsDwo03MfPDBULVHIozEQ0Li7JQ==
X-Gm-Gg: ASbGncve+7M170HAiQz7lzdgl8a/rg4zTKrSh6Dz1q4xEMmBIu7akYrFqelzeWj0Xd2
	lG2MSLrZyT92kE45ewEGYbM4N5pEBH/+eKxAKbeG1EuzANrFTB80GNR+2tGK662QEUyvqg674xZ
	kgeO4CjBXcdJsY8tW+Tqxynsig4vxhj3wWaT/nzrvRlyfScTJN0ITXUBvmA1WFK/zXgB/A6WtLi
	58z9FeLkLsFPcwfJGJ7S04afbfKHGoU7awz0P1ovAyqx8qnOmN26DsV/3rSCnakYY1s1zdPd1B2
	kWRte9ThmAgiT//iaMdfHf2pvh351Tj7GEjylkoe/VCfW47oP34jlRCHnyaUF3TWTeLZakWehDL
	0LL2B0w==
X-Received: by 2002:a05:6a00:cd5:b0:76b:2c12:334c with SMTP id d2e1a72fcca58-76c461a971bmr18576422b3a.23.1754981281723;
        Mon, 11 Aug 2025 23:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7H9Ql2feGPxhbQjAq2JDbE+sn/xtaVTj7G2n2qgBV+ACS1PNMwVZHn3m/nICxCW2NXbp3lg==
X-Received: by 2002:a05:6a00:cd5:b0:76b:2c12:334c with SMTP id d2e1a72fcca58-76c461a971bmr18576394b3a.23.1754981281334;
        Mon, 11 Aug 2025 23:48:01 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd6aacad9sm27578448b3a.124.2025.08.11.23.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:48:01 -0700 (PDT)
Message-ID: <cd74ca34-4303-b884-34cf-b5930359e327@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:17:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-current] wifi: ath12k: Set EMLSR support flag in MLO
 flags for EML-capable stations
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
References: <20250801104920.3326352-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250801104920.3326352-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX4fKz00y6SSQK
 ReoO1MYSI5cO7DhUI12DiVwJh8h7J74duYi109laEqE5gSCU023Co542YZwxIny2KlVRfJvimCm
 jFRUclmm3VgvefhjFrDMoJySTrFGWtO4JmGJzPjhetyAa17nBD61v8dLJN3YMXJlaHGg05x3EXw
 IxZhcB9P7mzBCs2dooTYbf6cPhLa2PKJ/u8qyPkoxruJFxYCmASyGVX2Kl/x1bngfqNJAuR1gYJ
 OImjnwNEVXKo46VafeO5HVLi0y3ETWRLmnVQwtNuPaWSNpJcGzuH7Dhyq/vtcetSUgVsyZAGiXN
 1ahLVBSdEeyKIBFepk+/UKCJ68f0X3zvHxpNUhiLZLUZilsxLfF413jpx42U/gdKkl9usYbkyWo
 81kwmh/n
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689ae3a2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8hMa9neySeqPw90dFaEA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: rozktNS2d3tLI24dMyJHUACC8Wr-bZp-
X-Proofpoint-GUID: rozktNS2d3tLI24dMyJHUACC8Wr-bZp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027



On 8/1/2025 4:19 PM, Rameshkumar Sundaram wrote:
> From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
> 
> Currently, when updating EMLSR capabilities of a multi-link (ML) station,
> only the EMLSR parameters (e.g., padding delay, transition delay, and
> timeout) are sent to firmware. However, firmware also requires the
> EMLSR support flag to be set in the MLO flags of the peer assoc WMI
> command to properly handle EML operating mode notification frames.
> 
> Set the ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT flag in the peer assoc WMI
> command when the ML station is EMLSR-capable, so that the firmware can
> respond to EHT EML action frames from associated stations.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 4bcf9525bc49 ("wifi: ath12k: update EMLSR capabilities of ML Station")
> Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

