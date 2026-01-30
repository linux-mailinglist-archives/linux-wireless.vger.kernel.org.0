Return-Path: <linux-wireless+bounces-31404-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIXmHggOfWk1QAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31404-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 21:01:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4311BE4A6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 21:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 600053004C8F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1EF28934F;
	Fri, 30 Jan 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDrwHOQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iXgPuYpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47A2741DF
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803266; cv=none; b=qBAzWLyFkqB53FnqpM6sl/BDr9A2NVzD3WnNLyAdAiGQULVubBW0A/b/KDR8Dsiej7UkJFZ2FPCGZdNENok9mf3Pl4vpa7rmAPDzt7OH0ZDBPxeYbxDtxvJRrLL3TC2m2Yjz2uFPzZd7s2C3q8uJVejExSMiafC1OTMjkhtiTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803266; c=relaxed/simple;
	bh=SWt2XETtKT6EgBEogQxBwj4xJLyK8xHgCvi11I2zj6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGN6dbjtH3xXhm3NMtAroPrMtec5GlKUHzZpZHkGGUrjHGNn0OWpmU4zxVNUuvKN2EnmIvqn352ahGE5E9ogXKbtqWQpnHMhtS0HRwkNMa6LISmZO/OZy0vd6X/439991lLClxCWM2Txbwon9dvw2BoDGE4YbzD/XJyvIRx3ZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDrwHOQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iXgPuYpU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAniCo1022128
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 20:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tz/hsnbD2K7FC+wSCS9iQfBJ4f/RO7qpudJGts6770M=; b=bDrwHOQZYvNzAECP
	RAruACmted87t9FtA4Z3d82HJ2nKgE+X84dkK2fQNVyiSTsvrVRbVGQIbSqYzXLa
	z+7RSj3OJsdh/do/aiM6RMVh0BLcSKgHolYY2eK445CCx2jFHUl4ULb0KhmBiPRY
	BjhTZyuTbbEXgg0J5TsD8HoJw5uXml211zxyGSc6JZyZikicX2Wwd2MJZMbhaG04
	88EG1uIKUJ5jFVXRJkbOP8mIlk41YcEhjM294+Uu5Zsi9i4O8j1cuNTzBPsSLXT5
	eB/4LjIVM4FW4ukmmQGiH47B1iCtCrwRzQbxsp659Zt2P2AuNthFIgFG1iicOBp+
	x6SMlQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0e3kbyar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 20:01:03 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12337114f3fso3648561c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 12:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769803262; x=1770408062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tz/hsnbD2K7FC+wSCS9iQfBJ4f/RO7qpudJGts6770M=;
        b=iXgPuYpUXNA9SLTC46JaX+TKnLG/HmIJSzyb3Dw2kCiZrr/ODOx0q7DwS3pUMc+sg4
         JTYqR6MJU3//6Qy1tW7gMCNw6FWDuENlglU0cA3R0sW3g2kTkJKOwtvyknCbJ/91OidB
         CMbtzCDi7QS5PgfmxjWRjuPrgG8b2t/JHUCL/FtZ69N2scgebx8VLCHQorq7jytf6jwa
         sxiRdumQvdtdRj5wBbDq8GcqlE1i6J+HmxwSVucpV4woIwEO5qowOboE3q6DyztG7A/U
         Ld+k0ed59NTEUAva/+s0d8hBbXv+3Ka3b0Z1Wgotyp2zG5VPfiU43fU8PKWC+uQs9o1Z
         zKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803262; x=1770408062;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tz/hsnbD2K7FC+wSCS9iQfBJ4f/RO7qpudJGts6770M=;
        b=uOFPFaxN9Vs/oAM1EWrVTQmSUcIslCm5gpt+QIH+sfXHGb0CoCEsOu5ZFy9rr5ABLQ
         OR7Uan4LFU+0cLyVHj0/1Rwf8wKTY5LD9Hp2v07n7uizAyO09y1Ga1bxT50Iqr8/rrOY
         ZyeTaqgbSBzrhue3XtTW+6SCpBw5IQxlYlwHqDfHkbXNFfWFVAmRVv+av0mi4kzVdTx1
         LzUQ4dB1QERHxnPX6MYRDsgwVMxgJVmvkchlpAVYgA2wK3NPVeGMXmxm9DrPa3qAy6rD
         E1B4Iuivi769qNazhbDC4diL4E9LudysTXVUSlB1zamoUnOItY61oPdCo3ztSDfFiQNB
         vX6g==
X-Forwarded-Encrypted: i=1; AJvYcCU2svAtLwARS7N4cF5bvRHtUXs1C6n9teAfzNCZ2JjKxaYsis8fhkkgAWz3rq+awXvEg1JisoClmOc/taFYyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytIlhRC87w/mgvUHN+a3ha927Van1/Xh6ySAx8+f4zzMpMnXf+
	/gyCu/A51o8kRPPfJv/c62wxeWaYFM66sidMNW2WkYPdL0d1FEv5Jv2FwnQoL5HIVqait7pCeRH
	eUrdcXYLhtwlk8EmycyTz941lt6y5TKpDPT4+Ajcm15s6o223MEOTRCW/fl8acWyHhTtQwA==
