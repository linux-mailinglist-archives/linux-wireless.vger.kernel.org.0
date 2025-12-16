Return-Path: <linux-wireless+bounces-29823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CA1CC4D2B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B745D3051335
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667D78F2B;
	Tue, 16 Dec 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrOo8Ltt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uot6IXD1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC59463
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908745; cv=none; b=HGiGNj0SpCRUbzBSfSH8jtrsU6UBtPLZxn5hWJ1Vupelm/V/JkWwpwBXlwO0ra+hornaqnVnUGkVgApFtCd5C2VpGX/DpxtDCUtwSAr3QWB94ByO6gQKKiWsu4vOjsXcG+t7cX+Ue30gAR95qAWRvXPPxVGRHSoDh1cQcsA0E3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908745; c=relaxed/simple;
	bh=vUAnSrga3lRROn25RpkkRSGVyGMb/5OXQi6iSDuReBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y6XJe2Ev3UHAUXJ9D9Wi6MZ3vSv45AjGdipyTJYh8YT+hNzYhaS8K3gcNESWYQIgOpLWxHUSLIQmUy4SiOOx+lsZn8GO6v3l/6cB+70mfXd8GqqCVx05gcsN90awqr45oeVlLRYCna+ZxmhxuZd2fd8uDxGzW7v6sWxlSsfUBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrOo8Ltt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uot6IXD1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGGjJC73494970
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 18:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qjl1t3bL28kARim0F/3eBMYNSvdLyTJtTowdvd44Jdo=; b=UrOo8LttVSlewhs2
	h0qQW5ABGN0fYBbXSh1AfE7gBabgRGyQsVoTVK55Lz/FJwdr1hynP1HcdxNWEs1u
	BH7t+jhVgNxATSyWuP+ZAahAUFicvu6lxdeQVbCEx5EGBp85MYKMqyMvj5Kf7tB3
	qTbKRmAe4L8GjJznQYheMwza7tooCuSEWSsYnEtpjw/vwQdGa2r6vYZo0ee484Zk
	3cVDKJmnNOvdQQe3nfsVkC9wTacAi9SnuPbJccWAvIRVhlmIjfEE1G/0xtobl5YR
	x+h5AoveO8EQYMzVZj5PJwaPXrKocatenuqHtL02rziT05u2NSjRmiB76dq3Ue87
	vmcUxw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3b7d89tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 18:12:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f1f79d6afso51551815ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 10:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765908742; x=1766513542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qjl1t3bL28kARim0F/3eBMYNSvdLyTJtTowdvd44Jdo=;
        b=Uot6IXD1JaOY8aCRW9uv5KByov/cGevfYDBFEZyxuUIzjduJknkeWlDQ0v76niKLpw
         ND68UO2cHZduSfuIXJSYuAVxTVU4LfwNRwochvuynKbqH+gyyG7F4a7vJcp4jWf51AK1
         U1zqsYvkxqd0b3f3uXoYUy+z1YhAtPhyAvXZXo6TwHUXIS7uSVPW0C5BdD6F3uWvqpOK
         Ik1v1kIW+/Jiqgbtz7GrM0fpOBDcwZRFSGpDB31/wKbe64GknG5g714b8ZEZ51yLjCSf
         sp2kgbtry7zHUxBl8N+XdAbQX1muEQ0ckeDvlJMQZFdMizpRAUowtDOGl9gty3uBoKYJ
         00Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765908742; x=1766513542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qjl1t3bL28kARim0F/3eBMYNSvdLyTJtTowdvd44Jdo=;
        b=JUPpeDueT47pf6WR00ksuAwrQZgZRSysqS5wi57FDz3h2VM4eiGPfK7XdPZxMs4Nl9
         2/Q2q2Ogfhod1fztMoSidMwjPhTx14dARRMTOQumhjrkdl0JqXr4W6eo2k9KpPLfp14R
         UUSdQ1nFD0KNM1d+msihUNO4SsnYNx2B+6Cg79YV7KnWnFRLXZrK4hixFHLDOD2FCA/9
         7hQWbUAqwm0DL9wA54wO3pkiIfHZFyqxh3t7iB9pN5zyE5ZIig8NQFzu2c8uXc9bXFJJ
         70Ui5OJjpZhqHo6Fb/Z7yVM1csIpNobJOonm0osJWT2Q4lCKjHXj/c+fBRSQVHLWsfyU
         WXMw==
X-Forwarded-Encrypted: i=1; AJvYcCW8wsMdQ3V4/CV0Uhny0I/AEGBhkO24vgEv/19dvz7lf9KrY+uB/+YoImUxXfpd+mWDMa4mosGoIqWWVYk7tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfnX2tR9/cg8quVDl5/pajzo8hnzMUb33P3gynMVuwkxzv7zl
	C2yK6lS856dyq4LsTbKjl/UGce5ARfVXrM1E0DzbZ57un2xMsv0oZ03JRTYWf0JHJ4kQeFaSIYv
	bezq71Nn7E/STaTp0lUFIb6dDwGV5qefRxbB7QRCbUK5nev3lZyO4Xy/FNPQp7VMpf0Pb1tgazt
	6Uqg==
