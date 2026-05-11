Return-Path: <linux-wireless+bounces-36184-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jes6EDxSAWpSVAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36184-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 05:51:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B92507C3F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 05:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E16630048F9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 03:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB321B191;
	Mon, 11 May 2026 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNCf7MYP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLGfYEkH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF41B7910
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778471480; cv=none; b=R+XleABcdsYWcL1pE1XBVQR4w3M2/RSSoi+h5ehcHH0psfUxyt9x7t9b/WsQPmIBVl2BScbSDsk/0pxC4vZ/EKjqZd8W45csgMDHEamJScIFHnuTTaMTzUai9kejv5J6mwaGVi4i1jjB47WMjODcXJhixH179Z4YtBQS20FZZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778471480; c=relaxed/simple;
	bh=QCUmhcoNXMlrIlvwMBnyt+dP1zB5MW+w8kvDi1x7m9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mp3TRdVCROOr2Sc+fWLJHtsfzr6q3znesn9v9yJCyKudHvlk1z718y1lzTjcJ0QRPv3DHoW9nKYv/oGK65kxiZGufMxo4eWnATJx89WC/VyXSLuF5B8xjDdkQtk4Epp1kPa4WCptgWfKnNz4EsOH/1aBwXNLC3d/vakYPV+M2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QNCf7MYP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLGfYEkH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B2p3OC1375306
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbKzUHT/58wGHmoxf6T9tOqHYXHEYsbOKeCSqodQo4o=; b=QNCf7MYPWX02Xp9O
	JQudjx+gijv3kGM0dWQHAMh+UG6v7K0rVqkngM8DwyMRklihzq/28WPuZXQVCocf
	ZP1wAH8AyWsUq3d4r3LB2bfPaptMQ/i3F/jxwEooElamTonPeFdWPpmDd9pvHr57
	y2jEn7gAzP+hrp6RGyw11AOs6DB0HGtLQAvhdbPAtdnayXlAW7E6JfLJmUXw6I6M
	AXcRS6gIoeT5cHP8dMH8n7Kh4g2n++dJh7HjiGJSzRxAtxfThYFl/5SOju0C2VCI
	e8FbQHyfonh8RdFncplA9IQXCHTxHaxO8WgfwzGgkr5JFtNiHrbxywT5kEl3Tu+A
	8u+mmA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1w0um742-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:51:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so3528122b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778471477; x=1779076277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbKzUHT/58wGHmoxf6T9tOqHYXHEYsbOKeCSqodQo4o=;
        b=MLGfYEkHDWacB3DNE2d6YzEnve9Q8oKYRT33zTKuCLwocH5FRzpXcH1ojjizSHzrFu
         dfdwvIyOjyWH9t2f4mhhDjUod1D06twogwWfoJRWa9VhPtkhpnI+I44rfpyU42nFncC7
         g074v7CVV1aFxW1KLbwO+yx6UA5d2IeeA3evk1wOY9IYhBqtOeoNn6ihB+dGrKSx0bR9
         oC0g8ZRXH63eOv6niLt2gTrQOaa1M5IarmboCk+17+mKSOdtj8ap1oCqtpaEEBGP/0G7
         XwJLCVgDbtpyOmI/bRtWJKUggYAgyY2aN3lnKHH7uziNGw9wAxFY4UADIkaaXW06BrFX
         o6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778471477; x=1779076277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbKzUHT/58wGHmoxf6T9tOqHYXHEYsbOKeCSqodQo4o=;
        b=MGTXZXw7b3fiEFjMwV25dAefhoWz23FjnC1u/lUjkaGMKE504l3pG6JWamp/FyteED
         a0pn1uYXVB9hamn2lZA5mNObdcbctaJMqd74lXRGKbgwPoHd/g3YjeSNispiaN9GW7HJ
         aZD5UevwBk1XT+dip5VWc3xOWF84ZIuu+b9kYAK1cSA2kElEW58xRQ+vdet0YUCpymNX
         7LhlWq2K98opshnhxu07DkAU2t8NQ5BTwlC/YvzsnsdwvmHixFLFjiWr9bKjrbRMLtYo
         DV3JyX4szzFoRMwHsLqeW6IRmF3JPwe6gt12Xaxet1VHkUH/XFlIVYg8J/tGcHky7kk7
         XXpQ==
