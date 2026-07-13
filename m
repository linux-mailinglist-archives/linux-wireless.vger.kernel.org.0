Return-Path: <linux-wireless+bounces-38992-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9B3XGXU1VWrNlQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38992-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 20:59:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53774E9E9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 20:59:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="WdU4k/7w";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=B3+VqgQi;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38992-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38992-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C5C304B2B1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233363546DE;
	Mon, 13 Jul 2026 18:58:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EB353A8E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 18:58:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969123; cv=none; b=SpGxDStuDWMpFpJvUIvnamBZOkCvHW9YJclFq78UcINU2zinwL7S/8YB9m8JTaUk8xFwRxKMznQgDZOBrBMMZwN0zCu/G1uCmJMMfrwTad2mxT9HSI6drUoKvayNYFoAD2J4xhJhiLxvMZfTIBWsOlb1gxk2aQibPWq5QQLZVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969123; c=relaxed/simple;
	bh=Q4FlDRCpngp1x0aC0AgdewQ8wbrSnrUV0YCYHer0W7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAKLr4aLI7CaSH6z3U5a+/SpHmPVOaozL3UYTikj1wqX3Mq3gHcLz0SH9SBqQsy5DLiNgu4cPlS9wzfMwFJKCRHDXH7q0KERzyfFDW0Hi6H/b/EE78XkW9weANF6gwOiaIZVZlZi+9T0+inVitzK9UksFVaIwlUcW4yrpSlk/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WdU4k/7w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B3+VqgQi; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8kfK1908342
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 18:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EGm08z2QRTZQR1FZakby7UHoEn+vMY549zyGYn80n3k=; b=WdU4k/7wJY4565Q3
	OBIv/l/9/g9bOCtXtJdW5RUd40bhhXJJtBGCi5XyLAHtadKYz5hVdLU8knWINlps
	bNUIkviKqHLWLxv9gNI9iqXdGJ2UVEa6jsENcnQVNwq4EoYLEz470KHRNeHUHT8o
	sa+g5Qw8UDN99M8RL+ra2kDJC1ovboKK5zPW4s1STq08y2RwX3+UBJFecEuQ8H0O
	9XnFwJm6nPXYLi65NhRQ+zIzTRuprHoYo7OT+5G6P0c+/w8vIfA0qbM/PnP+tnvS
	HmjjtQxXp4vx87eHAWKG9gGELlUiYgWMLYLOoSeiuwkqWt+92FJ1lGBo9st/xAKt
	nCGidg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda28dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 18:58:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so44384a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783969119; x=1784573919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGm08z2QRTZQR1FZakby7UHoEn+vMY549zyGYn80n3k=;
        b=B3+VqgQijuSCWCFzQ701QEU++m268e+byagXAZOHSrmIVPySEALWFP9QeK0foHQRHl
         AqlUR871aBPAMFHvEL1Og8Xz0auhuT4zUgGF/sjx4iZpwSQWcQzsr5dScvA+LR+0jBMy
         AHNwy8vQ43Ndc18Civ9Fafnt1ZDpY5BNruWUN2ivmJpmI6JLDmgUXalb4572ChS2RYci
         AMJsxK8B2kiaOA1mk+u1lq7oAxadrptqIGBIjhIfvbSxmMjJmrF3uO7fjZraAhDi0WA5
         U6ypt+mpUzo7RfF6sq9o976np5CvwnMU1AfJsFlcMdSK3XqD1eYjvXmfYzMezy4chdqe
         Bx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969119; x=1784573919;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGm08z2QRTZQR1FZakby7UHoEn+vMY549zyGYn80n3k=;
        b=NBxb+GTQeO5EqL/u5/QSBv+3xyAJnQPT5WC57gskAJL0fO9J5S+RuM5/9NVr9AqxwH
         DwFhPBTxW/yFzoKps1AlaZ/xi5nnl84Ubw2OArRXrdX09W/VdHpM2iUX6h33ZCfBA61F
         GXfF31dt06X4imANhp1FWg3PceRrIjjoBMmm8H7zlEhm/fLOE7YmsPWbsbkGPsugx+8B
         SscGPYRi0v/KwLPPh3uSw7Saqe179dEvbmJnzio4Q8pCowT8HZzY45U0JBneKskFZdB3
         6LFaDGDyCUIYwOtJuGTot7/UEXbyNy0NjdncEWAWOF00EGbcyAaqmWMnTWn0R5IFGju8
         3e1g==
X-Forwarded-Encrypted: i=1; AHgh+Rob+QQnb80Ftd0PkWsWtdB/PgCagXDhSDFrL7uxdXKQTAyGZd8zyZuVzoOl3WIHgrm/MpQStYT2jsRv3sD/FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOSHpLdl10MqiKRJAYIt8fxvQ4VHjiBGvozsF+mhlEhzHTJwDw
	Sqp3ZqLFwH+UXt/HOSkPIkjemWzwTW4qcvSsvZhLKJyULMJalY2ESU9j/BgpZZrN7K+AmVv8Y/P
	3JTX/GaRe46bGwWUVlJbIMZVe/h1J9d2b0av0RMWGpt2ZWl6cjpLB88tkvnsTAWz61iF52Q==
