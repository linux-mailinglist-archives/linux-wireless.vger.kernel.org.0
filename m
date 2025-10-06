Return-Path: <linux-wireless+bounces-27824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0369BBEBDD
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B981895F33
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE592D9EC5;
	Mon,  6 Oct 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KU77/ZbN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDF2D94B3
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769516; cv=none; b=cRrWgaLtG83lWE74dJWS/oSBpLgxrzslBbQbjAD9/Zme26nfRnLJHAgWVajWBwt6okhklZl672+ynwqveqTPEo+i2g4TUu2113CBAOA0wN5aClNIOeqGZ7ZrpXZA8JIthvb3sqym5p4spz7DBDJYC3zVSde5MNioG8wfagg6nTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769516; c=relaxed/simple;
	bh=A7UJsAckvltDqfaftbZweMIKjCKDFpp6wuMlEL7ZXd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HPnTW3qG0lJUpGgvX3b2dq7ufkg8Dmn79yoVavqJIzo8KjURtdNanGPF3Cdhe88zasZL9LF4X7jEGwXPizLgxmlSf1m62l1IYIiVaQJ55klqgAV1F/7yjICYctIMPccUcRBRqaVkUp6ox9AAb426chRM4NtRYHMfXR4T63f8EjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KU77/ZbN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596EuQTP014025
	for <linux-wireless@vger.kernel.org>; Mon, 6 Oct 2025 16:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wo69v9N0i7yus5uBIq03Txo87lWpTPaftw54sQRNMhM=; b=KU77/ZbNmc6ao1z/
	zwv2bS8FUKkxW5HkGNXc9wgmj92lxSW3JP6G3PSA9mkaBrvcC34bWoECCCSZXAJR
	Hukmjfsi14Nb5aZ+jgJlvHHnCPL7/OkA5JuPJrFIK8Kt3oGplT02/CyCtEtpnGA8
	5+XsSrujzh77LnoAN5ENwKkQaeljI2L+6Dh4Ho59TjHjFtYHWrTMI1QLEH8c08In
	jqiIiN74N9dPkZqWjuquJQI5nmlTLJtw9/cv6d0pAbaeuLfCX7IFH4/YHfjybcZd
	u9WOYHx8i95P1iBLZY6/6K4kPArixDWoKDLuEsU5eFGdK0eCs4zxYD5VCt1TooHr
	cilU1g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7mbtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 16:51:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso7928192b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 09:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769513; x=1760374313;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo69v9N0i7yus5uBIq03Txo87lWpTPaftw54sQRNMhM=;
        b=jZr/J/cgMjF/dctRf5jllammVIzKh/1UxYLbR6sK50ipNLA2+a6cXj/kx82HpVuxqm
         5MtrrgqFrWns8M5vwjnO6nfnkaqxrfOxrtHlrCAxArMM1pBaDdoq0QHMrW5EJ8Lv5hdD
         Q8LPs7yWLeAyX5eEv4Qskp96E9Y4Ke0mmMs5Bc52Nz6PmIE6mSI/lX2IuAG4TPT3iA7y
         q0FQ7QtZQ0+TxamZ6XEXGCMF77GFuQypVZz6PNAo77Ko29KSczYnCxqFxIyas3zNEfz7
         FvAxRWG+9zLuE2u9aP2WPi9i4GfHZlrDhpiMKDnjkantF5TtNDs5c/LLr40nmQvNVNBU
         AKNA==
X-Forwarded-Encrypted: i=1; AJvYcCWZdnnY49T+BFQ90IhPhDhXOLjqigOaOwrMCIyGFs8kRR3Yds4yq1gv+cFwRuy9U9s5ZsAIigTKSvwmyxQAUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybIxR48GBebokxBwsjxN39WYiStLW10g0Edt2t74s9SColYURY
	ZYEdnwpTfv2dJIsNmfIS6yANwOAReC9/LmeQvrZZlyTdZ+JLsB41Cz6avxR01IysdP6/Tg+nUoR
	tzhHxRNDnvW03biBqkaMw9n6Vtrwc97GUX6H8/kdFAapENQvamoYMgS8V5MCnP72kxza3zA==
X-Gm-Gg: ASbGncsJiTwpRXG2a1pLpD/N8Yj3MlQK5juZ2KIHTtbz/PUkT7IV+kFE5Fi3x16/mkM
	LOg2LL0UBx4c0K7ojhQPjoeRSxYRAnUtWapTv6IpemHz4Yv43zxeezVTj2cbg86cWXAbFTGe1yO
	2L3P1VqkWNc7L4a/GYadzfj4ApjVrvhzDAhKWu5wSSheXtwd/udSwVgJIsrUv9wDy0T4SzGFYvP
	LMPxFi5DDm1O6Wnj5uKUmcTEeiRE/DI+ej3WZH8BRFIlKLJtwBK7DhvIuSlFGG0+XhSIuRqYNHr
	q9Czkg3ycVj+X7i4uS4f83qBLv9x2kQMOkdvQ8yZY0bafiU2DSVeUqsnAEEgCGb5Y+lypmip4L1
	vpaBgBg==
X-Received: by 2002:a05:6a20:7f8b:b0:2ac:7567:c069 with SMTP id adf61e73a8af0-32b61e583d9mr17724732637.17.1759769513472;
        Mon, 06 Oct 2025 09:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETt6fN2a5uQ/TBgiYmhUZtcG9dd8mwsIIRymgKPE6BSHmuorQefyP4JFbxPMwBPSwvxcbj8A==
X-Received: by 2002:a05:6a20:7f8b:b0:2ac:7567:c069 with SMTP id adf61e73a8af0-32b61e583d9mr17724705637.17.1759769513059;
        Mon, 06 Oct 2025 09:51:53 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205336csm13293176b3a.45.2025.10.06.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:51:52 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk
 table
Message-Id: <175976951234.3451922.1302880550621653546.b4-ty@oss.qualcomm.com>
Date: Mon, 06 Oct 2025 09:51:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX+MhNYoG8mUth
 Jul17uonrHURXVrQrVZQRP5pVF0oyp83JNKpabxURM4TixiAz0uvY+iK+8lLpCa8v2mU90W9gev
 itH/G1+QavKq5Og7lvA5xhJgvf72i4VvHe/Ti0sJOjY8lUQDXRuC4WxLRGRNt3EEIDG4xgr4Wh+
 uigf39sa3eBjiRY2cXMv98NY6lHrFc9bTHf22zmQm5GMXHlwAn4SgfsyudChUxauxY6tHz2+LJb
 6cOpEX3IJkNzOE3qDhDUvQPbUrBTSiiTpmYf9t5Qy50uAc79nBGQDoC/B/5dfZVuXGHVWIVm7DP
 o5rSZr6xMjQjIPkxsnU0q34UobVNR9yb4PiIysO7rdKRGLxUiNuHmPg3wdbZsP5RelLAe7Z4WSu
 fI9eAlvzrNUdYV+e+qvm7U+npKTj9Q==
X-Proofpoint-ORIG-GUID: rmJSj9VpbpGitifbghd9Q5tqA15FKBnk
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e3f3aa cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4eKdMI8an_lkvHNd_m4A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: rmJSj9VpbpGitifbghd9Q5tqA15FKBnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037


On Mon, 29 Sep 2025 15:21:35 -0400, Mark Pearson wrote:
> Lenovo platforms can come with one of two different IDs.
> The pm_quirk table was missing the second ID for each platform.
> 
> Add missing ID and some extra platform identification comments.
> Reported on https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Add missing platform IDs for quirk table
      commit: 0eb002c93c3b47f88244cecb1e356eaeab61a6bf

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


