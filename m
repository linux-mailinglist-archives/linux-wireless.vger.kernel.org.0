Return-Path: <linux-wireless+bounces-26958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D4B4113C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 02:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA002202676
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF8134CB;
	Wed,  3 Sep 2025 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qw25cgHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C6134BD
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858677; cv=none; b=kB8QmtuPEWgJUhLvEMANpuMVfqq+LCGM9BVBBYXFucxTg/86u3dWUC09ZK3/yzwupuyi1d1YJlwOoR7xRN0Tx2pDCC+cB/BFhwL3ib6HOP8Niq7dtkqTmf8msv/bb32McRdidBQzpUixau9F5PfekkbfZ+Xjw7xEN3/MfezoX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858677; c=relaxed/simple;
	bh=53AF5Em8rx5jKn3u9PAXC2kYGObLU+AcGM4SHvUJ7NQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=PWAAxNvFvOisieF6NSeTGCv7AvdKvZpLl95xVTiOIj+zl64khhMS7Z+huTH3sDDSzhXzbZDH0NiyYAZ+EBQRS+a8PEwCBkA6l7L1n+ZuWmJtB9dAhD51vZbeXlId+FoM06hRY2SGA/Krku6KMtLJRk0WziUIX0mn+Crt8dCNkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qw25cgHA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqCaq019584
	for <linux-wireless@vger.kernel.org>; Wed, 3 Sep 2025 00:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cTlL3s3wU08p/sYLbsbZNw
	CeQ/WfCrG0UOH18y1enxY=; b=Qw25cgHAnBYpc2vYAjDlzDvnXCGfa9sQcSorDj
	iyWVdZBQyPq92VAedW3V4p01QufZ4y/qYw9gnfBHAx3arm66gkKMe5xaVNlYM9ms
	nRrNnLIER/DpYNN5L8rcH6GBQ03pQXF3WQwmdRXZUtlFla98ePghyjIIGhOuxkq9
	Bx8fx9Ljn8/oNA6RR9NvWtyox83LHosH+uRR3otVCBTsugTDpRpkzh1on2n6mHky
	B34AgdwNZCAYAaSP5Bn6OYzvTxvB/F/Y0O7t4AFLZUqtwih4CPX7u3el3S0KaP02
	CcAAaPuhgK6UYazKptefvx1rGAWu7BWoB/9fD3cZ6MLtizpQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw01ns8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 00:17:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174c667aso4818760a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 17:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756858674; x=1757463474;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cTlL3s3wU08p/sYLbsbZNwCeQ/WfCrG0UOH18y1enxY=;
        b=OOC52oeLoO6wmgG8ekMBZOUlSv35b2kFTMgqv+34m5bQ3EnycoBx66YOOlQxP/TVZv
         0II00pr2+qsRYsye4JKD0PS0ElG27OI+nX36YyUnexLb045xqic9fB6nEKIbH7BjskHO
         cgzCSIGGRXfK53KHbUqiG+Y/AdWWe13u+PEUFKpYS1Vsof9471QFp7Z0JETJs847Ldl0
         8eiq8w0VaSXvfG5CduNaq6B+XnRHJnT3JX8im89CSIBEFYJU6ks6szTX0VXJ3gz8ogIP
         T2OiibI+KxdAYUWLCYkitGgyHgnqodyaOj+Jygms3CBb3xhzwFQML6qfFPPcslRKEf4B
         o06w==
X-Gm-Message-State: AOJu0YwIXeO2llFV9C+91lvdcfBiYotuzvEVfWGeO8p7REzywsv5djOB
	50fb0R0V5NTt3B8nnOoG/oI5X4nKrWvmgqXTWrMLRFopO4KQ04oldrh3WQowJ1DvPN/StTj3AUB
	IL2tC3oy+85bKcHC6ALYY824bijU3OqHcNZilfbN0h0XNhxvVv3oK3lIwtNZhGRaq1iZ2sDUDc4
	VVCg==