X-Gm-Gg: AfdE7cl5jhmvvlMSu0lY0KI5daQqR6DaL8kERTG+q0Eor/rh8/Nwqc26F9Vonr+iqxo
	3+zwDq9DIoLkLhhK+VbJZ6bJC6Xdy2ZI36bWwS0+GqCMZsVZ2XvW5lzrPVa7Z96XtECGJUU5ygL
	MVjOuVQ0f37+cYUd6eRtvl8WuvQKrde1IVQIQEwzxuSThX7xCe741d2PknGjrS3Es02YY62dTy9
	4gBtTvEBn/95+BUJ09lh4WvWZuM5cwL12DoYkrreoDKyUXp8cbJajTM0+F5DLlck+GknA9Vqpgm
	mZuf3I5QMbsfLEC0ogRezidooZrnXfYIMfLVew3DTQKTJzHjSdSBam/RVQSckLtsO3J9cvTqJlw
	rVU6H2FjZRTZgEqhqVHVvMfCDXS/5mQ+wAdo+jlEhzI7HSzDPS8tDIPPekKY6ZyQnFcwC
X-Received: by 2002:a05:6a20:b7a7:b0:3bf:63af:859 with SMTP id adf61e73a8af0-3c110ad2e6amr11568609637.45.1783969119583;
        Mon, 13 Jul 2026 11:58:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:b7a7:b0:3bf:63af:859 with SMTP id adf61e73a8af0-3c110ad2e6amr11568594637.45.1783969119131;
        Mon, 13 Jul 2026 11:58:39 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm83117734eec.14.2026.07.13.11.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 11:58:38 -0700 (PDT)
Message-ID: <09e17504-d1b3-4e3a-b547-3c3c1040015c@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:58:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-13-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE5NyBTYWx0ZWRfX6KCMbDUGCeeE
 WkqAlli3UQR9TcW8d6SL1OAFIahHiw1a1QpCgXNoNYqMbi+glBKv5q95cIp87OakC6/1lSf59rN
 3GaUpY8ktMSKCrDvBcxM0/Ei8wpOGqs=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a553560 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=CBpSC656wZACrugyqBAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: ffipm8upnu8LPfU3AH2D9PEuL7zl2KRc
X-Proofpoint-ORIG-GUID: ffipm8upnu8LPfU3AH2D9PEuL7zl2KRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE5NyBTYWx0ZWRfXwEMshepqHPGd
 lsbYNMGGYaki9wvnQIO1OMGRXtGwA4F2+Tm59boosEirkntt+xr3kFzLkSnxIdk699C6+c/8FfN
 Wx1WGdvIZ7Luzc3qIXXbsYrE4p3wvYhv1OBn3dznq8czuTw/QVHALhhQPgkJUgUbH09CnzoynL0
 g06Dz5KPCmWfuku3WYaJq+Bpl8QyPpClcImaGCbptRXn+KfWVsNhDUOesmhX2O/D02gMj7ogw8m
 NLM4eBoxqtbnxlPfWs9LLIHLRLiUaKklNQFrKLJFAec3XLvJMR4FIpK0Q59J3SxfpxSAr6cvv+2
 Xs+TFwxv9LgPG7wdqo8RRLy/9RPrQ8puER6KivcGCvpHaXmBC4K7BUarDvBrbtxqGAxdRWbLr7O
 bygIGF0wZ3aRykPkGEss8r7Z67PhDcXZ0ZtiWzsGsU4TU2BSurIITr7OoH7Y0XRHHV4QXoPvGHH
 4ym8LXQeE2ETBrPJUTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130197
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-38992-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm
 .com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF53774E9E9

On 7/2/2026 4:58 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Jeff Johnson <jjohnson@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c   | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
> index 4a2b240f967a..0d5d1c55bfc1 100644
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -18,7 +18,7 @@ config ATH12K_AHB
>  	bool "Qualcomm ath12k AHB support"
>  	depends on ATH12K && REMOTEPROC
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS
>  	help
>  	  Enable support for Ath12k AHB bus chipsets, example IPQ5332.
>  
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> index 30733a244454..69e21214e629 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <linux/dma-mapping.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -420,7 +420,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>  
>  	if (ab_ahb->scm_auth_enabled) {
>  		/* Authenticate FW image using peripheral ID */
> -		ret = qcom_scm_pas_auth_and_reset(pasid);
> +		ret = qcom_pas_auth_and_reset(pasid);
>  		if (ret) {
>  			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
>  			goto err_fw2;
> @@ -485,10 +485,10 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>  			 ATH12K_AHB_UPD_SWID;
>  		/* Release the firmware */
> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> -				   ab_ahb->userpd_id);
> +			ath12k_err(ab, "PAS shutdown failed for userPD%d: %d\n",
> +				   ab_ahb->userpd_id, ret);
>  	}
>  }
>  

My code review agent is flagging:

**Missing probe-defer guard** (`ahb.c:422`) — `qcom_pas_is_available()` is
explicitly documented as mandatory before any PAS call. The OP-TEE backend
registers its ops asynchronously; without an `if (!qcom_pas_is_available())
return -EPROBE_DEFER` in the probe path, firmware auth silently returns
`-ENODEV` with no retry.

Is it an existing deficiency in ath12k that there is no probe deferral?
Or did the qcom_scm_*() calls somehow guarantee something that is no longer
true with the qcom_pas_*() calls?

And also for future cleanup:
**Misleading field name** (`ahb.c:384`) — `scm_auth_enabled` should be
`pas_auth_enabled` to match the backend-agnostic API it now guards.

I plan on taking this patch as-is through the ath tree since it is currently
just simple API changes. Any additional changes can come separately.

/jeff



