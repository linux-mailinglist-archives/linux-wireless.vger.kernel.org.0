Return-Path: <linux-wireless+bounces-22005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09FEA9B02D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 16:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C65A4D14
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A717A316;
	Thu, 24 Apr 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nwnUJDqW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194718CBE1
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503744; cv=none; b=eWSTP//ZcdBbif9nieYX/vhW8PENLuBwOFe9GQdfkguRoDKacNt5/3LvqLatKpa8yI+NnBaBXhtFTrYdZRvuZ62iTgJThahSOf7GanikYpgjhJW9oCuPUTHFMqeBK3yBAk9D5O+nYmlJ58mVQt4aCGt6x1XtN5WDOCPwo6YCZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503744; c=relaxed/simple;
	bh=JcCpsxuUp0ralhLc8W1kuW6UVifYp2YCCK0lnPqzCmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xiv5pQzjs2eK1X90vLx70l2P9FubNAjWtHdRRKlJQBxjgA0xTF4xLW21ddlwYc6AHwXhrfsnv0k3HgTaictc5n7wspc6eXglQBZv6zYepb6vXL/P9hp82f0U3SfrWs8rEdsSDbjxmgaLj+q6BhVtuNYLlaGMQXAos/pxS8doNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nwnUJDqW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OC3Pad013231
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 14:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HwIniLDOmXdB4HFP1nlmjOgcHAoV2syQICs3/r7G9h0=; b=nwnUJDqWPWOdATjt
	ySzLpJS6fn6nQ52QFJ75ozmTLQ1vNNcOHFe2/9dK1K9sSjCuk5OmQFo47Lt3MmHm
	0VrdS+RbiimfFO/Ve28owVraMUVpXn7y/FhMhDnMxNnIpz0LUQbFFIViXqBuYsf+
	xd6JDpXskS3C3otSF+SnE6x3EnhCCrqKpBR0quKN2X/Ut9cYn92TfgxavnTWFF++
	5MNFlgFnvrBI4+JEBN3idow8D3kO359pcIwpMDXzUfv/D3VXtsEXHYyeyE2yC/KJ
	x5fZ+7BbNPvBXkwVvzxtcm8lAFQ3066j5kbPBntt5wX51QshP/eVzdCAsfQrzYac
	txATSQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh05u9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 14:09:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b078af4b07dso633254a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 07:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503740; x=1746108540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwIniLDOmXdB4HFP1nlmjOgcHAoV2syQICs3/r7G9h0=;
        b=Mh7OKJ+3JqIHRoJMAIHnOOkaBmCKbB93ZkXP81o+ERrPKpKZPsnTTAfM//uGl9JB1n
         fmXXxoMWwGViC3tUPpGLsjtIj36aA9DybddBQZstsFQS4AhXMS0Wb8wDInvT9aUoyONe
         ngwXDMM/JMda6wh6GeRw+kti4oAgL0EsEItUHLPbf4ukf6WHkCJ01rWx8mdz6Q0LCo4y
         L7TVwK58p5j3ez1KqO4c7mv/dyqeOwqO/GM1KkhMeab8RYWEz8ZPcJYBCqrXPKoWnlXg
         fbuMQPKUeXfccwL3cbBP6lWyASPzdmiepjGCLmZ5mtRFZ0nnRl5yKUIXxjreA3jR3Ftd
         NYug==
X-Gm-Message-State: AOJu0YwSQC47y+qcDZtf0C+8O6DUpdzhOC+zCkAd9q4TeN27xXElU4m1
	XFzsVUHrG01tGovXHSh0SBStq0VN4ljhC1aP/bxSwuaZUaSW3I0V/tN10ZxtfnyQ1W21Er5RMJj
	WmvweFr5rrUbMmlTmMW6Nu83ZISSYG4yfL0tx6DbSR/uIROxpbSTswfUvflTKmZRD9w==
