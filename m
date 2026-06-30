Return-Path: <linux-wireless+bounces-38349-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fGbaEtKQQ2rGcAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38349-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:48:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 012DD6E26B6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:48:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PNleNZGS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=cyqEMFNe;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38349-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38349-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E7423070E1C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBC3769F9;
	Tue, 30 Jun 2026 09:43:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E652192F9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:43:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812590; cv=none; b=SDNPMimY2IywBeF3xktcF2Q7MtcauKchFt+y4SGXtUpU6b81O1EQSiyhsiasbvR0Y8LrmDmaR/8ugmbG/CSJ4SwrJx1cNe7fgA1ErJa0Zyi6q8jsoRcRuz06/WyeSqOv3pPMiXyk8M1m0M4t6lD5c8jbam26tybyep53IGORR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812590; c=relaxed/simple;
	bh=gjuHbqLsc1t77MjXkOk1s5u4i5Rjk4tLfCfcxr3gdFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPJEPjIhmg/+0GxjCC9UI6PzFgKaPuo8rKKPckYef6D+L5jsml44NQNdioK1Ph4589CtbstRr0h8kf/u+X7tZe0TfdvTtGbaI+t46M0YxZo1dxhtM6cJEzHw5iwYfI5a1K4MsHKyR5SxeqBke3q6tm8+G4QnWaX1vLc6Qx75+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNleNZGS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cyqEMFNe; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CJC51008537
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e0z6v/3XR6OT9Ka0uNrvJzg5uwpb1hRYu/d4UpVlOv4=; b=PNleNZGSVmPM7rZP
	9sfZm+GQRNYfefjKUjpUh1iDvO+2jsv4LZeiiDQ4R0DD6vTR5RMGSlTw9FABAIsg
	lS+hE7Q5FIdRD2usKDwY5rxRNuy2iEokj4Xs+TIYadDHPxUpB2MmKkC5Dg82DGkH
	T3Bad+tatwGzW+AET9HPufoIe5KgMrzejkpS7/UM7LrYhRi4MjorYpvJ3FXjTphG
	KzpcqwYtOiANauZHVhP1uPDkNmF8IcZp8Z8ibdGT28K9whBWyqym0gnSllACCy3P
	RK/FWWA2PGCccsGFOzblUdYR4kPPbtoiHISnSRx9vRh1TMeUSeXnw3wdhbujDSZu
	FpQ6nQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw92n6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:43:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c98775daee6so1568206a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782812587; x=1783417387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0z6v/3XR6OT9Ka0uNrvJzg5uwpb1hRYu/d4UpVlOv4=;
        b=cyqEMFNebEpN5yBlm+v5mbkT0578cOsyohZMfdgbN4AEzkF/8l3sJJi8un8d10ZzlE
         xH7UuBobftua2lgluwBPloLl+O517VUAVJwgwF+VYHQfAyddLOmg+eoTHpdBgoeqyzfs
         e98+c8156dDX0gWjWbm/bS8f9uA1dmAoscSdWismDUQipOIQCqImsziMI3Q0zTKGOWD7
         5f/Wuuvon67LiSRuQFrtOdQwNUeAq8z2BsDpZVUz5GczW4tA+vxa2PIhZz+3cVrTfpLz
         8hYEjaVmRYqlXjHSMaLe/rgIAczDuErfpNlm65+ps7yHHIFqaQo7qasn8mP6Iylf+uQ4
         ZGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782812587; x=1783417387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0z6v/3XR6OT9Ka0uNrvJzg5uwpb1hRYu/d4UpVlOv4=;
        b=J2S+QIFMUBfACiIxDZ2Uas89QMthHmSS0m1O+uC4Y3tGvCKh28lwuy8ejb30eRjDIi
         J/A+EamX/mgv8aBO4XiYQRwuJPyLIXwE44iemiwvebY4y1+7rdH7NtQFYha3UXlpOmuz
         OCu9LzDj5ahSdWOZODsJXKBesRQYK7iHLPkPkNRB/6BIkh/tl3VmNAXWhKol/rpw/gdZ
         oVgte6yu0Y7L1UQ6kDjQ/P+hdFZYTc+KLuIK5lkTSRwSZxT6FAfy+02uYdgQeXzihaG8
         d7s7ka8vca6NGPp2slO/F2VLI1UPpTbRKni1/p6zjw2BsxoRq1hmogMiFDLnqmK1Ls/o
         1WfA==
X-Gm-Message-State: AOJu0Yz3b33BBWmvXLRhZzqSPrK/95YGemTp9LZmiMDviqlwgEO9phsU
	hCtjrn7hQPBPNY+h/tO0BPbpjZ+9KryU+YagKpX5rbqG4MAcv7ArhN3QtJjzsTtA7HlpelgxaXY
	U4UQJVX7N97QMX9Al/LqeCFrZOUvQYUv7SheXX5vmaQSvp+kkd4eM1Z576cFB11L+J9hd8aH9fz
	T4lA==
