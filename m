Return-Path: <linux-wireless+bounces-38566-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8+79KxphR2q+XQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38566-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:13:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 041AD6FF738
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:13:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oI1GY7pI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=eOQEEXuD;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38566-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38566-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B0863050A40
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978A3839B9;
	Fri,  3 Jul 2026 07:10:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B233F5BC
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 07:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062631; cv=none; b=uOvRU0MRcxaH5sZeFTI9Q8oQYs+UIUgxQVsnNQehtrWdYHvc4H6SukD6s7DGNhWYy/V5O2pM9Lzu1hKKoEKTHQ3bDrGLJBmRED6CY0PYDg9An3XcXm7jgu9HrblzAYSZdT7Vs3mf1sdAU0dEabFjuYY0Yl2MsLXlUPPu2F+WZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062631; c=relaxed/simple;
	bh=enGfy3ekhl+RPZmTV6Ozm2VO+TiPvTzd4OHW3UfAjrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndwXSqnEZpQEGr13MmKYeG8BJK2mDps922KV5dNi8eWX/vd5YwnxT8690QzsqkzII1hSMdkKbjNs1O42ave5kwBV7BgCwxiDkx3Y+FL3nDeFI5PuAPxQM3+12R2aiDX6tBOGOV24i/gPg7tJaXtYCCVROsmECGZKWHsvEhKBzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oI1GY7pI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eOQEEXuD; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rwe63126425
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 07:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aq6TBwc51LH5Mew9JVDw6URTUq6CcWxDYoLHE7QMsv0=; b=oI1GY7pIl1HvWLR9
	sGyhg/5WXqmZMAQk4Ux3hUFN2ngP2MVS7mHV3JjFmM7vuyLue4zsc1pPDtfwRNAy
	kdihSJV4jyJObCP10IdlGr4n4nJlLAwHu4lbHNMHxZmXxFPEfiPOvZIkFKtuL6nH
	4obE31mEIDjcRak06TVEGoTSklRZ59tRSJQgPYp1Sg2wma1v/zTiNkLJRt1w9kgE
	5uF4ZdvQpuOzoYyRjtxZhwdLFuxJyaV9cvvf21HwD4RnPvWZD6V+5QNWIpbobtBY
	WrZpqWcPXxlVJ2bcsiwkXh36PgZT7hC3G2Fp2lzjHviGiMNwY+XL/L/td+0EdAUS
	pyoH2g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnk88m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 07:10:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ca5d2474c7so5616885ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783062628; x=1783667428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq6TBwc51LH5Mew9JVDw6URTUq6CcWxDYoLHE7QMsv0=;
        b=eOQEEXuDCLOTJG8I2A4cUL+X77Pdvwcin3ZGO+rGsG2ldSc+jusa04+msJIivhx8QM
         2H+jXzyNlLHmu2zSzlBu3uKRWNJ2rxbIJ+57WskPAcaSemgKTQ2GmyAlXCpadC7YzXEL
         EVG/xAK1Zal2dLNJMG8ParURFmUN7R7e/GcZyFIygvQE8HZCnvIMz2Nrn6tccZOr9U1J
         dRurZr0SOvCboA11gzFOkRI5C1hrVzlPp5FCsUQEr/YY76rKxch9l0LHv11LMUUs7HvJ
         JlF8pa+56YqlTQrfXImUMpwivrE2ZqjsJjqMp0z4fCVL2C6vA6k1UHY5fKNcVXYAvMVu
         BsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062628; x=1783667428;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aq6TBwc51LH5Mew9JVDw6URTUq6CcWxDYoLHE7QMsv0=;
        b=NrqgaoSlaIYSpIOEDXHLXYfM/zxKfkD53RJUzejuaSwLkNzUSSHlKOMa7eHIXnpUgZ
         W2FhftT2tUAfCU7yuJCm6mZ52vWYTXfMxGp+rO+yp1qCO3kxZ/j3AVcK9L/Eda1SoGoP
         NijGB9Shps/4nGGsVtAgr9RmcA/MN+Lal0OxqpqsnpIm7i1YpaurTypAxoUZXng9jg49
         iZwkWFBDoNyr0yb46FUu9H7o9x+RP04ApeLetFTl9j3+XONGWcXIMJDYYeMBnjl5oyip
         wKOH4CscHjfCfODIy4DVEYF8tZ9Dt2dp5uOB4oDUzif9fhLdOUoRKhRhjF8vu9AnuvsU
         jEpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0/mbMdjzNXGFLAC+vgp9MUB+7ewah7WZAWPDbHToUxLZF06me1LEjlFTumwH5S/CVUbVdWACOoQbHpgJhoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVlXFIc36VqG/i/XYpBp82IigjlQveH+MJIfGaxF+fMQtXX5e
	S/x+G/cL2gLFWQvXdXkp+N3WrceeUGr+l80kjCwK3OZ0cevfH8DDirZ75Z+JCC9sJKQnwXfrEoY
	/KV3r0+T3XLCGKQpAgzmKxGqq6vkdbxTaJHBpovlQIuRz2UmIRWCbbmFSufRPKoo2khv0Ig==
