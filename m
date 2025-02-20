Return-Path: <linux-wireless+bounces-19231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1054A3E6C8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 22:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E804238E3
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59192264603;
	Thu, 20 Feb 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9lwiQkI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6326388E
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087664; cv=none; b=IaIl1QDajr2BRPwXz5X21oApa2g1CS6h3vxTCSc+sEA22h9C3sS0WBKlcMY//TWi4K8hiW452KUYF+ClhZ9LuGCihkJo4WKHiMfSMLwAZwqvEuNAQk+CxFBnFfaUx6pzlCaRlivXVdDwZHXUAEECGF6GL1aD5BEDTLwKfgiV8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087664; c=relaxed/simple;
	bh=Rqlh9PEqEUGnJZ3UxtAQHoICxsGr5+PPKUm+y7Yalrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hxitE8dUcCJYkfimf8NsTdYbephh7tjc/eQXN0nY5QgXE0mHUv6dmm0NN9ONpA94gLL4qxyjz8TpRzOGVJd+z56p4U0LiemGjjTpYbX5NMY893mP0E34VS/L3FJnu5Kw2zxz0mXNUBnOqpEs9YUP+CT9ersEV3WKm9EvIcOhaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9lwiQkI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KAXILO026533
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 21:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zHYe/1J2KbbzqoHimzdyHNz0QBYzwKAZi3NaHlPEgDI=; b=E9lwiQkIf2FdAVEM
	aGymvbdTOrQiLH+BxvsK1OaWORI+wjHdFeOg4Pcbc0dn8J9lSNXcBNgLg8nOuPXV
	Rn3WALMvJbXy7LO/tzsgrOFl+rTDFXJOOSaelDmaBTPWsw7LOfCPt7DRmhZdkJHw
	9WJJsOPicjr6TEri3MB/C2Q9cFTH+guHzujfLZNxgZwyYMXXVXs+9KDzHis1sOBK
	cU/Ebnxp7J12HZHdAcAvM2E2BgW+U7bPKIOYGFAgOPMy2OYODWCrzcDTkdx+QJmI
	mHwNddwKwCXo2bMP7gBePvq1vn9WciFZksa9kaSHXe0s0V8Vsy6eiMiKEK4fq+Rv
	HrrxMg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x2r3sq7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 21:41:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220d9d98ea6so44262085ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087661; x=1740692461;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHYe/1J2KbbzqoHimzdyHNz0QBYzwKAZi3NaHlPEgDI=;
        b=cRPAU8+ywxhBxCKEilibuXeMkXC+GNNtniYBTcEN8sc6pRsbHl3vZHayjUo50mGGXw
         z1NMGfhRcCljQaihZHwoPwT8t83ACJ6DO6Z8+Rs7UyMcV47p45z8fvlw2rewXe3KYflv
         NJTQW4aLP2+cbAOn+9hZVeTyIy+j40HvIARiEubeaD6z9+nachsSD9/PlaeqdBvwoFz9
         t4fLKMmjBRPuXwe9ks+YtAcHr/VVP0fWu0si/kZlvJNRZcaYiCysLgK3RjpJmAsa8eye
         RhQY/mlOxmDUmOE4pny3UuXthWsWMWYH5iCTKPMpkw2KySWFQDoIYzJmm2QrfUJOFEll
         fqoQ==
X-Gm-Message-State: AOJu0YwAaKtEU6wDdd6OlIov1jkXpX30WaLmSKe29YawUQJYffSL4vxf
	V+RA4z+l9Vz+KvOId8Crgju8KLEKyTClnyJtXrt6cSx9Ls/kp0JAwg4vaKg7ma7LDh76/OjTOWD
	na6RaqYSLejBiYHRCD08G3sBLHbBPhyX8e/88zC3WDxt4wOmm2Y0DWS3D6u63gkvJiYNsbK5cWA
	==
X-Gm-Gg: ASbGncvo0vdHwa4Ph6y17fN7PEdAVpm47FfcTZ73Or70BPdb7/Y75D7G6moKFvSSBl6
	OvBQTUHtBkncdRZ1qd0JuyqTkKL87v+mlOHv36faWd2E5WN6dOBJ4yHgX95elXtZtG3lBfZcnQy
	QsWVm1CtefJ0uyjo4z+IUFCzHmoEXSw/LQYtCkSdrwwj1aAuDOwh+OAtA8Ze703mqdLSy4hVsWU
	9uymBsXhyQtwXooSdWrQCp5VaTTjVL1YnNFgHpXJ+k82LilCQsvyaUNYlCVQF8KoZivr8W7x3vf
	7UP9+IoJZa25HqSTemt2NcIV61WgCn9So/5Hvt17Zw==
X-Received: by 2002:a17:902:dacd:b0:21e:ff3a:7593 with SMTP id d9443c01a7336-2219ff336bamr9115575ad.6.1740087660859;
        Thu, 20 Feb 2025 13:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBQEEy5oWBD6OVqZecVlD7B9fRRwgJ3WVEmw/fiaMF0hm9lsDuFxGkF9PrkJtkp/zbU0HKyg==
X-Received: by 2002:a17:902:dacd:b0:21e:ff3a:7593 with SMTP id d9443c01a7336-2219ff336bamr9115335ad.6.1740087660425;
        Thu, 20 Feb 2025 13:41:00 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf8fsm125252215ad.152.2025.02.20.13.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:41:00 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250124113331.93476-1-nico.escande@gmail.com>
References: <20250124113331.93476-1-nico.escande@gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
Message-Id: <174008765984.757811.7713925396986427174.b4-ty@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 13:40:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: b6GDPYyJtWTm4CDweo_6b4wZ0tSmkAX2
X-Proofpoint-GUID: b6GDPYyJtWTm4CDweo_6b4wZ0tSmkAX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxlogscore=934 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200144


On Fri, 24 Jan 2025 12:33:31 +0100, Nicolas Escande wrote:
> When AP-VLAN was added, we did not add HTT_TCL_META_DATA_VALID_HTT flag to
> the tx_info's meta_data_flags . Without this flag the firmware seems to
> reject all the broadcast (ap-vlan) frames. So lets add it same as ath11k
> did it in commit 5e8a373c8699 ("ath11k: Add support for dynamic vlan")
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fbx: Add missing htt_metadata flag in ath12k_dp_tx()
      commit: af1c6007a64e78b729eb5a8d149637a820077bee

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


