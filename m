Return-Path: <linux-wireless+bounces-38476-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Io2GdpLRWoC+QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38476-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 19:18:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E296F0466
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 19:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZeyOKYmq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RGEYwVfP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38476-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38476-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D9A73003BEB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12036C9ED;
	Wed,  1 Jul 2026 17:08:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC43793B4
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 17:08:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925733; cv=none; b=KGpDInrHef2/YOzN2Cwc+7gl8WzMejhUiPNTkx2eXFLW9Wnr/0Z9L7FqeRi8YD6EIRzgFViKxbySXESNGlBNx66UwKIrI7cgAVCxk+4cXlGnrZKlC9kDsyEvtFNc8HbZ6IgTPoa3htkh+pUN6MmPt3AWyLvOMy9SeERZuZ9y3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925733; c=relaxed/simple;
	bh=6A1Wm7l/m4hNl6geYovfJ74zUOgl6tF7HpDo1c/Ywsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXi6NYHd94nlowEYQdWzc9I0iRD5ySc6FBFr6t+XYVYjCEHgjXFfcYOur3pR6JqcqYMP89NjTv2OqZRpg//X+x1lv94ukukEGqmzxUVbcyUoOhazk7nGr8/hz/KlY3DHCeVPvGcRgZr2u8EUyWqlln1/kH5D6Cr1j/sskvpBpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeyOKYmq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RGEYwVfP; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmiAY1708074
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 17:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iS5vtTLQxJ4op5FEDuxp3nMiGG9OS6mVarK5ICm9UAU=; b=ZeyOKYmqz2ir6nJK
	qKPD7WUPFIKl0j3SrJ4phD3celcOrernGQcnZzlfBOJ5oCWQ0neO2BC8jbCbZ3V5
	//cL0gzclLOwWxT34+OXsR53jpEfgCd0OIfzxdcWQQmBr7nHIhN7+3upIlDa7tN4
	h9ANvjLfKfwebJ7E//0X5JIe1ENm6Fo1PiOAUmWn9Rj3dPDgTl+mhachxeEFlB9D
	C/mbemb4bUXEEV6XGljcK7Cg7dd+4s0DZJj/XLNAmAvJgZxY7j2JkqpTm+zDoq6P
	vKw18bbKByZE5IWswsPGkFXjNudwg+DWnBIvQQykPxoUuT7QawaoqsieLTcaSmx6
	8h9l3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqsvhx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 17:08:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c9d85160caso8727665ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782925730; x=1783530530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS5vtTLQxJ4op5FEDuxp3nMiGG9OS6mVarK5ICm9UAU=;
        b=RGEYwVfP1Ryylry+cDP5VCrbtzJ+NYMgwV+PMSe022HAs6nia/HAOcrBx0N+wky6mW
         oLlIuGWMVLYB+J2Zr+KAoGcxuucsG50hTha9v8qBBfHxDv5pza6qURwvK6l0GnMN/74n
         MW4z8EU/S6Ot6LrFYao/z8Nw0PeLkfOkwKWqCVZnM7oMspapVcJn6MJHrEu9q0xeU6Pt
         azK8jsrx7rDBVFGklNuiM9cjHU9ghbyte1uspQq3se0hBLZozPf7ixNpHwXvsu/BFXfC
         fV88DBjWXrd7WVVGl5fHWPnu5fgDA8JYxNQC9IhuguKss6W9SpWKAXLk3s3cTDV1XdBg
         XXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925730; x=1783530530;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS5vtTLQxJ4op5FEDuxp3nMiGG9OS6mVarK5ICm9UAU=;
        b=moU6SD70yzhHFF6ta7r/9lRt+kjgwtbScZTMop6pqF/rB5mZ6GF4DyfOMHIFqQk5mO
         U/U5A3hbrBq445GYJSygTzWRg2qwi6O6NQ3Fd6iDiaSNXLZnLgzuMsBBHc7UiryT1S9g
         btERInN34xzBiIKl4Pajg9Dhsq6SB5kyk99hmj8TNh0+3uZffutAs8XXnmsYK76qk3tF
         nyrDB97Qk6TNofueoMzInz+6l8IZvcW/EsCkob6XHZE/kfxLkuE7rV12QMirjzmXXrUr
         Zx5scucaPhqwvuHRkNPbPW3Yr/TZAu2wbEgo71BzxNxO7JUJf9vF69Xnrg1N7A3nxLq1
         MBmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0jwilIxgm0+iCL5G77vS684XroGI76H8hfVgckh+rfXD8MvRf1fuI2pUysSF5ZVp4HCDrJdV+8O30y7IG+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxRfmNfAd77QLR/HA3LJFg+tPSOlWrBzjxl4vR4a0GYJ317cIO
	v4MrfMviYT8i8HcpX+8jO0oFw5uXCqGNVjJ8n8sn0YyUj7CriraXHIHTn9qY3mAJWr16SZBEg5H
	WoDeRJtqfHvCHNfbo3btsNxh/8bg6/2ZnpScANJ2p/AE9OJo+P0wJGIs1TnCsUSTf8aamYQ==
