Return-Path: <linux-wireless+bounces-19319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D633A405DE
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 07:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722E3189F2B9
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2381F1913;
	Sat, 22 Feb 2025 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VDLC9YLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676514F121
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740205291; cv=none; b=OaqUrJUvOc9nmGHuu+Ei//pVGRKp7Q9yaz/jjXVPUdR/Hp9brwcrNfXpA4D1hTm15PqDEGehDy3PP1s/T/0A1hrBkGzfKzKFXlNTWsO2V8dRzm7N4L6PlsSSkHqwqsx5drVrS/cDG0h0sWC8QIoYWvkj6SwwxSw8T1TdWQhIzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740205291; c=relaxed/simple;
	bh=UVZNwO7VPcINrjZp/U/2/vebbODTXtK1J15nahCTzvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh/wPG2d/F98HfMekin7EQaHe86icrcmZGBS2Y4hwKjn/9lk3jDmNwUDI8YqLGY0cEzRQg9XTsx0Ejh/7m4XMvRDF0m5b1l1zCaKGLiNp0F5mN6V5lCCTxq/YRysashJbO1QaGOkp9cMbsjqRYemrW3VcBvnP1ie3vAYwQ9/6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VDLC9YLn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M5wcYr012394
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 06:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NLuS/fQFdeAUaLvtNfjMp5wzz4vO8rZ8NdHQnoz6Qu4=; b=VDLC9YLnsGpHMSAV
	m9LXA2Fjc+o2KAp2tFIUMtUECZHLk6Rw2sivhTiUwboRMTokBOxyIhKncepow18x
	6VX5aSnsaM1QUY9A9WGd1akJ8qBgmqV2ofCqKn5zwfXtBgSCbrF6qXzlGiMcq1Pz
	dyJz9oOuo5c/buwuq1PgJ2JI7ziDSKjEkv8u6718ZDRJKl/kFW+1CRXi7AOirE4Z
	xXaKqHoxZMioi2P/p58EF4ubSdT4zGje06wcMeXx3bSuDt9TM6hxfUO4U/D17Es/
	htirnhk0VOfjcC1gOeVdgUFdM/9XOIWVcAVDvhi+FvUbwEXjhp1r/0TvgDFwBP5V
	RsSykg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y49e8e6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 06:21:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so6122411a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 22:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740205288; x=1740810088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLuS/fQFdeAUaLvtNfjMp5wzz4vO8rZ8NdHQnoz6Qu4=;
        b=XvFpFaBnIeq3TcdGds/APT8aroCqT/xjRth7loIcCBn7SG9x4McmgEYKT1CDllQVaP
         c4HVo2u3AgZ1hM5pebhCQOZVvLxwJdaAC5znSIpE5XUOEa8iLNqGl3Swz5/Xqp6UlU2s
         fB9nOzPeNHKYk9RJj91by0Z/SsFeiu/yFZ4xvFYgHuQj7zcPqyxUtKqKVua88oOvjcNb
         U40S9eV+pnk7Q/ZzkwpUD+RrrfufrLxyxrQo5Otje1ZV/HvPy1Vf+apx8Dz+VRzXIv8w
         1cprT77lxdmMf/BVgcntBkmmXwCkaXsDw1m6+T8pibVM7fkTCEVSbnfiPJOWiW/y+Oto
         ZE5g==
X-Gm-Message-State: AOJu0YwbfOBoYCZz7twUD5+Zr5ULmC8hjEn6GXIsZF+U6wbcWLIfaPu7
	bYcPpiMGjcinX6QrnJrSG3hwWVcx65H8lxzJrkaQ7Bm0+9OWvDqT7BoTlGjK9lgiOhSDm1EgzfI
	Aw5DwrxdjqvBXpv8q0EaAcAHFsagAn/RehkuZ/kfXe1ogh/PYOFXI8noGXk9IE1h34jclI7K0dw
	==
X-Gm-Gg: ASbGnctPBlA2xFqPIxE6l/thjT8cNFVnSPwfwAwhFv8jfenFz28vwVTMI6oLMxtMjrv
	F8NsSi1c4pLEsa64SivxrWwJKyF81zkbb7xyB88QcnSALBqn9xuVzG8zx31N+idXzagrbhtwyT4
	Hm4NKdk3SvykIo3tqFO/rom7lkuRm0M3qPikrSpxMtIJ0X8P48Yujj5K4nhnEE4mfHszDZNDsqI
	2UYPPtt5ZnSF4ccUTRsw5zBAMZRFKsfAGIKMjA6R9MRMvpRuv7vo8EMbdMYh8fgay0Do9Tg06rU
	Z8861oekumRVlnxGH1YSxt8nK6cvEttVO4YsyrPsp5J7AbQMCOw2rhnmAyaT
X-Received: by 2002:a17:90b:5201:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-2fce86af0b9mr11037804a91.14.1740205287987;
        Fri, 21 Feb 2025 22:21:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3E4+j/BLmEF4Q7LW9se54I5K4FhcH0koIkMPTHuO6ghxRVZsQFseo/0mgOCw9usR/9gRcwA==
X-Received: by 2002:a17:90b:5201:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-2fce86af0b9mr11037768a91.14.1740205287621;
        Fri, 21 Feb 2025 22:21:27 -0800 (PST)
Received: from [192.168.225.142] ([157.46.94.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb05f885sm2440615a91.26.2025.02.21.22.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 22:21:27 -0800 (PST)
Message-ID: <a9f4e06a-1d77-5ab8-83a2-59e2920d8dc1@oss.qualcomm.com>
Date: Sat, 22 Feb 2025 11:51:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 7/9] wifi: ath12k: fix NULL access in assign channel
 context handler
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250222033002.3886215-1-quic_periyasa@quicinc.com>
 <20250222033002.3886215-8-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250222033002.3886215-8-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gj858XNwSeulNbM9CkpIKlqvd2KUNbxN
X-Proofpoint-GUID: gj858XNwSeulNbM9CkpIKlqvd2KUNbxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=938 lowpriorityscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502220048



On 2/22/2025 9:00 AM, Karthikeyan Periyasamy wrote:
> Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
> (ar) gets accessed fom the link VIF handle (arvif) for debug logging, This
> is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
> access, avoid radio handle access by moving to the hardware debug logging
> helper function (ath12k_hw_warn).
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 90570ba4610b ("wifi: ath12k: do not return invalid link id for scan link")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

