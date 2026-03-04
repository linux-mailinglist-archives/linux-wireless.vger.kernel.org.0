Return-Path: <linux-wireless+bounces-32434-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA7iAWXYp2kRkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32434-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 07:59:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 702661FB572
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 07:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9EE301FAAB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8637F748;
	Wed,  4 Mar 2026 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bs1pSfva";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TRaIhW1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD737F73B
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607584; cv=none; b=h0p5bENfmQK1aX3k9FkWtzw0wDRAorHbHAkulh7YIuRruSNCVfDHULIZ7R5PD6Bal4KeCeiUAx5RQSQnZJGmbqsGmmD2lq2Ioca9p31/W5xXeHrag21LJowbQliYd7VBl+Ns8qHereanb4UFTQTv91LKCgN6XFjomkZyktRt4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607584; c=relaxed/simple;
	bh=agtz7PuUXwjUchh4kUdapCx4EPwAJ15eWXCZB0IbuMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btF+hDrm+NYIlhQ0pEyrOuBeScnMeC+yo5iTbMqlhxNYwFUCkpF7PRpdzMyXOYIdEqN5x4Uad+6VyOs8YbV/OnyBDihrQWs51uA2bfcYfhL5fyOjZcErABc1SYDDGUeFoXTpR3WTc+K9SalgEsWP7jvbqhLlz9LCfJ+pgvoSVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bs1pSfva; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TRaIhW1F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SrWK153117
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 06:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	agtz7PuUXwjUchh4kUdapCx4EPwAJ15eWXCZB0IbuMk=; b=Bs1pSfvaARD4oLKT
	GcCRMRVBGjNqslTHur/eAHw/mFO181jjKidb9o3Z0RYvMOoR2Smh9IYQnJCTfc2X
	mayyRo6x2EmjE1zRdv5t5h8QPnR5JOc/waM8l+O0Qsvx7YXDh1KM9oNu55KBF4Ny
	TTBcCh1Xou89Ai8u6hpNpVqyY8rvsQ2PbvCp7N/2crB7lxf9sfdCrntNCb0KiQZY
	RbwYUSLEcDJZgC4D0KVydiU5bvCW8UmvMoUP+ZT8JGOsuGjJaGk72Y1xwo7PS8Ce
	W4Ox/x99EcYGaZV2NFBpWAUgSDqowhhcvNBoMStRcfTHKLkq4YX9ziaiqr3GyQI3
	3pyZ2g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvjge2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 06:59:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35980a994d6so17965205a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 22:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772607582; x=1773212382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agtz7PuUXwjUchh4kUdapCx4EPwAJ15eWXCZB0IbuMk=;
        b=TRaIhW1F/hyYPrVc5eZQaFyEunc1tFER73+/1xmFhZKVvYXc52FJ8tWy2UScz6blUn
         hb9zRmywCWY2gbtIInt7xgPaOc9ujjmu4pb8WPZ5E9RDRG61vvus7eOkS6iABS5TVvrJ
         lMZw5u//OYrocK+OHXn179dqojLK78z0iL2iX/5s0/wgu/VCZPVy8b2jOyiNG0HT6zwl
         gPx/cBMvrc3Ijnk9FZLZrPnqDMbFrk5nMgeKVM8IQedJftOyYmySOFpB23JkzEwDjJMc
         u6pH9kpVnorCsRPLKrMOzbw2NsIwz8I3CoBseD58/Re+ofGf8iMPMAG/I/Df9jGvNnbG
         V3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607582; x=1773212382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agtz7PuUXwjUchh4kUdapCx4EPwAJ15eWXCZB0IbuMk=;
        b=h/8WupmsmKAffWbmmkDzzcpqbwOvAljFgmt1Dlwh3M3jTb6cqhxXDfzC7lNTzo1klX
         +Nfyc3yZmB6hU2VecSZA1lOtroKBOPe6HlPu3VXDiUKlZV4H+vm2mQFZxY4508XluVcC
         0xnW7KAvmeqY6IQ0aaB6zk1nf1REeYhd1p8UYaYWspAFoyVApkjmFbgFGgBXB0cbNpG/
         s5hBa3w4x3wGjXqlYWDl4X7lNW4zoRRyrV+Jt2X2h+/wY9lpaU6BKeln4CVFbRzQ5l2e
         t5jyvs/mGcCJwkZ5Pj1UkxYUB75FCTS8Ynygi6A1huzOZF0vaRdoMmFF0dLOgyY+thul
         ebVQ==
X-Gm-Message-State: AOJu0YyJIC3rEErDvxvgT1rVs4KVgxTDN5tZKJc/52Rk2nO/SsDTZgRs
	0IX7S8tBdWlUFi/9ALKK7n7TNRN2kcAl632XKP4vYjkAGMSPGSgLNDKwZ95V80dBQ/YKZY7K4kx
	csdLkpXgmjNbqTWuz9djYcYIQqH4gGUpctYwd+kfiv/5tA/wpdVFdbGe7usWm4VeRn6Rl
