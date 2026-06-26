Return-Path: <linux-wireless+bounces-38147-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TvpfI6Q7PmqCBwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38147-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:43:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5E6CB72C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:43:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HFczB+Ng;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=G6nyYFz0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38147-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38147-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BF923015C12
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C09288B8;
	Fri, 26 Jun 2026 08:43:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA2363C61
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463393; cv=none; b=mJl9tcMHwMy/MaASVKGPd5DfT78VASg7G1/trEVzMFA1zuuWY+Vf6sdh1q6zcTd5eKIFzn5WPyQXkpo6/ALMe4efNAWVWg3dmg5RanQfOr9uXxpInu4M/VYrpAdZL8ugcEhES+CvRrdF6speBbt85BOAvHT27LRtrOJYoEtxbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463393; c=relaxed/simple;
	bh=oudxw/kYrWCp3ShUe42Fo7yk/JqP8A+0Fh1qkWoyMYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXQMRTw58BWLIe1BpQ4jSChkaTzEGK3VDVlSVokBmwKBY6IVvqO7AwFDlFDIpWHGPuVRs4It2fz5UPm9TyOwb8jvhlDNF3usrlUvJm9GWFB59RRYqH+4quDtBSEPN3AEltbAOwEpX0/rtvpjBUPnGW+dMzrdVWt4WkjZdGiZjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HFczB+Ng; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G6nyYFz0; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6VY8K587032
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MYD+iBbEX2/Vczxq9auxJGJpjLsSUgd7K6ves1Mi7hg=; b=HFczB+NgZUNLhUwT
	VG8efrpdcFzLlLf8UHNs1bGbKb3guSJ0ENB9icVX+tWH0sVDqbCNbkSbpBs0hhYb
	Am4igGwl2PCK9vZXa5xFClxioxTM847JxXgEu6DXNvI7O6dgXibW7yvpGnFJpl9K
	WVx1grLm8+ZGo2g8xDbjAOgVry1ID8kBkorMd0Vz4EdgLQIjU3r2Qo3h3BvVaqUu
	vPOk8cy24F81YsE/UMOYzQAS2vBuXdb30lse67JhssmpBbLFDJSVUMyGn/2wkQBZ
	CHJ7uq6xZQcBRkcWE62z4aFwSgZc8h75zJDybZadxxRPAdoQT1ZtpJpUFVHpwhyP
	j5k2cg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eew9vbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:43:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c1f6c5559so878946eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782463390; x=1783068190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYD+iBbEX2/Vczxq9auxJGJpjLsSUgd7K6ves1Mi7hg=;
        b=G6nyYFz0uPc56rb8xB+12OC42fBAg1kGtnnQ5b9cSonfqnub+BqTwIqyiEcnHqEsaM
         WcFskiI8IwOQ4QkCT1Oxio5Uwlp2x9cE/k81JKEqg8/odKgItHYwiip1AX0CYpz/7IDg
         PyuBexOWLWS/0ThNQchePDj9NREXD9MZ7nY54LUGTmU6U1a6aVsOB5dHGJChsY0MyvsZ
         YVe+fz/W2cw9BHGtbMgPB4nFFNJfSQCEsCR0fK08G66LoFKBwQwjFcrZmH4yOrOUDmcZ
         9yuQ8h9pxteIT7FeQL0EcXO3BCt4LPg0BArDhMQedoOicKfjmy/U7DSuAkfe8IgJddhY
         3Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463390; x=1783068190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYD+iBbEX2/Vczxq9auxJGJpjLsSUgd7K6ves1Mi7hg=;
        b=qtUF2fPkHRBgxWISJZEwcdxXe8qJW/guZ4OkynPvacVk2uuJ9o6LfQcFfHSIZhyHB2
         CBbgmBAiIvN6jckWpHpprYYKW9l5EMJ1wSTIgBRRoEA0LU2GFvZClPJrHN8COkCyzxGa
         HgCEs0wsSZ5VIFWIZTy8At+uQU21oTZCt3MjqoRrv8m8YIrS7IRfvCCe2eGiVmFMR7YT
         kAM2LwLnCQyBN1lsI5JAmtICJlhp2jgt789e451hj9tyCnMXfY0EunN4616H+Hs7GpNH
         qUulA7vGavlTGhKkTuxc5Dl0hY71SxGLBiGLAJxfehtPNwmNvUutbGjtzr2G4gI2+C1z
         wC+g==
