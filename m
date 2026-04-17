Return-Path: <linux-wireless+bounces-34934-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LjhKnI14mm13QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34934-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:28:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ECD41BA32
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9399300BE90
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1851C84D7;
	Fri, 17 Apr 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f09k2gTQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eQrdcJ/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345003A16A7
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432489; cv=none; b=E32yFUE8MFAAk6tkT+VJT1JBmjLgeNlqrGApi2hSgkJ3HglUXUnrJpzbNz5kWEHywG3rMmq921qtJeXAU5JpBqgD33mKwpeNcJ0YZ0uTD5XipzWSbkFM438OAXWji3v72NKwsybSRKCzQCujwK9a2MDqDdgnExQtCeiZAtRGfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432489; c=relaxed/simple;
	bh=reVj/47ODRkZ7sj70bNmhneViNMnuvpe9iWviBB0DPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIIW49jkKNNlyPVLNYw5v9HNeKC3SgqeNNi5frHkIsWMiuelJ9snA1Z1NcWm/p2XPWYSYdf+mTmy6fwWPEkxckA0MKu0uvGpshk/11AGK027pTuACYUqZUecVgcwHiksAtfk2GmFZUS1mbaYcXas3s4AIdRKtmmTrhGF2dGhGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f09k2gTQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eQrdcJ/A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HABcja1323334
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsBDJgupJBFrJHiUbUWMMtapG15JCIuiJIDvsovcW1o=; b=f09k2gTQpYqIIzub
	6GFf/QB2tBnKm90nzRj8SWpWlm1qXBYrld3A654TFVTVvcUGBgYIkHVwOMk6Q7+J
	E/bIIdhkp+ht4oZ1paOVnnF1cCKg7LvbNBX7Lr/hdRTa8EEcOOLRAt1/qh6Gvmer
	pXbkffh/YOuqdFD6Yz8Nn1ltEWG0y71e7FI2octfLWbR9TvH3buHJLNSB29iCrFM
	81mm3J8dWOs0kk27Uo45H/9D39Q7+0knfx3R6Tim/37olnQjlAjgVQt2KIE/S8fE
	GfU3j8AX8IcgVCldSYiqy0r8ynLxWrdaliV7H9e+eHk8Et7K27HFHcC4IDlj0hOH
	5Fssuw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkdgy1wdq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:28:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so774806eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776432486; x=1777037286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsBDJgupJBFrJHiUbUWMMtapG15JCIuiJIDvsovcW1o=;
        b=eQrdcJ/AjIA1DW1X+K5heEx9Ct97+D7SUtQMjnUM3LBdKEuQ4Khyui4aZv8Dctdty9
         mAV4ohBAYq3Jq/JUCSPWRslk3JAWPS5PGRz8j4EQN2ruBhdWhLHNuPvmNxW/UIqCXUtg
         BhHSavoYdCOSMzgQUKbsTHVY1dozVbiskpZ1hQe6Z9eN20FwlVh00DzIb84wdVu5IMda
         1fl48Hzb/4fkzoR8tpXjyVUujFwTlvHoGDUYO/0/qbnsw1n9AeY+8l5xfMNhR68CRWNt
         UW9brGQnnd2JJzN0vrOygTM6MDMlCnm1kE+rSNFmru8TbYZQB26l6HjJyk7lZVJ7x9V9
         VngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432486; x=1777037286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsBDJgupJBFrJHiUbUWMMtapG15JCIuiJIDvsovcW1o=;
        b=dhNcG8K6f7aKwAqvQTIwti2xFFCgBhxMU/D1gxtoqAmjyTq7OJ5DokKU9oDGAsVy2X
         NTFdFG5SByovTLpKgtdjw+WTyCcEqvQL7TSIigb+vEEuAff01f1vT8KoBDbM40ckUpNb
         aV8F19NOJ/vS1tFLEgzOvU6zLvSDu9NpIbpPXXhZO/q6iav0bGZ84aerZEHrcGsAQgiA
         wFl4m5P0jTVMncMOgIO2VeigXU3RASXcM5Mn62kpKs+AaQoQ0Yx9/A9sya23dASrZFpM
         sOq0F9gKKj5B5vYIC6Ob6cK5fQ0ux4Lc4FvEQ2SDJq/eYeweZHzqZpYBCWECTJ3+NZni
         Pdzg==
X-Gm-Message-State: AOJu0YwTk5/gMwFNjanN0hSYJiwvd3T1D4lv4Qo0ShM9zbr7VK9mDH/Z
	QCjokgIFvhiQpszadN/vZCTAYp8Zf29NSMO/uOOPf1bwuoO+QlmppI322vHmaFJxFugCiNNdCn6
	Q9PWC+44DnOoJTrnYEt0lzNCkopgyXJjn3qpTx/2JvEt1jiCuv4UE4HwjYWvBZE1WJ8/nTg869a
	4VzA==
