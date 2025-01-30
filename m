Return-Path: <linux-wireless+bounces-18216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C4FA22A25
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 10:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095093A2FB2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A551ACEB3;
	Thu, 30 Jan 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWL6G0zm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748C139B
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228709; cv=none; b=J9B09yzW1OWXjWLdtqmzURWfKzCC/ZJgUTTb/HFfs9ifcTdOcbJvhSCfsILZnd+ahqOmrao3Gl3QvTcVKvcrzg8UkXfTTaGvCbzeqpEUc+SmdbVvK1g/OvXklETeqXIjA9x+ApOMVg1Nv0HQ+MHgkX55sK8R4F/b61LSgm+q/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228709; c=relaxed/simple;
	bh=6494x1NsziKlFATjP5K/hvSwS6QGIDEkExL6srt021Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXsUHLeFHrMRFvfbrc1b5p9PQCQ9zqpL5N61BeE3J6v9NWXScH95UlWAouPjle+TtN3r1252eHgmrkFIzIHJ2Ul9IehMW1fS/UmPBqlKWDktVZpf7XxAeYZhY4/bzJiDR9cdxID+8sKIVCYgSS2StUKmJn9/coJoQ4Bpyf/+tJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWL6G0zm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9I0bX012358
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eePmyQ6AyToHFq5ZzRudtzKbdM2PRLlCrpc5DW2Ub5I=; b=lWL6G0zmDNerUlaW
	G/LIYKhkLnZ62yp0XY3nKsGLGHSdlLmALA3PoTpdT8tfHIEmKPsF+6E8agbqc8nn
	gEtu8qd/LSnCp8aufeBP3daYAQP23LV3ChqU09j76d/iNJyJyjOKtPcQ670cSWC5
	bXoUUZEScDIre1Yk6YACkVNscpFq9sXEE+TCBCo0yST0kg5MhbZs5qApwsmntcC8
	y8L8xD7zMBsSzYPIBkQrpcJ08Lk/JA6nLYwcCOBMV1RvgMhCFBvtr62tAteHv7zt
	J8LvrghgMlFbrIG5j6kcw3iLbXInAfpXRLUn5g10efHA7JcL5I1NaMm49dNIeQ5A
	K64p5g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g6nu8017-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 09:18:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216717543b7so16538885ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 01:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228703; x=1738833503;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eePmyQ6AyToHFq5ZzRudtzKbdM2PRLlCrpc5DW2Ub5I=;
        b=VnLFIL5QIz8lKULKZryzBhwkdLmx2f8XIqXxnfwOlDCt8VdyYRFZLgbxFMoJZ/Ngns
         NED286cYI052GvgBLTLW2aSDe+K2kM+TRsTb0Di3sSUGPVbJ6locMzDUM1B2hygnj2vt
         SbGkQyfNO6uUBDxTklGEKBFX8p7Fxbk9RaK3m+cpDwG02jPXjhxGKHfxWRY+qXqqMKeK
         Qv9WX22R0yvmmh+4x666ns5lEFa+Iu2IpU75vzb2R4AwJ2WHWscl7IcswhAFGaE2A/Sr
         8tDGozWMzZYD+ee/kK9WvzvwbjfL8IBEQC4b6XsKF/gNIhBeWzJadqiztmlo6JUsz6+2
         UHwg==
X-Forwarded-Encrypted: i=1; AJvYcCVc3oA6EEohY8rdXj1OQLpCtB2siJiRNgvm/Yp/yVvDQ2iN6+K/JYi+D7eDMzIpNMOtgKp2JF6l9EuKuoE1PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPc2XqbpT+Wrkd040FqCcwP82afh8DoveCWdRQQL69tX3zueX+
	GVtIiQjM2KAkf86wTg2uYwjEt1dAJmv1d02KbGrd23w5rPI/As3aVTAFPip8gBPD7dOlhiFW6AY
	YwIdymDTRglZqWhKiVDMfp9tU/ADwYBDuKpcHKHOZS/kNcPJGKxfeQORnBF2MyWo0zr3Qehqn9Q
	==
