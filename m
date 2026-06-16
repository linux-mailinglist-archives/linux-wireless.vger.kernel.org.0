Return-Path: <linux-wireless+bounces-37833-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9TRoAQjnMGonYgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37833-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 08:02:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FC68C546
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 08:02:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LrfYmyTg;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BFCNbGFB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37833-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37833-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4F373027DBA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 06:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC63DA5D5;
	Tue, 16 Jun 2026 06:02:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A93DA5B1
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 06:02:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589747; cv=none; b=KVohNYs1nuWECVfdaWalRpXQjtPALBrzk8icm9n95u01EGkGPr1XhjqJVba6GiMmptpoIDEWhlNZNSF+iHxorhjjcvVBHciOehwbLbmPyR8XbLA0wyeBD8q87b4MI/SnvMROR506R+hQEmOkTCjhPIVMe9dwEEZXUJtKzCh52mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589747; c=relaxed/simple;
	bh=9K+69FgPRIP8Lu+Gj1ODqE8Y6v6kUrzZhTuXQ0RRWUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzT5j7sB+dIpwvGGoVJIF08ehjf0SODXafEL7XaEBEMsUjNjoo7XOfxDVuIUDT4izLbRXka+4evWFxbzCcKQmXMYzqn+0GH4x+wqLt8PPR5JhzLjD+bA2TfIzw7PlyyrKJ+QJ03Zd+DWUVSUJIZhGqsAjLQAfbplmVx2qXkZQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LrfYmyTg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BFCNbGFB; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G1xkvL2121671
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 06:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vdJb7brSnFhjpTvyR+OLd7Yg5ivRRexl8ZC1EQrrZ0E=; b=LrfYmyTgxrj7bLJq
	jas1LP+CFm0MV3jZYXGoSi6+MxdalINmqu8/CSi1FupTMmaNhIwgmqFHwk4g2UFP
	T7GyoCyZjdhVvaKCSHBXv9DOGCrHAPgI+Ytdngc+6adoaoE6kqP0uT9TucFxcKwg
	csjPXNZjwaH67c3bwro9UJZtQEtktegXQtSdlKIU/a62zi/55YjNEQttPc8fStD2
	jj85pIMfui2/vB/wnhN/nRBidUpQ9Jpz+xkpurwGq9SXPVw9PunndEnB7UUJGCy0
	qzdjfxhh46clDuJoY+Ko28Rwo2ZBoiuqWmBofT2n/AsW3ALC/w8OKDLxmNGhymmx
	ud/JQQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx538x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 06:02:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d97415004so7637124a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 23:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781589736; x=1782194536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdJb7brSnFhjpTvyR+OLd7Yg5ivRRexl8ZC1EQrrZ0E=;
        b=BFCNbGFBNRz2Ni0z8jDScR33ZwvXG6RoJNSr6xZEHPGDXIRK3QBTy0GbT8emV1cmrF
         FbZb5nIczRdqJZ8vMyXTqlVscZsQjmhW0tNn0sOqOMSH4K/5db6tlXA9vbbByJhLIDAB
         k570Gk1dZOwo+92SFkuPWeT7QqfPzNSUd9n8ZpimgtDG/HG6z5slszPLhIajfUyxFisc
         K4kKXo1waPo6CTOlPdVHWoOXU0EJ33ex49I2BYXVEwBit/4nvqGzji5li2VI6wX0BOQ8
         CM8sXjq58xj1YtwWPk2Xz6kE3FqNDdfLHZLfH7xyn+8bTA7zbaHo93XfxfBS5H7A678G
         rTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589736; x=1782194536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdJb7brSnFhjpTvyR+OLd7Yg5ivRRexl8ZC1EQrrZ0E=;
        b=h+iXtVVe698JZnA26CrC/fPwI/PjznbpLsCvbOON24yhbp4peB9St6RLfu1Y25JbC0
         7tIUEIE0uRi2Z9GQ+ibvZkC1T1Ca8Q80mtRSfFNApq0sbxBtzgc1bfGJPTikyytURzRf
         BRW4tuFLo9x98df0apqts0T18EWONJBfnHQg5q2ZLXWCKbF1qhQxqRNQC894nLo39xcI
         Kzr1YruINqNWw1vOV3mh8lHCnsuLKjhn51R6gYC3I1gUbrUt6KtU+OajX0wS8O3r0tY7
         mm4vzXgDjpBVGI1JbGNHLoit/NCpILpzsHZO2UNWXNDS6M4/FNYAOyzRuwetiG+Dbse5
         Gt/Q==
X-Gm-Message-State: AOJu0YzzN/znjGaBA73WqO/LWHbFvTWjwBTVYP8wYMXrl+kY58szkLW7
	U1B7jZxH9L4J5qv83dXLp6BUjr+PFbDtLwpUd+YqdjwdxKpzlRS0QpUeupKPtX4l7haQwmX7KtD
	2CkCmDFU35aeiSi8lpHzGe4HupCjvbSrer2pqatBX4/pMLjB+CGM5dQDh4Yky8Cd4fK1hPQ==
