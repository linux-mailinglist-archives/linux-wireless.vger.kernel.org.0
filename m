Return-Path: <linux-wireless+bounces-18734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45079A2FFF0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 02:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA423A1E6D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E413224F6;
	Tue, 11 Feb 2025 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H57qFGMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864D1805E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236259; cv=none; b=FuCM/0f0yOGbBsOsfnPW274lI67jJyjD1Cn7mwbOZrKFZRKwlfegI5VtSBN1nTZ0HK1KTSMgufetfWoGgXNb+Gz7ElmVQUwj3u2tQI/By1w/bvf2fynJHfPWd5OIyDDMvZC0HQXLJ0eovYzPVdK2/pAOdCqkm1BNXjQ2UzsoMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236259; c=relaxed/simple;
	bh=HC0mHiUXxtPqj1/Qn8eKR14KhwDTYJwgbUzB2SwGRGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ujzy3HsGVpoxjUljLjkk4VAw+a4FrL7AXnoGTYW6Aa3l8fLeSYS4jJ27tzO71JdHCuiARaT8Q42kQ37X91CYAZmedVLHn9sMpiD6RRWHNlt4vkl9ukHuca9Nv+r+IBw9Q7ThSKBaStKnNdK3abdRg2r4F60XGk8hIUnXcvLUTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H57qFGMT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AJHwIV024312
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 01:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yL4f5n5ALnjcTNjuUgDIrXNo7uRjI8rEH+kWaI5WpEg=; b=H57qFGMTuRyHz363
	M8U0/E0M+Vs06tQCrzs4V8IMr52xvJlOcvEomWcVaE/wCAt7J21txITl8rwhAVRz
	YRCCCPK5R0IVBpCeoncldeJlDOTsnOq0UAKZnDY7uyDMQS+nm9R2JZurAUDiVEVp
	qPNA8pN9ITnQ6G3PVjx3TtsHIKdQJWvxJ9vNN9tV5RmeTM2X3W9ZNs04NCpBZ5FW
	w1udi8Mn7lDSPTVcYK+OmlwazJiD/N+2+Oc96v9q2nUDq0GZnemwR73Jxypgqliw
	IW++bV1Z+OlUzItsX0F+JkTeUC6lZnk4AuowlEGB7Qo5LGYl4DB7tORW8w/YkNxy
	qab/Fw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dxp4dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 01:10:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fa2e61c187so6447251a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 17:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236255; x=1739841055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yL4f5n5ALnjcTNjuUgDIrXNo7uRjI8rEH+kWaI5WpEg=;
        b=SMklTt1abB9j6hxflihut17E8tw+WhXWZFNVL1VzvoHjN4zsvszI/+eA2CsYhKYswX
         vixXPPLAcyGuXZAVi3pGnTOppAZRz3hNt9oUieIwiib0KaqPbBKQE/9KPbCJi+Lzy+O8
         fwzD5sbsDnsUbXxduxZ0qm34qpJtiWJEsvG8m3VzUyFDBQlX2cKvHYI39XQKmPQHComs
         CiPGSfaRPgz7x9bUFIKMMJ0PKB1EqL3FfN9z40y/ig8qEp90T924mk16aGp6JzyeL7mJ
         czts1GF3qFx2rV54KnyXuRW0XNJ6rx1gsbvPStUNV1g7ZhaxbrpdjRkBFrXrrsg/dwWD
         h2og==
X-Gm-Message-State: AOJu0YzKuqFYNW+Tlhn5EmgztM/l+QpyQQJMhljPwMvJQIlKAR1JKCus
	KXwfmvjEL+vSgGeTkgyotsnuzoPLRZ48YkU7W8aJ5+j1trcuoPvDO0td1mHR4mT1ELUp8e1Cx4I
	yLpl0k2A8VRIGChMa7Y1NQibv5h3GHlLJjTxs1ozAj52KjsVc8v4PGMfWCyEkJH8wxA==
X-Gm-Gg: ASbGnct/BrXbUj+b3UuGi2TmN/OcF5DPWpINmqpJUXpFAH4EPST/PftbXqqtmj459ve
	GCIe6t7cVEmbivWRa4YiJVt0Y4nLE6E15U0XWF5BnSEuO3QszX6qtetBs/C7tgZOVTScgzAcDJh
	KSkAyRDhlLxWutK19IHahqztZ1dH+hP8HPmQJ5SD6s4Aw6iGk3FNJh7WIw7OaR57iochrCbQrG8
	dMK4L0Ov2L+0lPZTAGVkzzmqVzl31b5WQRvRFr5if57fZANe360b055Gnz6LONY6XvV907CPCVs
	en3dzPFewtHg60gHgV6ECycQEnVe28f70cqI6pKMaqrk2vKLh6Uy4Wedze8f7kJdzVA4uxfGVw=
	=
X-Received: by 2002:a05:6a00:1783:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-73218b6e36emr2624616b3a.2.1739236255239;
        Mon, 10 Feb 2025 17:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPaQn58CRCESv9m28hrqPkugo+i3/O+kfXm4D8jm4EAic534rNtpoNdac5TSUoPejdQYJv+A==
X-Received: by 2002:a05:6a00:1783:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-73218b6e36emr2624595b3a.2.1739236254875;
        Mon, 10 Feb 2025 17:10:54 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730884f5711sm3131605b3a.9.2025.02.10.17.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 17:10:54 -0800 (PST)
Message-ID: <183bc4c7-5ae5-4654-bafe-509d7bfbd75e@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 17:10:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Abort scan before removing link interface
 to prevent duplicate deletion
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250124093352.481-1-quic_lingbok@quicinc.com>
 <44dc86f0-7775-4d47-9058-17cb048cd976@quicinc.com>
 <7ee0f7fd-7a3d-4942-8323-08ff9c4c8915@oss.qualcomm.com>
 <bc54e1fa-da58-48e6-a148-4a980833f448@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bc54e1fa-da58-48e6-a148-4a980833f448@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gZmXYD75r5YvzCDd-fG6mUt3OPDq9fAd
X-Proofpoint-ORIG-GUID: gZmXYD75r5YvzCDd-fG6mUt3OPDq9fAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_01,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=806 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110005

On 2/9/2025 6:52 PM, Lingbo Kong wrote:
> should i resend a new version of the patch based on 
> https://msgid.link/20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com 

suggest you wait until the pending branch is promoted

/jeff