X-Gm-Message-State: AOJu0YxKem70p62Exd/iV2B3eWOvxF5c/buXfD25lrdD9vuwV/WJhHML
	H/PkF8O491MrcOkXTg1idudNVi6KJ6JxJkpjod0ZeePXi4v8dOo2tIk6J0uVaHMciJKD7B5ydkZ
	vmjQoxsd3rVSsb5waI7zu1noyap1XFLUvfcSLelzTN9rK1ovCv7yirg9cOqqoj5LYKo57ZSTTYs
	g9Vg==
X-Gm-Gg: Acq92OGjBjklBEhtohwKmjdXl4/cHSyYEeJjak+0YOkeGk7b63NrE+zT+ATWchyr6fs
	Wq9CUUo4VJlDVOi/8bFWL82u4eshvwxscxyyVBOLuO3oa2zfIB7P8KsfcqKdVDQ5nQ5dx4XFfEq
	AULVa/9byRYdXGkaeX2ISOrdzZE78D9NUrqPc6dXWIWYHsT0D5PL/bQ26FMQ+tIaIL3fjyuuxuQ
	8+qOCqsN95f7ujP4lKj77/wsic27gS5XdDz4fbIukjYshvGoEad/3NLO7ItG/ISKYjH4fAb3Cr/
	e41B/tsBm4CO6+lju4KezfGenov/wU7RHQ7qbi6AnknZDrJde8Rgi+hZy56aoDR15xzllYRwmpV
	vvldu0c9z2cFf+V54+KDuo/t1tqKY48Hi7B0B6EQzdH4VNAQOV2p3IoYRiqFlboS17FmTkz06r6
	DEyRYfg1B0VaPwhNeBzhCuo8wAD0yHdio=
X-Received: by 2002:a05:6a00:4219:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-83bb85919abmr15930623b3a.21.1778471476735;
        Sun, 10 May 2026 20:51:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:4219:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-83bb85919abmr15930582b3a.21.1778471476209;
        Sun, 10 May 2026 20:51:16 -0700 (PDT)
Received: from [10.79.193.74] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839683a088fsm18614780b3a.58.2026.05.10.20.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 20:51:15 -0700 (PDT)
Message-ID: <60d67218-aaf4-4639-b5e9-973e6b63bac0@oss.qualcomm.com>
Date: Mon, 11 May 2026 09:21:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: Add support for handling
 incumbent signal interference in 6 GHz
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aishwarya R
 <aishwarya.r@oss.qualcomm.com>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
References: <20260505143853.295368-1-amith.a@oss.qualcomm.com>
 <20260505143853.295368-2-amith.a@oss.qualcomm.com>
 <6ebbe7ef-b867-4d5f-838c-7f6224e38891@oss.qualcomm.com>
Content-Language: en-US
From: Amith A <amith.a@oss.qualcomm.com>
In-Reply-To: <6ebbe7ef-b867-4d5f-838c-7f6224e38891@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QdY37snD0qHm9VYVvMM-JGabCuMZrQtV
X-Authority-Analysis: v=2.4 cv=asaCzyZV c=1 sm=1 tr=0 ts=6a015236 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=-JVo_sVfTxQHn8smsngA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QdY37snD0qHm9VYVvMM-JGabCuMZrQtV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzOSBTYWx0ZWRfX7iFqJ8LONapv
 LeZITieOJaGXVLxqMW7AztZXY3/ykcQNjqetobcsUsuwN8sHtlET3mi+Ae3j4EwS1nquBje2/dF
 ML8hAIXjWY7iP0NJXp6K3pPQ1SW+dJ+JGN4+YIgb60tGqUUaTlP494CqP8C939nnqRy60yZeevT
 atSRpTjQzxTLnRSxAPvTxNEPx3BAnlaY8PU8bOagtH9hlpC2Iqjxpt2Rpl164YnXQ4Fq50/UuZa
 Q8lqkremv7AODXk5eovAh3Z/wIh3L/nF57HJUc6Rce973aG5pj4TRmRF/WUg0/V5ZF+7uUKNPRC
 ivO0QwwP9pVFulbuee2h8hdaDe06NjhBTJLMSLaKKRm9F12bo8P56PHCFUagYekjruTX+f8lyms
 k1Hz9UBXm+RbTHM+XEUKUBjqlKfxqOueGA6KOL62n/lc/ImovKOh9HxafeaWp+cATWbhUiJAZzI
 QyRVFThlmGDz3qyu+hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110039
