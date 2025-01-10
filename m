Return-Path: <linux-wireless+bounces-17340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD91A09BA8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE1188BF34
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 19:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5A2080CC;
	Fri, 10 Jan 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jEQ0srKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050312066C9
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536551; cv=none; b=G7st9h5upejSjPwRtPktSzPcOq+Y97Lk7zIoFpYMM+Q+ZyrmTwfqQ1xrVdVfQJZMnyc1TwaUZkZhQ134b/eyCLfHO4hKMhWMef0ycfqTpkNYQPKmY6WKr1b+TgaOaIIj5Y49XcWA4NYsIxe47G/yFhGu5Eft9C+2NIKOHCw1NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536551; c=relaxed/simple;
	bh=TGX2Oo7uyNyPZNIXLVSnYUBiY7sZo7hWSW9xB7zoD84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzR7s3VUHfTVVMM1y1IWxo2N+esUbE6SD1i919n4PFUE11hW/mv7Nlq9RVJljPpapjNqMS6OaVbVGwU3PgMGzYqtCc/3w3u0Ea6Y34UfgS0cvlU1E3NN5G9aGnuvMl/JOCBhsB7W8R7AasdthVU4b+mMiWNOs+rtWpQCY3F5sLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jEQ0srKN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9EgO8011871
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c3tUpG3fCBodRcd5VzelTr/Lk8E4pks2eY0PVPk02P4=; b=jEQ0srKNe7NhO/jz
	zNE77bXCQL9IG1i5hAcfZlHsv3cc1SDaXHW0Be/7B4yCiBmtivcvrKvzETGHPIBG
	cNVfT+q3MsIBoRf+jWR0M0UrILd0f+qp7JgceU3M3JOa6kpRtZZct/kjwn43CgdI
	hlKzvDOrkBPiJzhyvfK0R0yD/XfAM21LiWmkEZQ4xrbqKqQlbL7cavTtFkEIGSFe
	R+6K/okLonuc81rFGIZTST0Z/HhFC7C3VXKY4pDtF9mwT3j12onOAZNdiIYWdmnP
	xr9v2cmYijT7wk+6G5NQ4JYYr/djV0Ed4wNMxwLlgJY/L0xZp/vJ3jzNDdH/eu+r
	L3L7pQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4430rfhh59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:15:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216387ddda8so46749375ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 11:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536547; x=1737141347;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3tUpG3fCBodRcd5VzelTr/Lk8E4pks2eY0PVPk02P4=;
        b=pUAQTs6nsXMg3eq/j2EWQZCnGyUYuV6QJfndJin3QTmYXA9ldi2EFBtGjwgQr3TnGe
         5WrR4T5HlN+02Z0sHpqDIvAWHpKZPVxFAeowR/BXHXDCv5OqP7Pl36vyncSanFYTJ6Iq
         b5pXWMYFuI3cfr+w4/pUIC3ON13EDAC/Zebyw1/QXug4xfv/Qe4TsXfIuaRLa5LNdiIb
         DUg0BtDs4OsvHPPlPMOCXwxBBiaLw9XdMKGem3hTkDEdaxe3cK346nPmTHWJU+UfLJOA
         b3TAOraV3/BKEiwFI6K+SCJGTG4q7li2xleJJsiXrXKGeC0/bDjNr3piV8x2WGsjmkog
         gjSg==
X-Gm-Message-State: AOJu0Yy09EExilX8m9VBpYzmoGUVd8aRNSXc1t3pR+X97xld93MF+RMc
	bbWPYODYnMt6NphkriFHCmvPOeUEXOrZvlOYpwexVtDpr7hiObdLyuCHZS+RJU4ichhFnCDIwz1
	MnrlM4WNrWDuO0F5nFu2NoWzsv1i09LGtaDe3r1b1Qfcpr7cd6D9CTZcBHuM0y9k/9w==
X-Gm-Gg: ASbGncvqMPLy1Z2fnzNlY6PTM7b8LD4uOq7My+pYo6uU9PafM4HlBBG83wO224jj1hY
	SeiKC7VVfuxEYTKQe+Vao2dl9S2jlUjGCFViBEM8iMiRQvKHQniWQ57elrpnhS6Qxh4EZ4Ph6xE
	bh8z7dBW9vg273zNfQ5dZJInSvYeSdpxj3GUAQ6uz4ofVw9JWN8xoiPagwTjd5vIS3WR2QW4Y8j
	CMDVTNmdnaG+iYgl94QrRDt7mBDc8rMV5XN3bk1CCNvXO67+kovsffTCTOXH3YkFlyGqR9C4bn8
	ADR6KbPML0Mh5HNnGDfw320K7pfndtbCHXMevNUu5LXrA/5qTA==
X-Received: by 2002:a05:6a20:914b:b0:1e1:afd3:bbfa with SMTP id adf61e73a8af0-1e88d0a2a20mr21428179637.7.1736536547380;
        Fri, 10 Jan 2025 11:15:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERTp3UMzOaytbTacP2XkCDmM/hz89bf8ewCdobVbONC+3vUbjRtbY6e6ZAWv5rlUWcOQA6nw==
X-Received: by 2002:a05:6a20:914b:b0:1e1:afd3:bbfa with SMTP id adf61e73a8af0-1e88d0a2a20mr21428152637.7.1736536546991;
        Fri, 10 Jan 2025 11:15:46 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40680e67sm1907523b3a.139.2025.01.10.11.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 11:15:46 -0800 (PST)
Message-ID: <8b2d2ed1-88ff-475e-a4c5-8740591f67a7@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 11:15:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath11k: fix leaking peer->tfm_mmic in reset
 scenario
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
 <20240826014942.87783-3-quic_bqiang@quicinc.com>
 <d64f87fa-aad2-bc76-7de6-3e5056e2e637@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d64f87fa-aad2-bc76-7de6-3e5056e2e637@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2oOtbpMDFb_ZFKiFJ5e0Jk55XdZEy8_H
X-Proofpoint-GUID: 2oOtbpMDFb_ZFKiFJ5e0Jk55XdZEy8_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100147

On 8/27/2024 5:33 PM, Karthikeyan Periyasamy wrote:
> On 8/26/2024 7:19 AM, Baochen Qiang wrote:
...
>> @@ -883,7 +883,7 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
>>   	mutex_lock(&ab->tbl_mtx_lock);
>>   	spin_lock_bh(&ab->base_lock);
>>   	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
>> -		ath11k_peer_rx_tid_cleanup(ar, peer);
>> +		ath11k_dp_peer_cleanup(ar, peer->vdev_id, peer->sta->addr);
> 
> peer->tfm_mmic is allocated in ath11k_peer_rx_frag_setup() but its not 
> cleanup in ath11k_dp_rx_frags_cleanup(), which is not symmetric now. 
> Instead its freed in ath11k_dp_peer_cleanup(). can you refactor 
> allocation/deallocation symmetric funcs ?

There was no action on this review comment.

Do you plan on submitting a v2?

/jeff


