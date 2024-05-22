Return-Path: <linux-wireless+bounces-7967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443418CC92F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 00:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F321C21376
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 22:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E651487E8;
	Wed, 22 May 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="So9qYnAJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5943147;
	Wed, 22 May 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418103; cv=none; b=iIZ5NxEdIoyNwIVgFl8Idr7MRenY561D0HreVmPMTSi5ob8hIu3HHclo9d65dCjEyrsfhP242c5dPhBnXsAYktldYGUOHdC7GCB/ZtRSl5bA35Onvt3stVw1X3u9wz4G6nSe6EOlnvm9dgMp9KJja7yCJaIUZdaR6kD/NHfuCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418103; c=relaxed/simple;
	bh=Q7AOVt4S3YTvLLMTVjuhbRLaDJ2/BYT450UoDN+ynHA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTR4d5JTPsnC7NDanziGGfAyD7kw/C8frW31zRKOvEsHEsOyth72TKl/C4YlH15LZXJLiBaJrWq6aSM3ZAjLg3jY0dvca8g90eU5Hb+k/obiXXNrfSgyQnsluTztLH0/bZMdqWzRSkyRZZ52HR9+v9Gp+FzjzlQXpdor/MRMMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=So9qYnAJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MC54HT016423;
	Wed, 22 May 2024 22:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=wVZZk2nJL2CSRX5wqlOsi
	2I9R2Fqp1NUECQy71UCZJk=; b=So9qYnAJypGQRcFVOE+JolI4XVpuh5mZWe8O6
	IwLu0+kDoNK2QL4Cp3SSgUfcT7buoAQsmmnlfDvuwyGWqlsEZ62fAeymMlF6P7kb
	F92WvtesRHOfZa1OMmw4i0FOJBOX/o0AUDuLoA/t7l/6vxRrUUn3Uf9l7PPuUfZp
	HZMizILsNlhwt0N5nG8EbTmRTJ8uorGb/Uw7TT2N1ONfdEmWWJX/mJw9/wTufsHi
	1uRpl5W6xDTImY/wuaiXxu5+vg2qTzZN2ITqoISHpJd8YJuKiQrfIqjN1bHAXkED
	oVJrVY0J/0OsSz8Xf/nbixGKbTtUgj2iLlYT1m6Gy0434y8zw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gj6x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 22:48:04 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44MMm1n7032193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 22:48:01 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 15:48:01 -0700
Date: Wed, 22 May 2024 15:48:00 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Kalle Valo <kvalo@kernel.org>, <neil.armstrong@linaro.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <wcn36xx@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] soc: qcom: add firmware name helper
Message-ID: <Zk52IHqAfOnVDm50@hu-bjorande-lv.qualcomm.com>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
 <a45b53f3-b2a5-4094-af5a-1281e0f94d2f@linaro.org>
 <CAA8EJprxYsoug0ipRHTmX45vaFLzJCUF0dQWOc=QLs4y6uZ1rA@mail.gmail.com>
 <878r03csxn.fsf@kernel.org>
 <CAA8EJpqkgpCb57DGka0ckbPz=2YiaHzxmiNzG39ad5y6smgO5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqkgpCb57DGka0ckbPz=2YiaHzxmiNzG39ad5y6smgO5A@mail.gmail.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ec0OrfEXBm9WUFIjYdi3lyRS60ub_eX8
X-Proofpoint-ORIG-GUID: Ec0OrfEXBm9WUFIjYdi3lyRS60ub_eX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_12,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=939
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220159