X-Rspamd-Queue-Id: 60B92507C3F
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
	TAGGED_FROM(0.00)[bounces-36184-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/8/2026 11:43 AM, Rameshkumar Sundaram wrote:
> On 5/5/2026 8:08 PM, Amith A wrote:
>> From: Aishwarya R <aishwarya.r@oss.qualcomm.com>
>>
>> When incumbent signal interference is detected by an AP/mesh interface
>> operating in the 6 GHz band, as mandated by the FCC, it is expected to
>> vacate the affected channels. The firmware indicates the interference to
>> the host using the WMI_DCS_INTERFERENCE_EVENT.
>>
>> To handle the new WMI event, first parse it to retrieve the interference
>> information. Next, validate the interference-detected channel and
>> the interference bitmap. The interference bitmap received from the
>> firmware uses a mapping where bit 0 corresponds to the primary
>> 20 MHz segment, regardless of its position within the operating
>> bandwidth. Bit 1 represents the next adjacent 20 MHz segment, bit 2
>> the lower 20 MHz segment of the adjacent 40 MHz segment, and so
>> on, progressing sequentially across the bandwidth. However, for
>> userspace
>> consumption via mac80211, this bitmap must be transformed into a
>> standardized format such that each bit position directly maps to the
>> corresponding sub-channel index within the operating bandwidth.
>> Finally, indicate the transformed interference bitmap to mac80211, which
>> then notifies userspace of the interference. Once the incumbent signal
>> interference is detected, firmware suspends TX internally on the
>> affected
>> operating channel while userspace decides the mitigation action.
>> Userspace
>> is expected to trigger a channel switch or bandwidth reduction to
>> mitigate
>> the interference. Also, add a flag handling_in_progress to indicate that
>> handling of interference is in progress. Set it to true after
>> indicating to mac80211 about the interference. Reset the flag to false
>> after the operating channel is switched by userspace. This prevents
>> processing any further interference events when there is already a
>> previous event being handled. Hence, further events are processed only
>> after a channel switch request is received from userspace for the
>> previous event.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
>> Co-developed-by: Hari Chandrakanthan <quic_haric@quicinc.com>
>> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
>> Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |   8 +
>>   drivers/net/wireless/ath/ath12k/mac.c  |  46 +++
>>   drivers/net/wireless/ath/ath12k/wmi.c  | 382 +++++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath12k/wmi.h  |  58 +++-
>>   4 files changed, 493 insertions(+), 1 deletion(-)
>>
>
> { ... }
>
>
>> +static int
>> +ath12k_wmi_incumbent_signal_interference_subtlv_parser(struct
>> ath12k_base *ab,
>> +                               u16 tag, u16 len,
>> +                               const void *ptr,
>> +                               void *data)
>> +{
>> +    const struct ath12k_wmi_incumbent_signal_interference_params *info;
>> +    struct ath12k_wmi_incumbent_signal_interference_arg *arg = data;
>> +
>> +    switch (tag) {
>> +    case WMI_TAG_DCS_INCUMBENT_SIGNAL_INTERFERENCE_TYPE:
>> +        info = ptr;
>> +
>
> should we validate len before accessing info ? or may be add an entry
> for WMI_TAG_DCS_INCUMBENT_SIGNAL_INTERFERENCE_TYPE in
> ath12k_wmi_tlv_policies so that ath12k_wmi_tlv_iter() can take care of
> the validation.
Will add an explicit len < sizeof(*info) check in the parser before
accessing info.
>
>> +        arg->chan_width = le32_to_cpu(info->chan_width);
>> +        arg->chan_freq = le32_to_cpu(info->chan_freq);
>> +        arg->center_freq0 = le32_to_cpu(info->center_freq0);
>> +        arg->center_freq1 = le32_to_cpu(info->center_freq1);
>> +        arg->chan_bw_interference_bitmap =
>> +            le32_to_cpu(info->chan_bw_interference_bitmap);
>> +
>> +        ath12k_dbg(ab, ATH12K_DBG_WMI,
>> +               "incumbent signal interference chan width %u freq %u
>> center_freq0 %u center_freq1 %u bitmap 0x%x\n",
>> +               arg->chan_width, arg->chan_freq,
>> +               arg->center_freq0, arg->center_freq1,
>> +               arg->chan_bw_interference_bitmap);
>> +        break;
>> +    default:
>> +        ath12k_warn(ab, "Received invalid tag 0x%x for WMI DCS
>> interference in subtlvs\n",
>> +                tag);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>
> -- 
> Ramesh


