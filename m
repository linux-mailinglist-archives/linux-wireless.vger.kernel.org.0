Return-Path: <linux-wireless+bounces-36037-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJoCLKeF+2kscQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36037-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 20:17:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B54DF389
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E9613003633
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73084BCAB5;
	Wed,  6 May 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMVqzLK4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B5ZxSkiJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A34BC01E
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091427; cv=none; b=uZjMBcZnk2kElumLYKlL0mSX07QzE4jYzYX0v2VwkV0OxS/Cfgr4YKkIf49vcY2M1dg7Murat2zdlxCmEN4DYCxg3DGIfnVc5njFoJ3PaTNYD9//5PJR0LJPr/JS0vAwMnfmH2/YQTRQFqA1VYJ7vlYhSjzIv94XYjppE0P+Gzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091427; c=relaxed/simple;
	bh=zEv/toTRgAI01LjWDV/SsrcBFyQrKzNSS23sYQNA42o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ubv6mnv/4N9R3rM8kBKEsgkaT4pg8ByGSBkCW1uLnFmgk0Gb+bMJkimdixnxkSwHkpA47aE7CSBNrhUowHleaUGx9xv2NO0NPh67+gc8N4JsP/nhZSjlE90ZPuf5Zzrxh1uhb4NgxYyIkL+RMI+0R32nRRsgoPmBkAWMKjfWJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMVqzLK4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B5ZxSkiJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646DNHtH1527764
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 18:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hWkIqC1spCWZJCjwZCz3MyMzSv0Xnf0zHmXzkGZ0ybI=; b=BMVqzLK4MM9Y1t7T
	1X8Swvp+OjxHDdYlTKRymwrM190T9ywN7V3MiwfZzSVEMywrx+4t+hBOO1Ee4P8K
	5Qtwo5GdSoh85yGPbHlV2XvaDZs4NVJEFr8+drilL1YikAmxGQmhJk37GZsU1Opn
	D6K+xX7nN8Hf7mtn5AmWglWUCqD2xgEo2TLkjhxtpjl+E83JBpOq8Jp8s99lHLto
	0wvNmfgZc6Cf5pCVUkOghNhR/K+9E6Ut3gXr9YaphWHduovkB6br/rXsNraxSvno
	WEXZ7e2L5rkO1qOuUhn2LdEf9rdosZOIcGexS7+rSKGeJFwcnEs0uhzttIVqmDMr
	86zxBg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128aj9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 18:17:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2d83e7461so166495ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778091422; x=1778696222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWkIqC1spCWZJCjwZCz3MyMzSv0Xnf0zHmXzkGZ0ybI=;
        b=B5ZxSkiJdu+6eZ/QSJ00Zn6yuBwds1gIKnTXvwwoEmo50S97mhtSmb7p1WX/WS6hSf
         wzMkFwG5e1IVdDfXobYirGUaCLqda5iziwYySL77MRDUxGQz8y9jYcLkTXlj8llwUXpk
         QAfzgG4mEa1cwMJTMifn4sDSlhkXriObgCmdfViIQx+fvxVZy9s8BLEy3HB79ZHMdOSt
         tdsXvmxjsuqo1xRw72qiA8HB9pEw1K29wKuqi2aOh2XrSvEnYVwobCFyjdZhoK3aOaGh
         imz5b6AFdmHJRDXLfx47fAowxtespEzvhhMpNHWPS+6R61WcbSMKDeVJP9FQLpgkTsj9
         rr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091422; x=1778696222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWkIqC1spCWZJCjwZCz3MyMzSv0Xnf0zHmXzkGZ0ybI=;
        b=mBRDrUmk4+e52R/TGSy5fGHLe/0qYhMAEn5H9vRCjJF0oLz5ltiFvmy/sUq6PyFeHk
         yc5sYmUSzJ/Wz9oTUBaJq10UY9WzMgTVNz7GyZiyxe0Dfy+6nn60EA3yRSmoyjYPqhj+
         ++biml2ekjUh+QRivSkfCyDd07Jda2JqxfW55UiiW5e1kPrtafiepluHiM752rmgAZGA
         bXrSfiWNEbVxCDE4BV2OzRWfxM4ydsT4P2kcDuHhWzDDVEDW8pAFVruVTFs6bR+z6d4B
         Tqkj+ZeRo86JLM0x+FuY/hTG/axF+0Tzj+ElwvZR7mt7qI5zRrYtSY+ZYJO0PnhHgzSL
         s87Q==
