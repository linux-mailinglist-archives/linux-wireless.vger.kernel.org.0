Return-Path: <linux-wireless+bounces-24776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C50AF5FCD
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266AE1673DD
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9A92DCF5D;
	Wed,  2 Jul 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="olvr3A/E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C32F50B7
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476831; cv=none; b=hfqX/K5YXx9k/HlaRRCZc6LCtPuNbdbZ46thQxxN3XRUZ11LQ8qF6k3/syNib3Yaw5q4G7sj1zyayps8SFFnINoh+hbb9/9PZaobH/h3T01iXaDaeXeyt0PAkRlHAFURO+BaSnjTp0ESsar1aOeLQUFB9U0si4Nh7XecZYj9ukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476831; c=relaxed/simple;
	bh=xpFChYhbf1Tz8XRqqKA73WY8qMLNgVgZHhNtTXqDctk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsmowTZ4/8BIlGH5UplI9ukvVPLzdSyAiIzCCD1f/PM9I6+gLHATaf1SmXz2Lwqe6sHbUjTLurcbWdcPm71HjodRuwnVFQsKD8x2JQ8ULubTtxNWcOwFQ4x8fFElPJ+TIltSrNobK0tranwknDdbfgWt9u+QJkNiK42wMo7r3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=olvr3A/E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BHbgV010383
	for <linux-wireless@vger.kernel.org>; Wed, 2 Jul 2025 17:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VI49kppIRqRZr+dvbW5ZCHo0edGQ+Ig9cQS0B1KK9AU=; b=olvr3A/EVxjmc2OG
	zW3OqcqFV8PTrWacG9LzKzgw5GU29osPy+mQE0XnFIbup7o5MY53mEebRr3lXkOt
	Y4kRF2cqajljZyib6GY12oF+Zdwv+GxmXX44K3IZoumKh0E/21i7r4PrZ0CbVIzw
	azvzPHWTm07Z6MlvHADXb2fYpgDfOuvPtM8C7e90wypoRmQbMrTCbEtcYoVvU25e
	e+AhbLPpdb0i7zyyFMdjmWLlUAKogIsTtkpYzDYhXN3SKgnVw1yiak9yObaIwUJQ
	4JpaNOtYd7WOvZMtowYQrEJMq3YsGXbKTomD0XGh7Q6anLGNoOkA2CXyJzcxiABS
	8RqKcw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mw30agqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 17:20:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2365ab89b52so54953095ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 10:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476828; x=1752081628;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI49kppIRqRZr+dvbW5ZCHo0edGQ+Ig9cQS0B1KK9AU=;
        b=PnwN9vSLoQODmoEpbYSyYMVn0oUpgz+unk8+DBb1g9BAqIJijCAbBSxjmBG/DzSccE
         KNqKFgUd3a0gEYwopQpYic/u58h1OkqZ3TNHk55pbQ0ClLyn4A1ek5YCxcplYiuqzoLJ
         ocsL2Tw11A8qH57cyGp+9tgC3zmkig6wyXdVPWbK/vohXQcNLTm+XNSdxkC7V+PuU26D
         1MB6CaNJmeYnO++//cRRlJkQuD2DLeaN/bX4cWpDx0Xu2crHSXMfHj9gWjurpqvSmJEi
         3CGVy2ih0B7biBjDXMRhrXjp4Hg7Uo2ChqQykqy1Pc7Pp5Xj7lVjUiWq+IpkZcFYJ1WU
         TZgQ==
X-Gm-Message-State: AOJu0Yz12eYz/PPZDE8+yfX5ShhvfRjoMKg1mzOTYBjgTZEy2+yBN7hv
	8vSkNKNZvoVpHGJnPuUApQBvwNjP18cl/DHssT6MJjMEmnx8wkkXGFohQdbV6hBdP+aFjZJUD1A
	nikoXpnsh5qyNI454UTlprUp0TB1rbHpuKRClcTvWLc1wuqQ9sJun1WK5dV3qHG2gGb/AQN+IGB
	U0VA==
X-Gm-Gg: ASbGncsZx5v0emSO6fkJHL/hDBav2/aY9SZ1qi87cGjZhnTR84tSnQDfV3pMYIcgyrX
	DOIcUI9UjRJAHJa0x4fIYvc22VdFG9pTq4OXxluCmz8FiF2/fkQdwvNsbarN4k7HiLOC1DR9gw3
	swXHz7ldAfy+foUAdH21e1Yd4l6eNy5aVe/DlCLMIqyF9agFcIPlkVV+uq2mI95wy2Fqf3j2qpT
	zBUYJU/wEayZ0GyWQ1ybEHSbd/MWuYlL7wjWiEEg4yt4KeELDAfKRf8YfSYek1FkUi5J6QVBRq9
	VHCIMiu729R85wgIFOokJZxcuW4feWk3jhn4HjkxhYRp35N/A5GtPXCQsVCrWvvVFXFOvsHyjvv
	8O3RsbVwfOnCZka0=
