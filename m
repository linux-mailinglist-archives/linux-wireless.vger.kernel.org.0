Return-Path: <linux-wireless+bounces-25429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C792EB04E77
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242D216225F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600984A3E;
	Tue, 15 Jul 2025 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJjDRhTJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB12B9A4
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752548466; cv=none; b=ivUvzujQaIcBfMobn6MqR2UKI9Uo7nwcWNsdIMpijb7YKMta1NKw9cp2vx34Jmps3r6+EABa4sXBtq51BqvBSPVorbF4Fo8IhljFI3LwQbOp7+wJbKSLHN8k/yH2lH+ls2GKqd1KxB8a8ZUh/tZ1f+sF/GbhsS/x9sKQe5smqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752548466; c=relaxed/simple;
	bh=7S3TtrCp2lcn76CzYHbtNatFjIUM6G0g0kv+egxbqH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLzsdlP8EHVRq3ohGTjrc26xcgdkhuPYKf6zCPILKp/F2yTESWb8zouvYDelQb/8JpqDBGnaOFPTN2b/OBz8d5B/NEhwCSQ2sqQbZzZx/9XvACdCjMZ1HN9kbbCTu8o3xyu8atueyjO7OxpdtzxBl4dJK0C4XLcFPIxwSH5UNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJjDRhTJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGRci1029639
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yMVrUUJC69aM+MZi+poTcsRqHni541x751Wa10f+gIc=; b=VJjDRhTJtkcth0RL
	c9uSyMZogBGNnAT1277RPb8a8A8E4GTiXct3BWupmN1CnXeAJ/tqKQ6sPDh05z1F
	xBmsTslemfADuGNx0zRZfY7hYEU/Bepre9Z8jtT+Krx0DAFiZ0b0vMnOmxKT2Gay
	LdmjlvsovLAR0GZEJnN0SL69jqyKNqZk2k2baJcAP8PLWxZlTm3jWYSziSLgG9wf
	UCrSo4nMIJvYy/PviOiIPVaJpwTXi6tGejuxND/fN1n4DtSzPDcfkTBGaofp8qBC
	yIxVmNNuJnuslyM+0AJUnC5FDzopUPPYmyaOQgfzNTECXuVv7/kmue7FPneV2JQf
	Hku05w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dq1c4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:01:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c36951518so5622670a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 20:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752548462; x=1753153262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMVrUUJC69aM+MZi+poTcsRqHni541x751Wa10f+gIc=;
        b=sN5u5e+J9fIIJyInYnJO+wXxoYBGcAxqxqjSSHSKnAGNBBobBVJ13/ZVyO/ei3DGGw
         QE0wXXiYZkM+f2GDrzD3vP0qamqwi3Kz1gNx6+6V089aVC4muRDTW8WR6U2gsyYsu7hZ
         m4hVA//+m9WJFdcHmLYrd1fSoUjZrz0wXlQ+pkWGCHngHvIHc5gJno5UmEGYKn4SjxxE
         npBenJeWMWxCizsUWKkY125rdFKuL3IAYmB9UJ4n53unk0rx1t1z05Kzg4GBw4TZX0QJ
         t9g1OS1oUPTPdV/TotDFjlRwB65drem1TSPkgJ1UZtkgKmKw34GmEQ9VreirlUBhvwZz
         J8lg==
X-Gm-Message-State: AOJu0Yzb2TGhUX8KUJNuRT3G6G2IoJW0hXPNtgSPXMpuF2T+/BqfnYTO
	VuB6RZab+wetkepzXOWtLFIa0l1VuwuwyMakMVGnwfp0Nn490iki/UWiCR1cc/KBIJzx0H3+Sn5
	IJaqwqzmnumd2qpH1Iet0kuXWoGArQcHF4KSLgSyUSQuBix9fkoZtU4xs1GR3Y55fK2WuHw==
