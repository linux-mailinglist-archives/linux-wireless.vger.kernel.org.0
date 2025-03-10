Return-Path: <linux-wireless+bounces-20120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F9A5A45C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 21:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251793ADFD2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3331D516F;
	Mon, 10 Mar 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZMrMF8+z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E091CAA6E
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637175; cv=none; b=ApB0ZhFoasEyrTwrwYQgXhbxiryy+p2NyCqKOXxEa7z2hW7cn6fJs6WxOCEr7SnovvDLgDdm+WFMcZlfGf/OdwxY+6HkwL7oxr+suEhYa6pxg2uTSmIaNG7WXR+m6y5OwoDH1HSuSkOjPfUFK0Oj1hMmEdA0V0MjlPzfILYQj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637175; c=relaxed/simple;
	bh=3JHisht5dFBy3DGwC3bdDxto6rBMjzhXsE5fZsXmqf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VkEZ8qZACg/ymNMFU957nbUWUqy/qGFPd3h+E6IEpKSwIxeD2MpdgVJz8TysTLMd2ogbMeSL+i2pW8en+JlT63/nqRqdFgScQTLuqtTtkTj0xoA8hfOSNRgscGc+OSjW75NQY3gvimbQv/M1NK2aBpw1luO2uNpvcVJ0I83wIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZMrMF8+z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIpXvb021615
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OWaSKwt/0sm+5opJTd/K6Dt7zpEGvd26BHZwG2Qbd2Q=; b=ZMrMF8+z6ZS5RZct
	DhHnmYfg1hS4n724aeHgXIz5l711Jg6quztIYTuES8vr2cjVTgQdTR8tdpvWeOss
	ouuQFLQbVM1ebXgvmEPsJV19lkz9luoCwVwRlGbhQ5HAHz+yUUWMeJmECqw9DSJS
	795GB6A/ZER7y4P82w7QhlqQav7MhMWV0zVht4OLUG62PVr+yg/xlZVMOcNQBeKJ
	d/j032TXMZUWeKdQT2zzMQxW9dzfFvw/7wBTmEWseMnyxJgs77VKOWOXw8LaPkMc
	2iRelHDm+WTrvfEXaNsigivFT0bKZxZ/LiQrgaaCp66l554/icaAprKSDzVgPf4X
	adSD5Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex0x2w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:06:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242ade807fso99082945ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 13:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637171; x=1742241971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWaSKwt/0sm+5opJTd/K6Dt7zpEGvd26BHZwG2Qbd2Q=;
        b=xVgQ02PSerhGNaqfPQV7j+l9Czmt6nnxP3nWIMql8Z3IPg/qdJ3xCJqMhxtrhjY2v2
         d2ON9Otg0pmGjItHogv5l1eIrj9NLxQ+Fx3KjwVBsyXQ2p5cYtB6DLeb27dk2n5s/3dO
         Arg6fvnxcD2pHuF/ngXXZbdx18a3i8ehCkvHWazV6AsUuseL2wyGDhY0iRFiY1pxwIUx
         XxbAgYmcL0NiVOCz0HY4qLDJTLCRfDpc29XmH2PyLLzpey6SVpnNQKxeIUjKgWwuITFL
         OWReeNHwQ7k56uBHAlPdNKwHYVGN3Pf2KTymB1bsdonhKyW8OY16wO8w/csDktbQ0WQH
         WzYA==
X-Gm-Message-State: AOJu0YzMdptfiWmeEK1HnHiE8R9tEtAUj9KgJ4ViYB6Hp4hA9mXF44Kq
	wGpoFUPcudCANHlaUAhB3APkiDyr7Bw+jmwvL10TPfyk3CIc2GBXWrSgzGv6W+oWhhVrcZQ0kHP
	TKWnw+Kcg6lKVh5i1eUh5/QBh57fd4xOYqGuUE0GluOPqh9EBvZL3l4i3ZYRQoZPW6GJUAmCrNQ
	==
X-Gm-Gg: ASbGncso9ZjFwqrgPCFnkJWOAu4ErRDi9K7ehNcZ13s24+80qfwrO6sf8ygpFfTNcBE
	HRE+gUFzlZal1eCAVxKi6sX0v3sysUIis+vHmCJtqs4Ry7UZJFLt4TuXR5C5rNG9QxY4gA8n+f9
	5+jhcT1r8z9zvH6ifkVfzcSQ/ndbGKh4wYougCyxP2NSvPY9WU4UIgHtcBy2GmyXkkCQ/9vhdeC
	FuNiRI2Lv+wCFBc+JGKWtrdFh0P/MEY0eEHB6IfL33ZYgUCV/0240GlNAUwLvEpasdJBxcZu3Vs
	H1MWdYd5ao9HyOGa7j3GO2HLHB+MGIuQzsgX+ABuUg0ed7S+COleXpuj98PpJcN2llThUG3sgHw
	l865A
X-Received: by 2002:a05:6a00:1819:b0:736:73ad:365b with SMTP id d2e1a72fcca58-736aaa76791mr19717029b3a.14.1741637171174;
        Mon, 10 Mar 2025 13:06:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKRXO5Aqpy7hm1pqQTj4PHI1ULOzwIS0JSNlPjhEGkDWQa++DbhyJzHpZ2fI7xywd1An9rsg==
X-Received: by 2002:a05:6a00:1819:b0:736:73ad:365b with SMTP id d2e1a72fcca58-736aaa76791mr19717006b3a.14.1741637170820;
        Mon, 10 Mar 2025 13:06:10 -0700 (PDT)
Received: from [192.168.69.142] (c-98-35-147-9.hsd1.ca.comcast.net. [98.35.147.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736acc799b4sm7228793b3a.54.2025.03.10.13.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 13:06:10 -0700 (PDT)
Message-ID: <289cca50-b559-4b7f-bc89-e089d7bdf6e0@oss.qualcomm.com>
Date: Mon, 10 Mar 2025 13:06:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath12k: pass link_conf for tx_arvif
 retrieval
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
 <20250310200237.652950-4-aloka.dixit@oss.qualcomm.com>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <20250310200237.652950-4-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z3jtB4ywLv-nDSuUR24peAffDjJpdlXf
X-Authority-Analysis: v=2.4 cv=f/qyBPyM c=1 sm=1 tr=0 ts=67cf4634 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=UlYobBNIKLIdKoAhXwLdVw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=N-p2Yt28-VMXFBeuicUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Z3jtB4ywLv-nDSuUR24peAffDjJpdlXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=908 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100155

On 3/10/2025 1:02 PM, Aloka Dixit wrote:
> Three out of four callers to ath12k_mac_get_tx_arvif() have
> link_conf pointer already set for other operations. Pass it
> as a parameter. Modify ath12k_control_beaconing() to set
> link_conf first.
> 
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 31 +++++++++++++++------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
> 

Forgot to add tested on tag:
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Will send the driver changes again with the tag if required once 
nl80211/mac80211 review completes.

- Aloka

