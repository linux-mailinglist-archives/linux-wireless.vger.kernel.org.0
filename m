Return-Path: <linux-wireless+bounces-30600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBAD08754
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 11:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06DB8301F228
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 10:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A50B359F88;
	Fri,  9 Jan 2026 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVcLWGY7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WOEmh41S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703133984D
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953010; cv=none; b=XQAM0DKQUlFyXJm+p44phTAbw/grHEEm/R6i3XFWYD+r74qjBquO5/QxF4n4fOsgvXr7oP0y+/cfMCbF7eFUZbWIGSknMclfFgZON2pMBpEXu+OlyeSPGlKZ2jNdxTtyRQL/vz80+6iGl7kAvpev80L+8TmEnwSmaxK1bk3u1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953010; c=relaxed/simple;
	bh=SoT0otAwT+o4bUjIHfy4/Lf0klcvDEYy5wqxnr0jLrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sb8gmqqiPJiJ1oTwWiBkoL9LUTg04zFHHGtzhcqIJIyJoUtfutlMmQu9DHgBIjhOvJfZvhtrD94W84V036wUPoKeuU9zHWDSNZIpiMZTV8ZvYDijKqVHTdmt7QlGsyh9t3xFO1A0BOPy/0Vt8NGXJJAgVQj4DUWnAkLefb+URYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVcLWGY7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WOEmh41S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099N9rs472846
	for <linux-wireless@vger.kernel.org>; Fri, 9 Jan 2026 10:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mh6eHLjLavcfY1L5rsNVAQLBGwPvdQNnOeKmwF7MtGk=; b=jVcLWGY7i9eo50+S
	Bk+CkeY+RxpEsPJGJwBjFGen9p67YUbt7CBfAQxQ10mUbf2lMjufD5ZzMzu7vKKC
	r0sFFx9fJ6LLFfqz1AjjkbOm3A9qzr9OSdLIZReXMsicusukjrkxLEUSO9cf+DKW
	ZNtJrlRH4McQZCKO6Eu4igHKrc0PENWXOH50qFCc9OIIOU6uHPACO5nasW6Y+fm4
	91c4QZqyi/n6lEKkYDIR3bQvSYGy46z0tnKV5qd5xigXhz/gTuligSnIdma3T2Mk
	8KV7Uu+gpSr20yi2EnkGMhiWvL2IBad0VyRLRfYlMI9SALO0TWWH7ecJMzt2eZjO
	2gKYbg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy0a04jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 10:03:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so4656414b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 02:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767953006; x=1768557806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh6eHLjLavcfY1L5rsNVAQLBGwPvdQNnOeKmwF7MtGk=;
        b=WOEmh41S6w2UdWTu+qp/3AqSih7GrOYSNX8SU2/Nn9c4JdOzad0T0vu5aq0Ml+qu3f
         7N4HCEdt7oq30iv8gHAqMUAsQk5AMwRB9wMQpmPPct70RLvA/3afYaoEi1tp8hxbf419
         2ez7Oan1YRIobp2LL3R/wKf/Qi0G6X9sVjMJGeycGF8uXRgk+/w9GtAuN9TqNY3gyvri
         OzMIvK5KXQZM7Sl/vcZjq+fM+n4vYUPOgj2VwP6D24S1Wi3k9CAQOWyxkM82MF0S7qrh
         fNC+t1N9GKqLw5VKAnlp27qzlposeD4RNfZMM8hc9vQmeSFUTIHwkm0nSwTGCUqbFg0S
         Geug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767953006; x=1768557806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh6eHLjLavcfY1L5rsNVAQLBGwPvdQNnOeKmwF7MtGk=;
        b=bpBUdoo6Q/UCUrVfgOpskD4x7pdzQrlAYeDSLCItCKLeQwR7ydfs2WBfgiuwyvN2NA
         mIObHRx+KSOoyITIEKIv/eSf+KgkxCEaDQhT4lIIp+dnoDLH6edLi9Uoc6PEMN/1AqiK
         hCU/875TK7tANljRhI7PnvIFCEh0xml203Tpn8wsNpQKa/2a/woOnO2VKVnSB9dvlz19
         f5JYu2R7ibiMujO3czb4nBLF2TQ+G9fFecvxy31IcHw4w6J/3x7AK791DhrJwRjbIvxz
         AwFRaTq1qkwROGWWQU3KIikz+Bge9lVKmKrO4xdVP2MHViFNzV8crYVjkmh1VOoPG8Wm
         0rQw==
X-Gm-Message-State: AOJu0Yw7+BUxnpsb0UQHC2ENf6v5oeiBzsVyDW8WsKz1630QYVH9C/7i
	w9THApxISONHvZxRj7uCpGe+HpdsYNLYAmRpCVTGDVExAyh0t2Q8rLKYii/HpFeDZeKlgwOaiuH
	w+KzxpkP1V6ypiRH8ZXw8niIEAH0RCKhWgNjFxSG7zLuF1yNiBi9lxxNufiu53/0blBOwBA==
X-Gm-Gg: AY/fxX41flimrQKrgHRUAgnfD6Zt9BT/6ckcppNBgguSZBOxuhjO2Qm96di5+luWhtB
	1cvxZbBpK36Nlnff8WlfeOl4brIheG7aiorPsooq9B1EQERGNCvQpsvaw91yFxbPGqfrFVaAkVP
	zhqN1k6r7j7dWGCr/IwdaeALyFV3Nfm1xQviBj2jLOlTMR51lNa50GRWzwnVHKia7OTBZwLCB8r
	khdKnNEcY7W9+tmYZWSD0wQiGbUglnSe+kizCESQNJPwOjjuxCEpPkXDIkx+4QRRxRyVaXcUHtv
	PUrHggjC2ROZbhSMVmE/9SotRlAk5JR8YtkMfeQ+NzTDEBdrZ0IBZzmb4d3NsZ3gg/GuZ5Qu4Mx
	eCpDuDx9xObdulFAGo2i6hKwjTxICFtBQXQo=