X-Received: by 2002:a17:902:e94e:b0:234:e7bb:963b with SMTP id d9443c01a7336-23c797a7715mr2324675ad.16.1751476827859;
        Wed, 02 Jul 2025 10:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUFt0L4x9kkQvEwrvIu6HUuQrl1Cjo9dkVIfU4E547RBhSvWWwXLfC+6DwPDWJIKxpjU/dAw==
X-Received: by 2002:a17:902:e94e:b0:234:e7bb:963b with SMTP id d9443c01a7336-23c797a7715mr2324375ad.16.1751476827379;
        Wed, 02 Jul 2025 10:20:27 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f21fesm135663035ad.73.2025.07.02.10.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 10:20:27 -0700 (PDT)
Message-ID: <fc58393d-3f5f-4702-8436-ec117e611245@oss.qualcomm.com>
Date: Wed, 2 Jul 2025 10:20:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: cfg80211: Nullify freed pointers in
 cfg80211_sinfo_release_content()
To: Johannes Berg <johannes@sipsolutions.net>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com
References: <20250702162531.2705566-1-quic_sarishar@quicinc.com>
 <c7d5adbc4fe45c0bc55567f9d1b228d169dd9097.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c7d5adbc4fe45c0bc55567f9d1b228d169dd9097.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CY4I5Krl c=1 sm=1 tr=0 ts=68656a5d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VNoSgP8og5j-9tmq6ZcA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Iw3Naa6Zgf0pnB21IAQ04VmX5jf9TLej
X-Proofpoint-GUID: Iw3Naa6Zgf0pnB21IAQ04VmX5jf9TLej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MiBTYWx0ZWRfX7smzw0tEftCW
 oE4aY9VG53b4nYJB8eM3kGQykKFlJKfdxpMFZZ6Ek+lMrR3aRUT4Tpe+QGz7eZtz/H+H+6g0QCk
 kx5DeCnqGqS4dPhMzOOCXSigwuATWL0RuD69l0bz/kr8AcLcuX2lnLNH6ioi0wn2GUo58D06gsa
 LJB3L55JO1/dLw6U+8QV46Dvpv1O9mjThTMipI361iDKFf5ZeUKAksQewq29QZOGv/ZS+8WcfHg
 55p+5g+QdS6gUMhBrdpF5m5rjgFPsg6tMYCZvj1BICOavhbASjFDvkTQh2AHkybMaX1LcVSXdef
 nXWYwMNX6rhIzIVQ1+Fe5OdK0n6ScDDZBPIuyoPnuw1YdCJwgMq8ZC7W25r4Iog1M84Juso4Wr/
 KRSB0ubG7SBWqLod/7ylDrjaMSVVFYeOuh6p4E0tjjYHO0xvtU3FZzR3xLI1f/5y5OL7QtMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=746 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020142

On 7/2/2025 9:41 AM, Johannes Berg wrote:
> On Wed, 2025-07-02 at 21:55 +0530, Sarika Sharma wrote:
>> Currently, cfg80211_sinfo_release_content() frees dynamically
>> allocated memory but does not reset the associated pointers.
>> This results in double free issues in nl80211_dump_station(),
>> where both link_sinfo and link_sinfo->pertid are released twice,
>> once after the send_station() call and again in the error handling path.
>>
>> Hence, to fix accidental dereferencing of dangling pointers, explicitly
>> set the freed pointers to NULL.
>>
> 
> Do we have to fix it this way? It feels like perhaps it should rather be
> fixed by only having one call to cfg80211_sinfo_release_content() in
> each path.

Internally Sarika had a 2-patch series where the first patch attempts to make
sure cfg80211_sinfo_release_content() is only called when needed. However that
required either separating out the error cases into separate gotos or calling
cfg80211_sinfo_release_content() at each error point, and I felt that
unnecessarily made the code less readable & maintainable, especially given
that the 2nd patch (which is the one she posted) addresses the underlying
problem (and is similar to the approach Dan posted where he zeroes sinfo at
the end of cfg80211_sinfo_release_content()).

In my mind this is no different than the numerous places where we blindly call
kfree() with a pointer that may or may not be NULL.

But if you want the other patch as well, we can continue our internal review
of it.

/jeff

