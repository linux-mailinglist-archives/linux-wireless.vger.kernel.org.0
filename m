Return-Path: <linux-wireless+bounces-22146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D4BA9F54F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 18:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361F13BFA30
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAB269CFA;
	Mon, 28 Apr 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXB90UCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CE2309A3
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856824; cv=none; b=H1jlpfo+VZqPKB8zJ19HCrWSF90ksqu4aL23DUmYRAuMQ5roYoyMy77L6mesPH+Qgl4zaDR+67oPozLUSJ1WvQ3YdEM/11Th1uynT/7BtTiA2IEIeiEZ/UBzB1PqRVpOLtNkGw62zVzReAr+Ae4z3gKcgxUbPKjDVYmfu27cUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856824; c=relaxed/simple;
	bh=6dE2KtTa7cpacuL5H6pUigz3RnXWS6djzYvTFfGdKC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSGP0wKjqT4VRwcctMUbqaxZ7+5K8l3Fxt2IkUOYKPef9Qn9rwByQJPk1cat4JP2BtFxBI+mHxj382akkF0OUTA03bwN9HNGBccWN8dR2lJAWl4NGe3LH7DJ0vUeF7DdOa30IqhUxeq7gb+XYQPrPM6//l+fYCSyqLjEuyfHq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXB90UCl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SG1lfL020167
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D8we/A24VCleiu1L9oIyqx2x5TSIcaS7vbGyH7HDGXc=; b=LXB90UClggrzgzGu
	fuS+1nPxyo+FIzjnBqnwR7vzwejyORFEEV9jnPzK7vUEKGsCqFQxJTJTW0/jBcJk
	p6O7iLjYerdGVowybofuuziJs0QcMw1RvGk6GhnENbaw5iVnHpd6BXrCkkYvbpcU
	aj8AvYfrVNC6Q2eFDEvhuoTeQdvUs+aUd10wFIW6D7xMmQ59p8HA35N4yIradAkC
	TKVi6uQwi534ks27jYNiHmimy6rYGc2mY68hhO2y9UE+8ZZaFpyUD5OdEZ+IuJFT
	CWekTSqxgPtYIZQW8WECYVmFnKKAFeYwPDySpnghwej3hEKQU1Aaq2ySFSk22+0U
	olB8xA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468r8hrnyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:13:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254bdd4982so73397105ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 09:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856820; x=1746461620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8we/A24VCleiu1L9oIyqx2x5TSIcaS7vbGyH7HDGXc=;
        b=aqLUf7F7+oIpzKcjmp8FI8INaKjNSg8qjGDEqmKeeZSYLTtD7aF7NkdzGd0pD2IDBA
         SH+hQCN15kuaXtY1qT8kveIhZ/nDvwpKgdb6UwFAroCpPbs31Ic3FUQQhNV1m3x/a9cZ
         LNCElX2vKcxFWNaHxLVVU6mrs2pBt0GxjPIQLYAZ+nbxH5ceQFWRCvyyxqVuvi87Ssuo
         fXPRGIKW+DZtUAHAbwRFi0By5rSbIJv7Qd0pj0KWzGGSj1tmn9UKk57/9DChTnxzVi/6
         SUoOZRCTT7MSypCkP3JXezAhZONVslc1KSrO/zm4tQ9T2PBdJinOzDDLTi2XC2h2Dh1M
         k60Q==
X-Gm-Message-State: AOJu0YxWFAotqUwjAsH9sC/jeoXcj5iBjmsSEz/vNSRA58ADE+dEOyA+
	VwakFsa4tdM5aYZRIf/mYL7qrkks7471tUOc0Q0TWrajeqTvaHkRaK22zIZ3iQv+rQCtIAq52/F
	CuFAtUMA6ZIzIy2JwWHgWl7fpXcBcZ1FbNwtk7rKPqeWZ42VOTphX1nGk7krdWOxHrg==
X-Gm-Gg: ASbGnctMEQuwzz/e8HoH419/OXShtgrt0XhUl00ykfmj5sqZk+DZUqTGpl7HdUXVFbA
	sFcyJB+7WutNT4gzvL4DGp1q0NFIQ3GhIEojR48UtL52myMyt5OVZKly7o4A0myP46XvZdxHKcu
	PXaFuNmzUyheyXONATHW3FZO8AVXJ40deplHfskDfjIWpavjSfiK2CE8KG/Na2hdO4XSMV9z2+l
	1HobqUJgl0AbRp9H5D85UKRGbi2WUDl+LMAFpLozXj5LJNUAiAsBIunQ6LBk4RgJMvyKudh3/6o
	UAQ7XLmDbko80rZRbCMGUToDLO4Fb7/N38wMLmSe1NKliOLWfzRjyfc0zz67
