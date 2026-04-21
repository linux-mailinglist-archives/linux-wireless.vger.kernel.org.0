Return-Path: <linux-wireless+bounces-35117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kANhONsW52lQ3wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 08:19:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890C436D73
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 08:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658A3302BB83
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 06:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC52F5A13;
	Tue, 21 Apr 2026 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7YYCybp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kv3jYPeS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0A2772D
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752161; cv=none; b=MyILDvJHMAF900+tnYIUXFEFweOEcFrKZoevaWUODdkG83sJmcwx7pinij2TfZbakGobIqV2qNkTTPinO2EqmwUiTgfCr/JgfONTdRjAUZGvYPYaR/JMd5xSql8GreUhgyG53t6ySbIOjPM6XHCsgiXc2IEPhdJq1MzQC5tww1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752161; c=relaxed/simple;
	bh=jOJ7DMqcXcVHp4qj4FDuAp0CTF813PeG7djJ1WmN0TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnRb2fy6Q3B8G1nWNb0P++NDLiqKsOMTBfVewC/YwRineYXy9HcIqjt24p5Uu7yP7q2SuKKBrkRnqsgn6vdlkTNkLBeehzAbQWloFvgY5/bnfrU+ndhQAV9N9Hk+Ge+W8dx3igPZyiF+V2UFCeu1XO1aZqHuDu9oGxVBCqAuHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i7YYCybp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kv3jYPeS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L4GrC63455270
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fGJ2RvR2ic2jFvaQD6XapJ2qXWBqPIWAYII89I3SOlM=; b=i7YYCybptWcmD9ov
	6OndIP7X1HMOhAMIg7z7va/x2jiQUGIcbl+ubR7aYOVvR1FV7vUNH9JX/ACS4ISs
	E8TJTIF4ZcfR0DeNZZ5QLlgoQfdYNvIDDZW8KCFMbduH0WXC9MQB1HkAutwC3iI/
	MnjB6SyFmOtK4t1WGA3VEwPUiUszXwXV1q1HsCYI/AZY+UNH7b2C7DYrUJf0BgTa
	fThsudG9d+70JeVvGA5EnzUAroCNtB5FERaEs2Q+M+ijp5OZDC5rj70NyON5LwAu
	rQsreEYoLesIE/qSi7Nx47uCAZ9QQ5wrOi/DcSUYElC/QZkavtCFUElStxZqnChe
	o59ZOQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjvm5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:15:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso3778867a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776752157; x=1777356957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGJ2RvR2ic2jFvaQD6XapJ2qXWBqPIWAYII89I3SOlM=;
        b=Kv3jYPeSmKKcr6mNp75cMcR2xtzQ/SVJ+HyOLKFxPBWWUB38I0+86k0Jozg4BiY3cb
         2SFwFJri4+0/RXtbComtQ6Wseehn6/f8yHWSxn6WOlY+ImdLpq25YzJ7VeXKbFSwpId6
         7KS3452eHSTrXZ2o5VKqI2Gt8hdaI7JeQ3M0Izn4ROsQLbhFQjuvxioMQDsMPurLlqUN
         MMSJqHC29kcooVwGHZENfY50wcbBGi68rxfTPrj9RnBsna8Lxdy7Xd2cPyfPC9Yt3j0p
         7h8rnyIeQcwLGfMbJo6CXqFT3tCQ9mHl2jCoFn8EBgSnbKzlmNWJ4uZo4y3O0Fpt85hh
         wyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776752157; x=1777356957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGJ2RvR2ic2jFvaQD6XapJ2qXWBqPIWAYII89I3SOlM=;
        b=kKtxwkp9XOX7HeVF2yg0fKbfTmsFAqk+LLVzpeMphgJgdMjOpkZjXAZeG5fHC2zvpv
         CcvhLZwS2KsLBxp2cRPpdzt2HGe5WqzUuADWCORYAegJKQkE7LKtD/SEAhRwb+g9/vG8
         707WyNnw3oSdoDAFOMczOj1YF0T6KJE5hyWc3iQCl0OPrNREGllYrdVnHjWEKNMv2ASB
         av/Gzkw6L3A96MgGt7V58yeP4+F309NIP38W3e3z/B/guFaLg2k7rGmF2q6tpI5pDbJw
         xBLGz+VzRlyv7E4/t59g0lOU4f/cRO8IWbB2wicxPGFYA1myeFgvYP1AyR9IzvTJOt9R
         L9Vg==
