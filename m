Return-Path: <linux-wireless+bounces-31544-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPQoLi5yg2mFmwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31544-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:22:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32871EA20D
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F0C83023DB8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C479D426EDE;
	Wed,  4 Feb 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ASKi093Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ow/7/ALG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED60426ED3
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222059; cv=none; b=QX33r56iTrX2t7CjOXomONA4ZanB5+FSIeyLfYda6vXT+cBZCry8KA/Lrqyf+NAxH8cjJOZd5kUMXCBimignvV1EItrUfmFtp7wahA/BFt9TggDQo9LVFWeU3+YCI1Dx94ny1GfADwqjybcSpL1qbROR9ZqiwAwcSoKmdseJSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222059; c=relaxed/simple;
	bh=u8sWi80W3AO9Hv7XEduOJE2qL2MOoLFLl1vWxLJhO2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhX45z65gZ222RkZu6DpALB1mqVd60HFHF6Mh4sEy3OFAvxB5h6Bq0sL6tXC3mn7tqMWcvlSgrJZYb9NZwIedKFjFkTkB29Jc8W/jMTe7qX54lbqjEHiDByUGNYojIfZ723rqrRGB2ZZ1zRsZNblVrXMnBgpnskR7iNynJ57/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ASKi093Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ow/7/ALG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIWkQ096203
	for <linux-wireless@vger.kernel.org>; Wed, 4 Feb 2026 16:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HOlOfyr9z+7LwrrbiWx8+S1ohIiREdLe+EgAPSCZNIk=; b=ASKi093YdU6ntubn
	UgBzRH847To08Ef0klB6UGl+vJUggziUDnjc66nxCT/apDUcOUWfcusBeO3jy96w
	5X0KM17CwTR5IY846+co0bvPcrZi6+GuCd6/YxpzpiS8Fd80bU8uBxgLPzH8mdaF
	wl9OXoh6i1+LHEvSxuugdo0B2hiPfqs+yx1ZpfSZSjwynMUhfAzTVIRxduIkU2bI
	izN2gXIP/JtHJtbfxezRMQacpA4HTBWHxcCOKKfK+Y+O163kRA0QVP8x9pX6uw06
	iJG+o+trWui/EY45JK4TXriOkNTsdGEyTW4pb3flE4np2BloL1rd8I1qcbseNSJQ
	gATVSA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c44kbh168-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 16:20:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b83787af4cso5948257eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 08:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222058; x=1770826858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOlOfyr9z+7LwrrbiWx8+S1ohIiREdLe+EgAPSCZNIk=;
        b=Ow/7/ALGG0KREa9YMtxpQhxzYHkOooucA3XuwebvAqAVrOr8YjnxyY7vEJ2gguZlHq
         8nWYN9hfm7F/dyfsJuaEH1gY0SI8d+vTwMWPy1Dzvx6g0Kmg+xYeqCq4dVCHKAIh/0Ue
         rja67cFRadgj4sk/2oTOvhFEmCaDLknCu9UzhVnSpZKwV8KEDkfT4OCujNvvMYnx5YRD
         VtAYYmktVdOL5Um3hDdxOwEIR34h8LYmZtfcHA8ovvu3QGsv2RBbBYQOQFf5bKeZQPl1
         9Oy4bcPdFny3TdRHlhuGNt8ix5988w8UEAVrDdDp+icIiIvMlI1lowDye8VYlSehLgRL
         M2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222058; x=1770826858;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOlOfyr9z+7LwrrbiWx8+S1ohIiREdLe+EgAPSCZNIk=;
        b=jSds+ZpxV36ylREEsiYkObkpCD21izybw8KRVjlMrYMKIzh+j4rOeTng0x3IQ63JYw
         q7/duE4kLxDRpTY+O9MptcbtGggtT+rI2M0gfZAnkMpX1t8WQdq8wb18UNWcf5p0gCBq
         X4gFLYevKVpE0aPHW00tYnxHyHJ2asmivuDiXfiCS4QtReLTufSa6QwphvJdZREE6/LZ
         CbCTuJ5bxDxbBNnmf7iIndOaPa8K+um2ysia+KW3zF/y2FiwoKszJJS1Imj+Ru/Ow+Pj
         GaJ1ehPGjtWfUNURGuwVxjIy3XrUaAaQr7O33cYtwUXqdMui+rXU5JAleCvW3T9gCQ2C
         Dedw==
X-Gm-Message-State: AOJu0YwYsUQh8Kem9By+9oHo1OaOBMyl2JHsCoKUBb7pz2a5Om6PxB3T
	dJOgItomWHgFCIhbwBcKcbJFszuo0D3Gg1cTrTzgkDcVoEu392Qw6M5wJRU5hti8ZTip/1EJHfx
	2SWfSpeWHsJaagQvXBk99F/8VhE+gBdVCOQ6ZhWgeQyhNC6iK/AfIPtN3r3Sw1qi/hX2tpAJHIH
	44RA==
