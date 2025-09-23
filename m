Return-Path: <linux-wireless+bounces-27592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA0B93C29
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 02:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295EC19048A1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 00:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091E1BCA07;
	Tue, 23 Sep 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZ3nCz3l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6F18FC97
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588938; cv=none; b=tzDKE9RrPI62aFxqpZ+WA78TKwM/3aDPUq/9X9LZYrlIXgtjqWaO4C/uYzcrfxwUVj7VOSgUufJlRO1eNRTWPwo5+jKZhTzzAYOqtFUnkM+55IbeayC6x4TKBy6d30nXFm6xrPC9597SE7J7ffCshXpScBtR63OyjkuRBEv0uDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588938; c=relaxed/simple;
	bh=r3XfxCtze3N6fvQmIZENh4/4/Is2JvXIHoPY2CVVME0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E0gWoGsC/IJlWAetN28rOEWH8p5UAHx/DamdMR/JVBuQuZXf7P4CvHQokCZ365JJtKfraufcrlCkXjEBcwvae1fv+9XCqEMJW/C6yU/WOqzw/+D6nHqPa5+QTw4l+I4j/J3Zpy/wOLNjx1UfXdmS9vBRALGMMNGp4jSL+bsMuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZ3nCz3l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGCEs6009181
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 00:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NOb1UnHXBdMvECMo2QSGZH2wkRTlB3W1x0spXCNEWg=; b=pZ3nCz3lXzeRJLMp
	6plYcsHUyHfYocf5enSbYSuwcmM3ReJTcpMhk8VkHtfCCPOlYBMSGmagC0QgzrBO
	p19aB+hsdHgSKb1ZpYu24dYu6xdGs2+oXpM2NhShBpKlUOeRAWSz7dytaRnoBxDl
	QCbqzl4xjqnC1oxxWRcgwj/HtcBaGWy84TXDFMXLzWib6hv4rIgWqh7ZGrqT1i9r
	9LY3i75SwnaFLS1ZpQv4PzSY0CgMhpC2TZKKltMHk5Jq2Yu4E6b4tl2JLnp+yzUf
	+Y6nr8TYN+HBZM5y/Id2eCCOUbBY4BIcaNFzNk7yV+wy5rUbYL8iqCGf5jbhRbWp
	flvabg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyepw44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 00:55:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-272b7bdf41fso26758955ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 17:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588935; x=1759193735;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NOb1UnHXBdMvECMo2QSGZH2wkRTlB3W1x0spXCNEWg=;
        b=E4FZfo4yl5Dvmk9Xwh+Ps6cA1g+nYzYNhCHJT8tAf65LUgpBXOmZBT0W8G0S3tnBiz
         eqJ6ou7DvCWgz6yyylzmbtavBQPicsycZ53l0202tnfNOMDZMMJ0jFVpf1ghSPdpEE8a
         40gPXFqUMPhk1D45PtGJhaBgtlA/npMZglZHims23a/R8aHvRFZn60YViLS/FhtfBSBa
         XwH+6ymEimFj/MP7fw1w+7wLNFSdINegAPnuBMohYxQ0/Gi45Mo6P6TfXJ5h7iC0kmzX
         9ytply5gDVql1JkQLAdO5eyVeqXeEb0N3/Au3ENL/dClWKknvRw0QT5Ppl0yDKa8PEkC
         o5EA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Wz7US6lKlFD8ulA8EZxZPmA0UyKmtcdVR6JIOTdV/fiudjSvOk+m0JFzIeZ4qaI8kQuIxbWyiUkYCG+sGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQ7DKr/8ok4S+OIYvDw/jfSajRbzDch4VNHraoOoCh6D8kqi7
	2yvzHcrYmpjfn2BZk2XiZa/Km0RGO7WnIWyoh7zrDj9zrFElnibUGMFIxUV7jbfO6yDoHY+r+Vy
	5tnMjBf44e5HRjKv2qlsVsugIXblm+W/rHgxqIqRvBYfDTKFdfuKlgc9T9OQJDD1IZHqzMw==
X-Gm-Gg: ASbGncva2mbOmvM0G2TUUr4QXajKg4XDYQnIpyfTa6oA0Z2FGs2e9OUxXOu3IXA9CnE
	FnDWZ5dRRUtvIJSB4bDkByfGmgPRHfEUyf/e6jmjUDrQ5A2TbCMnx1u5+svpmRGr6sfnRSzg9Lr
	NqzmX0VFUsXgT8NmtbJallxLF2jIaNPAZ3mv8ZjYIuGacvQbPOYyoITDUD2KGUpD6LKEk4IJ62V
	cx2GtuFsnjM1SOjgfFvj6Kb9puFXLtGh9A/O2Xb9hGJ2uKxbLvuBXEZgIke+osQbQgvY0WtiSkb
	0TmDnQkAWtao5csvBgjefMFVCCiNufYIco6BlRzLt5GL7It5tAuQwJUvUIVOVojAH7/jFHRQQUK
	U
X-Received: by 2002:a17:902:d504:b0:246:de71:1839 with SMTP id d9443c01a7336-27cc696e83amr9635825ad.50.1758588935173;
        Mon, 22 Sep 2025 17:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgkK9eoU6vOWVlLO/FmLK8aalMDc859rdHBZhi4f6aTg1dHIeLHmkfnD2xmV3V5/OgUWynjw==
X-Received: by 2002:a17:902:d504:b0:246:de71:1839 with SMTP id d9443c01a7336-27cc696e83amr9635475ad.50.1758588934766;
        Mon, 22 Sep 2025 17:55:34 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm145381435ad.15.2025.09.22.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:55:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        kbuild test robot <lkp@intel.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Sven Eckelmann <sven@narfation.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Miles Hu <milehu@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250722053121.1145001-1-usama.anjum@collabora.com>
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
Message-Id: <175858893357.360026.14313486300585429827.b4-ty@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 17:55:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: _tEVIEZ6YWBZ_zWKz4BT-R6Pb426SyWG
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d1f008 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AgmplPYfmL6CJUdp4g8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX1uIyqmY4mEOL
 banv8D/HZ1lwBwPxm/j0Ur3IvUKKRm29jIXTM2xXSlSoHaWwjFqEPCX2WkrwBzh7pSzgNH+01vn
 XCIw2IEHHx5QSxdn4c9fdByNhgBVWE+sU4ND1LyQcAZQD98rTvFVjzuAhN+rSjfj6FTk1ROXEkv
 5UjXgxQwzH4u+SlWmvEJUdShchn0Mc66jA1cxJzpxpThN1lB2FJpvRZuurQfu4TFOVF+U2Klovs
 ODGIPjIORPvGsrbr7LsvntqLysgw5YWz6q7dcHw9Ci7cwiJkziNAqmycCKwGCksy0T+B4kQ0dWV
 JqAuCUXTXvU9byrgeonusN77sNKpZQUOq7ilj6B21WWjqccf707iFiHZPcnU/jPjU03Ob6x8gZ+
 JH51Qb9r
X-Proofpoint-ORIG-GUID: _tEVIEZ6YWBZ_zWKz4BT-R6Pb426SyWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004


On Tue, 22 Jul 2025 10:31:21 +0500, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again
      commit: 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


