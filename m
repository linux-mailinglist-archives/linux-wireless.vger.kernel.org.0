Return-Path: <linux-wireless+bounces-33449-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YbWpAd1mu2ndjgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33449-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 04:00:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 904192C53E0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 04:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19A1030268A3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645DB2C3251;
	Thu, 19 Mar 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nZ0v0NAV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JyF4/4VO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18219CD1D
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889238; cv=none; b=c7Z4H5QiMDLnXqIlvv6wMwD5/9Ur3oJJv9wSB+mCJbdcDKtMpz1ToovvdYhjza7TkF8tLdC/KAR+FkL1RHxP1f9M9HeRcgy6HMKymDXiU+5dVS0vbqKGdePzRNzpkAxs4GP+ZKc7H5YJSEot4ujQ4LfEiHSJDwo9L4fUqyUpJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889238; c=relaxed/simple;
	bh=VYeTahab9dWHytauFsvLJ933SiY9clgiY8Jl+9WZr4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tj0Wa5Xdeo5VgvNaUBwk/uJC5Arz7uislZddyGmc5oGdHFKMk+klMoUkfob7SuBiXG5Npsyg7L1aWV3c7mLinNrZUxq4n2qMPMi+fZT/kgnLvloMwvhNBPfFLx8rvU8szIEXP/RtTlz2N2MPX0QxHZJq6BD7L4XXbLnQBWfPndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nZ0v0NAV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JyF4/4VO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J2Su693413810
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 03:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SJtrE0QaoN7ncD+Y1nbvcSE0oQoNr4XLNfo23aiMjk0=; b=nZ0v0NAVyDwmcsm9
	C9+XbRCQ90c4OsAoJitgplAMg3pTQuyQxeu4Hnq9Ny6gF1bxSPGF5Qbqq9Cx1brk
	VqFTeOp5lXxE83zmVUeAbhvpDncD9IpLjZrA6PNVaxz3EkxfgOYlYDtMMzv0mND7
	/9OTS/3AKf8fSoce2TQeFUd1dff2e8gZDO9T4B4kIbENfCpOOml13IjEBwk2PdKG
	I1GHKleKwdb2z1guLm2o3OL0X39JOj7i2q0EyxgkjkjkbkwIKkQi3PqUhI4GGqaq
	4RGT+9qx5lAjzgL87FB2uuOQNQFekfcajsinD4MXdj9rP9EbKzfcqAwHWWzxC6Vj
	MyfcYw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032hnba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 03:00:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b059ab124dso7736635ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773889235; x=1774494035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJtrE0QaoN7ncD+Y1nbvcSE0oQoNr4XLNfo23aiMjk0=;
        b=JyF4/4VO9yTx3vSGhAO+w/QfXrL1wjTrptGxmdUurLzkK2IIOQZjhHwf/RJnSnLjCw
         4xdn5VtX1nSVH8sHF/x+GZn5fp4mTMy4KmdzlE7RDIGHEeTPzDOu2pbwD8MrFknsMg8+
         txYCfAje4rzHeeeW/S9u2z8hul3BHoYMY6HPJWy5Ic/Bj9bBeivPbqoLyjJwEol24jM1
         sS2rMrQnYZzg9aR6jpZVcFCBGKR8yjrsy2DM4rV1szbiSbGA6IP3nQYclIsmnR/S3HXS
         /4GQoeO3m/OY1qqDcFuqA/9vNQvohQ4SaVcZW0bFpypeDLwGkn0b1FDAqRE08+NtGQPG
         fvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773889235; x=1774494035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJtrE0QaoN7ncD+Y1nbvcSE0oQoNr4XLNfo23aiMjk0=;
        b=BN26QFWuoLjgbPuWzAUkX6Z7gPSgbRUe1FTwMhOoqNMVYXcbn2cRVuqJY1Ou9uPlHM
         /T+GuQqQfRGa/RjK/TMxWxxY4NrixW8hW1OmYHXFL+Vvd/Bofk2+DVWH7VNLuf/ybwol
         4wjifvsMvi3kA+mncoTGD6lYhLagkvMNzmNoHlbcywyPK6rN9iJsxFMrOdpQ+v+fs3sz
         GFU4tQcZVN8PYeBW85fMaEiwmRx/zMP+TMHPACbhWlfXqzOTOu2D8YoWAU9DnN+G9O0V
         ZuxUMAThE4TJXaox9WjKxdGoY2gfBzQ8jFUZdm78jRt20ieHUvwXYgJdX4d0ilHZezD+
         I8Tw==
X-Gm-Message-State: AOJu0YyUfAoX8+csAKGv8z6LGppqe/u0sWtSW+Qpv2sRLtW8OemlC+RI
	c9kCnnCNWBylo/OCY8B2m5+61Ven3096YmecdCwn1IiAmoi/B3r1cV7yYlP5oFO9azfcafjXJRj
	OZX13lFVX/LUD3IfbDytQ31rXSXC/uJ0Oq/qMUd9QT1gTPlyArb78lwsCeCpcQ8iHWJHslQ==