X-Gm-Gg: AZuq6aJ3FLJF38XnoCvl9fxUieK4nOKadpGJMwnOgKPRu8R3QEN1q4ErlzQo5gSXqWo
	+A+/fcr9rOIPobosgBfNaBGcQ6hvzD355o8NZ6sBbHUgBJ0wl6gj2mrI/bvsiIvbxh+H6BX1V3m
	H9hU110w4FkfTsw+tbWlYLKZt5wdIEYt5cxgHxh6pEEM4HwJtiE89WOGsKH5DTv5LLq2bfjKecR
	5aQhJhA4/qC2Ny1DxIBi+xZHewdUuUQIHDw+6C7iCcoPYYy2fHgUgHGXsLcbNux+MxFj+SNhZ72
	TPpL71zInB7SZ0kWyf+LzisnnYxY6GvR/X5M/lRKjuUxk80L//XpQ+mI6G88ZZsRHUYWyu/Uovw
	5gBrpbI0IButrbd2PjfaoVsxlHD4Rfh9lj2SFlQShQD/dMS2xZn3hlQf/XLIYnUlUTeQM0wthd9
	b9
X-Received: by 2002:a05:7022:6082:b0:119:e56c:18b1 with SMTP id a92af1059eb24-125c1000e70mr1983165c88.25.1769803262323;
        Fri, 30 Jan 2026 12:01:02 -0800 (PST)
X-Received: by 2002:a05:7022:6082:b0:119:e56c:18b1 with SMTP id a92af1059eb24-125c1000e70mr1983143c88.25.1769803261707;
        Fri, 30 Jan 2026 12:01:01 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm11546699c88.16.2026.01.30.12.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 12:01:01 -0800 (PST)
Message-ID: <7a763739-8acb-4bc2-92e5-3ff8a3fa2bf6@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 12:00:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260127
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <6f1fa3be-e28e-4653-bbf6-b0b64b7e65b2@oss.qualcomm.com>
 <usrawtmodalbj4b4i22tk3hzgbrpt3gdbji4x7vfzdhp6qsb3g@rw2bl7jdnp22>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <usrawtmodalbj4b4i22tk3hzgbrpt3gdbji4x7vfzdhp6qsb3g@rw2bl7jdnp22>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VI3QXtPX c=1 sm=1 tr=0 ts=697d0dff cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RcOUi4Ga9jvAjSuFGeUA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 8YgVTtcJDZcn4LCyfar_Z2qXY5T5mbHz
X-Proofpoint-ORIG-GUID: 8YgVTtcJDZcn4LCyfar_Z2qXY5T5mbHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE2NCBTYWx0ZWRfX1nqyg6aYCIjY
 hGnXB0b8OIrl9ynPaDQs0uJIS3zbxxTPlZG5wtwz5kkYjFPChf8RS5wWqvncKuXsV+E5/++jWNL
 swDTl7tZ+eU7Ts+8QQrG7ZG0zXIx4QR4uk3G7NxpMgB4mwHRsxB5tLe31dv+5gDDNduNu7EujP7
 AFgjNFaJYysGRfR+grqhTrU3zFNewtmw3S0BRjjl71iJwriqlOCGA74FEO2TelGqnVehd2N/Er1
 ocSRNgzj5/Z5mCdTHcm1w/M1WwpY3B7jvi/lnEgV+QaZifzMoUTrRGlLCt1XgiPwkWyMxQMCiSW
 EKllTV3ukXO1tAsT1H5oiKiVGmjH+wTIK9RSlXK6M8boEXySVuySSh5oNh7HmiwVntdKAfWTHSP
 1cCONEPW0tW5h7s4fYDBG0NwQj2kRoh+t12keMQDtdCSyc6MqUiXhguc7S96pjWmz837fxNbOGw
 BklQ9BRJej9R25RH3OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31404-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4311BE4A6
X-Rspamd-Action: no action

On 1/27/2026 10:36 AM, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 10:04:46AM -0800, Jeff Johnson wrote:
>> Hi,
>> Here's a new pull request for ath10k, ath11k and ath12k.
>>
>> No updates for ath10k.
>>
>> For ath11k update board files for QCA6698AQ/hw2.1 and WCN6855/hw2.0 to support:
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=255
> 
> Don't we need the variant for this one? Otherwise it's too easy to clash
> with another unprogrammed board.
> 
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268,variant=QC_Hamoa_IOT_EVK
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride
>>
>> For ath12k update firmware for QCN9274/hw2.0.
>>
>> Please let me know if there are any problems.
>>
>> Thanks,
>> /jeff

Please drop this PR.

We've spun a new board file that addresses your concern and I will be issuing
a new PR.

/jeff