X-Received: by 2002:a05:6a00:8089:b0:81a:d633:db03 with SMTP id d2e1a72fcca58-81b7fdd5639mr7239068b3a.59.1767953006397;
        Fri, 09 Jan 2026 02:03:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOYcDm/Zir474d0fUdRLgiYxQS1AHb2Jgh22DtDwCjLPf5is+SYTInOidJQNpX14MaArVmdQ==
X-Received: by 2002:a05:6a00:8089:b0:81a:d633:db03 with SMTP id d2e1a72fcca58-81b7fdd5639mr7239045b3a.59.1767953005885;
        Fri, 09 Jan 2026 02:03:25 -0800 (PST)
Received: from [10.152.200.28] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm10214119a12.32.2026.01.09.02.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 02:03:25 -0800 (PST)
Message-ID: <0847363a-055a-4d6f-a9ac-b62f275e02ec@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 15:33:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce computation
 for management frames with MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Rohan Dutta <quic_drohan@quicinc.com>
References: <20251211123612.2470117-1-sai.magam@oss.qualcomm.com>
 <5ff51b07b69284ca9b477dfcbe08890167c7ed14.camel@sipsolutions.net>
Content-Language: en-US
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
In-Reply-To: <5ff51b07b69284ca9b477dfcbe08890167c7ed14.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3MiBTYWx0ZWRfX4gg3pZ7HLhFq
 JjCeqtuyN6dyoDg0sHkuo/lTse27RuhAa9J1+cStjOcsYtiGbP+62sldPK0fRBsiQOrxciviC9h
 5xqG91snyQX5ee4Mje8QDp3anrIBYWqJ04St8XARq+2kxp3qQafWL5S7Lp793IzSXv0Q0vSmMAF
 LopN9NX1lczTbM5Fvt0k+0D6TDX/joItef7MaHoOBQSgyhZVBXMFmpqhkEGsJ6eIYP3LHZE1ezl
 ZlpjDvpVBIVyoywUFY1eTv3kFGtwi7POhJN7ndpxqvFeVdpUHAVQ7Xr/sMqUrzrQEE2D1569lvm
 Q2eU93Fwa2iWltUJB3j9lROWbdxZlIkK3RlRnA5kP8fCXXChoAQemwL9dV0bijF/ZZ5GRgUWMJI
 /92q2Lu/wq9LN7v6wUY00AXJdL8JC/bM34mC4fdby/hbf6z/4gy3Kgf1gG8FMZBejlSEiBeR6z9
 Sf3ecHJG/RTS5VrnTUQ==
X-Proofpoint-ORIG-GUID: xr17EujFMWo6lI06nLChnJXnOfbLBpOZ
X-Proofpoint-GUID: xr17EujFMWo6lI06nLChnJXnOfbLBpOZ
X-Authority-Analysis: v=2.4 cv=QPFlhwLL c=1 sm=1 tr=0 ts=6960d26f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=c5JA_5cYqXVCETtAKpMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090072



On 1/8/2026 6:22 PM, Johannes Berg wrote:
> On Thu, 2025-12-11 at 18:06 +0530, Sai Pratyusha Magam wrote:
>> Per IEEE Std 802.11be-2024, 12.5.2.3.3, if the MPDU is an
>> individually addressed Data frame between an AP MLD and a
>> non-AP MLD associated with the AP MLD, then A1/A2/A3
>> will be MLD MAC addresses. Otherwise, Al/A2/A3 will be
>> over-the-air link MAC addresses.
>>
>> Currently, during AAD and Nonce computation for software based
>> encryption/decryption cases, mac80211 directly uses the addresses it
>> receives in the skb frame header. However, after the first
>> authentication, management frame addresses for non-AP MLD stations
>> are translated to MLD addresses from over the air link addresses in
>> software. This means that the skb header could contain translated MLD
>> addresses, which when used as is, can lead to incorrect AAD/Nonce
>> computation.
> 
> Make sense ... we translate them internally because of all the matching
> to interfaces etc.
> 
>>   net/mac80211/wpa.c | 167 +++++++++++++++++++++++++++++++++++++++++----
> 
> This seems rather complex.
> 
> I believe the translation generally happens in mac80211 itself, in
> ieee80211_prepare_and_rx_handle, couldn't we stash away the 18 bytes of
> the three addresses in struct ieee80211_rx_data and then just
> *unconditionally* use those, instead of all this conditional logic?
> 
Hi Johannes, I agree that by maintaining a local storage of the A1/A2/A3 
link addresses before mac80211 translates them to the MLD addresses 
would make things easy, i.e, they can directly be used for the 
computations in the SW crypto. While this works well for the receive 
path, on the Transmit path, mac80211 would still receive management 
frames from hostapd with the MLD addresses, which again cannot be used
directly for the AAD/Nonce computations.

> I can see the value in putting something only into the SW crypto so it
> doesn't affect anything else, but also the address rewriting that
> happens is pretty rare, so maybe that means we also have a flag there if
> using the original 18 bytes is needed or not, but that should all still
> be far less complex?
> 
> johannes