X-Gm-Gg: ATEYQzz/Hd4bwpiV32iri12MzYYZsYv7eIkBHT67vwTBLY6yxQH8857pakzYbp7cvQF
	aCkGJOw59btvy0c0lkF9Cb4y2gcxGMXHjVpeRu8+MnpUTSBY9gXIa6VYVPihqDRU/pr5+VCXbeC
	BuzD7yYY7rfzrdlrkbr0gZDF7oNtc54VkX0qTGCM9G2PsOOOgh+52QAsJve77D4pxgRCAu4UJ2q
	W7dr9EC2oceoyfHYGQXVkIm6BTmuTYcHIwfYM7ik8WB9WrMf6AZak7HQ7V8uXa66BiQ1FvZpfvG
	SApQb+mXvjEgH3D4kauZbsi8oUUkZkdLTLw6s83V2R1v2oxwf0MOha/ZDylf0RcVl7HxLhG+6gG
	GCwtjlUi72RY8dEMOfgSux6Tc3BBIZsPMxYmo5f9tJ06Fspq5KnwcM+QSOHXOcnvpRVuwVYm94B
	dUYOVxfP3INobZGLT8GuM=
X-Received: by 2002:a17:903:37c6:b0:2ae:7f28:124b with SMTP id d9443c01a7336-2b06e3554d7mr64196035ad.22.1773889229680;
        Wed, 18 Mar 2026 20:00:29 -0700 (PDT)
X-Received: by 2002:a17:903:37c6:b0:2ae:7f28:124b with SMTP id d9443c01a7336-2b06e3554d7mr64195545ad.22.1773889229010;
        Wed, 18 Mar 2026 20:00:29 -0700 (PDT)
Received: from [10.133.33.235] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e627132sm43286915ad.74.2026.03.18.20.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 20:00:27 -0700 (PDT)
Message-ID: <44549364-7187-4b1a-b1fe-5bf6e309ec16@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:00:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix MAC address copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260317-fix-mac-addr-copy-on-big-endian-v1-1-b7b6c49cb07f@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260317-fix-mac-addr-copy-on-big-endian-v1-1-b7b6c49cb07f@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FTYsbIyO4uM88xEFNLxaAxmzRCzE6DS8
X-Proofpoint-GUID: FTYsbIyO4uM88xEFNLxaAxmzRCzE6DS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyMSBTYWx0ZWRfX1UtDe/xvniP6
 wEthGt9xJvJh5zMyWWQvJkOz6YMbqpR3l1PsTudelV+EDEYX+1OFkpJSuBACnxG2mKtU4EQQP1I
 N2mha49BEvI5Aa8HKBrZmNbAeAtsm397I/jajKvEb5Bhrpd2LPJgC1xeeaiYIPKyy2rXJdYofeL
 +VMJGu6kZD4vhjLRzfVfYa+eI/VtybELYQaUSIC8kvh4706K/h4T6HwYtXYarBOCa/ynhmeTlmf
 fqReB8k+ycjS3Fd0RHmUlwb53kbOdYhp/8VEdv/03IamqyD5YLkUfJOO3sipw3YN9KERagx9D5h
 hmYHQ0ZLAioYiht3DYVn1ZHy+xHkvIRv3nAMxnDRxcXlIYpYprZt8kYgYNeDb0PRxceNqLfFwE7
 Q/oIAVefxJLyGm4c8Sk/zRiimihSebZEqpeirijBCI0dhzHxPBA6hM2Pf5op+dsylC4BHjkWkGd
 EbPi5jHzuRKuK6cNiUA==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bb66d3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=N9GNhs4bAAAA:8 a=ywX3x0iTvHv4trEmZJsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190021
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33449-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[westermo.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 904192C53E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 7:22 PM, Alexander Wilhelm wrote:
> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> CPU-native data types into an u8 array. On a big-endian architecture, this
> later results in a null‑pointer dereference. Convert the data to

curious how could this happen? how matter the endian, it is just six bytes which are not a
pointer hence can not be dereferenced, no?

> little‑endian first, then copy it into the target array.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index f8cfc7bb29dd..50957915dbf4 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -647,8 +647,11 @@ int ath12k_dp_arch_rx_tid_delete_handler(struct ath12k_dp *dp,
>  
>  static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
>  {
> -	memcpy(addr, &addr_l32, 4);
> -	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
> +	__le32 le_addr_l32 = cpu_to_le32(addr_l32);
> +	__le16 le_addr_h16 = cpu_to_le16(addr_h16);
> +
> +	memcpy(addr, &le_addr_l32, 4);
> +	memcpy(addr + 4, &le_addr_h16, ETH_ALEN - 4);
>  }
>  
>  static inline struct ath12k_dp *
> 
> ---
> base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
> change-id: 20260317-fix-mac-addr-copy-on-big-endian-f1a4fea40184
> 
> Best regards,