X-Gm-Gg: ATEYQzxmYg9h3MRj7qVlZYS6F8R4w8tLNKxc8sHmxDGyWDCIIu0Y1hp7pCMaWJgbgGI
	QQ8AzZqpLNY8MKjw+1XCWEKwZntuq3++rCO5nQPDQImGdzquMcScUwU6IZ6r4i6k3psx4fxvoR2
	uE635K6yjyDInJvr5s3GTYtAgacSSCqeW1cBRtV+TMJtiIJt4bAMT/SHlCGWWN4Vwqc2Ri0SGge
	ARbD1LVMv/p3tyLrXNMWcwQO0LSFoJEZ9FM3TQd+Cbm2jDvC5ctmuKktrj61L9w+FQ3BbVPz8ec
	0oeRYmaHA/+HPy7dlgZ4NQu5rlO8YJ+ZxAL+rfRdf1FFjgcfhtlcWOIoTdhWGNMGIbvIFFNCJKh
	0s3rDdIGZgbfSA7k2p+TwQrKhSQecPJHfqbFvDKDSb5UcbPpv9MXL
X-Received: by 2002:a17:90b:350c:b0:356:4c1f:98d4 with SMTP id 98e67ed59e1d1-359a69e1894mr1261525a91.13.1772607582070;
        Tue, 03 Mar 2026 22:59:42 -0800 (PST)
X-Received: by 2002:a17:90b:350c:b0:356:4c1f:98d4 with SMTP id 98e67ed59e1d1-359a69e1894mr1261510a91.13.1772607581641;
        Tue, 03 Mar 2026 22:59:41 -0800 (PST)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3f21b9sm4066274a91.1.2026.03.03.22.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 22:59:41 -0800 (PST)
Message-ID: <63102b0f-bd91-44cb-856d-ef0f51ba76b6@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 12:29:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] wifi: nl80211/cfg80211: add peer measurement abort
 command
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-6-peddolla.reddy@oss.qualcomm.com>
 <8dd352f984cfd23ed178d5917419e15af0c201e7.camel@sipsolutions.net>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <8dd352f984cfd23ed178d5917419e15af0c201e7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1NSBTYWx0ZWRfX+umQgZLwzTuk
 q8xSHiSO+K/yfQ+rylyOcBDdlYALc5t+b2TYD1SofVGRYQARoBUeEJfN5Hs03hJA2nHtYueaZvz
 QunojBEQ4t7qwLZwR8CXDxGVpRVva/hMhENo7GgNmQNVxV642KBjfmIAeu+moFfYUgBCSJwuR4K
 BAgLxUFMC55nwaPugBLV5pgGmsIrLdNdSTn2v56IlTPL57b0JEAF93NRtr9hxQHTf6+y5IjBXmY
 8hrZTfpIyn+pYSSBuvePb1foBd5Vw/GilO4Vas+6P4QMf+zvdgLKbbadiR6yX3+xG5Dn8M/ADot
 Az72+AeazreAF/1kw8m0JQbRtxuiunciHo3EhfRjQ6dfjv6PvlkUDBS57Tf8CZl3LnRmN+DYWRk
 ebDB1nnXZGjDl5EseteRKF/J11UmQJnkCPLm1n0NFM5l/ggakLMMz8XCJ0YUs8OZWxVMNI5k4F/
 LlEVw61Rqjo3l7hcIOA==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a7d85e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=uCdljyhue6eu1we0CHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: k_AqD3zloN9mixsUuZepRi5dRGgOi-QO
X-Proofpoint-ORIG-GUID: k_AqD3zloN9mixsUuZepRi5dRGgOi-QO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040055
X-Rspamd-Queue-Id: 702661FB572
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32434-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 30-Jan-26 9:45 PM, Johannes Berg wrote:
> On Fri, 2026-01-30 at 21:30 +0530, Peddolla Harshavardhan Reddy wrote:
>> Add support for aborting ongoing peer measurement sessions
>> through a new NL80211_CMD_PEER_MEASUREMENT_ABORT command.
>> This allows userspace to cancel continuous ranging or other
>> long-running measurement sessions before completion.
>>
>> The abort operation is identified by the measurement cookie.
>> When a matching request is found, it is marked for cleanup
>> and the existing free work is scheduled to handle the
>> abortion and notify the driver.
> Originally, the idea was that we don't need this, since it's easy to
> just close the socket. Are there any resource constraints in socket
> handling in userspace that make this necessary? I'm not necessarily
> totally opposed to this, but you also haven't explained why it's
> necessary at all.
>
> johannes

We’ll be dropping this. As you pointed out, PMSR abort can be handled by closing the socket. Thanks.



