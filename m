Return-Path: <linux-wireless+bounces-18164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77EA222BB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1681883E25
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042031DF979;
	Wed, 29 Jan 2025 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7+kpTgq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742261DE3A4
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171250; cv=none; b=g36LPNjQbCS7HRfsVp2uUgJBvXjYzudHk4OJ6ZN3DKLQluw6yR3AlOS46Donoscppx7obTkWqeYj3bVDt/lXlTmDz43NVtTNqfcOlMVuM3so1MU9m/eMvaZSgasGk+iSeAkEeSJ4BquyZ45GyasPiisRFeZ8jNqPtX1AUDspEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171250; c=relaxed/simple;
	bh=LBfLr+B3eRHGEGDvutRX+pcvwbBVAmF8L+wynSmVblA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ns2LfFufFW7D9sV+d7eAPyvvWJTbr3Mx2Dx8/I/Jriudu8MIdOOA6itenb9wRokb1Tq+uUVsCC6SbT9Zx712Vl3sTIj0IEfmswNsBdlJ0E/gOMwZ6+lmTeYmkwWDDC4Kl+wBAXrUggCA6UuzPRqC0Al0dN76o4jAvhtDBY452kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7+kpTgq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TAbo3h018502
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qBr8eHAGkbaVufRiupcTkTS+Wr2bzo3VVkE0SeL43xA=; b=a7+kpTgqiJR5kxs+
	8B6UsIeSiUAd0Uh6/PVJIofG8wLzXi1RmmFMwL0/M9lkOZ/0YZIRwR2JFmnMEU2D
	OKQ0ekx3T8gIJ6FMqffZnQnuiUpTe0Ub9nwl7xzrlxuwD7U5xuBt5qDxW2xNdRhO
	sZjwf+wBi+f4AtphP6axSkAKd2K+a94y8un7d89xMz4zCAaq3zny/4zPY+j4rIYG
	ezDdpytKuK6fXGhcsC3oN3gWCINwVwje7JIKiUXOdCVXHDv0Z4yGsnf/ffanyHnZ
	zHaIRAybX757tPQ/Fec8Ly2Tbx+z+k+EUUOgNuXwP4mriFSq8rY+YTp/njeO6Ya7
	OwHzsg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fjr90ttb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:20:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2163dc0f689so205793195ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171247; x=1738776047;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBr8eHAGkbaVufRiupcTkTS+Wr2bzo3VVkE0SeL43xA=;
        b=BiDp6BRRWQiF5h2vFuVqoS1I0gmr7TYoOrl5Tf+MnM0Wbe/Sb0jfos1TN3U6y8Ayjw
         GzkVazDowvpFCdwxlwbMWlH2sdkGz9s/dF/8g3fXuZyc5digWNsODDkyjcdcxlEEO9iU
         9RfaW+Rn/Wli7B/Zyxj0lsNvco35lZOJZcdT1KbFWPBWbz3J5mEz0sqvXdubP8wDub5o
         EfHUbDiPd5B0Yn83J9k1qyy/MFyzr58XLGeIZrM7Kgrl5bMholX9/6FtWPEvJmby1t42
         VxVbkep3V6703isSsGY9cLyE/x7ug8ZFK6oQNI3D7CRlm74hDm0sIfiRAHMzlvKa62Pp
         dbhQ==
X-Gm-Message-State: AOJu0YyhIz0bZ0LAiCmbaW0rr+VwcIRvDysWLCWSrHCTsqhZGWIeIeVz
	TLypObgZpHpimSyaNSqdeeAgA+I9fHfw5n6X5aISyjn6R0wUGgP/Wr4V+7t9nG73JYB5BYIO+9f
	oh6nQqK30+CN0icmXuNwg6VqGb5+55q7nClpMKPILyhip/S/YLAQ5gX00Qi6tOxfmo8a+ucQ9Ug
	==
X-Gm-Gg: ASbGncu+5yxldAmICZFXImyURrQs4CYfBe9fj7jC/p14T4H6Lac0o/WLeiKLEngm+aE
	u3oLFJXLA6eY5tl4KHG2AoUj0DAyOXMgH5WT6HdyuM3F0/oWZaEPP/klvMqefZ13nFN26dmn1Os
	sulXJyxTmuPbQn7u5TFXe1oQ+fmY8maye7rDOuDA/K74EMOrMl4eJDnQN9ghpBhSjJP/LhANsM5
	lPtkQ9i2+VAz1CCtnH66GVK43fzpsPcvfCs7kXpURN6Td+IUXhEVsePtA8eoSvHRnUBjus8KEtf
	OoQQbwPB1dg6AJzwUZNKDf6J7BwNGjN4Mj7wLk4UTVmjbiUiBhUBdA==
X-Received: by 2002:a17:902:d504:b0:216:4e9f:4ec9 with SMTP id d9443c01a7336-21dd7dcb178mr65197095ad.38.1738171247535;
        Wed, 29 Jan 2025 09:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElTxmtWhoDhYmv5xA9phfKID6SWMNZzmGm4cJSO8ekjs8ajSR1tyy5XuNs/rxJB0K81OTsgg==
X-Received: by 2002:a17:902:d504:b0:216:4e9f:4ec9 with SMTP id d9443c01a7336-21dd7dcb178mr65196755ad.38.1738171247127;
        Wed, 29 Jan 2025 09:20:47 -0800 (PST)
Received: from [192.168.225.142] ([157.51.187.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e246sm102288695ad.208.2025.01.29.09.20.46
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 09:20:46 -0800 (PST)
Message-ID: <e180070b-1e79-796d-e298-32137d50080b@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 22:50:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: join request
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: "linux-wireless+subscribe@vger.kernel.org"
 <linux-wireless@vger.kernel.org>
References: <43afcf55-2deb-445c-d4a1-61e5132c02cb@oss.qualcomm.com>
In-Reply-To: <43afcf55-2deb-445c-d4a1-61e5132c02cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9tEXEaIRKBS8xbX6NiAkhrxYRVMI0LQC
X-Proofpoint-GUID: 9tEXEaIRKBS8xbX6NiAkhrxYRVMI0LQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=572 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501290137



On 1/29/2025 10:41 PM, Vasanthakumar Thiagarajan wrote:
> 

Sent to wrong list, my apologies.

