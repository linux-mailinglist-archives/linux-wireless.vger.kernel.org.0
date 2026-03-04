Return-Path: <linux-wireless+bounces-32430-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKgqIiOPp2lKiQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32430-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 02:47:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0083B1F9A67
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9FDB301A28C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804D3191BD;
	Wed,  4 Mar 2026 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHbyVs41";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Li20j/nB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72753195FC
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588832; cv=none; b=Ywe7PMIYSGbIVhyXd6MyP0u9dlWPzkR0f4dvIAvA3ZQHc+ShWKCepOxbhbwSLPCkEOD/j2ZEdMCb67u1oRR7FU+yIX6FyK8qRDeEoAVRYQuv38J3Jy7/aIFWg8SDHwc7rM4zSdP2xhmTmHioaN4xg6RxgLfpeeClCy0SZYqqZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588832; c=relaxed/simple;
	bh=uWRAGOBM9BIyIfP5HZFuAgmjR4roYQZluRh12WIST6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bcgaw8JNqT6Xmf3N3gtm1qJrecLJHXvgm+rT1ij6pLeAdpurcTb7gDY8jkGHF01J18jIrhhX9DZgdgx945H8cbrxo5DBDvMmyrS1RoOOQ9B3wTzaUR0WF9Wi7tMgLEDh5U06T249aFM6PTnui3ATc+E3LU1nd88bJ15L+4Rqx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHbyVs41; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Li20j/nB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0XfX687005
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 01:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LJB3nh3QvnyF/JIRZHSDJxC1oPX+zuLkSeYi0HOUoM4=; b=jHbyVs414p9fqRJ2
	ij4n0DwQkrt+ZYd7P4gVDROgfbiNfXtppEbW1wCXB/XxMBQ6hq42IAg9JdH5jrvr
	OyZsEKHE0NcNW0piwjTsMWzyecLEx9MIFDHtR/DpdnNoIQW+3Fg9TiunkuTqckR2
	jDqsND8Yv2wuxLaijaMR3ZP6X3bpkhKTdHs3srCKanNOa2A97RGQjC4zESeFaaO5
	hSrH6jbhiZwk5XGcEoHUok7wB2NoSumsaspN4efg+zylwu1N50lrofkDK6LbERib
	CQDO0uJ3r6vwsMQZzTLOWpBp5x7imlkSfHUrniEwbRMMxmuUPPrPStdlp0kCaAGQ
	IkRyDw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnu3nbfrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 01:47:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae47b3adacso28673555ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 17:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772588828; x=1773193628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJB3nh3QvnyF/JIRZHSDJxC1oPX+zuLkSeYi0HOUoM4=;
        b=Li20j/nBG1YDCSSJCVT2H4JWzwpqveKbprv/zkcT3fkdovX8IAcAR/me/uQHMV37AK
         x5jEXte7u4+k4b6xiRi8rMN2N0FuYdLHwXM1DntgLWKXHW1t8cDcq2sDVBa1/nD8z44E
         InJpqeU/IqG6tryn5j2tvd1KqXhf0Sg0R4oDYoyCUih2bMNEO9deaDZcJnrZ9ZTRnWwW
         wZ0D74jX/cwA79PVn2Banjgc8ElRZ0OYKWLtG9M+OqrCweqERajPm7SQ+d/BQQzla0Vi
         6hQBA7EgX8gON0sRCGxtXjgkJxdtRRJC5KhWTbnW6F0qmKiYE2+lXMyCEHQ05H2B6vJf
         IWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772588828; x=1773193628;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJB3nh3QvnyF/JIRZHSDJxC1oPX+zuLkSeYi0HOUoM4=;
        b=XJZi/sTLH4Z7NYPZiAnXiKhAWJEP4IpbV7ZouhvsgJ89F4Z7vcbx4NSS6kOSR8i9CU
         cPxplvh+ydhY2A+0YXuPHhoEOceRClh1F6fbg/jAv91wqkOBu7ew0MOLmshIQNqkfAA1
         R0O6Z/aBSUfRkeWcgUrkoJSa3j4wVkTFEEbdXbmuEzA22YY2mUmN7KSBxoR78YcteIzb
         l68KG4x1oSK7qpXdPI8sN/6QL2Dsyp21BbH7MNieiD+awfsGmPU2cKY7mzEwOVqRImYo
         8RlaXbgrpWObo1JBwV/Tu3xsTh4NLdhEyyk70bz8EXlcOlHpOPGrVvo6kCaZipzAPvYP
         rXXw==
