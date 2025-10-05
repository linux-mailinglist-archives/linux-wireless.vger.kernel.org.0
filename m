Return-Path: <linux-wireless+bounces-27820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E4BB9917
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Oct 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFDD3346194
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Oct 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34EA189F43;
	Sun,  5 Oct 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4RE1nKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D601E7660
	for <linux-wireless@vger.kernel.org>; Sun,  5 Oct 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679364; cv=none; b=joh/JcK51D+ZLQWdMEXX1L9l0Ejk5ixVzkLHNbO9AeszEf1Z96vBeK9UWIOMgKdB2KiyCGHYr87NBKPmNGke0H3cjf8Y6S/y+DG30poWOrYaHqSUPX3OOtb0SFlApVUEQLTVlVxpjAOJhEGpiddIXn6Wjls1xEtKWJzZMUqbOfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679364; c=relaxed/simple;
	bh=HXX01NhOJKzwTJkl9Xf4issAfhupybI67+98E2Q8DAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpaBhqaME2AAYG7ogeZiKVSl6tMV7Yw7eTUNrDzHo1mNewib1mLi0ML2Kzd3ICdRuWN5aqLHLAp0AcsHE9BkQ7m1DEUQWq1VpsaqQgwrtNBvzpZQaL+g0SCAJv9YQKB4NqdueSsf/usYQDb9YuUTpeTJtht9/b3BI8UAH25MTkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4RE1nKx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595FR7su017724
	for <linux-wireless@vger.kernel.org>; Sun, 5 Oct 2025 15:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l9PIQZI3LCSH8U6hYQlVNYYlZC7mA7OsdnmHKJGMOUk=; b=K4RE1nKxiA8TUAxN
	ac52y6FwYqQWRzOxoaXaxQZUxVWFgN2j6RxthYUNL3txL7kD41z5xCnBWU3NN7po
	cXwDG2SUWMvizmUF3A1ScLMWA3n9wFbDILa+ZYbXmQx11Re3MpWHbKAZMTlpB/vw
	oQfqxhQenZdAfIKfCsSrwIj/qqXUynqgjS9GY0IWP2qjT7PDAF5ZsZzXEHuX7bsb
	xp6umtHZbNfKK+8FxUk8bIr09rbmoTuQXqds3hUMWV5CDBQAF8Q9KeXDvfgcrrsz
	ReBWylsF++gJPIon6h7e5gwGNEmWo609inBsXYG1F4qXJ/KeAnm1x/+XTxzIaQCC
	7LRArw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhj105-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 05 Oct 2025 15:49:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-27eed7bdff0so46083145ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 05 Oct 2025 08:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759679360; x=1760284160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9PIQZI3LCSH8U6hYQlVNYYlZC7mA7OsdnmHKJGMOUk=;
        b=TAoprN45IjupeC7XCOurS5YndifT+aY5nbynogXRNNJWhTtJaRG+i7sa9vl5CEiRNa
         pb9Il5Tk44UrNwHKTR97grTPDl8KNf5TXSBH+dwMwpu825elfG5t67TjaUS5LLY6M2LD
         Zatp4NzFcbe9uNEeu7qZIgoef8n7yq5vLP/eUUShD6ykBhrnieBVlbKYGT5e/bDG7xdK
         eKtBPV1TiwNuiwQaX1EMKhwC7aSwEfrbGzUEaEgpczGmCTVSZFg2mxlU8B6YtDnrkXyI
         CV7LCPDCiHdRb6P11d6jQhOt/guAE3jrB1a1BOvRlrhTvJTrwCO6A9WMzNHZr27pWNyZ
         6o7A==
X-Gm-Message-State: AOJu0Yysdy2jGUL6nMZD+Mb9i/YePIR2+8DYakdT6YfE91BIAu/arBiJ
	/ujMPuy24S/IVvbO48Bo2LXAD9RhiJrFqShKXSddkDS3BheIYDoTeZeekFfxujmIc7LnrZQKFoq
	tEH/yTikHGUmvVI9ZTLLTy8FdnY4wGdwnnBPHMJfRKIU1BqET7Ipn21KJNoCm1mNVPvX2fw==
