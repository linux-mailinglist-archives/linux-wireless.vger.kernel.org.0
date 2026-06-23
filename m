Return-Path: <linux-wireless+bounces-37998-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0O+aHf4sOmpv3QcAu9opvQ
	(envelope-from <linux-wireless+bounces-37998-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:51:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3156B4A42
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:51:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Z73kFrD6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Zt88dh8Z;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37998-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37998-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D1B3002118
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8B8242910;
	Tue, 23 Jun 2026 06:51:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F6372060
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:51:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197477; cv=none; b=OjUqUOo7f4XBt8hqy83OxOlIsRoiA9uNj1rQS09tkfhZun1WDMZFrA173dlZisfDpUQSDWfkaDitk/bue0PdsfuOz59Avvow6YORLVSxTRxCTneJnFWloD6bkW/42ltw0BFgx0fwrFAJGv8lWIRSjWKVAyZfTjUle3y2+bpfD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197477; c=relaxed/simple;
	bh=jqedtDbfjZ9+FQ/LJkPITy6lsUTeDraIGAaPEf6DeiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO6AK/hfT5FC0SF54qowmqBBsZuXS2VScecltqlf7jkt0Kvk6KZrGeMMV981TQMkioGHDP5AEqJX8HeoH5C/Q0QJSep3fNjx9W6bA9lTxJr+Kiq6Uvqu5ruBr8L+wN6lx1d6bdSOeYR/i0vHdM8cVPYB4yD/rdM1Zh/sLBfMN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z73kFrD6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zt88dh8Z; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cq3U3547311
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BmbqmGjzdyAIoxI1ZpFVf2sMOa8fXd/RGWscJvCHmNE=; b=Z73kFrD63B3QFF84
	sdFlaw/D5DZpOWbf2RFFC9LTxhbleRF4xcnl9YJNM8tXdHCqhO31W1xeh2qVzWLh
	pPMjjps8N6gCGYToD8Asfzo/JSQxEmq3Wiu+tZSYGizneINe3t7gt3CN0fDvOYXs
	47rQk1a609YOzPoiOyt3lz3HCjZB/kJYNgBD8A4ZEW/d/MMAHt/NX8B7p8Oaxwi8
	rQchkGGBSS1GfZ4AjkuBg7fiCotrHKvrFTFO/y50AaxWEePYPQj43NQ9+y++Ikzr
	n0oX3rh3HovciW3EVlzIbl297ucTyoEiyINKyRhGjcX7t9lIhBm2fKYhov2kBslO
	tFh/ng==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebbuu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:51:14 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8428419982eso4934745b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782197473; x=1782802273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmbqmGjzdyAIoxI1ZpFVf2sMOa8fXd/RGWscJvCHmNE=;
        b=Zt88dh8Zumwchs1fFOszJZRcr1WJAYb9zTxXQerYnwcTjs8X2DFywXy0jiMH5nQVNt
         JpQShz1w4E7DxVmYfXTcN4+Ff5gHPvdtOwgtBncNXwwjvez0F+v08pCA1HzcE4EzCjpX
         qEwG5K3B0xVVwldlR+TKGXwrxZquqrdPcs8M7FnDhLFXCh9X/Yl16xmDUQGn+rV+zbw5
         97cpq/GRzPGUxpopOWJv3aPA1YF2nzuXtDkHzbymY4AoFoRLGlyXRVhx3BjBHP3r3EeW
         FD7CY48KXzOM2znHbnE4hP4aZmVAFOubhNpbpBbz8mxSD+AeF/XkS114B+RplAg1G+ne
         U5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782197473; x=1782802273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmbqmGjzdyAIoxI1ZpFVf2sMOa8fXd/RGWscJvCHmNE=;
        b=pLV9wBELTkepJQOIf4M/s10TLnBVbJayQmHYgA9vuR/ZX1UT54iRClT9s9h0vbhpfh
         JHLoKqfhJwYl2F/dVEsnVFQ74XF99lGbnCLF88bitPF5L0T6bSizYyrWL86ZXbFBklNw
         GE8J5RoNhjUxa/pxR+764d2rhb/BuKrU3ZBCkqiOJTD0UKnp+yTQDUQUwvps2EEbexm+
         x6S3OTvJlHFA8SqHmfcyQAoNEMwjJfwcI/zgZdXzoDLRndzSwsuPzPwCZhWOCSzr71YH
         1dDz/rWr8Qg7NWcgaDWRLTYHgBNJHZHGMf9KgYAgiohX2UZvgGsjoFzXM3WReOQ5Omd5
         hrwA==
X-Gm-Message-State: AOJu0YzPk4ZacH7kiXaQ4vMqoyHWPyitqy6zXf1pUGILe6JaeiE6rY4e
	OLYmH0Q+iKzk2UzwAuLIm9uHt4zTzatU8E7CvrLyjdPzcxgjQwbomOetUdJCJfRUM9ZpiSfXX6v
	urZr1H9rCicrp7LieYNuP2wFFbBhEJPyybiLpE/eGc/0toxKX5AUiCcddX+hK1ZtQPTjKbjE6GJ
	DWCQ==
X-Gm-Gg: AfdE7cmnyVg39R/a3VCu/2J6oRV1+Zw6tJT/sTKhygtp4akTMIAVfin8dTkf8VUyIbe
	hpWksJ1/sq9jv7dK6ZmU2xAAuE6w9XIkOrbqN9Zbt/AAPQv3KwI/eHmmdpyPAjFZBbL+YrL2YVL
	pTV+VQttMPcXM6iRzjm1yzjfG8UrTgAwlKwNNX2F6Zm8D0rdXku3UIUY0WWfJslBGxgJK4/yGGF
	YScLe5Vxd7mE3QFa6ExI2T0mPvSoG0qB7HAZbr5Ro1a8VttXdJiZnSDxCTEyJbJqXiWAp5Mmb1g
	KLVfWdrmBUfHkjg7t+cgau8N6DT97Cu7evMWMmVAJB2gyak/d5+0dHI0+6Hzp0Zg2T0QMo8ddOt
	OPrKCnCZ972lG69x+zIHYGmHZDV5VapCPWJs4OMLp6Ca8kXvwph0P
X-Received: by 2002:a05:6a00:4f88:b0:842:422b:259f with SMTP id d2e1a72fcca58-84597097a75mr1497133b3a.10.1782197473424;
        Mon, 22 Jun 2026 23:51:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f88:b0:842:422b:259f with SMTP id d2e1a72fcca58-84597097a75mr1497106b3a.10.1782197472975;
        Mon, 22 Jun 2026 23:51:12 -0700 (PDT)
Received: from [10.152.207.30] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ef4c09sm10765352b3a.61.2026.06.22.23.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:51:12 -0700 (PDT)
Message-ID: <fd1adff1-e9ad-44e9-a94f-f9780f4a22c7@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:21:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: advertise ieee_link_id in vdev
 start MLO params
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>,
        Karthik M <karthik.m@oss.qualcomm.com>
References: <20260619-ieee_link_id-v1-1-36cf573cb81d@oss.qualcomm.com>
 <c5feff91-9303-492c-a031-1b2a1e7f3b7c@oss.qualcomm.com>
Content-Language: en-US
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <c5feff91-9303-492c-a031-1b2a1e7f3b7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX2sVBB1GwKcpO
 hqor/uPoHYvVypfHi1GFkn1V2Tr2vKUnRl0ymKJnQ/8mtdUYO/AJTwENMdyAl9i35oCigJnPjcZ
 LPREDVorF1AAR/963BJ2yFWWXfU7syQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX71dS8H7xakbw
 Jq+epkxYeNT0VlCn6XT6eVVaSnXcnK06955+6hZ32vq2HOqewiCmiTfpSDK1RPR8SkjBs3Aiphi
 XMDKHr82dcus96c8Sd9U0NMQJYIxHO7+GKyzJEkOkBOwRbp74m+2bGn5JRc45zTJF6mLyS7z3xh
 U+zi6Cg+l516xVuN/kTIww0rvr21P4HdES2K9INgkJluhcwjrrFTHzfBAuwcURWQYxDo/V/D11p
 jAKnGBuNz4GkaZVGnXbA4qPFOzJZIVXowc1pBpV0R1DGMDId8AJJglHtLpc+QQ74X3xinE9PxFf
 GYE/29kff/fN6SJZ/P6DVhP0cm+jL9/31Aw8Bvb/tncQLtX0n7zioiB8t/0cIO5kELMDuyH8Eot
 Y0gkVVdBcaCpgdcnpUYZ6vyqcuL0hQCR66MV7dg1JXpHzSY3/Mrt9qaf41fDWSPoTE0a5QiOueA
 MrjAn/3ZMcft+1RuAEw==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a3a2ce2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=YF2iN5IkIrNdiBgypvAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: QvMi-4nyyk-tt4YWf9Fv5OK5TJv0Ohkr
X-Proofpoint-ORIG-GUID: QvMi-4nyyk-tt4YWf9Fv5OK5TJv0Ohkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37998-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rameshkumar.sundaram@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC3156B4A42



On 6/19/2026 11:58 PM, Rameshkumar Sundaram wrote:
> On 6/19/2026 11:25 AM, Manish Dharanenthiran wrote:
>> Firmware builds the AP MLD partner profile from the hw_link_id passed in
>> the vdev start parameters. However, hw_link_id is not always the same as
>> the logical per-MLD ieee_link_id, since ieee_link_id is assigned per MLD
>> and not per pdev.
>>
>> This matters in mixed MLO and SLO setups. For example:
>>
>>    MLD 1 - 5 GHz + 6 GHz (2-link MLO): ieee_link_id 0 and 1
>>    MLD 2 - 6 GHz only    (1-link SLO): ieee_link_id 0
>>    MLD 3 - 5 GHz only    (1-link SLO): ieee_link_id 0
>>
>> The same physical 6 GHz radio can use ieee_link_id 1 for one
>> MLD and ieee_link_id 0 for another. Pass the correct ieee_link_id to
>> firmware so it can build accurate per-STA profile elements.
>>
>> Add ieee_link_id to wmi_vdev_start_mlo_params for the self link and to
>> wmi_partner_link_info for each partner link. Populate these fields in
>> ath12k_mac_mlo_get_vdev_args() from the corresponding vdev link_id
>> before encoding the WMI command.
>>
>> Introduce two new flags in ML params to indicate to firmware when
>> the new fields are valid:
>>
>>    ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID         BIT(18) for the 
>> self link
>>    ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER BIT(19) for partner 
>> links
>>
>> Firmware parses ieee_link_id only when the matching flag is set.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
>>
[snip]


>> -        ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %d start ml flags 
>> 0x%x\n",
>> -               arg->vdev_id, ml_params->flags);
>> +        ml_params->ieee_link_id = cpu_to_le32(arg->ml.ieee_link_id);
>> +
>> +        ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %d start link_id %d 
>> ml flags 0x%x\n",
> 
> %u for vdev and link_id ?
> Also this part of change is not describe in commit text.
> 
Addressed the comments in v2

