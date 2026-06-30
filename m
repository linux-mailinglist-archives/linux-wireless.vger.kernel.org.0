Return-Path: <linux-wireless+bounces-38351-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V4+9DBWTQ2o4cgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38351-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:57:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6546E2896
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:57:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YwyMC1Zm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=awtk58zy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38351-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38351-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C6593098A9A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E31E0E14;
	Tue, 30 Jun 2026 09:54:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220834251B
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813298; cv=none; b=tUiamvx5lC9r1HoTAr6hQwoT+L4ACYT88DoDpWf4L9mthvMD/phfC93GNYyfvYFLtFNjWxC9CcTa3Aio7Hsu+CQvuje2dLqnMaH/de8+C9aUOTQ3KWwIXIXnT5Zv+yafseeKSHek+hmkg3Y5qPE+Lrs+IPSeIQhK3XeLsPWYH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813298; c=relaxed/simple;
	bh=9/Ppmccz0nh+h+90KrlbbTOVf2NpxKIj8/LBK/dP2vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8qIFTF9BvqkOLKIsBUWAHnAlwV13h/PVL7Gugo7MIauLA/PSyE6XY9J7Q7utArjBts+SETiZSf9N1Xv9jwkMQw2aonZC27UO/wqZMbwBxVkYITzxHqIicy5tDe9h1WX62sjOjBiScN7pALIpDwEblAtJjDrcCEhd96n/PdkMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YwyMC1Zm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=awtk58zy; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n5XD1508760
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I4mqX/qPgDfcNPuQAehIBrVbcs3SjlIok8zx5e9pV4A=; b=YwyMC1ZmYoTG3rm4
	a4mVHjE/jp6wkHh3Wsih5lo58TJXc1JmrF0eJRXOX1AdOuXCG56ETBSayr0BdnaO
	PEkZJpVkRvLZWRO6xYEpYTCKjiOOvJ6JeTcIuPCCqXgHnVygfuWyA68ac/ifXTck
	GjowJSfjUmmVfCmf1JB7g2WSxLeibM8A4RRpE/cavngzQA7NT263IiBh8hxo1GkW
	R+s4flvvFRLgGIuHYL1wiVi8mULtMtQpv8omiB99+P/rAGhf/1KmTXFUo8wZs5B2
	u0QS4h19ASNi/NLJs7t5EDbundKdpo5I4Vrqud8xM+oD3+VilHut8UL0wRoEqpcW
	Pj4Ocg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j2twx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:54:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845bc2e658aso3301184b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782813295; x=1783418095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4mqX/qPgDfcNPuQAehIBrVbcs3SjlIok8zx5e9pV4A=;
        b=awtk58zyL3ln7/97EqH0vgpCIM9s4f5ME+x2Kz8ruMzbqskJRaWYBawnxYsouUFUCf
         JPJOAGp70LtQAf9cCCgcUkd8md4HX8kU8vgT07YOGyHqa3kvgDY/eO9LzcjEB6VWrqoQ
         FScGz8yauvoqWnIFdzyUmluvoPxUhy9KrbKqkmfRyNHauH42o3Oc6XMLBEaZ46ujunjI
         l/47fUPTN2WxDlPZ80wC+ISa3SxLfFjhnQq1BCUhXrNUGM/rg5AN5KZrZAaIW3StAhJm
         C4z2IMfLwwBft6Zh+8tk1+75awulIBAdfFCih8fqk6aIRFuR477uZGxCdHQHAd8A7oZM
         0lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813295; x=1783418095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4mqX/qPgDfcNPuQAehIBrVbcs3SjlIok8zx5e9pV4A=;
        b=auj6/0p28oZdbb+4ktSweCZ6XT24BGXR46BxzLS2azGg9QNxv7fShxApZaP35dZ8kY
         74awIwzCxxy4J+oLIyr27p3Lse4Ix+3fyRLZveIAn4VosHZCkMZRq/t0UsaJvBMgU1Hg
         XDlhvcmIDvJVxDK8TD4Io7jGLS8ntIyXBdWZbYz4Dch1bntJVoiPAzPvsyaqUZs46ebx
         qnFtEonYW9TzkWxODaLL6Rat7URie+W3vXSMgvcxbLXaMI1TAMEWDscVmwIZ/L3DBheL
         d0xSYDDXTRVbyQkP8KV/6uskud3TJQzcFMGESRulHc69CpSZHgV/E1YmyWqc9ZHABIgd
         HfNg==
