Return-Path: <linux-wireless+bounces-38427-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mDBaO32GRGoXwQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38427-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 05:16:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6D6E9674
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 05:16:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CFdKlPir;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="f6+5/KkD";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38427-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38427-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D9B0302AF59
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 03:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A832DB795;
	Wed,  1 Jul 2026 03:16:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E72FA0C4
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 03:16:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875765; cv=none; b=JgiKOoa4gYaryA88YfOzmkmEs/UiSWNuFQQbFFHFpIOsDh14OCXzCjoBvefO+aUq03zMRttBRUUJPx6RLAA/nhEgS8wQAsj/2Z8q2dYW9HaEk3Q+nk+VYKk6Z7QtpMjlkilSPPaw1WfXc9Sq0SfCwZjtopmJFVBIXV7YNGlhL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875765; c=relaxed/simple;
	bh=41p69QRlg1Rraqq/j2JGK+Hac8iko/0XEVDMVLggZRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWm+X/WKh3xG/QaxP0acgIkBEGXt83w3LSjcs9kKwNp4Yy5fePO00tYopKUhAixLrdLcxfw2rsYe5N7oHXMJmAZJi3xzChFERyxyXFfMclWF1GX58epBS+U6PyksEP4ck0uilCiAh7qMt9boBzl6BhPj4JUMsLzlDJvtiwTnQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CFdKlPir; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f6+5/KkD; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tND63867932
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 03:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EluPiVYwrut5vB0qvVHBuX/RKP3pGuDFL8Baho7ssgw=; b=CFdKlPir1LUv7CT0
	WJVZjwGMWOaq12RwUJ8iW4FwHeMlJtloa3dQFcXEw6mzEZSw3hG28k7HDQJc0TCR
	BymI6cgFBb4wFwxBTpOG9b+FkleIqJgAUlBRoD8cS3u2h87ZvVjN/YbrEM3P9usS
	VDM+7EvC/jIJdv74QRqLEan3atmQdSGcEWCqLaa/kcPJ9EIl6i9qt711wYyLEHHI
	qH47ig16m9siXNR6n4uMUBBnVuMlZ53sq9g8DRwKaneE+NgkbJmFDe3TlgJJh4Bc
	zctYwo004q41ymXJD+JjHo9alCdhe/ytPoWoAsHKGgwL+0RdlyMSft/qGMyCguav
	bKoFVA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfya9ak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 03:16:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0a27ad86so717605eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782875762; x=1783480562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EluPiVYwrut5vB0qvVHBuX/RKP3pGuDFL8Baho7ssgw=;
        b=f6+5/KkDGw0lPW/Z8NvF+D5OrPG25rUk2Hmui6k41yp7qiSMmLbErSVchYg8YtsVIt
         6P+k19jGPiqo7SRy7Cjo2GwdTVnLF5w2DWVCJY7EKaobrU8ktoT5flVp94BsUyHLZakI
         WcLBXvKazYFu/y6QTySH4JCGj6CrUaMbnex5fisaVTx2isi/6McbYQUKpmf91z330ttt
         6ws/BGnZRg9z6u/snD2AgpZxaJl2BDSAzt1FJH/e8K8c+3slwFcQOQUcy5RkKKkXqWPY
         z01PVdpgvaM24omYFtnib+Ri2bXLhw1NIFXkTU/mMG4JoaXu/csoMDhcIoz3Ydj15goB
         Oscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782875762; x=1783480562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EluPiVYwrut5vB0qvVHBuX/RKP3pGuDFL8Baho7ssgw=;
        b=c+l/kLlTMxb8+3BwtglsCI6N654shtlM3W284rgkBZ8+Jw+bQBWj+A/RpsoJWrkFrl
         P5nhPeDZh09+82nru1rpUFv0JRa8EOFBmwSWan5Y8oQwtj63m4y7jb3nzYnr5Segfk6a
         8prKfRT62qkvY9/BV+GGTuyrtZzzT7SBybyThWgAQif4wRCVIAaXXTKC1kaOxRdxWH3D
         SnpMIOp2EOZ+kk/yW8/zXdUaSMOykaCnsmWRBP9TQkYW9EtAh4KYFyWs+PfprxSjw1vn
         Re0yJvXIPM0lH5aOGJyTER1eaQ1Xc5XbBfN0/LDiwJIWoVen1JhxxixGjfIdEPVA69S6
         3Kfg==
X-Gm-Message-State: AOJu0YxeUVGMRkXff0JEpk+MG8AT/sl/sGFe2AgZ+CZ+faCLhCIB8ZEe
	Bl+suK8Z0mNIfSmhgbD4MXGfHl16ASjJnjJ+4hjKV6wPuFRuyQCgNp3ThpIdSFhUnwxF6iWcL2A
	p7Rz+pVYGE7FKRcl9vUZjQiWLoNXKE07luS8jOwNyG0pE8k/Vz+LfszI47R33efh353+Uxd7cqg
	L3PQ==
