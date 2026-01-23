Return-Path: <linux-wireless+bounces-31126-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB24II6yc2liyAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31126-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 18:40:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36114791DD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 18:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17ED5302C315
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577027EFEE;
	Fri, 23 Jan 2026 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYQgRrRs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TX8dTbFs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2A13D503
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189976; cv=none; b=Dy6spHvhePD7MkI7IPwA4byBVx2Lfjz44fxoXwSQTCMqsZ9sRmfgAvzsC3KUUGXWRvwvSN3D/ew/aUgfCByXD0Icrj0e0NlXjRUsMkRUpAmw3e1GesWl9Nz33fVG2ap0Lxw8q8erm8UKMVdmX8ZH9u/Taq4AOfCuJY/KAd6Yewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189976; c=relaxed/simple;
	bh=CtpBtEO531brHlTMl63p6vtgngWpWBQuxL3UXW1xcho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlzF3tTqkG5i7SUbxrBEC2GTONKmXhqFBdQE7ZRjWLA1rzWaDGvPvjP4hSRsdS9DkPkqpqADpZdot+fmDyxPw3Dteog90g/IeITN5cqfckDHYBfRBTza4olRmq3ZwO60Tun5AdeItkoSuLJvspfL+6zty2azeGGRVPszJLvOB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYQgRrRs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TX8dTbFs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NDB4Yc1325104
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 17:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8ByX8t5DOEZeBqvSgYjGH9zeJDq9CCU8Sa/IMepH+e4=; b=KYQgRrRsaNdqZnKo
	9ApFejkSKbbaSx5mMtG5DXqBXlVtGvobuFgRAItmo0XL5zaksRWsUJz3mErPPwKN
	Ay71B0JRifpde4lt4DFdsWN/0qJILh2xZwedO1YwOlm81MVlCd1mnNxecyok7rw6
	t4LNA1AxMEUoqk7TN2DlNQNoONXYAqaFa59/8yC8j3dSgecDYSfasQ5a/IdA5W7S
	jCOGWZmSOuyCVsd0dD1CIIZtvbugPUAnNhk0a/sKCQjgVEcPHtsY4eX8U7+VVw1L
	K7G0qScAfFKQHta4kPqAZfxUoRQhHfH4P8nesmPLxDNlNGQnRGerh7lF7L+VN2fu
	U7VyPg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv44ca7d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 17:39:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b74aff34efso1228254eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769189973; x=1769794773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ByX8t5DOEZeBqvSgYjGH9zeJDq9CCU8Sa/IMepH+e4=;
        b=TX8dTbFsCFrgA25O2iX9Fc988D9DKftMd9LcdFS9FKWeoo6RNlJ/Sa77YrWomM34sF
         3Wdba5jmCEERtyVWDVGTm1l1w2Cjc7nJzMgdKKHdStj6YgOGmILDB8Z15odJIROrfsEC
         mpvyko9YpO3g2fKJNw4wLOOcibcnDNrwxVzmGeSj9GniTC+oU3QIEbjLDgGqOSMewouJ
         DByiwTX2w/tMMaLGfGRvFq55IBKP9kmL8Nu2ZQIEYQ3B83o1PTIgVfP+oOxQnX1MXyuH
         VigwvFbDkRbbxyhbMMxbTR5oBu+Djc08zlpX3SNxYA3j4zKEyFbvViJTiCtIP01LExSl
         FIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189973; x=1769794773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ByX8t5DOEZeBqvSgYjGH9zeJDq9CCU8Sa/IMepH+e4=;
        b=m01mPtgJj+PjTGTqf48+0y2j3VMKkhKnjtUs4t0zCgnbE0He/OPgTDuSdKGdQkPBgB
         oyqh8ytsP9wyKJG7McOBWQWUXSjhrex2BEcnp8CYdQEeooyEmzYYUrgPq/yE1P9Qn2cn
         nblBaC68tYNZWbjVfwasXHhrg+yagLpzZlmhuIp4gsadhwL4prT2OsuVsJJIS7G2qDpv
         gs//qpWvsvW9vmC8C8A8IuiYLJMEsGMOEg8JNFSFk3dXNqspsbVgoT4pJD3PQihfwZe7
         OHmNYKIyjDWm9UHDvBidi3quEHjdCSZQKptmIv1G6jJ2qkAdv0IVCkHENw1/AzmvXR6V
         KczA==
X-Forwarded-Encrypted: i=1; AJvYcCUpmxJPzIPHbYgsl1aIgwp73Ck5bKjrRVu6n6NlpOZmreowdMnwZmJKHn6xgNAte7W7g+e+L9u1KDgtn8QwaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpzgn5mexzXZM0kHYz5SzMjruO4qhCVB67rH4DCzXKeGt6D8J
	NUCwbGQ3uDDMP+ZRXPkuLkjMgq0x7Phr58NFUv5iUV8zE9QENN6E8Xr/Ua+yxG0Uj9Z91RVg6i+
	nVYoCLLgn0zau6hioiOJhmPWRnxhJLsa1CU9cDYd7d7GetCxYGVzsDiFDpc7abFfJ9+vjgw==
