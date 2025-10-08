Return-Path: <linux-wireless+bounces-27887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF33BC5EC2
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 18:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA781544738
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337124E01D;
	Wed,  8 Oct 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hfp5B4nc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653734BA49
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938741; cv=none; b=Y5zsoOq4oGDiRCXtnjkXRjPOWIjv3KweyXq09opaBVB8wVS41RBcv4eRo+Klcbz2RQeO4QO88fWTlaZlhbswL1UiNood5QHRbB/Ms2GJXGt53YTiW7PLKXVEUTVuWfX2Zq36t6vBf6BdDoNrJl4xvASlnmNZFeX5Mef2OB++cs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938741; c=relaxed/simple;
	bh=Q/GPlPertDK5rTYCQYgTjljnUZsVTJF7yiOUPKjbbSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ER5fIKwNU5MS7LmLGr+pgY4IV8pIK3hg5OiBAPCvnC0Lf+KeuM8svtDLQTY2pnxdIE999LNaY0hCyu1ZfuF3RaDD2xXr6k1ODrvdzrpGqimwOyfBgE+iAVRfqdQNTRrbW86rm5vb4jfr98I13JlA+enbk11AAIw/gKEugCr9pEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hfp5B4nc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890PP0022734
	for <linux-wireless@vger.kernel.org>; Wed, 8 Oct 2025 15:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KFc76BDgD2P9Eg/sErqSY2dRKzFxKP25dp0vt90ggU4=; b=Hfp5B4nc5fUWczSt
	Gf/rQyICI705m8baPzccyDITha05ciCVRU66tE2cs4a1hZXbIxgFOGWbknki+oUT
	HvKqMiMt9PY497s07lVpV5rW7Kst+Qel0H2PS7+5nD/UTfPfYgMbfX8TKNT1RWqy
	ngbX45awxmnS0iYeZeMXDB6Kl0iJVCGjUoM7LqMaK2cb6Z+hMQ/hrBe527JVKstt
	hWRfaA963jtUdYlOF9W/UnV/6nSPtk+vzrUr7PKEoc5IFa5+FL5YEQ1NUaOOBwLE
	9IWyWBYFmYCsWJ4Z6RXDRAeLB215hyyS4VS+2u4Sq9OnORPK8MmlNnPiD3CfONzZ
	79S7QA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wkukkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 15:52:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6fbaso104964775ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 08:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938738; x=1760543538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFc76BDgD2P9Eg/sErqSY2dRKzFxKP25dp0vt90ggU4=;
        b=Bb3uFjOnNKuPJqny4ePl0JkkpveHYFxeVV3epNwccNUiT1tWxMpnMrG33vlkslEA0c
         1tVDeLa/yX3kj4FzJ4K69vLL0eHsCLerkZQSuMMQAwDpNKQemcimCmkRC/LyudAE6H+/
         hsqJzy84DWzgq0dug4Zvfu5DeFmTnzGHyxv0Y7B8CFgd5ahl0GZZsJRPGyRCK/tNB12X
         qqCfBWA5em6vIeCUfv5xXX4ixuDb9Wv2532E/tWqq5/rc2Sw2xKEIXk0LlCYVZpTupp4
         syWE8cztKBU7uTUihm1mge4e8r8gDl3gLxIsOcGSrW7/nqnewtw3YQb8h78/edSwN8WY
         zwWQ==
X-Gm-Message-State: AOJu0Yw9e7kCvsb7gCePiHtt2DBSY6mwY3oq3g4c/aDh7oLEtX+mK8H+
	qXso58qN1fu2pVDRoY2dJYQqL8BfIcGtlSlGhUS7BSDdnbqFRZeoEcOMN1Zq4WDep+/sFDYPuLg
	BYwSmczstvSExQiZsAPJ6PS7M/3o7QZzb4CeAQDwUj58SmPaBy2HByvrZ/Ldh+fu3mE4S0A==
X-Gm-Gg: ASbGncsDIlQbuqQ36XPRWu2eSd6Ll06G0PdQ+rH2VszFev02mx1fWMSHwcRBEjjmz0U
	uKLt639npvFvwcN/xP6h/zFYw4IYNWmpsfU59ky08Wbbc3EL/OuBsnl0tmXRV73E1760GzHgl+5
	YtnCewUKHsLz1aDkofUNahJD3bOu/aLWMz1yhEOT+tZhMMIZp7VDgyTV+dlgM9gakjDLbopiCTM
	ypSe6sKq1RSVoyz0x/p4u5I9p9ZWnnYkw9VAqHCRnOLBTVQvnydswZU7GeX7if9fiq5qnFkqjrG
	WNXV7Ww3DOJMIbs4Vi5CZG0ZBWa0SN9ztcMGh5gBNdsfJz8wsAE7Ee6ksk0NjD9Bp5aMFxohBBT
	AmPzom1AqaWShue7WQO8sOg==