X-Gm-Gg: AfdE7clfqskEDfzAe6sJM03oKwbd9b6cpJ92/o0x+06zrxs5RvHEn73YX3cux5SA2Q6
	+vlhZ78aas/NgFaVUnED/SvXR2Uk5mBnXJ21ikHFiPwbQTNE2X36DulKmN+DYPsXQPmdqJb5CXo
	7W51ebIqMyf9PsrVqNsuaL3SRRh97wGpZVdXgB/6WLrchSgkJOADs++FWRkJ6dTyIIB2x0OmBuN
	HZ4ruxJ9JiouNmZthXhN0/aI+hqQ403vcBxLguACSYKDCPH78bgQV+YpcBsKTygpD2U6ewwvoZX
	6cyUqNpxruJFg6xwxq4LhIB3NMZjiD2AkgNY8V84mlCLmwl8o9kItKUq+i+mL9rTPy+wHr/JcBq
	FUbpe9RFvZEQ8j05/W8kY7RZYpsyJGu0e0QJUo+8KuWmP
X-Received: by 2002:a05:693c:2d8b:b0:30c:a62b:d033 with SMTP id 5a478bee46e88-30ee1347f41mr5819771eec.15.1782875762114;
        Tue, 30 Jun 2026 20:16:02 -0700 (PDT)
X-Received: by 2002:a05:693c:2d8b:b0:30c:a62b:d033 with SMTP id 5a478bee46e88-30ee1347f41mr5819743eec.15.1782875761474;
        Tue, 30 Jun 2026 20:16:01 -0700 (PDT)
Received: from [10.152.193.243] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee31da9f3sm12011579eec.22.2026.06.30.20.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 20:16:01 -0700 (PDT)
Message-ID: <d828e192-5a5d-4962-98d1-0f86ad402a63@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:45:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
 <4db87d04-2de6-4521-8da0-d80b036d216a@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
In-Reply-To: <4db87d04-2de6-4521-8da0-d80b036d216a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a448673 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=GQrcdJE8DHaTUL9bi8kA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: d3IzRyjZnIl02eSfmAssJujFU8aGVtVf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAzMSBTYWx0ZWRfX0uMKbU3jbBjZ
 oXpNcAidVigq3qqVqkJ5OscIgrgpm4orVwFTDWKZDKCrscodRBWXcoPCoY0qJrOhkx0YHQJMKjM
 j6bGtL8NjuMWfH+EXK7Rd7Qi4KhBKEE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAzMSBTYWx0ZWRfXwDsXHnaTlXJy
 uLk+/J0RvskVhsBS5z2CemUfZEwnES+6FUWnOvNh4z/VGkzE5VkliCXagwNglidSASYp80PR/bY
 MPPOvYIgMFhy7ngbZeRReOupTGtrDVLgqTJSTtVH9xBLnAt9Qaj34RkuMQWLboSXfUvsHJQ1X5n
 nRe2hWmeLNGEuME9ShfiRWKJQnq8frWDA7mo1UKA9lrthRC8/2+MAVHx9ugNLp5DJHuJj8+c+kJ
 15qk5DlNpcc9R986alrGNKzm2z892kH/+nFx0r3VahWvxwGpRBziou8l3Lw7454pg91LndLHZMQ
 wtlbMnb+O+AMyFKAWjEb+RFVyzilIi8CjBvvr+07W+lsjtv0InZoqIIIkUzg1WP3i6pFOgqHCyY
 Ikj3wb8tZEoyXCRgieZPfNhzLiJS3opwBu143Mio/vGvV+DA58GfMS8lmolWQv/k8fXw3V+znCK
 r7r8FnXe9WDdkgqZvAA==
X-Proofpoint-GUID: d3IzRyjZnIl02eSfmAssJujFU8aGVtVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38427-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CE6D6E9674



On 6/30/2026 9:23 PM, Jeff Johnson wrote:
> On 6/26/2026 1:43 AM, Aaradhana Sahu wrote:
>> @@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>>  
>>  	ab->qmi.num_radios = resp.num_phy;
>>  
>> +	if (resp.dynamic_ddr_support_valid)
>> +		ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
>> +
>>  	ath12k_dbg(ab, ATH12K_DBG_QMI,
>> -		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
>> +		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %u dynamic_ddr_support %u\n",
>>  		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
>> -		   resp.num_phy_valid, resp.num_phy,
>> -		   resp.board_id_valid, resp.board_id);
>> +		   resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
>> +		   resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
> 
> Your logging change conflicts with the one in:
> wifi: ath12k: use %u for unsigned variables in QMI debug logs
> 
> That one is already in my pending queue, so I'll have you rebase once that one
> lands in ath-next.
> 
> /jeff
> 

Sure, I will rebase and send next version.