X-Gm-Message-State: AOJu0YxA3veZ3BApgGt7hliHJMcQ/J7GAGejkU3JsVD68aMl1GfBM1Lk
	nkpoisMssU1bpttm+BZt+SFO1OQhoBq0bmzNVtDMi8clgjX2/PeYzCpvH0PbCbjEKEMYz6JiiTu
	22OFpF1j6N1pS7Kzm0WYwWDpLNCwNsiEEZCwrgEzNAzTwRH7+AYxsEFtYKpAcD0DsQJSSDAc9XG
	GLTg==
X-Gm-Gg: AeBDievorDLj55+BtPe8puqImZkE1vIdbe0GfjOSqymxqNz01o9XIWjhKFac420ENoS
	LFEEBuarNuzutIFGoiGcbIFFacuxULWW44qBn66+WgLEyabMGm/84E21eA0xoszYoxqu3aFqKSC
	7m8fPj3Lw+BFD/VXqwpsB1IALwHNp3yz1i/KShndB45N9yL2zGAn0BAyvCRfszX8uxXFvOP0+Vb
	XZpu7tKjubWgJq+v5bTHebn/WWjtBGj+mQvL0uyuMvLxGZNHdwf7Wbg0MHSrd9t01TEiIYEkZwx
	wTtErmlJwDJHiXeaUtcQW9hwbRRunNo8SNTOm/eKCKo/6bNNVEatnJEK/3CU/0nZuj8lsJzL9Rv
	EqDN0rN39UeXKJ/e5ghzM22iJFMMtgl3G139issdV806Y3LUZTYErqyn2pqngfwKe8olkNdMVu3
	2M
X-Received: by 2002:a17:903:151:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2ba78b48767mr33825735ad.4.1778091421548;
        Wed, 06 May 2026 11:17:01 -0700 (PDT)
X-Received: by 2002:a17:903:151:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2ba78b48767mr33825535ad.4.1778091420965;
        Wed, 06 May 2026 11:17:00 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c038ebasm33167835ad.36.2026.05.06.11.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 11:17:00 -0700 (PDT)
Message-ID: <f6e20530-0b5d-4c19-9ccb-34ee1cc7ee18@oss.qualcomm.com>
Date: Wed, 6 May 2026 23:46:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fix leaks in some WMI error path
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260506134240.2284016-1-nico.escande@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260506134240.2284016-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x0Il1RLCti_UA7hxVtwo2MkiiPT-8qGk
X-Proofpoint-ORIG-GUID: x0Il1RLCti_UA7hxVtwo2MkiiPT-8qGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OSBTYWx0ZWRfXyiQe1V+VQvFd
 J/f9CAWOBSfZDJBwT97b+iW9Vv3lc30PZhuvybQu3c+9qDf8t8nJt/n1nBtM+qPS5tuq/a8aAhJ
 tnTvo59okxJ4L4D0mzYneZewkEgUbZ+/cYlcFUMgWaHdcjgK5Wsc7hY7frB3sxyRUl5jS/eAKO8
 0PWGw2sPhd0B9r4RCMbyeYjpn/if2489bcAJcBpK7fw2WWYOGxm0qPpLcQ+K/e3dckaSu9Uiw1m
 gfmmOPQgbWqENxID2upon1xRkoz7BzBolL8DfjQ0nn98FVVLAD0tXzj/AbPoyLTPNX3Oryv2dWq
 wIGVkbSW+uZjKxjCVFMSIQAfzr1Ma7lzuLVFlYQ9a5+E/CNzgeud5lo17pyCVU06ubYfcbLUZ8J
 +cTOn8f4rMC4HOogxMCTH9qeBfPoU9sTfvnnnnqOCGwyq5vOcWqvT9Puuyr2M06K1MK+oJP13BF
 eVHqkqGGhEjsow71ENw==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69fb859e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6dxGyyh_nZznhl1tEkMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060179
X-Rspamd-Queue-Id: 470B54DF389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36037-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/6/2026 7:12 PM, Nicolas Escande wrote:
> So this is similar work to what has been posted here [0] for ath12k.
> 
> When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
> explicitly checking the return value we fail to free the allocated skb.
> 
> This has been split into 2 patches per Jeff's guidance to hopefully
> ease the backporting process.
> 
> [0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/
> 
> ---
> Changes from v1:
>    - Added patch to also fix ath11k_tm_cmd_wmi_ftm() as per Rameshkumar's remark
> 
> Nicolas Escande (3):
>    wifi: ath11k: fix leak in error path of some WOW related WMI commands
>    wifi: ath11k: fix error path leaks in some WMI calls
>    wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()
> 
>   drivers/net/wireless/ath/ath11k/testmode.c |   1 +
>   drivers/net/wireless/ath/ath11k/wmi.c      | 131 ++++++++++++++++++---
>   2 files changed, 113 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