X-Gm-Gg: AfdE7cl+38x7YvaziQivaioMNGZtS96uSGZn9GFHv1+V1PJjWLNOtOLZOZhnbxzlI1O
	B78qZ9dKfI9e7j/vRmXv1Qg409eQEGc0kSz522dMtlu02te02N3AIOvqRIy4uiWPt3CIT+EqSrH
	HsKUWVwRKhgw/v7u2zWd4SwkgV7Xdc2iq/OHK4UWjHJX/YmfP8waRTLFVN6oJHdr/e0LPYc9IZw
	n99inPuNsNBKbg99qC6hgj/2B1wudRpNorj1Xu8axpPXXYszmJ2thQQ4TMwOhrnFC5zzB1uBVC/
	JtSfxAyw8KklR7F/cTeRToiOrbIopammq/RQNniHPR8DiEhPG3mCsACR7AuKJaiFtEKX5u2H9Fy
	XE8gIaA9QKBZ1fNyHp88f/yZTK2QkgZ2KRI1ZKjCBmBxlbQCYF+Hm26f24STjPrB14KXqOMw=
X-Received: by 2002:a17:903:b0c:b0:2c9:d584:49bc with SMTP id d9443c01a7336-2ca4487f865mr59166375ad.3.1782925729708;
        Wed, 01 Jul 2026 10:08:49 -0700 (PDT)
X-Received: by 2002:a17:903:b0c:b0:2c9:d584:49bc with SMTP id d9443c01a7336-2ca4487f865mr59166005ad.3.1782925729203;
        Wed, 01 Jul 2026 10:08:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2a9b425asm27631455c88.0.2026.07.01.10.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 10:08:48 -0700 (PDT)
Message-ID: <a412f206-e856-47f8-af74-8eb268ed50d0@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 10:08:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k: BigEndian platform support?
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <68290980-5bfb-c88c-be78-954f9591c135@westermo.com>
 <87cz0y96j1.fsf@kernel.org> <akIuPiYGXDbDWLGZ@FUE-ALEWI-WINX>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <akIuPiYGXDbDWLGZ@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vF6AaZaICb-y4wATCUNXogWkZfPOymmQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE4MiBTYWx0ZWRfXy3ozmUhnYHuo
 5mFAA9LMWCNaMvm8LD4oOvV8NnzLgx1Ng6R874pBzSavF3Z7Wenk6emX1iZNAjL1aSMAqYf/Vo6
 lkQT3RtXoS3A66hVZYzEx/ETanUDb5w=
