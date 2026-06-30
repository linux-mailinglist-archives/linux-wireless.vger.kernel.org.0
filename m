Return-Path: <linux-wireless+bounces-38350-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YagrGTWRQ2oGcQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38350-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:49:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF76E2723
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:49:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="dsBiNXF/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Dbmf019y;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38350-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38350-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CD2B30938FA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F43C81AF;
	Tue, 30 Jun 2026 09:46:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87803A8FE6
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812760; cv=none; b=Ybk9dgkOxYZHQbvyXMPwiwzv4HQ3UxHEZL1B4kV3qq7VGxcccWjfTheTNN9VUrODTyCHA5y+vH3/1JVEYiUA2YOGztpSqXwAnvaOEa2j6s02m+0tySq4mVrjVZeBvxW4BgVvcoyUpKTEiXggqfpt+evjRxhBlaEPuN5BCZ0Cnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812760; c=relaxed/simple;
	bh=+bzIJUEH/vcq+ucvqZftSApeGtdDbMplZyGOVUjZHfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnOt5NjPRgNSUTUqIcVpUDNAUe9AZ2DrTqYqse5go8STlhjIysUw6wOTF/oQZRuYE4YvpXvjTc5D+QrtcjXpd7UoKEm+4NIlvOGxER6FCwMWv+krdE8RyxcGuvZyacvGi4GdHZEtqIUwYMf+6U0xQAUCBTyUofXJ3osTB0dASHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dsBiNXF/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dbmf019y; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CLGL1030006
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xD00hz2MK+0hIsyBDC5jnHf9Euvjf05JjPQj1W36hvI=; b=dsBiNXF/RxldppsU
	2WhMEc7IsBVQsjGrGjivxsG9bmDTSIasTuPBOGdxAPbViTIoA8Cqu/VbTJ7bRs4K
	KQbyCOtvQh5j+Gdq3NC3q0OF9X2GsqZGE4qMDF3ACBIk2bnCjDJaOXIIwU57Sqo3
	bXdc4BYbYy7b7rZnz0dUf2oT0vjb0ldeTLRDSsavyVbIPUnBOYdtCFHXZoeZpmop
	3VPiTarGeFUeV5KmFIlvsu1MCubuqull251J3wF5u4emMtsZO+9AxWeLzDbbqmDV
	2hzKZjiG+GP1TDYFCRN/DI2TtqafxhTEjNmIz60WoUk1eyUhR8rco+js9bIwjFL0
	qNEZlQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4hqh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 09:45:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c62861b3bso13526419eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782812756; x=1783417556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xD00hz2MK+0hIsyBDC5jnHf9Euvjf05JjPQj1W36hvI=;
        b=Dbmf019yJp6wCP5nHx1b7I/Wl6ofH62edVRHm2qxRT6Bi6i91vUn95rHkJ4DFZt+FW
         pwN9Vvy/04WDlF10bNnAn2hfnAEl34axhbwFifzgJ2UcZKTKK7axbzr5f9JbVFa2v71D
         YNcCL0/ZvrvbILPtgAGs5dKczK++n+5GuQC+38iijhiYWWwisfHiN4LwV8M9F7RD6xFH
         WBwpwwQBgITsV3Bp+UBf5MkhG6RomNQBxrH2J9lsCgddqYOrP5Odqhb4vZJZv5zMywJr
         TJ1Cg/qhkdiND1Ene54fXnGMYUY6piNoJRwxlbQUYPHmZHYi929e4Aq/0fHsqQ5mbErn
         KOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782812756; x=1783417556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xD00hz2MK+0hIsyBDC5jnHf9Euvjf05JjPQj1W36hvI=;
        b=GpKN8foQ/yYeCNKm8xz3BMcS+gc5Gwc+wGNgx+hbx9SYgRfxzVjFHDwLKJRFa08Bas
         YqLmujqu2HLWDyZCpKCV9TQOd2srGDqt4tAW+ekLFOxqFtLZU1DtavYMM8+9yHQPne1/
         f9GfZ6Ahss+PK75Y2sjA3ChaDVGOpw5NV67bMZyCEqN600YmEQw4e25+vUuyx9fxhfDa
         Zq7+aw+9du5EPRhX6Vngpdgiz3QwbmsbOt/wAFRdCqACk4/S6O3PyQLdOJSJWlOBfAbD
         BLpNKRKMQ7NsP7hD8w4eEn7myUVZNN5IRnIPestYf4o9vfjVn9l3F2rYYzXdR3GozXNx
         nvdQ==