X-Gm-Gg: AY/fxX6stvwD+z3g8VoHpXlg7Mw6kbJ9eu0LEB89j9GbZM+o3MpYtZacLeSgO7bA2O1
	vjHGkfN2qZ+QDjN3cdG3uPt9wahyUChIqmh3hNFvF91G86iCwcFPIqL6gyNyodKMOqxXSoAplE6
	xjPgmGMn9x4DKNjNCmke6q+dL0Nzz+q7Gv3R1ZXBJy0b3UE7rgV0WhXyOr6B8lCjoKua9b7JtEA
	mFzSbzpQ2eNtDRBN4u6xlgCSFTSkRs9vgLX37zyi5V4fVDfl4Fn6/szlWCgdIG7ONvjCmAQRRue
	wx1PaIlyOOXO4CroCO0QkHS9Jo8GOG0AbPE3niV8KOzcxX/acEpGvrAbRDdShm7PGCIeaOQw1wy
	6FXuqvSzY9pGgVUd0hpr00QDejSg3xb2oi7pGXqikHUsMv/3O3oVvkhFvVkWWZMIvRA==
X-Received: by 2002:a05:7022:f00e:b0:119:e56b:91da with SMTP id a92af1059eb24-11f349c1d54mr13475805c88.11.1765908741320;
        Tue, 16 Dec 2025 10:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXP35etRl0FXVHFgFesXy8iK6Su/vGmWGan+8be6P9rrdpaSBS5D7gyy1Lf6GbP4+38XtOhw==
X-Received: by 2002:a05:7022:f00e:b0:119:e56b:91da with SMTP id a92af1059eb24-11f349c1d54mr13475767c88.11.1765908740702;
        Tue, 16 Dec 2025 10:12:20 -0800 (PST)
Received: from [10.227.88.211] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb28dsm55601580c88.2.2025.12.16.10.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 10:12:20 -0800 (PST)
Message-ID: <2eacf101-3e4d-41a2-a45d-018bf0f134b5@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 10:12:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless 1/1] wifi: mac80211: do not use old MBSSID
 elements
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20251215174656.2866319-1-aloka.dixit@oss.qualcomm.com>
 <20251215174656.2866319-2-aloka.dixit@oss.qualcomm.com>
 <da89d1394d19915a389f19f8773a028956562a6c.camel@sipsolutions.net>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <da89d1394d19915a389f19f8773a028956562a6c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B6+0EetM c=1 sm=1 tr=0 ts=6941a106 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=immwu4UHTLlNtH53ie8A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: yY9G5Ay9VplNPYMfPqMHUYkMLWHTBj04
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE1NiBTYWx0ZWRfXwwX/oqjoeVor
 5t7QTFU9P5GEJYiISSBp4JTQ1F9l28BtPRfhY4wXwrhIkKW5Idc4kulJtv2uzFSXSZC26Nob8Z9
 Sdry+ZESCPB9b139hexhKPMgzzg9G7NOlmHI+RQ6WDYgqMI1m6rNTSLZdRfpe7Ff1JLXPFnl2Zg
 Wx/smyl1Gmd9lbzqSo4pKakA4u7y108iqxp7BJXYaUduJoYQ/6ysR5jNkBzCi4Ywi5CLb+jxfWS
 qzXs2lbzPd9xyVR+fpHtenAxMBQGXA7JzWUEtvfJpoYvNDEtSOD54DE9xGaatVqik3HYyyZPrx4
 ddsU+5X3tRp3Q95y/HbfDoRa1CgJl8OImRd+y0Nnur3H28hgAWJAB6O7mG9UytYE1MuWgfDY5us
 hmUA1M3cwSwE5fwzm6378Z+qiZSYBA==
X-Proofpoint-ORIG-GUID: yY9G5Ay9VplNPYMfPqMHUYkMLWHTBj04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160156

On 12/16/2025 1:32 AM, Johannes Berg wrote:
> On Mon, 2025-12-15 at 09:46 -0800, Aloka Dixit wrote:
>>
>> Fixes: 2b3171c6fe0a ("mac80211: MBSSID beacon handling in AP...")
> 
> I'll fix this, but please just literally copy the subject.
> 
> I have an alias:
> 
> $ git fixes 2b3171c6fe0a
> Fixes: 2b3171c6fe0a ("mac80211: MBSSID beacon handling in AP mode")
> 
> $ cat ~/.gitconfig
> ...
> [core]
> 	abbrev = 12
> [pretty]
> 	fixes = Fixes: %h (\"%s\")
> [alias]
> 	fixes = show -q --format=fixes
> ...
> 
> 
> johannes

Adding complete commit title for the fixes tag was going beyond 65 
characters.
Is that okay? I added '...' to avoid that.
Thanks.

