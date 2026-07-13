Return-Path: <linux-wireless+bounces-38931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5mpzNzNbVGodlAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:27:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C1746E9F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SaE+oz12;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=g3+s1B9q;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38931-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38931-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55DAA300E14D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A03148D9;
	Mon, 13 Jul 2026 03:27:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646E2750FB
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:27:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913264; cv=none; b=QApxTF059b4miscHgCwuP0fbSv04cquy73wDnJ96v2PGSrdoUomreuPy1FAQUq34dEQcm+fmf2DPPXUGBfZ3/aheCoPrPTnojnU38RcagmbMxinrL+uY/WAGRiH3dpekPWhQO2hlxRHnu4d6x97tvgmezVbsdGq1cbstDJ9KtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913264; c=relaxed/simple;
	bh=+34/+z0ZbKu/bd+1LPpvo5wecLNwgisenrK61naYBWU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bq9W7PF6XIrm2EjAvOHhH65V5b+z2A2G4n3FdV5w8bnSKMWeHehp/FZ88IITTKb1iNOViduE6P9DcUWByjV9G0gXPv/u+UKVjXD5J/+WIQctDM7UqiY4Ek8Gfllm+Fa3eZ/bbnJ0qbH3gkhw9clOqGO7kO8O/FCmlwpvdZRu2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaE+oz12; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g3+s1B9q; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D39uav038520
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/I7ysKPGmLo31nVKXGt3xJ1uJ1s5WIsQGW+XAUac7eg=; b=SaE+oz12owg3FFjG
	ut3og67F31ij9ChMII67hOnCnlHYcWs67TpDMJIKsCIuO9tpym80cH/5yGh49uAV
	GhYI3CdKCKlN08+DPJ9MC1m4XqKB3iDMB9Yk9IBJJjTw14wJcGlkolf/mEpZ8ozs
	tb8yqYe6EJEZujzfO9hJAh/gEi5x8qqQ/N6uVexqXnaflkX7lzVeZOsT3sUcmoMk
	ea8BtmeXge7NeRVIsPVe05pXgKWFrKzGWo58nUt6xG17wg9uKsOjVmXRaWHt/hHS
	MG6j9cP4ts4L+K6cT+HC8jCbSLWmB1qc6INVNr129IDOygyKgFyPcmgxUrNOS9ep
	SO6mbQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9m6ve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:27:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso4480696a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783913261; x=1784518061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/I7ysKPGmLo31nVKXGt3xJ1uJ1s5WIsQGW+XAUac7eg=;
        b=g3+s1B9qlkGREVwvogvbXWvQN9VfzsVeMioV/K+lbNfx7U0WVrnfudw5Ywx/YT6TTd
         XfsdC+R/r/mVpEzDjkBE8uf6K7Ms56g3KA8jWoKwY8rFeKXLZgHQp9MnevksEWcELqNC
         4qLhiSC2SxQrSbFtr3+hBSPL5PBqjxUmfBD37/NSvCRAlDUegK49Dgg0GITH3ZKnjBhd
         PwwRmrBeB95ihLayqiv5PRD2cZvC8tI/2iVpaEYHXJnfXX+kg+bqTPOn+KQJV17mV6o+
         ouX//i7xUtmubo8rqt4rFNEEK7p7BxYC0Q7Pi6EYk3BKvmD0Wn1SzbOwiGNDS6k2Rq3S
         I6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783913261; x=1784518061;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/I7ysKPGmLo31nVKXGt3xJ1uJ1s5WIsQGW+XAUac7eg=;
        b=Uu7OrhhSOYw4i9nW0mmb1Bb+ICZGkkZyHNYfn3jMilAue0cf9E84BWjxkvkFO+INax
         eTxOsSywOjni0lfrddR3osDhpTICTQhbP60nk33F6r/ThTcGn75vA5+S73Q4pG1CO9ZQ
         W/0gX0uY1Hab0Ixy6CJj5I7UzyDDUC4qq/QUGWzKEKF2P1w8/pby5T2Jl5RaMlUKdJPw
         iv3wHIOvcszcLzeM+imhesvCcsuPCf2/ixeCAro1+E2bFZMgQGuoH2pKn8m+SMRZYU5l
         Y3cx+KYREBdWsPWlnUsx5f33BqB+LznumQnuagE6uDNUYDUSvD8HacjOtD30YdPNrO6Q
         DNRg==
X-Forwarded-Encrypted: i=1; AHgh+RrJ+2PP5Vigsa1D7n7sh91KdnkIdE4QOZWUltnXeeMN+bjGG4s9d8pX0MqhSqmuqEwosDBRW+XIcC5EYG+1vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPT6o+e6Y4PeUm9VUfcCBmZgfUKH941KvvNtCe4O7bpizqRIe
	94sjUGiPcNDL2OPnu33+T3yIUVOOhZBctvmqLtqhKhID8POr4EEQ3rGwPmzmw8ryVnFe+sStbCI
	q9ApaqcbOX7WE0Kut26pRVuOoPPJpy18aHd54F57mka2emi/gAVPceeJg+w/eDYBN7P98zQ==
X-Gm-Gg: AfdE7ckm4M3n5h6nt5DuErJ90sWMB2iF1BZtJQNQIMT882spe3rntbR+EOnNlg3y588
	4RUmsT8vwpdVJahjviK2ddm3LkeHqjsBEnKC/4Sq7LJ+Daq0hiYNK/UBOwaCl9vX52Nj/wtFDj3
	9Ak2MK+GraXVV8hWfD+FUry7iDuiAt/dFEwUSMejSrGARTOfGyf/l+a9zT2PuaqHbJoXRGswIb8
	KZ8DwWGDmHtuuyzhZDgrc7IVklaI2r3EFSiy2d1UO7zT0p2Ujkzd1uHhp2DOgWEMmowz+tpVs9J
	RTkbocNkeH+kMLCj8qa1i3sP5e8TCHCSHLBnjEYPElekEqYjc8/352NU6B2Q1+MOIqd7HCvHD9R
	oMPTgB1U/zh0ndzmGyN023VG9MzALzF5WWIJLGcicyEncSzgxO5aq7Ho9NdaJ/OGuqUttUKOoSJ
	2B8eEueOc=
