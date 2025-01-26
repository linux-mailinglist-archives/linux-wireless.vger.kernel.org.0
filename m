Return-Path: <linux-wireless+bounces-17969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00181A1CD66
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F221886F26
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1F153808;
	Sun, 26 Jan 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P94aFJLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C125A62C
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737915406; cv=none; b=UCCc0IQZZZQuOxBi5ezbmGgzS5d7H2MZHNDKzyRAaG/L6KoXLbSctIFL7jAyiPkn2dxuMoJK0yvYOgznLzSRna3HrD0IxtzxHt43zdTsCbcujQ2jYQtvGUdaFFxkqmb0+UelBGAMUZT0CPD0O69g6s1IMFJdfcUXLWkRXwbsQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737915406; c=relaxed/simple;
	bh=+BW2U98f9bUqqsQHM0pPFR6VofvOnCVL58IbXM8+xIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urnH50f0MRtNO4OX7e64wG5allmxkIxnzNLayKMZbBYJmerR3h71NEfT2UwgLyKM4GpVI3WWRKOdbRtkAwV5nRzIyy3MQcNSuTraMBQfNYsqIQAMruS4EKPjJcQHrG8Z8vtZ/lnVllKSjNUluIVz2sZbPqVyow7xHoMGCzbZVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P94aFJLQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QHvAsQ021133
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+BW2U98f9bUqqsQHM0pPFR6VofvOnCVL58IbXM8+xIw=; b=P94aFJLQPvMF6/6D
	Jo3hwq12aauq5PPsI0rywAhu9u+lm29/0iT4Egr/NhNvvoa+vY+ARGtRgPW7GOnh
	DWZyzfulljwGMzNqhBlgVx3vLitJ4uOakSlRtwil7nbfYhe3mO2aUmdtyBs1nVrh
	hYwIozi9tPDnrpAaROuWdfhpPmvfVk7RpzvC3CbZrCevxA5ef1+rLWnyeWyJaQv2
	mZUt9FmprLiQIghlQ7deFSxpFH5tqsYq9hQbzXPCWj/zuMz88XL97gPKkGvPh+20
	W/z3+7fCU8/Wd8XwDrNK0ibZRH9Tb2Bmljih1+QAVQMPCiOIphLg/tiy6l8i20f3
	kuypUA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44dh6q8k22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:16:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9e4c5343so10626532a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737915395; x=1738520195;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BW2U98f9bUqqsQHM0pPFR6VofvOnCVL58IbXM8+xIw=;
        b=MkR6aE2mKSoRBMIVcPfuY2uDWPSDHs7hrRck5d9vJxZy2FVzZMsey5hicKTPHKcQcL
         CpnR3FVxAffG+VdZ5WBC5oQdJgckPtcnl3Uv5rnadAQ1xmoMJaNiuNbAnGlHHZsJ7s6L
         sUCt4d34ksIU5gKCbFaj1Y9K9k60bjKacQNDinixMI969ssKZRGx9J6JbRPpnDJRxANl
         laug8pQGBuVyl+DEcHuPGGipyjUBDc0N/CwYbLqTWdJCXuhgbq1uC3IZMgKKyhUtRkv5
         7t4muphhL4OPqyHbAzIClXgoKtFi4cO/BQAsOctdOzKmaRldyCE0lol81oVMT+el6d1G
         7sLw==
X-Gm-Message-State: AOJu0Yx/mz8s4zn4aIbRUKrCYhj8jlnd/gcgsg5jYEEuWPoyjgjsXM3e
	7u61hZL7LE03mmeYF3sRh+SJ9v2B0h1oNPFzASgnx1hXGtddM2NTeJbrZKQU/GRe/fRFrIeMkFR
	bOyTYMFHjdgv5YyvVXuLfE+vTgRSBf2EMut0z3RPN/XMBXQPOTynb4QE+gCnxvPx3iw==
X-Gm-Gg: ASbGncst20glGVqWyWaWmaCm9h0E0pWzHa0UaQ0kmbczpXNM1qKiL3xktQuA95DfSXk
	5kDL7WGyV0YSzT60HhtPeOM7LBYpLW3VXhE9VaW8SheT3MmaI1+GHz8wMHLv8PKxAz/0sU/3XXP
	irDT/vOiIVBkYC8W1QxyAG/+CK4ZoY0QtYFxwyFXsaw+JMNjAHrfhl83oKWIQguQbLf33z8nHy9
	DlAF3m/ehQNf/KEZeyTi4JRyZySHpH4nat9OgfqREnkHqP6nDYCERAemnhg0onpr9OZ6H1SUa9i
	hRxWGX+EUu0Et+RTKppnjaJdF87FYSzqUxUNzGFmelyVHkOtydk0rBiacng7qc65yIUPOgZydw=
	=
X-Received: by 2002:a17:90b:1f8f:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2f782d9a198mr49853334a91.32.1737915395318;
        Sun, 26 Jan 2025 10:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGun4CAWTga0BhEoL/MdVWK3/hSH2J4Zmhs+JnVVOyeBcIoN+uwv78QtV6WKGN8T4uZVSrD1A==
X-Received: by 2002:a17:90b:1f8f:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2f782d9a198mr49853310a91.32.1737915394819;
        Sun, 26 Jan 2025 10:16:34 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496cb4810sm4958851a12.66.2025.01.26.10.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 10:16:34 -0800 (PST)
Message-ID: <23d62bef-2393-4232-93ff-82ca4dbc4524@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:16:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fbx: fix ath12k_hal_tx_cmd_ext_desc_setup()
 info1 override
To: Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124113352.93638-1-nico.escande@gmail.com>
 <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>
 <D7B63ACJOYD0.1XBZ5VB991KOW@gmail.com>
 <18b47227-6b77-a029-2e80-04a0455ac091@quicinc.com>
 <D7BFM42HW2NL.2IZS207VTCTJN@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <D7BFM42HW2NL.2IZS207VTCTJN@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xMD65IUYdHQhHoMCBQCga2stFBa4hlgB
X-Proofpoint-GUID: xMD65IUYdHQhHoMCBQCga2stFBa4hlgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=817
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501260148

On 1/25/2025 12:21 PM, Nicolas Escande wrote:
> So You guys prefer I remove the fixes tag then ?

Yes, please don't add a Fixes: tag if no current upstream functionality is
broken. This may cause the 'stable' team to spend unnecessary time backporting
the change for no reason.

/jeff

