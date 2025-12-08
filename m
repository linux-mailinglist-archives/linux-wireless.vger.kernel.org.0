Return-Path: <linux-wireless+bounces-29599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A925CADB92
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3712530542E5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E92231836;
	Mon,  8 Dec 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3kHbwKr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d38u30Dq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7A243964
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210603; cv=none; b=T781EgepCnvUBVVed5rFc/BouLCS2+vy0RycrrfN/C6Q0WkEvNAbyv2IaT+lnnFbkBpLrCtS6WFsdglBDGoBRzmoeXZkLzWh++6J0VhwA/ugSuDwPtIrzRaNUXxk9cWwY4De/ytEnlEJk0p95GogWImyeVBsxdrIPKiRd4GDwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210603; c=relaxed/simple;
	bh=xtRYUN4Ez6YFGF3U9PfDbnTN9Yi0vdzap2wcAyCRo+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiHKaKFvoHJKHDUCvLgjwFhIoczhEsT8EbPDz/ICWIfr8p4rTy1pk7iriPdyfFtpS5RgO6Ul3WdIVhxR1sbxG9TnDbd/OiX/BrlhsYQOh3X/5rrt4EUb0gM7X/jbrNXImoeSW8qK0KGPQlAkTm8LYH6tQdPsOd6DAt/OveyHcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A3kHbwKr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d38u30Dq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8ChYKk850710
	for <linux-wireless@vger.kernel.org>; Mon, 8 Dec 2025 16:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ud7NNLBAJQWMt/PynCDg/O4Z5GATNvwyimSU4/I4np4=; b=A3kHbwKrWTMWOSRh
	jUvtaggQbWLZQqvATFE55y/sf2tko7azdbthNSZxgAJixbol5HaQ087BPy21Npxy
	S+Yjj9Uj7ZF/wi+xxGr+NdiUsi3XaoRdYIthqAkWtHHVFJYQ0hF+auz7EGw3EX3t
	bZpdxghmC+Po0eh8G2mBWoG1KzAgNfrp4JyIMWuTD5SbpoEKKUEcn0vHhhoyz/qu
	1r4jpbohd3VqoGBQTZ3eCckwAVwj5V2rZSww10uGw4ykJphFB74pkAW5Zea2A+i1
	XwVL8yuU2nbXagbxGysKczSKC4UdmZtT6jTK6QfJiC1gPJnMIUNNf8aGH+POJkFH
	yY8CKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awxxc0mb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 16:16:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-349a2f509acso3831854a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765210599; x=1765815399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ud7NNLBAJQWMt/PynCDg/O4Z5GATNvwyimSU4/I4np4=;
        b=d38u30Dqb3BO/tW+AoWqOthheJGao8tWHQvzyLn76xhmS141cY4cFkP06DCIOy6Psz
         K2ITrCzQY6dzCXR1xLNW55fyCP3et1okJhgeyHMaryU0bZjUnNzRjDMkRTxePf8cpYq9
         U9HBHu6unsnOBmQprs554YYkCD22yxIxYiP9K/rzhTnib2zHMoUp+wJXd1w7L2aIl5bF
         NpD0wl47YxvMiyqzPBFHNUCqrKEdcqgdDkn9DpXOzjrnMipPfyjXEHWmVm1C8HkkZ1fT
         mDu1K/y8HQYb/OZR287DS9377K1L4ta8MsDgmWBLVTUHpHb0axjrxWsm0czRVpYnXYxX
         RHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210599; x=1765815399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ud7NNLBAJQWMt/PynCDg/O4Z5GATNvwyimSU4/I4np4=;
        b=MZ4FamT+2P7tpfYfr/ag1PHeQuSq6u9tWpy63im6PGkgX5/oVS3QZG5pPt2inXizoo
         Q5hiOAFRZHbr+LLcZqeC/mONdZPWQssoXCtdJyKlJcD4RcU5Yj1uzRc4VCl3yydYiSsi
         ndrry9dNed0+ZOFuPifg808eBUfakBJOZZlpyN0aPpGSaNdBBgmb6hW1m0PzGjZBFOat
         g3DeC1IQg++UlHO+nLHtf4rG3z3gGC//6x+UbPm6IHScRfyXDLum7mDaSqOI40LM/nix
         mMUWStsGT6Aex1OD5s9pKtS6xZ8AgSbpKWQTIM/cU92lhsNX359b1jkJ30S14+Xru1ua
         pZ4A==
X-Gm-Message-State: AOJu0YxTTzBPQtX+tWVCfD5vkiVbTKATDylPVODaJr679adkizwG+u7J
	0TbdBp+Y8d/OuvAIEIvfLhdyCPrO7Q21uer1aO9uEAas8DZ488oWA23+cHN57Okm/9KxkVU9Vju
	2N+dBG4GNok+sx0g6rPKiBlMMyXwRpezmt0BRIg1AWZhRyU0NpDP9gOgJ3lrSdX/cfF85qg==
