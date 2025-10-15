Return-Path: <linux-wireless+bounces-27992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB1EBE10CA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43ADE19C53B3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968D31A7F1;
	Wed, 15 Oct 2025 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDUnIY7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42A31A549
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571635; cv=none; b=Eann6deHbTSzYO/ti32xELBEsPc5+zHXE2Dm/QCkfn8M52Ud5pVr0LQatzqV9j12718iwcU/SlxgHh9Zrfur5/36aamp9YvOk29+y3o3WHStuFLZuaG0JH4GR1ezn0zkEoetb6d4sABmHgd71GVBAa4PZorov/lq3q5e/XeySHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571635; c=relaxed/simple;
	bh=CqQ0tjvrx3mT0wyvG6NSgf0BT/Shsb5Uh/9onRWU5cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rtvS3HC2s6n2y8fN8GGAHvugMKm0IjRqhZDR2c5WWiXbgDAf0fOqhjjhEObtUdiMnApI2e+O2OouFG/msffQTSink8x0fi+cRjVolQLHcFvyGl/wuVv5Mu4IRqyK21wCAdgmCKfMlAlpTxC/qxa7O5KVUuqulB97E0qC/OW6zfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WDUnIY7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJ22GS016723
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JN9sVLu+a4PjGTCXxkztPeS/5WtgaxXqbM3gWtB+1Wc=; b=WDUnIY7qqTjNpsKV
	nodmW/589QlozQjuYNSlCJbvdix6ByKfv30FJ50JeyoBYNtCsmoBIkrF/vsstNMO
	xMzSM1K3G2zEZU9JyvKmwN7Fzq/GEkAWdo/8F02xfOWwORRndUVoxiUj/IGYagc+
	NYIXj0JMYwxTHq6R+x7MrSsKQMiD8MCWIy1BAuDkKO6u7hmugfJg+RBb68S38sPq
	27akgKRSjInSC8vGVbn0zsv1+7e6oDrCRCZXBKMNL2SeNZHUuE8V4WlgL0CTp7XV
	IFrkhkoVsycV0CcpuH7LvlSAwNTBBoRPnskzl8t9oNy+YzHfNy4eyUnzf6qMmIgg
	4MboRw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtb7h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fbaso1949025ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571631; x=1761176431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN9sVLu+a4PjGTCXxkztPeS/5WtgaxXqbM3gWtB+1Wc=;
        b=X8JwsZF3HacUFl+jLrwG2hD7Y0+Wy2L/kYfgO9zADeUp8k+9S/vFlEFKfEIx1EUmAb
         6j+h619JYzflPDuKO3IDRbXdmeTymbMrytrWFUj8y7ElyBhIFvpTd8Sa9XeGKJbh4RCG
         siUW3K7DOLq1WoFXXDI8ERfkBq6s0Z6sIiNPvNQ1ezvce1iMRlR6QEC2UIh5NgXRqTBL
         RkaKkc1Z/8Rnu7mRg9ay7xhYDKcDEyHmZtJFZyijUoFZCOWiR01oc3No00Ig7krz1zF7
         NmmDtdJUH7enExvKQDzZpLLEUOGiPFkvBJNC0Lfi5CrqiFG2WkjbNR0Q3l9Ot74jMhfg
         UcPQ==
X-Gm-Message-State: AOJu0YwkTOGgG+8tJ+dNlL5F7joHHR4i5Jh1UZBufsIhrGHPNiKdKXWJ
	zYpAeXRn6gA+2DgllnfK1Q4gI7IEWb1j/BB8viyhG/sDd1qfWhwQ4nWp7IxqbL/kbz+QGfGgms6
	vekYFs2Q0/myfuOXiqXDsPmcAIUEoDBaR1vN/zr70WUKKVPVTbFd1gwr1H4iYJwYL2iad/w==
X-Gm-Gg: ASbGncvVBVJ3bDpH8hG0pf0YdE6pAXUPs4T4Cyg1wFsL3Ojxf+e/njwNj7u/3XJ48Ru
	BlGdW7xS+HOkzTZgwEMR/qh9iZmtsoAFKOBfEF9x/2eH4d36sQRk1yAggnL09KkGSisrZga8IiJ
	9+9U8LNiFtU8UofSx7ivW0+tYXbUP0+SkY1pbAF6OwVK5dRVvsQiRuBtSFwVHFzpylumqrpOkXh
	PV+Hg4S/riam3L6Cc+fyw3RjQtzkHSHLuPZH3Akws0HY6g1RDFGlHkrQ/X9RiTSdceeWKYfWmoL
	SD6OjMMpBKrr/C55PBc5p6PDsBABrnr+lMZ1PiP3EA/orXCHbIOUX1UrwmoarjANgpKGEAAIX9w
	AnWRy+U+85TLfkOnS9Gc+aB/9FyFAQ387HWQ=
X-Received: by 2002:a17:903:37d0:b0:28d:1936:ee9a with SMTP id d9443c01a7336-290273ed7c7mr395820985ad.29.1760571631592;
        Wed, 15 Oct 2025 16:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx9/Zjh+cw65UvBzvZIJ5TaNJbwq7xsNwcsRRA90SFXBFxs2t0VrnT2QlohmCo8U7d7vlx+g==
X-Received: by 2002:a17:903:37d0:b0:28d:1936:ee9a with SMTP id d9443c01a7336-290273ed7c7mr395820735ad.29.1760571631155;
        Wed, 15 Oct 2025 16:40:31 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
References: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
Subject: Re: [PATCH ath-next V17 0/2] wifi: ath12k: fix TX and RX MCS
 configurations in VHT and HE modes
Message-Id: <176057163051.260563.14889563082385358243.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 6MNjGgfruuJir7NHh1ehyLBEnAq4xq5w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXw41M3LmK2YUE
 7KM7cDeLJsi/VkGVj4nOMVJVAImNEJ0Y4geo/oI0CtH3zBP/d/Kn6ti1oP4W4MdrC2lPbJRMa7R
 jIMdsQkbWo/6B7NDfz8tybdBB0wnSi96akoht+3XJ19v4lKAiuXCgEgYn8bUS5sAazFaHxKhzoE
 zBEgbhi1TTJ4zL/rl0uK/E1ttrKNYM1VzEj+G1vQvIObDZdEI1R9imAcxIBjlWigdCyuK0USyyB
 7z6Qx3n/LZXOHo2dMo5YMpmx6KNm9ivIARRm5J9BBO5uDbtPFaMkMMIwidMs9EnPdjvogCN2LzR
 Hq1clAcwMcZNCGeqYEE0RbBFLTFZ7Y+6SsTdcd20Dg8cb1a+Nh3prdXKx5K6FQmrP8xqeO+tAqV
 ZDaoOcdqol/hIulluJpxX5YVmQlSZA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f030f0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=1T_kBm5XZ40ICzLEKyUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6MNjGgfruuJir7NHh1ehyLBEnAq4xq5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022


On Thu, 09 Oct 2025 14:16:54 -0700, Pradeep Kumar Chitrapu wrote:
> This is revision version for patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
> 
> changes in v17:
>  - fix spelling in description.
>  - change wmi.c wmi.h copy right per guidelines.
>  - fix missing recalculation of v for TX MCS 160 in patch 2/2.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: fix VHT MCS assignment
      commit: 8c21b32c2cc82224c7fc1a9f67318f3b1199744b
[2/2] wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
      commit: 9c5f229b1312a31aff762b2111f6751e4e3722fe

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