X-Gm-Gg: ASbGncuskXsnBsLA4iRvEU7DfA2USTyTE+quw0GaTE26g9pEVd0GNpEQX7KvzrvjBA9
	upAgMUDp79a7PVT/X62nAAAr3YV2ZEuBCRc78l4UwOFBrtQy2QpF/tLxli6rjCbi8lAJYwZa3fx
	yN2Oo8QY7sKyzn14Wo0SKyFiggMX+apcBRxKDPT2yWiooiWYiwa+ClkhzyDyO8rVPyKIy1gbJjf
	Tc+qDzniBhryObUWw0ZSGZ2q6LnijRVaE4urvRpJOxSIcGyi4DXfibMNuKTNlNalz4IoftO1M+B
	HiqmLdzVLsuxOo7PlONGkxl3cjmx52BiEXUC7Ck=
X-Received: by 2002:a17:902:f60f:b0:215:a3fd:61f5 with SMTP id d9443c01a7336-21dd7c44516mr103038865ad.5.1738228703440;
        Thu, 30 Jan 2025 01:18:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRttBzfpMMi7+IvNp9nzNnKCJLwBTy4+pzP5Bx50uGqeX9D+oTbLTRBPYM8mM5/vF6FVybGw==
X-Received: by 2002:a17:902:f60f:b0:215:a3fd:61f5 with SMTP id d9443c01a7336-21dd7c44516mr103038655ad.5.1738228703061;
        Thu, 30 Jan 2025 01:18:23 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f8004sm9620975ad.74.2025.01.30.01.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 01:18:22 -0800 (PST)
Message-ID: <94db4020-b1c7-4aee-b22c-6fe6d357e593@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 14:48:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: remove return for empty tx bitrate in
 mac_op_sta_statistics
To: Remi Pommarel <repk@triplefau.lt>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
References: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
 <9c12e9b9-35a4-47f1-bd17-6b4641de92a4@oss.qualcomm.com>
 <Z5s9CO_mmazq2Kg1@pilgrim>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z5s9CO_mmazq2Kg1@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O-z0txVx2zJaxjitDfNc4f4NGdwN1FrC
X-Proofpoint-GUID: O-z0txVx2zJaxjitDfNc4f4NGdwN1FrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_05,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=704
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501300071

On 1/30/25 14:19, Remi Pommarel wrote:
> On Thu, Jan 30, 2025 at 12:21:54PM +0530, Aditya Kumar Singh wrote:
>> On 1/29/25 22:25, Remi Pommarel wrote:
>>> Currently in ath12k_mac_op_sta_statistics() there is the following
>>> logic:
>>>
>>>       if (!arsta->txrate.legacy && !arsta->txrate.nss)
>>>           return;
>>>
>>> Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
>>> if it return for empty legacy and nss of arsta->txrate, then the other
>>> stats after it will not be set.
>>>
>>> To address this issue remove the return and instead invert the logic to set
>>> the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).
>>>
>>> The same was done also in both ath10k with commit 1cd6ba8ae33e ("ath10k:
>>> remove return for NL80211_STA_INFO_TX_BITRATE") and ath11k as well with
>>> commit 1d795645e1ee ("ath11k: remove return for empty tx bitrate in
>>> mac_op_sta_statistics").
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> MISSING_BLANK_LINE
>> 'Tested-on:' tag missing blank line after it.
>>
>> You missed v1 comment? :)
> 
> Yes sorry I think your mail never reached me, did you CC me ? Do you
> need a respin ?
> 

No problem. No need of respin just because of this. I think Jeff can fix 
in pending?

It's strange that the v1 reply appears to be delivered from my mail box 
and it is sent to the list. I see even Jeff replying to that. But none 
of those are captured in patchwork. Not sure.

Anyways, v1 comment was regarding this blank line and one suggestion 
that in future submissions, please use base commit tag.

-- 
Aditya

