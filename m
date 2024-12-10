Return-Path: <linux-wireless+bounces-16131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA79EA873
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 07:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11F8169DD6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABDF22ACEB;
	Tue, 10 Dec 2024 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9u5KqNo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E73228C8F
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810705; cv=none; b=Yhj/+xhoAhpwqYUOdJB1IEhomakrR1phi9Mk5ojc6RO/aDPPyaKenaaXAlC1mkoP8BZTiH7Eb/zcpUA6bbboo7FvZzlU3bQYIfw1lwE2KHbIrdsiLyQ2XCoqxq/9VpNrH8+CdX4TuCn/b8aExV2VotGXmRJ0vXHJYhkLBoGLYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810705; c=relaxed/simple;
	bh=/TzYjSJMFsOexNuvmKmRRmEuckGKb+afohwudQiPAcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCMnM9XCWJ7GzduhIM/0RnE8DJYIIY+wB4TWUrxh8y8E32xES5L4YDWTWZKBooxoL/ipLXCEZqFWu0yDq0mDMh0AgYPXfTeNVmnyBuQLEgSpDJYB6rndz27jLxwYO4qYWoF5PO1mDGpihKc7TfiU7+Db0adHUd+PKHaKX+JnVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9u5KqNo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA2j2Xr006932
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 06:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuT7sexJqrl+drwkywE4TpkVkXimVN+YkzX3PdE2lPg=; b=C9u5KqNovIKxiPE2
	Qx2IobVsWgK8/w96zZlTOUPmZjO4xax5pIBkg0Y5VXOLYkkdLjVnCihubtdfOptL
	LHcjG6wt/+JiFBVWQ4JPaBr7TmjtjWKtFR+dwBGiIMHrHBlMjNVeaLp7Z9CYwEHF
	H77cFovjkCQb01XxrMmhzZODerO0F91hHYtlWCUMkpulGNfResW+ZtfTnHCg1kb5
	212HZYD//h8JUOz+1BmOnVZKjRpPWbc1RLPSIY3cTIMhTTxoynaoqMgwJYwbosH3
	Kr2kwaq+pt/4+T+eKVe9Ib+27OcXkqebzGGwi3tRWS6lz5ZJCjZusFRFvWufK4go
	huJydg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e21bj8x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 06:05:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so6644382a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 22:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733810701; x=1734415501;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuT7sexJqrl+drwkywE4TpkVkXimVN+YkzX3PdE2lPg=;
        b=tgvnGkx6LTRWCPWYTOqpUO+QqURllqdnnhbANG5eENDRbjNOf+dvGebD0SmKZ/lH9a
         yvnJKdu3vD7WEl7qGJar5doyRFS9S33H1iFNK5CIBzJ5IxE1nuXPrcrXW3WsRx4ftOZG
         1k12t1Hg1E6EKSOsCcQB2Az7pdOgiNjKUpoZbbfZzAb0Yc96qf0eouIQ2hd8FMFrYM/3
         pfi0pVPeYF2aY3FIQoVuQVRhokbXUxv2GGRQcCGmWG7yJj1/MXx/4Sl1A46nraU44dhk
         jJHFlnDyck2TaeKxAOI3HbQnKR0oMdKSVa/hUkHO8T5nmvTXgk+XFHm26Z/QvPCtzTED
         q6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2XMoaLxeuIbQT9JPJNgprpPDk5DPUAiwSEXDhQ4kPSNrupiRtZ52CjzoZbNqRB6q2X/di8bgVuXs9UelGsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIa0j+39R6IfhHD1Y/dDFKFqkcByvzCciOOLc7FsNZe737fy4S
	mvDM5rWxqKbjv4hzsSYgjG3yu3hFiRWIs70iQqRVIEceL9d6GbuMBn/R7UaRF7PD842IVHwvJ/O
	/j0SlccoN8WazkA6FPOhoinIJ8WXItq24Jxr1g2aM+AqBorNLQyoKzMDbPpCMXgMlBu3j9Lxq6A
	==
X-Gm-Gg: ASbGncuSOTjd0U8yuaTpCF2QFnkQsKs3Y+SZAqf4e185hmC6XwvT0SxnqtyfhxRmvmn
	XzVL6bHL8pExRe+gM25garrdkBr9L3d2r03aak4YfGKIfqCJoxgnjfyqO2dVwgQ3rxtSrhYqxfo
	ATX48itAYCHMRAdZW88jY3+QrsH37oV4zCZLK7t+UbEGzIdTzYlsSA+Jpl0tnIzSU11pOWevUN0
	T3l/48/scHZn/M0z9gOLkUhgI6EuCUB4PwR8SNjbdRKTUs2w72mF8Gr0eT47SzsWFQPuzo4z7fE
	6PpYMNsqNae1Nn+NJffLxGXAUS9LtYgCKPoZ9AAzvv32zTQ=
X-Received: by 2002:a17:902:eccc:b0:216:49b1:fadc with SMTP id d9443c01a7336-21649b1fd08mr106886835ad.42.1733810700978;
        Mon, 09 Dec 2024 22:05:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdZTBCMs7H1WTg5zLzKGDgofWMITKz9UCc3WUTnRaIn+Lttr79ry9IlBjhjDkydSu0LKbL1w==
X-Received: by 2002:a17:902:eccc:b0:216:49b1:fadc with SMTP id d9443c01a7336-21649b1fd08mr106886535ad.42.1733810700587;
        Mon, 09 Dec 2024 22:05:00 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21618d9beafsm64535765ad.6.2024.12.09.22.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 22:05:00 -0800 (PST)
Message-ID: <fc745e1c-cfad-4ccf-aa9c-77cb76c2f23d@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 22:04:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix read pointer after free in
 ath12k_mac_assign_vif_to_vdev()
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DREE8lYxFvyPV6XTPq5YQrwb0ALzzyIM
X-Proofpoint-ORIG-GUID: DREE8lYxFvyPV6XTPq5YQrwb0ALzzyIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=719 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100043

On 12/9/2024 9:26 PM, Aditya Kumar Singh wrote:
> In ath12k_mac_assign_vif_to_vdev(), if arvif is created on a different
> radio, it gets deleted from that radio through a call to
> ath12k_mac_unassign_link_vif(). This action frees the arvif pointer.
> Subsequently, there is a check involving arvif, which will result in a
> read-after-free scenario.
> 
> Fix this by moving this check after arvif is again assigned via call to
> ath12k_mac_assign_link_vif().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1636423
> Fixes: b5068bc9180d ("wifi: ath12k: Cache vdev configs before vdev create")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