X-Gm-Message-State: AOJu0Ywi58kDJdTeFGx3msBxCXAplKnVDQQ+58QwKQ6k56Hl4jkDpnR3
	ReByUO2Sj/hc2hw/Y8NweQBYZgOiIA6PCb018myYTMdDthQ1KR9SeCr5wQJK8fCEq7gUCVc76xz
	4BxDwBMi+loTrrO4PXnzNxrxDahveoKHNTGdyTkeB4IdXpJZwvZ8dn+137FdFZ2MdUL1itA==
X-Gm-Gg: AfdE7ck0SZY92Q2oSkdmYoY5JYel6EdDxXKCmEfqcTpetAclBv7dNWl2t4Y9dyD3mb4
	sakO66N6iqtlb0YmZrrBiqk1qht7rjs5BoF+XgULSWrirGq56NqTflhSe+ZCz2Vveq5eiEinBap
	j9NM6qyCF0aD+1kxSBFm4+w7BgEJaSx4LlXI31oVcrLNfh7rqELONimhkWY6wBpE0pQYEkFNgit
	TGSXLUK44YipTAbD7/W1zlTgfqprKpJgShadAttO4hUfjqAt5idl7fpqqJO/YrESE22J2tMhEOJ
	f7+UkHyLdVnIZC9bCW+V0pRwHAarETW+F+vxMbFwwM0VKe4ve3+dxn6oN3jOw0oLItW0BXV/iTq
	l535sWhnsn703WCcvh6lM2sJzRjv9BDISHJcsI60=
X-Received: by 2002:a05:7300:3c2b:b0:30c:56a0:ce3f with SMTP id 5a478bee46e88-30ee11ab8a2mr2614917eec.2.1782812755969;
        Tue, 30 Jun 2026 02:45:55 -0700 (PDT)
X-Received: by 2002:a05:7300:3c2b:b0:30c:56a0:ce3f with SMTP id 5a478bee46e88-30ee11ab8a2mr2614893eec.2.1782812755481;
        Tue, 30 Jun 2026 02:45:55 -0700 (PDT)
Received: from [10.152.196.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4d1sm6137828eec.6.2026.06.30.02.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:45:55 -0700 (PDT)
Message-ID: <eee587a3-2264-4e85-9014-c230988de6db@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:15:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: Flush the posted write after writing to
 PCIE_SOC_GLOBAL_RESET
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        mani@kernel.org, Alex Williamson <alex@shazbot.org>
References: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
In-Reply-To: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RJ0uv8U2osNlJJiA2qHTRDW_XLIwrVRJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4NyBTYWx0ZWRfX7Hj1e8kNsh7d
 KVaqYnSIUxSacflm0jc6pgtOh82/K4kWebrkiS3H3RWU4K/AzqaJ73h42pRUKnt5l9PbQ9yZUYJ
 Q+g2bPVtIErGSvIB6OXrCs8YA5Dc2Nk=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a439054 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=EUspDBNiAAAA:8 a=fjTVS2QutaehiSyZ5pEA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: RJ0uv8U2osNlJJiA2qHTRDW_XLIwrVRJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4NyBTYWx0ZWRfX7KP7sjmoFNnY
 RdFgqOIAE30F/83k71W7YCjKtdUjcxBWDGBk07xRlKCfr4WPb58SiH8hILEz+QAp49t5AKXReGl
 M0PNMwy66xQzIRvLujNst+tuTYQdsfaoo9cRMFsDPyqguu3UXgWVAPMmEII89PB6K/VXMr/Zf0M
 5lz2K+/c+mlInbQnUhtQo4Ni0vS8E6votD8/kcZjtWQQTuCuG+AI/GpZeCLfuCWNe3Las8SmWg+
 ZcgE7qgUh8eit/AM2yicSNJIOWGAmozLHOMzXHibjhCYQ5XV7UuCrlj1rQU9G/tvNeA2CVqkphw
 OFnPep7VNqE4Yph7vZZ5ir0aV4j82SwhwqO23jUky4c9hzsVNBwazdhMKlN2us0EN7tTJMqIbMg
 3RR6S7MjFkiP8/rTfDQsrz3jQTb6RTFHQMXw4PZ20QrKC/PHcj7PsxxOQAU2KvDrShHKdFh7JWT
 vVjMQDGnwoZC0G3czng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38350-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 20AF76E2723

On 23-06-2026 19:46, Manivannan Sadhasivam wrote:
> ath11k_pci_soc_global_reset() tries to reset the device by writing to the
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
> Fixes: f3c603d412b3 ("ath11k: reset MHI during power down and power up")
> Reported-by: Alex Williamson<alex@shazbot.org>
> Closes:https://lore.kernel.org/linux-pci/20260622160822.09350246@shazbot.org
> Signed-off-by: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath11k/pci.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>

