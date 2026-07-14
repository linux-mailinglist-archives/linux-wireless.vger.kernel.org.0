Return-Path: <linux-wireless+bounces-39087-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M1G/D4FqVmql5AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39087-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:57:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5038757284
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bQFP4djA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jFDnHjtw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39087-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39087-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CCE13031AAD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6C24DD6D1;
	Tue, 14 Jul 2026 16:57:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AD4A139F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 16:57:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048255; cv=none; b=sgUwdy6XstEp9a5Jjvxjx6jab3SWh5AiQperV7GZh+f8/OEHNJaUg4fGWe1fzZIe4EPrIwSit8lG5lkWzGD+Jn876rAdNhBoSDfbNm3Qisto5GuBHWkalDOxHMiYns7eLUAA/mlAdRxU66GLzbmb+lVTV0PAQuyp8+FSYYwbsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048255; c=relaxed/simple;
	bh=UsmZnw7MlvLZcf7ywpw0vdhiUZAratNSN9axuw5C6qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXUMSu80XxsNoL0o5tYFHXPxXXmimKP8wk//nG5CUmtcjPqb0uATqth7QXUahuW7oldnM4kDUycPx4/v72tF80QeeYdxkQOM6HAzgJe52CAh1+2cGHiSaXvm5QLDXDE1JB6zAHThmNO89SLYIgo1RVYglqJEXxAjCKYOeTnFHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQFP4djA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jFDnHjtw; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6v4V852617
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 16:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	REdpF1hgs8gzXS/McgKrQMBrhboqQcgPf0mwnfMcej0=; b=bQFP4djAGG/1sbTh
	uKgRQnW1+GWgIBQd9iO8skFwpR3iVApImo4aQ5oyUTiR8WMT2z0Nbyh2GXfYjyF7
	NziY8I+Mv2kL/cAYv4s5T8CT8DSeogw4PtSC8wl6srY6xNpdlF6E++RN/YECMMy/
	Hl/TVkar6k5Wt2rNX9wwwQ3Pp2TBUUOSc9UbSSI5HeFCXIoyByS+xPZeLiQBHEBJ
	ghJ3Akg3/cT/F8UsCYlBDRnHkeFrVjnUNnM9u1Vesdl9s0uiSewM1PejJCaLwMVV
	gempb5wkt65b0IJUTtFMgKa6RVky3l6YZaNIEU0VbrD1JFltXuIEE+jcoTo3U6lU
	rLqxUQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk1ahy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 16:57:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so1299103a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784048253; x=1784653053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=REdpF1hgs8gzXS/McgKrQMBrhboqQcgPf0mwnfMcej0=;
        b=jFDnHjtw303GoUWN6Jqk+uo3m59gjpxVNjiFVevGlwQJnTHaeXRU8gf/S0yOqAGHGa
         C2M46ZfauHaFh7iyH35cSx4O6M24KTeOeeXpLdewpI1fktzpxJcxe7STWkSQ2zFOgHPy
         Lmaha6rLYbf0w6ui7YohFwBFCxv+fCYEVRORSvy6kJ1RGuh4W7IT1dQMo9zWZyza4MHB
         p5ajFdz/X0JSyRtBp4Cf2fFARDeHnydXaLDJSl9oPCFEcva+sP8gXk0ZXz+GTi+3gqPg
         pJraGGSJCXd4PsAE9SxyKnb4F/4IWIKRR9SESA5md81sRm1GzMLk3s0njEbiVfjb39UZ
         bgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784048253; x=1784653053;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REdpF1hgs8gzXS/McgKrQMBrhboqQcgPf0mwnfMcej0=;
        b=DocbPR5oaTiLWRNcp1LCTRbQYjxybGXpUR461LuSEjOYurYoXNIo5pobe5lLuayg2/
         SD/GI0Qh8yKz6qoD04nnzCGXbdOyKARsmMu36CLSHHzaZR3vm+Ip3g5+HNoZL5jZImdq
         wmcXtfFFhGPTz+ph5JgoXRxUBubx8y5GBwGzfugnYrZekRik5SQmA4srvPVWM7xN42Nr
         yUOpNyAv0f/9Wg98XBFwcnGsoe20jHYFcAVjUwG1E+5AuNHuZrlwwFK478OL5ssIesy7
         Ng4+tkxWxOHvyk+Fu+Hil1xXeZACZsDZbacSP6Jg1iN0j29KOZ9KRZnTE6+AQBnwevCs
         Dsfg==