X-Received: by 2002:a17:903:3c4d:b0:223:6180:1bea with SMTP id d9443c01a7336-22dbf6218damr192112135ad.37.1745856820289;
        Mon, 28 Apr 2025 09:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFQ7Id/p1uW87txW7F2ECaSz8fiByTLszVSkzSMB/oz9YpMbg8QzGy2y1k2FKTccnT3cawQ==
X-Received: by 2002:a17:903:3c4d:b0:223:6180:1bea with SMTP id d9443c01a7336-22dbf6218damr192111825ad.37.1745856819926;
        Mon, 28 Apr 2025 09:13:39 -0700 (PDT)
Received: from [192.168.225.142] ([157.51.192.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef098157sm10202290a91.26.2025.04.28.09.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 09:13:39 -0700 (PDT)
Message-ID: <1cb0effd-71b5-415e-f419-69c727913f2e@oss.qualcomm.com>
Date: Mon, 28 Apr 2025 21:43:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: combine channel list for split-phy
 devices in single-wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250417073954.632994-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250417073954.632994-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sdwiFbX55NZtqniYKTUBbtUR8Gtfz_LA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzMiBTYWx0ZWRfX6G9gLsJ9Z0hG om9Wm9oiq0CwPBtbp4UuXPP26heo997ZUwmUl2uuG2g3PNrKdMK74ws5JyvWQEnZX1E/Gf+Asu6 Oau6bAkQBuEC0BhCihIDe0cctir856lwJI07wjuzuQ0PeP/Hy8kyOFRqIo1JyGfIa97y00hNSyo
 gdhRF3BKz/insNYkwn/1fCpw9ARxFktOGSd92akAW2icOP6PGLEWb/3Qt0fGo1ruSbwlMDoNhDH wr/n7RppvQeN6lKq2P8jl5DdusFGcD+UnPMNPh+j4/ghBpdoxrIAb0/rOPQtZnDyL6uP17QP9wv /Jm7nG4bPcH6NekSsj9bJqXdhzaQwUfsEXp6xl8RrYL4qEf/HD6foE6Li6UxWEn6z9BPQ8ieFHR
 IkhFG85aFfe9cPWxrCM+olZZw1kXvCsV8utY3N5qdMYnESWFk5FdH1Gx6jdKTPZLlHosggu+
X-Authority-Analysis: v=2.4 cv=cfzSrmDM c=1 sm=1 tr=0 ts=680fa935 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=XJI/iaC0GbrNbCf3OOiYRw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=2LzJI_1lXDcI7TO63KoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: sdwiFbX55NZtqniYKTUBbtUR8Gtfz_LA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=830 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280132



On 4/17/2025 1:09 PM, Rameshkumar Sundaram wrote:
> When two split-phy devices that support overlapping frequency ranges within
> the same band are grouped into an ath12k hardware (HW) setup, they share a
> common wiphy instance. Consequently, the channel list (wiphy->bands[])
> becomes unified across all associated radios (ar).
> 
> For reference, the devices are:
> 2.4 GHz + 5 GHz Low Band
> 5 GHz High Band + 6 GHz
> 
> The first radio probed within the 5 GHz range (say 5 GHz Low Band) updates
> its sband reference (&ar->mac.sbands[NL80211_BAND_5GHZ]) within
> wiphy->bands[]. However, when the second 5 GHz radio (5 GHz High Band) is
> probed, it replaces the existing wiphy->bands[] entry with its own sub-band
> reference. As a result, wiphy->bands[] always reflects the channel list
> from the most recently probed radio in that band, restricting supported
> channels to those within its specific range for upper-layer.
> 
> Fix this by updating the wiphy->bands[] to just enable the channels of
> current radio when there exist a radio which already has set it.
> This will make sure wiphy->bands[] holds reference of first radio which
> got probed in 5 GHz band and subsequent radio just updates the channel list
> in the same address space.
> 
> Since same sband memory space is shared between radios of a band, while
> determining the allowed frequency range of radio, its frequency limits
> (ar->freq_range.start_freq, end_freq) should be used.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