X-Gm-Message-State: AOJu0Yx2uiL5xeHSLj3ogYBxbOj+HK6LWSB0Gwy4AOvrZt9DKi8eEFm+
	BRsWjxhGqP5FxPoYUqUb1JdBcVWDt2AKHOiMOUcXF38YkfB5VzdniU0Daf2scJFhUXLNyO57Kw6
	h4biP3IgnJ3QTPL97R1F3idqH/1U7TCPrTpT1yMjvr1g+J8f3nrPYFo6af4Una6K+2bDlPg==
X-Gm-Gg: ATEYQzy/Kzgu6D4f43DoQ1ph59Gz3w4h0qTj0k5VNi+DQToRvl+LrsW7BgCVJ5xwZFa
	Es8vnZ7XNhTo1ANYXaMB4INLhEDvNwAUhRjVfmXAiOG23H09lPRlxOmP+y7aF9tEIpCRkaf6YXN
	SdMi0tZaFgMjC0T7H5GHXDbgSMDGKxeXHng0ds3TxtLXjGsstlKK/3OZhzA2xaAVVoW2xbgGX3I
	jxbua21XBaO50s9hyErvDptN1N5yP0esWLnOzGisd1TDeC+HrhtJBweop/7MOngAUZSpt+5CMeU
	oNDPqVy4j9TdJY1QYnO5+tspzhqzKhtwSSKQXFE3BFnHxv3SHezz+otlrHLj1aJFDe2q09FfBfd
	sm+OrYe6H2sglr7Y6H1WsAok7HWZvNljNUr0mOSKYsorjqPh2fwHnDVCpppD4iFmywsu3gc1XO3
	F69In3tS/+nX6+sJh0wWc=
X-Received: by 2002:a17:902:f546:b0:2ae:5763:99cd with SMTP id d9443c01a7336-2ae6ab9fa3fmr4208525ad.49.1772588828419;
        Tue, 03 Mar 2026 17:47:08 -0800 (PST)
X-Received: by 2002:a17:902:f546:b0:2ae:5763:99cd with SMTP id d9443c01a7336-2ae6ab9fa3fmr4208245ad.49.1772588827750;
        Tue, 03 Mar 2026 17:47:07 -0800 (PST)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3a9dd3e7sm115610065ad.40.2026.03.03.17.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 17:47:07 -0800 (PST)
Message-ID: <80231e1b-fc6f-488f-97f7-92e792954022@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 09:47:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `ath10k_pci 0000:3a:00.0: not found station for peer
 stats`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
 <6a83fd12-edd8-4559-b7ba-75b074fa889f@molgen.mpg.de>
 <5c152304-853d-4142-8553-55cd8907f271@oss.qualcomm.com>
 <2c722676-98c6-4162-96cb-9bea06672153@molgen.mpg.de>
 <badaf39e-6ab7-4be7-944a-cfc9d6757db2@oss.qualcomm.com>
 <e71b2039-0478-4775-b221-753dc25647d5@molgen.mpg.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e71b2039-0478-4775-b221-753dc25647d5@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69a78f1d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=exyQ1seZzitSerPTUx4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: kaqe5cg9S3YEnkfxjUKO-QTmuqHbUEno
