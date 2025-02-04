Return-Path: <linux-wireless+bounces-18351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63EBA26ADD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53006188696B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A315E5D4;
	Tue,  4 Feb 2025 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lYRwOqxg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5615DBBA
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641453; cv=none; b=GjX48jAyxKwbTl6uKuJhF0Uo/c9xOwxXcuIZZQkj2hVh3qrACIWwc8fgw5qq3TqafdhubjQYHMqYVYK3GZUNEhLwMsYb8WxrDUjGGu84tKcyoEZa4gRpZw84eALUOGaGig66pZMZXeNGJSR1axhyz8QNvN2hvV1SugUmdOxs+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641453; c=relaxed/simple;
	bh=N7SJ6M+LdXySo9Yp2HEi0TJ9biENoLWEwGo+FGYS+n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rp0TwmMo2vHIR0f6NstqnoS/VcvueYUXi2zvMCglENFK3Kts8t/91ms+NstpNgFpQrQXOFekGwlt+Hq1zYimHjeAkH/xZRvarzHu952L3WsZRPtdHLuuUDJAlad8HZvCmYQPqypvIF2p1abmJNiN6OLGWSj1J3yu6SaIZBBQjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lYRwOqxg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141afYI003947
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 03:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t+KGWqYwPwPCLRgkUh3lwN3keaTQlo7zjqys5L4okcE=; b=lYRwOqxgi9vYGTE3
	AzprnwZYXS0IMnQekp5oobOm83G6NJe9Al2HCK9r6E3KDBaGDUiQwO6BV9m59mKQ
	7IBsS2CBzWlv7QzETjCbiRsZAWTGtSzCeRu3CagOc+fglXhyDjJoH5o6fxmvCvZp
	jj0pOlaM63Uqw96t8IKcF9byajA8CNCUZeXT+c3FFrprhpjJdJVY+Do/gxYaWpcu
	kZs1QF0otwjKmMVivyUBt7t0yb3VZrSNYi76WLxncFtNv0Md50fC+LGhSpu9Cjsv
	t/ytcG1C4WUemn3ezeeCjAnZGkVrPi+DVJrsHLYQCxoZU3lj4OI4r0nD3JD3uIt+
	IKCoMw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k9cn077w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 03:57:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so9614975a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 19:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641450; x=1739246250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+KGWqYwPwPCLRgkUh3lwN3keaTQlo7zjqys5L4okcE=;
        b=PXPTKm/3E7gNtBr64PT0+Ky+n4YbOJxnMQ/CcyN4j08lJIsO6z+40KsQIBruZsnVMZ
         z6pTIAlNWgNFmlmXu8XgiyxRvFxKy05yUFA+lnByQAXvNl072PMoT9jc0TZOsMhiWF3s
         4EZW1GEOoQZz23RA6OG0M3tdmjx4AV6jsrypPkG/ljgjU0MQ6PUtRHV+i4TZ7KMtnj3e
         jDLKuvd1Piw6g+4J2B0B69iFZgryX1x8NRnB3x+Q3Bz6knd7w7OUHB/MxeQcbzPf4Xby
         UpnrCUhhE9NuqVY4xxhIgreiIEy1wfWRUtClhW4BNBoA68CdQf/DQGYPkX+GfBDpUxqm
         yLLg==
X-Gm-Message-State: AOJu0Yzp58Mkrnhk0zsJmKQ1NiWXCHDzJ8iu8X3BilgCkkAS6ndIpEJU
	rEIUdWV5AIAH3kMzv5a1Ha1R82Ii920mVxp4KCH7REB2/iQG8yBBuTETM0gYLRdGIpn00ylyJNp
	/f54/vRjyzSZEa+OPVz95cT4/br4cpG0dpIxK6U+esvQO86sbZWgoo3vLdZOgTS4FNA==
X-Gm-Gg: ASbGnctzypscOaTKKUwWipSt89rBEdxdaJ0hqMtN4BzwXNbKU3ZuFAyanhoWdkl2ZQp
	lkVja09QDHe2lzsKJsKL8PVLwbq1I9vjpBvO9X+fOfe0PvV7wWQIgbSdQX3TVTFKzjAApjnoiVe
	OpyvGrFWQ88qxDQ324+rlZjpJNHLj7pYhllev6qlPcTBGXlKL5zYUoz+vhSOHZsUJR6BLFIoeZm
	PS5X8TkCxI5wxGFPG6rIokSi8QC7mHycnY74WC/l76ao47F9Vqmm94s5TNExbz9BMKdSiR6Y12e
	UQ3PCrbAo3MTdHsfjPAk5tTJnzUW1R9jyLpwb3U=
X-Received: by 2002:a17:90b:1350:b0:2ee:889b:b11e with SMTP id 98e67ed59e1d1-2f83acb06b2mr35467301a91.30.1738641450283;
        Mon, 03 Feb 2025 19:57:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy/RemzBKRYM7fWRAW7wLw6O3yXVdLv/cZA2LIgDtkrJ/UFQhAjEgAqUMNBkcw/haPZTnmkg==
X-Received: by 2002:a17:90b:1350:b0:2ee:889b:b11e with SMTP id 98e67ed59e1d1-2f83acb06b2mr35467273a91.30.1738641449814;
        Mon, 03 Feb 2025 19:57:29 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bfbdba2sm12261376a91.40.2025.02.03.19.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 19:57:29 -0800 (PST)
Message-ID: <fd7508c0-e12a-4db1-b443-dd4c12ef41aa@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 09:27:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] wifi: ath12k: Add support for MLO Multicast
 handling in driver
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
 <20250203212647.2694566-3-quic_bmahalin@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250203212647.2694566-3-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: enV_auxNOVD6nAzcCEDIkKn-DYBlA8y_
X-Proofpoint-ORIG-GUID: enV_auxNOVD6nAzcCEDIkKn-DYBlA8y_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=609 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040029

On 2/4/25 02:56, Balamurugan Mahalingam wrote:
> For MLO netdevice, the broadcast frame should be transmitted with the
> same sequence number on all the links.
> 
> Per IEEE 802.11be-2024 section 10.3.2.14.2 "Transmitter requirements",
> An AP MLD shall use SNS11 in Table 10-5 (Transmitter sequence number
> spaces) maintained by the MLD to determine the sequence number of a
> group addressed data frame that is transmitted by an AP affiliated
> with the AP MLD so that the same group addressed Data frame
> transmitted over multiple links by the AP MLD uses the same
> sequence number for transmission on each link.
> 
> Currently the MLO multicast handling is done in the mac80211 layer.
> Enable support for handling MLO Multicast in the driver to update the
> hardware descriptors in a custom way to handle the multicast frames.
> Firmware expects the MLO multicast frames to the submitted to the
> hardware with special vdev_id (actual vdev_id + 128) to recognize it as
> a host inspected frame to avoid using the reinjected path and it also
> uses the multicast global sequence number (GSN) provided by the host
> in the HTT metadata to process and transmit it with the same sequence
> number.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam<quic_bmahalin@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


-- 
Aditya

