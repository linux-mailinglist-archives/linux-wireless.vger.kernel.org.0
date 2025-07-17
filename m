Return-Path: <linux-wireless+bounces-25622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32199B0951F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 21:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F5A7A2A1D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0462FC3D5;
	Thu, 17 Jul 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPGi4pIv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89387CA4B
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781351; cv=none; b=j6xgCQmQ1VBrjxjScSLxF2BFGELsyGboV31m6naNBrIxFCbvFEoy9SLE0OZlLbgaJLqt4KcSBfluML0jZpqoMwS4FKpvTWnxrXLhoYOeCFqfsjV/tKmul/S/+94LW7M84uxH7zhklY32AQ/xoqQQiBXin482laB5e6PSTK33+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781351; c=relaxed/simple;
	bh=HOKdI9eqQ4lmgku+SpfrhfjE3hrzMVnCFV0FSpyHMt8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lF1sc1l5hL6lAXiVNH/Q9HhdeQh6EdmfBro9Rc9JSM4NQLWxczQ9KSJy7EVs7KLGaNaBTRjV/Z2hCYUZ3z9XLi8I14g8jU0ZYcchFQzjr6Os5LW43ecGmT3lcTTTcaQ+JJz1xEU8pdOo1Ut3QidJyAWlCwCK1ZjAHmMqkQ6fo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPGi4pIv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCpuW1025190
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	luY0BVPgSWUzb7YHuowS+pO8iR4/4nofCJx/Pk3pHto=; b=cPGi4pIv0V81TKLM
	1j5BrdGMFeWgONQRmoZMkxe4vH+uGz2/LGst0BZg3rVAlJC8/O4EOR2hesYJNL99
	lTmSrmyfvDzdQGOVVfgPeXgrup3fIKmkJIxpzjHeVycGPo9JkHH3p6gSuyyW+rbE
	EfKeozBBVOQeNV/WGM6SUsKjiAPQk7WEFbSugKSzjwS8UAIPUhfFH5zAVrAdJOxP
	jXFTGNzHr8q6im7tZFVp5sBUg4VzYweS8XjcLE8rU/3BbpUI8Jc0k84RM5EpAZ7T
	iBl+rH0JJWQq5bfB8XVtyEvrt/NV4sPBM8NpCmiMWiQvUiDngPpVBxMAfGrtIlBk
	KeAbGQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqd6bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:42:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2369dd58602so9657555ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 12:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752781347; x=1753386147;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luY0BVPgSWUzb7YHuowS+pO8iR4/4nofCJx/Pk3pHto=;
        b=LjBlJXxRBis0U+Hb79KFCJX0pgCJ/1bIVbcIaliM6fChrTd3xkLDMmizrzgI6746yJ
         L88nQ/AaUF3OoLqDkgQLtQZnCv5+C6FfpPazsRR/NPPao5NC6Mk1ndC1WPdQithu2jOR
         /pDteilxpgaUpHTIqUOL89+IRplccVC8aC/9bjckdZVQ2sN398wkNkXfpU47Da66Z3eo
         YgYYASRz4K2bMr4FdFREp/pjfe56vYzdjfm4nGuD6ZCJLb6aZoBj+79V24dWrmA1NxO2
         I2eluM4svtJ1dQF3zVVDJIVddhXK4ex384xuvKCp+KeN1I8tb7zwDTOYcde3UYAsJU+f
         RpVg==
X-Forwarded-Encrypted: i=1; AJvYcCVqIBbJyjbOraecAV+w2E7rxXhbglr9yaVISaHj/bGsUIOQ3zUWCcIMzt9pyUNt4mZgV3la5YlTsLXGhaS0Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwRl+pl5sIQpiAvjQt5iebOXfLMc4DJ+bKkf4fF4fRH6SgVXD
	qaQz25frWdy70yQKKYjSJNid5Tp6mjW3D95Uc7wfE/k+Zf0kPmsBODzJ7epHbOmOv3EfRM3BM8t
	Y1TK5RNtZAZcf3m/+RFu0SW96AhFYMev74X/ogZAnHIJrQ+3Ux8bCrV7o9PbQtx/SppiLEQ==
