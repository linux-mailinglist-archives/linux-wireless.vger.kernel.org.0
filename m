Return-Path: <linux-wireless+bounces-37540-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id THpgD8sEJ2pSqAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37540-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 20:07:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E86598B7
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 20:07:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="B4kA5RQ/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NcNj+Jw2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37540-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37540-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40F8A3040CBF
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969DF3793DC;
	Mon,  8 Jun 2026 18:02:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D8352C3C
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 18:02:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941770; cv=none; b=oXUlCH/qmqWM6leiiJqNVf1n3Op1Fq+wESCveWGj4iFD1QFh/zSp4IEoC9V/UqAfbdF3z+P77QmrvmZdUnXfxJEgRgtIhe4/xbkW+EAepTZ2TjNqSi8j7ZRNkT+pQlgamYLx3mw3Sl+ashpJRxfVomoKp+WxezWRlMqk3Y51A+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941770; c=relaxed/simple;
	bh=KpW+Y2fAkBjRtd4MTU4sifYqzqKisBXs104uip1G8TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmyB8Dg0NDsGW6kMEsgdySqhSyyDKtNKS6S+NYLkbpJRnzBUOutWqpcqsJKJqE0hqHGaKMir/h+lXBjDP6WGak4RCrQyaASJK1TCGfNnV5pvUknV+rrTXyDbzvgwJKiqr63o9DF2R3xWYxglvtveXjEJVsxLtRSwnPHjNG5ls+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4kA5RQ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NcNj+Jw2; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FGKRf4010358
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 18:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OWnb/0Le/7UQJwRxs5sDbMwc31U11Dyl6gRwsKyqgvs=; b=B4kA5RQ/aTWP4zgJ
	anexe/w6spY3XVu4ZuhiEq9vX9o/p75mWg7BBFXncfn5rCgJEO1Jws6UZith/f6t
	ggn7MrfkSqdkvxz58vQPv4auwIgHfYjB8VWVumD0o3sJBlqGWQAGA0QxICkSXI84
	AyhMEaCqrkuxmsyEYBE185kk6sZcQR6f/78elAz3f1YOMz+1TNQAFnRW5L36iLY+
	kAu1apJ93Gx5Cgkxco/NhYKdcdU+T0fghuqeKfpgKl2LqhHlsVLI4wTtQs1c5VxX
	Odcqn2Rg9nMo+VGHJXymPzG6tXqeNf88XuwXIbTCbwCYc61JQBBYEeaYoVdS0w4W
	+Iz8tA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0jj0m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 18:02:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85edbb10dfso2475541a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780941767; x=1781546567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWnb/0Le/7UQJwRxs5sDbMwc31U11Dyl6gRwsKyqgvs=;
        b=NcNj+Jw25OY99qc4oZ6qHUrxJExFFsw5jTzg7e1/te5XHplZTPRLdTbwsL9Ktzhfde
         WK17oVdazCKtSoX/yfDW2i5ZANLK/DpzfwtIdTwuFt9BoEXj23WChm3iOfjq6Zl8SJ6D
         b3zYe8gUa32NQVigcuaNAo2yzb17qy0lWoCFMtKOv8/4bRH6Uk9stfkkCg2owU1GyyCZ
         eKdCvmdQioTGMwKt5N4rphwp0qBCiYQelhIsixU7fqcVbTTej4ggurg4k6Cs587uYksi
         4V4bNWNcPZqaBwdLjC7cc/yqTnyQ6Xxp1iYxeL4KWj4PQzXLe66lVRzLGz5cAfP4+g0V
         uugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941767; x=1781546567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWnb/0Le/7UQJwRxs5sDbMwc31U11Dyl6gRwsKyqgvs=;
        b=cIekNr9BGrENJPC7E/3aiijeRa730lHUF/GRo1uapQF/CpGYMfN9z6lL2/1KLPSBa9
         etn0ayfOygTOJwI5tP68D3jab24h5B9SmpiwIETLPAbGPxv3ancL0G+ycYamNbVmenQo
         mFN0+zXSManah/SEcA8PqV7kRAn1FfTzbPZe1nfTr86pbPE6y9gm9O7M7PmcSMQmG2ME
         w0VihP+8Iq1IBMaDWyVHfBA9TzyCHC8S6AsaHLasC7pXDTcYWVRg0jQJbdXOOqgc7igT
         u75D0fCNcK50Irta1DpAc3n3MEWehadhsNbQE00TQKRa8qu9Giw4A61fvnvdNmBzJ48k
         GWPg==
X-Gm-Message-State: AOJu0YwkTdWyGsMHS+lkOHbthgNdbKdX7V5tnh/u/nxVOvynlCrOeTPq
	xJ6OLSWbU86JYGfjp1+x3lu3O+UVPPL+O9BNA9qPtM3s1zGBcnKgLb7YdL/gGLFNH/+U0mr6v1k
	2Z/D8O/B0C2Y8Ati0xT2MrFNB4lu/+GC04KiySrDwaiz8QdJlZH1EUE4OQm1janUh1ne02zLQNV
	lF9Q==