X-Received: by 2002:a05:6a21:a109:b0:3c1:142e:762d with SMTP id adf61e73a8af0-3c1142e7916mr6387477637.1.1783913261328;
        Sun, 12 Jul 2026 20:27:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:a109:b0:3c1:142e:762d with SMTP id adf61e73a8af0-3c1142e7916mr6387459637.1.1783913260824;
        Sun, 12 Jul 2026 20:27:40 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca79aff904dsm5967088a12.6.2026.07.12.20.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:27:39 -0700 (PDT)
Message-ID: <c9e357e3-8ae3-453b-bede-209facf7d3bf@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:27:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: release QMI handle on late init failures
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260708100924.744386-1-lgs201920130244@gmail.com>
 <8133bce1-2b7e-46fb-8989-f5946ff341a8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8133bce1-2b7e-46fb-8989-f5946ff341a8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzMSBTYWx0ZWRfX6fGtGrLE9OPk
 Vg6O3OFHuYTVUP750f9HESS68e9JI9TPpggO+y1hNeVYMZ0Ro4O1ZnJFiMs1rjQdMyaedwQ6jzo
 v7XGGWa9ssI7TpHxXOE+DFwEU6n3tC8=
X-Proofpoint-GUID: g7dv96YNfe4uiWBVBtKliCk3Te1rKt1C
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a545b2e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=rfVp7ZFB_JrZeHXHEsIA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzMSBTYWx0ZWRfXzoi8sspf2PIN
 dW5wt0rjHNdgPGSomwsfe2rqSpvmx6ScXMEEJqox0+Nb1J0K5ESsuNftoe2c2fOEfrZqPSFZR0r
 +DMehh0J3GA0+j9OwCMkBPrRQMtzIyasOd6kBalfRbtM1SPiMwiOeBhNXnkFlpX6i+KV+Lne92P
 gfmiKeVwCoXKcCPayASoiJZA1YUKHCB0KLAeGUCZ4W2wAn/g6igf7UhAor/CR50w7lGu5+c1ehZ
 OrEYcvZ5yp8078Kv9GYJEyijWEKt4Pe4xuG1Se3gAarvBhg1Zoiz+rM4RxcvRLln4UJBnmCNJsB
 +aHKbnAyrCV6JvNGYTKwlPBdQxJbf9RvaeKHS83x5SnL1By5GVY3u/ZoTmooSOOHUjEhGAbLHUM
 hEdsdwy3fk83cfAPvUnj1pIvcNSqcrNvcQkoadGEMIAO4lsC0lSYdrGQgXcHdII3X9HTO0shg9g
 ddhHW4E3+hhRPBkxDBA==
X-Proofpoint-ORIG-GUID: g7dv96YNfe4uiWBVBtKliCk3Te1rKt1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38931-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:jjohnson@kernel.org,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oss.qualcomm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C5C1746E9F



On 7/13/2026 11:17 AM, Baochen Qiang wrote:
> 
> 
> On 7/8/2026 6:09 PM, Guangshuo Li wrote:
>> The change referenced by the Fixes tag makes hardware group creation
>> skip the device whose ath12k_core_soc_create() failed, and only destroys
>> devices that were created successfully before it.
>>
>> That avoids releasing an uninitialized QMI handle when qmi_handle_init()
>> fails, but it also means that ath12k_qmi_init_service() must clean up any
>> resources it has already acquired before returning an error.
>>
>> qmi_handle_init() can succeed before later initialization steps fail. If
>> the QMI event workqueue allocation fails, or qmi_add_lookup() fails, the
>> function returns an error without releasing the already initialized QMI
>> handle. Since the failed device is now skipped by the hardware group
>> rollback path, that handle is leaked.
>>
>> Release the QMI handle on those late failure paths and clear ab->qmi.ab
>> so the failed device is left in the same state as the qmi_handle_init()
>> failure path.
>>
>> Fixes: 088a099690e4 ("wifi: ath12k: fix error handling in creating hardware group")
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/qmi.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>> index fd762b5d7bb5..31e9fa9a62be 100644
>> --- a/drivers/net/wireless/ath/ath12k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
>> @@ -4054,7 +4054,8 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
>>  	ab->qmi.event_wq = alloc_ordered_workqueue("ath12k_qmi_driver_event", 0);
>>  	if (!ab->qmi.event_wq) {
>>  		ath12k_err(ab, "failed to allocate workqueue\n");
>> -		return -EFAULT;
>> +		ret = -EFAULT;
>> +		goto err_release_qmi_handle;
>>  	}
>>  
>>  	INIT_LIST_HEAD(&ab->qmi.event_list);
>> @@ -4067,9 +4068,15 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
>>  	if (ret < 0) {
>>  		ath12k_warn(ab, "failed to add qmi lookup\n");
>>  		destroy_workqueue(ab->qmi.event_wq);
>> -		return ret;
>> +		goto err_release_qmi_handle;
>>  	}
>>  
>> +	return ret;
>> +
>> +err_release_qmi_handle:
>> +	qmi_handle_release(&ab->qmi.handle);
>> +	ab->qmi.ab = NULL;
> 
> should this be ?
> 
> 	ab->qmi.handle = NULL;

I was wrong, please ignore this comment.

> 
>> +
>>  	return ret;
>>  }
>>  
> 


