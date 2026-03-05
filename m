Return-Path: <linux-wireless+bounces-32543-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG0vN0OiqWl5BQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32543-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:33:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DF21498D
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DFF03004DDD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E92309DDB;
	Thu,  5 Mar 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PcBG0DSp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kk+KU5dS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBF36DA09
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724800; cv=none; b=oGlk8VgVk5+LnzJsfx1cdBq/ZagMJ3uCRNP2ouikw+EbsfULKvnyLoX185q2Ail/J2dc1OBfs2aC39U10z+DE3qrV2YK1qP2fIF7BCfPD4O7G/Hpe/Z6FWSm4KAT3Q5rwqEvBVfxzWFubd9UXdGbzvhE4/AAYxPzghBneM5eyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724800; c=relaxed/simple;
	bh=yrPhUanwuRXyINSbKNLBkEVyk4z2cUKclRAoAEq3648=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPJQHa15FX4w7QrmTeJ77hfLbCiEwcN4OFsbhCIgBcuXrTqiyr2gRfAWxWr6fqmhWyXTMzJ4pLF89hFQoYKM+LLfC696R6QY2oTlhYzMTeE2j0AAGdJs90lAqu818wB0bDGxdPjBgp0ZejfTcWUEBuY3bwNZ08GxLWOsZKvSfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PcBG0DSp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kk+KU5dS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFnfF4171050
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 15:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VY8MB6LQt2erK9gj5DYHw61N5sXm1QDeiKlOSjOJOuE=; b=PcBG0DSp58ZjBh+P
	B2nh7VnmHSgqaYvGCSrWtxVgQVbOw/XJ/0DCrFEHLfzmzTm+IESa7yibYbGedbiX
	u+3Nvxb7ByxHjaE8S0zGCuwkAMWwKmQ8rFMyZyAvDmVdNnS9zBKqmLsx3t8xM1US
	RbySG0znwQgIyM9yQVD8zHRrNK8ZhEu7PmRTF1MkWNnY9e9RHByh+PF+CEnGZOPE
	uMkLd9PQoaBvf6a2sKQGhvZJEAP9gpsVYNmnojlm8RNGfx1ry4sFhUWR895yzQoe
	heT+/j+wk7DLfATaySGP8f0uKPbpcSXNdU6gPUlHC05mELcEiYVBJ0qM+4bG83+L
	nphKjw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuhb3bs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 15:33:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82984060901so639497b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772724798; x=1773329598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VY8MB6LQt2erK9gj5DYHw61N5sXm1QDeiKlOSjOJOuE=;
        b=Kk+KU5dSyRBozZj6X5fsgUqzJN4uxdhIK4ICkGROsxLaOvGkGpHKsCXUF+VvINjOPT
         rsPKetkI8/4NvFeyQwT70VFpnXR/RlRiVUB55uNwjr/keOprC4/nfiPvqWj11pqIxwBc
         6pEo4yvvguZ8AgdPIc0xy5lbQt5Rj5aaufyDr+UnEwMlS6sNd3VNQOTlZbku6SxXKqgr
         9CPyfBu7HMFNasgE4hx/s6gOYIzPa2Iyypp0tP2Kxw1cMGilfEdFwzuEajKsUOWSFw87
         L/qD9YZcwFrOU3tglhowNFWuD1eOtHuZBeHsG4uxfZnM3ak6dqdhJ5PiU77ccuHWlT6m
         s19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772724798; x=1773329598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY8MB6LQt2erK9gj5DYHw61N5sXm1QDeiKlOSjOJOuE=;
        b=CwQA7V9oQjLU+dlqnMh3qCg6p0MNGTiC8lW83U33wGBx+gSGyX03KDjGMd96wBGY1O
         Zw0xZ3UZtCVDc2u8nE6u2itStV5RFCZ5UKJBD5DerxGaeuiH9+8Q0dHLgEu4hIEivsIW
         LCysHjDEuViOggfB+fV9qk0XE1wKxppw5npEir+DMOyybcsOQGZ0Vd0l1olnqUnciiYP
         GeTpWVW31RsYZWd2X38ZETXYW58iCh5ciVHVwo9VJMEZZ8ZAw3PGcGsT216iRiUjLHGT
         EzPyz4amh5XEmQOUPAkGGfRQrFQNEruztz1hYeYhn8MI2j0oxXZwE6epC7AnhpI6s3L8
         a7ZQ==
X-Gm-Message-State: AOJu0Yznv+oroyY3n7YXd2NtkwsJ58EiqW9ZlpfEOeQ+uw1tQxGJxTzT
	bpAKuevUAJAyZ42irrI7mwfQEK+MFL9AnzGXEmQEMiqWtEGPE4eVgoJCvkwQTuJMo0sRrs9OFH8
	G4oQm7qxFdriwadsnGfhO45/2M//zdEItMX40ZHnzt3KsoH+kYblgpQnuKIfJj2Go2mu6ztxIID
	7I
