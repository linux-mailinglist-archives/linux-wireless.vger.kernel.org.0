Return-Path: <linux-wireless+bounces-38914-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RG+yFgcFVGrdgwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38914-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 23:20:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA37745F11
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 23:20:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BC5Rb8O8;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MDQNquNH;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38914-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38914-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EE223001CFC
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056DC372055;
	Sun, 12 Jul 2026 21:20:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC535E930
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 21:20:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891201; cv=none; b=l3HUf9OmvDSq9yKPjW1+ufbOJEU12VllXxkfvm7ADs9+iMKdaiv6oFvebtSQUqPHz4JN5DM5FsCfz+9XkjDM7fCObfd57YePBde/EBdH3g2Hgcgd9qzowYGW2FlqumM9EPXY9zaEb6M31PtCvJuKEnZw+/QwJ7boTsXMXOhcmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891201; c=relaxed/simple;
	bh=ZfchmFu0ZqmZykPSkCTJ5+FnYtcFYRUWgjt3QCL8SbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=El5RyIejuRF82Z847+iSlczB6azz7YL6sFEQnWcXppiPn/Y9k12/W1dMuj0syShsUdckQWXQKC4F+B120oiQA2OOepZDyadDL0rs6uae8Mg/Yn6VTR4c+qOGCdeXoE+gy0vS3yQGV/SziorRsjuCHpyt9emFf9Lhid2Mea5iofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BC5Rb8O8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MDQNquNH; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CKBxap3368264
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 21:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Co+UTMDcWwfARkoO3RPsTqIh+BIZC4J2WRE/abchvVs=; b=BC5Rb8O8pZ3VcZwZ
	t7jdzHC//R+2KKdKW6viJvatzCZJNgG9A9dEXLVRr4BCgyxw86zUDoemZ6drrP9m
	crX7EYuw7hhBKUhjxrTDKEmlXBGL9P6FOHQmfOH27lCYcaVQGgPq1rc/0fOnFWm7
	p5G0gu5wy9ymCM4twrsxV6l2HO06zkB4Oao8jMxKNEwdXZzLXFQ4GuKoH/wbQRKT
	3o6TQ7f/R0jDnbC0rabqD7tqAlWqvreOdRKlOdTvIjKY2Sn7iCLVgxwCqHBp4zZs
	tflUUaOhUvXYv9AG6FWQxhYLac+JYdkQc4OPpVtF/shrJSrpoeTrc9JU8+L/3DrU
	JfcD/Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9kk98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 21:19:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so3528160a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783891199; x=1784495999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Co+UTMDcWwfARkoO3RPsTqIh+BIZC4J2WRE/abchvVs=;
        b=MDQNquNHBvMb4l67YOGCixMJDjdzMA/nPUoWTTWXyFQqT5CCNu8Z8vtohnAeI4Q1T0
         kF/zRFN+MEcWWYJgQeNN/oKZog4iEsQPWsDXj+Eb8elbz4WvFAV6/C8s/M4tB1tkmSb3
         ZH1GlVMvrIIg0ARO4lde4Iy2BsWoizV/nwxJrWfOpPtbzyWxFp9/DiDE5ug9TRGYehH/
         a+0/N+KtthE+rzBRjHn8dxoJEcIiMq9dtzhlzGa3X+x1nJNy3SkoMBgPdnoHcpPCuwjX
         lVADG1YrfHicr24rtZloVBaB2NSFJmlK6FL2dJIHF6Hx/y4QJ5QH1ussbVWkEgxpXfUg
         mEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783891199; x=1784495999;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Co+UTMDcWwfARkoO3RPsTqIh+BIZC4J2WRE/abchvVs=;
        b=V7eTwWCbtEJRxJVDhWuKa1NmV3QdU48CHleiVm9lLcGx4zuCP2hmsMcAbz6WhPq+FL
         Ed+htc3F2lqvNe0e9i/f3DftOV/kB865MzeilzGVHxyXyCZ5HKZO77gTVNQPunJGAWUu
         BszJTeIOwgX5Td1TD1p6DOn06neexlnz8s7KlEYEv8eUMgfvClgNutA5R+rp/nRhaSS6
         x+2/5zeMM/KhMsjU8Y47bj9XRrcn9EkYzLxie85v9AhZfNlEixAu+ugVkddXDiM9Dvgp
         4lxogPTthFwo2wHMXYdgou5/TkTr9kS0FgQPFE4I5+bqs7WtXqlJ1YSiUml6fYqtb9hF
         TN4w==
X-Gm-Message-State: AOJu0Yyl8P2zDEYx/St0jdYAAdjZCw9Jcuzk7IsC1LzIau7r66FmZO5v
	sUbd3sZVeKd2GuF9J7SIp79S7jaaIw1Aqg/I3n4DcBrBBdhhWA5GQXJ34pzK3+Uw4cdAE8MVu3c
	5uVhl5IykErpxvwrL5Qc19/ScpjpkW73lQHbD2xz5CbXefSTn8lcS3s180o+S0J9HZUdkeA==
