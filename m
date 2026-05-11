Return-Path: <linux-wireless+bounces-36222-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JoKAD6wAWoeigEAu9opvQ
	(envelope-from <linux-wireless+bounces-36222-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:32:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAABD50BEA9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7A353001876
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBBE344DB5;
	Mon, 11 May 2026 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gGyPDVNs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fViVPvPT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B432B99F
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495543; cv=none; b=XhnHtSZKz1uQeH4AwuYtI7zTWE0a+UGX+mMxcHTV8Ng6jwlOl++PhYpRUynuHdbIVn8xvzdxZUEO3hG7q6MmQ0aAF5jlTJoVEkFNlkZ5MRZy/AHxgAIbF8280vkwSLeaPKxLaatza7FJCgaYk4i1fZp8Vwu2CR3Guc9akr8a1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495543; c=relaxed/simple;
	bh=V8jdLh5erVGnMqFJKqPmOvCAqNlz6zmNqO+D1aG7nZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASerkqXUtwOdNfSwtzXVrfyclfHPynclI0amDN0xSmxLak6jlCSKTpeTsD4NaDeLXZThVyq4qqKo2GNzRC/58dI7ZNw2xScotAWf4SAKSaOqWfvLAjm/9ntSDeoMArqm2Ld4kZf8QgK68LbZSbymaKlvdTMww9uc945pd2N0GLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gGyPDVNs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fViVPvPT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B76lpA3527931
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n5ik+qPSqxOyB7Rt8kxov3+OHfqW/cEvgFBPIUMle10=; b=gGyPDVNs9f8CsxBc
	7Ly4U7DLtlwjGiNOsmswaV7blFRxXezW1EuN62rNVtzvaGV4mhBvTiveylfWaYtS
	mT6XPe+jp0c2vtjWn5OA9lScxIplJ5sglp3y6JisK23xxNS0CjSk+3tQzpxOfJhR
	Otn1AbwfP0BTkjgESf2zd/BGVig0Nr0v24VtOV/sbkyZgMVmBi2Q/o9MF2g2U5c3
	FUqUHN3X+96h0pC3Mn2xTuUnRwDqDON29GU6MR7nSkXCu7JaXWw5fpQGPo5xe3U1
	f6vupfYFdxCQHWR823iIhPm8CmcYubhurWNCyqGP9/XijWr3M7L15Nj3ZI2PfD1r
	wYQLiQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e2dksktj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:32:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba3245a43dso30241655ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778495540; x=1779100340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5ik+qPSqxOyB7Rt8kxov3+OHfqW/cEvgFBPIUMle10=;
        b=fViVPvPTYA6z4Wz0geIb3ez//xIC5sTPz9yJ2eynL7faR3YnDAj+6EWpLF2u3ekIX1
         dgBXG84dItqynijP+RaXoKc2qauZYSWT8cDx+TxzwWkv+v+0ZVgwFTYLBiAJJzD1qby+
         PESuqHkWc5Kd1RNZ49bmH3IQckUntSZOHMQNHeN6YuP9Tb9rl5S78Wk5ls834+Lm4BOG
         LLMxVrkERe1d9/evJllD+Eq4wkqqsiPhzgvQFvm1QGO1wK4XraKqeoQdHPLrDTqzzjhU
         40/5Di6ssedAtPcLczodz63qfa+xxGekEquwkAL1q7p5Kpx7Yfg1x1CpVhtP2yH2OeTl
         0wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778495540; x=1779100340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5ik+qPSqxOyB7Rt8kxov3+OHfqW/cEvgFBPIUMle10=;
        b=VEzRpKm1ToQu07emtmUIKLnCp2aV7dJd1x2WCQASehJSayxCFqMgguPTnU+oujskgg
         kmCmK9tRy6gSD0w3HLwK+Z22jNBTbSn3/cjWXgjlweJagVh3ZDyux3AAhZ3TI8kXmhyv
         fq00TBrT+7WAbjkbZurKu7sAin/NXjFJdbTPq2uIe4PCsOeQLg4fCynTIc4ZrLAbE7o9
         ujS0F0YpstGgV8C3b8VHnEHbuDdOw6jTYbV0he39yqOjf5O43R2xbITS1xyLCKME+qEI
         XynaLusOMtCpxJAfeKUTWiIG2U6cr0zWLiqJysYxMIIRN6FkpSYmgpTFsReopPp2oqmR
         V99A==
X-Gm-Message-State: AOJu0YzQaND1XDOzUt4l4asj91R610y5iGrIhR36fg4y2MdqW8AIGiLD
	XhkZFjLakQtZmBdh49whKTA7SeNKEBMKceucE04RRJdW63koK2gQX6mSfpmnzNh2SHD8T+I1SNp
	bGqvh7RHTSKCKojSC8OaIWCURudcs5SB44accqhIEozxaFI/liW4Yi1BxI/OSwVcfqlOtCw==
X-Gm-Gg: Acq92OFRaRqvHZTXYW9LS+h2nGqsSLNKlIYQNkOdUlJE0bcNK6NwigPxpOAXcScewtr
	7/wXO7McVc3R7RBoMjT24btsFhnjg5QggA2nfSExmVYtI9XA2k8hVndl4vlpxU5tlOij9NO1zkO
	pRmbk24lVjaHRe+BDlGLnZA8yOOCHYlQlXOSzZPED0ApUEOmO1TUdveHu1qdWjS8Ivm+7JU1ttI
	+GOecrZ4kNxKROTvAXMxdHFHZ/uNzMaFWGkDYFtZDQpSOT8pDNcIc9+vDXN8FYoEBJkTgrbzzpS
	OQropFjEBYskPLcwD6MvDwgPedH56kQTL18t5cj3VucSA3urScChjM7E/8a2i6UXU+7IYK5hhec
	2zRYBD5QjIvuJ2H6NpSlZpLf3FmohQhZlIGM2nmwAgmm6NWtgNmCsFieWO4GZb1g=
X-Received: by 2002:a17:903:1a68:b0:2bc:7486:21cf with SMTP id d9443c01a7336-2bc748623e7mr112803685ad.36.1778495540320;
        Mon, 11 May 2026 03:32:20 -0700 (PDT)
X-Received: by 2002:a17:903:1a68:b0:2bc:7486:21cf with SMTP id d9443c01a7336-2bc748623e7mr112803365ad.36.1778495539781;
        Mon, 11 May 2026 03:32:19 -0700 (PDT)
Received: from [10.152.207.30] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ecc4bbsm96895415ad.84.2026.05.11.03.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:32:19 -0700 (PDT)
Message-ID: <0935f5fb-13cc-48a2-9aad-26e6a29538db@oss.qualcomm.com>
Date: Mon, 11 May 2026 16:02:16 +0530
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
 <1d06b2a3-66d8-4c27-b965-6c21f80b7539@oss.qualcomm.com>
 <a5b6798819178dd2995c34ec817457e90985708e.camel@sipsolutions.net>
 <dbb28e3e-5022-4915-93e3-dd428ea59507@oss.qualcomm.com>
 <72b480830dee1489bc28246d13102048635de5db.camel@sipsolutions.net>
 <ffb9e313-fa81-4da7-8415-6713cfca3230@oss.qualcomm.com>
 <cf877993914f9cee95fd5da1d9e57c838319a085.camel@sipsolutions.net>
Content-Language: en-US
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <cf877993914f9cee95fd5da1d9e57c838319a085.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDExNiBTYWx0ZWRfX+KN89Qihq3/9
 4jOVb0cWPjKarDMih5FaUnTte9VLF0wn7HHyf7al6JDkGrlgiF3PbTrjn4SVJ5GAY7GU8huQBC/
 lCF8uAjBvwNp/9y0npO0PbaYOktSi1pLo7oAoJ1suHhVuusI1og5Fi8/lcfJwUyF22S89hhBEjI
 l9OAfdAlYrShjjEli09K+pUuymkNTlzvXFT6c8CtQZ926JvFTAK4nMLE//92LDxvC94GTc3TFWZ
 g233ld5RsYwsYev+d0GDwDIvP7+ky6aDnf2hBGUqHiTmTYoCpfD/QnJCRq8C7jHE0uRlF02gE6Z
 KeKT7ZizYDn63mFpowYKmdkgfm1YIfrSxnjhkDepMqTBdAqSNGrHNgsrt6IUvtx2aaJCeWuIdr/
 XnIq30XmrbBkDLygK8E+K8WlzjHAYjuKNUKSQSLHHiTw1AseR8wBdb4SFFZ5rq8L5PKkiakOpGB
 MutAQb5EeoMyvoXfIbQ==
X-Proofpoint-ORIG-GUID: _IunzQDivKmRhwfSoJoPIV6T8PSN3LOy
X-Proofpoint-GUID: _IunzQDivKmRhwfSoJoPIV6T8PSN3LOy
X-Authority-Analysis: v=2.4 cv=cKjQdFeN c=1 sm=1 tr=0 ts=6a01b035 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=O-Z9MHfGKvQXpMZLlIMA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110116
X-Rspamd-Queue-Id: EAABD50BEA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36222-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/11/2026 3:41 PM, Johannes Berg wrote:
> On Mon, 2026-05-11 at 15:40 +0530, Manish Dharanenthiran wrote:
>>
>> Even-then, if there is a actual change, it goes to invoke the UPDATE.
>> For the driver(s) which didn't implement the UPDATE yet, should we use
>> additional flags to notify the UPDATE support or returning a failure
>> from driver should be suffice?
> 
> I hope drivers would refuse unknown operations, so I think returning a
> failure is fine. We can quickly review the drivers that handle this to
> make sure, but I'd prefer not to have a feature flag.
> 
> johannes

Quickly checked the drivers which sets 'SUPPORTS_REORDERING_BUFFER',

  - ath11k/ath12k drivers silently returns a failure if the 'op' is not 
handled.

  - Intel drivers do a 'WARN_ON_ONCE(1)' as default. Would need a change 
to avoid calling warning for UPDATE operation.

  - And Mediatek drivers return success as default. (I guess, this 
should be fine, but would request comment from them about keeping this 
behavior for UPDATE operation)


