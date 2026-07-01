Return-Path: <linux-wireless+bounces-38473-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yFWYNmc/RWpj9QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38473-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:25:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 762426EFC22
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:25:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=a75MgahK;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MRlSXED3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38473-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38473-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F395A30795F0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F63672BA;
	Wed,  1 Jul 2026 16:24:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A54223DE5
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 16:24:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923086; cv=none; b=SIuQzRgd6OnK6Svot1N2Q95a8USpV3ibjUvTvvKSBU0JbZnrwnFUoy0SmTsHUVHVtLYODgtQNe/Yl2Cl9LiPa5gdp6fDbutmdLWwtSuzUmM7nozIyWpbhrX7Nh1p2Yj88jt9MBKLEWQYmSjLhjxh/N3bN3m/9zyPnPSahQjPsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923086; c=relaxed/simple;
	bh=IiXCW39L8qZ/FCleYiN4eX+8DvOuaRhCzIdAT7ImgXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azTgOxaGTHhSAx8dGi427hzS6TCq1uIM4zzuBHeozodRESZb24AMwC6frzkUy1RY9wPg4+0J3DlOGSUHghRm5JQOVX6Q7DQ2eBWA4sL9LdTxC4RckdvPcN8/XPehPnXU70dlTTVATRZu6isqn1JEXsN1T81ksQAvVlcThz6gywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a75MgahK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MRlSXED3; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoCxh1553071
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 16:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BrjnZZ6CJtE12NiFM1sGcczeJqgfAHOuf31KphptjEE=; b=a75MgahK+5eRm7WT
	6VrUFgPAdZdcohqsDJ5ggjmOCdJIOz0a7KC/pdJjK+Lu1IlbkLp14kkW4+GVwzGD
	R2x2APWkZgQu21FJr3QC8jfHWDDh8+C8OCTDdR9xLZuD7HGRzEoIMIMqU6/Kz/Hs
	G6qNGsKgIw31OEwcT/U6XBw4e1ydFjLtxliNKux2509k0abj3bGuw//ZMYNsnVtX
	3ih6z+9zlx/BnWZhHzs6xteSFxKOZpA33+m5R45pIrPNHX9SwGw4LNdngbPi6zho
	Go+sIWTY8uF/1X1cTk7EDAEBNkApEa+vF9kwGpfFjPEaCG9Ffpf3vWWWyNfS2Hcg
	MnFcTA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd1kjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 16:24:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c891ed872ddso641521a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782923083; x=1783527883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrjnZZ6CJtE12NiFM1sGcczeJqgfAHOuf31KphptjEE=;
        b=MRlSXED3hVfNegHshhJv4mt6ONpPGV9EOqdYPLEpLXuJqIzxLV1wIJjvtazYSf/0jd
         lBjD8gbwBv/PpqmW/Z+jXjWq/J+Xnp3KveL+hVi0QeRxk1upmknzjHipiQxOCEG7WNAY
         KxsqXH2bqUU1ze1jli2CnNOPUU4ntWaRcNsoOG93kPa7RLZoYV1umcopPxZcTIRrm/QQ
         8b7pQdlU7ZTD1fBNNtLnCSN0Tmnh2Phszeq1IXxsYgJkyAq5x6AXbunlWy+1flsZOaGB
         VaLq0Imbf9h8AdWJbn077gVVPGXPxwJKHHz8Io0PbSD3LHuvGk+BJRQ6GATNqrADtISj
         pVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923083; x=1783527883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrjnZZ6CJtE12NiFM1sGcczeJqgfAHOuf31KphptjEE=;
        b=bSbRgfPKy0TH2qkW1aURAu7RJwG0PF1cHeCS32Ucfg6vr5elh1WlynlRrvQfJqqjKC
         2FN3eUeLsoavaWWi2ocdc+onSyxcKspRD6aPGF7966LfXhClKN7bxXvSlK1FDaghay1I
         QOv54QfdmzX08BjavQkOYbI9p0/aMUEsQudtfQ1xss0mf2Q+4dy+HhS11CYdGJ1hTN+L
         dWE31eLm6lNZq6mrURrRGImEG2t5KAlKrVq2SGEy6VccoL/LT6rMqpYZioqpsXRkkhPb
         nyX3ScMFNw1HwRBhGStiWbe6opChYpXdkcAYZjnjHV9CNfEL1wLeSWnPjrwBvlh4RRfg
         XoLw==
X-Forwarded-Encrypted: i=1; AFNElJ+ii0pT/L0ZBfjgSuuc76t0aWK6+LKn59pYEPTn71mck+e4vLrKFXIjyWu4qUkqkjJPJKZjW9gWd/gpO4u2UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTy6RUjJRvKvxoyUkyh14Yf02ZJWwSO7bIgPLUi1igVm016VYu
	G5EMPer4qYuwpttYBSWBjR2/Cw+DbQphQFu3IQ67N+jZzxV/thW/tNzsa1G8mhpPoh0banReBz9
	a1gQzKNE+rFnGsUbtJGpH9jk5d0CIfllY2Xf7CV0jCIcgaAB5XJ12S4jx8O454zswp/3Fkw==
