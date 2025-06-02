Return-Path: <linux-wireless+bounces-23537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10DBACBB2A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 20:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07844188F836
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 18:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8D1922DC;
	Mon,  2 Jun 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o2pDPgXx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3A33F7
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889847; cv=none; b=TDr4WT9gqpqdfuPHcNNGbVE8kzJSZBMdJ63Ac1c2Relfw8EbgEOXjxEN2XZI68GGg9eeBz71SJ/TfJJpOSCazJtuEadMYe4UJZCUQ2C0ThkNif+7hdzQKrzeScv16uZy3fSmqdnfZ1POS5Hd2cjAv/EIGQzq+O8KJWqtfxE5iVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889847; c=relaxed/simple;
	bh=XmtpEbxQTVY0TxB2afkia9yFjnx6FANLX2a73TxZpqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYblMne1o2ShMdQ+Yy7oGr1NB8W0N6dWFoiQxhNc+C0+iSzcbd7Lvywsi4xa2ImcmIEML8/AJ9jzlnJcCivnIqmkHAu6WhTSeA3sMSimI1U6k7Nfo/T7eoo95g99gsbOc9bA6VZUuziZhnbmDfNNsNE+pq4/FhA3vVi03RxwgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o2pDPgXx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HK2YM007730
	for <linux-wireless@vger.kernel.org>; Mon, 2 Jun 2025 18:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pkhb0fZJ6685MfzVSA3b9RYxGVM93ZFjX8xQbnaRk7w=; b=o2pDPgXxuqsz+HTq
	p9M/mjJ7D6kxHe/RJz5w7qXbVS8v1sL7+spBWf33WLnQPGBdv3XViIYM22jpUlyb
	Op4c/mcYPG82IGIphJu68et/bwens/v7KZDr1h92tGGcTARFAtNvIJHBER2EmGnA
	CM66vWvuaOPxq+DJ+bBWbXs55TjnJwzpHrCSP5o0otKj/2jlaTH8uMwogZOKm46m
	3lBUrD088yiHQR2pMsNlsOj+MbcDxB6M7MV+vMlwR6oQXDHCcT68mbVvNOENeSK+
	oTurDLGnXzxieqJhB9cn8VGIX6SKImiVCdxIItCwxhW4J5QWa88VOyzol2MlR8gJ
	ojsecg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yg73b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 18:44:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742c03c0272so5682833b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 11:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748889843; x=1749494643;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkhb0fZJ6685MfzVSA3b9RYxGVM93ZFjX8xQbnaRk7w=;
        b=krT/chJ5fkeQ6YsEef16JaqSzCRxT9wB6wD6rpS2LyTZb35qsTxJDyJPS1QksXo2fq
         uHacZdXgjRR4dODDwXDPvFL2BR4bkLUkYgi4Vv5u//pmU86wIoFBVBFmU0SJJ/xP6QeV
         gsKhYd7PqAU2Bp03KtqTys3MQamLitny5wZkcbbIMUZaYz2ze9IcEVQM/fQXwvElDlh3
         QfE9v4utheZGzsmBpEOUEr/qaHIr51xOLzyqy3OmcRDbxQBRV1iPAS5tkz3Rh62IJfGr
         H/l5o1TBdLnqrtl+y0+zDJ2l3jKkSwGsMfURcKBk1J5//Lp2QxdvrBtybGssPHNHU8II
         h+kg==
X-Forwarded-Encrypted: i=1; AJvYcCX/yFmfEjiS4NJh052vmG1mYydo24yoZxh+7lhXhULVxFVWK7BjGBCf4s6BbMrBcaLRwmRBx3jfXcvwDJLAPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHr0us+ZzgZoaY3nUk+gyGvqLML9pXFpnVkfaqE9DGrcGcnQc
	2HU6jFf0J6R9BkE5KABAV9a7uetQU5swDC4sXG+5+/3RsaTSKSSFliJXcqflag4I+Iv7y59GfYW
	tuZ9JdOM6Ch0Bqr6lajJKJiDyMCZJrPAmYf8U0OK3zer2mJMv8XTSoA98nqOR1ADKDvkHeg==
