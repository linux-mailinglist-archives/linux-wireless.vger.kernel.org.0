Return-Path: <linux-wireless+bounces-17268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE54A081EE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 22:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FF63A0372
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9B19A28D;
	Thu,  9 Jan 2025 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dbf7sMmq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3577102
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456547; cv=none; b=tzcI0aMamkLCH9dp1cXL7/e/Or/r5IPqAEzciP5lBtLqOFpepRriHfmzhOjx5gnv4rVs1jA7hsO4y4rhEJY9T3A7haouBWxex+jz+mK3wg3tl/Wol2FXX9Zh+LH8vybUJRpUzlZt13PYqrKGbBZEIJ4mPLz9gCJNqIxqrXaAJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456547; c=relaxed/simple;
	bh=J8QOLLzhy4bXiu16wIDcvdjSnUYGIxB9JYdvWEFxs1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Shfo7sKSzS+A1+gUSnsstnzsFUbY4qcRMck5lRnxxCIIB2wEo5rpnm1CDthLzoVIjHz8bheTtXaa7yzzq4eFRbdfQkWQgGUWp7hFGuLU+08DFlAgZJ/T4yPAOyjXaJTYm+kzgGzs4kw72Aa+3HLlR1CaBvNUcDcq1o7Hlojrci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dbf7sMmq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509HIdZd012078
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2025 21:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d20jpSgXHWmcdbS+qzfK/jlD3QyrndY+rUzeWA8JT4Y=; b=Dbf7sMmqABThEAe0
	NN57cvoHdou+wIS64Aiy60u64MULu2qPbwfSJ/mjXe2aOwEEc4SXXdC/jp421VwX
	GWb0B6yMPXKyBwkE7lufkoKnG27TE81Ko3yfGf/srrLD3nd61zxDkw2l17BNrbwM
	HiF4JwDedj8BSHKueB2tCpI8cD7zMgiCuAiMR4OQYVd98wE4SKPIEi0IjzVJYQtH
	s2eXYrX0uZlEkHnC0qW6TEmkN7NoE131j7SV1ad7IqOsRJ+qZxFIR+yKKCbxfGxk
	s1st7c0byLExKkqzuHPWNV8cE1RVsSYUc0uGyrC9eMEOGsWPy2j97pEfLp4+i4yf
	Wo3L9A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442jra8f90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 21:02:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2178115051dso23782995ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 13:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456544; x=1737061344;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d20jpSgXHWmcdbS+qzfK/jlD3QyrndY+rUzeWA8JT4Y=;
        b=rtmHexgDxqlK1FcwP5dJ4M9ykHfL1lS59h0nvL/SvgLGQzy0KTbhZfzcLSRUJI25Vp
         zMIxht1jXqeltMJjlvKedyRqAsFBtBOMbHnscfWlMYiCIilVMuNL2nMcr4Ux14VqcICD
         iYXTRu6xdYlsqNK+erWuNIAm1VuLdv3YID3PPYSXfDbqEHl1OoDADgQsf+5RDgH1QmfW
         lsNgflnJkURE/csv00K9iYRnaEKHctWjUIB7O1rIuMbsaGrue0xfFG+xnuVbOMhpgyHd
         MygvTC7/+7QysstJhLl2abr+7IQeKjOveIDzZoT4gcQu71SrjT22lEjN92vpMXvk/Znq
         QyHA==
X-Gm-Message-State: AOJu0YxHwquG9pqkeHI+6fOYwMIShQAgYhqT26M9lo6waByr71we2qLt
	JljcsPtZxbUtrVHneMPOG6lJkGhJUcGTQFGran3tNxO1910VsPrP4A0xdBJ0MAHYBrmMA4i6qw/
	ioLo9cAwAKwKozyjYoHpQ3MJSNhq+Lonx5x8YF4kDJ4BHkkKF/b6dO1evwr5r3dIjwA==
X-Gm-Gg: ASbGncuf1Ictu9RvNp0xTnSMy0bKkA00NVnwY5RElMnO5jKInvdkFTjfKAwbB++sya1
	1JPb66PI+TC4UbMH2Nz1yjMBE87/INMo1+cgG0Zc55cWbj0TwBGJGYtVAagPmW1FGJDrMPFi7VX
	qvIhZrHzHK6OvQialFwLBxy94mPNVDmHiRp/6DAAl0VrKQfQYyviHZa7MED+lePqv1ym9mDXh2W
	KGsbUsqxd8/+OXj2USWogs3NSC6+h2x3Utac/YzgcimP53B7YSM24JKj9Ky14BXGSIx3OzlQuF+
	aumbYGeQrQZ2BsAwLE79WDt0rU0wb8hJylFq
X-Received: by 2002:a17:902:ce06:b0:216:5561:70d7 with SMTP id d9443c01a7336-21a83fe48c0mr130229075ad.52.1736456543882;
        Thu, 09 Jan 2025 13:02:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCNbfdNwzmPtgj/WGPz7kYYib0KE+MlhdotcoB7K49Gub/ExHLgm5LfFv/xccluXnL2jgA/w==
X-Received: by 2002:a17:902:ce06:b0:216:5561:70d7 with SMTP id d9443c01a7336-21a83fe48c0mr130228695ad.52.1736456543484;
        Thu, 09 Jan 2025 13:02:23 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25c927sm2083345ad.228.2025.01.09.13.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 13:02:23 -0800 (PST)
Message-ID: <b625bfc7-0229-4dad-9059-a71506a70a6a@oss.qualcomm.com>
Date: Thu, 9 Jan 2025 13:02:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] wifi: ath12k: Factory test mode support
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G3Y31Sv-dTtMgIMEn606QfxhvD_ZxOmW
X-Proofpoint-ORIG-GUID: G3Y31Sv-dTtMgIMEn606QfxhvD_ZxOmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090166

On 1/9/2025 10:35 AM, Aaradhana Sahu wrote:
> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
> 
> Also added changes related to correct pdev id access for
> fw test cmd.
> 
> Aaradhana Sahu (5):
>   wifi: ath: create common testmode_i.h file for ath drivers
>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>   wifi: ath12k: add factory test mode support
>   wifi: ath12k: Fill pdev id for fw test cmd
>   wifi: ath12k: Disable MLO in Factory Test Mode
> 
> ---
> v6:
>   -Rebased on ToT
>   -Updated copyright
>   -Added patch[5/5]
> v5:
>   -Updated copyright
>   -Fixed line length within 90 char
> v4:
>   -Rebased on latest ToT
> v3:
>   -Rebased on latest ToT
>   -Updated Tested-on Tag
>   -Removed second parameter of ath12k_core_start()
>   -Updated copyright
> v2:
>   -Rebased on latest ath ToT
> ---
> 
>  drivers/net/wireless/ath/ath11k/testmode.c    |  80 ++--
>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>  drivers/net/wireless/ath/ath12k/core.c        |  29 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  13 +-
>  drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
>  drivers/net/wireless/ath/ath12k/mac.c         |  17 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
>  drivers/net/wireless/ath/ath12k/qmi.c         |   4 +-
>  drivers/net/wireless/ath/ath12k/testmode.c    | 395 ++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>  drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
>  drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
>  drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
>  .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>  15 files changed, 621 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
> 
> 
> base-commit: dbe50a7420e22954c747e79e72df2750d795ea77

I just had nit comments. Kalle, can you re-review?

If there are no major comments, I can incorporate my comments when I pull this
into the 'pending' branch.

/jeff

