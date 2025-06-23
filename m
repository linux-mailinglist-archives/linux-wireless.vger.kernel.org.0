Return-Path: <linux-wireless+bounces-24351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B3AE4767
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054FD3AA320
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BEC25291F;
	Mon, 23 Jun 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8DpsJeA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0491A01B9
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690123; cv=none; b=j8xbF1MKDuOT/kNQQsEagyzCdJu8F1/+hAYVQDAxUXdiy4xryFkir9IBKZ8sei1zjS6Zz0lX6FaOsa+4oJtF/T8oOrj6Q/mxQmAchbfs3BjbQvzVKhpK3TSAbJRG2irPwAfMTHUooCUtg1vjrlOTdCuJ3POgrimWvsTBV5An1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690123; c=relaxed/simple;
	bh=Py+wieluN0yqvBp8e84XQcExinwGrPcWz08OshliOBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rIkAQ20gt/zHlPhxXTT8IGT0epzEDAFqV1BEQQQrDB/5FZzbkSI07vkMhkVxh/rftBnIi9YuhqHcvuLduRC6AItrghCbvF6JT6/oyYIJgby/ILIEflWOdGG+LndsnkNQ3L/BPK5SIlYQ/MN/WlNp2JDGR06ynFN55/U40b66/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8DpsJeA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N91suV004238
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GTgcOwD1pQslP9DjDPthnl7fULdNoTIo2VyDHxYti00=; b=L8DpsJeAEox99YDa
	kp+4XACYtiQN37gU5VWpXmOs10KDYkQkgJAttXyruX43vtpnQzrcwWlFBt9f3kTd
	OuCh4yb7fZYqRkiM7hhzRj2fUOlryiUrRr0odstBsc4suGsBAdIkgesKYQHr1sYC
	HFk3l+wMPKYM5CdX2CBVu0VI65D7yEmPtZt9Ss3UsuVXL0cVuDoGQfohZw6HjeyL
	XTtk0sybpBUXyFhRi6AG9B/QQngiGMP3Bwk2+le13JJJLqoahjJPmxOiI0xqwTE1
	sD52pFN6tW1wIOT/t87MJhVqjDAgjDZ4B8IBcXZDU9N/Dn0ta3+TCNY9TJoSZl7h
	9tcgnA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4jatr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74880a02689so3512893b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690120; x=1751294920;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTgcOwD1pQslP9DjDPthnl7fULdNoTIo2VyDHxYti00=;
        b=sV0BkMT3IbcQjv/lzNLBk44PUTBUi4gxW4ABEH/yyzUR+rHSIN1CwKFSz/o6vLstgH
         l8HyfmbmfQVBQoz2lItslvuKjErtiG89E8vCs9qlQDEsvpo/fn+eX0dQOaOB0Sk5ySiR
         gtMV2e7iYq/8qfmf553STUTuYMq3OrGJCJHLVuB6/ugvtTgvTzEDu5pjYtugTlrKnGIB
         GqiMC9tihmbLneD+xXrogQ21Fmw1o4uVRXYqsRdW9u6JXNEnoxykY6b/EXh7B3Dz47iQ
         YrgR6vUYJ63mF0YD4Yd2hKxzQyCGfH+nO1ztaxp0UHtUKpgslyYAl+BGGH7fDu8Rjq13
         objA==
X-Gm-Message-State: AOJu0YxVjCoON2u8WSkg+jAWxjmHZUD5ru+l3+KbmVcVis6K1oA+1QCz
	stLgBUUqyrsQ9omgU1QJlR1zE7fuHCCx/jWmwFSjiNuGXO8bMkCiEY/eJH1Ngj+0t/6WrQtLzC3
	FSbLj6oO1CEsNHvSh0PKEbR9yV9L7DKsR9ZCm6myCxJ/ZdNgfRhXPHaFJEUAHZ5KEnL0+1uwgy0
	2BNQ==