On Tue, May 21, 2024 at 03:08:31PM +0200, Dmitry Baryshkov wrote:
> On Tue, 21 May 2024 at 13:20, Kalle Valo <kvalo@kernel.org> wrote:
> >
> > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> >
> > > On Tue, 21 May 2024 at 12:52, <neil.armstrong@linaro.org> wrote:
> > >>
> > >> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> > >> > Qualcomm platforms have different sets of the firmware files, which
> > >> > differ from platform to platform (and from board to board, due to the
> > >> > embedded signatures). Rather than listing all the firmware files,
> > >> > including full paths, in the DT, provide a way to determine firmware
> > >> > path based on the root DT node compatible.
> > >>
> > >> Ok this looks quite over-engineered but necessary to handle the legacy,
> > >> but I really think we should add a way to look for a board-specific path
> > >> first and fallback to those SoC specific paths.
> > >
> > > Again, CONFIG_FW_LOADER_USER_HELPER => delays.
> >
> > To me this also looks like very over-engineered, can you elaborate more
> > why this is needed? Concrete examples would help to understand better.
> 
> Sure. During the meeting last week Arnd suggested evaluating if we can
> drop firmware-name from the board DT files. Several reasons for that:
> - DT should describe the hardware, not the Linux-firmware locations
> - having firmware name in DT complicates updating the tree to use
> different firmware API (think of mbn vs mdt vs any other format)
> - If the DT gets supplied by the vendor (e.g. for
> SystemReady-certified devices), there should be a sync between the
> vendor's DT, linux kernel and the rootfs. Dropping firmware names from
> DT solves that by removing one piece of the equation
> 
> Now for the complexity of the solution. Each SoC family has their own
> firmware set. This includes firmware for the DSPs, for modem, WiFi
> bits, GPU shader, etc.
> For the development boards these devices are signed by the testing key
> and the actual signature is not validated against the root of trust
> certificate.
> For the end-user devices the signature is actually validated against
> the bits fused to the SoC during manufacturing process. CA certificate
> (and thus the fuses) differ from vendor to vendor (and from the device
> to device)
> 
> Not all of the firmware files are a part of the public linux-firmware
> tree. However we need to support the rootfs bundled with the firmware
> for different platforms (both public and vendor). The non-signed files
> come from the Adreno GPU and can be shared between platforms. All
> other files are SoC-specific and in some cases device-specific.
> 
> So for example the SDM845 db845c (open device) loads following firmware files:
> Not signed:
> - qcom/a630_sqe.fw
> - qcom/a630_gmu.bin
> 
> Signed, will work for any non-secured sdm845 device:
> - qcom/sdm845/a630_zap.mbn
> - qcom/sdm845/adsp.mbn
> - qcom/sdm845/cdsp.mbn
> - qcom/sdm485/mba.mbn
> - qcom/sdm845/modem.mbn
> - qcom/sdm845/wlanmdsp.mbn (loaded via TQFTP)
> - qcom/venus-5.2/venus.mbn
> 
> Signed, works only for DB845c.
> - qcom/sdm845/Thundercomm/db845c/slpi.mbn
> 
> In comparison, the SDM845 Pixel-3 phone (aka blueline) should load the
> following firmware files:
> - qcom/a630_sqe.fw (the same, non-signed file)
> - qcom/a630_gmu.bin (the same, non-signed file)
> - qcom/sdm845/Google/blueline/a630_zap.mbn

How do you get from "a630_zap.mbn" to this? By extending the lookup
table for every target, or what am I missing?

Regards,
Bjorn

> - qcom/sdm845/Google/blueline/adsp.mbn
> - qcom/sdm845/Google/blueline/cdsp.mbn
> - qcom/sdm845/Google/blueline/ipa_fws.mbn
> - qcom/sdm845/Google/blueline/mba.mbn
> - qcom/sdm845/Google/blueline/modem.mbn
> - qcom/sdm845/Google/blueline/venus.mbn
> - qcom/sdm845/Google/blueline/wlanmdsp.mbn
> - qcom/sdm845/Google/blueline/slpi.mbn
> 
> The Lenovo Yoga C630 WoS laptop (SDM850 is a variant of SDM845) uses
> another set of files:
> - qcom/a630_sqe.fw (the same, non-signed file)
> - qcom/a630_gmu.bin (the same, non-signed file)
> - qcom/sdm850/LENOVO/81JL/qcdxkmsuc850.mbn
> - qcom/sdm850/LENOVO/81JL/qcadsp850.mbn
> - qcom/sdm850/LENOVO/81JL/qccdsp850.mbn
> - qcom/sdm850/LENOVO/81JL/ipa_fws.elf
> - qcom/sdm850/LENOVO/81JL/qcdsp1v2850.mbn
> - qcom/sdm850/LENOVO/81JL/qcdsp2850.mbn
> - qcom/sdm850/LENOVO/81JL/qcvss850.mbn
> - qcom/sdm850/LENOVO/81JL/wlanmdsp.mbn
> - qcom/sdm850/LENOVO/81JL/qcslpi850.mbn
> 
> If we look at one of the recent platforms, e.g. SM8650-QRD, this list
> also grows up:
> - qcom/gen70900_sqe.fw (generic, non-signed)
> - qcom/gmu_gen70900.bin (generic, non-signed)
> - qcom/sm8650/gen70900_zap.mbn
> - qcom/sm8650/adsp.mbn
> - qcom/sm8650/adsp_dtb.mbn
> - qcom/sm8650/cdsp.mbn
> - qcom/sm8650/cdsp_dtb.mbn
> - qcom/sm8650/ipa_fws.mbn
> - qcom/sm8650/modem.mbn
> - qcom/sm8650/modem_dtb.mbn
> - qcom/sm8650/vpu33_4v.mbn (or maybe qcom/vpu-33/vpu_4v.mbn)
> 
> -- 
> With best wishes
> Dmitry
> 
> 
> 
> 
> 
> 
> 
> 
> 