X-Gm-Gg: ASbGncvMJDwFDw3MDBLLvE9xJjm7Re4jRegx+r8IeA44eoljEwy/1vnSoZFwvZjgtm7
	5hzKpgFS/8gOrF3VZeI52+lWd0vydduiqAYxmVy6x9pCKDMxJpAd0TKR3WQarlj50SBdwZ0flEX
	rdg4bRoyejEq7g8958aPYEPsixr7l41XOJI+EztJylUleCEOjaJlVbdlKkarb90rHVEtGTufAwE
	cl3/CjdwpwMVtONkgH+OARai66OsUseW5zgDgVBTjoaMpHQpdD7f4GlkXEKautWdXHax6Z89TNK
	A1s6lASIPeYva54yXTfuNCzLb6u7s57rNjizXnn7KHo3e3XWqhewYNBo1HeJx+aAN/htn0uig4m
	L08TwHVfPWZKo
X-Received: by 2002:a17:902:d492:b0:237:f76f:ce34 with SMTP id d9443c01a7336-23dede3869amr212021015ad.15.1752548462031;
        Mon, 14 Jul 2025 20:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/31uXj369rvnVHrjBXgX1NxDdoHWNI71i1vo48vvCgkenQvNS+WIUo0oIjAhO1qCWoufEJw==
X-Received: by 2002:a17:902:d492:b0:237:f76f:ce34 with SMTP id d9443c01a7336-23dede3869amr212020685ad.15.1752548461565;
        Mon, 14 Jul 2025 20:01:01 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.226.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4283a81sm99247935ad.27.2025.07.14.20.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 20:01:01 -0700 (PDT)
Message-ID: <96e05fd6-6fcf-23b4-9def-1ba6fdd5261e@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 08:30:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM
 mode
Content-Language: en-US
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250711035420.1509029-1-aaradhana.sahu@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250711035420.1509029-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAyNyBTYWx0ZWRfXw10hl2fWPVz3
 8+nI7p8fTkGZ82oamduZOJrm+vkpFGDJi94KUpMgZLpi3H9wcUfSkk58RqWiJj876YENCgp3Yrm
 CK4kNTEaKIGK9j+LF1vy8k8rNZ1ntpid5uOg2q1TR20WhzWSfU1a0G/pcZ94QhCWugs374YOZ+E
 mUsS3jM2E4Rc6y5I9W53GpU7rujILdqykPH/o2CpjILxuhg0lGQAQlP9NC/B07j9rVMyzO49RDv
 tYzq2IBW0W3P+wapHVE3NUqCdvKEkIMjlLtOEyhabLzR4kCQ8PocUdRAHg+Jri/mOZEBt6SuY8c
 BNiO0bZPLpOfEkutbGRliQnFLHNcjv2I/Jw2HTcx+qVSy7YPQmEYisJ5xVzPX5RaWKl+FXxqGdw
 wEnazpclTM6YwCpWC61Nv7fWwS374CmgJ0cxp+1eGNL+1P1MibDMnGQPnNkvPXaV7UNZAKlA
X-Proofpoint-ORIG-GUID: XfId1GtYt8-QYTld9HEphBnoI0ToRulF
X-Proofpoint-GUID: XfId1GtYt8-QYTld9HEphBnoI0ToRulF
X-Authority-Analysis: v=2.4 cv=MpZS63ae c=1 sm=1 tr=0 ts=6875c46f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=bFupCVmCsjxzjGptNxIE4g==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5bc-JWag2cNjQzrUM98A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=818 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150027



On 7/11/2025 9:24 AM, Aaradhana Sahu wrote:
> Currently host sends HTT_TCL_METADATA_VER_V2 to the firmware
> regardless of the operating mode (Mission or FTM).
> 
> Firmware expects additional software information (like peer ID, vdev
> ID, and link ID) in Tx packets when HTT_TCL_METADATA_VER_V2 is set.
> However, in FTM (Factory Test Mode) mode, no vdev is created on the
> host side (this is expected). As a result, the firmware fails to find
> the expected vdev during packet processing and ends up dropping
> packets.
> 
> To fix this, send HTT_TCL_METADATA_VER_V1 in FTM mode because FTM
> mode doesn't support HTT_TCL_METADATA_VER_V2.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 5d964966bd3f ("wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

