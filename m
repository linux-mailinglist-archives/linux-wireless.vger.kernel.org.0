Return-Path: <linux-wireless+bounces-38637-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7sP1A22USmpXEwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38637-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 19:29:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFAC70AB1C
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 19:29:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mO37KDNb;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=eZsMxCVc;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38637-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38637-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABCF30209D3
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C73016E7;
	Sun,  5 Jul 2026 17:28:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567B2F9C37
	for <linux-wireless@vger.kernel.org>; Sun,  5 Jul 2026 17:28:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272484; cv=none; b=X2UktL7F/wZDu6sd9Gx23cKqADv8B9wQRU0K/CLQWDuKsve/dSf7YjFQv692javJo09/uwZyUT3QF1T0kbmUePieYIP7u//8LEr1+jATeHBxHR28iC2GXU/4KOigFIp17DcUOUS39TDhuRXjtLVQKx8fhWfcMpGS35znXHF1m2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272484; c=relaxed/simple;
	bh=sB7AINyyti7uXeU5MUKtTiLyLBD6wITu9XF36kuNIr4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AKVblxzoAW98Re0td00ePTUl7MOh3Ozlw2Re4WTOoLepG14JFnY7Z+ATyzryvoV1/CSrBRK6oYc3IpeQ3yrf3l5XZTv+le1nNPyAdHFvn8Zxb9k+o8JVeb0NREz4H8+WhpAdQLU1zvJ+FS5tbgFUp8eYeY4oYV+rdPX9CI4k/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mO37KDNb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZsMxCVc; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66510Ivv247729
	for <linux-wireless@vger.kernel.org>; Sun, 5 Jul 2026 17:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gj+YLt1a9eyMlIaineSH/PGHkbWi7DsdRDopGs+T6Mc=; b=mO37KDNb1Udtd+Ej
	wyswc5+W8Y3oKvIa27hBAob4YwrwOfmBuh5xcOXzM9oeowZ5zTf8xGRruSCQKAf7
	5xRdmp1s/CFbSXAidKpJ991RGcXTl7GkN3bXWgquRIqL90/fwaKpKrX0rFV3VBmE
	IKCzUHLwk7FHSY/Dovw5Ye3fTE13PMCT7Mhj0VHrLUoy143yxnB7tUQHARnX0LY3
	j+0nVOaN1BukUZRZzXdbKPt5Yeb+X9paLnf81Idfk/Z3OK3EMhSSshkipyN3woq6
	iBOzlkCmE+Mw4xiQ2mVk1fGvn2R8cGPw+J4POIMr53tEcQ/pfT/2KR8QZHn5Qvfb
	ZA8oOA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnkdem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 17:28:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso26751905ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272481; x=1783877281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gj+YLt1a9eyMlIaineSH/PGHkbWi7DsdRDopGs+T6Mc=;
        b=eZsMxCVceUVTt0ifkAjoO8GHLtXjd8b+IblN7Sy9FklQfemmGPM8evRK/N1kmeRnFI
         ELR26ZwMkPOlRs8sRwQ9GAxy1cJjystMRBV+UmS8S5cwhgTRIa5OboGNxWxYdqNfFM9i
         cvOLpPG8yNURVCfxA1DOg5eUMWH/+SwLixuXIwy3Hnq1WY+Tu+9s/IDKL7sHB4Eg4yLO
         wyhDd8yqvczZrxuQRCXKHWoFVR9p62fcngre161q3av/NxHP/gMbGRlWI6h3ybz4DJam
         NOSkPCivvpyoHU7iMyw7cGr4XNo4rsDy3Aukvi3JGOJCAF/j8Y5RKlTqQbKtCDufb6A5
         1dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272481; x=1783877281;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gj+YLt1a9eyMlIaineSH/PGHkbWi7DsdRDopGs+T6Mc=;
        b=Hooavh73zp58xS1eudL/oeO9cr18NcBwkpzmwSjcuDWgfrJeg9vame6RDkSE1nKbBl
         oy4URFDz5VtROZPu+AzzHk+DGdaSpTO9eYjBMdcQ8ZM6oWz4+we5rjRdRiiMU2kNob13
         vXOYI+APAW/Yz55or/eM9A1HsBwLOFHZIkDkyVl/OesuXoqHKK7uIwU1OZrisq9KCSMN
         2aF27OmVVpr+6cvKxf653hin2us+qk25sJGiVpj80STu8DNraOHFMNz256PFW74oIp06
         UOXKkrtd+LreAfg6IHK423wcDEtSUuv994E7pPr1nv4ktu/OenFT74nEiJ40HfKxOXUH
         kxbQ==
X-Gm-Message-State: AOJu0YzlnUwA8CxLRL1A9LxBjCGDCURE4B83oNjT4HRh7F2FX03PTapE
	f612g02b839GeBcj6/+RkO4fdCKMVd26VeDZnwOJ4Uk/OzQKI4X2I7O396p7hvdhKmQnXgcDFpv
	YniIpY/1HWg+qsUlnL+EGrDIBTrzQ08IJNdq4Je42Z0jfrdgjQ3vDavydL3jXKeI9xiY/lw==
