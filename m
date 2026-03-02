Return-Path: <linux-wireless+bounces-32352-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADciH6CypWlMEgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32352-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:54:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79981DC35E
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D299303F564
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20BC4014B8;
	Mon,  2 Mar 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgBPwB/e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gnWDhQWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F163FFAD4
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466672; cv=none; b=R3K+YhlBrmWEL3T/aMvtjoXUZJRDfwTk1NZfRC7uQ+v5+8IDtgBv6+65MrLNZVB+LtQT9fq+jGwIMuzIXn5IiexT5OMmAYGUISapEIEuotra6zWz0dzJZyryV+ZsMIigWTIM4gqZf+/KpOSeDINTqWp+jcmmvfyFmu94y/rK5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466672; c=relaxed/simple;
	bh=Sb5NSbe9+T078QRY7tc+3y5HSnIctZNuZ8ACjcbAgEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TnMMwp9Wa9VoofqvHsy7dHJWbbk/ty+FbcDTUdp+anLH4ljZ7yAaYwU2yDQAGQpNgYzn8sAWKdHtX2pRYCQE58MpxDsHoydmt0CWzswfEAMRJMCfv2lED7CzesZvR03de34esuJZBga1Teqwby/qIMNA2H/Jej6jRL2MYTBan6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgBPwB/e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gnWDhQWJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622B4Mcd3561527
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 15:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7521JNbtXxnR4PxW9aWNTwPl9ez2aDMCtwOtYha4n6M=; b=hgBPwB/eCfeI6Rgf
	RxZ6OIlj4MoaukoMNbmc17YLoDDjHkWYmfD7XF+EvBSuBAMBx+rHNvW5xPtvJ/AQ
	8k2W2GRHwAI9i67ho1b5DTfQQkA2wlkS8Mz2Pkfjw6MIJIL8e5ZVlyKR6j2tC9cv
	w1ai2fe1b+sbbTjSbNEKZFmC4R6Imn9kAKyHoxrnDVUoINcSPyTJuoLePsMRPr/8
	WDdkf+810dVvFt0k+J6SybUlvHz3qE36zrrCk6fhNe6EWI5gka5mkAON8l3S0hlP
	fNTvstAWUfRGTL2dHoJUDHi61ypQ3vsfW9CZ1uh+2CFBiqRPN/D2QxccDyOPvurr
	RAwzGA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn9bv8xpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 15:51:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae405e95f5so20397495ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772466668; x=1773071468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7521JNbtXxnR4PxW9aWNTwPl9ez2aDMCtwOtYha4n6M=;
        b=gnWDhQWJPEXJvsK68QIbEtqU3u8UaDOs5U6HZnk721AkhFzj/Ay98ZoplLV0k5tjRr
         kYDIdbr202c7+wzyCq1Z3nOZhJYk02OefkSXUVBT7uJ+LMfSV/Fsi7/I9BwZ+g4JLmJq
         NrYMWfDI1c73dyQL1fslKFWqMdjAY/gVa9ZBpNgIdXRJALpSBbvJoF5J+8aG0NmR/GbV
         NNCFFJi9Lgc3WxXW4MyRgbt4O87SZ9o7nd5hIywZKjPR9egGacJ9sYP4J4RCitbCJjkp
         Ep+nzvYuB8H/NyDYVj51Wy1TfuTlCZFX2c3brNnMbW6mxPrst5EkGgvU2TAcVCvjcgf8
         0gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466668; x=1773071468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7521JNbtXxnR4PxW9aWNTwPl9ez2aDMCtwOtYha4n6M=;
        b=hO1xvkfiy0rsC51dQB+Fz+Zf60GOYBYqJcl0qbYNj2Zz6xRODPS02QKggULeIM5Ryb
         66atoZLXHf48laZbkQ0PGADxrpu9EaBhD0yYzB6ERG5ni87kt6ofAEvuPdeh4vtXZUvF
         pmSAOXTd3Ow8ZDGAd8bXOH3aApmj2fQhzq2w8QqB5pmwg6yyaUCjRlgICHugHZOBnIty
         16kFLuLoiaCjKfjgPauAX5gT8S/bJ8q3WsShHXuhJKJcQc6xHuaB//otcTZa4JJADqqb
         PuRd7tNwN9jrpdkpGmsLDm3u+0bhcPHLV7U+6Vph9Xuio9bwsHnuWWk7kZEQoBUu9F/R
         c6LA==
