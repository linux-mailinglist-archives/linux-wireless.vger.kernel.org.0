Return-Path: <linux-wireless+bounces-18802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53282A31D42
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF15F3A6971
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 04:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA4271835;
	Wed, 12 Feb 2025 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6hEwCf5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC41DDA1E
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333363; cv=none; b=MwkE3aGKmXJ1MwPmDov7w497zhgmMZLoiVfLJvDEa0cCVLD7Q+EL7h/thw9nmtiL9ZCA/WzZX/omp+fYBA4fNXH520lcxOwyVDVGXA7sur91xzC7BtkihuGpwjRffAF3Sn1X8SypIcgx6QY/Rvw2W3JnJQxg+CKjXvmu1amwT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333363; c=relaxed/simple;
	bh=OEwWbRLrKnAb3RGADlGIkoKP03I+S+EzXwrlWv4oVpo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qkzn+LiMbEgDnpSt/qdLlmk6ASkJphtvxSOhPALAKzM700mzKmeGZB3MFJ1s6qiFDEBm4Nm+F/6yQmBjBk3Mo9C0Obu66rdeYHLcVNrT5jGKU0CJi1CdQ20gRhxi5zpW9KF5oTpCd7qK0vxlV0Ygv640YoP66sWQOOH2LgjWvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6hEwCf5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BH0a7j006115
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 04:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UmkM2sgKl/os28MvWYbqe0+++DekWCHSvMHgkykMltk=; b=A6hEwCf5JEJvcfyr
	/DkXYhvoeJO+wWjVumyF23ub4fBEL+GCyGHjlJQT8pwO6DoDFsPrM3j+5JhKLtj/
	5DXP410RczMDyGnhfaY18tZpvdAivkAz4mJxzenLh1aex9L/qFdZ2g8/b2BY8F4q
	vwFD6az/Q5dxdpKYamEaB84UevFuMmXoAOkWeLvWs08oEYKAcpMOlOfsSU3lleIC
	ozBFDXDQQ/44YsW76HuRTgyMNJFj48+f03soYzNbO7EtpcVoJCxPGoP0JMuBsaG8
	Zxl86L+v0Yy4F3c1/bYnP0a0ljUDdHG96gUzLx3cyYDHC6UXxDeHfrcsaJKhIx2J
	V0mnpQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe5mx79e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 04:09:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f9c02f54f2so12807193a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 20:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739333358; x=1739938158;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmkM2sgKl/os28MvWYbqe0+++DekWCHSvMHgkykMltk=;
        b=C0SPdJFDv4eUm1yACv2P88NWy/wPQWtMKQemPzjnqVQEgydBIEXXQPZPLPNKiosM2B
         4KlQtkBLlIW4OIGf46TtYzD1WSm038Z9bQm7Fqtl/ArPL80+KknSv41dw2Wl1yOZkKRQ
         vJ9rMJAaBRAmWd6Im+82wTvNIEJJkEvwylJodiu4WZTYarn11NNhM4wC8cl3PsuW5L1V
         PZInubaXW2NOooLAFf4LVQQwr1ReIUUshOqCwLx+/YsdGJ1BCxuS5UFvssuApBRsHONh
         CpA/uuNY4f2YIUzKHu/7iO5bNfG8BUh+YcDfclKlxjXgLIOkdhFt0plpTW6gaE0sGtHT
         6izQ==
X-Gm-Message-State: AOJu0YwwRm2OsYgF8BAGI6Tc8VH8C2pD9kc9xM5MjXXLv87i5oHtCwcd
	VUQanW9PX+3+QmlJluvfK6nLdeyPtztfRDO1Vy0OCgPh+t6M6Hstd4Ixafabq45J7XyCUusgmgj
	rggvL1HgBtUNzbRgyErUzHide61/71P116u1LT9A3Dbr6MSlqZ8HuWL+f6Ecu5IUJ5g==
X-Gm-Gg: ASbGncs9Om1UIAi7X9ParzYZOPr3R8lgBvyPHeu8qbSnt4TT3rLrqYnec2VGiiflVv+
	ltHltZx9sR+CW24LS9koGOucDLkm7aSB/vjoOjl3G0/DJ0rbBnBSrdN8TmYb/t75grnnNGC60Dl
	v0EbUhDNJnb32i+5JSWnTHoN/U55dw2SAvtKU71aMkK730Y2M9Azv8zz+xoOzM7n4fCV13lWoDi
	/B4/msLWukOBU1KyZ+J88dBoZBCtuS0NJlewYfyuC/FkgbcWbrJW5W6oo3bnSo5tBHBmy7Tl8Xf
	q0DP4gf/3d7Jg0akJdKLcluwpyX8aUrbFBQ7izHdMALWWrk=
X-Received: by 2002:a05:6a00:ab86:b0:730:74f8:25c7 with SMTP id d2e1a72fcca58-7322c37c0femr2427623b3a.9.1739333358613;
        Tue, 11 Feb 2025 20:09:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTqahfub5fqTygv21tDtGBIbsQicMGyjE5EH+CHy9veEfQeMdI2r/bIVUx5ZRMWVvonJo98A==
X-Received: by 2002:a05:6a00:ab86:b0:730:74f8:25c7 with SMTP id d2e1a72fcca58-7322c37c0femr2427595b3a.9.1739333358204;
        Tue, 11 Feb 2025 20:09:18 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7321b34c003sm2263027b3a.52.2025.02.11.20.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 20:09:17 -0800 (PST)
Message-ID: <03697f42-7237-9ea0-311b-ed0cc5ac4e7e@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 09:39:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124113331.93476-1-nico.escande@gmail.com>
 <48cea2db-c6a7-63f1-5e3c-1db77a6fb84e@oss.qualcomm.com>
In-Reply-To: <48cea2db-c6a7-63f1-5e3c-1db77a6fb84e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lC2DZly6N7FXXhNYy_LrAImie9vo3VCN
X-Proofpoint-ORIG-GUID: lC2DZly6N7FXXhNYy_LrAImie9vo3VCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120030



On 2/12/2025 9:37 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 1/24/2025 5:03 PM, Nicolas Escande wrote:
>> When AP-VLAN was added, we did not add HTT_TCL_META_DATA_VALID_HTT flag to
>> the tx_info's meta_data_flags . Without this flag the firmware seems to
>> reject all the broadcast (ap-vlan) frames. So lets add it same as ath11k
>> did it in commit 5e8a373c8699 ("ath11k: Add support for dynamic vlan")
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> 
> Thanks for the this.

My bad, I meant "Thanks for the fix"

