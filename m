Return-Path: <linux-wireless+bounces-37229-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJlgGDQBHWq9UwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37229-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:49:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0026194D3
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E4403003622
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9AD2F3C07;
	Mon,  1 Jun 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9ZapzOf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JiS9w+It"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108AB640
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780285744; cv=none; b=ggGSPwJ+L4TyKOYUSVdjmMhMhl4mcd8xoHbDME3ed88cS1a+3XvLo/skeeRqrRcScYY/IDrY8yZOUN5blkQ0OyUVTRSINjwDDGssXIY/UMk11+D2/dJNXDBzJXhsxyVqoB/uN3XKHvfaxqUYM6V7qUxcAtryeTLeSYV0ndQ0+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780285744; c=relaxed/simple;
	bh=vg87zTvg83zKO5SyVRjWUYIfAZCS6YAIFPojZQ9atAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOxDytjVIYVScc3qHzISJBkuRFmcuKmZEuElqJ+cS2MSXLdiVI8X9yfjPYdu778LmR1m2q79eD2uiBPiRgO6IZ7GXfKNqc9GARQMR9xMnCvK++Lvw2FKkRa4csYgJVZ2iHPn0rZYprGnETDDox7wogPRQEyPv85pGSyBHoYmVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9ZapzOf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JiS9w+It; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6511oJVm1069059
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 03:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+awC8dNZErlVuHkKOYw2cmsviDuE496nG60Cx4tWSy4=; b=L9ZapzOffXmNV/3v
	PbvNZbqz0Hluc+m10saw/TpYmGzdF/1tFyVyUB5724rQ+kg7xJxXq3pdMkrmU6c1
	iRoBZqZRymQFpb5MqiMPbN7pJzCzYzsGz9nyQu85zawbkwKiOj2SbFY3Fu0xVVXF
	3oAkLJ1PyJn8NKCkRp0tA0RdAesdLFr0hTgs4fNjSZ2P2vhsr8WwFhoQn9jQxMN7
	gKaG/Hzc9Fi/EguuUX38ST8mlMN4GgTgv7r6md6zWZe6Dqkkjpmd1KSKSrxDOkWX
	I2KWZOl9KCdRMJuajcU5GNSYmXfdg3aAuqmBPx6ZXEul0kn1ClpQT9UHsitYyQiT
	8PLz8w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr98defy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:49:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36bbdcf36f0so1946158a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 20:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780285741; x=1780890541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+awC8dNZErlVuHkKOYw2cmsviDuE496nG60Cx4tWSy4=;
        b=JiS9w+It5YuhczhnNS+ITs/LnsTYazxe23yzx3MwdInXBlJcYSBP8t2iLHM9XVeMte
         eDxUhlxcxCMwIqtfkHJvMEIRUXLM5hEF/Zvqumyz3L4iulmmJxYX66RzW8EyI7kBGKQ1
         rRhVirlWFTjpAGzM6g6QsH5Ztv+wkwZwvL5rswxKq4u0H3GnUwTu6MP86mjSOzGJrwYT
         jtBnLbpgZHCjFGJMXw9tqcqLukq9SJEO8AJ3OVQByyzT7CbnJrmmfOn2DzcPXk7wE3EU
         6wb+IwGDFoCm5EaMAkW1WQ6Z05Eoe7VAvoj/34BeKchBa+mSP1J7Z0Zmvs0jNxXeka2p
         OBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780285741; x=1780890541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+awC8dNZErlVuHkKOYw2cmsviDuE496nG60Cx4tWSy4=;
        b=RMMyPlVkkMEY7gTmEN/KSjH27fyWpn/odgv+HlDrnvKIV/9RQ5M4kK0f83dQLPmpz3
         3C3MEqYZhE6impVMVzZe/DDrkajodl21fMw3/t4bj0g+G/YS7xZkjrw2fJhzDET8DAG2
         ixH3YVBGF1ltayvND030v469xW2TZphXmtMls3T/WJtwjZgziOnOtNg1xINAXO/1fiLD
         76Pd4RLCxa1EiEWJ6kKTbqIvktRsfP+gsgY6Rsb0mmUKO1J0nJxDM6unZQley6UQlhje
         +bRT0EiAWl7rYALVU21ObKWwexz3ewy/rTZNTyCSODG8X8RetS3mSV6qar279yAXbdpC
         aIvg==
