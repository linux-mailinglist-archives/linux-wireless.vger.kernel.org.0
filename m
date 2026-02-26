Return-Path: <linux-wireless+bounces-32208-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOIECeZToGlLiQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32208-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 15:08:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5BA1A73AE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 15:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56461300DD76
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414802DC34E;
	Thu, 26 Feb 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g/bQJ0Db";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CN3CaPDU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16133372D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114879; cv=none; b=H1PhJLDL/kuWXNYrJLQXzbNYRAmzC/Tpww6hMDGiX/P0b9RCZT98hG9qA9/zM421prhuZQnyQXfkHpkgS/swwZDoupRM2Q0xYWN9anLEcgxtCT+OuYj6/Ru8Lanmvkxngw8ayRb6Qgi3CZlg7LcEAwyn9ZM92QNIVRxmV/E2uAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114879; c=relaxed/simple;
	bh=ukCYLY1Zbdotym/2vy6uK4JJQ3XXD1O4cE1lqPWEsG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtR4MBQhRL7PCtS7qQejUcn8iKupzbOTL7xdUFPNxkfSLZVbkNHq/eDoy9tJ03riaGnsvpFXmkjgTT3SZTqiwazP6FdF71gr9XRpn2E1bO/iswcjw1DzB88YJwSUy+jMs1G3CVoXsGxRCRdeqvaEQ710qDrjpNDWLJF6Nss2YbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g/bQJ0Db; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CN3CaPDU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAKiW52376130
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 14:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4x0BYFmBYWIafzGmwNj4Xnk6/ICEnpGEN+n3/x7bkmY=; b=g/bQJ0DbU++ing1S
	GUT/jq8Dr5DwWDLJ8NfqFXaC76LMDsUI/vMBSU21zwa56N5nVomwWN9NZM7KxP+C
	cqvq/5Ee5JY3vwlVzxkzMaQ1FTnpIKJTVAsfcZv6RAwhhHhzoeocmLGoiPN49Hxr
	2XowEpCpu3FyzQFQH9U5LCtMyShhg9qWRtTg/pKC8sKXXYrG6H5tlXLYxmF83kiV
	E8QvM0HhyNO1Fhe+tm0RfzXk15QtOTMPTNBcxtdq9qjxeMCGCO/lmkTq+qbi6elT
	0Zawpme1rlkxQj5GOqX8LDbJj50wPm7Z3fc8t6AFvGYesOFvNAB2HS6TMvRk15pc
	JYNbgg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjm8d8n2f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 14:07:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-824b5637daaso417673b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772114872; x=1772719672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4x0BYFmBYWIafzGmwNj4Xnk6/ICEnpGEN+n3/x7bkmY=;
        b=CN3CaPDUL5g1jDzt3hbI2BkTNzry5zqDzhDCs1pKbjprKL6+q2iy7x86ckj/5IQSeI
         LlB1kUf72cP4KzcQeh7g/KVGXefCTvn+DtNGoJk/HxVVc1pU7XJwrRsRzMf9jhDNeNzv
         Tj08z+FqvP0699aIzZC27lkuc4I39AlN+CACyYTHu+WJURmu0MRgTwCDVsO7caIStcXo
         JJYaNs3iesds8CaMI5A6kRAAAGHwm8kE5G/Msq+Y3EAgBkEslXjO/6i3XAlezSgTO+HR
         ycy+/ASp3+zgM4thLCFUD768weQr/uBbKZPh8v6Tr/rhbF2i0w2mkvav22qO799FDmqn
         aLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114872; x=1772719672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4x0BYFmBYWIafzGmwNj4Xnk6/ICEnpGEN+n3/x7bkmY=;
        b=qcaF54H9iXUumS0YR8SpLAuwyxZfccIfieoRY1iDXkhHo6+qhlJUhgcgCR0TAQuzl8
         wCDF8Wp0g9fZl01IPfXkdnxVqP1YtSZUD1IFlueA079PJOlgn8wkGh+Hc1ObzJZftlML
         /CaYu1OAOpyLLbGTOMMqoNwJXOwjSceHl7Ut4q7J274Fj7kQREhtFKWJPMhEY07vYsOa
         gOrfSHInKTg4I/CVglHSP/D3E/GyG9hxKPzX6BYcFJyrpnhSqiBn1KpD41gh3F4bPHtx
         Ol/ZwemqnV3Fmm381mK2PNTBSPE9+hBxxVoCjyNmdcdO9ylNyKWEPxnYJtbip+a3ZCJ7
         hX7w==
X-Gm-Message-State: AOJu0YxU9cxe4dWEaE2kstIJeQGdl8LUzqqIcwBIGhnczn0bSIgi+pL8
	0DfZSHfZiOkVaVnjLPL+OSqV3Rrf4CLmyeTY/hKXrMoLrw3FMAfGH+fFfhJV0nGZvMC2MXwO83p
	H+VjaTWLGw/iPwV3WkmbkuLkCy74p+qr4c/LwGhBby9WqiOq9AGElNowwlWf5dSiVWu0IXScm5y
	4ipA==
