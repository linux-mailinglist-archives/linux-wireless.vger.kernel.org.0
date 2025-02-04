Return-Path: <linux-wireless+bounces-18393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B4A26CB5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9AA7A4985
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D9B12D758;
	Tue,  4 Feb 2025 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDlcXnUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BB206F3B
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654589; cv=none; b=r2GkJycKPfXHF0Mn0GSRU4i0fvfagz8h7narg3nJkuhHHea4Xih1UUy3RKus/nr0UC+I2HrDdCeNUrOna3yY5krTBt/tPXAEHG6uaHTzaOqqB+zj3E5qZIQhtOS9PniIEEXz1c0Au4/KEM2hpJx8DaiRp2cPgrRcpyYhtXCF9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654589; c=relaxed/simple;
	bh=JKrkttbd39E+9OzR6qKOjn5EAs+0hEW7gnYf5Jn5nS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtUcjYVYtx8Nhiwp3kPgXViTU22c0cnbS9A3SB/MupMIfA9Q9TXrP1vMelUEp3JJcBMeJpVuTUKprW2K6UsYMThTPLmc86y+2oKS0UehwT7XG7ayay25YZo+dQxcytMah66eoojg+UTlZgDPJW89EtiAtW1q/nV6Bx6h1l3Lhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDlcXnUr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5146Nh2h016054
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 07:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WE3//OQM5pXdaucVVgshH0y0fU0kJk0nrQaexmq2EGE=; b=fDlcXnUrYVnQEhFG
	xpAhjN+PBlXpdKzyjom42CItEiMWMAVa97Pg/hU/7CN+KhPR2gHvVcM7mwoiLkwy
	LlmOv5wqp/vGJ36H9GYcsaQwFmNsL31XUbMoMzUQ9jq7D30wipdssWcuct4/jJYa
	dmyY4bHoxrvZarLPlRwE9I4J7oanwPZWb5/4/u0mhj7zWhRM9E6sPj4ucpFbRySO
	m+9LOeuY1/8oNZkVB4Bmg+pyKa1yFK7DcUQlH8Xh3xeMBEg79BVm8ezw9Cxl+SEl
	yAg3Kqn5mReUr7fI2GVESlu2bLSAGaHAQs20Lpi/+lRDkAtZvy1/ErP/o4mUQnRU
	6AaJ0Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kdk88506-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:36:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2164fad3792so113433265ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 23:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654586; x=1739259386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE3//OQM5pXdaucVVgshH0y0fU0kJk0nrQaexmq2EGE=;
        b=gfGjHb5ClXg2plE7mWqkYPGv49X4PPjcPCY0tOVvSYe+dO1HbiwDbjnJK3xIumigCY
         sLGGUtLzGfmrVpKZ8u+o2YebrsfSee9ZiwHVQWJ9vEcAtwW4V0SPglwDlYWC7necA4U3
         TjyT61arpLKWwxsvnfVx823SHP5IqeHOETAJKAtexu03F7Q/iszgqxbcx84fjgWgxgx4
         nIw2PCVJJ/v0jNSsZmsqFRkjkN77JRlokpoyp5bMo8UfeMSnJ7TX+oJz7XqT5BwhEG//
         0LWrX4NSFZfGcbvxj2aGfjWHL1FbO+oc8gFlY/8zsq1vHfaO450wN2KnuQvDN8dET9uj
         lVDQ==
X-Gm-Message-State: AOJu0YzxlBCcnMgCIz2zHBy3mbv3VuggORVPS9q34IWNXFzLD2SH/liZ
	c1TkwsQunAQ8kyuef4TozwU52rTMH+Pczbd3sAnoFfworXZ8OnPWHRpffd3I0tXL59k1TRP2ChW
	jmg5GnAj/jKR86uqRSvfSiIa+By/EMT+dryVzYKY2D+abGd2wnTxJq2leL2HUGRK4cA==
X-Gm-Gg: ASbGncsPMbVPE/uvlBC+gAo0IxW0ehL8qZMsyFBxD/CRFcvnN9aLO5zNmGW0d7hdVTY
	CAWnVAsZftLEi0KspehfeXLcObA/49oMGmigowZLEBb4TOWC1mxUu/MgN4GIiBzHYHDoyG5r9fa
	HraG3uQSCsgN62HX5rKfYqOWOObZDDCWjnxppvJG6mRmG6hfDsSHious0zvcKy3j0cQcLE8HWGq
	xbXmT7uFpWsu8qHPwADD8fIVavL89zEQOZ+7Ceidm/YTPOivHGspJ8TBfJ0x5TeST0NghFYaWz/
	z6VPHkF9sYcgLGh33zwWJm+pdpcy2IoFzjysMxzsRZ2k5tM=
X-Received: by 2002:a17:903:2b07:b0:216:4165:c05e with SMTP id d9443c01a7336-21dd7d787f8mr464939115ad.24.1738654586333;
        Mon, 03 Feb 2025 23:36:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVtpRw7hLlUBVdkkMj+yMEet/93LYwVV01hDU07I9y5swZEPjUMH3XSPFMb6pKgyn8ozqnXA==
X-Received: by 2002:a17:903:2b07:b0:216:4165:c05e with SMTP id d9443c01a7336-21dd7d787f8mr464938855ad.24.1738654585965;
        Mon, 03 Feb 2025 23:36:25 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee0a7sm90068475ad.18.2025.02.03.23.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 23:36:25 -0800 (PST)
Message-ID: <fc1df129-e859-afe8-a883-cc34f55e22cf@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 13:06:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] wifi: ath12k: relocate a few functions in mac.c
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v1-6-675bd4cea339@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-6-675bd4cea339@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iVAv25_daDpcjvoekwsT5ipDfEXWM2Fr
X-Proofpoint-ORIG-GUID: iVAv25_daDpcjvoekwsT5ipDfEXWM2Fr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=720 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040059



On 2/4/2025 9:53 AM, Aditya Kumar Singh wrote:
> An upcoming change will invoke ath12k_mac_init_arvif(),
> ath12k_mac_assign_link_vif(), and ath12k_mac_unassign_link_vif() from a
> line located above their current definition. Hence, relocate these
> functions to above so that these can be invoked later on.
> 
> No functionality changes. Compile tested only.
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