X-Gm-Gg: AfdE7ckfk0/aFfrAj6GTqXVN9I8W95hhncrk1pkXHeSy6ArIvsIOGkKwX/fjEgH8Dxn
	LGv45oz4sAGktFSyK1bhK6gkrY3gLLHIZGa/iDPri/3Elpxh6wquIgj3uCI+3SADN2/M0dHTQ+N
	KPG1A7z0GObjFu+aa08Ri+p5HiuDz25/KOt3fbikp8WXkR0rkM1y4qqsJdKHR0jHBWBm/y5Scfk
	atkMwX9Ta2H/GevDo5xahZOdcxOh1FY+xOorlij9y2qbA5bLvWF7KxwAPjACR6kkAVZ2g0ZxNAJ
	SqAXunt2mRKJ4UHeQs9KkYYspbZrs0ysKT3NlozRFCMEWhIsDFHKHire+mKtj0OuV+Q4y/H5qPZ
	lOKMV+7bxRNaSY5DEKABDIFpUGOtOqneV0JNkJ+k=
X-Received: by 2002:a05:6300:4047:b0:3bf:b6e3:fbe1 with SMTP id adf61e73a8af0-3bfc549e62amr2736298637.55.1782812587216;
        Tue, 30 Jun 2026 02:43:07 -0700 (PDT)
X-Received: by 2002:a05:6300:4047:b0:3bf:b6e3:fbe1 with SMTP id adf61e73a8af0-3bfc549e62amr2736273637.55.1782812586756;
        Tue, 30 Jun 2026 02:43:06 -0700 (PDT)
Received: from [10.152.196.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a002c995sm1549725b3a.24.2026.06.30.02.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:43:06 -0700 (PDT)
Message-ID: <01b3c5b2-bd31-4862-ad4b-ebabc29f57a1@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:13:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Flush the posted write after writing to
 PCIE_SOC_GLOBAL_RESET
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        mani@kernel.org, Alex Williamson <alex@shazbot.org>
References: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20260623141649.41087-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
In-Reply-To: <20260623141649.41087-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4NyBTYWx0ZWRfX9JQkdV6gemE7
 qmv9H5M5PyuJTBWr6jYLjMaaWTyUVcVWrdsFJyTbg0ySQB0VjVfkwBR1nFbTo2XMt4hW5R+hzuJ
 gPfGyBTUnvml7tL5Fy6BGEMoTkWPCk4=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a438fac cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=EUspDBNiAAAA:8 a=-7ihF9cDai9aFXk1VuAA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: T0VM7f0-WTIWXwzFTD3n0Ow3li4I1FF2
X-Proofpoint-ORIG-GUID: T0VM7f0-WTIWXwzFTD3n0Ow3li4I1FF2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4NyBTYWx0ZWRfX/iAWvH33X1g7
 TObTdULmrN7+T7lQN0CdXKoLCqTCy66rmxH7zpVil7S6JfpDcS0Gw8u85abJjPLIDTSvGBR5ACQ
 E1PkEaXqceVeXBePX3CCacL5RyMLSh8z2otWEh435jVyITvVYMgTFUff1g6jVr3xkAMm4BbA2BI
 k7rhXyyeR3ryKhb1O9VggTOuGRme5et95NzzUcwqHTgukb/JWOCqKaW9PED3OmBhfx0yKGNcc78
 hZmVIOxzqkD1jPHJxHz2fbBVmjIijBYtRTG3yQxVkufOI/0hLUEh50RNNPR6S+3wy1RPhJFfSgH
 CJ6osTfUwXtUWcgo3v3BD5BK/HX/Kuv/0ddR4HFSPcoDn0HevW4ZCc/GEysD6WQdWwfmoh7Joa6
 WKaH6yaop8CpoXSRrI3jsCbPITf6/N4KQX3RoNe2rB93OgqPqS/7KLE0M7tfrerTyoPowB5uaDy
 OKPyCgJ+Poza4uwsnPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38349-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 012DD6E26B6

On 23-06-2026 19:46, Manivannan Sadhasivam wrote:
> ath12k_pci_soc_global_reset() tries to reset the device by writing to the
> PCIE_SOC_GLOBAL_RESET register. But it doesn't do a read-back to ensure
> that the write gets flushed to the device before the delay.
> 
> This may lead to the delay on the host to be insufficient, if the posted
> write doesn't reach the device before the delay.
> 
> So add a read-back after writing to the PCIE_SOC_GLOBAL_RESET register and
> before the delay.
> 
> Compile tested only.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Reported-by: Alex Williamson<alex@shazbot.org>
> Closes:https://lore.kernel.org/linux-pci/20260622160822.09350246@shazbot.org
> Signed-off-by: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/pci.c | 4 ++++
>   1 file changed, 4 insertions(+)

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Tested-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>

Validated with 25+ successful ath12k and ath12k_wifi7 module reload
(rmmod/insmod) cycles on QCN9274.

-- 
Raj Bhagat

