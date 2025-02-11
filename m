Return-Path: <linux-wireless+bounces-18782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F8A31323
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 18:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746567A14EC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA742261569;
	Tue, 11 Feb 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqxbXW9c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22426156D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295140; cv=none; b=mDx51yHIgNe9tdmVYhOcyyAEcmjvKrNIKc/u94NJLy5ut7vsnY8ikIxGSvYHH2wB4p4jtPCDTB7xy75cjhYtBvM3zZm2uiyYEvzIc+1LPCQd0r18ajpaajsgUD+HWNPt2g8+T/8hPZ8T8HVhQxLvYy48RtaAXeFj3IvpI0cQziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295140; c=relaxed/simple;
	bh=myFhEI7olwvlcKDX/vZyne2d/kbazrOb4/046xUxn4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouysasVzfN0LxxA5RjODBYXh3ld5RmVy09BhVNWEHOIE3zdOG5S2TigVp0B9ERjhuAIB4vJvm8JUiePWFtQEZ6A1P6ubuuuJIsspYqMGQnstzvpBVc96865dXMAYpAG5veyS5bN6CwEPs0DEipRa8Z8ruYXbgezdfftyGmdqPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqxbXW9c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BBHiFg025783
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 17:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7t13RmOscMfNDi73nleX4EUfoNXKCb4b28tzUu8aPKU=; b=EqxbXW9cWWmWZDpK
	KJHTfS4BOz9w1wKyaRz4aAM8il3tM5Wz52S/pYIY3Xb9NNCtCE6vl1VMgkSTrXUw
	J+a62IiCeyKEIl3tCWDuXYJgR9n3WPjRMj2xrp0s/MwZt0nxVe1xzm3PB1sRSE0Y
	f5ypUFOn+PX2Z/SaROlw7CwKU1E9K71vrgo1KxOCiG1QOPE1IFD5v1SKZsWPPR0q
	ZBHr5akx5RiKD/KbYgcXvIv8DHMla3RAmGIUWneM74x0pLDvdQWAtH9VHEei86fG
	cY2he9AwYXRXa7gGtfjgkBkgyErF27pk3v49emaiRQHFeH+J8qWdfnFV+PBwzuaP
	QtPGyQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j59325-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 17:32:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f9c02f54f2so11766139a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 09:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295135; x=1739899935;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t13RmOscMfNDi73nleX4EUfoNXKCb4b28tzUu8aPKU=;
        b=vM2l4PTUVQonGEPtMVEr2INaLmyITuyayuVVcY/GAysWcBnGwyeG1XjMCrlyX61sDH
         IdtQ1C1wRSrlb6Qd5h3XRhHfXPLSIQTiRS4O3HFGpqBnyZdE3tCEyFqBSfj/sqa0pL2H
         ANRDwfdSupTDmEVDsareP5flrNa/4A5cRdBq7EjJUT/Y1oWcdD8B3awYhutfsq/abMk4
         oleXm2eRQV21Io0viEAEEw9kShQJPGnSbIL4FQ175nJYjjK1SLHku/kMa/6yTeWRmT68
         N6Lffklf72WV62OuvKCwVQiBsXY1t5jp89/7piylEUSzMQBifzyiczOhl353atIsJmk6
         vIxg==
X-Forwarded-Encrypted: i=1; AJvYcCU8xhGl5RtPrGmdZx9aROYZBKHQ4En/xw/XWt335nmuMJ82rwo1UmpnGBZ8wHrQFvWX5ZUUQULUDboECOvRBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqtjhMILgDbYS8JznqkBqFKsRJnEuMLruB13TYkTV34gIzL4k
	uyoHDdoMfOtdNE8u5r3MbkOhvoSClgKb+amN+0QZpL7v3TvSkc7mK/efdtpPWU2Q/92hRfSPZeH
	Pt5Tbc4FZWTSa+R0EkpN1OW3tNB891WSWIjJ10NjtDxXSreOY/SH3FuFlX80XU+WBdw==
X-Gm-Gg: ASbGncuEWG9TmlE9YkGk2UYDAKCBvaOm5jxqIOTkVihEITe/2cd5vV44YwUUShCy10E
	1PmLGdc48T1RObwZe/hsYPKF/r5JA33nBro3NTvDUi9Q+eqI8Xj8C7F3ZE9m77EsglhNJNwvuUc
	nmCce8GqLJT/Kos3wTsyBNzBzxiZpVrehFR5fA4JSwaDDJ+DksOsfn0lFtiFd/lU04y4gdHAaMq
	nb6kB3xLEGDByP6sJxII0ocK6Du5Auny9YN6mX6BDlpRdEr8RKlGrTEu9ba4MbDeO1zXUdXpChp
	OdH9pGDgVkMciViUNdSq81FgFwL8+9ThqlsOI0QN1w==
X-Received: by 2002:a17:90b:4d8d:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-2fa243ebdbcmr25018188a91.35.1739295135573;
        Tue, 11 Feb 2025 09:32:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF21/tLPL2jpe5F4TcV+Wyh9fwEmWRbfBc0shXo7z6JXXJnQmbq2Yvx8LMK31GkNy5SlgN6Ig==
X-Received: by 2002:a17:90b:4d8d:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-2fa243ebdbcmr25018158a91.35.1739295135224;
        Tue, 11 Feb 2025 09:32:15 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm99816815ad.168.2025.02.11.09.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 09:32:14 -0800 (PST)
Message-ID: <9f0b4a6e-337e-4370-a2b5-9aed1887d112@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 23:02:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo
 <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 97X91ZF4FEKoWcw0jcl-QdJCC-Xfkngj
X-Proofpoint-GUID: 97X91ZF4FEKoWcw0jcl-QdJCC-Xfkngj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=518 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110114

On 2/11/25 08:19, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized*ret* variable to be
> returned in some code paths.
> 
> This explicitly returns 0 without an error. Also removes goto that
> returned*ret* and simply returns in place.
> 
> Closes:https://scan5.scan.coverity.com/#/project-view/63541/10063? 
> selectedIssue=1642337
> Fixes: b716a10d99a28 ("wifi: ath12k: enable MLO setup and teardown from core")
> Signed-off-by: Ethan Carter Edwards<ethan@ethancedwards.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

