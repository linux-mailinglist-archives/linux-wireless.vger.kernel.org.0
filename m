Return-Path: <linux-wireless+bounces-17440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A83EA0C148
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A833A60E0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293F1C5F20;
	Mon, 13 Jan 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZu07Cug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55981C726D
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796170; cv=none; b=S9ix0ODZDg0/+vGQMcZzRn9kyvMW+Q7o5t0aKCpOxkKgq9St27bH8FIrxCiSSkj0vv97zZ4etR66oDC+gfYK45ONsix+DBQni06/gMBAFVhwFhf704xFYix+CBq4Jyij6TE74AD7e0i1VJrCHbKkhBc6Y27sWhEFv9iYZxrJ1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796170; c=relaxed/simple;
	bh=BJfxukrV0cRdE6T03hzyj+t90BiuSUWGBEhYyqqwb1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do5/Ktp7pMSwRbdD7pO0zL3ZGRCWRybVmhSyoWUKlD5Q31ZuTMZf9QakMPoJ+6OrIr1lI622+9L/kzs8jo4etYew4rfJQ6M41zw9ucXqF41VGYxsETkypv64UBCaJbYnCnfV2LcN8gtF/wNZVrbxVorsWdTc4u08z4O7ySTQiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iZu07Cug; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIimsB007912
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8GDh/3Mropk8svO83IQMbA/eQXru3jFiYV22yyRJ8u4=; b=iZu07CugBvnR2gr5
	FKLiASmW/OmMklmxyjRx7WiUnsA4Dm05NSQ150m8sKKWkT2roG9os5K6cxwRC0Qp
	nZ2+nUUejjwzC6JzmzfrUUjLYEbNcR+xAXCJap3tb/MjfIlpA3OC+t4zmxo34sC+
	w/dYW7KnkRWNDeKNXhtBgwIBEj+ILqua6I8ZQgN0TTiUETWUvlskupIZoXbNZ4k+
	xDeEsdLO4ixfjx3zj+DZvcBpmBTPX+bNU6EvF6xnAczwLpyMIcwl7/gBS7BUE4tS
	M29NTSx/qrOlJ2hmX7vdciQ6jMePpMapjZamd5lbJi3GRMRZzFswn6u4uQYhc2I+
	AydICQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4458cn03ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:22:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef6ef86607so9561150a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796166; x=1737400966;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GDh/3Mropk8svO83IQMbA/eQXru3jFiYV22yyRJ8u4=;
        b=wI3DTzTkdqDmJ8zptC44aP3+mNliXbvG6kvhymkIY6wyDr9KHmH7q2sj7J9bkuxiBM
         ng6fdOR752HzF6T7w/T/pai89xtmQPm8LffREc4MX0N80HvIy7jp7ZO1lp4dRkCg6qlF
         loVWdQmSFEJX5xWdRO8MRPZIQK/Yb/dCl9d8nh4eaRmrEOkGXOlVfSwZGFO/yH+EW6GS
         0gyvmCRFs93+Y1IkE5ctSroZFuGD4EyO90iQNy3rnlahMHXPzyGz4jVTWiEOOUYrV6jQ
         CvdyXIoKjh0yIMIWYiz853Mc2mk+0PPddlg5YCgs3n0nc55ayeIOg/F+ClchWfnTWF1o
         2hDw==
X-Forwarded-Encrypted: i=1; AJvYcCVy5A/mCIlICqJNzElAUvyWG4Fm13BdZthRM/b0RxLfYcopKxervkJcM4ysqF3vBSA/btt2QDvRbcYuV3Qvpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYFr/JPRhLOpi/IITS33kYFsR98d5VFKlt0hIoRwuDgx691Ui
	yc23zRrjC799jq6DtJE4blKASEVhbvS6Jq0lm1AfwWIPUYugYR5C+4k3XJ0GohB5kZRqq0BZ6ZC
	IggA8fCvZudSwWg5kSRxOmIPbarq6EOXZC5GGcn6p6vCuIxSSwWnNQKDtN26Kd8hADA==
X-Gm-Gg: ASbGncuTeLBkU1gStHEsLotKquGHB/82k1qGXzmXEby3ca0EcdS6CPruwEpTMlO+DAk
	kmLAM7AWEGIuLXiAu6gPUBi4Hq7rjeiSTfMQH/EdKfvDZt5JyLEX750sZ8JUDSZYJweHSzaA5JE
	uuE0ibMPbEFxmlPL9PjgHUduW8/TyX374KDQ4Howyk3q1RXuHcyAG2TQGS2pKKT7FDjsSqcl0gd
	N4mURWvo12YZIwHPfoaX8BKNNtdcDF3ni5PlfaFUooZ/Luu5mRKAfuAjKsLiY8kwYLrmkzR6sk7
	20R+NWq6UcdA2Nw+OhZgK6KzYmBh8wXr31h8L3qA1POJtlau8Q==
X-Received: by 2002:a05:6a00:4651:b0:728:15fd:dabb with SMTP id d2e1a72fcca58-72d324df33amr27007525b3a.8.1736796164767;
        Mon, 13 Jan 2025 11:22:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhtJVs73Q1pdcrf83MYihvTQtpKHnSW5FChfr4I6BTVHklM0H6RMBeISqIIO0FY+xsXriGFw==
X-Received: by 2002:a05:6a00:4651:b0:728:15fd:dabb with SMTP id d2e1a72fcca58-72d324df33amr27007366b3a.8.1736796162997;
        Mon, 13 Jan 2025 11:22:42 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40681b25sm6415544b3a.149.2025.01.13.11.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:22:42 -0800 (PST)
Message-ID: <f3e8a292-9d2a-40df-a595-bc0917def320@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:22:41 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] wifi: ath12k: fix
 ath12k_core_pre_reconfigure_recovery() with grouping
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-6-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-6-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tdv57gq6A5QooC9dULRMjB_xiJQvxr03
X-Proofpoint-GUID: tdv57gq6A5QooC9dULRMjB_xiJQvxr03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130155

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> Currently, ath12k_core_pre_reconfigure_recovery() reconfigures all radios
> within the same group. During grouping and driver going for a recovery,
> this function is called as many times as there are devices in the group.
> Consequently, it performs the same reconfiguration multiple times, which
> is unnecessary.
> 
> To prevent this, add a check to continue if the action has already been
> taken.
> 
> To simplify the management of various flags, the reason for hardware queues
> being stopped is used as a check instead of introducing a new flag.
> 
> While at it, also add missing wiphy locks. Wiphy lock is required since
> ath12k_mac_drain_tx() which is called by
> ath12k_core_pre_reconfigure_recovery() needs this lock to be held by the
> caller.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