X-Gm-Gg: ASbGncvFl9sFN4NAGAQma/svGaQjqlHSfFmiHj/SOGyHO43keLKYGQ0kKUi/ko0Lcdu
	xiy1vie2rN7czDYTzXj63u9bphqGXVTly5cJ5YCCbrAhsSvhOmu21F4ffMm6EQA01C+Msv9Fob4
	MWnmRDgi0W+rH1iGcpcgsqzHQaeXKmkL1v+0FcYc2E824d6OpVnifqarH0i3H+A3GokGd0wQa+i
	1ivfGUhnq/EkrrYPdxQdQaLjS9ERboz3rwA2DdNYeMa+Z/HcH1o22i3S5XME5oY4Jc4OHx1raMH
	FBKYLqTLve1xHnPsGYR6P+WNon+pgF9RkdyEjuhZl9+kDjMDT4CfeMIAZUh09yTVK25xawaFAbS
	Ce3tG4PENw48jEYIK0xoplwrKk0dV0nCK
X-Received: by 2002:a17:902:ea04:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-23e2578f517mr125095875ad.53.1752781347052;
        Thu, 17 Jul 2025 12:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF21vei6egRxGWQiQNQ8358x5+YNlDx/NMSCHicIfqFSoDmEJqt1K5A47VJ1nds2SQWOyPEKg==
X-Received: by 2002:a17:902:ea04:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-23e2578f517mr125095485ad.53.1752781346565;
        Thu, 17 Jul 2025 12:42:26 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2ca8sm383695ad.28.2025.07.17.12.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 12:42:26 -0700 (PDT)
Message-ID: <ead8f37c-6fc3-472f-94f7-ad4ea6fa0fba@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 12:42:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Remi Pommarel <repk@triplefau.lt>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
 <20250410215527.3001-1-spasswolf@web.de> <Z_jpq26P99qzPP1c@pilgrim>
 <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
 <aHj4zS_3uhDRhzDn@pilgrim>
 <fa538ba960369497f6d65c1448ab7710f76aa078.camel@sipsolutions.net>
 <aHkHOC6DYBXtnE5e@pilgrim>
 <a5e85969-1dc9-4d6b-be2e-ac2338d38d98@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a5e85969-1dc9-4d6b-be2e-ac2338d38d98@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=68795224 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=FvJLhJUQffOWFEYYKpkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 6y_b8WwcRUxBlA2ot8hVsMVBUxa51zlz
X-Proofpoint-GUID: 6y_b8WwcRUxBlA2ot8hVsMVBUxa51zlz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3NCBTYWx0ZWRfX/79gP4Idw6lt
 omN64G2im8nQtDCV1p4GYDQL9f7U2zBXqUtE62lN5KbQcwuhVm50nra0QrjJdxDCdJpWPft6Cs2
 Wxp/fbRixO7YdpQ4UQd29mRrUh2VzpB1a3euwOltlHtwl8ttdfAhda43OE1kUaxDWhU2izIv/Bs
 e39b5BZDfe3lsxd/sjQVhHetrDn6/zRifrPZPU1RAOUtX4shPHYJrUoSMkpsmiwlGwSs1QNiNeO
 0v30fP3udGvnvBZh+71ej55tbpqpTzI4iohAS2Xqj1aFOuH6C2NMC3kdLsjBUTKiH08GVMy3qdo
 6v3AG71KZV4Fj855SxwdD8iQ+vc7avPBUSFluXT9SAhdto+bSruTWErxsbYflVoyLwIfYQmPnfY
 +2oeYVyxezWeOByg+HTSgFZlmxEokSKI1lh6KRDDSyAfd0dqy9MEoLzQe7bzdMYhHvsIfl6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=956 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170174

On 7/17/2025 8:46 AM, Jeff Johnson wrote:
> On 7/17/2025 7:22 AM, Remi Pommarel wrote:
>> For the record, if I am not mistaken, ath12k driver does not seem to
>> support 802.11 encaps HW offloading mainline yet, I do seem to have some
>> vendor patches to support it though.
> 
> Upstreaming this functionality is in the internal pipeline but won't make the
> v6.17 merge window.

I make a comment like that and all of a sudden internal reviews get expedited.

s/but won't/and should/

/jeff