X-Gm-Gg: AfdE7ckf/7pgZo3ROiXOi3BnqfASgh51RdlsYhHsbjSu0qKu73+tUODmZThpogEQGvt
	gGXKrR7eLcNHDhUvCU4EtEI4p3hve+iFUPV6W6mARcpgOSBc2lVUSxqF+sqKOhemDL5iIbGr3Fg
	8lUQk+LuoOklo1cgY/ZU7AYEvAiOEmqgarpVnXlcHCfnsHIWw1eQ1p88898FuuAwvVUpvcd1yYs
	7N44O1KgWAxN3vUrrfGOv89+rNg5ofbtn8TPLpuUar3X7LRShs/dGBzZ3lwMy6v5LuUzi/bvJ43
	o5qKSQJLYM/g8pB41mXp8dzOlRfNz6g0nvsGkuiuRfm+8c7B1TAg+Wyu2QQNe0hgyjAwtTUhMxV
	DoGc+rYgV+3mDHhcIpPLOPGNN/nAu/XZ6cvu1O5mooLWLrOO5z1nKiU5z7PBRo5yxib8dqBbpKL
	91myj3VAbl
X-Received: by 2002:a17:903:234c:b0:2c0:b6c7:2271 with SMTP id d9443c01a7336-2ca911121e5mr88935145ad.4.1783062627434;
        Fri, 03 Jul 2026 00:10:27 -0700 (PDT)
X-Received: by 2002:a17:903:234c:b0:2c0:b6c7:2271 with SMTP id d9443c01a7336-2ca911121e5mr88934765ad.4.1783062626960;
        Fri, 03 Jul 2026 00:10:26 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad78a9f83sm4888795ad.83.2026.07.03.00.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:10:26 -0700 (PDT)
Message-ID: <606bc37c-45ff-41d3-8f0f-942c3009c4b4@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:10:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
 <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX> <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
 <cdd85c7d-976d-4bc2-8792-bef7e98afbd4@oss.qualcomm.com>
 <akZUUhopfdxb3VTX@FUE-ALEWI-WINX>
 <980e1f5c-a845-4180-970d-02f6496f2956@oss.qualcomm.com>
 <akdYU_Lejd2FZeIN@FUE-ALEWI-WINX>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <akdYU_Lejd2FZeIN@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CJZvlZpIyU0V5AChBrICdm7SYV_aeA2T
X-Proofpoint-ORIG-GUID: CJZvlZpIyU0V5AChBrICdm7SYV_aeA2T
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a476064 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Iwk81yimAAAA:8 a=L-SkCVRlKA2wWS2LGbwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=PqBb7rsBcpu_OT3Qf5tX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NiBTYWx0ZWRfX8WgQJ3rCbH5r
 PtFqImiIqklOoHxcrTC8gISE5VZKKKhQYvxU/OK5GbU5/t/QTWfvkz91mPAYcqLeg7uMLc0VJ9y
 SR7ZAeIfcPCqR+7a0LpepBTDdChHkXM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NiBTYWx0ZWRfXy3dgGYB9USZ5
 0Acq01ufn+AzgQiZsT5SOtWBk6rh3vgL+sm+k4WdcuymGNb44bbPXDQDxhWvW42cyySrummGFUU
 nHTajiudYy7+Bww/iu6OZaTENrNURnCjvZQQp4LySL3et3xFaQU1SJE/AvwREKQ8DbulLBgSmlD
 RTpoES6kmEzdh1pb9JexqKr2Lf2fiLda5xDoG/f9J5EvqqukCnwENMbkM0mqiLnprFTWsAEOXOF
 SAdMdt0s26r8K4A1pHxDVAX1BTJFS+6VPbGhz0H3nXJKif7hRPZxkCZ6bU2BLk1kQsLjW6WBq4f
 KCG9fRijuD0OYGZJ0H7hrJzopcY9JPtDyrlFgmxug56xNuLPXlyvw38X6O70Y3ffUCEj/ru76LS
 kqlhQy3VgLm5QCiqj+zbvFlY2YcBhkWcg5hdXr8wyGa7g+TyZeDOcOYODBxnBhWicFv8FY3B/Kv
 df1V6jkuIUTuZH9Bt5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38566-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 041AD6FF738



