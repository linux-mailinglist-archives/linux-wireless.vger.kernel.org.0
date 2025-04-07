Return-Path: <linux-wireless+bounces-21200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805CAA7E460
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914F0189D422
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB051F9F70;
	Mon,  7 Apr 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WFkpJAXc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18B1FBE86
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039439; cv=none; b=tx33mJsd7Jog9ZK3Vg6KBnLDp1yMvEw+8EVC/KEd7JZI+OU7QS5kPNPRdT5WVhlBTJq1QffOgyWRnOnBPO+GZ8EBNPEIG2lsr0LsVUa6GTCjGqAM3nByL7SaPjBPZicTfj56HtObpRbXObiHRlxVvXpXw9U/QJOLkkIg1Ib2h54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039439; c=relaxed/simple;
	bh=PJhfWfjrLVJIUszTIrpZT/xCEg8DCZ9SS+vujmLA894=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sg8sR20DAM6hC/IlXuLtSKGJcL/2ldNavvApW+3UMlJ7l0DFhQSp++jK3TkS27zKEB4M1cpFofbkVeUarhW7H1yXE9lMNRfmq5U3A0oCD/GRUcOgmdrNTPyqcxZQBEo3AN79bXJMmT3k2OrwcFM7wXicJTMaTnEf0gUGNVMtm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WFkpJAXc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dqTa013398
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 15:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPVafLpZ1KQwgoYIl+VYcy6p2KP5KKeKiX8x9rBQclE=; b=WFkpJAXc16TXRxzc
	tMqgWDVFYngGdOTnMUc69HMgccQIWpdx/tT4tCWI+nrz5Kgdau2MRt8MtMzNwOju
	POuYB+Ao4HhlafN8QS5b+Yex66wzDbB1meF+KndOhmrm+XMUF4JI45lIKQy9hCuG
	lgOrFJQ/KWH9h/vees4TpL8xjTS+nDmEDEWJSOCYXDBaXbk+IJuwkzJoGf0p1mrm
	IH/p03IJpSv7gl7Kb/+PfDOwFYO/V2KUgKFII7nPXlTf6Gm7/bh3R74gwSY1/1xJ
	3xDVUY5DzhNQjgmV3LLAaHMBvBhLYlqmW9NrKVpf1565Su0/PLd/d++uz4N1iyZ7
	UvCOfw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1cm2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 15:23:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2254bdd4982so65061585ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 08:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039435; x=1744644235;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPVafLpZ1KQwgoYIl+VYcy6p2KP5KKeKiX8x9rBQclE=;
        b=bpc0XQkYJ/3GN0FLu0yPV6u3+J9psdnsOfH6g/WGYDfi5MwO83YjnBC5k7gCh6JfQd
         WOAjg29tO4S9sv3ywHeIUyKkKIPZ9bwOXSWEJRcVYXtgo7dYHdhjg8v689cG2IpGEmZ1
         Tegi/D6yrfSX00jGBizr+YXZjckh9wJlEZEhwl24tCPxeN5aJUkFIJZr+WyVYA3jCzAG
         Lq7PeR3xq9DznZvREjvLOuSqdn5A1BmsMyNWWT0ZqLJ7AmyWNzjAsuePbFjvPxoNiOpf
         FgzaHOT4+jh261EP8VwI3NDz+3XwHMbeA1FedYKR96Kd8ttg1fgeUKy6P5SEJNznrZVo
         0A+w==
X-Gm-Message-State: AOJu0YxyhKfKTPThuJkPa4pJhmcpAuE9Dz9wHfkTb1YwxaQguWN4aNqq
	R5oHfxgxlSiTfn8IKdwciLCGVXxGeoNptl4jDI4MAMyNEWmbBr+DG+vV1d60wwanbFl6jDiTSm0
	DcAjUxvz9QIjJw2fuyPEoaFwQp4D8GOsU4W3+nSuDlh3AJyYHxZg8Wc61VU9qYcS/Kg==
X-Gm-Gg: ASbGncsjVddS+9EedDUIAjCAqH/5B9xWGj8i3FXMwqyQhYJ/iiph0wbY6ALfBYVfJMv
	zCEeWJmawcKNq12bjjFEyrmTvhUH+bhc535n2qUzFLitFlCNFdARkaK+zCUNTWKnlnSuRs/8DgU
	5xmbesDgBlYj3FN4SsATNh2P2hyVxjS76cu5Rqnl8hen3P4VS1A5RvisOCvIB7FMMpqeSljtV8F
	/nw/oiR2OOOICgTQWjiYB14M9NjAGW91+JajzNE9n5EYAfrrncHQ5P6JI2sfAHQetrWj+lTPgEk
	Q0x7zTB/OvrWY8EgAq1gsC0H1RNwEZCzTy4JgFM1vX/BiQ9GMrCo
X-Received: by 2002:a17:903:189:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-22a95512156mr107876895ad.19.1744039435164;
        Mon, 07 Apr 2025 08:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrKm9eJ1wzqoqedel9CT8njg02rwA97wtuHxpiSBWptxfyZZkrwCEllOIfvQrrAozu/W3cMw==
X-Received: by 2002:a17:903:189:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-22a95512156mr107876405ad.19.1744039434468;
        Mon, 07 Apr 2025 08:23:54 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e7d3fsm8691592b3a.180.2025.04.07.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:23:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <20250320112426.1956961-1-quic_rdevanat@quicinc.com>
References: <20250320112426.1956961-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: Fix incorrect rates sent to
 firmware
Message-Id: <174403943378.2068408.13497064533641126291.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Apr 2025 08:23:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: Cp0J6BDecso555Z12l-rGFofjdwP9ECB
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f3ee0c cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=YRjURhDjmDyyyRhygVUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Cp0J6BDecso555Z12l-rGFofjdwP9ECB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=865 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070107


On Thu, 20 Mar 2025 16:54:26 +0530, Roopni Devanathan wrote:
> Before firmware assert, if there is a station interface in the device
> which is not associated with an AP, the basic rates are set to zero.
> Following this, during firmware recovery, when basic rates are zero,
> ath12k driver is sending invalid rate codes, which are negative values,
> to firmware. This results in firmware assert.
> 
> Fix this by checking if rate codes are valid, before sending them
> to the firmware.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix incorrect rates sent to firmware
      commit: cb1790249361ba9396b06b1af2500147e6e42e5e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


