Return-Path: <linux-wireless+bounces-16627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A9B9F82BD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A680C7A4AED
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614371AAA2D;
	Thu, 19 Dec 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LeSb80QG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DEF1A239F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630899; cv=none; b=PaAuBvGMnHbtH+ZyF7CvgETRldWsBZnKzKAGxYCgkuOU/N25qrmYdcBfWGE33R5wmt/O7n7S5JmsynEc+eb5feizEdYHTyTMJFNRCR7I6sJ23CW+tqD+MdV08SUqyqadwmuH/d/sQsnHnwbaqSegrN4scfJ1NBtZy5EVcYjNjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630899; c=relaxed/simple;
	bh=oZwRqy803An+355ixhKoW0TKxaGqD5dbK2vsid0b4SI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a/7uQgTVebXjg58pI23COxiGTZBX6LcgBfSNzDlQyJEl9kb8uo0BFftDCBPBeF/ovYbhS5FTrRH7jjJpx+j/JbQPI/H4taf2n35Kxzl62MxxypWW9JiVBVXpouoYd4z9rFiO5WhYX/lqSNbwBpk+m/CtfFosG7fw3mNUroiQXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LeSb80QG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ8kg7W000547
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VA7tV2ui67rX61THZ5+FlVRr7eM0epEaxOyh5+LbLho=; b=LeSb80QGhzC57pbQ
	vy0j2a0k9IR6erOWMy0LMyZSYm/pcNB5JyhRgokuipyW5VUh56ghcmmuoRmMWGVJ
	aRkhtGgUC9iv+Pwsz4sOEdl/OmOL8yqvlesQHe8JP7E19Ok24zelaiLv1GlJS0EJ
	AReBmd1aLV3VtYrs047hbM3zLpFoJDf3kUGgOX0U2rZ8y64kK2m0g2Kpo2ACcgHm
	tyq+VL15c0brZl2tPWSi1ZMhfEFW772Ma7ZFiVDqwg3u6pn5NrEfNp6KxiG82h7F
	VxiQ1CAY5uDq2PYcMrGJqIBWSj1NnBxa9Yt5Q47QYwCswr4L+4/hbA3iKNoA+1p9
	jLaQvQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mg98sevr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2efc3292021so1397602a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630896; x=1735235696;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA7tV2ui67rX61THZ5+FlVRr7eM0epEaxOyh5+LbLho=;
        b=BsXlNPkzNCITjEmzXwFTpkEc/YbpRMrRLzduFzcqmSFd8ayNx9S8mMH8z3iFVxby4J
         eN50Tw3IAWYjFcHVKTuPRK7juL2OK/0wmEFbq+2AGbzhRbnfaJDv1dPV9uutfrf+YxcF
         dO65AsS+adh1f6TfUIoq+LgYbinVrAZuw8L0Qyt2I8K/eeBTlcOtrDgfpoOev8Cff07E
         jtd7larcIZrQHRnCoStJPZV8ixp7BaYhh0zMEz4c8E3V/nhVnOUBXclhlTWhoJj1mANN
         yqUogRk8Y+8af72C60bXXee/JXtXCanyZLr35UjC4JA5IfmXmZP7BoKLjn4IA6rxRVWf
         Z2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSMXwguujk1TQyXS+t9rZ2Tkbt90d3GAXdJWmv4sYbSY94rJYFmpIWWr4q/7bDHdzzeMHZv+24odPr/w5iYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxw1nDTak9VAAuSegevKcve7sao1wMsy4HUlG+EheIMxA+hWh
	mR2pxQTNyauQrhykOatKfTkxWGFebPMkaz19FbyMenNnjTswoTpRSWkikm41EHgddKJBgmmhfuY
	SQqL747DaweMakznCvX+o8hj6dOQutGLkwJMMs2K9z4UO5O8uKKHGQDJAfaIghFK9pA==
X-Gm-Gg: ASbGncu23UGFVhFdE+UId6/NwnvrWgNLtTOTThOMKOl+/S2Yi0Ur55JlVg8wHTPRl1Q
	wkOp2jKXGvcpIdzagKy6+sO+SvUJrT8+6SAuqTfVV/7CAnlJqm7s7cjHhpvqzJczZEtnk9zvo+Y
	fSLSYI471YbB49jyBKVleBD/kBPiAfnnC3Ev1iDS+ggpqVh0XHUFJPBVMtDCxO45jfg54G6oNNX
	6MKgfd8dNsc7ffEqcv5jNRP5k5QjhSfASieZit5vECTL0n5fP8Nn700BtGaKnJfjFBQ86eh24pu
	WoJF0UNi7US7aenHJw==
X-Received: by 2002:a17:90b:50cf:b0:2ee:f1e3:fd21 with SMTP id 98e67ed59e1d1-2f443d454a8mr5966931a91.25.1734630896240;
        Thu, 19 Dec 2024 09:54:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELG3UMWl1CbADJmhXEaU2YZ7TC+6nbgzolRNVUIHmnFsQx0hXG9D4OQTIDGnY8nNs8qGa/+w==
X-Received: by 2002:a17:90b:50cf:b0:2ee:f1e3:fd21 with SMTP id 98e67ed59e1d1-2f443d454a8mr5966895a91.25.1734630895835;
        Thu, 19 Dec 2024 09:54:55 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fdfdsm3630628a91.52.2024.12.19.09.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:54:55 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241217105505.306047-1-colin.i.king@gmail.com>
References: <20241217105505.306047-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] wifi: ath12k: Fix spelling mistake "requestted"
 -> "requested"
Message-Id: <173463089453.2609009.334897453986903182.b4-ty@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 09:54:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: YBKODTzfS55AKjAcAFMYKl-RQRBh16Od
X-Proofpoint-GUID: YBKODTzfS55AKjAcAFMYKl-RQRBh16Od
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=962
 clxscore=1015 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190142


On Tue, 17 Dec 2024 10:55:05 +0000, Colin Ian King wrote:
> There is a spelling mistake in an ath12k_err error message. Fix it.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Fix spelling mistake "requestted" -> "requested"
      commit: 578f6fc55c2ced5f68a7f87edbf6db3663dc6b57

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