X-Forwarded-Encrypted: i=1; AFNElJ9PYdzH2VyyMGeoQBhdbRVaMp0HIhGwoJAMA30YNsfxI+fz1C5EI+1FKwfH3omvDCu/ur6yAIgxkbqOrFZuaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjap0bDGdEMF5GfKEQxFelsTGIU4ZzNsDt4kSsxchx5v2NFwwT
	y0BGqgUNKCJxWb91BLMB/v7ebL8hriZODiCextgi44iDOjWQQgBNAwzizzaeCIXTM6iuUM7dklI
	mp3Jp5JFaCCLtumSMQlwrYVYieTJE5a0t16SweVdJoqV79d8ufP8zAGsyF61k8iXEnfzocA==
X-Gm-Gg: Acq92OH2hnxHfU+LvWIKPFdjxjf6QKR8VnxheLHv7ACZmA7FPvr5s+O3OAXigJorGfP
	/moqpMraf6bJQMGiENAsy7QKp1mQ5kQetwPl8uaCrIt089Z7uZ8FyRnnjVEjGAAq/sMuYth+Qqs
	4BBovkwa4FKz08YqWRgeL+Bb2OiNifAAEHL5RMQOlifU/ZzxFEEhDMCtvHK4t8JVfTixIxngewl
	Oy8JhnZyISqsrrz95a52qQ9Rw2YPuOSutyUuHUREd7ssrt6JiQ5z3EvKNEZ9MNSRWV4Fz7raEaF
	rR7XeZbWmHnUapelFFVrkJzbfnoKdYGonZY1zO+VBDlgOZOAQyY8+L5fJDjew/n088i+zWaX7FJ
	bldCGbtrPmDDQlMZjrc7xG+lbLcKg2WnGgC7bub7bXP3x0l/LGpACBL7oqABWLMIBMGFcqwCNNc
	3ySDD5W+fyRMRXK9ruabfwbZdN6u/m
X-Received: by 2002:a17:90b:2cc6:b0:369:e9a2:6b with SMTP id 98e67ed59e1d1-36beb5d69d4mr6507487a91.13.1780285741549;
        Sun, 31 May 2026 20:49:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2cc6:b0:369:e9a2:6b with SMTP id 98e67ed59e1d1-36beb5d69d4mr6507479a91.13.1780285741114;
        Sun, 31 May 2026 20:49:01 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbd667fa4sm6337397a91.0.2026.05.31.20.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:49:00 -0700 (PDT)
Message-ID: <91270ea6-68a9-4e64-8f6c-d088f94085e8@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:48:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: raise max vdevs to 4 on hardware
 with P2P and dual-station support
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260525020711.2590815-1-wei.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260525020711.2590815-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaDoFLt2 c=1 sm=1 tr=0 ts=6a1d012e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=DLlhXEFHjEEqyZQXiqAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: gyRkjk6qvYtwV7s4qY8teLHW8Z_mfAs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzNSBTYWx0ZWRfX4bNtdelxRzkP
 muCzv3wZBq08AHDP2ce/F7rdMwEqSYtW/sfzfwl29cK/b5ToxrH+tRvLhXsYClerSj14euyrjrn
 4Vz0Hrs0nJ9fPMK1YPsm0WXRbhEp5IAwG+xXJmmovui1SUyyVzx0jX3B9z4ywmM9dMZNIhaxcVq
 BKAvqbEzhPdOT4x/40gVb0TvA6oWuv5WbWxPLkXtDL2B/BDT216ugrqpN4maTaAQBANKn5dIn7p
 QzWaz730bKd4gJRK6fBhOPrcKgGU7sM91q8WTsnke6zjlQ9uoHW6mVG1uZyJNo0Uf5sxnQ08oLY
 rdNbLm9jNOOfyZfFpxntqshEV2oSEhvdf6f9YGuuELTMtJtnsyYZJR8s50h08dTzACdihmRbIC6
 haWfXL/dyvQulKmwNq918w86da2mHAcD3Igy3+Ij/NLNtw+8RT4hV3sZPTO6XRq0dtENOyHIcrj
 O/alqGk8FlcUAsbElMA==
X-Proofpoint-ORIG-GUID: gyRkjk6qvYtwV7s4qY8teLHW8Z_mfAs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010035
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37229-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ED0026194D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/2026 10:07 AM, Wei Zhang wrote:
> When P2P support is enabled, wpa_supplicant creates a p2p-device
> interface by default, which implicitly consumes one vdev. On systems
> managed by NetworkManager, this interface cannot be reliably disabled,
> leaving only two usable interfaces for user configurations.
> 
> Increase num_vdevs to four for QCA6390 hw2.0, WCN6855 hw2.0/hw2.1,
> QCA2066 hw2.1, and QCA6698AQ hw2.1 to account for the implicit
> p2p-device and enable common concurrency scenarios such as AP + AP + STA.
> 
> This change increases interface concurrency in the two-channel scenario
> by raising the maximum vdev limit, while keeping other combination rules
> unchanged.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


