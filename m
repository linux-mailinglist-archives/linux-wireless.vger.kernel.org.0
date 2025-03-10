Return-Path: <linux-wireless+bounces-20129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039BA5AC29
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 00:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27673A4233
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D91E5219;
	Mon, 10 Mar 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8YM4bub"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71B1DDA09
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648690; cv=none; b=Fyyy7IOSgNRKqTJZDsItbOxLKeK9bQF8GLxf2KgC1YcVhL3azKmDmIQIVvUWjWT/jWYvKyhlE+3k30BS2aqhnl68hPGrxuNXLs/B6l3eiCBrmIu+V5ACJEgaMQ7bO3wQJuPC1IFZLC85oZ6fPTBwzuFyfawghmzJc3e2xBF1KcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648690; c=relaxed/simple;
	bh=VrnSOfAtlhLncWxmk2q2YGgNVlxUWv528k1quMHVrUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cf1vXjn9z0BOb1TLAUxisyN6m3tXuwpxIj+WwPlAMxkLuQEGIUo+CbC9IOzQH68CPAaVI8X3QntoAPc8gOFaQ5+GTQtPRw5gkqGZVQ2Y+QSrkxDRrHNcTt+Y/SnRbjffPCXHdEnHvpx0OBlTyhLiCx0cOP+P0SCQszsHY3HE04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8YM4bub; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIETwq022032
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 23:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	obMMFOPF5wt116Cas1gkTzZ+oUeuOoZd+h1bPui0PVU=; b=B8YM4bubbPENKARi
	X2ZgZyivSe+rdpXGm//efbpnATEJPOqv0E4W0G9gcT4JgDGKOcV1OLZaSR57ypRC
	j8gl474iU6XkmpcNS9E1b34yuL9K0XnH4zo9CLtdkW4ruLLSwiy0dc338ksiYm1S
	qRqX+Gnu2HeZtv9HndRTlAKepoB6r19pZt7eWjjuDWYUxkerSEwPVh4kcplgnIMT
	BWP7GqWF4K+g0Y+MGk/+Z1NZzFZ2TyDvuwUsIfMu67LTEwGB+CVlTKYJ5yxha8jJ
	AuKwgeV2pZp3aheBLBf3b5aJGcqyYiW5wErSdIhXuAkdrzBCo/Pd6bTtHWHhaxeL
	Nxt1HA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewppdjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 23:18:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225429696a9so74134055ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 16:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741648687; x=1742253487;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obMMFOPF5wt116Cas1gkTzZ+oUeuOoZd+h1bPui0PVU=;
        b=OetM9Tf8gz8qCcDIORx3C6OfzBnoSKRj7Z7dviiAUh/ejjtIa5XOTY4jk9suxDzu4Q
         gpQy7Ymtu4VR9Y3h7OJ9xnroNDIvPW3Vmns4Vd+spkUOpkzpBOHWkthbRHWvg8br7LXS
         gyefwbP0wMcGUcPdsR0NNlg8UPJ+wJGUS0IK/TG8y9XJemAIPMPvyJjK/dDto0eFmqJg
         dJ36P+ZvsQ6FtuCPpf24yDx3bDrWsD7Y8+U6AhPNaRbTVxn7l/iD3yPI+yQRJGgucrFB
         t83HCcjSsn4GRksEYdOp1LgtOJnQ2aTM9U5NJKzF6N0DPOeR6pakmoL+xsY6xOmvi4fM
         OYng==
X-Forwarded-Encrypted: i=1; AJvYcCXtkv0B4ijez3rzGWtQAkYe7siP5vSzB1cGLdTFqNfH0aT2xOrb0XG6JUCN2NueKucTu1SHyBk+KGcYTfBBKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTQWvlRFLj238t4mDHxeADdEhLfqc/C90WPqNEAyVycRWivbl
	KEpPYnEBbcXHcz56tU9Aq1wBWKfB+XDGzZ9qovOHRY2D/XsmovkuDw/AuFIDoCLGCaeQJE6XrOP
	MqPuMxDIcXtp04fbttV9mk1tJBpkzCAWfBNCREBm/6vmCi2hmZu+yibNTGbb0Xoaxmg==
X-Gm-Gg: ASbGncsYQ0CxpcTlT50TXIVkejhsInDIJvVL3lnuABGJKzFAM5Q7y90D2f/b+A9i1Pg
	P0uysG+uxKuzVgFuZkDgxYQBubktJeKQZ3kUmeaijfxwD6lalUlJjbjVL4ye8gp7C7I6/l5p7L+
	qynvr8c6n5nWekwLsu/tL/T6sQwEiHOb+ha/+7L9iQB//Xr19KZHGaEJmO5nzKqcg0212qNy/53
	io3Ai97KE8rjL85zo1yOcKQqmg+8VWUI2yuTrd8VuEeEkL7ogaVaEaajSWuP3mBp2T0HvaGzyc1
	61wTfbx80uDkcdE5z/GmjY6p9dh2jprdrBTMdhvHgwHIZOo+Dbby6/2rk4b0G+ZtUMTMuM3hjLn
	9u16YzxT2
X-Received: by 2002:a17:902:f54e:b0:224:255b:c92e with SMTP id d9443c01a7336-2242887b608mr222139555ad.3.1741648687379;
        Mon, 10 Mar 2025 16:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7wxwgSYH7C6i7r9Zsu2dJoV847cVMhkIqYL3tpPcSHg0KFBJpFZOZtRby1x6RrL6KDqfb/A==
X-Received: by 2002:a17:902:f54e:b0:224:255b:c92e with SMTP id d9443c01a7336-2242887b608mr222139405ad.3.1741648686970;
        Mon, 10 Mar 2025 16:18:06 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5c41sm83646795ad.232.2025.03.10.16.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:18:06 -0700 (PDT)
Message-ID: <b9ccf604-800e-4e4e-bf35-62d97cd1d90a@oss.qualcomm.com>
Date: Mon, 10 Mar 2025 16:18:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath12k: pass link_conf for tx_arvif
 retrieval
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
 <20250310200237.652950-4-aloka.dixit@oss.qualcomm.com>
 <289cca50-b559-4b7f-bc89-e089d7bdf6e0@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <289cca50-b559-4b7f-bc89-e089d7bdf6e0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NTToQuu-wBs23JpUA5EivmzvgMiwyNSI
X-Proofpoint-ORIG-GUID: NTToQuu-wBs23JpUA5EivmzvgMiwyNSI
X-Authority-Analysis: v=2.4 cv=C5sTyRP+ c=1 sm=1 tr=0 ts=67cf7330 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=Cd0U8RgZcvPyX981gHkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=924 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100177

On 3/10/2025 1:06 PM, Aloka Dixit wrote:
> On 3/10/2025 1:02 PM, Aloka Dixit wrote:
>> Three out of four callers to ath12k_mac_get_tx_arvif() have
>> link_conf pointer already set for other operations. Pass it
>> as a parameter. Modify ath12k_control_beaconing() to set
>> link_conf first.
>>
>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 31 +++++++++++++++------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
> 
> Forgot to add tested on tag:
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Will send the driver changes again with the tag if required once 
> nl80211/mac80211 review completes.

If Johannes accepts the first two patches I can add this to the ath12k patch.

Note, however, that you forgot the wireless-next subject prefix tag ;)

/jeff

