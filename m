Return-Path: <linux-wireless+bounces-27724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F1BAB285
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 05:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06637A77FF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9A1E1A17;
	Tue, 30 Sep 2025 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EynkdRfe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68882145B16
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203110; cv=none; b=sY0wSckHduTbb6bwQifVYMzfB2ag4F8J6FhBpOdtfQRviFxqE+fDLUJ9I2UUZV1e04pMdJgJyBk9t0EeOtUAs1kpIytAX2rYzt6EilmtkTRoCWOHNXg6VpVj+ZWKEAhx+SjQzLr55Nyv0Pl6EdiIZba/IuEBuHgAmeWEH8lCwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203110; c=relaxed/simple;
	bh=9XwlDbL0Cxgkh1HOkxaRpnAMuN4dH3tG3+ZJeXbrwyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqz3t7XnU2MRpyd+Xe2PClrSZbgQ9AVV4nudUwRNBOXR2WAJhAuhcdgQHlesgJ0tmo5vL8mrX7hFWwAIRTLVg0VJnxo1y0NG8NxwS7OQoyediH2DPaSk/px88R7m6gb+bEuHiQWxTZnzrBTCA41ow7YL1wNQNdo2bNYidqfT6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EynkdRfe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TIK7O3012062
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 03:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jmE+a6SIgfWrhaIW24BFA+Kyx86nWQNX287UT648S94=; b=EynkdRfeAFsOV/cq
	YYj9vROGu2DqvojSHzGjx4fw0J4+ebceiXvQC0PyhZe9Dc1GYhV/aYktnM5qEkgW
	WInzxj/f38K+DqJ8gmcWpDitU/UKEpvg0ZHBNUua1so5d9tyd0hXlroA34tKDGEd
	BEYykA1Dl15fBzR0RhENBTO9wgSavUUMxao52p39Y6tWffH7KkUe6/EXt67tgaaG
	YdUnlJeiHEQEG5YjT802PDXZ1b2jC7gTEY21AyVB7kJtazpmqtbXNxZ9oRam1EB7
	BkSNbeZyaMqFbABfA4276uvQjKk3Ahh5lNoet4K7TMc6zV+dzrwkRK84DqrTyULy
	g958ig==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5qj7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 03:31:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so7313653b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 20:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759203106; x=1759807906;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmE+a6SIgfWrhaIW24BFA+Kyx86nWQNX287UT648S94=;
        b=UkxcXAEVYVAhUeQtRH3tCVfG99yGBijUy3SsHOoWcL6d9bpMlNUg62SXQSKU5cuv9L
         NFf/GhZSnGAezh3wjoooMtar6Hp9tauAw+mHahgxL4z1QjvB6TIRgK4oKCh6/ra/UqUL
         mdEDi4ckb8Y41me0h5n80XX2BApB/1nBdcEdp2PdQC3QlXE3jAvL6RicM1/YaIBdO/iW
         K+vJW+G23lr0jKr3c9OYMxGTmEydVMT2KvE1A1rYbByawdjt8A1d+WQm0W5lZTKfyPqa
         26FPMPvXmRmsOAvyYzp9saSeohBpIoJ8P1Du7jEtSSeM0LgFCR6h19Z17iopPmC3Gac4
         ZLxg==
X-Gm-Message-State: AOJu0Yxk925U+zvKjFKfZxHXI0AojM4skpAnqTcTqaypRaFfTLeRLWpV
	N+JSAJANLQMm3Ek0DMJyDJTE6OJhcqdrU7jaaB94aa6lpT1LLNDBFm6+O2FxYtQ9tp/uTWV9idJ
	BG//dl4MhAN16euiZnLr2QiCuTqeKyu7DO8Kx8ygLcwyg1Vdl96BUZmfNbeEoWskJyDzU7w==
X-Gm-Gg: ASbGncvegaIToWqF42f106mmC1DPpqGUz4Ql2zWF1MCocZSB2z8WPaXa6VejO8hcUU3
	nzRqwA9Szuwktsl9ZAzOmiAd0PIcMUesOxv3bR+iu/ud7DcK9NNyw6DU2D+NRKF9v44dijM19rF
	ceaEsPQTvUGW3+GKALUjZhyLDIbG9gLuxjQA9MSB9098RNTsVx3SJ3f1B9NqaMqUyLY2FWpS7ej
	mMavkj+sDMLzhIyZBSgGp3X0pmlqPCYJzs8oQEr1fM2DP2DO9F4Ax55eivuEYJE6O/d4r5H1iug
	NOlhI0ZeejqXVYlSd3xiOv/K9S4Ia7yn4zADOcjknifB2XmIG1dyJ77pJe0r1/vx3q6diBGk1Cb
	wS7l1f1Y0P+1//yBiTToQuJqoXsycizFzpapKe3XgxKU=
X-Received: by 2002:a05:6a20:7349:b0:262:1ae0:1994 with SMTP id adf61e73a8af0-2e7d83ba73amr26327940637.42.1759203105839;
        Mon, 29 Sep 2025 20:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmgl+4ufBZ/rhJt7kCTlkjU/DMZ+0QNPC78B8rvyxOUDkGwC8PYNFlfGleUuhg2bFvb/+nqA==
