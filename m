Return-Path: <linux-wireless+bounces-32101-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ORpITU5nGlCBgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32101-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:25:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D89591757A7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8343530848FD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E633435CB8F;
	Mon, 23 Feb 2026 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BasElSIC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YS6PepEY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476734EF02
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845667; cv=none; b=J48ohUM9/Mjf0jqWw3z6CC0HVtBwVR2E6lNy4UJYOp+bnvaCgRByLXFZEt7+18ot7Mt2HVfuuscqxvbJ8zWKpeWsJEfArJRI23EwNwIts1aSZOLiy4VDp7oOBsCf1j91KmKUBW0C5FMYVCElu7b0qZG0NuEOBtPDMxfNn+owySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845667; c=relaxed/simple;
	bh=cs6jCuIvZmFucr/s4Bc312nmpGZY1RW4zRW1c6gxJu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYQvxzzscqcIYnktazKNBFPqkXGa0zsNBvb0uT6K9cfWKnYhEbqxiUAgJHa/eCxHNHV0IytxPjdlMpKYfCjcQ1k8H8V33OWChKd2us0MUpZIaoxVmeKca/ic6Cvb+8SHRs62z7m/gVFwQnz7P8/CQKJuEJA3NX3g5oDCcJQXr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BasElSIC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YS6PepEY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAYINv561407
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 11:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+c4XKQV6/kHOvgBRBPJwvx4KXL7WsI8ItcU1unO0zc=; b=BasElSICVLSMm87e
	DQP/wcHm0FfsAXxWWS4/w3gk1nuRp8QIvlDpEgtyIj4HejLBtS35e/SnElf5AlzL
	l/WAnuIookQWZPGBxZuY1/IVgGXIzUmvMSQ8XwsdbEMdmO8ydkOAWcZG9Xm7IZyS
	K4j6Ro/IY2B2w7jBRs7XxBzWH+ZpMDz795mLBIdTjY3MTUnXfYT4wq00klMhkI1k
	aTTGyi43RdclJ9EQ+x9Q3LBQwoP/qvi/mjU9zR967RpFy0bX8SFNP9WsgoUX+o7J
	q1t+QhdtCtdhkmfYa/eSRGoOxfP/WwsppyX2fXniR+uiHUpL77TKR9AXwiFUptrC
	a6znCA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8r849b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 11:21:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c65f69edso4885688a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 03:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771845665; x=1772450465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+c4XKQV6/kHOvgBRBPJwvx4KXL7WsI8ItcU1unO0zc=;
        b=YS6PepEYRknCoaSES+R+YNq+y4D1gjua2PE2ptfBfVGvOf7v2/ndfUEeLVBzdTqwoX
         00iimJI1DixbM0lQdJJ0Kyt9h0Pjc1wHvPkvJlV5aEqvIapFKaZ2KhrXTV6gXTNGg+Bq
         dpWOTcVWE+gWGhcmzLaJ3wtJ8sSDIDQOugwqxP3xkZWm2oF049glrEMk8bhPt4j5eroc
         Go8iHsLf+jYogN9U0+Jq905RDaaxNNL9le4g4ML8tmbNFdrATlU3a5ikAwGFuUEq3pWp
         AQ1ME3JwCpMbF4M9P5D46mfgkxMGG22h1zAjWmnwHGrwgQ3aQB0UGb9zsShjuDKa5CJD
         0QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845665; x=1772450465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+c4XKQV6/kHOvgBRBPJwvx4KXL7WsI8ItcU1unO0zc=;
        b=Jv8QDUysF3fYhFDi9Oe8YWWRhZgepX0gVVUEoIJjkg5XKqN/+j65WtzfkKN3p/emj/
         8oV/egw1kWVUeL0Gq20OT3X80oVoRaYr0eK8+5e9HG5/rZcyvHGPOA7gA903exCopB7O
         J0IfWaI5RJAeIKOqBXThmBQ0uOIL22hk8fTJ7R7Iika/45km7r2c81kjLddHAo73rh5/
         KrUBzIiqL/Ban2tQ0X4N1XuU5Kjv57GdVkrrfD9Sujcd5b41ic0nkE2zP8y5sd0+q8Zu
         wAKKvXKbDfMRreO6zFE55gwkn05xUnsq2whXPIzrkDRRusoITqubtBUQUwLWCXjyPM7N
         5zrg==
X-Gm-Message-State: AOJu0YycRGq/JCKehXazzAcomuoJltkK3DPOQgKASOhVgYvFzx8syLMs
	gva2gEMrTTgRU0xmmR/IzOyUxmvseRkQp7r+LmHQaLnaw/sNjaBduIqEpPOKO4BQc+j9uULtr6O
	syGTPNCRcshBus1ZStmggjzxy3z2Arif7B+apXSbLSmndomQQypv//wbVJXMA1efZORo8RQ==
