Return-Path: <linux-wireless+bounces-27109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5448B4961E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BF5167433
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FF31076D;
	Mon,  8 Sep 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OJIa+OnN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276730F7FF
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350199; cv=none; b=QBjy6585gxiPrgBKTRYMms048e8vjwG4ejqvMYImp54Uj5Nz5x14c3LM2D2obI2yghZfCRtUPxJHUP1tWpCM1jpbl4Mn4c2PehLt0KXtjt94+Y5Hpi7+eOUwvp3PR88TwtSmwTMBDG6DNYw7hKHyoLtappppSht82hUupf43DZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350199; c=relaxed/simple;
	bh=/9CQ2OX3PxqBt7H0alYZbdGyWPsxjbARuPidtipLk1k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZvAQ8eMmDHmEuiKXG1K5axWeY7Ff3937QEdPYa1eJI3C6TG3/jR1K4xdaqZn8Vx1hosAPCKtA/CV0KmiwMAHw8dPGThCRmcA0kg2mtj5ud9LNESLs6h69crV+cdXNNNe0rN41K8cbYhwOihuWmxv1uxl5xlLsvkNiI2rwlqJpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OJIa+OnN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588FtjK4009012
	for <linux-wireless@vger.kernel.org>; Mon, 8 Sep 2025 16:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dg2UgokEeWhMc48JRI2mp84dAZ/f8bS+61znB0C+pvU=; b=OJIa+OnN04Ie3fWo
	MlrJaDYr5UfsJCOk47esyBzp/1kdLAWVOZyZCkWDJkT16me5b/sigwnmOSwSMHLi
	Y5JgRGOCA0sbkQYuF+R2YfrUUISqEs1KJMBO/EnWcywiSjCgcWp6LrE8gPadrK7l
	DZuZqXW6XY9MIrSYuWkD4MVmNtkaBlOjIzq/ev+AALmuTEaRyKe18UJXJj4CNZqC
	leaWy86Wg8kMkF5CD2df1zxyVM/ZOORFpCcBUMxexR8ow364aD6rMR8IsWFj9QbJ
	fd0f8GgDAxDyDupNHJBIJu2t8LxrePjqWKKC/6krQ0OTM8aD0foag/NqJ/5MvzIQ
	i4RrDQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a56wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 16:49:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2507ae2fa99so64551375ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 09:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350196; x=1757954996;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg2UgokEeWhMc48JRI2mp84dAZ/f8bS+61znB0C+pvU=;
        b=Yyb3dEcb+9gWu9Xx+qPTB9f2qpBzR921VTKCTU+nieVlQfoWve78SGPoLDmldUaWfi
         rePiYr9prBz7hviGsvkPWp90rIE/t3AhUrOvi1Q/AIYZADckHfv4j0GtjDsQHF+J2ZpF
         ucogvh6KZmkfYFmB68zUVJ6+Qyte7FLjcgyGk5wRWxWxoWhFCrpYEhko52QaWv+bBY1Z
         4rc/r/Ztds0egSHG4hIfrgyt2EnnbDS4B0dwtSX18BE3NCjHp0rEjc1hJySWjHq0Fgf5
         UBdfuUhEfGFcutoTiI3b9xei59zLfzcs/Kg6w3slLuejFUW3/ZqA2lMCOAAQ4F4eSyPh
         TY9g==
X-Forwarded-Encrypted: i=1; AJvYcCXewuLaLflShZR9qHuxIhb6h+KflWl6vHIEs7n/5JDOWcjNIoMn6lw9WFqWBeGEgj26ih8JNxTNEl0lzamkEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVvDle/LMGOtFCPGhLyCk9RBHzY5xErpCyw48SpuMVr3G05Ir
	a74pVlWa0fexyYtiqRitOt9diuaYYIBMBf9OmS7ZEioJWgGqJv50sCPtVsSQ8vclvjCWXUKbXct
	dB+jGjyshb7d3/fJx2fe9RXK+zApi8tbJYIY8CSGqdgHpgaeqVYBQNWRq1eKhiLicBRQfR7w1eH
	Bssw==
X-Gm-Gg: ASbGnctqchMu5oPID6NML7nT/ja/NN9reVtxckBwyQPO/t6Z1WAzCXssMum+QlcLYn8
	A+WIzZgp8aaENg6l6CS7HrcMexjmYM1LU9SN5ImB0Ssle0thMgHIvMfL2dGp8sIHEBvVBPrkx/8
	o5197j2knAOsrZ8rXAJp4vhk6u2NqVW7b5npxytUNCF6ZNPihNmXbShKL567gVOzJz6JNvsE0Kt
	rFFXAuA2Dfdmd7g8zOf/QKEisGTXMYSaT6Qi7cq3y7nHAxul1cZ7iaNH8ZY9vwDD2LX3cd5WfeJ
	kfrlGSS1MLn7Z+foITvGnVvKV53Dh5pfLPmMoP2ErXfRkJTORThZHvUSk9xKjnc8Lw+a0sOdvhi
	/
X-Received: by 2002:a17:902:e850:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-2516f050554mr107248835ad.25.1757350196252;
        Mon, 08 Sep 2025 09:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+zIa0x4vuPGLZMXZtryawOhYTo5+tSCWHHkxGVO7NzqSam/ERzYOoCQyK3wKgWJuklzisg==
X-Received: by 2002:a17:902:e850:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-2516f050554mr107248415ad.25.1757350195711;
        Mon, 08 Sep 2025 09:49:55 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3147sm130460655ad.73.2025.09.08.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:49:55 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
References: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix missing station power
 save configuration
Message-Id: <175735019498.347840.10113935121682584580.b4-ty@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 09:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68bf0935 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JgkEKiiD5wMD4hIjs0YA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: WdVZg3uuXQ_KrCA_2hP3Upmt3Afr-0e2
X-Proofpoint-ORIG-GUID: WdVZg3uuXQ_KrCA_2hP3Upmt3Afr-0e2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXyFzD1pJPpChT
 Y+IMzeKAe8pWTjF9VxJGXJ/VC1/hCrbR9kAvj4FobIWFQb4E2Lhe6GZFqoNdcelqS36z9WYXTq6
 AQjPov0DV+7jZnWewZKAylDH8VhqPdAQ08iyPdJd0Vvg2927LxdyQhSUTme/Twp0821dbNFHWGy
 u/r/r8ata4mvknULqP9MzSVyi5Nb7u6ARfJswHMymqu2w5d1frQG/cx0OWJK+DgG1vSQOTJ03nF
 kY9nIm/jBYUUBFDiiIFdJuRPfuAvt+n23Y6fj/GSV9ERGYP3uDrV5AWtkykCquBEnx0jV4xp5ra
 70w6FjktJ0z4kEmNdFqdCdDhB3j7ubJaCf12ggHIzafcKaWxVGmKQ01OzFDp4YGc16guQU2RiFG
 EWR0Bc8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039


On Mon, 08 Sep 2025 09:50:25 +0800, Miaoqing Pan wrote:
> Commit afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed()
> for MLO") replaced the bss_info_changed() callback with vif_cfg_changed()
> and link_info_changed() to support Multi-Link Operation (MLO). As a result,
> the station power save configuration is no longer correctly applied in
> ath12k_mac_bss_info_changed().
> 
> Move the handling of 'BSS_CHANGED_PS' into ath12k_mac_op_vif_cfg_changed()
> to align with the updated callback structure introduced for MLO, ensuring
> proper power-save behavior for station interfaces.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix missing station power save configuration
      commit: 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