X-Gm-Gg: ASbGncuwGAYKw3dzBTDzEuuLJmg3yyHHev2w4OCXymDn8SK5VqGXDF0rKYOApnPm1+9
	tdEB3B55sQnNlrS1qYPXn1RVvSLEhRn0B4SPplBUe4drr0EmOqVKprgSbuGv1VGjC6SETM1LYIw
	AqS8If4Paqng0OtENsE/Lvs01fFeS/yiVSsGNqjYl1oCgFL88qVfJenQlNZVmOPOd/6EZZNeUis
	wz1o45brpRVa+dqit47tZg6TWeIUa9hhQtYO7vILDfpPAXsHROdecGBKzn8wjhJz7F2G7IwbjwC
	glpjngKq0n1uFBg4fbF/YgPzfVMD3ZiFhTsdYA/R8cdy7h6Xohh18gNL+sA=
X-Received: by 2002:a05:6a00:8c04:b0:749:122f:5fe5 with SMTP id d2e1a72fcca58-749122f609bmr17361329b3a.18.1750690120294;
        Mon, 23 Jun 2025 07:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWmPgPVshHE/zr0NNaPcHLcbCD7fabUaWYiCqu25X7F8XzE1bxZybvxOBlBA18ztADQ3B0jA==
X-Received: by 2002:a05:6a00:8c04:b0:749:122f:5fe5 with SMTP id d2e1a72fcca58-749122f609bmr17361289b3a.18.1750690119838;
        Mon, 23 Jun 2025 07:48:39 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250618185635.750470-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250618185635.750470-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Avoid accessing uninitialized
 arvif->ar during beacon miss
Message-Id: <175069011928.3758471.16087243533484607785.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=68596949 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=WQS1YfXabkAatbxEeBsA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: uy6J3Cz5DQ46b0F3i_QEZHEMwWDS1dMi
X-Proofpoint-ORIG-GUID: uy6J3Cz5DQ46b0F3i_QEZHEMwWDS1dMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX/fDCArv1POP8
 Ly3JZlJ+TfSeocSuL1zBhJbTiBjk/4S4dyin3jJLRgy2RYNuT0FJSOz2ij6Ex9ICQEHXLRGjk0w
 CcM3WHypjFSjHUXKHvmsSmW/GXAFMsu+70j+x7b0QbUJdpjFyJBW7rKEK+xrJaLYZpRUVnAMchh
 VXeupVZ2vSjP34dzH4n8S6JqgWkbMBy0vlYa7GLF89F1VlPu1iPR50S5EeuhnJIbKywGnail9mN
 AcxDvfYaxfsjjGYNotzrx7Lhv+jCLXP8GdMV9xaSH4//WeFxlmJQRWrPgElXX42tDv1rYOmxWaS
 8M2/ARGhjxGZwNdCvmuSmezxKfqv3VhZu4JUvM9Ok4WoLGIds0gkXy+RnfWwP62klU9+i4PZVzi
 QgkUdDRI6bYKclEj+KeXz97DR0zr2KLcTxdlNm1Gt7O6EShSRR+ZL9fHbCCLiJuF/CGk30am
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230088


On Thu, 19 Jun 2025 00:26:35 +0530, Rameshkumar Sundaram wrote:
> During beacon miss handling, ath12k driver iterates over active virtual
> interfaces (vifs) and attempts to access the radio object (ar) via
> arvif->deflink->ar.
> 
> However, after commit aa80f12f3bed ("wifi: ath12k: defer vdev creation for
> MLO"), arvif is linked to a radio only after vdev creation, typically when
> a channel is assigned or a scan is requested.
> For P2P capable devices, a default P2P interface is created by
> wpa_supplicant along with regular station interfaces, these serve as dummy
> interfaces for P2P-capable stations, lack an associated netdev and initiate
> frequent scans to discover neighbor p2p devices. When a scan is initiated
> on such P2P vifs, driver selects destination radio (ar) based on scan
> frequency, creates a scan vdev, and attaches arvif to the radio. Once the
> scan completes or is aborted, the scan vdev is deleted, detaching arvif
> from the radio and leaving arvif->ar uninitialized.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Avoid accessing uninitialized arvif->ar during beacon miss
      commit: 36670b67de18f1e5d34900c5d2ac60a8970c293c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