X-Gm-Gg: AfdE7cnYSQ6wnvg6E7DgTJYWeDD9Au9AN6h6jPHQGcW3KRQpCPJC+KyMdiDn1nQpX7V
	5Ieic1nrMlgxEXKnDFDwI0I09AT2sRSMqXW5XsaCD8BshU76rDEAHhiXTOP5UfDuTNFCTqW5Ecy
	6//V2i+HpejXlAw4Sw7AFxcE/yoY24dLZwe8yPloONsz3m4Y7+Pdd4z1ejze61AwjT5EmX8RQCm
	L/tNw7aK5j4lNMH4oT/S5gWu0WnD2cE9zX3p/Cmi43qnhWZbsiXAeYv7PhrUOe9Ho1Z1TwGL4iS
	M3ttUgBgR35Zowzu451MPJoW731BXdyCfapYahDFW6UwlAVaCLism5Jc5NceSgz7/xcDxZ4pPRS
	G4rmCjMKOFk74ZlI4wo4GYM/v2f+4n4f9Ts+lRjvr+YqdtKOB/Imdlnq8uLxYZSHIxzeK
X-Received: by 2002:a05:6a20:4324:b0:3bf:80a5:51b0 with SMTP id adf61e73a8af0-3c10fb6f300mr7554138637.0.1783891198659;
        Sun, 12 Jul 2026 14:19:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:4324:b0:3bf:80a5:51b0 with SMTP id adf61e73a8af0-3c10fb6f300mr7554114637.0.1783891198177;
        Sun, 12 Jul 2026 14:19:58 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8fc7c088sm15707591c88.2.2026.07.12.14.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 14:19:57 -0700 (PDT)
Message-ID: <3c02ccfc-7e3d-474d-9ab5-a6b5ae187fa8@oss.qualcomm.com>
Date: Sun, 12 Jul 2026 14:19:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix scan command endianness on big
 endian
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260703-fix-channel-list-copy-v2-1-372c39306d79@westermo.com>
 <afbff608-a005-43c4-af76-968a58bf0cc3@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afbff608-a005-43c4-af76-968a58bf0cc3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDIzMCBTYWx0ZWRfX9gS6NT17crGX
 6se+YGzvrDQkQqlZHvIyvvSwpav+U56TQpl3gwOUTVZY6iN2eGxoioC6g0yUOjDUX7szhCKTBLt
 rOGsPeFU05bH7Xd2b5jjmJ5hIEVB5mo=
X-Proofpoint-GUID: xcb5GMgcgdRFghvopLnbAPBs60vjr1nD
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a5404ff cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=loD7mlZLawVs_UXLojYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDIzMCBTYWx0ZWRfXyeo9AVswe6DO
 WZyGANVZg85gTxDH3lxA6LUWs6Bpilgfr+I8iZHk2srKg7jL7XUMcDbsTxnQ4uiskHQeJmstDhG
 KHMnEBLK81PiQgmzO+6XMQtSj0+DFBVlD/OQxf4oVf8ucZXsMUuAwahbN6LOPONuy/1TmvcT0Oy
 HoPt3h2FnBIB9FoUhg0Tz4JA5tx2b4iqfp+tcFBrZhNbhLZuBkGOon6B13RhNS1xnKex6aBOLdN
 y1DbBlPv5fBclFiTPHNSMuKXxc88qGJH/l8iLt7Ynx/JEix6tLsvyLaUwlczjRFpdUxQjJ3rv5x
 Kf28QzeU2wGOgguth+XEv7utFtOxWLAGO2IbQ8GrIU7MQz/d4BEXQf5gF8vLe6+6n3bc2pdmqhW
 s9aiqIWCJYyB8A8Ey8EtDntCpHCWGV5IWxJKtMpuIqEzTwJ4rqQO6X4iIhs7YJu0bMFOV3L+j0Q
 WGA1sjz5OnBiBO8OL2Q==
X-Proofpoint-ORIG-GUID: xcb5GMgcgdRFghvopLnbAPBs60vjr1nD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120230
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38914-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BA37745F11

On 7/3/2026 1:18 AM, Baochen Qiang wrote:
> On 7/3/2026 3:35 PM, Alexander Wilhelm wrote:
>> @@ -2795,7 +2799,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>>  		hint_bssid = ptr;
>>  		for (i = 0; i < arg->num_hint_bssid; ++i) {
>>  			hint_bssid->freq_flags =
>> -				arg->hint_bssid[i].freq_flags;
>> +				cpu_to_le32(arg->hint_bssid[i].freq_flags);
>>  			ether_addr_copy(&arg->hint_bssid[i].bssid.addr[0],
>>  					&hint_bssid->bssid.addr[0]);
> 
> the src and dst are wrongly swapped, should be
> 
> ether_addr_copy(&hint_bssid->bssid.addr[0], &arg->hint_bssid[i].bssid.addr[0]);
> 
> However since this is a pre-exising issue and not related to endian handling, not sure if
> we should fix it as well in the same patch.
> 
> Jeff, your thought?
Fixing this should be a separate patch since this is an existing issue that is
unrelated to endian handling.

I already have an AI agent fired up to verify the issue so I'll have it
generate the patch.

/jeff