X-Proofpoint-ORIG-GUID: vF6AaZaICb-y4wATCUNXogWkZfPOymmQ
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a4549a2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=N9GNhs4bAAAA:8 a=ZRmf-2ApCqndCitTYBsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE4MiBTYWx0ZWRfXzuiSCJujfFjp
 IAuC2g2L8fkKtbDIwZC2MyoBkWqed18BjAo9mi9JsrYgsBL1GT8SBQb0JqBJAUZSsZMdW7BSMhE
 VLhTh43MKN0785XH8tzyfKiZE9YHLMyBWa6O8/CIjghz0dWVU+tNrFjU6ua8yaR/sWFJ5DeDPms
 SSnnpt9TBm1Y0imkBFovrD1VAXbUHcSDBRUPsojNtMwgwzaRxibLok8RhbRCJT55AmQKjqmgBAl
 xESwLcoB+PRGyb8PNRsUo20uQJ8brTGjWnlJzpVh/gSKkBMhwQ6XIdmyURx8Ac2PwXF+P8NjEQk
 3BddMegf5FaAE44qpLo7i8hcVoIgYC/n1m+G+4v6dSroJJ95xRvodN8P5cm1DZOsFOAuIHQ8n0k
 c/5mtkVTuLmEquIrJ+h0C4cJ05zvG/sdR0H6j3C/jx4ZKa5lYy909+GVjuFEJ3DOQMBewUL9Qbt
 rPKy0azawlxXRby7AHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010182
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38476-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57E296F0466

On 6/29/2026 1:35 AM, Alexander Wilhelm wrote:
> On Tue, Jul 11, 2023 at 11:49:54AM +0300, Kalle Valo wrote:
>> Alexander Wilhelm <alexander.wilhelm@westermo.com> writes:
>>
>>> I am trying to get the QCN9074 module to work on a BigEndian PowerPC
>>> platform. My question would be, has anyone done it yet? If not, what
>>> kind of effort would you estimate for porting or are there any
>>> firmware limitations?
>>
>> This is a good question. The short answer is that it _might_ work with
>> QCN9074 but AFAIK nobody has tested it and I'm not really optimistic.
>>
>> The long answer is that the big endian support in ath11k is implemented
>> in a weird way which I regret big time. The idea is that the firmware
>> does the translation instead of ath11k driver with this flag:
>>
>> /* Host software's Copy Engine configuration. */
>> #ifdef __BIG_ENDIAN
>> #define CE_ATTR_FLAGS CE_ATTR_BYTE_SWAP_DATA
>> #else
>> #define CE_ATTR_FLAGS 0
>> #endif
>>
>> But later I was told that not all firmware branches actually support
>> this feature, sigh. To my knowledge QCA6390 and WCN6855 firmwares do not
>> support this CE_ATTR_BYTE_SWAP_DATA but I'm hoping QCN9074 firmware
>> would support it. Grep for BIG_ENDIAN to see more big endian specific
>> changes.
>>
>> In ath12k the endian support was implemented in a proper way using
>> __le32 type family and cpu_to_le32() & co macros, but it's also
>> untested. It's on my todo list to convert ath11k to do the same but no
>> idea when I'm able to work on it. Patches very welcome.
>>
>> Do let me know if you test ath11k on big endian, I'm very curious to
>> know the results.
> 
> Hello Jeff and the `ath` developers,
> 
> there are still a number of pending patch requests from my side for `ath12k`
> addressing various big endian issues. I assume there may still be gaps that I
> did not uncover during my testing. Nevertheless, `ath12k` is now running stable
> for me in both AP and STA modes, so I have started to look into `ath11k`.

Let me start by addressing ath12k. I have been sitting on your patches because
internally there has been a lot of discussion on this topic. Just this week I
convinced Those That Need Convincing (tm) that your changes are consistent
with the approach that was taken with the rest of ath12k to have the host
driver responsible for all byte swapping. So I'll finally be taking those patches.

HOWEVER, Qualcomm is trying to transition all of our products to be based upon
the upstream driver, and the team responsible for enterprise access points
believes that their KPIs on Big Endian platforms cannot be met with software
byte swapping (my understanding is they currently use hardware swapping in
their out-of-tree driver). So it is possible that ath12k will need to
transition to hardware swapping in the future to meet that need.

I just wanted to share that bit.

Your proposal for ath11k still needs to be discussed, but there is obviously
concern about introducing regressions to code. There will also be impacts on
projects like QSDK and OpenWrt, which are based upon applying patches to the
existing driver, if large portions of ath11k are rewritten.

/jeff

