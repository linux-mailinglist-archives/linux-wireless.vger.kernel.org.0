Return-Path: <linux-wireless+bounces-20548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D009EA6897A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B031D3B70CF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4A253B52;
	Wed, 19 Mar 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFWaDTFq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361B21129E
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379812; cv=none; b=HJrp0sFuK1SlE3g1vAmjVfqz84hhD7BHqRG2HlZASiiN6EC/76ojTEfqjDZgNn3PijLwIJ63uL/vLYcBFnlu556P41dEmLDjNC/ojwLMi9JdoK7E4l86QBNN8S/RlE+sDYZk0r7oeikYiuGuzEbgrP4jc/TFwaIgjGim7uT8tjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379812; c=relaxed/simple;
	bh=3O2gHHqpHU6RVBQ9jkeg0ftkJEEe+8q+ut1OvSszNDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ5fxQhc7ZEr2/Qm0a+j5nB5XvbPV2v9yfndQxshsyCCozeWEwFxHxGBqNWTasXQ8RB1xQjA4poM7p8oW1tXYmBZaxtGi0Ekt+ycfYvL9RioNMmjCZtkrbWcOLn4eNAA3dF/ECVBl4HlkrJVFEnKjkLEuL43Hx32zwdr2ElHenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFWaDTFq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lqdI002134
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 10:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FbvkYFpqev3zR4mtvpBcUC20
	7wPCz5TpxzDYSvZSuRo=; b=gFWaDTFqIWcPzjjOEMtFya7SL5DioFx/8nOxN0iY
	DxPSUB2KvROBciRS1PSD7/PNS+yS1P2KNLHDtF1l4++UZbtIXiPPltB4drBo10JM
	b+JLjbI/dRqjfScNU6TLuqnu9gudowux6o1bNr0k32ljnnhzqzpp131S/VCoTE6e
	5UCx/3RVioY6wpM/fKdvjXfIUiHx2cJWg8rcTD73b3fHYS3z4s87fkfGpsjRYVsa
	yTgb29v4Af8zWFEonO6oazG16JVOHkbyCEucjG54fYBzSETsg2xXs3mgf7UBcplv
	9Rk0h8iRPdVfnD0RYJ8TrcUGNbNpu7MWMXWtZcLhF97vaw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmbwhq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 10:23:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242f3fd213so101458295ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 03:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379808; x=1742984608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbvkYFpqev3zR4mtvpBcUC207wPCz5TpxzDYSvZSuRo=;
        b=lOeDFZlTYqBsLIPydiVewZfJULdwxsMCzxthKKD4GAe+SJRT17PEzX1ukcIr32tnYy
         LgOJC0o7BWkk1m+7zkCY2whL64mwSbGqSCYghJ6cziJcie0hJhI//N7C3LSMx+q7HpzW
         T/L+TmAYAd7OsQZm2LxEDq//ovQTinq34lMkL00GRyQ/teLJa9iUJ6xYrA27ylc5R8mm
         HmM/Y+OudkdwoFK8fLYZW7aagL57+JFcic0Nnt8rBFbbmrlycsOpRtMXogkis0OaJ2aL
         YWTyXvsBbDfea28djfxHHSDQ5/8Rz2LFirj7wsG/q5Ja4Q9N3HDBInF1tHUdE6ExlqBX
         9Azg==
X-Forwarded-Encrypted: i=1; AJvYcCWjXiOBGjzIN87xYkFnIz/er+nQHrxxycqQ1n7KbamSM0YyulGb7O9Degp4TRNguEnm7XdfbmGC+iwe05LQnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBQBEMidDmDa/k5P+mVHXee9wx1LFkIwo8k/aC1igfzgRgo9I
	YepAODZXTylrtO0vGiERKVMcfi+9205TRrrISCgmba6oj47gqFqi9ns9ST1aOQSpU9zhxB4p3yN
	MHCuJFDBYl62SunrTJ0dfwIAU727UCFtxe1px9jBUDzq9kYJjjkfw6bRw9yCKjPwGi4JLIwV2DT
	AS10RWBU+IgbkuWB0Z0QwiCfy9/0e9LB0UJ3IjIWLy
