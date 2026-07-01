Return-Path: <linux-wireless+bounces-38480-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zwK4NuZgRWqa/AoAu9opvQ
	(envelope-from <linux-wireless+bounces-38480-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 20:48:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F26F0B19
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 20:48:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="X7/VOqqi";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AzpQDeBp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38480-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38480-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 173B1300BEB2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0E39A808;
	Wed,  1 Jul 2026 18:48:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFB39E9DE
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 18:47:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931680; cv=none; b=mNK0So4+z0LHOjJ1AhORX8bMFm4zePJZCYz+k4oGiwGiJIoV9Vtc0XuumzIAEDABQ0mpgkQX3aqeQaEb7JD/8t04ZN+jgwH4avpL7dFeW02U4mxSbkPghyg3wpFLrFBV3jyGZyfI7s3nrD/YpjXeOeNLbh9OkMABnyXStFPqxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931680; c=relaxed/simple;
	bh=BE/f/1rXvLInz3pmufr5ci/5WEk2/qxHD9OgDxPPvI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tsn43024X2JYqAZp+H5xb3f5RLImTipfX5P0WNMH/6V8zO6rH7HDnavHhvnnCFwh5HVRZLrb/fMS/h7sG9yfg2d8A8nfFTmeOk+6XmT4jzfwxQGgvrjCinLiZNy+DxwogZ9ZhgcB6WnZ4PXwe6o7a8CcauE6gvEF0dzjJEC4K6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7/VOqqi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AzpQDeBp; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmWuj1710536
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 18:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	85Js3m9pm0S9QHIZ/FB4kgJE/3jd/T/kYM2D4Xv+89A=; b=X7/VOqqiKKBpJlMX
	hQOwYUUN852+/C5TBC/DFtAzzOMDdgwLi+kcbNM+9ZQpoiABJNxYEACfh99uJzps
	M2ZhOlL2QPUTFBOoVFwxq5oQyIURS1nsOpsxOZ0StsKbchxwdLdwtDi0d9bd2WRc
	GUMR3FbMJx/Mmb/AjvsQ64u/JZhxG3TZZBIVmoEMZjjh/m+oIm+M9Qg+rSHjroSL
	KZHDU5GSx3x5T5KnVPZiRe8+cNjbVUz0UCj+X17Rc3rN2rW9i4Z60Et4I3Y0iw4v
	vH1Ugrj6B4M7f6Pxvldxe2kZluyTQ+TZ0Foawcx9hYe5WOFrvjBc8DP0oHK3ZEFq
	YxSHJw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f56gprj0m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 18:47:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38096521198so1551358a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782931675; x=1783536475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85Js3m9pm0S9QHIZ/FB4kgJE/3jd/T/kYM2D4Xv+89A=;
        b=AzpQDeBpOOReLN2eWkKL32qv6jTMJNuZUkBmMVafknPNTmgTpxgn98xbgh/Xx72s17
         k45UfKj5p7D23/jDnY6l5pgJeSj5JSN2BaGzFCEsfYEY8+ROIHdg1Bhm8YQUjtICvFma
         Q+PI7B33UhTh5l3rrzwG9xXmyjQr1Bi/YZyxjVYEpo1tDStBNZkxN7ZNetIsTIB8BO5V
         xQ2MGI+SXyzVR08Jsu0/1z2jBssxYPj/hMx1/8DOcxtl1qiQ9yqnj9AJ1cA2eGkgP/L2
         ZGnI/bb2ZBj3ita9cQnXMxamR9Wfan9/Gtk03RL1RKPhXSMlAXdubs6fs37WUSe5ug6S
         8yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931675; x=1783536475;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85Js3m9pm0S9QHIZ/FB4kgJE/3jd/T/kYM2D4Xv+89A=;
        b=d8k1hjp7C+d7WtrIW1RnqONr8hcVXL/oSecKF1smpQI5RO+nbKVvFkl8+27SiRDm/J
         MUoNOLAPGVNQU4FDn0SWD/BOejNeFTptIOSUlvwr4PkcZfLz/03W2PFpk1xOTbJeeG4g
         D2NVik4v8Sz1sVPFu2t+Dpj9iEGVODzgUuL9jIPkW3T6YOfEYS37dhTadzplVRiviq4P
         kMfzAykkdczvQWNXuI15v+m5bfP2EDXy0+5n3qrbM49rjAM6IECBIFmhBaMyZNpLvbey
         Pis6HJ/BsQwAvkLbMRkLK4PsOLQPw71ojV2AcxnWgHpZpmSNJMOsqTceKQkarzSvpYhz
         dNHQ==
X-Gm-Message-State: AOJu0Yz9ydPoCQpu3/eymtuRlQUAcxtsy3Ufc3DDHXaxUIsu7ynTrKd9
	3/Rk/PkaPopwFHGLlRZYyRTejPjVvSxuh6qNn3IUgnLh1EFRH8SOBCi5c5JKUQN6aG70o3Z6968
	s0KFZK5tbWnVUqnmZsfdY04Bn0LRkXg5Xe8VG4XIi7CcYgavqIgOIXBlNF3v9AR6dP/NpzA==
X-Gm-Gg: AfdE7cltYs3ZHxOi4UhyxOjXNwwob3NQVTd6Umq95Mxhxx3enEn87oQGs0VZ+cQMFL+
	xV44qrtxUmyekk6p9iYLmmSI19OhZVgW7UScejzyDVbAxsx+1/i/1UZLzLrY1PVtZqlP2PxjzMP
	igwRyjKPOgaEBnOFAqL+GPjR1gtqS0esFoVJP1vvPBaKiBX+VXPKDo7HTe7378KByxVmKrvUIG0
	FP8oD5AsrGkzby7H0wCOAD7kRGWqlVdc/qCANnV3A176LyO9J0J/6JHhSLqsBH1qC6Gof/NN4bl
	HXLmaTAE+sxIsCeq+xyYxIWEmZbKY/NmB8nJ2XLlpgHVNzN3pOgLGXbKeInsbdY8Df1G4tVg/p1
	VCsFrmeUE0INJzjc+DhT0ndH3dTYLS239jCsmO0uwjJUh3m7EAnlhLcYxXlfzEh7P2/BrA50=
X-Received: by 2002:a17:90b:510c:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-380aa18d0a8mr2656572a91.19.1782931674736;
        Wed, 01 Jul 2026 11:47:54 -0700 (PDT)
X-Received: by 2002:a17:90b:510c:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-380aa18d0a8mr2656538a91.19.1782931674142;
        Wed, 01 Jul 2026 11:47:54 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380ce0c25bdsm344196a91.12.2026.07.01.11.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:47:53 -0700 (PDT)
Message-ID: <85a5f48a-2eba-46ec-855b-c4f7abf8e264@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 11:47:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: fix stack-out-of-bounds in
 carl9170_cmd_callback
To: Christian Lamparter <chunkeey@gmail.com>,
        Deepanshu Kartikey <kartikey406@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,
        tristan@talencesecurity.com, TristanInSec@gmail.com
References: <20260424031711.53104-1-kartikey406@gmail.com>
 <26e33fea-c81e-48f4-a058-4b3bf0dc95c5@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <26e33fea-c81e-48f4-a058-4b3bf0dc95c5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIwMSBTYWx0ZWRfX1KmrIpsGUFhl
 TiL38m/Yf27aV7iw050piaJG9fpl3jSVbfbJ9Ml9L9rBmysvqfd/LGnQ8juxDSG9ockO5POi54W
 ODKnCcC40p6cucMatg9gTRcEPsK4oIw=
X-Proofpoint-GUID: 2RLoAyI-DrQ3qdC4twIqCXi_et08_8El
X-Proofpoint-ORIG-GUID: 2RLoAyI-DrQ3qdC4twIqCXi_et08_8El
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIwMSBTYWx0ZWRfX9AA3rQ4ecXOj
 uc/121LEzjpovXiyWVnl6nE61aXDMcZDbzE1u0GurGYPAW4uEhNkKSNrOwIc7tMmmz+ZCJX65vQ
 nCW76DQLX7oy8CR2Yc0KVtw5+X7dIjLTXuyh10/MuLnuWsfInpxd0F54Qlf+ifrB4WpWltFyhWC
 XVZOMNeU3nS7MfIVH7VwhA+gy1r459MwAe/LiHNx2Mzr4kKEJBBad5QMHmIn0xac5C/26mkcG4c
 M1aG8sdH6UrHZdtueFIT+GSXYzZDkl+LDKdQQM1X/tJ1Dc9SIzjdIb3B5/ZkGqVXzRLkW5HfhoF
 LPMx81UqzBXyQDW+ZPa+EN+u1h5gctMRIFoKCkhEoV3wQtxlwy8IsDGuHbyXFgJyaXVtqDT6t4E
 YQYrbwBaEHESNMuCgjkgerebtI1QyLoTvjyg5uOO+yZdGELWGNCbTSkyMUrBK0hbjrN63UvC8b5
 2AexPtt94nUHoXSL9pQ==
X-Authority-Analysis: v=2.4 cv=K9oS2SWI c=1 sm=1 tr=0 ts=6a4560db cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=oAVE_eoOLsoIbNkDC6UA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010201
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38480-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,talencesecurity.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@gmail.com,m:kartikey406@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,m:tristan@talencesecurity.com,m:TristanInSec@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D53F26F0B19

On 5/1/2026 3:17 AM, Christian Lamparter wrote:
> Hi,
> 
> On 4/24/26 5:17 AM, Deepanshu Kartikey wrote:
>> carl9170_cmd_callback() does not return after calling
>> carl9170_restart() when an invalid command response is detected.
>> This causes a fall-through into the memcpy block below, where
>> ar->readbuf is written with a device-controlled length (len - 4)
>> instead of the expected ar->readlen bytes.
>>
>> A malicious or fuzzing USB device can send an oversized response
>> (e.g. 60 bytes) causing a stack-out-of-bounds write into ar->readbuf,
>> as detected by KASAN.
>>
>> Fix this by adding a return after carl9170_restart() to match the
>> original intent stated in the comment ("Do not complete"). Also cap
>> the memcpy with min_t() as defense-in-depth to prevent overflow even
>> if the control flow changes in future.
>>
>> The bug has been present since the initial driver submission in 2010.
> 
> 
> I've seen this before in a mail from Tristan Madani (CC'd) on the 13th of April 2026.
> Unfortunately, he didn't post this to the linux-wireless mailing-list. Instead
> he went for the Security Officers <security@kernel.org> , so I can't provide any link to it.
> That said, he since changed it because of the notes I had about the driver actually want to process
> further so only the memcpy that caused the overflow was modified with the same
> "min_t(u32, len - 4, ar->readlen)" instead of "len -4" as the length:
> "[PATCH v3 1/3] wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read"
> 
> https://lore.kernel.org/linux-wireless/20260421134929.325662-2-tristmd@gmail.com/
> 
> So, who should get the credit? Maybe another person will post a patch soon too? Who knows.

My plan is to take Tristan's series once I get ACKs.
Any other contributions that conflict with his will be dropped.

/jeff

