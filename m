Return-Path: <linux-wireless+bounces-37957-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sVYjA8qsOGphfgcAu9opvQ
	(envelope-from <linux-wireless+bounces-37957-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 05:32:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569DC6AC4D7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 05:32:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZscfBkx8;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=aXgxc3we;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37957-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37957-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E12300BCB6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36DE25B0B9;
	Mon, 22 Jun 2026 03:32:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A11DA60D
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 03:32:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782099131; cv=none; b=rRixzf/7pQ6x2yk7hXi3o2rtTZvgRJ05sBZO3ISmLMTuqQvnAYyEmUpJuVo7YX6PrmH4RswH0zyf3/LhPairLfxfKDceRsFuTutWX3rgoeQC/oVPRd4MKIT8JdWlUCyjJRWkTx8E6qWt7RKmjDQXBweVqubWh5pLGLwPr8WZ5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782099131; c=relaxed/simple;
	bh=sav4xJiruDNM7mB3BOpZtRH0lX78ToeWWCdpo2uftVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAAxD6H7DZ452wLEW+/4NeUTvajvvQN5HYfkFY5Ourq0EQA7Aejx/7Xbwc8nDwNZ1p0vmTNQIfjfAXMl/aYQv2VHB3xTP1zSSg6W+/6OqGwxtfD9paHx057s76WNVZqbMqJJh71vigEe4QsB5TSzN2xH76ZGF9PFXp3v4eZ/Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZscfBkx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aXgxc3we; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LDtvMN2486771
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 03:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pJa1DnynoCbIJLjtDNqzEZsjsyIjhRDxhun7EqvtLrs=; b=ZscfBkx8tfb0z4l4
	+xApX2qVJQfeZOrd2NTR0mCsmLxQ5H82n9GsVYzPw3AxbkIqrh875UNhmzMCyrxX
	HYCtH9vxIPCl7x5S2TuT/1i6jYsHoSQmnSFvxmoR5LOtNako80SvbFQQWPsKp+gi
	3cKayy1R/W3FUW8M1m9CYeMYTkh6PXoxQzD2LEqHDAEO1WZT3mhBGmAkDxzxMCBz
	k+vKdAgJaHMIQ5gBp/w4N1FZ/+GNQHvUoSQYEhN4o5W6HUn4wpKNzqo9yjdHzQIe
	F6nCXGtRAMppthpMj0WDCppy+wcX0xps+x1xtKYp0C10CHbbHjeSv2v1aQdvtuSb
	aGNc6g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewg7mmvt0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 03:32:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so4826849a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782099127; x=1782703927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJa1DnynoCbIJLjtDNqzEZsjsyIjhRDxhun7EqvtLrs=;
        b=aXgxc3weVK/ptXnRbXfGrvJJhsaivnpK2kMSjWaZDq2sYkOUH7wgQ/olr9L1Ep3pHZ
         Tg4sIX5fNr7VjepPaedAkeLO0ABjS/qUsWXBBRY1l/QYrXgrOvXeXAcg4l4cvKqpRKoa
         v6mWEmVMhMnx2D6JYIJgcWE0pgSGSo3wWLv5AhEPSzyn5hZHlc3uF3TBuvg1dQE6iIgB
         73eoddmHmccTFcruL+azYA76eB5t8BoFCpynWcvLlTDhJXdjQxwe2BFIMjmrPINu26az
         FZXoU3nqIubBamdhlkcS10TeBiXgi/T6IoswPnrr1BMzf1ToboFUjLyWdeK51qRdObQD
         joSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782099127; x=1782703927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJa1DnynoCbIJLjtDNqzEZsjsyIjhRDxhun7EqvtLrs=;
        b=Dy1KgHfYprz3GRTxR5jM7eqaWJVcJyeuekFGpkjoqXDqy7wJ7mECGbPDO8rDr1n+iT
         +LU2IMgEaI3ukQsCosVoAxSKM35kFz6SDNXw3gBD5N+CZacpsd8H3rQt/BPEpyzy5KZQ
         heZ6xI/FdStWMo4gqgEz4lFWsq7IjAQ7iHTDDzSzSxYjYBWsVbmq5yyZ9N1SR103JBl/
         qJCualMggdtuqgRaXDc50KjvTX8OMkRfH3OLg/prEqabrCMgcRExC0LakEGFnG4TA9r9
         i9X54zdQ0ZcnBxdQDnvphgzlSD5b1diHRR9N0cd6WBO652GbyED1uQon0VdPlE94Hwvl
         Asiw==
X-Gm-Message-State: AOJu0YzDQY31a6F6wss01HudVcewZCBoP634L89GvcVvAjygCjWMTII/
	kEL5TLisT43Iw7NhWnERLRSOE2ed9xymXdUjZTuHE0NJVGc75pZK3RiajxQN/3eLty1qYLDXVhL
	u064tqPJHPjr+5EfpIwCTxUdodyPtC9zyY3xSeAnZulViDGUcQ40qpeW2RJlKkwFXv2MrZw==
X-Gm-Gg: AfdE7clUEE+UmLG3fZoEesbRvv3KCyEK/o5s4PcMThjskTzrsyr0PhiwpWUSHd6Goib
	Bi/Me6EBRrAaViYIduQe2xo2Yq+0VVYA7B/RVBf5UquvYSa0Ihdzq6POPExES4HkOzsVSQ+Sczs
	phm9OMpGdfkqcBEcSHZNMWOO3C6Ria0JEpiOQbM1Nqbe97p0rFPnAz+BTluVmn5Ag5viFq2u1Zc
	17mhWNE3Fn/t6W/x0hhLLFAuP+ujBlWNLEpiQG0gyDM0imm3rMbf3kmTZyP8xZFUgVlw5Yk4lM8
	iRdmMCf/TdrW5oYt/2QZUvUpwYaE6o3aeU3R9JLts3cdTVp4mLoVd8/fUX16EPAuPPzyE23Zoi0
	dV6BGhKbtHIDwV+uVZbWW7ijTWQQQh7X/jx9yVWzh+LrfOguZQ9ze
X-Received: by 2002:a05:6300:220a:b0:398:a33a:71c9 with SMTP id adf61e73a8af0-3bb6c9cbbe1mr13694476637.43.1782099127414;
        Sun, 21 Jun 2026 20:32:07 -0700 (PDT)
X-Received: by 2002:a05:6300:220a:b0:398:a33a:71c9 with SMTP id adf61e73a8af0-3bb6c9cbbe1mr13694446637.43.1782099126957;
        Sun, 21 Jun 2026 20:32:06 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.223.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8ee89sm5551794b3a.20.2026.06.21.20.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 20:32:06 -0700 (PDT)
Message-ID: <630fbc17-b8d9-40cd-a151-6af8fd9ed979@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 09:02:02 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDAzMCBTYWx0ZWRfX8fPYO8LRzDjv
 HX2uaHJTU5ce2SeEkMBuWXhXyHKjGNqsugkSucQ71vkbdqCcWIQg07rFpE+IXvmVbUGeQL1QHS+
 TzPEF9MFDjd1J5u/IhxugOIfsnBmD5Z8Z4IpviXRzVnK0jIySwOJGIv49YIgOM0BNhrPiX+Rvgc
 BNpI1RX2HP7PfwIH4ssv2zzlyXumZPGmEWc91E2EUTtAnVNJkvg43+Rd4Zjs+WTDAtlZ/acuMbb
 m7rblk0+cuPvtItl9FkpTNbqf2JtsbCnlccShdlVZCRuejfC/GnOVCttU+YFTxuTyC7nd9FDFD0
 +EzfLa1xn10pXmJaveiF8hg7HAhSIh4YevfRf1g5tDuPnoC0mBp6HbfKzDTbfL//KJYKhcPo8bp
 +yrxNhy5Yn/WbDdqIQuVkNAft0rANlAz6vo419NQgr+oJshwOlRISx2/UtHG1a6t2HcsepDRB57
 R0v+MizMChbTyqmF1yw==
X-Authority-Analysis: v=2.4 cv=IOMyzAvG c=1 sm=1 tr=0 ts=6a38acb8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=BF6w7GvFs2xbIyFlm1owPA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=b4I1gYfj5rPnem_N0rEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDAzMCBTYWx0ZWRfX0iGVDPgI6pRH
 9PRU8v30Sy9AhEtOSspp4Jz91KZ9Y96o47gyn6U+qrjGnHlHYQPBC6QEAWNWPvrAqB7G1fNTATX
 AxELPQpwnyDDiePamKyhYpDRq3D3J+w=
X-Proofpoint-ORIG-GUID: CAJdYeR2gBX6_6ikS7da4F3cuPLjEefo
X-Proofpoint-GUID: CAJdYeR2gBX6_6ikS7da4F3cuPLjEefo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220030
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37957-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rameshkumar.sundaram@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 569DC6AC4D7



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
>> Co-developed-by: Hari Naraayana Desikan Kannan 
>> <hari.kannan@oss.qualcomm.com>
>> Signed-off-by: Hari Naraayana Desikan Kannan 
>> <hari.kannan@oss.qualcomm.com>
>> Co-developed-by: Karthik M <karthik.m@oss.qualcomm.com>
>> Signed-off-by: Karthik M <karthik.m@oss.qualcomm.com>
>> Signed-off-by: Manish Dharanenthiran 
>> <manish.dharanenthiran@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c |  3 +++
>>   drivers/net/wireless/ath/ath12k/wmi.c | 32 +++++++++++++++++++ 
>> +------------
>>   drivers/net/wireless/ath/ath12k/wmi.h |  7 +++++++
>>   3 files changed, 30 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/ 
>> wireless/ath/ath12k/mac.c
>> index af354bef5c0d..773ecd6da8e5 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -11253,6 +11253,8 @@ ath12k_mac_mlo_get_vdev_args(struct 
>> ath12k_link_vif *arvif,
>>       ml_arg->assoc_link = arvif->is_sta_assoc_link;
>> +    ml_arg->ieee_link_id = arvif->link_id;
>> +
>>       partner_info = ml_arg->partner_info;
>>       links = ahvif->links_map;
>> @@ -11276,6 +11278,7 @@ ath12k_mac_mlo_get_vdev_args(struct 
>> ath12k_link_vif *arvif,
>>           partner_info->vdev_id = arvif_p->vdev_id;
>>           partner_info->hw_link_id = arvif_p->ar->pdev->hw_link_id;
>> +        partner_info->ieee_link_id = arvif_p->link_id;
>>           ether_addr_copy(partner_info->addr, link_conf->addr);
>>           ml_arg->num_partner_links++;
>>           partner_info++;
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/ 
>> wireless/ath/ath12k/wmi.c
>> index 84a31b953db8..a0e8b5678ae3 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -1228,10 +1228,14 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, 
>> struct wmi_vdev_start_req_arg *arg,
>>                      le32_encode_bits(arg->ml.mcast_link,
>>                               ATH12K_WMI_FLAG_MLO_MCAST_VDEV) |
>>                      le32_encode_bits(arg->ml.link_add,
>> -                            ATH12K_WMI_FLAG_MLO_LINK_ADD);
>> +                            ATH12K_WMI_FLAG_MLO_LINK_ADD) |
>> +                   cpu_to_le32(ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID);
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

Agree. But, there is a mixed usage of %d & %u for both vdev and link_id 
in this file. Will address along with other comments, if any.

[snip]


> 
> -- 
> Ramesh

Regards
Manish Dharanenthiran