X-Gm-Gg: AeBDiesFJuL0wzPIcQbeZkF3Ph3NiPHhTy4XGoqBu2xIg5kpopCwDLG+NRHC5qbu3hQ
	EV3oMAru9nsZXa/uEa2IKwjOAyws77ggm45okiw/swkIpSkidLI67ISR6lbugoDRRaaZjEdt0PE
	NB8zH8zUT25Mz1+ufCjkm8oxXhpY1gcB5F/D7kZ1IO14IuNB8J8QzFjjY0sUpWYEXub6aRJCnjM
	s61vf/4i+kYh1Ee1zb7LarXVsRnpFmRf8bTur+fPEwxk0z/be0QFBhPpJSh8xFV4rLNEvz2OR4o
	oCdwPdWGuilLngLyYjum4JohI8TJqgR6eSISbBZg2Z1JMZOg3i1tbxcdkqt3466b2tC/nuLDCUj
	H6f5lK/414I9FzqkhmatdPUC9F0QRpWlKu6fYXqL6IXIyIE22rbTj1OJoCiX0iWRjYOa/
X-Received: by 2002:a05:7300:641a:b0:2dd:6937:79d6 with SMTP id 5a478bee46e88-2e46c48a9cfmr974107eec.7.1776432486176;
        Fri, 17 Apr 2026 06:28:06 -0700 (PDT)
X-Received: by 2002:a05:7300:641a:b0:2dd:6937:79d6 with SMTP id 5a478bee46e88-2e46c48a9cfmr974087eec.7.1776432485441;
        Fri, 17 Apr 2026 06:28:05 -0700 (PDT)
Received: from [10.206.105.246] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm2042942eec.21.2026.04.17.06.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 06:28:04 -0700 (PDT)
Message-ID: <3a6025b1-5098-4760-ade8-eb7ea4b65816@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 18:58:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v1 1/4] wifi: nl80211: rename PROBE_CLIENT
 to PROBE_PEER and add STA-side probing support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
References: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
 <20260415094304.1731390-2-pritiwa@qti.qualcomm.com>
 <acdce727bcc094ae13846bcf03bf0a6206186200.camel@sipsolutions.net>
Content-Language: en-US
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
In-Reply-To: <acdce727bcc094ae13846bcf03bf0a6206186200.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y4dBPFsyl07S5oEsBdmwqedoxyn_tJXc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzNSBTYWx0ZWRfX7V6pNx6covoy
 ZG5M1sLrIVrgndRTTc1bVkb6t8qb2luVylTOlYNSTjnawJQVEqXs5UKX/646QFBdI+ccElTjoNE
 00U+vT1GYcMmF0II7VYC3tNLaCK0WNwTng/Wq45NtvuZulqkY/Xf9Azrch9tRWltiMUAVyImk6I
 aB4wAvByHMCNs7asir3JFl8RfsDDBMnltVp9OIbCMuyT8k3IlSGo947ca7n0Ua2N9HdK+5dJyv4
 DodgDJFl5Q8Krf42FkoeNJNOrRukEF/KeYJWrBKi4E5imV/OJV3e/ADZBa0vA384odVhmIttyi6
 1qjd3Whfc7cNQTnxoh1W2FvydDrm+7cLX/Rdf0/VLmX2Hj5P7MrZ8z6v4DWIBes07Q6QkiBPXdd
 j2dXADSptehJbr8k0NieMFhQxsKzEA3PWP6Hkh7agypMs1eNCXk2ORlV6tY5+FldLaZcGv9eYzW
 tbCzgK+FAsVoFxWSanQ==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69e23567 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=0v0I65xdqm1H3p92iXkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Y4dBPFsyl07S5oEsBdmwqedoxyn_tJXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170135
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34934-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C2ECD41BA32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/15/2026 3:23 PM, Johannes Berg wrote:
> On Wed, 2026-04-15 at 15:13 +0530, Priyansha Tiwari wrote:
>> From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
>>
>> Rename NL80211_CMD_PROBE_CLIENT to NL80211_CMD_PROBE_PEER to generalize
>> peer probing, AP/GO continue to probe associated STAs (legacy PROBE_CLIENT
>> behavior) while, when the driver advertises NL80211_EXT_FEATURE_PROBE_AP,
>> a STA/P2P-client may probe its currently associated AP to quickly verify link
>> responsiveness without waiting for traffic or long timeouts.
> Why though? Link management etc. is totally up to the driver/mac80211...
>
> Also I'm sure this isn't going to work for all devices, e.g. Intel
> devices can't send NDPs from the host (this is probably wrong in the
> iwlmld driver for AP side though.)
>
> johannes
The intent is not link management, it is to let userspace explicitly 
verify AP reachability on demand, without waiting for mac80211's 
internal probe timer.

No change has been made to the AP/GO side.

The NL80211_EXT_FEATURE_PROBE_AP flag gates this feature: only drivers 
that can handle host-initiated nullfunc frames in STA mode will 
advertise it.
Drivers like iwlmld that handle this in firmware would not set the flag, 
so userspace would not use the feature on those devices.