X-Forwarded-Encrypted: i=1; AJvYcCUl4QCK1dRdUmme0B2pztaE/czCdiShvYAWn0MW+x92CWPAtmrv3BsdqqxkloE/Ay3zIKWyqvUyhKe7ZPLTfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywUwutHnhycixHDxkbdMnm+KR1i8+A9NSdc6D7vVAZaphIDyLV
	fmtgXTsdh8xugg17lTUyXB+5gEawC3/agU1lXcjlkp/mD50O86+O1AbMJ4NbnXVY8pdiSLeG7pz
	D/1/QJ64WUCa5q5ZXxgX4EMGiCiVurxQKjdvcGitCvzMdeuuoFYyVAIC2e/fg+77Xyp/Tng==
X-Gm-Gg: ATEYQzz98gSaiVxRBsf8aj1MUCEe8x1vj4MfvfKoC60sz/70lmdtY32h5up7Qbt1mqA
	iTzlJ/nqS+Bwa4F+ZGtix7GJmkKuiSz9Ij9XX9xDUic8pg8KltkMHXRolK5O4YPjOq8fUUA0I7W
	xgdfrv9xJKflG0sOW68s9zFEV/8vAFgU2J5JEahUlN71T5Sl6TIXcH6xF2U2+tv8QTfBsOmAtT6
	LJhJ6zC7wBxhxmRPN4gf/onk0ojg78lZeUiPwZecoW4AIEcmSyz1L6ZbN30IOmYBEkfskCZCW9p
	SunUHE6+RYEZgEyKjkENBOvKHcx4KIi2adFiDy2T8tZuuW9lnyaRRkXhQj2NU8NTdjgp+9beZ19
	TMmKmUJmhZ4liCKKXcQFs/f2MF9j/+iaxgDEBQH1ZeMOhSn57Rr3WA/E=
X-Received: by 2002:a17:90b:3dc8:b0:359:8727:6448 with SMTP id 98e67ed59e1d1-3598727677amr6511918a91.17.1772466667897;
        Mon, 02 Mar 2026 07:51:07 -0800 (PST)
X-Received: by 2002:a17:90b:3dc8:b0:359:8727:6448 with SMTP id 98e67ed59e1d1-3598727677amr6511903a91.17.1772466667361;
        Mon, 02 Mar 2026 07:51:07 -0800 (PST)
Received: from [192.168.1.10] ([122.177.247.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359956d8e57sm1858541a91.10.2026.03.02.07.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:51:07 -0800 (PST)
Message-ID: <21ddfbcc-8f6c-4849-b50e-9028ff0d0a41@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 21:21:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: give the AP more time for
 EPPKE as well
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260128132414.881741-2-johannes@sipsolutions.net>
 <49b8b784373eb57ea89d83e9a9a3893f0312744a.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <49b8b784373eb57ea89d83e9a9a3893f0312744a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: d5Zz7amTEmWmmk_lggxby6Cp07rZNENY
X-Authority-Analysis: v=2.4 cv=S83UAYsP c=1 sm=1 tr=0 ts=69a5b1ec cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=gjzu+g+CfzGJ69+jdWEhCQ==:17
 a=WXBG309AbXYdgB-C:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=dUK3EDJeRR1-ExoOXcEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: d5Zz7amTEmWmmk_lggxby6Cp07rZNENY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX0MPvJb4Alyia
 5dpq8bf1izcHRX7IUS2RNp5ENZz12R22T36LAnD3zcOWofHK1VPM3n0j2UsRWjrnCR8p38IYmJk
 LrWZ/OKi1GHHRMDOimpA75DwMG9X4VCPk38NBA9IYaPa52kFzc3j6qEp47t63WSPUzFYXWjiNk/
 rZSmvEiAgFmHird5g7waqDyoxCqygYGLJ5N16OVMnZL2NyXt+Q6L0y69u9O++sM+6bRDfXrNUk7
 Dbh+a/CcasVoWEA9WPkgDJDXlAw9mwaMu882Qkel0blRfig20K73P+ftCRV9RLmVR5AC9kCap0z
 7KpE5iIt7nqzl4V09miPc05sPGuku25BYD0K8G55AV1HTnEq1a52gqxgLlK+IC/ae2RiopGz0BZ
 /EFoF98FYKroVKXv8+516s7fgRUyeSMpe1YEolv1xCm16/LYUczc47ZAuSoA+6xVNzZf1qOKD+2
 /ACi0lJ+vEsAk16hQag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020133
X-Rspamd-Queue-Id: E79981DC35E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32352-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,intel.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 3/2/2026 12:48 PM, Johannes Berg wrote:
> On Wed, 2026-01-28 at 14:24 +0100, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> EPPKE authentication can use SAE (via PASN), so give the
>> AP more time to respond to EPPKE case just like for SAE.
> 
> Any comments on this from AP folks?
> 
> Are we expecting APs that supported EPPKE to be much faster? It seems
> unlikely to me?
> 


The AP team doesn't have any issues with this patch.
As per the specification, using the SAE timeout here is appropriate for EPPKE.
Thank you.


> johannes