X-Gm-Gg: AZuq6aKlUUHePDUUQw7l78A2zjO/B8vNZbUpw5oacvE+MUIBd+qk2Q1zG9qbriDgTZa
	7OovMA0gD7DIcYcXZeAxjjM/aJnHpw5LUgCPq3fmV9+KPEzMaoQ46JbWnBIopN42y1jaaf0dHAD
	eu0HY1DJBsLifCcNTxxxNw09FSqV3lx6l+lQkUAy3Hp85059KW3BaDTaK2R4Mo/dtJrP6ivLZRS
	DWxL1Te/MrcP4khAh1GHyU60BIofTzbi5VZO38Cn1lwfeaoHQJpYYgCu4Zqv9Ll1j0EwaBRc8G5
	1rlIg63HdyOeQQcUJAbVhNpUtKi1moHtDgT7YY4+UUGd8Wz5etJ/fcQJw/MOCGV+ZmHaMHRN/Zc
	xgwfOUfqPPWGKR4K7LIjbpDWZRLhxT3UBIK0mFYEmXNPK7P77Bg6hvReZHGAShdwWdiBKWg==
X-Received: by 2002:a05:7300:dc86:b0:2b7:fa47:3b37 with SMTP id 5a478bee46e88-2b832738e71mr1414609eec.0.1770222057968;
        Wed, 04 Feb 2026 08:20:57 -0800 (PST)
X-Received: by 2002:a05:7300:dc86:b0:2b7:fa47:3b37 with SMTP id 5a478bee46e88-2b832738e71mr1414601eec.0.1770222057362;
        Wed, 04 Feb 2026 08:20:57 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832fb363esm1734756eec.26.2026.02.04.08.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:20:56 -0800 (PST)
Message-ID: <9f3b472d-a8d1-4c51-9eed-6ef0ec5b28a3@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 08:20:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
To: sun jian <sun.jian.kdev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
 <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
 <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com>
 <074b66ab3d63e6640ecd6962c074702225fba19e.camel@sipsolutions.net>
 <CABFUUZFxH1noKq-=zSTrqpirJtTQ2AA6anb7Pk=BDGC3aTs+Og@mail.gmail.com>
 <a1989402f65d0a9a696eb85925db98f6b722fc11.camel@sipsolutions.net>
 <CABFUUZG2pNxwgJzw1hiCj8OL988Ed=2xBhsFuNo09rRLTUF9aw@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABFUUZG2pNxwgJzw1hiCj8OL988Ed=2xBhsFuNo09rRLTUF9aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iaZGH6NfL-FnyUhaGyeY3V5pvjAOAU3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNCBTYWx0ZWRfX2aiy+DV4hPxI
 rgfmlJE9t/Q4JlLXu+S33J5fLaq1FvdNPEmAnTL9H5v6CIHH1wU5YGgkj0OhfupQMYwBoqlzV6K
 ib76Xs3YGT3VFzdLcimMu4tSXd+Z+VGD4zq0j1ryQSoyn6916i0uBGlTv5Sdv18mY21KiSAvR1/
 tPw0Ui6W7ajrHqMLh5TIxCvY1UHpfFAX24cE9vb32Pncqwmij+87aZ7/hwbh+mqxSzVh4i7KPFn
 Ks+KYWPePtrZylJU2WFjgHtq+tpc9kXjAfCUlGnVyca2PjxKuPeuS3n1LihYAWj9ai/1F2aS0Aq
 MLYtaV0UWKPs8qQ88Fz8UZPEFfTS909vBI6FXh3NsV/+/R4jtapi/cG67R24nTcXf7sO0xgkR0B
 r4s7e+U/ZaDOOXfjtIavdU4NyssqYXiIbeZEsGuMG8SWRbhAUkmm+W5NJtGkZoUaOIryAy8/ILR
 UYReODIH6pILTNZxz8Q==
X-Proofpoint-GUID: iaZGH6NfL-FnyUhaGyeY3V5pvjAOAU3H
X-Authority-Analysis: v=2.4 cv=HN7O14tv c=1 sm=1 tr=0 ts=698371eb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=stkexhm8AAAA:8 a=TyCgi0gAG9BFsVhkn9sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040124
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31544-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 32871EA20D
X-Rspamd-Action: no action

On 2/4/2026 3:33 AM, sun jian wrote:
> On Wed, Feb 4, 2026 at 7:29 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>> On Wed, 2026-02-04 at 19:21 +0800, sun jian wrote:
>>>>
>>>> applies _only_ to signed short, not to signed char?
>>> Fair point, thanks. I'll drop this patch.
>>
>> I've thought the better way to address that warning would be to simply
>> use 'int' instead of the enum there, but I forgot where the warning even
>> appears. I don't think it's generally with gcc/clang, is it?
>>
> 
> Right, I only saw it from sparse, not from gcc/clang.
> 
> It was reported for net/wireless/nl80211.c at the checks around lines
> ~5762 and ~10539 in my tree (both are "band < 0 || band >=
> NUM_NL80211_BANDS" with band coming from nla_type()).

For future reference, if you are fixing a warning, then your commit text
should include that information. That way someone else who has that warning
can search the archives for that warning and then find your fix.

/jeff

