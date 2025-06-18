Return-Path: <linux-wireless+bounces-24241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7286DADE66E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 11:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF25B7A11FC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDFA27EC98;
	Wed, 18 Jun 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RR+NqD8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB46202F70
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238302; cv=none; b=qOLO3hA7ziY+zDu6YZ6J7uOlwpvhBknnI5mDqGxfGJCLQrOyS3zImxz+GksVcUnPfkQQD/ZB/v4qLRbb4qJ2efOTykyF4f5AIFW7E+JtMss8kofThvZ4GGkM8zWQ4OdlI9Vs8DkEPM3lrsI7wrEgkKyvHWnTLBX4BqSxqJjnSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238302; c=relaxed/simple;
	bh=j3yPqxVhBRubpXAnhCCuwTQ8HVzQJfgdRxMhr4pnooM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blKowWlsgRwz+Q8g4W1DkCHZMgyyI929Z0grpxvYmUbj4whMiGkMqK5WQy374a0RqqtZRnjR4NbHH4gmbi9bJzwn63/IteaJzeN3IgWRn+OUsCHMMdF3m1gi8iU5CGc7nSHdTwc9Mj2Zsd3BdUsPc48CzAKBm82A8bbb0w+agPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RR+NqD8s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9FPVo014148
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 09:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fOJroyMKNm7vSUy+fmC7JYV71ihvrx4URxb1UJUiwg0=; b=RR+NqD8sZMb/as38
	gD30LEbfUIlOEhRpq6nBdDvla+v6cUuAJ5NAljP7PwZX/TGq5LysHHkw0O6vrToq
	f6VdfEAkgf6c2i6bTwqsBS+/pglxrQOU0suarFXR7zDPSsaFxG887rhYFhj7pcPh
	AmFdqcrsQm+xSRPDeRXcTvOOStG2TkVB7RcyKdMRVqb9lGrbYvmru2HiaJczaqSf
	WFyxidav5zESnC42tBERaWJr3QGetOLh66kJfGmegqe1UdfnPa7zLfytegT3u2lG
	flpKLGkd4o0/X4EfUuzHQTobi1ofGGEPEtVm9Q9/a6NuveZ5esFX0jiNIFa/Oeh1
	mS6x0w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47b9aktywm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 09:18:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a43924a1bcso12810501cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 02:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238298; x=1750843098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOJroyMKNm7vSUy+fmC7JYV71ihvrx4URxb1UJUiwg0=;
        b=AuXFo0+gxQqQRY3yN2Ca9VTnfuJZmDiUY93BZDMNhhEnvrmNk2MY4Rb1FH+GUxGMJO
         Qxd0g8kb6glWVy9xURW3ju0PSF8arA9ShxKxVLAH8vtzswwvU3gzHhXvoj/VCNocWFTl
         +JF542GhkBK7p1t23jqrtyz85kkkXCCl4JCh/Edl6G5q0Fclw2nUEfAyctnSeNPNLrl1
         4OnMl3lvibcwZ9XWimVTtgmqznm3nc9+gw2vE551NvnU6kSj7N03PMZSgvVChLnAiTxm
         lE/XVBMpsn7nF89bmdy53Un3jjmCf0W5EkGYHGB85un4mJ/2i8P3kiPDxD7fYGpBfYOK
         nSow==
X-Forwarded-Encrypted: i=1; AJvYcCVSEcF++RNItELoKWZfyBfthapFBwXL3KndypQHf+aJQG1Eo4m9C5ihUeKY8Gy/zFFrCWFd+ZdZ6CAeJycGJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSQKipXuQ8tRFVDy+sY3gGLh3NPTXAAL4vRzb2Hg/AT4CMCTQ
	TxqVylkNHSZVxAAYrpZQ+P4VkHJm4/TZ3dTTD/Lnj4DlviXqE2LAw3SiIGrlpkJPBoNZzBttR1R
	QO9woCvBweX6hx6NqXBmylj4q2DBhJ4P+Nxjjk184OVWZqqDpKVOmAiIjWWzAfDR6dDwz3g==
X-Gm-Gg: ASbGncu9YzDxGQH8aWl4Vt7tn0z1Us7o/RtF0cgV/v144FRmXdNVMChtjyFFYHwgjxH
	FtG+reIEMgQN0mr/YyUwqHb8XqJGzagOMpueZBIH08dB2ltWmYB2xItU6QmPwQdXwyMxuUlbAW0
	KwhbeF2aJ+VyHpwxLZOJJ1CYqmBwD+yu+lMk7MS7Y4WBL92IdDRXYWoHB5p9AZ1byQDTQKV7CiS
	uQVY+Zn0foPMWGqTMwNHqzSqUHjbun1eKmkfBBwHAigQkilHvGMJsMPf8JBhVWkdTR2KcGhNcMu
	nTRWt/fO2oEd865VBLz56s3RUg0twrd1d0loKZj1IU6halrA3HvnG/eWM50o0+00LRfzfhUJNJh
	SC7Y=