X-Gm-Message-State: AOJu0Yz+i8pSRBIOI0D8WBjRS7mjXky2IRQHSit6b0dxT6cOje5N+ivx
	5/kBKDD4CCUnqGDM+cTIDAIPkbTQ0vmUoovL2H00dzJ2GRj7E560ekgnlESOwzjSISbqgvIeRmu
	yjYBcxTwQ32s17xU7oY23rYIIU6n6lHARJsfL/VUf7g93uUyDWqezmayDRSu7YTv/oagdaQJ8++
	++Hw==
X-Gm-Gg: AfdE7cko90UoCiJBohW/uWUjLS6dA2knf1nybqDErbSVTQHTUpO4cJL809aqlCwadkg
	yi3DEi/5cjIklHvWqMxsWaN2WXCVryNmZeEKnv5t5qyqVcx0PHiUGH3LZ3QGyPQXA3CI2cuPh3s
	AQu56JMolj+PhWU9PYVItRlNyWLVMZtITkLh6glTYZLUy5iRKzSqE15bLrkdejbk8o774kAfsuO
	2cKTxXpYt1ZXo+Lf9FbWGZvaID8PxAQ7EbQ6q6aXrRGbX1/f/A1MfmDYcUTvF/WV66sYMdwqDwn
	g6OHzUggROxCDttQv/xsGxwiQyzXjRIkahzOJk9ahzLTdFDknBVEEbwMfbB7BNnbjDd57cmUUP1
	i8LaE38P1P27iz1GgoBMWUAqORj3NaqKHBxyeXog=
X-Received: by 2002:a05:6a00:c87:b0:847:70aa:9586 with SMTP id d2e1a72fcca58-8479f0fb4f7mr2380838b3a.16.1782813295553;
        Tue, 30 Jun 2026 02:54:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:c87:b0:847:70aa:9586 with SMTP id d2e1a72fcca58-8479f0fb4f7mr2380832b3a.16.1782813295136;
        Tue, 30 Jun 2026 02:54:55 -0700 (PDT)
Received: from [10.152.196.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a033b21esm1545220b3a.48.2026.06.30.02.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:54:54 -0700 (PDT)
Message-ID: <e6f33487-28df-438c-8af1-73207d0ec23d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:24:50 +0530
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
X-Proofpoint-ORIG-GUID: 7vzpB9aUPjraoiCbigq6bL4HSu-DxGPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4OSBTYWx0ZWRfXysQ7/V/5rGJL
 kRH3RcXpMIPPDNj4DyV6u+BOj8h6nEGHbey0Je2Nm4rTZ2lrlWX3Q2Mokgnkd4/g4lnpGjEgWgl
 TbM6ZmN8OMUplaYt5Jy6dkQrrVrxrQJhIXllIg7qZ3FVjnCQC+L1ejcMVmsunAYnCbIfCSt0PnX
 JtoDMUuprMdVDHfLm4Pfcqt6aoAX9TGrHVkHDd5RG+1HLvnEDKEb1mr1u6b7XRImuSc1pV6O9jK
 IR3nIrFWCB++5WxLN9zchmIlZiuZ5xuZCTqrb+mXwxI0dqv+M5k8z4p1D8QRUNpPuyr9ti5tm/L
 cxeDLUA470UpOjI71glwbkpBAwz9E1oZllics6eKwUHLhacwwpJ+tQnisSCv2pfZ1rKlDsjAVvX
 5RjsvUFU3FWCJDLI9TDDNIQBYMWiKwvjNUqUyHAVLVDV7Y10zRDQUfIfmJXLo18SKcN+bA/A/30
 t4EnxS4b0FLZCW7NhzQ==
X-Proofpoint-GUID: 7vzpB9aUPjraoiCbigq6bL4HSu-DxGPa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4OSBTYWx0ZWRfXxsgIwVhmnB61
 tpszI1yX6Ydpf3fbZoCe3uDRGzY+6Vcqujq/pStZpbVZ+uf71tu+x0q94e9mQ7QrwWGmQfdBaaK
 sQ3NCTp0CdVOMFLgZF9P82vvVlhcQm8=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a439270 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=EUspDBNiAAAA:8 a=fjTVS2QutaehiSyZ5pEA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38351-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE6546E2896

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

Reviewed-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>