X-Gm-Gg: ASbGncsv9rIhxVAblPb++FB3L0PONUuh3Q9yvQQHwOhH+wwItaNHiNTGyCOsxsLD1XQ
	u1IrOD4DSzmhSwZ1xzCTwQlTf5kIcde1N5UgU8aNRso0GNe0EeT+Nt7w27sPX7VDRyGJt7J0WQi
	L/GtPHp6SskoaZ10wF3H2zQ7gPC3pCbSu+o6YhAiZwYgir5Gmh9Gbict6BLbAn1fd64X+bYyTaj
	/9cqjFrmzhpHT53fi7HL+4mmbrogxginP2xjbXCBxK0elgewcvIq95E/coHdWH0J8KoVV4p7pC6
	itEBgpnNzI33n1ud58fPtTS4xV9ERRxSufpgfTHOs+8GGucFSkDB4DSZfQPqUuecm+X3aMX7uPm
	t
X-Received: by 2002:a05:6a20:3d8b:b0:243:b190:d148 with SMTP id adf61e73a8af0-243d6f02580mr19232375637.37.1756858673674;
        Tue, 02 Sep 2025 17:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFoBDXowFfmFVh9kvrykyPsnoguSqtBdlEPxuL91LPUOIVWBRu7O6kvVYOnwcBKK7zunER1w==
X-Received: by 2002:a05:6a20:3d8b:b0:243:b190:d148 with SMTP id adf61e73a8af0-243d6f02580mr19232345637.37.1756858673229;
        Tue, 02 Sep 2025 17:17:53 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772466e629asm10148491b3a.31.2025.09.02.17.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 17:17:52 -0700 (PDT)
Message-ID: <8fb26b97-f483-4155-af6b-493b2bd16442@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 17:17:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20250902
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: N1y2pY8NpnHfmwurxEwKgy-QtmSHrCV9
X-Proofpoint-ORIG-GUID: N1y2pY8NpnHfmwurxEwKgy-QtmSHrCV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX0hLpHAnM2Baq
 Ikv5NXN0MmhuD7nv+8aq5VYRrOWTLotO5Z9ACH4XzvQb18RfKnwo8E+2iDxnJSRGEX9iBes/8GK
 iYYI0G7TJW5dVGCPG0bxARDDvSmwgrSOFrLHfsIvN5uhygmZs6BGCeYiIpzKUxV3CCtsDob2Mi5
 m60phn/n3uNC5Va7vqdkRDBXuu6eGM2f7W+S91S3CpD29g85NmGnrx/neMQta6+vexRoHrb25aa
 5SnIpVhsctMpla9uadWkE1YzRgkgLBk5UwJBj6PRNKqzZvSsUl4avg0eqntk7nv+RfprQn+O7fy
 q+FN/7+mhOfOTLWRg1CG6DLcZmIPxMnZctICXtITFhrViMkicEUdcG09SZi/o86qE5Rf/D6NZUf
 aXySDQku
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b78933 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=ETpNzpHT8A4ojKDL548A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

The following changes since commit 2c72c8d356db40178be558bbbd43a1d0b5bd0c27:

  Merge tag 'iwlwifi-fixes-2025-08-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-08-28 14:03:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250902

for you to fetch changes up to 97acb0259cc9cbfbd7ab689e25684f3d8ce10e26:

  wifi: ath11k: fix group data packet drops during rekey (2025-09-02 15:43:16 -0700)

----------------------------------------------------------------
ath.git update for v6.17-rc5

Fix a long-standing issue with ath11k dropping group data packets
during GTK rekey, and fix an omission in the ath12k multi-link EMLSR
support introduced in v6.16.

----------------------------------------------------------------
Rameshkumar Sundaram (1):
      wifi: ath11k: fix group data packet drops during rekey

Ramya Gnanasekar (1):
      wifi: ath12k: Set EMLSR support flag in MLO flags for EML-capable stations

 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 111 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/wmi.c  |   1 +
 3 files changed, 105 insertions(+), 9 deletions(-)