X-Gm-Gg: Acq92OFgnbDCJsZBF9+/Ea0ShjGbnwhTMEHg7mRs37grgWkLVxpqBzr8tfM2XgvXGEa
	7e6sBK6a6kVZiKD54bq43EWPTRZsneEHMQ8tG5OVDAUa+9FpoOZiPnyZ5aqEjE5hcjj1+3YviuH
	p7odmHQ5yE7GzTc4yp3knrKtOHKWLknc/AFbEzu0PvkAOmw0Dwd467u577PxEobjrmcGc91+law
	S5OWcxABURUUeE9Ue2ttwGRYhy/nLhNUvB3rMorcyDytg0aXmeyXuhlFfgJzkn8swKASxYxIswK
	cAh9VL3IYRDsS+gW3qpytMCyIC/n4QCrGMEoTYLmyAmOzh/A2SzqeOHqrPDO1wE3NRTLwXonRUQ
	Sfxj0qQ6GDkPWF+ZZAayhprGsQIc1mkcsb6Ee+En+IF2GoVheHw8LGB83Eak=
X-Received: by 2002:a05:6a20:2d09:b0:39b:bc11:9ec5 with SMTP id adf61e73a8af0-3b4d3a529ecmr13266382637.13.1780941766833;
        Mon, 08 Jun 2026 11:02:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d09:b0:39b:bc11:9ec5 with SMTP id adf61e73a8af0-3b4d3a529ecmr13266354637.13.1780941766351;
        Mon, 08 Jun 2026 11:02:46 -0700 (PDT)
