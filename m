Return-Path: <linux-wireless+bounces-19565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D5A4891A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 20:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F9189004B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5051C07E6;
	Thu, 27 Feb 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7fsC86b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056E270054
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684944; cv=none; b=H1nIqknPjdaNUmE8XbegCH5Gro9sDgiMHAFIpuE9ILrpAYY/VzjeElS/hz1HHXvn5TV1YAIAp4/PYT4i7HgRhdQOhfCkv2fAyg3fLZDLyHZGZE7KC+b0oBR8E8/d03grmTovjgnvgnhuxucGMhwuBWwhcvkmTf1ZOnQGMHwm9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684944; c=relaxed/simple;
	bh=YmWMOxkwcOqUOJmLwm/JmBPzFinJ99C3Njd0mLJmcWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrfJoyrjzk8oSRyKM8dg1dBHv+k4dG+e5m2iLW/I9l+FMKwHf2WwVk8ec8zg1r3dbrD5BHIH7ZVQIZDrSC76PKCrWXSgF5lEVeRfs2wD/AcXukZJMaNBBhXPTzHzJz8B6lNpva3jPay8pDAK/j/6uodGIvnoAzz8PaXpwoKhUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7fsC86b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R9kwD7017217
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 19:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nIdrYWNQba7sYavgsAMvk6IcAs+0IphjbLu8WqnORIo=; b=d7fsC86b/lJg6eKi
	T6JSwZDfbZkJ7fBYLkSzhs5cFU24q9snOBRM8zZyny/iSUn1zLJ30dF8VFZ8WtAW
	tn5G4PeG53/LBu9U84bzG6lHQxLIU6IjMm6bhoOLZ6yH2f6+t/p8YNwXMqEpw5x6
	iiBmap7OHJJ+5sxFThPoqZO+9DNTZfGgeZHjqDyWt52fGCKxog8ZwqbkJIopYiLC
	jHbijbgnuAatZgle6dl9YxaLxzdmHXA9rALkx2B9wk5dXeiLJEKjxNk3pdw5c8NK
	BsxOouSHyQgyA7QGNzlqni56lzQyptGunzS58ifppcRK8zjJnx8uJ6AJnIKQyvEk
	QfJOag==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452nqkhpxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 19:35:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso4197465a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 11:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684940; x=1741289740;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIdrYWNQba7sYavgsAMvk6IcAs+0IphjbLu8WqnORIo=;
        b=wLg6g3pJ8m+KsNjtHpOIeaMh0IyQlLvcLfft7Al4KA6bsnFmtJ3v9xO5C1TLFW2M9u
         lPu8Gjc4bnDa3bzVMYXYlL6JCtszrbh8u8ulZnx68QBD9boDLos0wm8cDA0ghxumovW7
         av+f+IZxS5xTRzP447gQXnu9ZBcF6bbh5Zw+o8gJYZ812rk/XnBdHHyL5S7qFKt/GQR8
         3bc9BawikzuubZ98N2Axt1pt32pB2w0UtNrs7vtBVES2LjiXJ3m+K1a9PcGK1Kh+hnAn
         EO8xe9rRy2+B5+SbmUWzW+sPmFXUwVm+UjRwgCz5Djb4t2P8rZ+ZmKx2E7SSssmZ84ym
         6Zuw==
X-Gm-Message-State: AOJu0YybwYsMUx5jVO9Y0FOsf/U7o5T0Fd0qCN35u6AdYIDbN4f3uSGm
	xD7JaUtKHZZmmN84UC8ZtJTEbjnZDWUgTxZCv10+Yj9mkfie76gOja8tiFrZ4bmDKZ8I/K1A+HR
	sEc/eQtAeTm7Q3VuD02Cn5HLE4IWrwOjOlD6i1cJYDBbcH9NMG3cn63dhjvhw/I2dLyNUTCEXsA
	==
X-Gm-Gg: ASbGnctGQyawfaYtWy4Ud49VzTIKYL50eS4pcytJZM1/NFqqc6kaCvGD6nPu5LTVCdd
	PUK7I7gbXhMepNbarNjDW1xIrnVd8ecCtcCVnY5zIo+c+GcT5SQWRyxIIN03rt1wZazBW6MU97w
	vYv85U+FLdBXwayu8NGfH4xCq8BKhH51fqJGxB0qQzGYGj+pxJRE3HZGnPy1MXHg/atMWVMfZV0
	AfoqX+XI0H1xYM0YEPJVY9se8CFIGfeKJl2D65iF0/JkZO+4Tz0lZxnPfe4WzHAz3g4IAv5vh9r
	yadLQQvxKcKyUh4aqxuilv4gahJBMwAFRv19DTfNmbt332pQKUXjBemp45cEv5Ls0QMWwyWkD0I
	cccuDTs4j
X-Received: by 2002:a17:90b:4990:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2febabedb80mr808671a91.27.1740684940282;
        Thu, 27 Feb 2025 11:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3NzBMPbwQFLBIWu63EVtr1wldOAZRJN12Z4hsFBjmzUFCNZvyQUZB2a0S4+5lsGUNbGo71A==
X-Received: by 2002:a17:90b:4990:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2febabedb80mr808512a91.27.1740684938660;
        Thu, 27 Feb 2025 11:35:38 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea676bf4esm2078772a91.18.2025.02.27.11.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 11:35:38 -0800 (PST)
Message-ID: <8bccb677-de56-475a-9b27-ccd55bcaebc5@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 11:35:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] wifi: mac80211/ath12k: add support to fill link
 statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sarika Sharma
 <quic_sarishar@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250227045824.91480-1-quic_sarishar@quicinc.com>
 <bac3fdc3bd39e45150e5b7d60be01b5d732a04bf.camel@sipsolutions.net>
 <df26e3aeb3724d969f444eab65d8c872@realtek.com>
 <900f042d03d34385fa3507610ae291a36ca4885b.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <900f042d03d34385fa3507610ae291a36ca4885b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8zhrFb_b9c6oxAF_o__r6ePkQhHqE7Vt
X-Proofpoint-GUID: 8zhrFb_b9c6oxAF_o__r6ePkQhHqE7Vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=632 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270145

On 2/27/2025 1:32 AM, Johannes Berg wrote:
> On Thu, 2025-02-27 at 09:30 +0000, Ping-Ke Shih wrote:
>>
>> I have encountered structural (not functional) dependency problem too. 
>> Could you share how I can tell NIPA the dependency between two patchset?
>>
> 
> I don't think you can at all, at this point.

So it doesn't support the mechanism 'b4' can handle, namely having a
base-commit: tag along with one or more prerequisite-patch-id: tags?

(note this series was not created with b4 so it doesn't have those tags, but
just curious if it had been created with b4, if the patches could have been
applied)

