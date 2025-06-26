Return-Path: <linux-wireless+bounces-24582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4BAEAA56
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F8B1C27218
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D022C339;
	Thu, 26 Jun 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="goQpgdo/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF43218AD2
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979721; cv=none; b=o4RjjVdqxA7nMAv8KPKtEb0nxExKn3OwHC1n6Gx09jmtIsNIF5J1K3pdaPbPq4t3kj7et9Wem8Ot6O2ZJ0b9BG6xu+vfwsd5vz5da2s+oyGqkGtam8fp4xCD6jzT70PfmLseIudR2qVRxs+QiPExlAaugmsV2wAdxJD38D1GeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979721; c=relaxed/simple;
	bh=p+rQuKW80mrU11o0MRp9eyFQfof+vUyb4O3+JceI4NY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y7htzNVU+3djvimJnefgNQ8v8FSQ2/Me3BTwqcxcDAIZfr7OU0WmbCvOhlrYqqfrA5mPetIiDLbKszNSAue/jcHCzWZbsJSmJ3VTri8kAHA3RBMzpHebEsYb50vdotQzeTf+Bg4Wh6dcjQGOzLwVTLqEkKJr+8MMG7inq/eqMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=goQpgdo/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QHpV5b006382
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JpUrGZ/8sOs/7BIRrOcCuGlh3xzBiZUoba4pzlf4yuM=; b=goQpgdo/L1dxI8rZ
	SskNHlP0oIs2tkOsFFTaKRRakWYQZBUeUQcskQrCBVUB6xXOtyiE+nL9XBxiOx8R
	OJFSF9v362AOM4EOErlb1KDo/N9XCWaDkt/EvKF6jbRRGzljqFFD08FLnsQJ+Ytw
	O9fCGjXyeF2mTfEUdCOabiziJfO9jlhbzwTGn2pIitUakK/JrNdzCgVw5LzauRyz
	Z0ZRYI9hnNhktEaL4yg+IZ0bYqQddYxnPrvL1bS0i2DIvscTPT1ul8BbS9rowsE1
	psRlx82eV/WiU+alepO7p5jA1J0y5OUQyWq+48mp/ix5MTynfTK0G6uG0apQzxNB
	XCovUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmxjpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235f77f86f6so13116905ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979718; x=1751584518;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpUrGZ/8sOs/7BIRrOcCuGlh3xzBiZUoba4pzlf4yuM=;
        b=gCcUjVt+WSE/JpyFt6bzwlQsN66nq3Qz9bpV4ZJqJmrguqUvqdRqNqq4SeC+lovRDG
         hibuRsXjZx7YYRNwf7mVGhN335fUOaeeuLmax4nB1Hq2esH++G8SCfFCBjgbMaD2QqqT
         rAmbkWBGLR3qurBon1gAXJU3GiMgbiIbRUyCKkUQ1gINP19Yqgt3cGlJ60DCjLxuHUFG
         47pk4lCiYF7VOvRGST59Jw6gOczTlZXCo69YguvQz4jNs/Gj25Np6k1Z6cuzZLrEbYbk
         l+M5yDbOk2X6kkkXfsEXq12o9q6nBBeXos8/wZm5ReG1QymDtyOsyw5vJ3iH/ZWgZRJp
         ciWg==
X-Gm-Message-State: AOJu0YzBaftk4ckXxyrskJj7oDdrNtGgU6T2lHgye+GYGofp/0tNGUup
	5GauJwcdbgctUhxwuDkahdolfvehmaXEmdPjIqPht29j9SKEgvN0Spr96ltV5Gntqa9PzigfEJc
	mC8PJL9fVb0kMUi2qyDOuTVatYfCSK+aiHmHC0Sm1GMuuDfAoAAVDLiaZGwDnZdghY8RD5Q==
X-Gm-Gg: ASbGncsn+sPxrS5DEDvUUQPFy3iTPFjU3YAjKDXyPafGrSO5wQJszm2wzYZthwBEFHz
	5xIAKBs96BsIYltT4Wmy85srOQTPNGPmqp+ZU/qxVryYv5srD9B2vXOiJD3RchQ4WKmHUlBEsP5
	TNErju+32fGJAEwRODJC99vColhCUJ67lpVYxSkgJpFRrjBgpSIPvSljfVrpG2gBW4fdRpATL0M
	6yWfjxqQIaKMj+t6Rh6TGFmB0xc77z1SqXN6+nNbbJlFVe8OrRhHt28+Ne+nLfjZNBasw5Tnt8x
	1H6fI9Y0BCjnZhE1PmfkEixykAtl7SPA/tK8VmZ7Ybsasi13KqJMHJcdQ9E=
X-Received: by 2002:a17:903:1c8:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-23ac463414amr15616695ad.29.1750979717950;
        Thu, 26 Jun 2025 16:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy5LDu5rsUxR0pOFigKbIZekN/414KFHps9hjNJyAoI7aMDBKuAZ2qefbYsZG//fAZGwucuQ==
X-Received: by 2002:a17:903:1c8:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-23ac463414amr15616165ad.29.1750979717377;
        Thu, 26 Jun 2025 16:15:17 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:16 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Hariharan Basuthkar <quic_hbasuthk@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250606112316.39316-1-quic_hbasuthk@quicinc.com>
References: <20250606112316.39316-1-quic_hbasuthk@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Send WMI_VDEV_SET_TPC_POWER_CMD
 for AP vdev
Message-Id: <175097971661.153431.4409140578529794002.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: LgSGweUYCK1zxB0s6sn4ndtTbkxWX8uD
X-Proofpoint-ORIG-GUID: LgSGweUYCK1zxB0s6sn4ndtTbkxWX8uD
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685dd486 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=Ca_dcU4mKi5WET8l3hkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfX5pzI8ScicHPv
 yTkH9xp3jquHNLNuWJxlOt15FLMd5We8WIE9SNlZZDs2orFD5z/hX8nlOcXUEu2nDAgW4r1qMiG
 K4+l4sPbO2SNv0tfxodA5FzvcxHMfv7uQw+RVqh0yRBvVK+X6I8ajsiipwebECeuViCAzFt8Mg3
 SEzjBsXdIl0BKkfehzaIx+NcCxgEoY1ziSv43oE+e7SjQDnfDCuVOlOPjnOe7sIV36CdlQbMLTZ
 MqRya9PujULZZ3tsj3uB1bJUvR3PyimYCriD5GBg796IdeNhBWxxxw15Ex9TADIgOWZxxKU0Xs7
 ZFPF9O3wIx5H0fUc6NbuwaK2NGZ479oyP5LxXXzDXE7MMuTHFOZraqbvMQzPGWC7Q9b0SvA35v0
 /jl6lMK7oWX2v/6uG7noUsZwMStV4D8E/agtIvZzlqNWzw13on2Hvqdm1hOn/2etHK4wd6DW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=790 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260200


On Fri, 06 Jun 2025 16:53:16 +0530, Hariharan Basuthkar wrote:
> The power value is 6 dBm on an AP operating on the 6 GHz channel.
> This is a very low value.
> 
> On 6 GHz, the target computes the EIRP based on the power values sent
> in the WMI_VDEV_SET_TPC_POWER_CMD. Currently, this is being sent only
> for station interfaces and not for AP interfaces.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Send WMI_VDEV_SET_TPC_POWER_CMD for AP vdev
      commit: a44958c83e52238996a48e7d604167c9b9d0a529

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