X-Gm-Gg: ASbGncuEexgKTgiNtv9aVKQWDvlOmGEkUkARj3aWR9+vOKlu47BQd7VRWlLvCafPo6W
	Ed5zChgw6uTOLJmz+5hZZg0+mKONVHpLFDKvQ6hIDxVHSsIWUbQmXwzqmfiFtR27GfwTz3dHFIN
	E7LmwC4QZdRIjQD33OeF3VK3Ra4cauqMM/3WFXw6ec8OYnwu2mZSW3hKj8H212XFaM8wxBzlE2u
	qtigAnbeHfjV0tGw55pq8zQT1FkSbPYxV11dWqOzck+DjsbbzdL1oXj3K3XdWHyu4PrN7eE7Pt9
	YoTzQimWZa/mlOnV0PQd/3FsQVI5HX6KurwPzGyI+jcSoYqk1Lz1cU0xE3TQE2TtV4dDMWFCD/7
	Wq+5N/xK3EPMEJ7F92/qE
X-Received: by 2002:a17:902:d60d:b0:272:d27d:48de with SMTP id d9443c01a7336-28e99d87ab4mr113813765ad.18.1759679359860;
        Sun, 05 Oct 2025 08:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1mJ8x2elGCEAsphoc9C8FUDodvjlK5885jCCmAIT0/U50dB5n4jUt0cw9J7YAYlYwkKA6aQ==
X-Received: by 2002:a17:902:d60d:b0:272:d27d:48de with SMTP id d9443c01a7336-28e99d87ab4mr113813635ad.18.1759679359380;
        Sun, 05 Oct 2025 08:49:19 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.209.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b88e6sm106267615ad.91.2025.10.05.08.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 08:49:19 -0700 (PDT)
Message-ID: <6b6c8f3a-63bc-b3eb-9f26-c7db6e8bcd7e@oss.qualcomm.com>
Date: Sun, 5 Oct 2025 21:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-current] wifi: ath11k: avoid bit operation on key
 flags
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20251003092158.1080637-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251003092158.1080637-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX8CjU//mE7cGq
 CYC8vzbmdYCroym4n85GzBMwyEsjv1B3kwhp7MkruCc4dRmIuoHieZDwNzbcXhJpnfGzw9uXsEa
 zDXEKfblYhlQ0QCG2u9InL3YWPLAznmVTzAuUI3pknrkdkLeC/+LAkrXnfCrVDefyheeI5eS2vY
 4p+0BjX/dY/2enyu/ppjQb63N4B06D7Bc5xE9jB93pKN6bX92oZOYUZZhMq7F4hYyEIMU7FZ4Sn
 9Jnf800ANJcUyFhwqcoJTMMRXLG1P7MD9aiQRXaRBoFOzukx/aJSbztOkZBymC4WCkcBFuohONR
 xBVmG+hrrBs21ShY5dD8nGcr2WSspTM1gvdPcN7zBOJIcINxD4SjB4+YHfbtU2vz/WydKI18fIE
 X3VyjHspNrOCw4sqrp000v4i5gz7Mw==
X-Proofpoint-GUID: 7Fu4I0gxmN6MtNyltAXyAaRIqmXEpJYh
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e29380 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=FXeiAMptI+yIFPIDlLAp5A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=ls5EOjYx-Cy7lCJonlYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7Fu4I0gxmN6MtNyltAXyAaRIqmXEpJYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036



On 10/3/2025 2:51 PM, Rameshkumar Sundaram wrote:
> Bitwise operations with WMI_KEY_PAIRWISE (defined as 0) are ineffective
> and misleading. This results in pairwise key validations added in
> commit 97acb0259cc9 ("wifi: ath11k: fix group data packet drops
> during rekey") to always evaluate false and clear key commands for
> pairwise keys are not honored.
> 
> Since firmware supports overwriting the new key without explicitly
> clearing the previous one, there is no visible impact currently.
> However, to restore consistency with the previous behavior and improve
> clarity, replace bitwise operations with direct assignments and
> comparisons for key flags.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-wireless/aLlaetkalDvWcB7b@stanley.mountain
> Fixes: 97acb0259cc9 ("wifi: ath11k: fix group data packet drops during rekey")
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