>> +               arg->vdev_id, arg->ml.ieee_link_id,
>> +               le32_to_cpu(ml_params->flags));
>>           ptr += sizeof(*ml_params);
>> @@ -1244,19 +1248,23 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, 
>> struct wmi_vdev_start_req_arg *arg,
>>           partner_info = ptr;
>>           for (i = 0; i < arg->ml.num_partner_links; i++) {
>> +            struct wmi_ml_partner_info *pinfo = &arg- 
>> >ml.partner_info[i];
>> +
>>               partner_info->tlv_header =
>>                   ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PARTNER_LINK_PARAMS,
>>                                  sizeof(*partner_info));
>> -            partner_info->vdev_id =
>> -                cpu_to_le32(arg->ml.partner_info[i].vdev_id);
>> -            partner_info->hw_link_id =
>> -                cpu_to_le32(arg->ml.partner_info[i].hw_link_id);
>> +            partner_info->vdev_id = cpu_to_le32(pinfo->vdev_id);
>> +            partner_info->hw_link_id = cpu_to_le32(pinfo->hw_link_id);
>>               ether_addr_copy(partner_info->vdev_addr.addr,
>> -                    arg->ml.partner_info[i].addr);
>> -
>> -            ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %d 
>> hw_link_id %d macaddr%pM\n",
>> -                   partner_info->vdev_id, partner_info->hw_link_id,
>> -                   partner_info->vdev_addr.addr);
>> +                    pinfo->addr);
>> +            partner_info->flags =
>> +                
>> cpu_to_le32(ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER);
>> +            partner_info->ieee_link_id = cpu_to_le32(pinfo- 
>> >ieee_link_id);
>> +
>> +            ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %d 
>> hw_link_id %d macaddr %pM link_id %d ml flags 0x%x\n",
> 
> %u for vdev_id, hw_link_id  and ieee_link_id ?
> 
Addressed these in v2.

[snip]
> 
> 
> 
> -- 
> Ramesh