X-Gm-Gg: ATEYQzzz/XlpklwdWmOHX8IZLeK4QLKYb/vOS2acskFdv486y0gUO9X15ujr8/oE2YI
	I16DMG/YTBd8RGjr0WXDgXaYINpg1Bsgrwj9xO6toOCtLf+JJ8u7Z/TRc9Wwes7c2dgNUhs3KiJ
	f38doUIZOnXhzjSXEVikqbgM3+7vZiplrrOxLyQ9WCQho3s598W1WXvgaF4G3LT4Q0KIX6/zi0H
	fKSGxGbqtWeDRQi7+StegAzhJiMVe3emftBmj3Cho5KZEL4XfyhSGCHBSYJBpufdb4EbDJ4sV4X
	raqTSg1Hh1FxTBQvjDDxSDcszs/y21kIbHGwj3G8VwFijobYIDs1gEUTjmxhP423sp6VMUhLMmc
	8F3FANezD4sTy6ksl+jnftwb0B5res0X7l3MKD4fb2OQVkTS5K15wu2XnMDHgunXU
X-Received: by 2002:a17:90b:3a8e:b0:340:66f9:381 with SMTP id 98e67ed59e1d1-358ae7f826emr6346114a91.10.1771845665304;
        Mon, 23 Feb 2026 03:21:05 -0800 (PST)
X-Received: by 2002:a17:90b:3a8e:b0:340:66f9:381 with SMTP id 98e67ed59e1d1-358ae7f826emr6346098a91.10.1771845664817;
        Mon, 23 Feb 2026 03:21:04 -0800 (PST)
Received: from [10.152.205.141] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a1ba819bsm5460965a91.4.2026.02.23.03.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:21:04 -0800 (PST)
Message-ID: <4a8970e4-da6e-4b55-b1a0-a1bb9d8621b0@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 16:51:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <DGITONL8L200.PJE38TDXYRQC@gmail.com>
Content-Language: en-US
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
In-Reply-To: <DGITONL8L200.PJE38TDXYRQC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oFp09ACT8O4Zc0QV2F5QAFoT4F_kJK00
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699c3822 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=5WUcvfMz_r7U-ursyZAA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5NyBTYWx0ZWRfX3S5tBTGwU2Xy
 pybS/egfMKoiTMzm/75eXEtIj/jCuIU19a4DqLXdD1cVnL/3ttCKPfrj8d/LarIxnVEwPHQYUQP
 D6EfNG+uMZTRwcZjNOfK2jTmZpStVwjsP1M8AMamJHFisdgBYYPfDEMe5uPHEtGx+aGo+iEQZYF
 xX+meuf/HQ+hfFJbkNMGAuLxHiterAV2UtkXb19sD1/qLrEUYGr/cSTuR5eFxL90b9dc6zqpxl1
 aVsUejYwgn4Tf3xbnPNzKSxrWKixzwkU0rFLEFAs9Po1cXkHhnrPQ/2KcvZpvmjqqjXd28NG8Ut
 gdu5is8H2YgH3ob/T+LbvpP4vn/UMiseQcWOviU+FQuKntyove0MnPnpAh7ohpM5Ka6QlVhq0Qo
 Xs1zqR1RnRecQo4rcPN5YBCVlV9K7GmjAnz8pUyG8UroPLZokzNv0U/0Rcz6+z3mzPWT8/wAMoK
 +qeXR7jJMjuKxratKKw==
X-Proofpoint-GUID: oFp09ACT8O4Zc0QV2F5QAFoT4F_kJK00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230097
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32101-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D89591757A7
X-Rspamd-Action: no action


On 2/19/2026 2:45 PM, Nicolas Escande wrote:
> On Thu Feb 19, 2026 at 8:34 AM CET, Maharaja Kennadyrajan wrote:
>> Add initial thermal support by wiring up a per-radio (pdev) hwmon temperature
>> sensor backed by the existing WMI pdev temperature command and event.
>> When userspace reads the sysfs file temp1_input, the driver sends
>> WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) and waits
>> for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
>> (tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.
>>
>> Export the reported value in millidegrees Celsius as required by hwmon.
>> The temperature reported is per-radio (pdev). In a multi-radio wiphy under a
>> single phy, a separate hwmon device is created for each radio.
>>
>> Sample command and output:
>> $ cat /sys/devices/pci0000:00/.../ieee80211/phyX/hwmonY/temp1_input
>> $ 50000
>>
> Hello,
>
> In ath10k & ath11k you guys also had the throtling feature. Do you guys plan to
> add this also at some point ?


Yes, we have a plan to add that throttling feature as well.


>
> [...]
>
>> --- a/drivers/net/wireless/ath/ath12k/Makefile
>> +++ b/drivers/net/wireless/ath/ath12k/Makefile
>> @@ -32,6 +32,7 @@ ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
>>  ath12k-$(CONFIG_PM) += wow.o
>>  ath12k-$(CONFIG_ATH12K_COREDUMP) += coredump.o
>>  ath12k-$(CONFIG_NL80211_TESTMODE) += testmode.o
>> +ath12k-$(CONFIG_THERMAL) += thermal.o
>>
> I may be wrong but I do not see Kconfig changes that allows to actually build
> the new files. Is this intended ?
>   
>>  # for tracing framework to find trace.h
>>  CFLAGS_trace.o := -I$(src)
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c

