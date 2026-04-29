Return-Path: <linux-wireless+bounces-35636-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ9vLXQS8mningEAu9opvQ
	(envelope-from <linux-wireless+bounces-35636-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:15:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26E49577B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16FC63047418
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987EB3FAE14;
	Wed, 29 Apr 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JgZmM9U9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D5bwTm2t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA529346F
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471792; cv=none; b=ScbPkr2yf67TiKiOlKdM2aLSv34yvNox5bddeHvw70L1LFhiAgQTNVVYt2LWv75OqSwZbWvGNZKRvipXoFoIBnqQXwhbBtecHNRam83jC8Zlf9hlKieoII+kSGOTNT5AFKfBhFoIcGyk8PcEa6Zq/xXzviNyWDB1peNcjj5sQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471792; c=relaxed/simple;
	bh=rlBEJqKNyuPquMgcrGD8UP2yC0h2pPL+aE4YXiUth9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=As7njKGZTpjZN8oqAvrObW9eCi0dtgsgxYspob8Pno5Lsnb1vtm+A+wGLMlL6AvYeC8tbBc7a66UcOfHtO2z6YYyX2lbyJlXWvYElvtFjx0W/1VMNPYuKHTjdznj86/R2vT5ZpteoX8pz3wPHTig0VEpXw4PPgzQ3ndiIMcX/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JgZmM9U9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D5bwTm2t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q7k41721227
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ao2CpI2lJEtQ46hy1HjSJpZTDoSBpZQJq0gr7WE7O2s=; b=JgZmM9U9b/1onUfp
	L5F+KQ8a62d3JKiVa2joS7FTUJN3e/b3tkLPfisbdKMxc4L0StPP2mKJggXexW8B
	/olvMihKmP6u9rTMfsPLV+xNHsvj+aytMW0CEGiNJl1JBC/ibYvUj+TTTsjeeR90
	yNSftyKx3TqtX5Z4H3l0QK4f6pytNj1uH2Qg42IObSoImfZ1afo2oDmv/qC00Eaz
	M3nVp/yYcZBQRQIdNDUyk95uBrjDE4o4U3Pl7UrzIJRBlg9acLif5On4aOhOldhW
	y5r4nusp6wKNCStLBwj3a+pqTNm4+O57s99elqxwib0TvWXBDyi9w9MqZmjKan5d
	C6LxEQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dua732bxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:09:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so6480568b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471790; x=1778076590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ao2CpI2lJEtQ46hy1HjSJpZTDoSBpZQJq0gr7WE7O2s=;
        b=D5bwTm2txbX/VTqkuaAU0b8ozJtgiFucx68unXCIFkuxIYiR3sb43VvALwwFYU+FzO
         xAV3tJ+GTfwWdP5WTP0W98crBz/ELoA9VI9ugpmxnIxSAdKAA88bhzZaT7XZTRkFrgVI
         H9wj3o6oWvqn48W+vTKr2FJKRGmfqIr42hLusgO5YLTuCkFaBEwB2tgaWYk0yWGcGi5O
         3hoNCQFgIVuuKLHh0T7/D0onUCsA8pSFnK/gctcla38L8ntk/2zsFMBSxrOw5Q8BXhsp
         OSUQoMtZihCTgwCZ/8S4VgWWAzgcjXXjur2FowTvZvzyhdOG2lXp4DmmMWlxI7j9Fqj1
         98lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471790; x=1778076590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ao2CpI2lJEtQ46hy1HjSJpZTDoSBpZQJq0gr7WE7O2s=;
        b=dJsu0Bi8+veSIscavGJruunVM+TaAm6j/4SjupockcMBWcAyvtfRdBg3DYUSxyufyO
         FvkA6QyypYT2OWeP7Y7QWsDgOKW3Klz3dAqxMSbwNe1jRWRaNjozBBemWxyhySh5QB7W
         EDNfzjb6CSwmZjXrWB4QWcKJWGbPl9P2R7W+g7sBqMjYhvZ5Tm1F7LEOOgScdq4LogIr
         o1ZlZW4aJ8MipldeD0GiKBgN75pvYei/w2PT0B7SpHmdAQvtuQX50fh65UsX8UxuvZQQ
         ITQ2ZGYAjzSGjPil88gY8rIecM5LqpqLxqG+HE/+reuejAEmWwjO4Z4E2rCt1TRv9HG8
         slEw==
X-Gm-Message-State: AOJu0YxHqZ8xzxFuEkkOfi2s+1Sw2IQw6m4uZjQy+WeLwvJl9M/58NdK
	XgqLGc9ElLMq4fyPEHGBg+KX05ZRzSuKPoqz4d88hJ/VhZoIueAmdinEUiowRlIadLJfN5ktSsq
	XfWlRYweYV4jPdfC+tzVrnSmgS5Y97GTa8CoMWyJbdL+jchKWeBMzR3tWlPIjc3k5bEGSOLkmPg
	3KFA==
X-Gm-Gg: AeBDievIOSEaV6JbkK3kCZd04nlOIX4o18SOue2T3yIAOsd/3UZRYeVqLi/+v6QvyMa
	xmiLT6trq0/gXbUAkYwDqtFs81+Jb1GF9t19vst3MSclpKl2vQw50zRvgWVOZ2d3nSJHXGMxYJo
	73bG2PQh3cz2Y0rwptdsjQmwNm+GnmV6VKNbeT/OVg2cFSVXppMvldXMdw86lNslpxL5Qh/Ah4p
	DhsgJn2dMRQ4jm/pViaIsW/AbXQwHZYxiSoO+c5Eq+qdZHiC/b+yGe//JDVlc2XsJzoBxfxzcUg
	j6nFXKw8kz8ZHocnLppFN6VXwEX0PgZID8+nfP7wNLrzbSC2axKpFgaCmEmR3t38lbGCmy7m51o
	syqeAuxe5bOJgVL7RTD2PtEULUuJnlYUJRXvsUZpuLOMbqz/Ueo9my9qMvwLh74vFJuDn69nQ0Q
	==
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8629972b3a.29.1777471789933;
        Wed, 29 Apr 2026 07:09:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8629934b3a.29.1777471789362;
        Wed, 29 Apr 2026 07:09:49 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.223.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd407sm2212442b3a.13.2026.04.29.07.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 07:09:48 -0700 (PDT)
Message-ID: <1d06b2a3-66d8-4c27-b965-6c21f80b7539@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 19:39:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix ADDBA request rejection
 after MLD link removal
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hnaraaya@qti.qualcomm.com>
References: <20260415-addba-req-v1-1-6eb9a33d8ca6@oss.qualcomm.com>
 <1f57207139c3fb955459425deda4d06c374ae212.camel@sipsolutions.net>
Content-Language: en-US
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <1f57207139c3fb955459425deda4d06c374ae212.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XtvK/1F9 c=1 sm=1 tr=0 ts=69f2112e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fCcjYtuGweh8oyheFmjXfw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0ld2DFB2u2Pi5bvJUX4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX6m/SLFaEM11W
 0Y/Z1UeRYsRgNUmHmdy51gTBkWl74stU5FGwIBfoPFzEndeth/IDh5HupDkcixpVpRp6dG+xjh6
 KmuZvKSVBXfiinTlXN9+AVwjw1mRVeCWhVCEqarROM9bTs0PK5IXQsWrCrEEn2JxgqjYq/YloME
 NVPt5+mctEjkbSU092jFVr9jxrgpOgiD5Y2+JUwKfL7y7zmTHlzDoOSdfZ1KMzZMS6HE6uB9EgY
 x5+xY3eaCfFUGB7lBcGv9Crt+7X4JJHDkuKr9TCaphNXjtc6NM1kb+sUyDGfcCEvp8N7HXuXEyx
 hprqCFAIaQ2yIazKP/kGs9N0lYJEeXE24p/TxLjHwHTM7BsquCvTgC8jPdxoTL06qn2Ms7q8yHl
 A/b8hA/2es3BSPlEa/jWLmR3+DnCvdTF7cb6YgchpaXRd+7qEnih6Wpxu9Ca79rSRpXYRPKczNj
 W1xFUv1wsjG6h7hs1Fw==
X-Proofpoint-GUID: mV8k6pjs7ljyRIsEQaOkurZZvewnR_cz
X-Proofpoint-ORIG-GUID: mV8k6pjs7ljyRIsEQaOkurZZvewnR_cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290142
X-Rspamd-Queue-Id: 2D26E49577B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35636-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/27/2026 3:30 PM, Johannes Berg wrote:
> On Wed, 2026-04-15 at 12:21 +0530, Manish Dharanenthiran wrote:
>> From: Hari Naraayana Desikan Kannan <hnaraaya@qti.qualcomm.com>
>>
>> Subsequent ADDBA requests from a non-AP MLD can be rejected with status
>> 0x0025 (Request declined), preventing BA establishment. This happens
>> because mac80211 checks the per-TID A-MPDU session's tid_rx pointer to
>> detect timeout changes on ADDBA updates. For drivers that set
>> SUPPORT_REORDERING_BUFFER, the reordering state is owned by the driver
>> and tid_rx will be NULL, causing mac80211 to incorrectly decline the
>> update.
>>
>> This can occur during MLO link reconfiguration, where a non-AP MLD may
>> remove one of its links while a Block Ack (BA) session is active. After
>> the link is removed, ADDBA update requests sent on the remaining links
>> are rejected, preventing BA establishment.
>>
>> Fix this by calling drv_ampdu_action() on ADDBA updates when
>> SUPPORT_REORDERING_BUFFER is set, so the driver can accept or reject the
>> update based on its capabilities and allow BA to be established on the
>> remaining links.
> 
> Pretty sure this will break drivers, particularly iwlwifi, if you don't
> fix those first.
> 


With link reconfiguration, not handling the update requests sent on the 
remaining links causes throughput drop, that's why went with handling 
the update requests even-though the session is valid.
Please let us know if we need to clear the old session and then proceed 
with the update request to avoid breaking the other drivers.
>> Note: A similar fix has been proposed in [1]. This patch also fixes the
>> issue mentioned there. The difference in approach is to keep a similar
>> flow when the dialog_token matches. Previously only the timeout value
>> is checked, updated that to check the timeout only for the hardware that
>> doesn't set SUPPORT_REORDERING_BUFFER. In [1], it was changed to invoke
>> driver unconditionally when SUPPORT_REORDERING_BUFFER is set.
>>
>> https://lore.kernel.org/all/5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt/
>>
> What was wrong with the approach we discussed there, other than nobody
> implementing it?
> 
> johannes

Not a major different between the other change, thought of keeping the 
similar version that we validated in the internal tree.

Regards
Manish Dharanenthiran