X-Gm-Gg: ATEYQzxvxqvkCMnNWbeNTFEC6937syKiTj95i3lh7rrUzsa9GT4stvz4y+Tp/yz7E9q
	R125VhLGOjF5IJpyXWUzf6GqHFL80w6MntnwPZ1UB7VfMybmpA8vFUJu9ob51o4iDte0LcQhb6N
	fXL/u9EpNrounQxJbbyFk5kXfIkdu10bSOgGnCURCQ2DqF6i1SUc/ZqSXVdFjVtm6Hv+zeRVMRN
	BqyIU6on7CRFPwyNvKxKN+JR3LiZWv5Eevf/qWfHB1jN9TX/N6kTr1fC989g4nDHBiQ84UkWQQ5
	0WEQ9uAZp2dUbUi1FCS+tuTh6QQCGdpZvAoS81D+gMmjgJta8ZrroWhHMfrJymc6wCfu5Eo3ret
	6jaK5eqUIegbiRNg09/SsPhtRTD2WP8y6dH1U9OxWuBKt5RgCanQjBQE=
X-Received: by 2002:a05:6a00:a25c:b0:81f:4566:ccde with SMTP id d2e1a72fcca58-8273bcf10demr2391633b3a.20.1772114872385;
        Thu, 26 Feb 2026 06:07:52 -0800 (PST)
X-Received: by 2002:a05:6a00:a25c:b0:81f:4566:ccde with SMTP id d2e1a72fcca58-8273bcf10demr2391602b3a.20.1772114871839;
        Thu, 26 Feb 2026 06:07:51 -0800 (PST)
Received: from [192.168.1.10] ([122.177.243.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a9dasm2564535b3a.49.2026.02.26.06.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:07:51 -0800 (PST)
Message-ID: <38f9ddda-1305-4159-9f8b-3b558052e1ef@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 19:37:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: Advertise support
 for IEEE 802.1X authentication protocol
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
 <20260226065442.4182232-4-kavita.kavita@oss.qualcomm.com>
 <3ecb3d440ed3ab4fe4cd3765e0c8457ef58fd6b6.camel@sipsolutions.net>
 <af15a01f-93eb-4c0f-b13d-8cea41f82703@oss.qualcomm.com>
 <e96a1d08ab71bb75bd7a65278b04d29c609904bf.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <e96a1d08ab71bb75bd7a65278b04d29c609904bf.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QMtlhwLL c=1 sm=1 tr=0 ts=69a053b9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=RvLD6kXmVJWkDpkbezg6lg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=JDhulJ6o1SQiRcSVaV0A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 1ocwr0MhiVETxe1qgGnusK8diCHfNOkH
X-Proofpoint-ORIG-GUID: 1ocwr0MhiVETxe1qgGnusK8diCHfNOkH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyNyBTYWx0ZWRfXw60FpS/GKGlr
 SYuek15nQhn97/ArEX4dPlBPw5U0KjsJ0IxZ7zoa03v1Jo6UyD4ljs/EmgGSKR2Hy6iZYeOQu+3
 cnFWRLMyDMDW1acK5i/LPyA8LRNGcIvFicpmH0pQ4Xm4DgC/jDuIs4lrx71k7J8AJlqLQE8Oa03
 p/3KVnSVgXDNE0qSH02Ab/0cUjx+mSyUTC/NbwebO4QL8NVSVFDHmiWwHvIJZblFOaQJwmOrYNV
 JhPJhUIgEVuiQn0gNhj7XCYpSsNoH5mrEXwj1OcpUHMVX0uqevuqk5zix0kPTMetiaGKOeXcgLk
 7mWG0oYch7/+NSVkRmojyz7XOI5SmO1RMb+DJ/CaR3g23oAVtZsq8g4mxHCjT+o3iijYzlyf5R2
 EKh9kaNsipFdpnDW6FJJcX1s5eNz0xOgoscrXoXQ6O9Ggx+cm5hdQnZrXNtxHe39WPJxXhlAnL4
 iC1ixzuDtch5C2OMahQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260127
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
	TAGGED_FROM(0.00)[bounces-32208-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8D5BA1A73AE
X-Rspamd-Action: no action



On 2/26/2026 7:23 PM, Johannes Berg wrote:
> On Thu, 2026-02-26 at 19:20 +0530, Kavita Kavita wrote:
>>
>> On 2/26/2026 2:06 PM, Johannes Berg wrote:
>>> On Thu, 2026-02-26 at 12:24 +0530, Kavita Kavita wrote:
>>>> Advertise support for the IEEE 802.1X authentication protocol in
>>>> mac80211_hwsim to enable testing scenarios.
>>>
>>> Do we even need this in drivers vs. mac80211 just setting it?
>>>
>>> All the code for it is in mac80211, so it shouldn't matter?
>>>
>>> I'd actually argue NL80211_EXT_FEATURE_EPPKE is the same, mac80211
>>> should set it instead of the driver (I didn't merge [1] yet anyway) and
>>> only NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION should be in the driver?
>>
>>
>> For (Re)Association frame encryption, additional changes are required in the
>> driver and firmware. Because of this dependency, we initially thought it was
>> best to let the driver set the EPPKE and IEEE 802.1X Authentication feature
>> flags as well.
>> However, since no lower-layer changes are actually needed for EPPKE and
>> IEEE 802.1X Authentication, these can safely be advertised directly in mac80211.
>> The driver should only set the (Re)Association frame encryption feature flag,
>> and mac80211 can then conditionally enable the EPPKE and IEEE 802.1X Authentication
>> feature flags based on that indication. 
>>
>> I will send the updated patch set with these changes. Thank you.
> 
> Right, works for me. Can you please also resend the hwsim patch for
> EPPKE/assoc frame encryption then, that I linked to earlier? Feel free
> to just put it into this patchset (instead of this one) of course.
> 
> I'm planning to apply the AAD/nonce fix soon, and then this can go in.


Sure, I will resend the hwsim patch for EPPKE/Assoc and will include it in the next
patchset version. Thank you.


> 
> johannes


