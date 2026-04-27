Return-Path: <linux-wireless+bounces-35371-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CByvDk9c72llAgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35371-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 14:53:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CF472D9B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69E87302F69E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551883CAE93;
	Mon, 27 Apr 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHzN6Ehp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XdT1qY8e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD83CA4A1
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294024; cv=none; b=okJ/OezG5MWLfKr+mfyZyEqW93EptLEOeOqTCgIodK3ixJYb8g1D6d/s5uToIsqhKFYWicZvs0FLYiP/MGnpqPcWUMxsR6FzpwLhpiqcxn22rNmf0pY3l55xJmx/G8eVaP3diu1T6MPM7WqjboZ2yJslo5ksufGB8/O5JIEbNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294024; c=relaxed/simple;
	bh=IIZLeuD88V3jw5429c6nUEJ619yaNCusLix+g6q7sOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVcdU0UrSEWshGSYi9SZyQd4V3zQ2P7RjY+hyXZ4n+Vo9yTIclcfG5e0x9thR9qP++kNE3Ee4wG1FaX9Sa7c7QBBGt2YsSov7V2PCF7PE8GtPdyLbm/cYvFmKs+ETA/Ge/df6pgqQxVL3YlL3+LqvvANYQh21W6reDJTUuXwu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHzN6Ehp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XdT1qY8e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8T9St1762101
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 12:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PT8XoelM4J68pOU5FLDggN7Sv+o3fXorq+LKl5X0tss=; b=jHzN6EhpOs/VDzFb
	4078ZcnZOZ0Wrvtb/GI1AmxYd8a2KVN9ceOqQNDdYj0Phw0jpqk7cssSROeXWbY0
	SUEdJgtXFlO4H/HPpWUh1BE4ZaF4zsJy7j26xd64mJqlULNudi5Qdy079/iYNHg4
	LRx7MyCEkuPy+dV2i5bBRkS/SHQAZDkAthaIVtf6Pgx+u9DUQWHyPSpnnYkWBOmE
	V7bQDu4U0wyWrzfZR2b0REIrbrE6LfMmvnUIPPZX9pc0LigMfcYxHd1DrtF36wa+
	cNHdnG+ft9V5VL7M6LXBrEGlaWa36gLhpkALw4BhhW1YQEZD02l1RkQtCbDUPxqp
	2AHKlg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw9e3fp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 12:47:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so7483182b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294021; x=1777898821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT8XoelM4J68pOU5FLDggN7Sv+o3fXorq+LKl5X0tss=;
        b=XdT1qY8e6eKUSK/FBPoLVaTGGIYeL3fArTip6YPsVrYbLq2vzRWmvf0FbsUtdF/5il
         +lj8Qjvs9Nsp7AYuTkR56nUHqPeC0ZJx/ik1oGN3S/a1nyF+blYg69q6KcB1v6HwFR07
         kfT8b5xUqYoPqwfICUu8XHBUB9C0qfj+KEW/BnfC9p+9MBv5vUBg8BGHHoe+E9wE1SfR
         vtQtZiymEvn2yyRKNs6lr9U2xLcAHeUg/6WyvhN99BmTbSVNggQ0W8+M87Ogb6hg4BgB
         NcZtG73C134w88xoLVBLkGBeVwPbS/9x8DHV8m+WBXD/e7Ig3JoqbMQmb9sIyfpKBMJN
         /yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294021; x=1777898821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PT8XoelM4J68pOU5FLDggN7Sv+o3fXorq+LKl5X0tss=;
        b=QeT4wYntsocYeixcbPTTlSmugL8AHZCRGFz5Y9pOlHFDzEiISPLdArUnPYFyYNxHbh
         eXAHL6feo7wyzrjp0THcBxyYokGJnasW4mZlfjFjsc/OXEUQXke3r/LY7qPCQssyBXbw
         lQl6vFcIzaf+5gA52Cq2sQctHZL4AmHzffmc2SPTW9d9BMRCcZ+jPsEI8QYTXiwm/+rk
         pDZsHM7yppirV2sjG2aHswwTF71fR5TiVUKk3/UEjxWIy0b9zqHUGZ+IKtJzRCsIMS8r
         a/Yjk62707NusTP7SJu+crjdyLVa8NfypRzdN++dlNCZBvvAaSIOAb8jqoP3zG7TA9xX
         Qd+w==
X-Gm-Message-State: AOJu0Yy4qmWh9L/VLmsw7AjgtvIULGWM7USEzNa/RRfql3SbiArE4Q1J
	6w1Rvc6QjD4Vy23va3Aeva1q+3LipRmJgPM4I7nmDP+wkVLeLsaaXG/6ip7Z8jk7opHi6pfHx5+
	/hXUFNFTNnavVge5dMz4CPKKowm+3kd+TUZJHjKFvvxTZj+FKtMi/6DIdrGiQayXf0iUIHeBItg
	HI6A==
