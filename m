Return-Path: <linux-wireless+bounces-27489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117AB86603
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 20:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0712A7BA6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB2283FFA;
	Thu, 18 Sep 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVgd9L0W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0132857E6
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218809; cv=none; b=nn0eTycxrbhdgP13lJ5bVW68pTeQsJnpnpAh991l8jUSyUaU6LvCLS3h36iq5oUaVCone3t5sKDd7Ad0TPMunZe6ZZchNtJYafrPfK3MJAVekgHGwfZHIvR1yfrgc6EzjwqrvkLBqyz26GcHx5ArpLKfV1UzXtGmSGscr+ezzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218809; c=relaxed/simple;
	bh=H1lyaRM2/WbNdW6Q12www5xhD3G77lWSXAvetxGvvlM=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=iH/BCR0OfyiM2nmclt7xgFMa5riIOAyNn18pQaJVIBTLSY8kechTzD3hWcK+4fStXo7CzFSIZ9BYrIWm6hi/d18hDWXFmZyzMn3C7xjQeWDw4z17BpGHFIkT/0d2IcWLjxRK08O/HtRa8UWsROiweGcyAvfhmP5Fu3GVxWGicO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVgd9L0W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBSmLk018262
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 18:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=216aGmttavblAfmxtYmqgH
	fbJMwZU8PhIe6pQ5pZYfg=; b=jVgd9L0W5gAZ89DPwmreNCe5zZSls010LhK2SR
	nMs58oDeflAQFi4i1aBdIXMMxTOjSdlqaBLojisk7uaHtVw8UKWey8tmSZ9tl6d8
	zm84TPU9oaqmxPePF0gZ2dYnxj9G3+q08jR+ty6iVCqlyilb0AgdxqCfXcDj8liN
	ylDuwOpC+S2wtsp2JwfZuDZewiU883zD8C1a7+zJh5Sx+3Fz09n4m2twv22qytIx
	MXXtUY6or88Z+UMeaOE8G6kPVkunKXK/z2Tdv/wZiJmyawndMtOZI9u4Leb8wlP8
	Rn/TQJgqXMtUQJtzqTKEU188dEPSTxEUqNTwZE1nVYNZh9UQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwfega-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 18:06:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2681642efd9so11195685ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 11:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218805; x=1758823605;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=216aGmttavblAfmxtYmqgHfbJMwZU8PhIe6pQ5pZYfg=;
        b=FaPbOsY/Nbxa+PgeqBPy84fogwOILJ1ETH5e1zsvtZszvLrF+iovsDIMcef5lzKhik
         qbpCkj14Y6VJXjPQL0trehKmOwrMZ2Y2Q9CXH5TeIihNWvVMnhns+07gR2pZfszoTGb/
         TvrNTHZ2yILfZrt1/zporIOItBYqYi2A5EtvHVeCC0oSEiDbyMGOri2Ak1b204yVnIT3
         RxhUiIQK8T05l7WIWPBRp1HdcgLCNZ76RTWVzaIAXgbLImuAL9AV0+JPWLs0oYabp13z
         jZQWWml2AuDdV2TaLcF25c7SQ9fo/YgoVN2gT+y1SeFsXcgyGWHSB/33Mc1c5ftERCmn
         hjKg==
X-Gm-Message-State: AOJu0YxWR+2GR9N6Tym/2X12vffqQpLKLMK0uz/xRPYeHV6WWtlxns/s
	mLlez51E5s62CVJ2EZhBNX+ZFwIx7HmyJOKN2pk3ViMjYcTiic2rGz9XmT2k74UCaXl9QDTc6P5
	yzCxxjiAKv+RQENO5UQ6imv8c0r0qR2Gjq20Kd4MkAD70Gqir0HD5LU2DaNMINzv2TPr2qA==
X-Gm-Gg: ASbGncsPhylHSTYo1VXBUcvtWhhhgg1NVLK9uxjhC1e/qreW28I4YgzWkeFBb6rRucz
	pdO6oEdgKnIU9siFUxpwrLsIXL7sEGJgEU1kUpjmk8+ADhPU1Tn3da98ehYpvm3lS1grlm85ocL
	Tefxzw3zvwksMq56L6xj71IL60lXfiFVVbuVo++JAzcN8u0Ig9HZHRTBo93Ne5oPUsZZPiXCkz5
	PgaVFkpmGxPYELOiHe/CU8NEQVBbZH/7NvkbkbH8Dm3GgW3qRiBhBzyhZ4APjo18jWg6kQtWeMA
	2SBZZP1FVleOf5IeApvorrRXmpkt7S2vW000sviBQzSyQXJp40Q6hhk9gLEfBFONwmf/nm+5dLZ
	Y
X-Received: by 2002:a17:902:d487:b0:269:96ee:17d3 with SMTP id d9443c01a7336-269ba523685mr4906235ad.51.1758218804858;
        Thu, 18 Sep 2025 11:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU8mGCWRPd+psvoKsiWXXqf6YywFbV+i/dLZiaG9yQ9bphtKe7TmqCheJxRks/sB6c9EPyDA==
X-Received: by 2002:a17:902:d487:b0:269:96ee:17d3 with SMTP id d9443c01a7336-269ba523685mr4905925ad.51.1758218804345;
        Thu, 18 Sep 2025 11:06:44 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de7a9sm31863505ad.80.2025.09.18.11.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:06:44 -0700 (PDT)
Message-ID: <9cadcd6a-5f99-4a2f-8aac-c612f355d82a@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 11:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath12k firmware ath-20250918
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cc4a35 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=payZvAD0jBNu81Yx7e0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/q5FB/iAzt5T
 G9V99Tr3ZWBCnxzXYjBdOcW8h2MQ02KAKfN5tXlC5xNhsOzeal3O368ihzM7pWZetauS8YZU+Q1
 QH453n4mHEhYvML42BjBfQmRlAMd/IAG7L+2hF3mYiBOjUhotQd+vhm07zASy4jxziK6PaDDzKX
 aHqFnVXrbsedBSLzH0k4FhoBkWyLrHS6SbrfvbGa4bRZfhYzYu1K/vba1AP8NtFLc60wtizCG3V
 tuhe5mQFHm6ozt1zWdROlFyCwYPUefIe+eUzQdedsYG87VF5rDRHRRc2YDCRdm0Wtztan19u40z
 xQKfsBpt40qiotJSX+7+kL6YsfYxjo9eRgSEA1WEfYGvBl5+HsAAJTdH6YrJJlQTq5bRiL+Kr0b
 rJk/qwY8
X-Proofpoint-GUID: tExXRCDeWlUzn_rDVbr2bVDXjMq1mSCq
X-Proofpoint-ORIG-GUID: tExXRCDeWlUzn_rDVbr2bVDXjMq1mSCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

The following changes since commit 37f3f2d8e14cff7b316616924331d57f6ec6e259:

  Merge branch 'robot/patch-0-1758163077' into 'main' (2025-09-18 12:26:22 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250918

for you to fetch changes up to 1d588f106ceea113c4c650b43d948da5746e704c:

  ath12k: WCN7850 hw2.0: update board-2.bin (2025-09-18 11:03:58 -0700)

----------------------------------------------------------------
Jeff Johnson (1):
      ath12k: WCN7850 hw2.0: update board-2.bin

 ath12k/WCN7850/hw2.0/board-2.bin | Bin 1986952 -> 2253732 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

