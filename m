Return-Path: <linux-wireless+bounces-20558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F827A68BA6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E327A5EA9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B835254AF7;
	Wed, 19 Mar 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lp0MyyfV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C0254AE9
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383890; cv=none; b=S4ty0PE920aijAMv5CqTrf3lUQjNkuBu4D/Bd02f3prkDQCESsfy8Y2Mmhk3KHir/6+KnqNro9aHYrr/hrliTVmVI6mM4/u6VCJU/ACrutFAnuIc+ozHYylIeypNHdLGIPEVc3qZbLg7/p6xtCdF2AK+hh2kMjq9bjfe+cw3AsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383890; c=relaxed/simple;
	bh=miPNwNamxQnwll9Jxfko9krCAsFl9p+itypX6gJKU5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi97Te59k5B02JJ+eC09nI+j+Kzf97mNHm30saF2SBwGwaj/sBx6Egm5PRZBUsIKCY3lCk7tvuZU9ZgjwsB6edB1L5DRaGh/YUlfELm9B1SHJmhLqcwdYpL4/J+Ys2Kqfs30ALc7OEBF88/Hk2TfUgn4yMzEsiNtpYMulHviPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lp0MyyfV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lpo6004545
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 11:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KpWWS4rtujK1n/xo8nEaDZVAURyLPCgq6nUafEBKolE=; b=lp0MyyfVfGy8z0YJ
	vL04sg/ByWLmFfW3eDFjBpbnqMvq7Lz3LPhuHyRGy2O82tMBNX1P/szo9vhmCGmD
	LTAqG2Q6oaRMwgCubYd+1In/M5GSo8A+juxjf3WcVl1FcMb4iD+dW+e1MmWtEIDk
	suh+6o6JQI3NpVYMetczxlU+94duPlqi5AlfjoWNRW7lpHVKwIOTDsjJ0EMWEzV8
	nXrCyQ3+sv/Uh6R8tJb2R7DCm6oiS1sCuJkpsDqpNxNfLDmzAIhDcfg+MQMPVE5n
	eP+mwnN21BMMZK27ZGATSEtFSGdsps4kBrItvYQa5Vh3GvLP7b2oi+a2PmKyNPsC
	R9ZE9A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwx52t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 11:31:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f184b916so196632066d6.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 04:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383886; x=1742988686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpWWS4rtujK1n/xo8nEaDZVAURyLPCgq6nUafEBKolE=;
        b=M9+jgOSOcldCFbFjIlgJWGrHhWrj6SQi4DrIOVkZf7PcasRjrPlaBwI2nHr3RA7HiJ
         RBKAM4ghZ5HryGSQpnyNxAVMvgynPxGaIiW3K54qZKoaKIhyiEktCIW5JdY34BpG7/WC
         xSvlAZeMvw1/2nyZayZFr2qIIlWpZ4GIEmm0mb1RELd79XNxtXzO0rMXVc3HDcgHngle
         IvkFUnqrmRtiSUegYfyiQFWGWo7TgM7PrftvT4JTRMg/QxAILwB07X+xCk0izVSiX4mj
         SALONETDX9W1DJR6x+8JCqR8sFAzY+dDH6/XdHJGo1SqLCHuDoqXkx4NP3voOpzTxncI
         CFyw==
X-Forwarded-Encrypted: i=1; AJvYcCWB8pFH5qiwgRfqQAwUqtDs94JRjk+MMT3dg5ZWUhDlzU91brPVDi8ok0PtNNg4IOaZ91W7hpptQq/ntvt3dA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mRo6BiU79P0+NccMB8guAsYZPTt7l+VkkJs8YsXbM4197K26
	qMzGvVrs0ZYbulW7adJ2WBc+0kuPIYUs2dJZKN78rbN34PQPhoTkcZO4wOXO+mmx3Z3fpD3s2Uu
	clbZvvru5WGN2ndyV7BGGkfzePF2XN7HkfKkadYnWQeqJxpekC3dUhklDkcwZp+KUHw==
X-Gm-Gg: ASbGncvdh13TBS3PxJuJ40jJG1ve0dwrs24txL1/wH6CKRVK8omM8P2b0Mn3FJbZ2kA
	5BIx0PjONWvTuPwMunxPSkL9acKERbtQvFkEFFCLANTVyQeUMkGMXnqz6nVCyWwwLDhtS+wnlbw
	jEDrlZPtizv/3BqA1S9JHDmObMoa1UcCpz3NCPqgdLhCeVvejLlJd9xLVM/osbcsVj6bsFf9ZNM
	0e/IgNucEKAVUV4pD3tkViBX0utUdb4uHocxXf4J4fe9vK8b9E53Uvm0Y3CklA7T+B2VNO3E280
	ky1NaK6qGFBsuRSe9OcYMQW+zpWfIogxoF8GTzoEiRRvr15mPofOfrVIJ7BqeihK5xi0pZ/ApKH
	/h+E=
X-Received: by 2002:ad4:5be4:0:b0:6e4:2e12:3a0c with SMTP id 6a1803df08f44-6eb2949600amr32213066d6.39.1742383886265;
        Wed, 19 Mar 2025 04:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7/Y6VInAkBnON3Epc11JfY+SkSvLQjl2R0CfSZ7JEcJWOHWNKrGQiyeneFTelehZyZCM5kA==
X-Received: by 2002:ad4:5be4:0:b0:6e4:2e12:3a0c with SMTP id 6a1803df08f44-6eb2949600amr32212736d6.39.1742383885904;
        Wed, 19 Mar 2025 04:31:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d270csm22789301fa.8.2025.03.19.04.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:31:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:31:23 +0200
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
Message-ID: <xu2gugtf67b46cxn3jnbwgxmukhh7r6bcvsxdodpg7tdecdurk@ct5nk7ohs6xs>
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
X-Proofpoint-ORIG-GUID: DfxBjEYdbc7X_bMiQD79ouep4sM8o9Je
X-Authority-Analysis: v=2.4 cv=INICChvG c=1 sm=1 tr=0 ts=67daab0f cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=fqUNt6dOXZUB1Xd34j0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DfxBjEYdbc7X_bMiQD79ouep4sM8o9Je
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190080

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
> 
> > 
> > Generally we only support upstrmea driver + upstream FW.
> 
> In this case, change the driver to only support those exact firmware versions,
> or print a warning in case we try to load a non-mainline-supported firmware.
> 
> But if you did read the commit message, the commit 46d16f7e1d14 is bogus, the
> single_chip_mlo_supp should be set to true to keep the driver behavior prior
> of commit 46d16f7e1d14. It happens to trigger the crash with this firmware,
> but the code behavior was changed by commit 46d16f7e1d14, which should be fixed.

Now to the change itself. I have checked the referened commit. It's
behaviour doesn't match commit message. It tells: "For the WCN7850
family of chipsets, since the event is not supported, assumption is made
that single chip MLO is supported.", however the contents of the commit
doesn't match this. As such, I'd support the patch, it looks corect to
me, despite being used with the non-supported firmware.

> This is the whole point of this patch, fix a regression on the mainline tree
> for existing users.

-- 
With best wishes
Dmitry