X-Gm-Gg: ATEYQzxv3i2zlEuWMIxYK9IZIcfMhyd/s+7rT5RytUwd5MmBzRaAFJxnJbEm4Fp+dhs
	rPekklllFdvnls3lw7dWVfvsaE6T3DRXfD8mF4ZjAbIxNhtFnLSkGIaUEKa6ZBp8ycRScH5OWa1
	zvkxhbNGMJPQqbtzhVzm+acRhlLrr49nHgnXVYhQRb0hgL5Eu32gEHkSi+CE2Waqmn2+mI6CyZ4
	ZYa27AX+r6k+8p5Zn0eGEqY6M7SX41zDI3MU9X+JVdqKvVaoLAsKj2YwZsRsoQ5h8W9tRDXV9ud
	CDTj33xTTOHZGtz4gTP+diyH4aPIb1WFyO4MQqn92m4MCb8mABrTsYuVAe6etUCqvSpJDKqM6gj
	EqVACztiQ3AkzdomDylSvi5DbinVMnbTDo7sCk8es1l7E4SPB7FNO
X-Received: by 2002:a05:6a00:4396:b0:7a9:d8a8:992a with SMTP id d2e1a72fcca58-829855eef94mr2870896b3a.13.1772724797563;
        Thu, 05 Mar 2026 07:33:17 -0800 (PST)
X-Received: by 2002:a05:6a00:4396:b0:7a9:d8a8:992a with SMTP id d2e1a72fcca58-829855eef94mr2870864b3a.13.1772724797050;
        Thu, 05 Mar 2026 07:33:17 -0800 (PST)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05c0b0sm21343626b3a.61.2026.03.05.07.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:33:16 -0800 (PST)
Message-ID: <21f78318-6951-4940-9cb3-e9e6f5f317ba@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 21:03:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 05/16] wifi: cfg80211: add start/stop
 proximity detection commands
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
 <20260304071538.3833062-6-peddolla.reddy@oss.qualcomm.com>
 <0ce019564f0a12f9ebb68e505485c5df94d7300f.camel@sipsolutions.net>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <0ce019564f0a12f9ebb68e505485c5df94d7300f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyNCBTYWx0ZWRfX7wwTTc2Qo/ja
 cAbqKMQR8z+VwsbFnjxUzmJZ5g0VM3Eaf6QeXBTccpb63bG272GpcrHDkDgrcELRFFdNDaXk+LN
 EMal1tQd1XMfiXAYmOOEq8+WTJsOXWtNZwrPCsAJOVwES/4qaNMrS+AaJNxgOhyQSIMwKbdmCx9
 LwlfKXSIpkfTzxDI1Ye7wGW4xeFuQooIyI+fIbFXpiKKw+Xbuku/8YxUk2XEgpcQr7d8OX2sEuw
 itEHy97N+VSEBQ6D1EiLTE3VSsqD/dMPwTcHN+JxqfCTr2aBKbMm1un6JgPoSFNnBxFBXDQwN/u
 DLOFaNpUVljobgMJ8EsR8a3OA1bq+VYI61zaU7X6SEHh8SXzZtHgRkQIWoO3E2ckEol11gmtSJU
 SCT1YYpb3el/NEkoq4oJA0vukOKVOXSB0oCOSX83isunkKPhMjEnuTpUPqup9kWu3mF0DyjiTpq
 81miTmdcHkp46Ht3TcQ==
X-Proofpoint-GUID: u7BLRmbNkk1EpPuqY4N99q5a8j5uekJf
X-Authority-Analysis: v=2.4 cv=SqydKfO0 c=1 sm=1 tr=0 ts=69a9a23e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=clh_EXJFYCm27DxF2MYA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: u7BLRmbNkk1EpPuqY4N99q5a8j5uekJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050124
X-Rspamd-Queue-Id: 684DF21498D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32543-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 04-Mar-26 5:17 PM, Johannes Berg wrote:
> On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>>  
>> +TRACE_EVENT(rdev_start_pd,
>> +	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
>> +	TP_ARGS(wiphy, wdev),
>> +	TP_STRUCT__entry(
>> +		WIPHY_ENTRY
>> +		WDEV_ENTRY
>> +	),
>> +	TP_fast_assign(
>> +		WIPHY_ASSIGN;
>> +		WDEV_ASSIGN;
>> +	),
>> +	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT,
>> +		  WIPHY_PR_ARG, WDEV_PR_ARG)
>> +);
> Why spell this out completely?
>
>> +DEFINE_EVENT(wiphy_wdev_evt, rdev_stop_pd,
>> +	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
>> +	TP_ARGS(wiphy, wdev)
>> +);
> Clearly you knew there was a class?
>
> johannes

Sure, will address in the next version. Thanks.


