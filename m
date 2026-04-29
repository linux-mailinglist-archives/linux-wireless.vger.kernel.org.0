Return-Path: <linux-wireless+bounces-35571-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPhjC0ez8WmwjgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35571-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:29:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 241DF49075C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6A0E3016911
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051C3A4F54;
	Wed, 29 Apr 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ljn809wL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QukfSswP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0FD3A3836
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447440; cv=none; b=MVowzfNDvi4gpT4YWgdBDIhIXPY2wlI1pJ9AtdxY4876KRwyYVt4qDVcxE3ZNW2DCou7rjZBTtgBYIqlCkDrnZGkOWkdyg4Mmca8vT+I0ZoM/eSDNu0PLEjFD1GTFWdhS3WHtGnV8VkHvHHFspesRw3YzYftASRRlrxf6CoU3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447440; c=relaxed/simple;
	bh=4kMjEWgH0O6MSc6+Ivs0TbjE3sJ/FOasTo+8HTfQQDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeL8WSnam8ndLPkg1dokhUs5iBrvVNt/CF63eEe+tKV7kl5wdL3cZrNOHXQtFHdVzvP2mV1ZSBbKcwdW7GfNIUImj7tuLeItKTBySpsmTwzednN3M2x1FS/TtHTrRWUwyCMn1ILqyp6pNaDf6pPoPNO3Dp2hmBM9Lbd0uKkbDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ljn809wL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QukfSswP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T25Ebl3705162
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UvKCNndBBkYUc0nxuFbkUYiO0WRhlXQti+/4X6+udB0=; b=Ljn809wLwDtH+Jki
	+Z70R9qKW+U6dKJhlu64OADISW1Iw0ExYW0z0WuLKYXgoIcn9l58xSh6Z3EaRJKn
	+opWAOajEVw0bx3Qs/mKFyy0yWazAua7CHkzC9CCsJCwJDW/niKrzLCPu4J3/xEJ
	lH1Zx6hrAOLLQhYJpu+9NiZJ5/DFjHNX8bLEm6jP+fVceniOZKN4mSdV2RUzIY42
	zx8ps02linokJCndkAeEXE6mGqz5Ca4OWKSjwhsZ1oJmRWttjKwNfRQrPPjyDCPW
	Ayl49f5E3CsHgs/z6UCGMZkyfnZ2PdI1sbkSYzFXEp/FoEedNs3Y1SHhG6D7hVrr
	IqJyzw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttxhc6rh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:23:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35e5791871fso16520867a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777447435; x=1778052235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvKCNndBBkYUc0nxuFbkUYiO0WRhlXQti+/4X6+udB0=;
        b=QukfSswP3c1VcFt8QCAnprFaSFgRtDmblOTmCVOYHFZg8lAwrx94OdoGjRBkZln9WD
         FNWD9k5cEvostEfwjo22lk6VypuW8+evWecBO8tkvvPXw+VPPR1Vg3d4LUxQ0bWBSxIb
         VkuvrpBNYt+QadFNTL9ERxtPOUFfaLCeLGLtld6kxUVws/XSwVkSZrav0ikD7A/GvMS1
         vs9A1xSl0wIj6JezB8Wyi4n79yhvGu+sOx2x454G7Dr4lRY5Dh+znwXh5wIxYOhzC1Bh
         1f4fzWV0BuqUVYHo5/RXITiOrqgqgYP9uqZUM9rjzTv+segFt8O+xmU1GBrT+lLKn53Y
         GBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777447435; x=1778052235;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvKCNndBBkYUc0nxuFbkUYiO0WRhlXQti+/4X6+udB0=;
        b=BJrHFlG0XZlH8YWon++X5xywByqILHebC825oaqbkaU7rzTOe7I3W8LxnVfZckTAyW
         odopaZobE83zpWNlJlL6/Xjw3e5IGoo9Tc0b7hCeJsmBFOc0wqB3i6SEshVlxPkAk0Nn
         yLXIbgYyQQ48wL9vRYWqOl76KrNagK1TYWKAAD4iiJ/Var6PRGK44f1UX8aquKqJu2mP
         KHy/83Bmxka4pw0HyxypMNEMfykl7FglePDpAva4EUvN4nfHgbJR1IWL4QRcWgwWYZq6
         iCC4DcbnSv5fNeNqGVZy5RVFSo2QIDRSZZWyyse9dPBZGUgamM/dNN2m/gTFcJPe8BfP
         T/6A==
X-Forwarded-Encrypted: i=1; AFNElJ/I7Xo5i+lAph7CUfFUG4DCDfvKXXxpTzc6zdibyblVKmiqf11kzlBkC5RKRQmeuGbXH3cWUvJoZLCX/Dfrog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSi23aUUkmSPywRBy1YuXoN4K+Z37QGELxCJmIT86FoFD4YGO
	WcuUK52rmGY+pOEptRD86VyDQnP3rdY202AEHBasJBs7ncOXmNvZxAQh4XZWDzNK/x7bSWzUVM7
	jFl2Vb63dI5cQpj0s19FxtdjRiIcy7erHqZExm+vK/P97EJ9kdvSFFQf90Fq8fp1d+/Xq3g==