Received: from [192.168.1.8] ([116.73.159.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03498csm18439621a12.1.2026.06.08.11.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 11:02:45 -0700 (PDT)
Message-ID: <298f2f3d-d363-49ef-9503-bead5b35e24e@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 23:32:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/5] wifi: cfg80211: Refactor
 nl80211_dump_station() to prepare for per-link stats
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
 <20260607175912.2266215-4-praneesh.p@oss.qualcomm.com>
 <39d12d9ae3b18495ed634715c93ede2f68c5bbf0.camel@sipsolutions.net>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <39d12d9ae3b18495ed634715c93ede2f68c5bbf0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2OSBTYWx0ZWRfXwxujo1kFSOub
 kfDCd2RCYkdbJxYG707r+etaAPVJYRPhwIa2Lx3MVwDgf1Ys8h53dpQhsyf+gshzdJ9jMLpW+Sx
 shVOaPX1/XEEzFQzsNs+29lBUqpwfOXYJ5V7QUkJKJ33A9MjS9uCdJ7kEqA/X8aSKHodM3H4+/Y
 qKWsZxHLeThxfbH0ve67tt8BsA+VoDyyqGf5M8JcgBiVUEeJaf/LHXbuUjkSzrCKuBsqSaME1gy
 sx63fZa02/FkveJn0ooZ4x8hnY1kr2ME/qUXOoJiNvua/kut11zBBKKlDbIDoVha+4p8zL32QEn
 CKAnXWe5L1dQwsI4UFQhxBiefZ+XCnefq+iwtcZPozt94QDP9pQfEDvTx7Tm2B8viqQ4Sqjmh+j
 9TlFKEic71NcjkiqSfcdL1w+MwTOhow3LzrmouH9NZ/XJU+/Bpowj4YjdUIUTnrbjwL6H6yGgLt
 D/tGZJM7TKvFFHcEHwA==
X-Proofpoint-ORIG-GUID: v5Z715BNA6B_oECGQPNgz9wTAsl7Rdds
X-Proofpoint-GUID: v5Z715BNA6B_oECGQPNgz9wTAsl7Rdds
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a2703c7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=0XKIscjZuezYqwSxLmfFhQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=8RXYgg6yP7Gg3BFkkKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080169
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
	TAGGED_FROM(0.00)[bounces-37540-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA9E86598B7


On 6/8/2026 1:00 PM, Johannes Berg wrote:
> On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
>> +++ b/net/wireless/nl80211.c
>> @@ -39,6 +39,39 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
>>   
>>   /* the netlink family */
>>   static struct genl_family nl80211_fam;
>> +/**
>> + * enum nl80211_dump_station_phase - station dump fragmentation phases
>> + * @NL80211_DUMP_STA_PHASE_AGGREGATED: send aggregated (MLO-combined) station
>> + *	statistics for the station entry
>> + * @NL80211_DUMP_STA_PHASE_PER_LINK: send per-link statistics for each active
>> + *	MLO link of the station; only used when dump_link_stats is set
>> + */
>> +enum nl80211_dump_station_phase {
>> +	NL80211_DUMP_STA_PHASE_AGGREGATED = 0,
>> +	NL80211_DUMP_STA_PHASE_PER_LINK   = 1,
>> +};
> [snip]
>
> probably nicer to move this stuff to closer to the dump code that needs
> it; at the very least it's missing a blank line.
>
> Also I think the whole 'phase' introduction etc. seems to more belong to
> patch 4 instead of this one? We can still do the structure allocation
> etc. here.
Will add the missing blank line and move both the enum and struct
definitions to sit just above nl80211_dump_station(). Patch 3 will
only introduce the context struct (sta_idx, mac_addr, sinfo) and
the stateful allocation/free mechanism. The phase field and its
enum will move to patch 4 where they are actually used.
>> +struct nl80211_dump_station_ctx {
>> +	int sta_idx;
>> +	enum nl80211_dump_station_phase phase;
>> +	u8 mac_addr[ETH_ALEN];
>> +	struct station_info sinfo;
>> +};
>> +
>> +/**
>> + * struct nl80211_dump_station_cb - state stored in netlink_callback::ctx
>> + * @wiphy_idx: args[0] - wiphy index from nl80211_prepare_wdev_dump
>> + * @wdev_id: args[1] - wdev identifier from nl80211_prepare_wdev_dump
>> + * @ctx: args[2] - dump station context pointer
>> + *
>> + * args[0] and args[1] are reserved by nl80211_prepare_wdev_dump().
>> + * The ctx pointer must live at args[2] to avoid corrupting those fields.
>> + */
>> +struct nl80211_dump_station_cb {
>> +	long wiphy_idx;
>> +	long wdev_id;
>> +	struct nl80211_dump_station_ctx *ctx;
>> +};
> I'm not sure I'm happy with this - better to just use args[2] directly
> for a pointer to struct nl80211_dump_station_ctx?
>
>>   static int nl80211_dump_station(struct sk_buff *skb,
>>   				struct netlink_callback *cb)
>>   {
>> -	struct station_info sinfo;
>>   	struct cfg80211_registered_device *rdev;
>>   	struct wireless_dev *wdev;
>> -	u8 mac_addr[ETH_ALEN];
>> -	int sta_idx = cb->args[2];
>> -	bool sinfo_alloc = false;
>> -	int err, i;
>> +	struct nl80211_dump_station_cb *cb_data = (void *)cb->ctx;
>> +	struct nl80211_dump_station_ctx *ctx = cb_data->ctx;
> This doesn't really seem better than just doing
>
> 	struct nl80211_dump_station_ctx *ctx = cb->args[2];
>
> given the overlay with generic code.
>
> Alternatively we could change the _whole_ nl80211 code (as a separate
> commit, perhaps even converting other things later) to have
>
> struct nl80211_dump_cb {
> 	long wiphy_idx;
> 	long wdev_id;
> 	union {
> 		long wiphy_filter;
> 		int mpath_idx;
> 		int reg_idx;
> 		int bss_idx;
> 		int survey_idx;
> 		//...
>
> 		// and later add
> 		struct nl80211_dump_station_ctx *sta_ctx;
> 	};
> };
>
> or so, and then we don't have the args[0]/... problem at all.
>
> But I'm not convinced mixing the structs with "must have this type at
> this offset" etc. is a good idea if it's going to stay this way.
Ok, I'll drop nl80211_dump_station_cb entirely and use:

struct nl80211_dump_station_ctx *ctx = (void *)cb->args[2];

directly, mirroring nl80211_dump_wiphy's pattern of casting
cb->args[0] to its state pointer. The cb->args[0]/[1] contract
is already established by nl80211_prepare_wdev_dump(), no
overlay struct is needed to document it.
>> +	/* Phase 0: dump aggregated station info */
>> +	if (ctx->phase == NL80211_DUMP_STA_PHASE_AGGREGATED) {
>> +		while (true) {
>> +			memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
>>
> if you have this memset, why do you need this one:
>
>> +out_err_release:
>> +	cfg80211_sinfo_release_content(&ctx->sinfo);
>> +	memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
> Seems a bit odd?
>
> johannes
The two memsets serve different purposes.

The first one (Phase 0 loop top) is a clean-slate reset before allocating
the per-station sinfo.links[] entries for each iteration.

The second one at out_err_release is a double-free guard. The ctx is
persistent across netlink dump callbacks (stored in cb->ctx), so when the
function returns early via out_err_release, nl80211_dump_station_done()
will eventually be called and it unconditionally invokes
cfg80211_sinfo_release_content() again:

if (ctx) {
   cfg80211_sinfo_release_content(&ctx->sinfo);
   kfree(ctx);
}

Without the memset at out_err_release, sinfo.links[] would still hold the
already-freed pointers when _done() runs, resulting in a double-free.
The memset nullifies those pointers so the second
cfg80211_sinfo_release_content() call in _done() hits
kfree(NULL), which is harmless.