X-Gm-Gg: ASbGncum0iY6FgQt1Dg/KP3x3cX9hInpB8sXz0jicdUAlO/S4NdyJlmp80zM+bACORL
	AufyJcT/zD9T3s5PfOd6epYi8tApzWABoQE/qRshdawJn+dXcAhhj2yVMDBFt+SHwhhT7rMXU9B
	3Z5xjJWpdcJMqt/2LVUlZ3pFiamStgwsZlmeTdEamvAcJA0gNfzvqqMzAuGy+8JHG13zUUsfUYZ
	F51s6YegM2sH5RcO2MfCFjL6oeuA208WExT5DPiBhAz4EhYr9MEYHYblqDs14A1FBz/DHwLGwGI
	g1DAX5HYOpqhT6rIrz1ZbBwPTBctlWy82aFpd8Y+zBzrqw4wP8Za+sWJXFIV9Wi+bt4ySj58MMD
	089ejMiV65IIv4LlKqhuds9VFdLC/9DDr9oqq7pORsCCUU6VAp5VUZBEVcCWevg==
X-Received: by 2002:a17:90b:562d:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-349a24f21f1mr6514413a91.10.1765210599556;
        Mon, 08 Dec 2025 08:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpRBnZEduK9iwcFFoWaJY87xaBpkeyCAnHea2DdIuaFEzyWsnMJduL/ggt7hO7EqfqSSWJTw==
X-Received: by 2002:a17:90b:562d:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-349a24f21f1mr6514395a91.10.1765210599060;
        Mon, 08 Dec 2025 08:16:39 -0800 (PST)
Received: from [192.168.225.142] ([157.49.252.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a23270e5dsm898569a91.4.2025.12.08.08.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 08:16:38 -0800 (PST)
Message-ID: <c030f82d-75af-9a70-68fb-64c96d7f210e@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 21:46:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath12k-ng] wifi: ath12k: Skip DP peer creation for scan
 vdev
Content-Language: en-US
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251207072717.95542-1-quic_rdeuri@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251207072717.95542-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1dvb2fPEG8TUES5rfl3efafp0y_MZ5AI
X-Proofpoint-ORIG-GUID: 1dvb2fPEG8TUES5rfl3efafp0y_MZ5AI
X-Authority-Analysis: v=2.4 cv=AKf9OaRj c=1 sm=1 tr=0 ts=6936f9e8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=wFAAa1VAB0ePzTpIHxh7fw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=bzijrYIIVt2SdmEy8ygA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDEzOCBTYWx0ZWRfX/ArvJdQHgtyI
 sBkkMAEszNPKo4hx3bP+e07ZL/f+UpLVgOHt6OIgenaSHNX9L5/ifvlFFbHQv4hkNYIoaJsdXIM
 fh3ktXLm5cmA/2sE4nu+roZ9llnuVUbALCSoBSOhLIoNvQmCBObdVdVkupBNmPYbeWm16B1Pe+u
 urq2MLtiwYwwYlRe1fspCKbxo2PxzEDW257yJYFG1vuchxW2ohoZdYcgZQ0if6X3SJFZRwMokOn
 e8Euz+zEP704YTooCVPwdIswvB0bT+0KiGdBcT3uYX4OlaKyVLd2qTetmDZl1U17jZUXvnT7n3K
 XFRZIf3h/nVXygUEKcYFRl38LaPBM5lFoB2tZAa2SwmhDT4zC7VW2n+uyqTtqPtRlNg0XvWy54P
 /FoCMB5ccnLmg8M7cBDTUYXUa2DFTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080138



On 12/7/2025 12:57 PM, Ripan Deuri wrote:
> Consider a multi-link AP configuration:
> 
>      MLD vif (MAC addr: aa:bb)
>          |-- 2.4 GHz link (BSSID: aa:bb)
>          |-- 5 GHz link   (BSSID: cc:dd)
> 
> For AP vdevs, ath12k creates a DP peer using the arvif's BSSID and stores
> it in dp_hw->dp_peers_list. During scan operations, the driver assigns an
> arvif to the scan vdev and uses the vif's MAC address as its BSSID. In
> the above scenario, the scan vdev MAC address (aa:bb) matches the BSSID
> of the 2.4 GHz AP link, causing a duplicate entry in dp_hw->dp_peers_list
> and leading to scan vdev creation failure.
> 
> Failure in vif bringup sequence:
> 1. Create AP vdev for 2.4 GHz link:
>     - Assign arvif with BSSID = aa:bb and link_id = 0.
>     - Create DP peer with address aa:bb and add to dp_hw->dp_peers_list.
> 
> 2. Create scan vdev for 5 GHz link:
>     - Assign arvif with BSSID = aa:bb (same as vif MAC address) and
>       link_id = 15.
>     - Attempt to create another DP peer with address aa:bb.
>     - Operation fails because aa:bb already exists in dp_hw->dp_peers_list,
>       resulting in duplicate entry conflict.
> 
> 3. Delete scan vdev for 5 GHz link.
> 4. Create AP vdev for 5 GHz link.
> 
> Since DP peer is not needed for scan operations, identify scan vdev using
> arvif->link_id >= IEEE80211_MLD_MAX_NUM_LINKS and skip DP peer creation
> and deletion.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

