Return-Path: <linux-wireless+bounces-18540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395ECA28E43
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 15:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A004D7A3DFC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E2155382;
	Wed,  5 Feb 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGx+aWXf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977814D2A2
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764635; cv=none; b=exzrdEk9XagzSMdzRLtuiMDk1BsqbXi8Wdzzv0t7tUpnp41bEwCu6hvmUoYWl9Xd15LeLgKifQp+g9r3Qd1rhYWazyx4Vrpdx+LI1R7qii2cvf9XTkjlFek0DwroIjdnw1vX/kAWoT6/730as7jq5DAIU49dj+mqBsHbpNKz5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764635; c=relaxed/simple;
	bh=yM7HchaJht42EoK4BpDOv6Ef9xlL6sYcieg2jMphz7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRmDyYnn3jGiRjVloNmIfZ87MAR4+caMrKtJffRud5ZRyJxyH9HBkYnnG56F+q32WdDqGybDH0d/+stFvyKumLjROH5iIz0tzRSKDV2u3tqjfIFldKod6gG5f9ILXZIBZjRpM4bGySfzd8rZpXeysRohWlk6pcO/VvGxq5QdOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VGx+aWXf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Ah3pC025135
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6tW9PiE6Uggch1rl+VNHUMkhQgUT6+CObpqMjcgW0j4=; b=VGx+aWXflJxuhxt9
	mhcF/vukRqGSIyrfbiBic7DmaEEbsPLQ3HHGadOMXUGfchRcIbqxdFH+Y24B6RBQ
	TPy3Hps5N+XTfTygE+mOL8oe6lSMkixVANeooWVeUz6pjx6mpBOPM6ySPLbBKhtC
	hplNbcVV5LsdeDS9d139wZAMBFdlPuJ3omGBwqb1EGqP9uPYGSVxFpXKAsFIMO9X
	jCtHraSDgP+FvQVxHozx77/ek/swkEPs413Q4GXAH6RETpWzfe+1ZHjMF0+YAk9U
	lPJquQvusw7mMus3ZpEvu9yTGcEFmdd+YaOP/Qsz+r4eWfsdWdq+mpRN55C2iPm7
	0n2GWA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m6fqrg7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 14:10:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f9e3a00fcdso1512721a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 06:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738764630; x=1739369430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tW9PiE6Uggch1rl+VNHUMkhQgUT6+CObpqMjcgW0j4=;
        b=jUSNDZ6OSoVyEwGjb7cOUQClfmHJvu58poCvxnd/C0sRMcZXn7ES4bl2eJtZqdn0ip
         nuY8zkKrk8mZkXDVsEMQOeH/k36NwB6g1suRulYGn6Zj4XvIFWHnXLWtinM8FEq0938k
         WUNznu7gUdhTKMGIZLhhkV19l6ylyh+8pOUKtsnSSOzj1Za8teDqBAAvJbDgStnmNLo6
         v3XgZIs/Ud4HZWyxAtzTBrC0KFHo/wwRO6vFKOe7KiLSU0VS+5hmSWkp1RHvsfMHmKlH
         T69asUWFzrd2gzDv3xK08wkCu82HPkZJdBY+l2e5+V3oj/ZdErKKcg4QukpxyBAFpvqa
         LF0A==
X-Gm-Message-State: AOJu0YwCpFJk9+KQSx2Ov9LVToIVxKRhxCPTs6luDL6GQFsD7lVH2zAm
	LidKo2wMaUUSmJLbu7DJxuFOl88MeK0BB5mNTK+h4+vi5MHdoflJ4dUN8jvCMF0vhXWiwHS4REy
	If6WGd1rUO5T4atVW+O5n0v/gpdivJG6hsD5U999Y0fvjvpi2VvfpU0uIEg6OM49Bi/HHiBlYpQ
	==
X-Gm-Gg: ASbGncuDDDmn21xW3nVEhwAmnl7Q2xkhGsLazTEOZoEK89PV+JambmnHNbkHifA4bTT
	vFwBqoxdTtK5oQJtc7MZOqDtlVeI+reo04UwnVV6nN+yPZ/thQwMlTIphBIhWQH6ho8RusvOjMV
	cY5CG0ZPNadZhTkOlTYzV4GBsrWNKkpIyLNDEGQ1R94nXF5vsmwgP+PfSLqJBwWCOwxZ8RR695I
	+RLonjxqSxonmr991LlCA9Do3JhDVk9Rs1JLZawygHbuTQSVO0gQeNLVT+yscBT1RVt6NWIEHcJ
	RQMicJq9bn59tMAy9TjLIlI4FubEbwo4+4j0n6lYMABpDMKxqOuS
X-Received: by 2002:a05:6a00:a81:b0:72a:8b90:92e9 with SMTP id d2e1a72fcca58-730350df59emr4741156b3a.5.1738764630557;
        Wed, 05 Feb 2025 06:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4rFAQZq/54xv51y/JyFYfTwbzoD93BbJyApBVaYuSBCDIVueZ7AgbOnP2zjeFkL8iuAQrDQ==
X-Received: by 2002:a05:6a00:a81:b0:72a:8b90:92e9 with SMTP id d2e1a72fcca58-730350df59emr4741070b3a.5.1738764630142;
        Wed, 05 Feb 2025 06:10:30 -0800 (PST)
Received: from [192.168.225.142] ([157.48.120.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a94csm12984892b3a.173.2025.02.05.06.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 06:10:29 -0800 (PST)
Message-ID: <395ab26e-f7ca-82f4-9bdd-ad69871fccbf@oss.qualcomm.com>
Date: Wed, 5 Feb 2025 19:40:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/8] wifi: ath12k: handle link removal in
 change_vif_links()
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BlnyrxqapP2lVhzjN1NU0KUZMpQmNoGl
X-Proofpoint-ORIG-GUID: BlnyrxqapP2lVhzjN1NU0KUZMpQmNoGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=655 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050112



On 2/4/2025 10:35 PM, Aditya Kumar Singh wrote:
> Currently, the link interface is deleted during channel unassignment, which
> does not align with mac80211 link handling. Therefore, add changes to only
> perform vdev stop during channel unassignment. The actual vdev deletion
> will occur in change_vif_links().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