On 7/3/2026 2:36 PM, Alexander Wilhelm wrote:
> On Fri, Jul 03, 2026 at 12:04:10PM +0800, Baochen Qiang wrote:
>>
>>
>> On 7/2/2026 8:06 PM, Alexander Wilhelm wrote:
>>> On Thu, Jul 02, 2026 at 05:56:01PM +0800, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 7/2/2026 5:17 PM, Alexander Wilhelm wrote:
>>>>> On Thu, Jul 02, 2026 at 10:41:25AM +0200, Alexander Wilhelm wrote:
>>>>>> On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
>>>>>>>> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
>>>>>>>> CPU-native data types into an u8 array. On a big-endian architecture, this
>>>>>>>> later results in a null‑pointer dereference. Convert the data to
>>>>>>>
>>>>>>> Alex, did you find a time to investigate the root cause of the null pointer?
>>>>>
>>>>> Hi Baochen,
>>>>>
>>>>> I am now running kernel v6.18.26, and it looks like the null-pointer issue is
>>>>> gone. I only see the following log messages:
>>>>>
>>>>>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
>>>>
>>>> what is the actual mac addr reported from firmware in the PEER MAP event? My understanding
>>>> is that, without this patch (if we really need it) we get a wrong mac addr, then in
>>>> ath12k_dp_link_peer_map_event() we are more likely to fail the peer look up hence would
>>>> create a new peer and wakeup the waiting thread. But the log here clearly indicates that
>>>> the wait timeout, which does not make sense to me.
>>
>> I think I can understand the behavior here: even if wakeup happens, the waiter in
>> ath12k_wait_for_dp_link_peer_common() checks the map result by calling
>> ath12k_dp_link_peer_find_by_vdev_and_addr(). Since the mac addr of the newly created peer
>> does not match, check failed. Finally we get timeout.
>>
>>>
>>> I have now added the following debug output for `peer_map_ev` inside of
>>> `ath12k_dp_htt_htc_t2h_msg_handler`:
>>>
>>>     /* DEBUG */
>>>     switch (type) {
>>>     case HTT_T2H_MSG_TYPE_PEER_MAP:
>>>     case HTT_T2H_MSG_TYPE_PEER_MAP2:
>>>     case HTT_T2H_MSG_TYPE_PEER_MAP3:
>>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info: %08X\n", le32_to_cpu(resp->peer_map_ev.info));
>>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.mac_addr_l32: %08X\n", le32_to_cpu(resp->peer_map_ev.mac_addr_l32));
>>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info1: %08X\n", le32_to_cpu(resp->peer_map_ev.info1));
>>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info2: %08X\n", le32_to_cpu(resp->peer_map_ev.info2));
>>>         break;
>>>     default:
>>>         break;
>>>     }
>>>
>>> Here is the result:
>>>
>>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
>>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
>>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
>>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
>>>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
>>>     ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
>>>     ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
>>>     ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0
>>>
>>> Let me know if you see anything suspicious or if you need additional debug
>>> information.
>>
>> I am not really sure about the final mac addr and vdev id passed to
>> ath12k_dp_link_peer_map_event(), so can you also add print below?
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c
>> b/drivers/net/wireless/ath/ath12k/dp_peer.c
>> index 47d009a0d61f..3e8201d536a5 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_peer.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
>> @@ -162,6 +162,9 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id,
>> u16 peer_
>>         struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
>>         struct ath12k *ar;
>>
>> +       pr_info("peer map event: vdev_id %u peer_id %u mac_addr %pM ast_hash %u hw_peer_id
>> %u\n",
>> +               vdev_id, peer_id, mac_addr, ast_hash, hw_peer_id);
>> +
>>         spin_lock_bh(&dp->dp_lock);
>>         peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
>>         if (!peer) {
> 
> Sure, here is the output:
> 
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
>     peer map event: vdev_id 0 peer_id 2 mac_addr d902298bM ast_hash 5 hw_peer_id 757

what is d902298bM? are you using Linux? seems %pM is not properly formatted in your
environment.

>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
>     ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
>     ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
>     ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0
> 
> 
> Best regards
> Alexander Wilhelm