X-Gm-Message-State: AOJu0YwhK9013FW7VGDoqkn63MgzCBfEBgqFyABADNs3EmtLDB1ojTnI
	XG2Zy05roHKaAVi8UY8mvcOJKoyLXSYExsMtLHI8kAHJiBkJnfy2rDCDZvsF8bNrCqdQ1gtOn5m
	mqhoIa/Qs6pCB7hJCbdQa3rmaeYsnZHBh1kGlIekYICC1FAcGjqSBsw3jlcyCJxCGRS62ZGVeHE
	Q+GQ==
X-Gm-Gg: AeBDiesCSMgP78QHuWvPqkRN5aaw+mwl3WONVoCpYo+BdaS97uPWap4ItmLn5xgRiAo
	/K2Cssdrk0OjRWB26hsUH/j6hikc3V63OpvjQ4gt3Iim/c1i9ACzQeYB9LSUwXrs723zkvbqt/I
	vHcclzfk/UUU4OX9FCiyUDFySt5JV+6HROFf2pFFCjGGZtJsko23Fzfj7/36Ygu9m0yChDz5euw
	KoCgfCIt4ouMhVycpUyl7laIVCAF59aBOb1DafRyMOcKeYzkj3c6RrC+bYPAeOpFxuK24JbJjcD
	3tJITcZbkJgeNTTiPCAO2wK7d1T3OW2FWU8nDl9FW4p+hVy9QmlOIgPkiYnsNCFWHzRmR9zjRD1
	NFgz9UH7wQOIrX3Iph+AfmdS+qTBhAgT7arp7kxGMrZXPf+yAGu+2GjW9yeF9cjXvGSC2orwX
X-Received: by 2002:a17:903:1a83:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2b5f9f36f53mr169205415ad.20.1776752157515;
        Mon, 20 Apr 2026 23:15:57 -0700 (PDT)
X-Received: by 2002:a17:903:1a83:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2b5f9f36f53mr169205275ad.20.1776752157053;
        Mon, 20 Apr 2026 23:15:57 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff390sm121268505ad.9.2026.04.20.23.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 23:15:56 -0700 (PDT)
Message-ID: <752f38a0-738b-4e89-8e12-b38f8d207af3@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 11:45:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add channel 177 to the 5 GHz
 channel list
To: Yingying Tang <yintang@qti.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yingying.tang@oss.qualcomm.com
References: <20260415063857.2462256-1-yintang@qti.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260415063857.2462256-1-yintang@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oXiU2uQlYaczwfZpAnslmvHVycsSqGB1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA1OCBTYWx0ZWRfX+2a/RvXj1AXQ
 3mWKY0kcM89G5hymoMRsI09lVAiZFqr8WvOllBh0TzAnXkBXDIft90kcJjz1P2fXP7dh2XpUQWf
 TzI74CodWIeW84+xk1r0vckZRj6ldnBYO59S6y4feRPD6KCDGd1PhzqfmOrRqow9AkeSs0ybQHm
 mHuF69Bump+kYFOxf+Wntm340wJxAkHKm3I7IaDXc14qDdd6headAkUELzMW0Yk2nAVawIU19Lg
 riPz32baE4veO+r3KC79J3RPfvga4F6CsnDE4jiVe9zGZw6REaDswfiJkNHk3PBXhBnDPyCXNzk
 f1AOadFMu3D1iLZLHh2Cggs+B7bmfvpp3/odTmF3IohGS2CC/k/UQYiawJhd3kqkzCHQ3RSS418
 O5lRgN0FEE4V5bSWwnNcejucMlHGvXuUTV0ZNKkM11o6X/P2HMb8l1+bLEvMGCWyYYmzHMd3Uw5
 39ySaM9SaX86zvFTTMA==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e7161e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dGk-cjk1AREVnTvJvk0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: oXiU2uQlYaczwfZpAnslmvHVycsSqGB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210058
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35117-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3890C436D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/2026 12:08 PM, Yingying Tang wrote:
> From: Yingying Tang <yingying.tang@oss.qualcomm.com>
> 
> Add support for 5 GHz channel 177 with a center frequency of 5885 MHz and
> Operating Class 125 per IEEE Std 802.11-2024 Table E-4.
> 
> Channels 169, 173, and 177 are in the 5.9 GHz band and must be disabled
> when 5.9 GHz service bit is not supported. The 5.9 GHz band is only permitted
> for WLAN operation under FCC regulations.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