X-Gm-Gg: ASbGnct+kiYJKFnk3m9VRr5tgB5ep9Hq3nZfn2NVoCWG22ib0ZlUt5WY0qi7djlRnF/
	trm9ZRo04xOku4+/qkmcYccnoykr3cxxWHMXz5Dvu+ycKvn0Zc6l7CyOJjaJV06JVGdBwyDpBtY
	ntgSe6TfZP73YBPEYPv7jDtoTSfXpupuLv9IAGm90pM1jbzPNJe8MKu5krW0VFbiorUzta2Vm6F
	MkuMRaBHUcoWFfiYCFC5XpIZuQ19wzP8wak8WIRA/87yDrjxpt+dOFOFXx+H/2WgyTDavlCBJ4D
	Ac8bLz8C6W9ZO8AO2wF97MjbzEu4XsScthpkZsVdfOEMUV7F/KlsU7+qT8SG10aZuOCGqC5PwpJ
	jQknw
X-Received: by 2002:a05:6a20:d50c:b0:1f5:7d57:8309 with SMTP id adf61e73a8af0-20444f089b8mr3593087637.21.1745503740522;
        Thu, 24 Apr 2025 07:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYUAeajIB0jdH2f5aDrV3SkJUkmeeYgbA/prjSE15XVhCi/dQWNidKZ7igvy3slS+uYDvmug==
X-Received: by 2002:a05:6a20:d50c:b0:1f5:7d57:8309 with SMTP id adf61e73a8af0-20444f089b8mr3593045637.21.1745503740076;
        Thu, 24 Apr 2025 07:09:00 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e259134casm1470698b3a.11.2025.04.24.07.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:08:59 -0700 (PDT)
Message-ID: <d2e6a1e9-7831-4342-9458-4628f9cf7182@oss.qualcomm.com>
Date: Thu, 24 Apr 2025 07:08:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Prevent multicast duplication for
 dynamic VLAN
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250310230105.3534334-1-muna.sinada@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250310230105.3534334-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5NSBTYWx0ZWRfX4tM137WlbyAC UV+4dAkQFLk2AAmY0ruYWbEzJt2+IZ81iktvko8h7OE7m0/QkrAgLbI/ARwGd1gufeIN/XKAu+P 3i0Dc/oPDl1k+mSKzFVmKtZvHus1vRZDd5SNg4DRPxfCKNEdO1aVd70HDI4fD6LH6WATBW6DDDC
 b+UBhd3c6Cyu02IYsGZj7m9xjDL7S9oZWw3j81WnLG8zJiT6ArMA62vl/cKAHNL5riOsUYq132l X/cI+IKtfnOx0gE76eRjfe5NzF67mrPBBZC7RqrojerOMbdyUH34PgDGMIPP+bKbIH8vkFCOUA1 sPMsYcXnNu4/tPZCdgGJwfLC2C2cMhuoG84M030e1bDc3mI1ADUlNpOI7RZp3rHJ9kjPs7A78un
 5w/I3ildUUv8hbVDWbiCTZFXSRfJaqbjpITuEv1vUf31tbbcU1pzRXIMoRMLOHXf2JcBl/rF
X-Proofpoint-GUID: jlE_apDZNdDSXBI1qeBFnPbfTVYJ-tCq
X-Authority-Analysis: v=2.4 cv=ZuTtK87G c=1 sm=1 tr=0 ts=680a45fd cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=zGDnsRbxjYQ8UK2HgisA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: jlE_apDZNdDSXBI1qeBFnPbfTVYJ-tCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=540 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240095

On 3/10/2025 4:01 PM, Muna Sinada wrote:
> Since dynamic VLAN traffic is software encrypted and encapsulated,
> mac80211 handles the duplication on each link for MLO dynamic VLAN
> multicast.
> 
> Currently in mac Tx op, all multicast frames are duplicated and are

Let's s/mac Tx op/ath12k_mac_op_tx()/ to be very specific where this is happening.

> assigned a mcbc_gsn. This is causing dynamic VLAN multicast traffic
> to be dropped in HW.

preference is to s/HW/hardware/

> 
> Prevent dynamic VLAN multicast traffic from being duplicated again in
> the driver. Check if incoming packet is a dynamic VLAN packet and
> avoid defaulting to multicast conditional.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>

Don't spin a new version just to address those comments.

I can make them when I put the patch in the 'pending' branch if there are no
further review comments.

/jeff