X-Gm-Gg: AeBDievfvTKQjcP8LW13C/G4w7K+0AJ6iSOZTAV742BiGYjnBGnFxLhTkuiDb7yCdcH
	bxWrw8pEHmM8CUPwgRyf/ufkb77zfMX0RXWt1aE+eH4owyoobMZBr4qiBrZtbOW1z6PTyaley2v
	BCJbehYU60f/Eqx7imFerR1n8w5G+aU0QHXPEHK3Y/HF/3lAMUHynYHJv/7hk9ojVKT2zoXIvJ4
	TBoI47GRpiaTRKPEn5wb1xBuL4p2VHTjbHRjaRCa4FTx3tSismjTTNB0qO2cmuZKu/q3I2K9dZj
	6qQlPkq+h3fgzuiArs/YhndVtJZR/lRUKoAtBS6EvszK3XBsYOMFTkIcQThhmoQ85wOVzHZVH/B
	N2A/0ynMWQE0FS4gv6lHM3a0NDrRKdwZtREHNrfuuPG58O/Wlu1jf0RgfAe/w86mLkOnW/Q/9Po
	28n1QTXIoOOLesT/ypY+8PZEtlytzqUA==
X-Received: by 2002:a17:90b:3fc5:b0:364:74c1:53b7 with SMTP id 98e67ed59e1d1-364a0adec05mr2719576a91.2.1777447435147;
        Wed, 29 Apr 2026 00:23:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc5:b0:364:74c1:53b7 with SMTP id 98e67ed59e1d1-364a0adec05mr2719563a91.2.1777447434764;
        Wed, 29 Apr 2026 00:23:54 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a4180219sm1292125a91.5.2026.04.29.00.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:23:54 -0700 (PDT)
Message-ID: <0ae92497-91b7-4eb9-951a-dcd2258f538f@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:23:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <c0d2b6df-4109-4c93-b229-7eb2d3fca6a7@oss.qualcomm.com>
 <20260429051414.6625-1-jtornosm@redhat.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429051414.6625-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA3MiBTYWx0ZWRfX0ywuUeak5co0
 gwOf10CP5mBeZLdVRmX3tNQxl35Jr1Tt1O12aJCLfKaybWMJv6qK36mb4aToRJL1MdmiWkb4N6c
 47RlI42IaWqNKs6JaK7FaY6BjyVhwF4RxKT9eTOLo40vOMUtd59kAaEtahaFnLo9CjwDF6aWJO0
 +vpnywjOwLJYCKPTvzj2m3tfMHv34Lxsc3wWP617qFR/ARqzedh0eyrzZGf1UwZEgG/u/5PqVav
 sYWq8g/7Z0dkqdzjN85/jbHbz8njG5UlSGeB0vA122AGRqM1z8rUM7shpkZ+oA99z034799szY0
 Yl91Ne0l35VkBrkOcOSYKbhIa8a2tceQz4zFpOAlm53pG+ktxynAJoaCE3mg2hDr4Eggmo2aMaK
 4F+cHgFR9ngxA2HgUpQ7qPhbsFvNskzrAz6tBPpu9f/B/O9e7y8Tei+5uJl0LKGp+DzGSjtm/g0
 4Eifl1nIde1t28Rydww==
X-Authority-Analysis: v=2.4 cv=Uu5T8ewB c=1 sm=1 tr=0 ts=69f1b20c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=hnrE4znNAVy8RLhoGhIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: AAfWAVGYQDRaHqfoCsAlvA8t03psL7Yc
X-Proofpoint-GUID: AAfWAVGYQDRaHqfoCsAlvA8t03psL7Yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290072
X-Rspamd-Queue-Id: 241DF49075C
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-35571-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/29/2026 1:14 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Baochen,
> 
> As I try to comment in the commit description, the warning is not at
> the intialization, but comes up when the device is unbinded after a
> problem at the initialization stage, because due to the problem the
> buffers were released (probe). Later after the problem, if the unbinding
> is commanded the buffers are released again.
> Setting to NUll after releasing avoids the double free.
> 

OK, seems the first release happens during the error handling path of
ath11k_core_qmi_firmware_ready().

> The easiest way to reproduce it is to run in a VM the default upstream
> kernel (that is always failing on VMs) and just unbind the device
> (ath11k_pci).
> 
> The same problem was fixed by me for ath12k driver here ca68ce0d9f4b
> ("wifi: ath12k: fix warning when unbinding"), and I have seen the same problem
> is also happening for ath11k driver.
> 
> Thanks
> 
> Best regards
> José Ignacio
> 


