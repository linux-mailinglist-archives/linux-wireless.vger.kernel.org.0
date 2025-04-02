Return-Path: <linux-wireless+bounces-21079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B274CA791D5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9AD7A4F3F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741FA236437;
	Wed,  2 Apr 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBP4rg9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601D2D7BF
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606486; cv=none; b=VOwS6WCNvhdgMMkZ1DKn8ypFSfRa9u2RRvlwMmcu8dUZnL7sN8P57F8RsAddkPqkQAoiwvTvN+k+pQOI3Vwjcezhlwuq+1HY1ntYxsii3BWCk3SY827eWG8JhGbhHlzIQPwpbFmgyNy3MauqXFRXxJLCPmhXWjqPgNAIhiRfKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606486; c=relaxed/simple;
	bh=BGl80FeBrXlpQLGJpkBnb6kJ7QX5Wem86uX5wgjEDKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j0EVPVdYVpSRLku8+f3umgbk4KL7Q0J1x/iroEaahca+xW0bh/DPFWl+4+mGossk4bsluW3HA7wABqSdhAsPn4FmYgvtyJaTqi087DZ6lnRffvsQ84u5d/Spfu1npVWbm6xbX+WAo00uYQ919wkUB7EWykq/x2tycB5DgtZJe/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBP4rg9f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DuBck024541
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 15:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YWPVDzyugxAflJFq6iLaRlE5P4ZqPyHBftmbgYjzF1Y=; b=SBP4rg9fVk39J3GK
	2elGBbQ2SlKwclJIe6Gr8oaFm51y6EerSfsUSDilIYTK6PsFMTNZiBc2A2i8KZi2
	AgKsIc4vVPVknmeu15K3+GSSrd1YNxVtUdkoYw+5ieMgyq/tsxPqgFon7ElD+ezg
	GiHGstuYT9uSfAaBv6i3/VhVjdH57Qw0DLyts6vMhWTXrizy6ZbTQtGebgBxOhbz
	CPZgYitZnV7kTYvSHFqyC292z6oXBISf2T2BO3nNQIPHIofwdun2Ws8g4siPkz5b
	plHTXrTKr0cCE8nYoix+WtW3E4AixVNwfAXQ8KHFDYRYojLun5M42GB9L30n8ynn
	2CbGOg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpyvvvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 15:08:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af8f28f85a7so127985a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606483; x=1744211283;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWPVDzyugxAflJFq6iLaRlE5P4ZqPyHBftmbgYjzF1Y=;
        b=EYmlhtzn6j2nAkCUSE2PQrto43/dOtEyBu4LDM6hGkbGirjZN8mcUONDAtvOLH+daq
         Agy3EWXmKNMBB++xFRPI4DnUqhR4phbPUWPBLQxA4zuWhO9Q0yOIaPLWCACU10gYM8mV
         wo9/FvtLvwAeM2Bigj7A6q2j7CgxJdd5A9f1Fvam9SiE/iIns7z/7Otedd82tF3XK0bG
         /qVGYhN9aYEBX0e60gxICapisUjNZQGh6KtiYdW6/IusGGjthuencwedUpGxKPSaOOFY
         hHpAlYgdwkAkD4UAb9vcdDe4u5Gf8a+e2ZuxxeWBhAmIkl0/wX/PQxkGHZX1LyeLJBdO
         yAvQ==
X-Gm-Message-State: AOJu0YwSqY7yzNShsVxuj3FJWGHAbdwqYCNxeG3QwS2W4W1+lGnWsj4F
	kiwPmH2U0W1RjWqVCINv4yHOUrEFFXjxnMJPPaPOXDrjBKzIfsR2z0WbVFZcrgkUTOzJxMsVfTX
	n5/fXfsO3heK4Dkq6SLbBpvaB8Dr/7KEQT/RMnR51tp/0FyMFAt7MapZ6+LDnjbz3EuczJ8LhKQ
	==
X-Gm-Gg: ASbGnct44Yue0Jh2sRtCuiUH6QQ09UIDd1u876jEtez4FO12d7IbRmpNnvM039RRwK7
	B+VBe4kewxPj4/wt2NGGkPkIe6/km/S47yWGn+chMU35Wj9z4mAbUkILf35oIICHmgQoX8IK/g/
	k7f71yBYy+EYI+xWQdmKpra88dZnsbEsjetF6e2fnVWldMqwWAp/HoZB8+/2cYhxoeMd40u+b7c
	2SWkOXtWZxQ5ncBfvPrc64fCKsAhLkLCnAOI59g8Ux66T+a+hxJpABGzpesj4+2NspDma1XeSMq
	0ANqsl7UmZU4nWBIsDPMIAmtd/6mi7WNQQRsIzgw+9YX7NNhqADt
X-Received: by 2002:a17:903:19c7:b0:223:6657:5008 with SMTP id d9443c01a7336-2292f974807mr295523095ad.24.1743606482423;
        Wed, 02 Apr 2025 08:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxFI31BLjo9H5AnSdfC5UM/tcdMze1BMgiFXDZGN9nIfKlejkbi+zgdZDO1htp+sovQitGNA==
X-Received: by 2002:a17:903:19c7:b0:223:6657:5008 with SMTP id d9443c01a7336-2292f974807mr295522335ad.24.1743606481672;
        Wed, 02 Apr 2025 08:08:01 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedc988sm110193905ad.59.2025.04.02.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:08:01 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
In-Reply-To: <20250326213538.2214194-1-muna.sinada@oss.qualcomm.com>
References: <20250326213538.2214194-1-muna.sinada@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix memory leak due to multiple
 rx_stats allocation
Message-Id: <174360648091.2001642.3728671779418142424.b4-ty@oss.qualcomm.com>
Date: Wed, 02 Apr 2025 08:08:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: SXE0IsjTGMGud1cWi9L7plA1xJKwqsem
X-Proofpoint-ORIG-GUID: SXE0IsjTGMGud1cWi9L7plA1xJKwqsem
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ed52d3 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=X9lr2ljuSIhPkOebW48A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=789
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020095


On Wed, 26 Mar 2025 14:35:38 -0700, Muna Sinada wrote:
> rx_stats for each arsta is allocated when adding a station.
> arsta->rx_stats will be freed when a station is removed.
> 
> Redundant allocations are occurring when the same station is added
> multiple times. This causes ath12k_mac_station_add() to be called
> multiple times, and rx_stats is allocated each time. As a result there
> is memory leaks.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix memory leak due to multiple rx_stats allocation
      commit: c426497fa2055c8005196922e7d29c41d7e0948a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


