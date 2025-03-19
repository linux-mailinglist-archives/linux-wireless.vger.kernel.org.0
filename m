Return-Path: <linux-wireless+bounces-20545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D2A68943
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C6A174BAA
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE78A25333A;
	Wed, 19 Mar 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELFSXtSy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528D250C0C
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379510; cv=none; b=X6lycvEb9PmoqmW52peYdYKt7qBKFXxphHHHt9gqrijLyx2XdUkIY0WtG12YnAzKNu4U474fbExxBma2M9rfHmlSfJgA6TZcpPcMlTM8CsUjTziMp7eebS2HZo/WEscxzqg9JrVSkm+PeIlAYcTJF7S/fMAqqZDlaq/mqoh7dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379510; c=relaxed/simple;
	bh=fjjazMyM+9OhKz4+XIpx0RxbJw3Yq8alW4cnwa0N404=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vACqasLcDHjj1quG4FA8XVcds0s5a3znsuyPxJPVBbywEyBe5a+2/eX6Bot+mXaUWmKZinstoCEQH3tLr02tWdu/eBU+WIWhDBA4N1N+fx5OV+xIdqeHIR9PKs6XZyGmb87s4oSGFj+iySlTw8gCegvfjCWyGY24SsoWOBzZQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELFSXtSy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lpo1002066
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 10:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g6Y5lGGI4q46cK715gNBMUsF0BQOg3wunktc3lR3ua4=; b=ELFSXtSyaN/qTi23
	Fhv+k/KK9cS4TjDLtwnfEq24IQj+ATJ8Ow+nWodLirGL44stpHKmmxfu1fx0J8xF
	DFA2hGVmqK09sfW/qpy2dJ6QPJVlqg93fhdEDUL55Vs5LTL8fgaFpi7cQu1oDfvR
	Gys8EC06dIOeD5InvWgvSnl3G2kr9UQJ+uBtNhovEY8cMS2gkOeuqk9JFKurgL+X
	Qb5ptnMfRTST6k7Vc7vXr3qumy62xHXlsr5FCoIhoq3xxh497CBVEzOMu4ETcfk+
	0/8eCDS6ER3+IVnS+By6mtAVMj0DiP/PvuNM2dwAazBS1cpK6l4otHRG4m8dxQA2
	UbP9SA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmbwhak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 10:18:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4767bab171dso65245751cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 03:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379507; x=1742984307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Y5lGGI4q46cK715gNBMUsF0BQOg3wunktc3lR3ua4=;
        b=uwmWtMf4W92ZerY1YX2IfRc2wIMWpYAbOQMM64Y3PXUNnob1M6kBtaL/Gxjt4rZCzb
         4J3st+5SNGPPcpt7onvdr0dca7WTYz0R+fhsHakc7iTOAF0Kh5CI8VmnoBDtodFFiO79
         62KHVdxLSWyiKux2lvar95wG5YjPToiD51NMJkwC55Q1TKlEhoMxukzcLcwhuFz7nQti
         xsX91t0C4DAuwN5q8sZK/tjkVpjtmrMbP/oS8NoulX9SBDqucbGJFOoWwFzYPINZI/Ju
         f11beNIIDP+CeuHa7kBOVnUXiZgc8D/KcUmag1QQyjyFIF8msjaBNLAOmfE/M6ePf4ar
         +aZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCByn+KJKnOsuB0T99fQ31J8mcrti8yRfU78iMuBRjhY4+QOahygzO1DSa7buUyhnkf4YApBQxgqfZ7EVufQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDwgcRpjtofdoJiVGd54wnuCk5gvVpMHQ5S7lwCkkd26hGQAI
	azM8DtSyiSuSM71QNBI273F29eGZza7ji6Ytc1wxQx7P5FxOmBmfyV73YBoJ47p0KxI506Sc0xv
	Su8IkNotJU6o2soxtXgOQ7uBEKlwthn6r1yusplCW4p0pBpcHI+ejGBb+LtyOY2N8Bw==
