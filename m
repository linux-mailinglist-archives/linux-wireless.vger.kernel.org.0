Return-Path: <linux-wireless+bounces-16129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041849EA754
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 05:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175311883C1F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 04:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9413A865;
	Tue, 10 Dec 2024 04:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAMMHS81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277979FD
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 04:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733806216; cv=none; b=cQuR3H1QzkOMxwddQHObbJzZ0TqQ+8X/fKKQ4PvSsFLzk6pqdBs5F0DVItXmSgB6jvs4lV+G/XXmCLqkAU/M0/29YhS5lF5CgZX+rGoL2zHlX3UZxAx2rTsu3EPNaQHPKCaMVPEzh2AFwcOS9CmAd3E5pYJ3gBmuWHhMLS2OZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733806216; c=relaxed/simple;
	bh=ZQ0IJuZfLdX0xUZZupkgK1WpaesKhhlYAM4mLjlTITI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxG57MhwDZrtiY83JBlxisyQ3+CxcgsQSYzjfyJK4uGnQa5DPiYBBzWFTaDaJQDGWoxajl22771/iMPMFOXNGcRFHxfo1QzsFN9TPbKWsxkAghzAuEBa3yRHejJ8uGvD3beO67W0By/S9fVbNdBI4N6Vk8HUwC3EFlteqkXP7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAMMHS81; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9NpvB9019925
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 04:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LuuYdInP7eOBnrgKXv1aGjEPQhcydVxdMGklxB39e1A=; b=oAMMHS813WBACQMy
	t8JxGAc02X/1I3bzorg1ZOCwyZ85Om2gKLX0v+GSHj0827OaEdMJqSXW+DYFQ3pX
	frwPS/PrkmodWU8vN0fajgPyMv94rT6VSL3nyclWubk2xdljhqHGDXcjaN47dP2+
	BA+O3lZRScqyRD7khMDQU3dc57gY9DeTR+YLwRVBfhNcbAjJA01QT/KObMkmYjnc
	Db6n0NU9IS4TjgCJCnmJlV+Mv0wy4Y6JvWQiQRe4mnlZ0K+SxSbT/WiO0MJ4lM83
	T6Kwy3xFXWjtYd6K+eiGtv0d+YZWfMJvs3W3cDQHKq1MXodKW+Fk15CV8V5gjx7q
	p9MxIA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eak38kps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 04:50:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-211c1c131c4so57047185ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 20:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733806213; x=1734411013;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuuYdInP7eOBnrgKXv1aGjEPQhcydVxdMGklxB39e1A=;
        b=NuSFUtpFdwAWklDg5qvt5e9361kBIcf0ZzFIbinqcp/d/zKNtgYFIAnnHlcuveN6pu
         6W4o/rKbEhJ5pn73mv/Mbl0V/cW6ureth7c5fKzkyT3lMEztkfU6wWRz5gH8KO60/FNV
         oKiyX+wgVJvPpMKCAEBiur1a6aFb7x1ncBMOKbp5uvcOknlP5gCdRxPaUP+FV9f2Ne3g
         TP+lgAwxpNokLKHjvWd8hUiUIc3X4yt1XHe3+NUzTXY9z5vfyAhNPOzq4uHaRw+uBNKi
         eKI2/OZnFBBERl9I2093oUDwtqx0n9U2xTJJVkFKOz9ovXmH29hS4QRhythziYqR6OzG
         XP5g==
X-Forwarded-Encrypted: i=1; AJvYcCVQb3CAzy2nga/u6rahkTcakop04fTbDU5CD7SmUF3CrruWEm7COKb45DXWlE/ll+S9DZD6MmygCp/mhTblTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7mOUVNfazqILBhrTOhpRDqX/DHAa8IhD0D5RyEp7+PbY/ucV
	k3x3LpF8jlsKh8nDyHVmubo02COO5LVmo9rUU2lY4bZTy6hsUjaLlrM8j/eh/C55SLPm5KB4rAQ
	aXTx+tvFWjc6AmDJNCna9p3I7Ynj9YNY7D1jKsX7aHBcU/fzrbp8v9h+ObhatJlymfA==
X-Gm-Gg: ASbGncuEs004b6TUgzde892YzH6i0WV2XX0ctfyWR6JXN9QTdWq59W8/6a8z5Lw4Ulx
	PFCBGPUL4HWDYU7sjIjxFE7we5M1yhVy4EY5nCH+hvYtIvAe8VhikPk51sp8qvDf9kmEbQRWfhq
	UsZTFCNuztuvaoKF1oYcg2Ezk8S/NyLKfd8qOc6m9N5O+IpEmJJ0/er/sKm1adsbO8kM0djThSP
	E8GcNZFfhnYSXoczyB1jGsFgl5LQVk6A1jUVxcLod4g7DWzIY7sykTB10JKSUhwdrd4K6kQJqGm
	tnD7PkwjqDJtNLlTE3Bbuco6yacdSoFkESesCazWpGP6tNk=
X-Received: by 2002:a17:903:187:b0:215:a808:61cf with SMTP id d9443c01a7336-21670a47b3dmr31989645ad.25.1733806212979;
        Mon, 09 Dec 2024 20:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGhqg062ZytpVvK9uJNkfbL9AyKTZQ/TVFVk+nH7o+NW5xk7sDSvSmjMhjypV34iXLF6KiKQ==
X-Received: by 2002:a17:903:187:b0:215:a808:61cf with SMTP id d9443c01a7336-21670a47b3dmr31989415ad.25.1733806212634;
        Mon, 09 Dec 2024 20:50:12 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164eadc389sm26268125ad.31.2024.12.09.20.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 20:50:12 -0800 (PST)
Message-ID: <b5399f79-18bc-4fc2-a1b1-d010505cc0b8@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 20:50:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next] wifi: ath12k: Fix out-of-bounds read in
 ath12k_mac_vdev_create
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: kvalo@kernel.org, ath12k@lists.infradead.org, jjohnson@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
 <cd5ef876-d849-4d7b-b8b7-94377e8720f0@oss.qualcomm.com>
 <Z1fBOUqYGB5hNP1e@HOME-PC>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z1fBOUqYGB5hNP1e@HOME-PC>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rpTb0G-M0BVwyp4Sf6CHrkjGMyqa-GjC
X-Proofpoint-GUID: rpTb0G-M0BVwyp4Sf6CHrkjGMyqa-GjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=708 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100033

On 12/9/2024 8:19 PM, Dheeraj Reddy Jonnalagadda wrote:
> Thank you for the feedback once again. The Coverity issue is from the
> "linux-next weekly scan" project and you would have to be subscribed to it. 
> The link to that project is here:
> https://scan.coverity.com/projects/linux-next-weekly-scan?tab=overview

Thanks, I found that project earlier today and joined.

So now I can track both linux and linux-next-weekly-scan.

/jeff


