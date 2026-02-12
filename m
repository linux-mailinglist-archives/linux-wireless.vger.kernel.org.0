Return-Path: <linux-wireless+bounces-31784-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jUXsAUkRjmk7/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31784-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:43:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7215813007F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D39B3034A35
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8A1A0712;
	Thu, 12 Feb 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/mbQe+o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azmxVqpN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73143BB40
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918212; cv=none; b=KniAsbTZ2+KPLfw5jwQO6Z1+iVBpieGRyVS2iIrXDh4nx55EfimCp2OD7p/4UGFCs3yM9Z7rZztx3okDVaKG5cUf/VJtVoGWibH45jthJ9GVt4v1cSJjdMohrdlsbK5z/fl4ExKHvlq+9O6y0MEnWmH2FuUVTdNwkOzq3HamyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918212; c=relaxed/simple;
	bh=hXhUjFZXcQ+MO+vrt5Fd1D/t9fV6rSeyuxzeYzHqMAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7Puh2oQkvw3ghZM04Cmykv1CTVqnBaYyQALUp56lxWdiypbZo7MSIymgTn30XXPdZRmG0sPAdvbOH27zvHYgJf1TcX5ZEhmgNTIzH41cjnqLePWcf1PiGF9jITSblAFKDSr2NfelD+WZohQ2RobI9eOiBhvUk/5Ag/SRWtY1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P/mbQe+o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azmxVqpN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRe9q332253
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FcYo05PZlk2AUgSB7V9lX1yVEW/sgbKI2PL1ZdsLsc4=; b=P/mbQe+oijh+ghJ4
	8UTjqIhcj6qWAl9QVWiUr6Uqgmh05/ITnGnSFK08lSE7B90YK5t0WPBc0IUMkt87
	o1dEuOmkROD5KiZei2PEcuGIMvconMKu9qVZBsKtLRpHKDMJrT55UJcgOuFbzrDX
	/dzw4tLyd1j9h9fnw7SXbJGP83xYtZNy2FVTeBfG7UE3Ldx1D/0DSCFPRxnAj1E+
	2IsNkWWsZWvtePXekfeleKMkLf5FNdsis7mD1QnaEbf/p7r5+ICn3h23k2N79hWU
	hQZm5MYCePnFl7qcQ26WQLQSuBIkYUs52h0SrPwHurVa7ZaWoMm8IBruhzw6VUM1
	Ij6coA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cya9h85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:43:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35641c14663so103649a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770918210; x=1771523010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcYo05PZlk2AUgSB7V9lX1yVEW/sgbKI2PL1ZdsLsc4=;
        b=azmxVqpN/StCo6Owc78s7prqzFx3iujgAaHGcodYYhnKNc8GSaf7rV2SuEe53XV8kU
         cTfiIgXvMaYHfcba6DjSvJ+oKrLONR27maoJkWCmGfSw2PzC6kEUJbN3alfc1gG8WJqx
         k/QnWy4xYL0SY3Vyvrkmn48HyyEN1JRSijMEAnGOZhhI64XQQX0xMzW1N4VMyYH2Jc2Z
         VIiwoUHOLrbtiqeHtbw4T2KoqjRGrtLwEa6uH5740xO6t5DrlXiO5KF9jxokxaxSHBN7
         KjItb+rxYlHrPQHt0lqz745dz+GGqWCXPDmOswZjmJF6rf0tbtVpLFsQ4/DGJnH3Czjj
         /ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770918210; x=1771523010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcYo05PZlk2AUgSB7V9lX1yVEW/sgbKI2PL1ZdsLsc4=;
        b=Kianl6IEjygIZ2JoSmi1MTgAoYsuS5/91l4nnHnbSPC0Hjaj3wrS+4AohUYFuMeFzU
         AR2sxTNixcLH13+cmLrxLAOewoZRv8H5urnmizZyd3kAj0uJimF/LbG2zycQao5rBuqc
         /d4zO7r+Wkz/lTCMSr6YdHLb/HbfHCh51VJhBkkIqzToFJuRjw3KVgyfFloikSUffws4
         Ysl0St+v1su9c8feTB6D+nvbffzNQXw6OxJiDxHwqFTgFvzpiDHoO1btskJlzfOLmoh+
         MCPCvlIm/Xy98uPMa3qF9c8FSsZogAlllpv4rye648aqpCBv41WcwzdwSUAUzZtrltgy
         ZxhQ==
X-Gm-Message-State: AOJu0YzaWPGoR1y/x67Yo4QqwouzUCNwasQxfHRIjrxIhZ8dvLfvOm3i
	Q6kVVE6f9tqNvj2JvG8SL2mWVAvVUmCEK3zfvNOipvzl3zy1jxGC+5G4tmRHJuur2rvwCbjhfZT
	xZelrZUMDGt6Qhn3L6baOJSEZf1geaJ4+WOUoy3OEp2IgdfAJH21xxwQsHaSb9umi9jOIDQ==