X-Gm-Gg: AZuq6aIG5JR3tv31cpg/xXSGz2OhAFyAM/sxn0Vz4uBk4qGGZlW9Ws0X8EhPZ6m/Hn9
	Z1bLPsadcS9PrK9xutKhlGwEd8ab4/kNR7JK8ZmL2NIg7i11Yw7c3Xnkp58TRexaUft5PKoT+2f
	wA9dthn/bnSOmEmrphSy9GLF7HgzYY9r1ygYkiPpwtl+isnIgXsZDmq62I886wo7dvmMs/V7efm
	DYEZ1gkUGg3xm9hrvZeUjUZzVoS4jV7QmYyai4EvXnCleg34CcRYkO1NaLZ73gmahXpm5Kl5vcC
	S3eP9+pqu5Ar+6tArYGK8Sy0ACbnln/jDM1eVlvxvWEWpyZhCwE/U8YWfpPEPzI8H7gIq/mw2fy
	GNslxNXXZvcvpgqeA9iIcGTFIWi3ozlGohZ/+gIgzHLgRm9b+DygseSztf8nhMyY3eR/Fxq+nht
	Nw
X-Received: by 2002:a05:7301:1697:b0:2ac:14e1:c67f with SMTP id 5a478bee46e88-2b739998979mr1464278eec.10.1769189973089;
        Fri, 23 Jan 2026 09:39:33 -0800 (PST)
X-Received: by 2002:a05:7301:1697:b0:2ac:14e1:c67f with SMTP id 5a478bee46e88-2b739998979mr1464263eec.10.1769189972427;
        Fri, 23 Jan 2026 09:39:32 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa03ecasm3765297eec.27.2026.01.23.09.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 09:39:31 -0800 (PST)
Message-ID: <59dcb7dd-11fe-445f-a5af-6d46768203ce@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 09:39:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: fix lock protection in
 ath10k_wmi_event_peer_sta_ps_state_chg()
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260123160244.262225-1-n7l8m4@u.northwestern.edu>
 <d42a139e-7e8c-4516-ae4f-5da419a3191e@oss.qualcomm.com>
 <CAMFT1=b1fCiXFbMpo6+LJzbFkbLBWevcwiP=EP+hWX1FbRAEng@mail.gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <CAMFT1=b1fCiXFbMpo6+LJzbFkbLBWevcwiP=EP+hWX1FbRAEng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TLdIilla c=1 sm=1 tr=0 ts=6973b255 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=h4soWA5Jhnv_6aMFX8gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Cr3pM4QKBJ0A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: kA5x0wW93EaSwxONpLqeQ7ikMgGmyNoT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMiBTYWx0ZWRfXw3D3rAFOAwXp
 PUR83jXc42zMJB25kSTGqVWkVxFa1C3Ott0qfP2GsUp24IIHIOZcujtrLTcm1rmJdHeHNQn08CB
 28g0T20KshA1mB7njvwJI/tIPh2sWqIT9DioLLdLbJZKQ67B7PRxQfO3WP/VD3ezPDldz5Elkvc
 itzZ3kLYPWbvcJSW37pJbK/kYWmDYaNQrEsQrqsCUsmcNDM/Y6yaRWkKt1J3vhn1WixQ3C9StZ/
 wg890F6HfHNsr0KOnS6mn9mk9qSl9OUSj5HDGQmOeLLg5FlP27H3DprmBZPyR3IXJaZ3+J0Xql9
 q7uaypJqsOr7kIQ+QCQnzBSMPepxMw2rDj+yk/DExn5s/04r9GS0zZkKRJVCthwwFXqu1AD1v+7
 ie5StwdRDubxFuJ49AkzI2m1x51BBWXq8UbSXVlJnUwcfKwIikk3Y4t4RPC71cFOAyj7P8oTaDA
 NupNhL0gxOMsOAsoQWA==
X-Proofpoint-ORIG-GUID: kA5x0wW93EaSwxONpLqeQ7ikMgGmyNoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230132
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31126-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36114791DD
X-Rspamd-Action: no action

On 1/23/2026 9:34 AM, Ziyi Guo wrote:
> Hi Jeff, 
> 
> Thanks for the review. I will adopt the second approach: remove the |
> lockdep_assert_held()| and add the |spin_lock_bh()| protection.
> 
> I will send a v2 patch shortly. 
> 
> Best regards, 
> Ziyi

Please follow linux kernel e-mail etiquette:
Don't top post
Don't send HTML e-mail.

https://subspace.kernel.org/etiquette.html