X-Gm-Message-State: AOJu0YxIJiygy/nSEJW9kJjRWIcfAtbX1ijdLmRB52ZCplPGeFMmc67I
	6hq6HqCzhD3hy5iMNaPIEhJooM+6hfCca+eMI2EOSoz0bGFhYy+nUKDe4Ym4d9r2oS4ptg+6X2N
	YSXpN7IACq9gHX3cw0pap9CSe+T7WgHAP2Nb+uWWLRuCswXnQ9m0GG8DSzYiTZ04fhZc0zA==
X-Gm-Gg: AfdE7ckIX3y2dUWPLAlNCEE9enkOhGp1P3ASMGa8NtFjBre9NU4d5QANIcVC3lC8N+x
	RDnlM0BLk2mTm+PV9cmxKsKBmfecGFOzxo72A+SvGrDYLtMNdlGFCGQZuv5J/Qzu5HGoTI8l8DX
	VW2hHIkjjt08yvU2gN0bVDROmGk8TVdu1WKO+NMTgvqnqqFrlouF5PxnSIYBef1WGsg9Qvkd5cp
	w/bySnes836z1Kc8bNN9pXbggOk5TTE+P1OcX7eP2IZBYJTy+cQeOZ0hAHF7PFUwwgP1qXOMyRL
	19EZwT/uGmDtggg+manfNaz6hQ3UIiUvMKHaSVuwx1S/I8jg4U/SDExq40iwTsmKXTa7X9PcusN
	LCuk2Ja4WjCLktlwDRYF+pIzPirtSZpJzXGDuHXnUfWjJ
X-Received: by 2002:a05:7301:5789:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-30c84df3c57mr5151663eec.30.1782463389833;
        Fri, 26 Jun 2026 01:43:09 -0700 (PDT)
X-Received: by 2002:a05:7301:5789:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-30c84df3c57mr5151642eec.30.1782463389251;
        Fri, 26 Jun 2026 01:43:09 -0700 (PDT)
Received: from [10.152.193.243] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1ab6sm25418640eec.15.2026.06.26.01.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 01:43:08 -0700 (PDT)
Message-ID: <6df2e6c8-b0d9-4b41-ac8a-22d4415b60f1@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 14:13:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
 <44d9944c-3760-4ef5-8830-265eb2e9b896@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
In-Reply-To: <44d9944c-3760-4ef5-8830-265eb2e9b896@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA2OSBTYWx0ZWRfXwwbDZ/Q2M5AQ
 WtBA05XH9bNVRdqOEdYobpVdo6r6rTEKW+W3WCYiQ3Pm7eO6rEarv5ys1zv2AM6wJboBOP6CFj2
 zJ1Ea4LrxPTKFrSaZakn9UFBhGFDWA0=