X-Gm-Gg: ASbGnctRaDLNZ2NM715R5J1Kx4jAlAOtG6OeD3xvkZ2E2QmYAvzZ4by7b9iiguvCd5Y
	eS/thD7vk9QK85WQ3optFkqFUhRGKgKuyQIiPBt91B/KQBjtOPrqUCKn27JyIk4huLePUPx3vvp
	z1nXk5GKo2jzpByn9Uj2LQD94isEoFswnm/j6gLrM22oLSrsIfdJNixePf50WPNF4KXMTIpS4To
	x1hyvJI85VCoHl0V7D1MNS53qeXUZXIUoTvg56jkrssfAo5LqJI02qppA//CuSLjr2Hn6y+VYN4
	ARw9Kguf5QLP0JVupujkR3ma29U0UVpM1944jIblWttuFircFFUSnDjaR4oIh7vHS2Uifx5MD8A
	p9TIW
X-Received: by 2002:a05:6a20:4393:b0:218:c01:ddce with SMTP id adf61e73a8af0-21ad98bbc8amr24524338637.40.1748889842917;
        Mon, 02 Jun 2025 11:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh3f/0lMirOc3pBNrbZ8B3eldkYX/eh0mNVpbeV25DRUU76oAwll8v5eq7/Bs5wPVnGhE+Dw==
X-Received: by 2002:a05:6a20:4393:b0:218:c01:ddce with SMTP id adf61e73a8af0-21ad98bbc8amr24524305637.40.1748889842573;
        Mon, 02 Jun 2025 11:44:02 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafa64sm8208743b3a.93.2025.06.02.11.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:44:02 -0700 (PDT)
Message-ID: <1a5852c1-8595-41af-9a9c-282bd508842b@oss.qualcomm.com>
Date: Mon, 2 Jun 2025 11:44:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath11k: validate ath11k_crypto_mode on
 top of ath11k_core_qmi_firmware_ready
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jjohnson@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250522200519.16858-1-rodrigo.gobbi.7@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250522200519.16858-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE1NCBTYWx0ZWRfX8j5Um9EfyHbc
 nx9kFzoWTZHbdWCcsbdS3jiiTpzSoRDthCfgB5WpgFxiaW4vT5p7Tq7+Wu7RVQJMAo3IZ51uos2
 QveYaZlMapy4PF4hB746CMnn615YT6fh8rAyaJthCTth/FfxyA09+WzPif+Qbg+EIoJhoRAgm/7
 4Tyl0IAbaBhewVpgAffZRG2mSw58aPa9BO3ZJfwPDcSRK/YSL5OpspaydLbvyUeuHESeVh8hufp
 t7OULUQyV/mArtSkWpGk4RndFt4XtIAVE7kd8qXLOVO0wQbn452CK1hhn0BIVCz8l9dcNaHy7Gj
 3OcIunbGnKjqGPAcrsSDq6Y6F9H/Nt5yztnYsihC7e2RSKDpB53NtI3wEQeosqmztmxuBzip9yM
 lyy6gedJaqdcFbRmnQBz4imy3YSXFQs1vjDv0gHgjUaVs3LTBo93Pn+YX+vLixiYF/iutQ4C
X-Proofpoint-ORIG-GUID: h0UnmJceE5xsJ-APOfT4PPxhUwayG4Ne
X-Proofpoint-GUID: h0UnmJceE5xsJ-APOfT4PPxhUwayG4Ne
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=683df0f4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=7IIfrU1qyLA2P-n2L4wA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_07,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=884 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506020154

On 5/22/2025 1:01 PM, Rodrigo Gobbi wrote:
> if ath11k_crypto_mode is invalid (not ATH11K_CRYPT_MODE_SW/ATH11K_CRYPT_MODE_HW),
> ath11k_core_qmi_firmware_ready() will not undo some actions that was previously
> started/configured. Do the validation as soon as possible in order to avoid
> undoing actions in that case and also to fix the following smatch warning:
> 
> drivers/net/wireless/ath/ath11k/core.c:2166 ath11k_core_qmi_firmware_ready()
> warn: missing unwind goto?
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>

Since this issue was previously reported, I'm adding:
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202304151955.oqAetVFd-lkp@intel.com/
Fixes: aa2092a9bab3 ("ath11k: add raw mode and software crypto support")