X-Received: by 2002:a05:6a20:7349:b0:262:1ae0:1994 with SMTP id adf61e73a8af0-2e7d83ba73amr26327905637.42.1759203105431;
        Mon, 29 Sep 2025 20:31:45 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53babe8sm12704442a12.6.2025.09.29.20.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 20:31:45 -0700 (PDT)
Message-ID: <4f48debc-7910-4160-90c9-cbda2fe8e66a@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:31:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng v3 0/6] wifi: ath12k: Modularization of objects
 for Next Generation Driver
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250929115102.512719-1-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250929115102.512719-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LXPRlAIzMGNT0GcFG0JwLnpyrQh8olJ7
X-Proofpoint-ORIG-GUID: LXPRlAIzMGNT0GcFG0JwLnpyrQh8olJ7
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68db4f23 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wCY2apRfTzfgVPxwIycA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX3UkoOub3y22x
 NnxMSK46D8bkrs0DFA5wPRS4J0fv8XK24j0cxkM5FKFlfcokDlO4UNaaJIb6HyntoYd3ia38pd8
 7S/hXBzt+ynxBDvxHHXijZU+hCapp0ZbefL386E+LBdD6ARlEDe/rDQHKPGVBadZJndzXGq+1q4
 sNr09K00qtytzekdZ9p78ECyNgLUN+QkqeeWmsP+WQvFZp8jPx6R+OVssnMUOhVSGTa61eTerjY
 PnTgIdVj64UDJvuUpx8mJ/MwnY8pn/LBUzx+mudOzzhe+abjkTpksOr8Iq0BMQ0OftHLTucZII/
 e8Me+MtjckDiouvPs3dU2wtyvhQRIjUGCXboJI6kqH/DnITqDeObWR+h2j1X+mAuhBuJJA5SWog
 smCpLxQ36/c1/y6U2aTLjsrvzE/ZdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018



On 9/29/2025 7:50 PM, Ripan Deuri wrote:
> The primary purpose of the patches in this series is modularization of
> object structures along with their allocation and initialization APIs.
> 
> Patches in this series are made to achieve the following:
> 1. Modularization of device object to have a separate DP object in order
>    to support chipsets of different hardware architectures
> 2. Refactor hardware group and vif structures to optimize data
>    path operations for future extensions
> 3. Add framework to support architecture specific interrupt handling and
>    ieee80211_ops registration
> 
> These changes are intended to provide a base framework for the data path,
> allowing the data path to remain flexible for future extensions in Next
> Generation driver development.
> ---
> Changes in v3:
>      - Use dp arch ops to invoke arch specific service srng handler
> Changes in v2:
>      - Invoke ext irq setup/cleanup from dp device alloc/free to fix
>      suspend and resume call trace for wcn7850 in patch 5/6
> ---
> Harsh Kumar Bijlani (1):
>   wifi: ath12k: Refactor ath12k_vif structure
> 
> Ripan Deuri (5):
>   wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
>   wifi: ath12k: Support arch-specific DP device allocation
>   wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
>   wifi: ath12k: Add framework for hardware specific ieee80211_ops
>     registration
>   wifi: ath12k: Add framework for hardware specific DP interrupt handler
> 
>  drivers/net/wireless/ath/ath12k/ahb.c         |  22 +-
>  drivers/net/wireless/ath/ath12k/ahb.h         |   4 +-
>  drivers/net/wireless/ath/ath12k/cmn_defs.h    |  19 +
>  drivers/net/wireless/ath/ath12k/core.c        |  19 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  39 +-
>  drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
>  drivers/net/wireless/ath/ath12k/debugfs_sta.c |   3 +-
>  drivers/net/wireless/ath/ath12k/dp.c          | 143 +++++---
>  drivers/net/wireless/ath/ath12k/dp.h          |  32 +-
>  drivers/net/wireless/ath/ath12k/dp_cmn.h      |  50 +++
>  drivers/net/wireless/ath/ath12k/dp_htt.c      |  22 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c      |  15 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  20 +-
>  drivers/net/wireless/ath/ath12k/mac.c         | 339 +++++++++---------
>  drivers/net/wireless/ath/ath12k/mac.h         | 131 ++++++-
>  drivers/net/wireless/ath/ath12k/pci.c         |  23 +-
>  drivers/net/wireless/ath/ath12k/pci.h         |   4 +-
>  drivers/net/wireless/ath/ath12k/peer.c        |   8 +-
>  drivers/net/wireless/ath/ath12k/testmode.c    |   3 +-
>  drivers/net/wireless/ath/ath12k/wifi7/ahb.c   |   4 +
>  drivers/net/wireless/ath/ath12k/wifi7/core.c  |  24 ++
>  drivers/net/wireless/ath/ath12k/wifi7/core.h  |  11 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  40 ++-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   9 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  88 +++--
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  29 +-
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  62 ++++
>  drivers/net/wireless/ath/ath12k/wifi7/pci.c   |   4 +
>  drivers/net/wireless/ath/ath12k/wmi.c         |   5 +-
>  drivers/net/wireless/ath/ath12k/wmi.h         |   5 +-
>  drivers/net/wireless/ath/ath12k/wow.c         |   5 +-
>  31 files changed, 845 insertions(+), 340 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h
> 
> 
> base-commit: 972f34d54015a4a16aa9e6a081bafabb6f9bf95c

with the two nits in patch 6/6 addressed ...

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>



