Return-Path: <linux-wireless+bounces-26176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3F6B1C761
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D0B3A2419
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022728C5BC;
	Wed,  6 Aug 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ITE5Y9ZX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA228934D
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489412; cv=none; b=pFHLBx5EVj+Jy2ruRG7StY0VkVrVfXhI5kpVvG6ZypwrZjTInLNJVgGYHChgwL9Y3z7azIFTk9A6WG5NS2++lCT1DxsfFgi3TBzQ5fjc18clpTB7i//BhdrR5uKncDGR7nVy8+TCZcp338duzj+G6Sz+ChzGQE+5RfudWQ562a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489412; c=relaxed/simple;
	bh=aUyjuZGcXY0dNHHGX8KYxpO6gAvcnqjyCMaMOwvMQ54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI/jUq9AYsQxlXUYiLC4fk0haCGpJFaHqqs2+zerf4dyr7/HwCn2ALal4bdTKKoSUD7lWR2chcnuCU4xBQgFlewOf92oCF82JoIxtFwUypcR+R+4FXlHA95c5ioODg+Fy6gjK/W11YiyHKbzj6lC/LFuz7sbmepfMjVgaS0Zg4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ITE5Y9ZX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576E4Isj013679
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 14:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ldco9VGV9/AxZ9ihFqepHt5ZP+skAMv8MaOKmwqgkMY=; b=ITE5Y9ZXXc/DJ76K
	3Rp5c0p0XYo+oAMvxIZY/+eSbFr+jtrMEtov+lLHTI5qhBOssoRTHcl1airMQ82R
	pIdDtsaljKPwe1ng7qLZah1sKjBcFXMfL22PzATs09vG4B+LEkvoRN1TrBSU8+Pd
	rZfnQI5auazkvN96ABL8lrOkdTpbFlle1IdvLt+TolHMIPG/5Pd3fAzEhcd3Ts/f
	KToCEYAb6pYslMzfwUzRzSZAP6DlGggazwy+5YEULtWchNxSq1oVPoFMMzrJBQ0x
	14f795WBQW//Q0PPWM28+I1+clbuUoajU8k3d4AWxGrA6rm0YaijfAC5Am18QH4T
	geKVoQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyctvxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 14:10:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bfab12672so7490827b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 07:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489410; x=1755094210;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldco9VGV9/AxZ9ihFqepHt5ZP+skAMv8MaOKmwqgkMY=;
        b=A78075vzoEJsA9xX6aS43SZTzdumF5xRDG3nBh6UqD/jahlKkrQpZP0InGz74WHGXE
         eiQSMv3EB2OTkZz3D9X5DT5T8aR+Lrf9AOE871vRrJ1Eu7mScZ8ekeALbr5r78vZT53p
         NDpN62p49kfkHBZmX4RNQvPBU4kqjUmpnO4x/pFA1FCXs1RS0eLF9T8ecIvoRyAa/qxu
         d5mTm2w4BG6x9udlThgzx3xZyq81DCOK2tOiUqfRmy3gY8eIZjl4rgvThFjBnWEZqkwH
         kgKsPko8YuB4GAhxgKvjDbwaYo5gtLVDCD2Qj/HRTuFkvTnzm4zCZ8Fg8z18bksaiKly
         96Jg==
X-Gm-Message-State: AOJu0YwUDkOunLH1vCaleurMWmPna7gSbb72a4+zB4Gy8FCLABIL6Efh
	8zqYkLBeh0OWcJK55FfO7Y9CU7LR0FZ/EQFTMF2nTZGgQekxmfG470WRnXY6q+fxQ3yE4h94tix
	DFIvWWrZFgf5fJEBP8EBFiO/Y4uA5rq84Tr41MY79dPsrfoHVWalzy9EYcm6R1wy6zQLWf/ys54
	taeA==
X-Gm-Gg: ASbGncuadbJsy2fL2CX40BdqlZ7YCNKYk7SAj+Zoxnf3gcSVxgmyR2D9X/ltmfPm0f3
	eKTedDthaaYH70wTn4YKTXhhra1VTFgiczkXT62sATaxu+2st+KAWT5Q82yVxzUNF75GYiKHeZH
	/MDRUnn6QpHdvER35lUDPlkNC1A7sBRBEZnHlIpzlFGn2QZMuS6AozE1GxrR5rslSkLPRJ8fT+P
	0kJuBJLA4z8raYakNgLGW/+ZRWXY1joj5LM1clk2rhdxDYxFD3mLozmUf4OP+P8Bexxas6956xD
	OzFQLWTMFfRUf+FBlpNFgyCAy9xBEZXAPLGamkZ8nEFvHcDq3JMRT/hc0FBI+ASmTagTJp5eY7A
	O+Kp/p+YDPjrIIVyPIhk=
X-Received: by 2002:a05:6a00:1817:b0:76b:d8f7:d30b with SMTP id d2e1a72fcca58-76c2af7aa3cmr3017998b3a.10.1754489409748;
        Wed, 06 Aug 2025 07:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzNrhBL2zIZz8t0xkLTHT+9snFgYHpKK06KmLuKGgNauWXMLuf5Ab8TLJ1Q2uACzyQ4tSNSg==
X-Received: by 2002:a05:6a00:1817:b0:76b:d8f7:d30b with SMTP id d2e1a72fcca58-76c2af7aa3cmr3017955b3a.10.1754489409247;
        Wed, 06 Aug 2025 07:10:09 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd05dsm15434414b3a.81.2025.08.06.07.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:10:08 -0700 (PDT)
Message-ID: <81440d36-9729-4eb5-aa30-d94d0f85b7a1@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 07:10:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yb6cbTVRurLq5yaTf6by76OsvhdK_Lxc
X-Proofpoint-ORIG-GUID: yb6cbTVRurLq5yaTf6by76OsvhdK_Lxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXzUbpcJ+R3neV
 XRZ79mCTfxrTvXQMJ60m7ltWFsfKu3CoAqOwRhBKx3gCTbLY5Tm00oPNNhMkUqvvzvRsY0Odk5E
 tg/gL6PMAx44/RtxXicRb7bmUoPegvWrgXyYMT7XEPdtns1ObQmSqPDVrtKMLDZL1VktyODHGMq
 +ySMxHKE9y3YXY2boLKlWDH+tyMXsZr6ka15hVOobNFevMOznf4GVzNIM4f9+2yH05oZa3TFTqx
 pKEFEfYBf3OoGsVXEW509I7A/k1uV6RnUqP9X2DNSMt3r3gUyVMnDUIUrXZ885rMtJJ6xDlhNkU
 vGxoJLd0vobbbvCA1sh
X-Authority-Analysis: v=2.4 cv=JIo7s9Kb c=1 sm=1 tr=0 ts=68936242 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=BoDogKCtvrOBLCu30DUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060008

On 8/3/2025 8:03 PM, Baochen Qiang wrote:
> Fix below two Smatch warnings:
> 
> 1#
> drivers/net/wireless/ath/ath12k/mac.c:10069
> ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
> 
> 2#
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (2):
>       wifi: ath12k: initialize eirp_power before use
>       wifi: ath12k: fix overflow warning on num_pwr_levels
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Since this is fixing smatch issues I plan on taking this through ath-current
instead of ath-next.

/jeff