X-Gm-Gg: AfdE7cnv3G+orOWnJTTPU4u8Qk1aj1b0Tp3KHhiMWgbWWjCVqy7LUtK8hO6zzUv0kkl
	icsdAKzdSc2VzEwBW5i/fy8juzENUulg1Hm9wyuru+6OTHAqAn99DFPDfK38F/8ofT3kx09gWGV
	JsC9fl8Q3PdyBLBd9tvu7RRT4Vs8+7FdCoQLdgNYHo80CDTdU7cYcILrtsMIjABwlXxddV/qV69
	IkhSxyQs6YE9dlHVN16b9ao4yho6Pxu2s3unADNbj1K4XlAQBD4C+5w+WLvOa7Qzk4vGabBfPEy
	RmPSlyt0JXlbFVM12L4VY0qWOAHcjaMy6oAmMoPtpsVORGw3XDqrqv2opiyhWlHGr0gRUjQRb74
	9T+Qkrl/cfOnXlTjjznaAuwWst+v5PqSVbq97HPNW+4XhR3rKEjsYJqAcGPz9uA==
X-Received: by 2002:a17:902:f791:b0:2cc:9473:97c8 with SMTP id d9443c01a7336-2cc94739b69mr13488215ad.15.1783272481208;
        Sun, 05 Jul 2026 10:28:01 -0700 (PDT)
X-Received: by 2002:a17:902:f791:b0:2cc:9473:97c8 with SMTP id d9443c01a7336-2cc94739b69mr13488105ad.15.1783272480731;
        Sun, 05 Jul 2026 10:28:00 -0700 (PDT)
Received: from [10.168.91.130] ([223.185.219.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm65764138c88.10.2026.07.05.10.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:28:00 -0700 (PDT)
Message-ID: <b25be5a2-bef6-4fda-b166-becca3d1d650@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 22:57:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615112103.601982-1-jtornosm@redhat.com>
 <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4OCBTYWx0ZWRfX4/91Ijim8pgk
 dGxgyxzbV7rJfPVv83gP0e/JAfx/DGUk3xVqkU38mdtVes3iougdIP2sJuMI0QKom0UcqT53ONP
 7DiMWQfRdEerB8KKFmVv6eiUB2xzhmI=
X-Proofpoint-ORIG-GUID: 91UbfE372WRwthcG1fE7sb37eWmTqRDN
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4a9422 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ziM92C7oNnnlFgKtw0sKeA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DO-9swsaIGp9kS3Vgj8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4OCBTYWx0ZWRfX7OBttNZB0U3j
 t6kLwsSycWxLBH34632mLRmMQe1LBBDMxYnxojiTNUo9UgNcUO5zDBZBeLu0OfzpiOLuVIkoUpi
 qTBRklV/8UxjHhxFtyKCTQjo4vdxPKnSRbHo2ibSlJeX/M2JK9Mk0zH82tv8ZHWRsdU1hblJa2m
 zhHqD9xHi1xU56di3XpwVhdcnCt1bka37WdRjEePYMfsO7NLP8fvklR2zIEqmdmR4DxAT+UsQSA
 ZOWKbvYa/i2siTGmUxVGdWAWFk74GAyZ0JNdb+IkiuIFkgg8w0pkAwkzkcIPD9WRB37DTo24+l/
 qxWtGvATscpX4Rb+4UsVrUm48lnXBZdzzyMcUxDihM8XX3bLo+7m40UPqiO2jApqEjfXRnYWYLS
 Flt1vw8yWBsPgp2p1jySljBT0tPE7rJwGrbqragK68hpPDyN1r+YpqbmUzsE0vio0wBIglRqjv9
 /FrDkxY4dxe5DkE4R6A==
X-Proofpoint-GUID: 91UbfE372WRwthcG1fE7sb37eWmTqRDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38637-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EFAC70AB1C



On 7/5/2026 10:53 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 6/15/2026 4:51 PM, Jose Ignacio Tornos Martinez wrote:
>> When unbinding the ath12k driver, kernel NULL pointer dereferences
>> occur in irq_work_sync() called from rhashtable_destroy().
>>
>> Two hash tables are affected:
>> 1. ath12k_link_sta hash table in ath12k_base
>> 2. ath12k_dp_link_peer hash table in ath12k_dp
>>
>> The issue happens because the destroy functions are called unconditionally
>> in cleanup paths, but the hash tables are only initialized late in their
>> respective init functions. If the device was never fully started or if the
>> init functions failed before initializing the hash tables, the pointers
>> will be NULL. The issues are always reproducible from a VM because the MSI
>> addressing initialization is failing.
>>
>> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>>   RIP: irq_work_sync+0x1e/0x70
>>   rhashtable_destroy+0x12/0x60
>>   ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>>   ath12k_core_stop+0xe/0x80 [ath12k]
>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>
>> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>>   RIP: irq_work_sync+0x1e/0x70
>>   rhashtable_destroy+0x12/0x60
>>   ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>>   ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>
>> Fix this by adding NULL checks before calling rhashtable_destroy() in
>> both destroy functions.
>>
>> The NULL check approach was chosen because the rhashtable pointer
>> serves as the initialization state indicator. The init can fail at
>> various points, leaving some components uninitialized. Checking the
>> pointer directly is simpler than adding separate state flags that
>> would need synchronization.
>>
>> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
>> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> 
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

Missed to mention that pls add wifi prefix to the patch title.