X-Gm-Gg: AfdE7cm5qrM1ucRRYSIzzCb4qXdvxKxaOaH0t9l4Z8hM+1mDubgaWLisi56lRVHy+Ps
	fb9A+os6Y4i/WRrT5fZMDbzGX2dQ3RUttvzj+BcjTNDQJptBsxgz0T5Um69XUJNmHrtzySVjSXX
	IAmKMJS8XL26tEMN7gizqRsAN8Mpefn+E8QUbofxwaYWF07KmZvWjKkHR5z7mO/woN9LQPIhn2A
	xEiy8902RLSRaR2Y67qqOQBZq2nP7QK+NCOm/DOwqTyxItGqgwGlpieLyyv88QYih1nZMKEMMZL
	7Sl8j08Zrekk3Ni4vP0VkOdDEEJiP0HFXlNV+2a6xoDZ7Bmz05zl8wldg+IZ5ypDpcLO/Ww7fWL
	/SBtl/9WKgNV4KqGmUCSxN0jAZujIzROhpJIMXZI+LLOKW/gua03Vd5viI7mRB7w2mW8pxI8=
X-Received: by 2002:a05:6a21:6196:b0:3bf:6c05:aa with SMTP id adf61e73a8af0-3bfed53552bmr2528823637.57.1782923083370;
        Wed, 01 Jul 2026 09:24:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:6196:b0:3bf:6c05:aa with SMTP id adf61e73a8af0-3bfed53552bmr2528779637.57.1782923082868;
        Wed, 01 Jul 2026 09:24:42 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2cd21bcsm44619867eec.0.2026.07.01.09.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 09:24:42 -0700 (PDT)
Message-ID: <8c662e03-0a7c-4a20-9a29-864aae23be46@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:24:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath6kl: fix OOB access from firmware ADDBA
 window size
To: Tristan Madani <tristmd@gmail.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Tristan Madani <tristan@talencesecurity.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <178243229402.3653332.17576562809691611363@talencesecurity.com>
 <34ad2c6a-b9c3-4f99-97a7-e58fb22e2e78@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <34ad2c6a-b9c3-4f99-97a7-e58fb22e2e78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a453f4c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J_-Nd1mkAAAA:8 a=pGLkceISAAAA:8
 a=Z0swO8mX9np9Bk_veI8A:9 a=QEXdDO2ut3YA:10 a=WH0m3Zn7na4A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: mT8f2ZJ4PS7_7IRwy_cwBF4oEkkk1z5_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3NCBTYWx0ZWRfXz6NKz8od2TQ9
 o9Qn5ZRgnPZV+NQIszdkwRZ48QUrlun1DrgrmL8cNc/OVZFejK/q6AMJdOSf0+KpCYKYbduoum4
 WYktHOgr2aHsKcqkMJm6bicYfbFqV2Y=
X-Proofpoint-GUID: mT8f2ZJ4PS7_7IRwy_cwBF4oEkkk1z5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3NCBTYWx0ZWRfX9f3Yq2AwINSh
 CssJWEZ+Z/y0uW7vNmJpeuZHjuUMdUwNsirMnbGnYeIk6glvbmrP6iGI5SrbqVpRIEFLY5AJm09
 tmbNO4EXW9hAxVVPFEGf6borCYnJjgHW+oJi+cAc71Wl/zn+rdHoito3ck6qHSHMKylscwAplV9
 0BxctvVYXknCwoypudF5us5zIwLN3K1mJldH/OGOVA7loFHmo3ExZ7UE6cAA7iENnSRA52YdSlA
 Xt6zm8Z5NBIPGCtu5Gybcj51XrkDD9SoyVGWcJfPBK2+GgUD5WNm/0b3uzUYO42Vig2NMFtx9ZH
 4urloM1wdhWpdu6oKXBHUG2XtVulsVGCXjF1qXNRhiGxA//0pR0Oo7FBaPGWFjgvmt9AhXzjvvs
 15rdZ8qEDon/J//0uWKqDs3pjdz16akCZQBEdfFeNBojPZdHdFCe7ZFxv4cPcemdMVKMxj3C0Le
 Cd1Hy1wXZF/xUEGCtkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38473-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johannes@sipsolutions.net,m:tristan@talencesecurity.com,m:vasanthakumar.thiagarajan@oss.qualcomm.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,talencesecurity.com:email];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 762426EFC22

On 6/28/2026 9:57 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 6/26/2026 5:34 AM, Tristan Madani wrote:
>> aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
>> win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
>> return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
>> compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
>> zero-size or overflowed allocations and subsequent out-of-bounds access.
>>
>> Clean up any previously active aggregation session for the TID first,
>> then return early when win_sz is out of the valid range, instead of
>> proceeding with a broken allocation size.
>>
>> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> 
> You can remove my suggested-by as I only provided review comments on your patch.
> 
>> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> 
> With the above comment addressed,
> 
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

Can you repost a v5. I can't take this one since:

WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email address mismatch:
'From: Tristan Madani <tristmd@gmail.com>' != 'Signed-off-by: Tristan Madani
<tristan@talencesecurity.com>'

You missed adding the From: tag in v4

