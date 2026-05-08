Return-Path: <linux-wireless+bounces-36107-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NvyJZd//WnnegAAu9opvQ
	(envelope-from <linux-wireless+bounces-36107-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 08:15:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F02594F250B
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 08:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8684A30363AA
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FE13750AC;
	Fri,  8 May 2026 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRPvAEkS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CdlP/qdX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B535DA6F
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220838; cv=none; b=fDnRMqeIB41uG7qnkn2RpbUJKiBW24X0EYYT7hgVJJmQPaUs5Ly/xSp5izNJ70aN0Fg4c7bHnZBsGq2i9Znipd8rJCBM/f2JkGRMT5V+qgZOfIQnDJzr9bVYzvSeiVMMhBaUpIEE/TVkj+sGK813cN68i/l4A49DV67vGF8fpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220838; c=relaxed/simple;
	bh=Ap5sFCs9XX4OaGtvqGVm5br60V/e/jcsdUm9yxaZCmY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f6Q4EeKerYpzxGymigYU6J3uAWNgIVjBEMgUS7trFCQlgPNqWG5ZLi39V4PfIGxiBW5OpyQuhecwMwuK7f/JwLNrRuasvNap5VQKu8hb+0RKQVKpq0sRvvd/HmSWxwkB+eN6D6ZdpzBvrEOFvnLM2URnY+qHwHHwlR4PXQJXZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRPvAEkS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CdlP/qdX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6485CeOJ2531307
	for <linux-wireless@vger.kernel.org>; Fri, 8 May 2026 06:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cFBuui+wGCwe3wsLc6JIAOYifQN8Kjh7VqLeN4nLlPc=; b=BRPvAEkSE0HdboLr
	tar18Loxy6uWSOgI1M/OidFVpKR6wGoRgOWRBf+mU/qKPdPz2sDnTUfp1UEC/BoG
	n1AzFojOIv2SbVEAQFG12vpe+kIh+V9h81FHxvwjUm1AZmDKyZ9lU1UMa6xMIkmd
	Zeg6ZA1GB7rmqKnGV6EVOKw4pns2lpB55fIrCujIl+sBTHKlVT0L2nfoD/eGF9PG
	swaY1zzr39zJqqLMRX53TjHZJEsPZxU6MXbM6oGc7ViO755lQWea+wZxRCa7jaPV
	LcLaa6kGLbhhpH7wwi2i4pmu6pR32wWd9j/bLRuNugvukqlN6H4mX49D+GXJ0tAV
	Rhugyg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10m9sy1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 06:13:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-837d0d71c61so1003922b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 23:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778220831; x=1778825631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFBuui+wGCwe3wsLc6JIAOYifQN8Kjh7VqLeN4nLlPc=;
        b=CdlP/qdXmsreEuuRie3wIoZKYLVI7gQ1phG8QJZnzJU6gS2kWvRnnyz5I4coavb5cS
         4E2woIdfzCjKWv0iPYsRv59jS54GXRY01Z6C409+XgzaaXqt30UMW1ocN3K9wor8BYF0
         kp0YPM23yTXGFBSpALX5GEOXxLly+B7o1Hw4o1UFYsSICJlb8nBbfVSxZ9vhVXSZT2OZ
         sosNMoH78h0+HcXOXDk2a3LT1iK8Mshd8YSyul8xh7Pnh1mN5oy/4ksWwjNv0lz7fJ0h
         8kzyagivMzAqloTP+do5WOOP1D13MIHK3GmtJu87MLIQ5uihUB6XdKiHArDHd2gO6cwR
         m0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220831; x=1778825631;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFBuui+wGCwe3wsLc6JIAOYifQN8Kjh7VqLeN4nLlPc=;
        b=ZCtx+Wo29KFRnKi9KLjNjNCNMJ1wW4ImJvFDbzfLsky8BAENqoPsK5tfZkc4zbaTQV
         8IV5pM6LMR3/WS/8dhF3T2vUFBZXuhl0NbJWQrm4ikeiBO0dF+ei9U0q5HD/BCHvbf1B
         aZ8P3KD805HOya21+Y4IzKFCnEeAgSDbPKbD1rIFJkJgWQkTwRKs6dtdTuPpoR1On7s1
         INfeNq/SuP+XNRZYlZkK9fYAVkaWwBZSUcH94jbmZyf9iigSLTIq8hh5GEStZ6ZJEZhC
         DSR5UjiCNZqPayofvndJ0t6JUOSGhNGn1RXPldJdHQL3EIq51R2lZV92cEFMjzH7tavJ
         TbjQ==
X-Gm-Message-State: AOJu0YxKhKVinWI7oTUE1nrluFA6hUWdYiJ/gEqjJCPvJ+pstCMYO87l
	iEGCTgERElEBknHWsa2WZ/pcJqLwe8E+5vCL0f2sDgfMUu6PnfXG1rsCwgI3Ryo3q0YnhvAWRBC
	0ktftVMhI3noKmdPym7WqipADyp5V/G+5W3/J50GlOm1vxmr900LqiBWZRXphQejIpwxxFA==
X-Gm-Gg: AeBDiesnJixuNuFxPKRye/bgtZ5D7QWwAvAoYwjOZX9rygWPOrb2vdiWDJtkHrRuehM
	sc7R0OzKeMYuoAGeEhsszGQyKj7T51vMZ6i5ALDfgNkZMe2T1oxiGjq7gT60rKJMRXI5sGrYSI/
	v+i3Hcf54EU0G6mpLT92JUBoPhk4M49G/S7g4HW83Yd/e58p05VkfXivZd2eW9uhazmHFOQtXne
	wcY6c3GziqRCHdOCYM64mtJPjhgB+0sHl8f+tSHDnOUOvs5ziRNhOB7u2/VJaPYfjaocbBAeYdh
	UFwnlhndgIMBJkBS4wLbGrt/FbDNlCf4sj5HuScWr9uCfKADGzUV98BIPQ7iEmO0XaPXLZ/aE0f
	04AChKNmtAvGHV1EtwsQdaYsWxeLcfkUjA/saGo45U1Nb4gQCndUZ1nYwNbE7sw==
X-Received: by 2002:a05:6a00:10d2:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-83a5e23c9abmr10450497b3a.35.1778220830640;
        Thu, 07 May 2026 23:13:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:10d2:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-83a5e23c9abmr10450457b3a.35.1778220829939;
        Thu, 07 May 2026 23:13:49 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm14718219b3a.49.2026.05.07.23.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 23:13:49 -0700 (PDT)
Message-ID: <6ebbe7ef-b867-4d5f-838c-7f6224e38891@oss.qualcomm.com>
Date: Fri, 8 May 2026 11:43:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: Add support for handling
 incumbent signal interference in 6 GHz
To: Amith A <amith.a@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aishwarya R
 <aishwarya.r@oss.qualcomm.com>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
References: <20260505143853.295368-1-amith.a@oss.qualcomm.com>
 <20260505143853.295368-2-amith.a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505143853.295368-2-amith.a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Lhav8VLXtYmdcoElNX-y0wkIpQpZViNe
X-Authority-Analysis: v=2.4 cv=VP3tWdPX c=1 sm=1 tr=0 ts=69fd7f1f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=IYzlEOER3vfPUB5pnoYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA1OSBTYWx0ZWRfX1neG77gX5Qsk
 jrL9d7xLd0ewxUEQYcQ4WFqNlwUHrtElDAP9SHL+qydxPwlz+WURoThFyK5qrZh3K5mOvs2XOoE
 bYVbtU4i3XzQRP3a1K6U3KTaHpGSw1AsA2d+21+HFxLubYftGk38s7UH19Rfac8XhQ4zccnHP89
 syCAV+QGPadrvK8xTvV9cm12memxuL0R5+IijZuMh45XQVM7yEsdg0JX3J0qSRtkRxixpqhgp+Z
 JZZ3u42z+iV0mEnS25tsyJOdDDY5DafW3V0JL1wDDZvG0ZsuuOmAjch6BVn4mCl88uQI6jto55t
 DPjnIZ328ZHD7mBLN+qWXHEPw3EBQhqHsKWmro2AK9z40K9i0XcvCWTNp6SXTyXCCTnEgaUO/uB
 Z2OSUIHpvpXjwIG1i0ijRSVwG9LTPQ1sK1ruDr6WwiFoDgI9PjQbW2dCufaVp36eB92M2F5ESQ5
 Me6R4Kkb1VXvheaM07A==
X-Proofpoint-ORIG-GUID: Lhav8VLXtYmdcoElNX-y0wkIpQpZViNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080059
X-Rspamd-Queue-Id: F02594F250B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36107-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/5/2026 8:08 PM, Amith A wrote:
> From: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> 
> When incumbent signal interference is detected by an AP/mesh interface
> operating in the 6 GHz band, as mandated by the FCC, it is expected to
> vacate the affected channels. The firmware indicates the interference to
> the host using the WMI_DCS_INTERFERENCE_EVENT.
> 
> To handle the new WMI event, first parse it to retrieve the interference
> information. Next, validate the interference-detected channel and
> the interference bitmap. The interference bitmap received from the
> firmware uses a mapping where bit 0 corresponds to the primary
> 20 MHz segment, regardless of its position within the operating
> bandwidth. Bit 1 represents the next adjacent 20 MHz segment, bit 2
> the lower 20 MHz segment of the adjacent 40 MHz segment, and so
> on, progressing sequentially across the bandwidth. However, for userspace
> consumption via mac80211, this bitmap must be transformed into a
> standardized format such that each bit position directly maps to the
> corresponding sub-channel index within the operating bandwidth.
> Finally, indicate the transformed interference bitmap to mac80211, which
> then notifies userspace of the interference. Once the incumbent signal
> interference is detected, firmware suspends TX internally on the affected
> operating channel while userspace decides the mitigation action. Userspace
> is expected to trigger a channel switch or bandwidth reduction to mitigate
> the interference. Also, add a flag handling_in_progress to indicate that
> handling of interference is in progress. Set it to true after
> indicating to mac80211 about the interference. Reset the flag to false
> after the operating channel is switched by userspace. This prevents
> processing any further interference events when there is already a
> previous event being handled. Hence, further events are processed only
> after a channel switch request is received from userspace for the
> previous event.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> Co-developed-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h |   8 +
>   drivers/net/wireless/ath/ath12k/mac.c  |  46 +++
>   drivers/net/wireless/ath/ath12k/wmi.c  | 382 +++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h  |  58 +++-
>   4 files changed, 493 insertions(+), 1 deletion(-)
> 

{ ... }


> +static int
> +ath12k_wmi_incumbent_signal_interference_subtlv_parser(struct ath12k_base *ab,
> +						       u16 tag, u16 len,
> +						       const void *ptr,
> +						       void *data)
> +{
> +	const struct ath12k_wmi_incumbent_signal_interference_params *info;
> +	struct ath12k_wmi_incumbent_signal_interference_arg *arg = data;
> +
> +	switch (tag) {
> +	case WMI_TAG_DCS_INCUMBENT_SIGNAL_INTERFERENCE_TYPE:
> +		info = ptr;
> +

should we validate len before accessing info ? or may be add an entry 
for WMI_TAG_DCS_INCUMBENT_SIGNAL_INTERFERENCE_TYPE in 
ath12k_wmi_tlv_policies so that ath12k_wmi_tlv_iter() can take care of 
the validation.

> +		arg->chan_width = le32_to_cpu(info->chan_width);
> +		arg->chan_freq = le32_to_cpu(info->chan_freq);
> +		arg->center_freq0 = le32_to_cpu(info->center_freq0);
> +		arg->center_freq1 = le32_to_cpu(info->center_freq1);
> +		arg->chan_bw_interference_bitmap =
> +			le32_to_cpu(info->chan_bw_interference_bitmap);
> +
> +		ath12k_dbg(ab, ATH12K_DBG_WMI,
> +			   "incumbent signal interference chan width %u freq %u center_freq0 %u center_freq1 %u bitmap 0x%x\n",
> +			   arg->chan_width, arg->chan_freq,
> +			   arg->center_freq0, arg->center_freq1,
> +			   arg->chan_bw_interference_bitmap);
> +		break;
> +	default:
> +		ath12k_warn(ab, "Received invalid tag 0x%x for WMI DCS interference in subtlvs\n",
> +			    tag);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

--
Ramesh