X-Received: by 2002:a05:622a:1a15:b0:474:faeb:50aa with SMTP id d75a77b69052e-4a73c55c1c7mr88059911cf.5.1750238297814;
        Wed, 18 Jun 2025 02:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFroTGQ38e7nIabQthNy/Uv5H8RTwz2UgGQOdmYHCVSIwztO+5tMX7dXUQ+pcaxlMq4WUfu4Q==
X-Received: by 2002:a05:622a:1a15:b0:474:faeb:50aa with SMTP id d75a77b69052e-4a73c55c1c7mr88059761cf.5.1750238297388;
        Wed, 18 Jun 2025 02:18:17 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48dd68fsm9525214a12.22.2025.06.18.02.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 02:18:16 -0700 (PDT)
Message-ID: <db65c9f0-334f-43fb-bddf-316bf883a848@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 11:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
To: Johan Hovold <johan@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
 <aFJ-SwT1g500h3kC@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aFJ-SwT1g500h3kC@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c3NWwog2KpPMTaRqHC6U8N_-HBWBOwEc
X-Authority-Analysis: v=2.4 cv=UPTdHDfy c=1 sm=1 tr=0 ts=6852845a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=ueFis7n8dWqy784j0wMA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4MCBTYWx0ZWRfX36U5cOX5TdL5
 rv8iSy8YXaJ+6Izcpl8Hr6WH9YPlw90KnTBqX5oAptRw0qz61X8HZmsBOmgspiJ/uJtpssfUTI3
 MJqI0LAlbVzt4FCwcqzxN2F2qVfBktahO90QKY8N29tEM+bQq1FZUOrpQwSL0Txm0t4FA0m7GpY
 b3qmxaGVyBtRDGcMmXybdKjs0gTALGdMUaN/sKl8zOVp4ogOTbsDd+2yhaANG4QDXFHOmVMZjrH
 So6phCN+S049udm+k1RIIiygRf5v1uXANIwOh13wHahmmY9TZF6lpVne90qif7f13gZdbIjKZaC
 jaAoz+0k47LW05kSYq5XUFj2iq7xh4Bv6vDxeewNpjRHouqdi1IbECmaJLOyUVZdb4b6Tar0PUi
 fFOqtakyfjW19Ze2R0NlLkzouQ23Wmgdw6VzqgOn7FrAabKUAwyvDDUeMp1L5auEd6c/em6s
X-Proofpoint-GUID: c3NWwog2KpPMTaRqHC6U8N_-HBWBOwEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180080

On 6/18/25 10:52 AM, Johan Hovold wrote:
> On Wed, Jun 18, 2025 at 02:15:04AM +0200, Konrad Dybcio wrote:
>> On 3/28/25 6:32 AM, Baochen Qiang wrote:
>>> Now WoWLAN mode is chosen for those machines listed in the quirk table.
>>> This works for suspend (S3) but breaks for hibernation (S4), because
>>> WoWLAN mode requires WLAN power to be sustained, which is not the case
>>> during hibernation. For hibernation, the default mode should be used.
>>>
>>> Register a PM notifier with which kernel can notify us of the actual PM
>>> operation: if system is going to suspend, the original PM policy is
>>> honored; while if it is hibernation, overwrite it with default policy.
>>>
>>> To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
>>> in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
>>> non-WoWLAN mode is chosen for all.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>
>>> Tested-by: Takashi Iwai <tiwai@suse.de>
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> ---
>>
>> I've bisected the following splat to this patch, still happening on
>> linux-next/master, WCN6855 + SC8280XP CRD, 100% reproducibility 
> 
> WFIW, I'm not seeing this with 6.16-rc2 (which has this patch) on either
> the X13s or sc8280xp-crd (ath11k now fails to resume on the latter
> because of missing regulatory data, but that appears to be a separate
> regression).

Do you have CONFIG_DEBUG_NOTIFIERS?


>> [root@sc8280xp-crd ~]# echo mem > /sys/power/state 
>> [   20.267830] fb0: Framebuffer is not in virtual address space.
>> [   39.863070] PM: suspend entry (s2idle)
>> [   39.908067] Filesystems sync: 0.035 seconds
>> [   39.934453] ------------[ cut here ]------------
>> [   39.939259] Invalid notifier called!
>> [   39.939268] WARNING: CPU: 5 PID: 513 at kernel/notifier.c:79 notifier_call_chain+0x84/0x1a4
>> [   39.951566] Modules linked in:
>> [   39.954732] CPU: 5 UID: 0 PID: 513 Comm: bash Not tainted 6.14.0-rc4longbois-01215-g32d93b51bc7e #12177
> 
> 6.14?

g show 32d93b51bc7e2e557771abe4a88da69c609e3d52:Makefile | head

# SPDX-License-Identifier: GPL-2.0
VERSION = 6
PATCHLEVEL = 14
SUBLEVEL = 0
EXTRAVERSION = -rc4

it's been in the tree for a while

Konrad

