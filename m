Return-Path: <linux-wireless+bounces-17430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA2A0BD0B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359FA1886A89
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E72297E8;
	Mon, 13 Jan 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zscyj+DI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F120F06E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784742; cv=none; b=NHmKvu8CpYvrfV1//6bVH3EBhGRHL7AliVjJKcZuFBqwtVgy27IVwM62NG4NFGwW3e196vY7rNYKceFeZpZ/IN4pTW1H+7DxEjXqqFeE55peu6mTyLri53OlBEfc8mqMcp2E+bX2YuL78KQPoS+Bkv7tTdwXncy8nBNguqsB4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784742; c=relaxed/simple;
	bh=CNspjU3Fqz+yNGyEdLm7rGk/2xt1VQwwUf3V9TkkIGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVoWFZq2aeDZB7AekYIIZBnk7gqueg8hfXQu74CTmC3ofAMncHkeM8gvfoXwnrXog7le23yPe+OAmUYknfYvR4gWSoPN2bzDaH4pJcIa911jVgJeqU7lYunSgXDg6+R+DdKbfJOAkXzHVXkXYJt6izpMB+qPd2WpdH5VSy3ialc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zscyj+DI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBlTno006596
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 16:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ieWuwDOy7+JflIqyjS44bPCt4QQyEsDp5BcB7aphpzA=; b=Zscyj+DI66Ycgen1
	QK+SOzEWqxm3iAPgPsGVx9RKgjYjcRTim8EJBQAlFrjLh3LHVis35eda31yUEQgh
	CWlz/phIH//pFv9QF6+FYHtXw1vjyWm0hjkL13Ny42CEMW7/woSF8QfkCfFVWP/a
	hXnvLM9FFIAWpk+B/nSZnLSwKoQ9dqwRrwV0OHh1aiV6lQD5CSbHgnKETAJA4PJW
	rtYmjZZdv++yjAuxe1oLXvtWBJdIv4MfSVrsvB3+AIK2qOYteVoOwDnvvJUKpVxb
	8oQgTZc3LH6jAXAZKJFnZJNlc068lHF4RQWdYKtDX6eYi7S9X54PUoaOiev7rwhI
	gfwOfA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4452938uet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 16:12:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2161d185f04so55126155ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 08:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784738; x=1737389538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieWuwDOy7+JflIqyjS44bPCt4QQyEsDp5BcB7aphpzA=;
        b=KynFNLdJchlH0p5jHsp1PDPdzFsKDApvcD1MRHFy3JPwuDXoU+N1oms6HWLL+NoRTG
         urEglRwFjIASm35pD3cuXpYkwDv1aHuJAfrdbV7uBeeYyvt95Uxy8AMQThEfnZIy35P0
         QlIW+3seRAlbY9QgcxwxKC8zVogfxUJLqxwVqB+WhBLHnj8NpOAkepwO3emi00F9Icmx
         u2nsSvh8ywreK11lDyojfyS/IfIU0sNnbVgwWFL/ZfNWDTgUoyV9VgREguP+ssAb/pI1
         ClrZy7AhckzUwQonuV21ZQ6urWcZ4GwyCO6yRq9ygxQsLXK5Xl97OMzDIsSt0gjGoIST
         qsOA==
X-Gm-Message-State: AOJu0YwAU3xvRvS+fIxb08ihW6BtcW0NAuAgZtKMP3MyUOGqNOouhMJ/
	mP45RQLl9IGVvbjPs4rKHSqDpVZTxYR/f3JNl3VMLjJJqNR1EuE9N4/Sp1aXUsnkedbUR75Wn5I
	xpUUqeNOVem3KCIIjRJRnOaNeqi8c5j14V9ayzlvkRkcB4mUfu85i6m6WtXNJbHYq0Q==
X-Gm-Gg: ASbGncsCXgv18pEHgB0Sokxv+0YV045i81Gp4dNyyUhZ+nyw+AaEOmIX4ASO31dX/W7
	5+ysySBJaFwjt5crGHpgczHL/v+WR+3yVpnXB9Gb5QfADRIbud4GT4VvzRyVaUhFAJCsYd6hCPz
	fElMHSlnWh48MEIWcd5Yu7j+M8ujnp1VQLTMWqMo6jNrrXErjjjii2lfdOQN8KRX45TvRfNneB8
	Oi9o4EqIJ3+KPh54shaF/gasCiZhtybuoGfKjdZWBQ7q7d5QSsm7Np3WTr8JNo+q26Cg3hfAwA8
	t8Ej8J4X7Nu00hH0EaDkvaB6e59UH/ZuIiYyV3levOEeiO/SAQ==
X-Received: by 2002:a05:6a00:cd6:b0:729:9f1:69bc with SMTP id d2e1a72fcca58-72d21f45b2fmr30050486b3a.12.1736784736987;
        Mon, 13 Jan 2025 08:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5MLo0uEswESY1JctsFSF9kdeKM7IksXCnCDnQO0Mc+cernUwKAZYoUDUMyldbdARRQ3L53w==
X-Received: by 2002:a05:6a00:cd6:b0:729:9f1:69bc with SMTP id d2e1a72fcca58-72d21f45b2fmr30050328b3a.12.1736784734943;
        Mon, 13 Jan 2025 08:12:14 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40568dccsm6064170b3a.47.2025.01.13.08.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:12:14 -0800 (PST)
Message-ID: <db1b3d4b-db7f-4c3e-9f58-b3cb3a335677@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 08:12:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] wifi: ath12k: Remove ath12k_get_num_hw() helper
 function
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
 <20250112071630.4059410-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250112071630.4059410-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nSOqYDk5BUCKxVNXxaV2_FsLlZUpEteb
X-Proofpoint-ORIG-GUID: nSOqYDk5BUCKxVNXxaV2_FsLlZUpEteb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130134

On 1/11/2025 11:16 PM, Karthikeyan Periyasamy wrote:
> Currently, the ath12k_get_num_hw() helper function takes the device handle
> as an argument. Here, the number of hardware is retrieved from the group
> handle. Demanding the device handle from the caller is unnecessary since
> in some cases the group handle is already available. Additionally, there
> is no longer a need for multiple indirections to get the number of
> hardware. Therefore, remove this helper function and directly use
> ag->num_hw. This change also fixes the below Smatch static checker
> warning.
> 
> Smatch warning:
> ath12k_mac_destroy() error: we previously assumed 'ab' could be null
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
> Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