X-Proofpoint-GUID: kaqe5cg9S3YEnkfxjUKO-QTmuqHbUEno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAxMyBTYWx0ZWRfX1DLNSP3zGd2k
 vM+OiTc/UlCWq0+4DLLWZvEf+XxoXdNfw2szzLGrJkj0FGdZeb27HsTIhH1eAsBXGQAm1jXCdQm
 BIg7ldzWyZvB1vqpneBJSie4/qW9hen02NIoxo6yjUPB2ifPuZssIsALJ8JTw5Fbyist5ynI3IT
 0NvuDS24n1AzlEu0VGfzpHnOWJvzST6Zi9JY014cfjMUrHxuXskySRO8wAlUXtQF8CEJmNYcRJ/
 EhH+CNKlqhI8M07MrQV13IZXK+aELWU7Ou/9X3M7SiL/GGB0JIgdpkCydmSdEQ8uZwupIS82bFo
 g/7gypM7W/CJ+HdVE8p6g3autRSrh7tQjENzvKVTyOI8yls+WHKiKnZAxPGfdM2M55dV8PzpOds
 F6T+lNfkvJzHj1xPNrOonU2p+JAhZ4fFeVSg3Omy3qdONjYHgZ146ccN6OiU4JEYtNWcfjV36nc
 AGhlzcN1cq8VZLJtzUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040013
X-Rspamd-Queue-Id: 0083B1F9A67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32430-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 3/4/2026 4:01 AM, Paul Menzel wrote:
> Dear Baochen,
> 
> 
> Am 11.02.26 um 06:43 schrieb Baochen Qiang:
> 
>> On 2/10/2026 6:31 AM, Paul Menzel wrote:
> 
>>> Am 09.02.26 um 03:44 schrieb Baochen Qiang:
>>>
>>>> On 2/7/2026 1:55 PM, Paul Menzel wrote:
>>>
>>>>> Am 19.01.26 um 17:41 schrieb Paul Menzel:
>>>>>
>>>>>> Since January 10th, I have started seeing the warning below in
>>>>>> my Linux logs, that reach back to September 24th, 2025:
>>>>>>
>>>>>>        [   37.108902] ath10k_pci 0000:3a:00.0: not found station for peer stats
>>>>>>        [   37.108906] ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
>>>>>>
>>>>>> It started appearing with 6.19.0-rc4-00282-gb6151c4e60e5, the
>>>>>> version running before is 6.19.0-rc4-00003-g3609fa95fb0f, but I
>>>>>> do not see anything related in the commit list:
>>>>>>
>>>>>>        git log --oneline 3609fa95fb0f...b6151c4e60e5
>>>>>>
>>>>>> The warning log from `drivers/net/wireless/ath/ath10k/wmi-tlv.c` has also been there
>>>>>> since 2021.
>>>>>>
>>>>>> Do you have an idea? Please find the output of `dmesg` attached.
>>>>>
>>>>> Looking through the commit list from above again, commit
>>>>> a203dbeeca15 (wifi: mac80211: collect station statistics earlier
>>>>> when disconnect) probably introduced the new behavior.
>>>>
>>>> is this error seen when disconnecting from AP?
>>>
>>> I attached the logs in my first message. But yes, it looks like this:
>>
>> sorry, didn't notice there was an attachment.
>>
>>>
>>>      Feb 07 06:32:52 abreu kernel: wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by
>>> local choice (Reason: 3=DEAUTH_LEAVING)
>>>      Feb 07 06:32:52 abreu kernel: ath10k_pci 0000:3a:00.0: not found station for peer
>>> stats
>>>      Feb 07 06:32:52 abreu kernel: ath10k_pci 0000:3a:00.0: failed to parse stats info
>>> tlv: -22
>>>      Feb 07 06:32:52 abreu wpa_supplicant[846]: wlp58s0: CTRL-EVENT-DISCONNECTED
>>> bssid=74:1a:e0:e7:b4:c8 reason=3 locally_generated=1
>>>      Feb 07 06:32:52 abreu wpa_supplicant[846]: BSSID 74:1a:e0:e7:b4:c8 ignore list
>>> count incremented to 2, ignoring for 10 seconds
>>>
>>>> did you try with that commit reverted?
>>>
>>> Yes, I tried it now with Linux 6.19 and reverting the commit. The warnings are gone now.
>>>
>>> Are you able to reproduce the issue? What devices are you testing with?
>>
>> I managed to reproduce this issue locally. Will submit a patch fixing it.
> Sorry for being impatient, but as Linux 7.0-rc2 was tagged, were you able to come up with
> a patch, or should the commit be reverted for now to have more time to analyze this?

The patch is under internal review now, will submit once it is approved.

> 
> 
> Kind regards,
> 
> Paul