X-Gm-Gg: ASbGncuFYfD0UPWiZCeFVl1/f+7uKhPfRhiz859l/nm009oo+UqMurfwBVGjyNfTC+c
	WEPb9w3CC86VDIxL/ygAWR7dMSMYn2LfoAxUCcORpSRXlEydt9aMdaZvx1NpM1rYsfFf36F4A7G
	pGssozV244CIduk5WVJqSDllMqNRV5X52SSH+mCtkpfiYDJMg6w7UEZj0OVgPloQJqg/a/KcU3G
	8uEgNTIiA0Rq/tr+NwwAMgeAp8IdOrX2JwlFi0wCmKh/NJYjfBgMx4j+bDAsHFWdkL6YJ8nmy3R
	UXdlIpAh0VcndcitSpTWFi2cNJ98m2kNY7c/S7b4/0Yd8cgSYf/cksfA38G051e19D0mtcExwJm
	bM/o=
X-Received: by 2002:a05:6214:246b:b0:6e8:955b:141e with SMTP id 6a1803df08f44-6eb29394c4bmr29894916d6.21.1742379507125;
        Wed, 19 Mar 2025 03:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqGB3tXFnX9eFbTzML8EPlNjeAQVUX+G6oWctw4G+pdkokTJUMuoaQB1gAhPBzKRoofBi5IA==
X-Received: by 2002:a05:6214:246b:b0:6e8:955b:141e with SMTP id 6a1803df08f44-6eb29394c4bmr29894616d6.21.1742379506730;
        Wed, 19 Mar 2025 03:18:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a8bf7sm1896139e87.223.2025.03.19.03.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:18:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:18:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: neil.armstrong@linaro.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
Message-ID: <4pidr33bvbtykyufw35ubfr7mut2ypqmoiydgjlcsyxolqteze@j2xhigdoxqhp>
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <a5ebfdfb-107f-407f-b557-522b074c904f@linaro.org>
 <38cd738c-1a2a-4382-80f8-d57feb7c829d@quicinc.com>
 <6717d816-02b3-4d27-848b-620398808076@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6717d816-02b3-4d27-848b-620398808076@linaro.org>
X-Proofpoint-ORIG-GUID: _SRm7GONYg57NE0WzBvhdfyXvAxk4Dve
X-Proofpoint-GUID: _SRm7GONYg57NE0WzBvhdfyXvAxk4Dve
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67da99f3 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=Ta77wq_4RykSGFGVYMQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190071

On Wed, Mar 19, 2025 at 11:00:34AM +0100, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 19/03/2025 10:46, Baochen Qiang wrote:
> > 
> > 
> > On 3/19/2025 5:12 PM, neil.armstrong@linaro.org wrote:
> > > Hi,
> > > 
> > > On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
> > > > 
> > > > 
> > > > On 3/19/2025 1:34 PM, Neil Armstrong wrote:
> > > > > On 18/03/2025 17:35, Jeff Johnson wrote:
> > > > > > On 3/3/2025 7:00 AM, Neil Armstrong wrote:
> > > > > > > In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
> > > > > > > single_chip_mlo_supp")
> > > > > > > the line:
> > > > > > >      ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
> > > > > > > was incorrectly updated to:
> > > > > > >      ab->single_chip_mlo_supp = false;
> > > > > > > leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
> > > > > > > 
> > > > > > > The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
> > > > > > > crashes on driver initialization with:
> > > > > > >    ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
> > > > > > >    ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35
> > > > > > > fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-
> > > > > > > QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> > 
> > this FW version is not upstream yet, why are you testing with it?
> 
> I was not aware the driver supported only a small subset of firmwares.

Yes, this has been communicated by Kalle (and now by Jeff) for ages:
using any firmware outside of linux-firmware is not supported, unless
you have been explicitly told to use a particular binary. Firmware
coming from the Android / Mobile might use different knobs and have
different expectations regarding driver behaviour.

-- 
With best wishes
Dmitry

