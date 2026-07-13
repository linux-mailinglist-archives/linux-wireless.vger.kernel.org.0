Return-Path: <linux-wireless+bounces-39002-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wq4EFVN3VWpIowAAu9opvQ
	(envelope-from <linux-wireless+bounces-39002-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 01:40:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B774FC2E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 01:40:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="D7h/+U41";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TFeOfy5j;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39002-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39002-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F282F30376BB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1193B8BDB;
	Mon, 13 Jul 2026 23:39:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375AB2E8B9B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 23:39:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985998; cv=none; b=RYcxvl6+ijy1JszVfOXzCAOmgEKzx/V38cBibocZ5TiphqrRGQeOSgFnNbLA/d2Lt2MA49iHyIxtNzUyGLa6xSKyCwIxMCg07lSHnnB94PBIwz34sWp2GVh1GVUwXkDXACuGrCEoCiJ4NbUyT0/WFWdUXrPGjZVZHrs7UfYSGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985998; c=relaxed/simple;
	bh=hCxIYrjzCvzufFJ+2PtEn8e8x/CkphV39I0OeHTRUPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdnnYEf/AO/DGsdS7x6CKEKgyBcLp5Q7dz8nGNRsziV5c/AiUE3/u8Bx9QX+KGiYX6iqx2Ho9PDXsUX0BbnBoC9NGnwlXwMab/YAY6O/Fw3xoAxfK2HPn8bQOjkd3k9f8LJnfxzG9y0BVtBimGTfE+7uc0nBMiWzI/XzkByZp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7h/+U41; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFeOfy5j; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ99JC2519250
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 23:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iOGyuai475L8l/K5PDfSguK/bb4C7qykXUbNoYzeG1k=; b=D7h/+U41l8Eh/+Mf
	yOdwEhiiLFTwLBq0e64CbcVkdF9bN0/7Nbfn8NJgxUwNWQ4nf7rRyNWeVjEUrgFS
	/usbEeN2LjW7LIPXyrsJ2b/wDjNEapfmdBLypSnZRKp77PJQCzkDTRKOF2evyaoK
	QvN8oL8R32SO1Ly1cfX2rNo9gj4JD/6tE/8Pdmmuhw3jNGuTmQ4xGYZsQOtHoat2
	sr3ud1G9sQoQwfZWQT+PSEAGWxUiN9XOsczStEjzEgilSkUQZLZVDmYYIywHfFxg
	b7WpL/806iuPKgtAWE+F46rppCSxOa1QC5Jy1mmLBtQfU89TwHQR47ftwigpurLk
	ZHtIRw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44cs585-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 23:39:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c892143db7fso285208a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783985996; x=1784590796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOGyuai475L8l/K5PDfSguK/bb4C7qykXUbNoYzeG1k=;
        b=TFeOfy5jyHlSpjinWnozVP3Ye2dmKJniQyIFDMeizO/60enRKq3+kSoTPTka4trsQL
         Q4GzltCZnTKm4rtSSXiBaUbOqbWIn3Jp5ZUMyJYUzVT8OxZRSQx5FFM4WIuSnrwFgaz1
         AkQeHKOkCPsoY1g6PiF2TI7i4+Pg8wnbzOFzYWHLVm60voP7VMaqpLsNOTgPLSyRDRBB
         8QJVuNAB0NV5RuMmNEh+o1+G1N4UD8IJHwcqR9mOJKYpJXzSDjyPYAc/c8SgRYSgdxeh
         9kfwIuw+69aoALANHUrbILtx12hlYTC6LteG+aEUUMgq9cXq4+3v3p0qy4+os119dDdy
         QZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783985996; x=1784590796;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOGyuai475L8l/K5PDfSguK/bb4C7qykXUbNoYzeG1k=;
        b=Ylnj1NJT5hLsKe3hOlDJaDKUgNbBopqP90Okqqgme+CMf0JU15O58aQVl2U5qYo1NU
         Fap/dPxEULo0FA7gCqjyJ5KAU7TS35Pho6K/i/ToD6dvY0PyROEaHWlw9JsbyrUXk3lJ
         MyTqpbEUf7Kz7EDQ3u7y/Q2/a1JU9/ChOG60g9aldyl20DZUePcK0fGaNPHFJ4ugMgEp
         O84cf07gB/tBvcWcwZWd1cWia+pNzDCLKyfrwK1trP8KVIqd4GMoupq84siUeoYvNBbf
         o/pmmjCNKbTTUbScoD4CTom95S4PpxWRoV/7D3TuTXxGoHLc7B7aM05Q7WOU5oq73exS
         ip8w==
X-Forwarded-Encrypted: i=1; AHgh+RoZncFT+Yamrn2ESp7Wi8gftf565G+FMzul7uCfF0Bb10TfIfGN2czrVpX7kNaci6xiY1Bpwozxi0MWW3dKPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMlH6HWVF8elbU+kBfO15i41gb5Ls42B3ZkRV1JtE2oujcBrdL
	qSMnh4CPkz0OgcINgjkIvRjHafaaZ3BWK/gEJVFe425KU0hMCcBe8J4qTYe9jYxgIjYlz3QTUF3
	rDPKJFB9PmuFtqCxaLjRLFjFz4w+Wzy/sYHaqBNQJeh1Pdst8ehpypqm8T1CvTi4lCkQ/4w==
X-Gm-Gg: AfdE7cmVcISkmqvW88MkH6idUkZI6vRq0On2iaYBbLWo7sMXFwKMIZscrHWQwiwKEs5
	44kKhEfuBxX02qTSK6zKDAkefTRYj2cR//DsshEYWYSQ8oarIHlRUEeVtjMEi7FOyf4bTkU60Ds
	jX0D1fwbK7H4AhjBVe5JJMZfEfLzaCkCTo44QHTBTBh/RJFZkAkmjMjQXxm6hzL0dXLIyNWLK70
	ZtkeCyuc0Bwa0Wk/mliYgYEvGEYvVtBAnVO98yXIH12kf6WbgOhV9Gd1SoVYL/j8NEGOmbZbsHl
	9NZljEFbrG70eSey9+7B9qarm+u0YvdrdNURzsADGFOKKRyRCJ6AKL9ifraKfqwhSIvGBYaTqxI
	kd0Htl5aaGUyRVgb2camL6huuS+IBN+mN8qoH9jqW779kZLOruR3Q0IXtO2KAWyMI8gjQ
X-Received: by 2002:a05:6a20:734a:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3c1102d7cb5mr10384834637.9.1783985995639;
        Mon, 13 Jul 2026 16:39:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:734a:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3c1102d7cb5mr10384807637.9.1783985995137;
        Mon, 13 Jul 2026 16:39:55 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm62806565eec.20.2026.07.13.16.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 16:39:54 -0700 (PDT)
Message-ID: <95d263d4-11e8-4b11-8cf5-fb3a3132187d@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 16:39:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath6kl: avoid buffer overreads in
 WMI event handlers
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260711-ath6kl_wmi_scan_complete_rx-v2-1-22dc0f7f45e7@oss.qualcomm.com>
 <44c01b93-5538-4a81-ab5e-b25d0d56980d@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <44c01b93-5538-4a81-ab5e-b25d0d56980d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dh_8RNn5xOjGAaQYm8lyZGrQKzhAPlA8
X-Proofpoint-ORIG-GUID: dh_8RNn5xOjGAaQYm8lyZGrQKzhAPlA8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDI0NCBTYWx0ZWRfX5izi0foedGOH
 TRLEjvG/bAJd1Fj7SMaffo90KglA5MJQMV8snaxwT6UvSIfhwZDL9tsAFjhmq5Dtaj+pxh3SE5o
 ntFT5XeM/AfO6/umNuW8TLJ15VUq34c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDI0NCBTYWx0ZWRfX9o+bQMq91nRg
 j7Wt7Cx66COG2uypswHTxmM1msXYJTRFeUtzQzu4oPHCTF2vKHzMXf5UWorovG617XKIHiRSKYt
 Hr66CNEeqJQF/c+VUrOqf0CakKvGq+cBCF71hCY+AX8LHkqLVPx3P+XcLWwIvUf87lNU5PRc7B+
 9IrsUZ0GFRM3R+lh320J6GksrKI0V8YS+gEQZCA3tmdLjL1j5E2rUnZ2xy0vf84Qg3WHE8gZ1qp
 s0dDSVkoJkaVHrndteWixX0jFtqtvK3UBlEcUZbq/1Hqy/fylPUlTNWbp+xZacAHmLk13IV9Wgb
 2/jDS6oL2g0H+gUGQlGHaNf1UTK7XB0Kwl3K6a17hWDhb03Ho/8rFdT1Ba5zxdfDmEqdgGwF8Ht
 t6irtTq8DslM5eIG0S7M752Q9jJyUtiFcreWY04D9+XyoEk1htdYC0U37FpGZvx2QEdIU4l7TCF
 Oq2lXTL7I+Iwx7GUWlQ==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a55774c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=KcS3GExwFv3QVkoieGQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130244
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39002-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,msgid.link:url,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B3B774FC2E

On 7/12/2026 7:06 PM, Baochen Qiang wrote:
> 
> 
> On 7/12/2026 2:04 AM, Jeff Johnson wrote:
>> The following WMI event handlers currently read from the event buffer
>> without first verifying that the message was large enough to hold the
>> expected event:
>> ath6kl_wmi_scan_complete_rx()
>> ath6kl_wmi_addba_req_event_rx()
>> ath6kl_wmi_delba_req_event_rx()
>>
>> Add length checks to prevent overread.
>>
>> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
>> Assisted-by: Claude:claude-sonnet-4-6
>> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Added fixes for two more functions: ath6kl_wmi_addba_req_event_rx and ath6kl_wmi_delba_req_event_rx
>> - v1 subject: [PATCH ath-current] wifi: ath6kl: avoid buffer overread in ath6kl_wmi_scan_complete_rx()
>> - Link to v1: https://patch.msgid.link/20260711-ath6kl_wmi_scan_complete_rx-v1-1-7b11e5f8b96c@oss.qualcomm.com
>> ---
>>  drivers/net/wireless/ath/ath6kl/wmi.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
>> index 72611a2ceb9d..08030d88c7d3 100644
>> --- a/drivers/net/wireless/ath/ath6kl/wmi.c
>> +++ b/drivers/net/wireless/ath/ath6kl/wmi.c
>> @@ -1276,6 +1276,9 @@ static int ath6kl_wmi_scan_complete_rx(struct wmi *wmi, u8 *datap, int len,
>>  {
>>  	struct wmi_scan_complete_event *ev;
>>  
>> +	if (len < sizeof(*ev))
>> +		return -EINVAL;
>> +
>>  	ev = (struct wmi_scan_complete_event *) datap;
>>  
>>  	ath6kl_scan_complete_evt(vif, a_sle32_to_cpu(ev->status));
>> @@ -3352,7 +3355,12 @@ static int ath6kl_wmi_get_pmkid_list_event_rx(struct wmi *wmi, u8 *datap,
>>  static int ath6kl_wmi_addba_req_event_rx(struct wmi *wmi, u8 *datap, int len,
>>  					 struct ath6kl_vif *vif)
>>  {
>> -	struct wmi_addba_req_event *cmd = (struct wmi_addba_req_event *) datap;
>> +	struct wmi_addba_req_event *cmd;
>> +
>> +	if (len < sizeof(*cmd))
>> +		return -EINVAL;
>> +
>> +	cmd = (struct wmi_addba_req_event *) datap;
> 
> Nit: No space is necessary after a cast. This is a preexisting issue, since you are
> touching, better to fix it together.

Yeah, let me make those changes in 'pending'
/jeff

