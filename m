Return-Path: <linux-wireless+bounces-18330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D80A26722
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 23:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D6D3A41B0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE272101B3;
	Mon,  3 Feb 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/Brbjkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A1211A06
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622958; cv=none; b=DV5Q+ksgQmWkwJNFOc3mrLQqsmLm3j4HdK0vuqCDLxkFhjhkUJyFBAPjBWxRx/G+PybyIaWtbe/aZrshDyrF2gvAZmfhJJWsq5+78auLDGA0YzdOGpcfRGosVCY47imPoM33X00f6WLMddMaRT5Ulx+KrcUx77QHuv9e/EdxAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622958; c=relaxed/simple;
	bh=fFIsTmRS2CT7PxjknTNedNswoPmgBp6lioXU+OU80Fk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F96BrDBUTLNv1hm1Drf/xyBNy2kWlUCg/fipEO+OcW8OxOkOMJo1v75ZA6t2ygQizReF0bAlDWF1jj9yO21OoAswox57bqS3Ak3AJuXnEMCVZK4GmK9o1umDNYEkIxYywK4SNBm5j2S1x6UFB1aOHO7GmQbOKZCfQg9JTPCI9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T/Brbjkg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KROwA028458
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 22:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wBPNZd4PRgKycBmyjDhvYaIoIeOcHmWZM86wacoyZjo=; b=T/BrbjkgCmLcuKXV
	eu2TzjA5kDevaWQ6MxgL196gkh0trBcOPP6fPtidLIYbFoTiHKgwP1Hn2s39So0U
	a6kRmPg78MyL/OTiUBuFa1yIrYtFaick1FSRQXAjXpc7t7WwKnEABT2P9XAG1Jpx
	1MKYa6j2qw4k5Rfzq6HS0CqGs9lvUOQg2I5nqxafLUs0kLF0QqWoo6Kfm0O3in/D
	v6cy6MyJRU2RqCbqHhQ8q4uLBoU6yd9Hve75zI5nGuc/07kr5pQ9aBf+pwXAqTJv
	KUm2bzBz4xNIFoxWHkbZvxmhPb+hVFqQjm1wOpHmDq9SWAazAhbFaCuk86+ElUT9
	Wsvp4Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufr8h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:49:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21681a2c0d5so93761705ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622954; x=1739227754;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBPNZd4PRgKycBmyjDhvYaIoIeOcHmWZM86wacoyZjo=;
        b=nqlz2lvfDzHDYvy5ZnP3JnxR0BICHjFYJesRk01Q1W5xHcPuS1pKnxTcF3EFMPRQuq
         Po6uBmymU7qcROf4b91ePav8HIBDaFheOEe9Ww5zgHKWUnq/u5YTAaebiALPYiCv09ue
         FaVo4rEvgB1eK2yQGwlwm7z83ji3aMl7B3FfmCxHYF5s29PL7UGUtbQ4zg03jlBsSxVe
         B8ow70iBzN4+SO43vRhtB4WeJ+gIaTG1UlZkt5DrwO7K1rEFG16H5dxNB8kZ1ehGaQXS
         so7Fp/cv11SwE1m8GFIDHfaJPE3+qBwwJupLf/L83sWWCzcEStlKnxf3C5cLZMgZzG8l
         DjeQ==
X-Gm-Message-State: AOJu0YyT6IuTvTENf8Hnh3iZtG5XYq2QBaBpqv9ii0IJQnlnZsUm0nqi
	5NrtNpYRHfiWRv1ZpPk2ZmBNdrodCQGfG6xf82XDedLMzOsEgmiq81U9pJFNt8W1NFde0ptM3+l
	yVKJtopjqoDL5bA5gHkKd4TOUK11hh8kUZhFYFnYDXReUFZArAeiOxGHz0vT4ZHqNSF2BMyWxqA
	==
X-Gm-Gg: ASbGncvF2KeAhI+At8Q2413ah0PdAWDBx2BhZ9K87BwcAm4gnQZ+tTJradzrEsuH2nH
	UMvXkta3QC7k8fLmSJEZGR/sBzQqVxz5cAVrNlYpImaFAHBmy8LznwTkzHVsjIVDJGJhVEwWTuK
	lvrrnARQXGCAUsttqZ8G0bhfvnTA2+TvGppNUnZLwH1vV8RfebLQkSPLEowOBTd2U9AHsH/TBwh
	vjj0Q0K8hU3FyzKAKz0i/3R+fmZ86++lxH7ChP2iOmxqzniWyjsHTYezW2jVmIHOKHzHlvp+Z2j
	ORZSEmyVbtU4x7ZHf9gWDRmHSrbH21AR1PYRpil7Jw==
X-Received: by 2002:a05:6a20:6a05:b0:1eb:48e2:2c2f with SMTP id adf61e73a8af0-1ed7a5efa87mr44743402637.30.1738622954048;
        Mon, 03 Feb 2025 14:49:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFpGz9EDaUNWuzYyYtq/xpl/W+Lzv4p7XgJL9p5ZOkMlODGqlM3XWKKonWHwyqH6CZlEDo2Q==
X-Received: by 2002:a05:6a20:6a05:b0:1eb:48e2:2c2f with SMTP id adf61e73a8af0-1ed7a5efa87mr44743377637.30.1738622953666;
        Mon, 03 Feb 2025 14:49:13 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba353sm8887444b3a.112.2025.02.03.14.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:49:13 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250124075953.2282354-1-quic_yuzha@quicinc.com>
References: <20250124075953.2282354-1-quic_yuzha@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: fix wrong overriding for VHT Beamformee
 STS Capability
Message-Id: <173862295307.3734728.17015515287970538991.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 14:49:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: UTIFuxJ5ZO4YO193uFfVXTNIP5VDbAGb
X-Proofpoint-ORIG-GUID: UTIFuxJ5ZO4YO193uFfVXTNIP5VDbAGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=571
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030166


On Fri, 24 Jan 2025 15:59:53 +0800, Yu Zhang(Yuriy) wrote:
> Current code in ath11k_mac_set_txbf_conf overrides nsts, which is
> incorrect as it confuses nss and nsts. nss is Number of Spatial
> Streams，nsts is Number of Space-Time Streams.
> 
> As mentioned in Fixes: 55b5ee3357d7, the nss used when acting as a
> beamformee in VHT mode should be reported by the firmware and should not
> be greater than the number of receiving antennas - 1. The num_rx_chains
> related nss rather than nsts.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix wrong overriding for VHT Beamformee STS Capability
      commit: 9d13950acb2a51342c93c69f1a5bf285adb90d88

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