X-Gm-Gg: AZuq6aKs6CqAdpN2LiscD69umULaGqvZ69ehO4K/hjyxOQaSA6j/JGtyQg7vnvcGb77
	ZVtT/QmTj8cTwWZ4K2/KF5IOkThb2uv1oAmTX6U8tolY007kqJ4TZ3s/XOmL68jIrhUxzdCaEwP
	gkJ8nCikYGARks2NeWRZqCvLCF5ppUrJkKdW5QEuA8Sc8b8tXXpD9NNtk0bSeNF7yqcc2Y5OvxB
	gG2hYF7iVqb5+tDdZYLF+LwF+YQhaTBRZfwE4oCtyYyrJec43UB7VSva6vUuzwXB1oa4XQPHt75
	JuNVoadGweHKYCbrSftTGX9LGsz1Gxx7egN483vjJpFh/OKhZL78WAoxVHVMh+bsnL0ipqZvy0L
	xYyy2Fr9rcvukcaDqeUAroVArccoQblIc5ARfLP+2lSoNIlLquTHQRtMBXzo4w5GoyarwKgHBeP
	NgpukimLdoRFqGDNQal7NwzquL6wtyZv3Ydbp8+/hQqvdrEzsJBw==
X-Received: by 2002:a17:90b:548f:b0:340:e4fb:130b with SMTP id 98e67ed59e1d1-3568f314b04mr3222992a91.14.1770918209491;
        Thu, 12 Feb 2026 09:43:29 -0800 (PST)
X-Received: by 2002:a17:90b:548f:b0:340:e4fb:130b with SMTP id 98e67ed59e1d1-3568f314b04mr3222973a91.14.1770918208994;
        Thu, 12 Feb 2026 09:43:28 -0800 (PST)
Received: from [10.50.42.130] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9dff38sm5670314a91.7.2026.02.12.09.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 09:43:28 -0800 (PST)
Message-ID: <6e9ff54e-dc83-46ad-8415-5c950d6c4444@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 23:13:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 00/02] wifi: ieee80211/mac80211: Add UHR
 (802.11bn) Capability and Operation parsing helpers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260212172401.234059-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <c9353b48d4efdcdfcd46553e83a8131869c08b49.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <c9353b48d4efdcdfcd46553e83a8131869c08b49.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vOb2SeVWVEowV3Fe5OIkvN5UgKqSw6Ix
X-Authority-Analysis: v=2.4 cv=OrBCCi/t c=1 sm=1 tr=0 ts=698e1142 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=GiPjJN1dBy5oX2_y9DcA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: vOb2SeVWVEowV3Fe5OIkvN5UgKqSw6Ix
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzNiBTYWx0ZWRfX2vyr89tmQgo8
 pvJRjkJZK3JzOw909El1bO9u0khfQuVwvyXqL47+W5KkrAlLQ+3oQ0jpocy0kHNWh+hJCYKemZn
 O6QTEh1sV5U4s4N6/shzbMSPgHq+3JB46xyW0CU+KLzhjYRGjGijh2md5nBcngKMXRwlsVh1y6/
 5fwStf3KS14jhiWaIbeycpk21RWT8ZjRSI3BvEvnxIQ1FsZhAf2Vx6fgtZ8SjGgSGlFks6jSCG5
 uYbQslLXbzQspXL9mNzX2ogwxffKwIkFcqzXT0N2r9QBLxapq+BZVziQwhPaWv7Ihs6tVkAUpLi
 Cjkl/Mxm0CxSgghqFy7oa1m5SFitLyLsNJGeKE09fe6AAZ/VTWxD7bBmc7Px2Fd0LeOCU2ICADC
 jpQd69iHKLpQa4hzdS95/8LYTSfHGdFLK5BvW5fqcL4lb0+Pg2f/4JTvdNHeQv+EqxISf5xJKhv
 FmSBpCn7VWPRFeOEZtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120136
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31784-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7215813007F
X-Rspamd-Action: no action



On 2/12/2026 11:06 PM, Johannes Berg wrote:
> On Thu, 2026-02-12 at 22:53 +0530, Karthikeyan Kathirvel wrote:
>> This series covers support for UHR capability and operation (11bn)
>> parsing helpers for DPS/DBE/P-EDCA, and adds mac80211 hwsim changes.
>>
>> The code changes are based on the IEEE 802.11bn Draft P802.11bn/D1.3.
>> There may be changes in the code to adopt upcoming 11bn spec changes.
> 
> Indeed. I hear Qualcomm prefers 8 bits for the NPCA primary channel
> rather than the 4 bits for the NPCA primary channel (offset) ;-)
> 
Okay, I might missed any other thread if this is discussed, let me check

> Anyway, I'm sure we'll adjust this all eventually. I just wanted to also
> say that I'll try to post the NPCA changes I made soon, where I was also
> adding NPCA to UHR capabilities in hwsim, but that doesn't really
> matter.
> 
> johannes

Sure

/KK