X-Gm-Message-State: AOJu0YxSH2GQFku0jPsXlGbaQ+n4c9n3MJxy2bzJ3bMyeEQIvlbAKOrR
	Dm34z8cE7ADIIKyGgG2QsK2Kde5BiIJcMl5sMUhSMag7OXiH4Xq1mqzUf7Oj/D4LFk9Ryub91GT
	o0JLx4EwoQlC6DINEoTa+EUgh99H3kwBc0OytZ/oDe4tdIqeyjakkIiutS41wCRWVjEEuMA==
X-Gm-Gg: AfdE7cnKRQSMQgtB83y8ug7mJtOAi00WB3DNBwp6/GL8PkeUGANMYiaPA/Rh5pKN3ZE
	mjqWHS7xkAzRYF/OODKpyHdEjuJ+8ltu64L7EjMSIjKhefhTV26jQQ3IoFs+A20+Vp2S6oRWreL
	w3khfY4UllT0jKq8Gn0Z7O5esH/QQvRslihKfj49ci2kA5lMcGgkClFmsJkzIqP5hoIjNnD7/M2
	Fz3auZNJnl++Zgbaet7rBQU/LM+Qe4e0fZcQRP9uj2jC4j63w2ZUOr9uMWmOQ2wOV/LsJb2aWbJ
	9faXv51BJVPxwcEC38RDXWW58CCnoPLIGbe9HeI1+dvz7U+tm7jUIubcEUgyOunIfI0hYjMvhaf
	WYe/B56tpwQAIPGUrw/RmoTNKWchZFQP7QtCKT/GXTiTj93mIvf6Xchg=
X-Received: by 2002:a05:6a20:c784:b0:3b3:216b:274c with SMTP id adf61e73a8af0-3c1108c0142mr14583951637.22.1784048252898;
        Tue, 14 Jul 2026 09:57:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:c784:b0:3b3:216b:274c with SMTP id adf61e73a8af0-3c1108c0142mr14583921637.22.1784048252447;
        Tue, 14 Jul 2026 09:57:32 -0700 (PDT)
Received: from [192.168.11.107] ([124.123.80.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm88739228eec.19.2026.07.14.09.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 09:57:32 -0700 (PDT)
Message-ID: <0fc97639-c4ac-4dae-9ce0-a80924c24f41@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:27:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath: Correctly copy the hint BSSID in
 WMI scan request
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: shqI9dFSdFy0wjAL5RbNlOTgRQxYG02Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3NSBTYWx0ZWRfXwBAxh8UYFZ2i
 mmsnpsiXrJrcRQcepUUSrMR6rfrApoAB28AaIpwT95FxV+62GAbA42JDGD+4hGGVBrbspI/X4Iw
 1P7J9SCP7zQs2zFbhzzxqW4PDRIY+xDsPHt9BtuFHATckz6sg+v9PFIgPj1IdKg/UXvxpSazxd2
 g7stgCCiGz7z7/J2WFtz0sETpI3EE6MAxGH8JfE/FrRhBLzv5W/CnZBkh5Rk1aAQZWpb24l5+CG
 deccm89wSb53pQKB3V3boUlvXjIensBrNH1nn0YLh7QlLdyPSL82gsFnS44altxr8vF9sGIfxzP
 +JLQ7sK4Ss1tg1siyOKhNITe6PUdZNTuR05zV4zygXf5D/BDsXMyzpMcLzGZLPn0v8xGj+U0sDx
 tnDKokMutP+zBJNQn4GzDRa5Qa/mMMWf4mVXu2c2VEN9dLNG7k4B0iQwqj7s3u327nq0HQBEmap
 hWOUR6b/5mwv0xnJG/g==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a566a7d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=kllYWVK2JqQtNyhMtAlpJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GL6iRD3gBWkkJquUCRcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: shqI9dFSdFy0wjAL5RbNlOTgRQxYG02Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3NSBTYWx0ZWRfX4aPmipeDfpSo
 eaBwWjl3Cc4LDuIt9vfibl99g/Ro5nEIEynjoVlC+K440CIZhTBWv9e9pHE8hOVs4S/EVNUJNKw
 yWtoDfKdkzjw5h/gplc3FePD1wAduoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39087-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5038757284

On 7/13/2026 9:45 PM, Jeff Johnson wrote:
> Issue was reported in ath12k, but exists in ath11k as well.
> 
> ---
> Jeff Johnson (2):
>        wifi: ath12k: Correctly copy the hint BSSID in WMI scan request
>        wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
> 
>   drivers/net/wireless/ath/ath11k/wmi.c | 4 ++--
>   drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