X-Gm-Gg: Acq92OEgmOO16SlOasR4a39T/VMtPq0uEN4qnV2tR6IyROJTjUnDWuLud0iem2D8zt0
	CyTYx+jvEr2NDSvAZAk0qF2EOsX/UIQRxJhmBaL6h7Z8ji6SXw4lTqQ7oHrVuyiubwMKTBYApfS
	m/rw8cgEyvLgY/CrrEMBhpY5vNRj2scHiXcRILkMDkvj9kc/lILBtqA/dS/h0rLz+5mtiTXvTTt
	wnWBmRPNvUakGoC7+7nIWhYTai3J5pxxslF/QEApw8QdARsLO6wwKZQj15PGtxYTf57unqQ5adJ
	Yd+nh1yPgp7c0SL99rSO+f7rgYDd6OaarlbIK9Y1CbIoFbN2Msh1TVkkM/WLEjBe/FEYmZNOlBi
	3iD6yb9bzepjw693aRDBEiu4ZpMW+2vxUgyd4tcKas+DS3OUixTFZ+/8=
X-Received: by 2002:a17:90b:5148:b0:36b:936e:73c8 with SMTP id 98e67ed59e1d1-37a037e4b2amr18459293a91.19.1781589735673;
        Mon, 15 Jun 2026 23:02:15 -0700 (PDT)
X-Received: by 2002:a17:90b:5148:b0:36b:936e:73c8 with SMTP id 98e67ed59e1d1-37a037e4b2amr18459242a91.19.1781589735167;
        Mon, 15 Jun 2026 23:02:15 -0700 (PDT)
Received: from [10.152.193.243] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e7e217c0sm9196245a91.2.2026.06.15.23.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 23:02:14 -0700 (PDT)
Message-ID: <fd87f749-b930-4147-8948-c412447a11c6@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:32:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: correct monitor destination ring
 size
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260616040653.3985702-1-aaradhana.sahu@oss.qualcomm.com>
 <9ed73ed4-3c52-4841-821f-0fae12f452dc@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
In-Reply-To: <9ed73ed4-3c52-4841-821f-0fae12f452dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PgnHioVLViZUapIAqc8bpGYoo8i4aGvZ
X-Proofpoint-GUID: PgnHioVLViZUapIAqc8bpGYoo8i4aGvZ
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a30e6ef cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ByWTzcf8-CCAcaIRRJsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1NyBTYWx0ZWRfX/+tHF66OH2WS
 8OZ7O1XL+5VwiN3N5T70JEnUYZfhmC2tRARf8wbkiN6OHeoMdB2SK4zlykMUxRAy9kBUVy8nqIm
 h6VkChSgLKp4vYedF6p93mZxahEVeNs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1NyBTYWx0ZWRfX/E2EAx4CmYFm
 8NQ5QHynh1roe4/pP0PJlVRwoKbOjXlVxIGAfwpnv1b4gMdy7+jkJYXfNY+WlyuMigAedXYrMsI
 wFaL/nq6UFLN5qaJq0BkoIlpXs/2nEWEzpMQk75zkGwcAm1pRkvGmeeK6jBA648viQ7+QG08HMl
 SjZ3gHrDP//nqGYE7BSEx0AbwSWiA/DjTKfGTV7AnZpjsVNIfUzx21/i+jFMalzcWrVNIOBlXnB
 UxE4Id20x8pMyIgKCjei/AD54+stDUNgg69l51+mwivwg0Ym2P0Lan9H66iKSYg7vwOeCPW0TSW
 BpH5PXiFs5lnM4RCcYNte6js6j6HChSOPoFAmbSONmET7Hz4qdPgg/1ovUnsVOaY8teCOmWIhfJ
 OA3pzadGdEA9bmwt1+OP4P3zsZYOFs/b+E6vQQPLInsjT+54rSt+lpt3NV1vmm5JbsHgHRbNeUB
 p11f4BM/1laxLV+n1PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160057
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37833-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B1FC68C546



On 6/16/2026 11:21 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 6/16/2026 9:36 AM, Aaradhana Sahu wrote:
>> The default memory profile configures rxdma_monitor_dst_ring_size as 8092,
>> which is a typo. The intended value is 8192, consistent with all other ring
>> sizes in the table being powers of two.
>>
>> Correct the monitor destination ring size to 8192.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> 
> fixes tag?
> 

Sure, will add fixes tag and send next version.

> The rest LGTM
> 
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index 742d4fd1b598..b488bd8fea9a 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -49,7 +49,7 @@ ath12k_mem_profile_based_param ath12k_mem_profile_based_param[] = {
>>           .dp_params = {
>>               .tx_comp_ring_size = 32768,
>>               .rxdma_monitor_buf_ring_size = 4096,
>> -            .rxdma_monitor_dst_ring_size = 8092,
>> +            .rxdma_monitor_dst_ring_size = 8192,
>>               .num_pool_tx_desc = 32768,
>>               .rx_desc_count = 12288,
>>           },
>>
>> base-commit: 83f028be15fe071efbee8e27837538d6cca77e87