X-Proofpoint-GUID: LrCmxEveU_JOPeEgLrEak2RMFs9LHfth
X-Proofpoint-ORIG-GUID: LrCmxEveU_JOPeEgLrEak2RMFs9LHfth
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3e3b9e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-Rr0OPpVIScezk7OxfYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA2OSBTYWx0ZWRfX2mIqaw/+HehU
 ZAanVnEGCVryVzz1W7dQjvy7LsSNF+ZCKvKctVKr68KNPfbDvIVNFiYH2HZRgqPklyuTxvfHntK
 Tkw1hrKtERV7RO5hHmsps8C9lLHQdVK+u3Tfp4JwT/YC09BZoBtxC0weAUqlSe5EKebHYQnHWA1
 +275eb0l6cbCbP9PBE+csKmmI9I03Toa4rVoI+AVupY2u0xOo83njw2359uFEb1lfEzk6yHBdF+
 CLV6t+2IN1ELd7Sqmh+6EMrkjdUa7WlAxuxO+eIT8G3YncVIuMZInyKxFktWW+HVrzqeCcqpMZ6
 9EWOt4eeyUUTB2fFo7OEl+ri0P9Gp2ZEcKE6xiuC/v+DCgeYvG1TwlA+GgpJoMrzJeP2eR5Z8t9
 JsmJ01t6lW2waqpSMP0yOv1JMKB5ObKi7yhwsWpWjqVkkF84A3Vfq+qRi5wx2nq3agYcqHm40UT
 igwJ/GZDteRRVN5U95A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260069
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38147-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28B5E6CB72C



On 6/24/2026 5:12 AM, Jeff Johnson wrote:
> On 6/18/2026 11:58 PM, Aaradhana Sahu wrote:
>> On AHB platforms, firmware operates in two modes: fixed-memory mode where
>> firmware uses hardcoded addresses for memory regions such as BDF and does
>> not request HOST_DDR memory from the host, and dynamic-memory mode where
>> firmware expects the host to provide memory addresses including HOST_DDR
>> after the Q6 read-only region and relies on host allocation for all memory
>> types.
>>
>> Introduce QMI capability negotiation to support both modes. Add a new QMI
>> PHY capability flag dynamic_ddr_support which is advertised by firmware to
>> indicate it supports dynamic memory mode. When the host detects this
>> capability, set the dynamic_mem_support flag in the host capability message
>> to signal the host is ready to provide dynamic memory allocation. This
>> triggers firmware to send the HOST_DDR memory request and use the
>> host-provided address.
>>
>> For backward compatibility, if firmware doesn't advertise
>> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
>> where firmware uses predefined addresses.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
>> ---
>> v2:
>>   -Dropped QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN and QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN changes.
> 
> I think you needed to keep the REQ_MSG MAX_LEN change.
> My prior comment that the REQ_MSG MAX_LEN macros are a layering violation was
> constrained with the observation "that is a preexisting issue with the QMI
> interface" so we must continue to pass valid MAX_LEN values unless the QMI
> interface itself is changed such QMI determines the MAX_LEN
> 

You're right. My bad, I mistakenly dropped the QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN
changes while updating the patch. I will restore in the next version.

>>   -Used %u instead of %d in the debug log.
>> ---
>>  drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
>>  drivers/net/wireless/ath/ath12k/qmi.h |  6 +++-
>>  2 files changed, 52 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>> index fd762b5d7bb5..e15a0c0120d3 100644
>> --- a/drivers/net/wireless/ath/ath12k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
>> @@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
>>  		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>  					   feature_list),
>>  	},
>> +	{
>> +		.data_type	= QMI_OPT_FLAG,
>> +		.elem_len	= 1,
>> +		.elem_size	= sizeof(u8),
>> +		.array_type	= NO_ARRAY,
>> +		.tlv_type	= 0x33,
>> +		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>> +					   dynamic_mem_support_valid),
>> +	},
>> +	{
>> +		.data_type	= QMI_UNSIGNED_1_BYTE,
>> +		.elem_len	= 1,
>> +		.elem_size	= sizeof(u8),
>> +		.array_type	= NO_ARRAY,
>> +		.tlv_type	= 0x33,
>> +		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>> +					   dynamic_mem_support),
>> +	},
> 
> Does QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN need to be updated to account for
> the new TLVs?
> 

You're right. I will update QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN by 4 bytes and
send it in the next version.

>>  	{
>>  		.data_type	= QMI_EOTI,
>>  		.array_type	= NO_ARRAY,


