Return-Path: <linux-wireless+bounces-18860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52752A32C8F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE416176B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A1253B51;
	Wed, 12 Feb 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NU8DpwJ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948F1DEFDD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379286; cv=none; b=MhEdpV1tGcrxWLKsNgbVCAP4H4V7xj9JD63MprBGp4LBZitt5Vei4QQ3DJ9eFS9MgYSx+cRooHc52jpgc5pub04M+mNmnhpAM13MjbBpInOtu1Yp98Eaa6j51sYsO11EbqA1NmeMz1m5GXEOu12K9N84c6Y+ne5iDYsxmIUufxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379286; c=relaxed/simple;
	bh=wkaUg1DENSD4yHymFSi2ejg0prL/M/EWygSMyN+dkvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ7ZJZxDFkMQTJxHrSTghmF47or9BANpeuzgvqNedFiZs6stmT/pKcHhLIn7SQRm7PYHhIe1ulYD66Zw3CoJaeCtmgVtcfba6cGj7HUS9GhHZZNHtQCw2ItO1Ytv228f4JqM12AmOU6+WHebyft2tr7WPaBJJyKoxCAloSCwNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NU8DpwJ8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEiMXX006135
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 16:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nfbHxXfLDJVGtgNZIgeGSymwLVT6zSrgg/aja6UrOP4=; b=NU8DpwJ8CmbsbmiF
	lsoXBD4n34MNA4ARVp5HzKP90RqInNXWXXHBR6njz5YKZcuXQmpkdHwq6ZNR1OzB
	YZWT9Cq4eZ/FnRIwA4iR2QTNWR2ZK25uc3VlqYxFj8tKQVGL1b+Zl640Jg/jvW1C
	0YNKYpwu5zgJBpM+8klt+0MB9jKIsq6vrVMCA39oKNVjfD9/sOlbS6C5MsA/n6O8
	d1UyD0gybZQ23wBSGlZ7fLXagn8/iUwKRuZVqcIvtC1Ke5MT1hizU0FynsgNpHw+
	vD9lcahJnutDSOTbmbtqgqXt4dA+M/4oSRj7oXhGnt34EPQCXuI12jST2hYEecO+
	tZqHiA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe5n05g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 16:54:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fa11d8e448so7645a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379282; x=1739984082;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfbHxXfLDJVGtgNZIgeGSymwLVT6zSrgg/aja6UrOP4=;
        b=v13Ejkx/S3+hneI9sd32R558LZSzYch14K5FyOxMp1UbvzULt7AeR9chNGV5qWNzCJ
         PkcC7QD+QlsMpmLprfziH/jzsO6sP/ExU4FLaY2oAsSyiKVPFUtpvhfGlfGk5+GYCdIO
         teggWJW4b5imqgaF+ULnDzNYLcAyfvNfwk40rOasaaOxio6AdNxxDbe1gEklumdM1YXE
         DReMzDsxPEH+Ouf9g6A2FrnWMtseQeiwbB8f77UFoCv6n25SZK4AkDLWy8e0Ljzzofcm
         jZUWL80u+8tyOiLyh48kFvwDCECKn9TrLX9oqJKNNMpuWEBXf3G4/+qXkiKQ+wUqJlEs
         wV+A==
X-Forwarded-Encrypted: i=1; AJvYcCWPvDv5LuZXo0R+VPxnfX91uiZhwLKzr155Vrd0+EJfaSeTnhPueF49WCoKC0kIflnPuDxSRIqMbjrImo4n2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHf4MD5nz2jr3QN5VkOB6EY59g6CD3Q4FBmRPo7SoLQ8XfVxt0
	uKBnX71cp4i/6FWdYClKx3qGmst/Nao4vA+5gB39OrEHNCNzcbHXtObAo2ZQg/q2UcOD3wu+whM
	lL5Q93PB5YB86lDTf4m3CLmBnzqMOx1rIhTBZ8h6ZvpMSXugWkMj7DgeVaLenofZ/pg==
X-Gm-Gg: ASbGncsqeEhct9oLoG2rf/NpTNouoNs6ZVHplMemgrkpJ8xpHhdiQx3cJp8L7sLPB/p
	lyGznG2pwbyu+Rjed1c4BQ03Xm9a7bBJ01ce5untiVjiRxqxREMOGt/4xk2BG9py82bnoB6CpTr
	foMBNRw6iSdsHQYwdYxMJQZikSgbvm9WP/Mr/4mVqgk+doPo5ut0Zz+S2/ayXO9RR9AH+AqYyYf
	5c9AYeplC5bDJDb6pHm3tlOvn4FS9XDA+/wxYuKEn7k1hK1oKW6ImoD10CMVlC1AkFcJWY0HOwN
	c95qAIgTzObiPLPP+ZaB2wm1ejnwMXSHg3oj2+geE/7p2Q+f5xsjGJt+HFQ0
X-Received: by 2002:a17:90b:134f:b0:2ea:83a0:47a5 with SMTP id 98e67ed59e1d1-2fbf5bb5735mr6133332a91.4.1739379282024;
        Wed, 12 Feb 2025 08:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx+CWks0nvoqMOT5wEtwjJQXwKdPFly96tXraDduozSmPBMM+3wmzaLt6FvkicFgrTncPtIg==
X-Received: by 2002:a17:90b:134f:b0:2ea:83a0:47a5 with SMTP id 98e67ed59e1d1-2fbf5bb5735mr6133297a91.4.1739379281639;
        Wed, 12 Feb 2025 08:54:41 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf989bdcfsm1721378a91.3.2025.02.12.08.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:54:41 -0800 (PST)
Message-ID: <509cb1aa-a0d9-4444-9a54-0edc0b181d61@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 08:54:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo
 <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vsaXM4sNejDDTdRrh3RONhcdIrjFpU05
X-Proofpoint-ORIG-GUID: vsaXM4sNejDDTdRrh3RONhcdIrjFpU05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120124

On 2/10/2025 6:49 PM, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
> 
> This explicitly returns 0 without an error. Also removes goto that
> returned *ret* and simply returns in place.
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1642337
> Fixes: b716a10d99a28 ("wifi: ath12k: enable MLO setup and teardown from core")

In the pending branch I changed this to:
Fixes: b716a10d99a2 ("wifi: ath12k: enable MLO setup and teardown from core")

To fix the checkpatch issue:
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: b716a10d99a2 ("wifi: ath12k: enable MLO setup and teardown from core")'

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=c2f7ae223cd3d781c69337dc804f1fae95789cdd