X-Received: by 2002:a17:903:8cc:b0:269:936c:88da with SMTP id d9443c01a7336-290273ffeecmr43821555ad.41.1759938737880;
        Wed, 08 Oct 2025 08:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNlgtcPoxczCO031rhbVKzGidTk9wzfvUrXjmBL5eGY3gTdvs/Q86Zo/mTahJRpgOo0JJCIQ==
X-Received: by 2002:a17:903:8cc:b0:269:936c:88da with SMTP id d9443c01a7336-290273ffeecmr43821275ad.41.1759938737356;
        Wed, 08 Oct 2025 08:52:17 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.106.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b66sm862305ad.124.2025.10.08.08.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 08:52:16 -0700 (PDT)
Message-ID: <a3b8334e-c3bf-015b-540e-d6962ecfaa4f@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 21:22:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath12k-ng v2 0/2] wifi: ath12k: Modularization of PDEV
 object for Next Generation Driver
Content-Language: en-US
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251007110203.1541167-1-quic_rdeuri@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251007110203.1541167-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX0YJ4cp21rArS
 Bcciz2GbgbTKXMMKDjU/I7x2JZVqRjdh0pE4ITByv7YtXgyxc7z6Z6XLSK2GWH8PGxo7enOhD5s
 jw1QwsK1uoVE7tzUn9weEjgwCfGqnwRgjloBR9sPakXDG61lN+TYQ6j+22eRzKAC2SDIXBxTe8G
 NFdH1Ff+tU2oT7AkUTsIcmrc45R+UgCY7Zauqvo47u7aBuB+RYzsU+KNgEyokYX910CJKJ/2c6/
 xvGLIeJUO6ncXizV1A88DeJ3ZHuRa3MZE0mVOzxNwDsJcgeOGlywVjiBSyQvOvJoip39ulj98R9
 8lXtfaAv5e6IdQo7oKWT9ldDNPtSkbhaS4gaoNsO8vJbds+GI3HRut+StHe+ATHn64OWfkFwIc0
 EsdMz7w2OQceuhphOQrJb298HBqmoQ==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e688b2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=z6xreaRxtU16OQ9bEhv1vw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=vHGgmhArcKzGfspvb2AA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: rTStvKXlbDwBJZh8IUFwnhp0Gs1QWj2s
X-Proofpoint-ORIG-GUID: rTStvKXlbDwBJZh8IUFwnhp0Gs1QWj2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117



On 10/7/2025 4:32 PM, Ripan Deuri wrote:
> This patch series continues the effort to modularize data path structures
> in ath12k, focusing on improving the organization of DP pdev handling and
> preparing for future architecture-specific extensions.
> 
> Patch 1 refactors DP pdev handling by consolidating all DP-related fields
> of a radio into struct ath12k_pdev_dp structure. An RCU-protected array of
> these objects is introduced in ath12k_dp to facilitate dp_pdev lookup from
> ath12k_dp.
> 
> Patch 2 encapsulates PPDU statistics within dp_pdev, as these stats are
> associated with out-of-band data path operations. This reorganization
> provides a cleaner structure by grouping both in-band (per-packet) fields
> and out-of-band stats under the same ath12k_pdev_dp object.
> 
> These changes are part of a broader effort to establish a base framework
> for next-generation driver development, allowing the data path to remain
> flexible for future extensions.
> ---
> Changes in v2:
>      - Made ath12k_pdev_dp_to_ar() a static inline in core.h
> ---
> Ripan Deuri (2):
>    wifi: ath12k: Refactor data path pdev struct
>    wifi: ath12k: Rearrange PPDU radio stats
> 
>   drivers/net/wireless/ath/ath12k/core.h        |  24 +-
>   drivers/net/wireless/ath/ath12k/dp.c          |  23 ++
>   drivers/net/wireless/ath/ath12k/dp.h          |  41 ++++
>   drivers/net/wireless/ath/ath12k/dp_cmn.h      |  18 ++
>   drivers/net/wireless/ath/ath12k/dp_htt.c      |  59 +++--
>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 183 ++++++++-------
>   drivers/net/wireless/ath/ath12k/dp_mon.h      |   9 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c       |  99 ++++----
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |  13 +-
>   drivers/net/wireless/ath/ath12k/mac.c         |  34 ++-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 216 ++++++++++--------
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  66 +++---
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +-
>   13 files changed, 488 insertions(+), 299 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