X-Gm-Gg: AeBDies31mU9mUzcWuFG6WFrzAaAQq0A9RvhVssOFsvcPn7HEY+/gJKd0R8y/KHfII0
	gfc/sghSG/yDW9kAQeIUgJd4x552cVzM3WZmvQkGfzx4zrH475tRFY73dia+441c/qDvGBVNT1p
	3Ex/a80B/39EBi5XTqOe7tQ0LUft7EYoSNQWrAE9ckiWNbeg4qxKIb02aRcR/vcnSPo1TMb9Vtq
	9Euc7OUeNosHrgou3Lo4iyEdrpVAOVxch7TJgP+47KgNSDX6puTiRY+rjZO4tuIS5CKN72cbj47
	rAfxBMWFktOgIC8NyiW4xj5s3R4A+j6eq0y49UeGP6aKaCcCJuAfrPwNBHf/DOtso/NHzjdmzDL
	O4hIjKyA5A4TBhazqsjQNTwF1jIY40Q5nTxRSbSmAP69HbwgSYUvdgm5cKHZZVKFDSHJmz0tvzz
	XVlUazsAIkTlPDCdVsS9len0V9pOnUhC4vJ2NFY/Oplls=
X-Received: by 2002:a05:6a00:2d8f:b0:81e:1b77:9e61 with SMTP id d2e1a72fcca58-82f8b599b71mr35197668b3a.25.1777294020917;
        Mon, 27 Apr 2026 05:47:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8f:b0:81e:1b77:9e61 with SMTP id d2e1a72fcca58-82f8b599b71mr35197647b3a.25.1777294020408;
        Mon, 27 Apr 2026 05:47:00 -0700 (PDT)
Received: from ?IPV6:2401:4900:25e2:c02c:2171:a04a:44ce:a6ff? ([2401:4900:25e2:c02c:2171:a04a:44ce:a6ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe6439sm32472002b3a.41.2026.04.27.05.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 05:47:00 -0700 (PDT)
Message-ID: <3eb126d3-22ef-4a5c-b1fd-11db304979b3@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 18:16:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath] wifi: ath12k: fix leak in some ath12k_wmi_xxx()
 functions
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260422163258.3013872-1-nico.escande@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260422163258.3013872-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PcfDXRfCGoC6Y8D8VI0dkJ3mfbb2gEOu
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69ef5ac5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=lfbKPbqkovPu9Dadm-kA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfX+sQFMFoAjaA5
 73jw4SsPNxgy9MwqZr4FizrU1iLQ4UWhtfuyAWPJHRjJUQk8oXfzXrgiKwM7PkU51HUrVpPoDg2
 hOM9swRfNaTvNbej42ZcKSvXK8lkCn9N+2RNSffSzWmmP0YDSIWetFxuyg7E8a3+Xdh1PIjlrQE
 yyWkgY+cGcaPhr5TISr6WapuJ2xLxNDDxOsUG5834/WR5m+CZ/FpQQYwv03Hp6Fgf2CgteKoBVE
 2Jc9CCV4m3L2fCtGdQJO1mNkRz7tyWxoAtcNDahPDFRLW1uwbt6MtgHTqpJepXJnWLIxAzXKq0T
 iHPaK839d5uKRA1safgEtBroQ2XYJjCvBMzI6CrCUYeFptz3yltq5VlR05n87fNMTjk49M5kldK
 XNufq6ATAdc/xE2bcsMEe3NO3Wd2KXPN0oLqf2E4rFXbMv3kZYKz8yCwbBnt0h+usjOmUQ8hb7Z
 jFhJh4k/9aJ3HLQgruQ==
X-Proofpoint-ORIG-GUID: PcfDXRfCGoC6Y8D8VI0dkJ3mfbb2gEOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270135
X-Rspamd-Queue-Id: A02CF472D9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35371-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/22/2026 10:02 PM, Nicolas Escande wrote:
> Some wmi functions were using plain 'return ath12k_wmi_cmd_send(...)'
> without explicitly handling the error code. This leads to leaking the skb
> in case of error.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 66a9448b1b89 ("wifi: ath12k: implement hardware data filter")
> Fixes: 593174170919 ("wifi: ath12k: implement WoW enable and wakeup commands")
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Fixes: 16f474d6d49d ("wifi: ath12k: add WoW net-detect functionality")
> Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
> Fixes: aab4ae566fa1 ("wifi: ath12k: support GTK rekey offload")
> Fixes: 7af01e569529 ("wifi: ath12k: handle keepalive during WoWLAN suspend and resume")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 103 ++++++++++++++++++++++----

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