X-Gm-Gg: ASbGnct86DeaaaKXNQ6iMbs4YH48eL8kmnv9RiKNoCgweQQL8buZCcXO2/NaeQiI57y
	iWslJlqzBOPV3fZ/uwbmqCkviEZfh+dHmD210hGAeQNQ95a/ZTOatwrvxQaWUBrVBRMCDDzWfoN
	ROp+qC4UXfZlw=
X-Received: by 2002:a17:903:166c:b0:224:160d:3f5b with SMTP id d9443c01a7336-22649cbb880mr30970775ad.49.1742379808224;
        Wed, 19 Mar 2025 03:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ5IO1S/i46Bu67ToV8tPzQkrYZ6vx48Ae2+DaEwRE8G4v0xNRcDqUmYlsrikLoLVDh79+3MWtYXE5aWjM1LU=
X-Received: by 2002:a17:903:166c:b0:224:160d:3f5b with SMTP id
 d9443c01a7336-22649cbb880mr30970475ad.49.1742379807863; Wed, 19 Mar 2025
 03:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com> <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com> <a5ebfdfb-107f-407f-b557-522b074c904f@linaro.org>
 <38cd738c-1a2a-4382-80f8-d57feb7c829d@quicinc.com> <6717d816-02b3-4d27-848b-620398808076@linaro.org>
 <4pidr33bvbtykyufw35ubfr7mut2ypqmoiydgjlcsyxolqteze@j2xhigdoxqhp> <42932860-dd78-4eed-b8ba-6eca1c7099ef@linaro.org>
In-Reply-To: <42932860-dd78-4eed-b8ba-6eca1c7099ef@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 12:23:15 +0200
X-Gm-Features: AQ5f1JqmByGfz39h-H891_Zdju3wuL1SK8KDux6sJpLamAM2Aa7rzwvzmoWajiY
Message-ID: <CAO9ioeUuRL6z1DmCoefNU8-Q2xQXwHVVppt6Yo7w2ko-YW8ypw@mail.gmail.com>
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
To: neil.armstrong@linaro.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: fpxCgRDV7U5wtKXdd28jEhtvLOfv8f0v
X-Proofpoint-GUID: fpxCgRDV7U5wtKXdd28jEhtvLOfv8f0v
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67da9b21 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=gvejlOHYFDooY2tF6NUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190072

On Wed, 19 Mar 2025 at 12:22, <neil.armstrong@linaro.org> wrote:
>
> On 19/03/2025 11:18, Dmitry Baryshkov wrote:
> > On Wed, Mar 19, 2025 at 11:00:34AM +0100, neil.armstrong@linaro.org wrote:
> >> Hi,
> >>
> >> On 19/03/2025 10:46, Baochen Qiang wrote:
> >>>
> >>>
> >>> On 3/19/2025 5:12 PM, neil.armstrong@linaro.org wrote:
> >>>> Hi,
> >>>>
> >>>> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
> >>>>>
> >>>>>
> >>>>> On 3/19/2025 1:34 PM, Neil Armstrong wrote:
> >>>>>> On 18/03/2025 17:35, Jeff Johnson wrote:
> >>>>>>> On 3/3/2025 7:00 AM, Neil Armstrong wrote:
> >>>>>>>> In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
> >>>>>>>> single_chip_mlo_supp")
> >>>>>>>> the line:
> >>>>>>>>       ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
> >>>>>>>> was incorrectly updated to:
> >>>>>>>>       ab->single_chip_mlo_supp = false;
> >>>>>>>> leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
> >>>>>>>>
> >>>>>>>> The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
> >>>>>>>> crashes on driver initialization with:
> >>>>>>>>     ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
> >>>>>>>>     ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35
> >>>>>>>> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-
> >>>>>>>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> >>>
> >>> this FW version is not upstream yet, why are you testing with it?
> >>
> >> I was not aware the driver supported only a small subset of firmwares.
> >
> > Yes, this has been communicated by Kalle (and now by Jeff) for ages:
> > using any firmware outside of linux-firmware is not supported, unless
> > you have been explicitly told to use a particular binary. Firmware
> > coming from the Android / Mobile might use different knobs and have
> > different expectations regarding driver behaviour.
> >
>
> The patch remain valid nevertheless, the 46d16f7e1d14 changeset remains
> bogus and needs to be fixed whatever the firmware version or ongoing work
> to fix MLO in the future.

Maybe. I'm not discussing the patch validity, I barely wanted to point
out the firmware requirements.

-- 
With best wishes
Dmitry

