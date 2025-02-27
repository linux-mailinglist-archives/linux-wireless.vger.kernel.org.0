Return-Path: <linux-wireless+bounces-19514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97DA470CB
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 02:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F1816CB38
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 01:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992958C11;
	Thu, 27 Feb 2025 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9zpBYwH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D78BEC
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619075; cv=none; b=HRhzfVC/eKGM+Xvi5kaMrCn6rjigkLNU300UqRJcz0BYWzKJOWLcDeeOLrC4GeQIH5AOrB6mtr8pBMkiyaq0958uyv9/ijhIpWCm0QlvxmkRI+UhLc7RbTnGhVICiZvOZ372F1ryVQOORXo0Rl3Q8joXP2rL/TshrCCOl049UOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619075; c=relaxed/simple;
	bh=00DMkVoL/zaa+T6gxX4+M8N3d7w5TAjl1JND7vfrPSg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RsJIeeGjCL97pThUOzwi83ALntjJaOS7j9DS2TXr9aKwqoH9WdRbkPTcfxumoGoWDop3m/d3qxlWXALAU6gU+Q7sNaLHfR5ScMoDwzm3GReLm6rv2E029hY370mZ0wIe0qwiXfmC4+vgYqLJ8eRQ79OhfgdgW2E/BK0x8XZJV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9zpBYwH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKF2cr000925
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 01:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00DMkVoL/zaa+T6gxX4+M8N3d7w5TAjl1JND7vfrPSg=; b=G9zpBYwH/8rK5Wue
	qjIahKs5MGc/HXVvh2RkypspnhJj3C2YcJ9gPW89CHHBQT1yvtwKR1XU/dqoCapi
	sL638gciJumyTVKO7lz3kx4w57R1EEK1GoXblsgmrOZ2Rl79yKyrULHxYeSzV7WM
	N77GSeJhZlM61pqSaHSWezB2mKQWZfocKdZOjTkIKpcK2QkjYm5MBKJcjkCKJ0VB
	WJWjM4YwHkuwefamN0ShP7W0NTxH9WAe0qi352YLnqXrWs/9nVm6vFO+u9bSFyP2
	bNO0hMh7E8VOuBlE/aMHzvPauiTTxj6AdFAMSWiO7iYFH3ywuizBo8w/A6HB1lMj
	4zqBTQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451pu9buf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 01:17:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so995530a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 17:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619072; x=1741223872;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00DMkVoL/zaa+T6gxX4+M8N3d7w5TAjl1JND7vfrPSg=;
        b=TpTEU0SH81Jj2dIIqbaas+e6ZoTrLdLYihvfO2Jcojo2VK/66d0Rb77LNz5uyRrNP3
         CpdIvTkgJJZ2fwi/y1Q3brWLzoI+XUCdcXApdpIMgvKgjVV4z2tacPRkIY+mhwjShKlw
         0K3fRh4teRg045IyT7ru//HJ+s8Mfh+1OIkItoUwh8L4wvir6yk42y+G5evgedgO7cfa
         vQKdFV/1j9PuwoL7Bwpk2pevglSP6z7Kgmo4103U6TOhj2zJaY2l4HZc6dAgq49fyQt3
         JD3DjMGfQD9XIP3mn4bX1PXNoDYE8XPIk5d6ZGYI4Z7HOqQCRv36iAAFmsyq5qdoe66f
         TslQ==
X-Gm-Message-State: AOJu0Yz5e24XDBHU93zBwZ1oAgAXSPwVQ3gPivCEOvsxxgGBJ+wy2FRX
	JkzDsSPES3Fyj0xx4F8ZPBMuQMISWYfBol+TyO4czVPaf0xejFSv/Rt88xUnX2bs3wECsYsQSdN
	8kEKh0fXHHN5Jldy8IJdcFrgpLZxPA3Xu4SgleD/bdCRgo4+8sQVFYqWqJtc+zyJ2nbpDQPLomQ
	==
X-Gm-Gg: ASbGnctHrX5VV24HjwtJ5Wcc9CW/+VV++HPdK+p8P6Y5JU08hiqSpUvvyOe9BdDHSDg
	IRkSSik315ttLbbJhG9sfyelMkuJDdgB8YnBwWpsPtm+gfiYNXF84qXS0wQHubUk9gNyAnGbowX
	6jKyjbSMy2Lrh3ZG8cc+ANVucLlXhmt4N7Fh5umoeKs3x4l0YlmSK5Gaxe5jFe1L5qd3YoDn3Oy
	dJ9zTo/qMMt0ptQHQRnYqdWz2WeWGX5ajrPza/qSKj+WTLkbzAOQm0U0TBrmWITdsCOH+uYWCnL
	f1nvlvBr+0DrA3G8Eo/mY6g2i+C1JqVnPIBCqlCergSBb0Ttqzotnri8MhPzAT/J5OjC
X-Received: by 2002:a05:6a21:348b:b0:1ee:e701:1fab with SMTP id adf61e73a8af0-1f0fc99be85mr18728224637.36.1740619071910;
        Wed, 26 Feb 2025 17:17:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfAZRBm2/zjMdUfeGvLOYhxNQUXaOfLGN/f5gYTPEetN9LWWkMCB1nzHyM2DEe85bDb1/3Lg==
X-Received: by 2002:a05:6a21:348b:b0:1ee:e701:1fab with SMTP id adf61e73a8af0-1f0fc99be85mr18728188637.36.1740619071553;
        Wed, 26 Feb 2025 17:17:51 -0800 (PST)
Received: from [10.227.106.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe51432sm259750b3a.70.2025.02.26.17.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 17:17:51 -0800 (PST)
Message-ID: <b3ca11a1-2923-45c6-ba42-be916c37d664@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 17:17:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: Re: [PATCH v2] wifi: mac80211: Add support for management frames
 stats
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250211202518.126305-1-muna.sinada@oss.qualcomm.com>
 <0aa5d6e8667350c7a3d80af4ce3956cad7096fba.camel@sipsolutions.net>
Content-Language: en-GB
In-Reply-To: <0aa5d6e8667350c7a3d80af4ce3956cad7096fba.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kZIprr3OWrwgsM58GNsFe4sQgY-iL-oV
X-Proofpoint-ORIG-GUID: kZIprr3OWrwgsM58GNsFe4sQgY-iL-oV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=950 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270009

On 2/26/2025 6:41 AM, Johannes Berg wrote:
> A very, very long time ago, when a lot of statistics were being added
> (and required by Android?) I suggested that perhaps we should add way to
> run BPF programs on incoming frames to keep track of these things
> instead of having counters across the code for all kinds of things all
> the time. I suspect that in the time since that has become much simpler,
> since now BPF programs can be attached to tracepoints and adding a
> tracepoint or a few could be very easily done.
> In this case that'd really only require a TX and TX status tracepoint,
> where the latter is getting the 'acked' indication, so that's basically
> trace point definition + 2 lines of code.
>
> I wonder what you think about that. All of these counters add a pretty
> large permanent memory (2 KiB here) and code cost, and having them in
> debugfs _only_ can also be annoying for certain use cases.
>
> johannes
I agree with the points opposing the use of only debugfs.
Let me familiarize myself with BPF programs and get back to you
with my input on your recommendation.

I was wondering is there an existing feature/statistics that is a BPF
program commonly used in wireless you would recommend to use as
reference?

Muna

