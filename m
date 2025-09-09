Return-Path: <linux-wireless+bounces-27187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DB1B500A1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10163A7779
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E852FDC22;
	Tue,  9 Sep 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTCS4xiW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95E4A07
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430310; cv=none; b=GdfhqUduY1m2PNPJaM8Z8/NP9JVBRo5R37A33U21OkrvPqUEArRv51V2DSBEw1JJ9akReci2oFtmHI2p5PmCYZ9uS6fFa7MIcq82ocDfGLc7HfGVL7SR/xK6yCwC3ebLbG/5F2jrJHFKiOqtZXuspRHkRdnja/1zD+uEgrr6g7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430310; c=relaxed/simple;
	bh=oHWIK/WtycmgC/zGJbH1vMuoLIZX7lE/zbbsEfF6YwA=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=IeeymFl310LRJyo77VZNl/vUDBIghvLYRbx1a890Tq/VAhMz7wyf+aCyg3M76v7ELF9+5J1lWoA3ibhtoQBi9BEGn6OTGMct5PPKS/RFAZQM58N3+BWIfc781HFzzJhBdRYuF8ZYUeyKguN92cBAOtxcvWWOmP/90Vsv5W1Hhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTCS4xiW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899M2OF002280
	for <linux-wireless@vger.kernel.org>; Tue, 9 Sep 2025 15:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RAntPOqg/0XyFFE83IKtNh
	+7Q9RRLCGHdB6U9HhQMQQ=; b=RTCS4xiWgP5jQD1FJtOlozp1b939TWLW21nNjW
	8XzggxOmspmJj2+nM3VCQJepG12Jb2LswZ5aDxewEy93Mmr/VcKGSad8RqKRtKPG
	6xw8MQozVjXp54HgBfnfHm2Pfflg0ABEtAagU4BlGcMvozqs5jMc9j3LfaoEluS/
	QIIacHYVXhIGVlud3gwiZOgQ2fUv1AgNrqudmF4r6TzH2VeEeOpQ0U+l+fikBlAT
	C+HglwVZSHZ7K6y5YwOC0P11aJ8dNuV+rsykAWyng4EPAJGtK9/+gilP9F1x6Ei/
	FHbF1OnvqwsHuPiZ3lBr83Maps4hcw5V2y2aV+7KYca0o8mQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg0fdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 15:05:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24d4ab50385so67695095ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 08:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430305; x=1758035105;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RAntPOqg/0XyFFE83IKtNh+7Q9RRLCGHdB6U9HhQMQQ=;
        b=MQ7MIK+P7nuFA+5RmYVFVubBjxDsOWFyNiVgKiDcKksIdv+wdAmRiC+xGRCf6QFgZN
         LwOwAlmnfr9P8yxG4sGpKbE86WxDnkPm1ehReLf3byToyK50vzW5sw28auSlPu+P+9ZQ
         mzkzTRevHC1qnTWDcd7lQyOmsIXc/ir4yj7O2YG1u7IMMItHzDjJySE3KDF+3cr3LPl4
         zhSQ0dmSNFRhZbnlPOt1peyL3QvyLTLMXlsOXowKSI/xYfqvX+ycUVJZ604TPPz8EBYv
         0O8lVlmPo5/noaYNlbo+R3K+IQ37KpfhjHoAEyhjD5jwfdde2PQS8bVX/iEwLz54ly3+
         JRKQ==
X-Gm-Message-State: AOJu0YxUjv0NSlVL7DSjGAnxHRjKObzti7ns6TE186ux+wV4+jocwpPZ
	+5j7ueEX/ggfKgHS3DrqMB8bVRSh/5uGSQIl+JF5mARSLDo1YQkWLEaeq43TMVhn10ono60N9uZ
	thcrCKo57gQklhW/w7SXqKaRlLdxya1Rn3FQEUYk5WefCRfim58PIV7hc6WNROYQUJ3KK2vz7Hj
	0QsA==
X-Gm-Gg: ASbGncsALInLYjHb7taHYyay3o84oWSfc/WIMDpAqPRO5vcCEzKb7SCSKZKmO7vNheR
	ZBBo0Tu9k5124E9K15dj/du5vWwGljU3XhYGy3oqbxeoPS73MPjb2fq6Xf2Qo7jHnrEdXoz7CFY
	j/bbXXIU9sTNPAzFlFaWyb3tnDz1cQKgQ03WAT8fwhBEnytqwmT8+g1xVQXrYzoWVr3vSXoUyK1
	vBvhRPbX+Ck17mXhvh7puGuXV2eh+I2vBKoO32YtLng+Gi2y09aX7FRugtekO9eR5/fQCZzoS+x
	LOh0ZNG7y8i/lJluO59p9lB2k+t4zU3hgUtJ/d8XWeY6lAiXGdEAk0QBCnrOybcKmhAOU28sqcP
	j
X-Received: by 2002:a17:902:e541:b0:24b:2afb:b3f2 with SMTP id d9443c01a7336-251788fcc2fmr155542945ad.14.1757430304387;
        Tue, 09 Sep 2025 08:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb48fxPq6mEUOM7DGxxKSIV9zoJtKUPGkijzFiKPpf3EvVe5kxlfkcerNzemxmf2LpV5eY4Q==
X-Received: by 2002:a17:902:e541:b0:24b:2afb:b3f2 with SMTP id d9443c01a7336-251788fcc2fmr155542015ad.14.1757430303596;
        Tue, 09 Sep 2025 08:05:03 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a921755sm508065ad.96.2025.09.09.08.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:05:03 -0700 (PDT)
Message-ID: <3072c24b-91ca-4abd-9fb9-c24621bbfd5c@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 08:05:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20250909
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Do3rDrNpbjOhTOA0wYL4e5lCliqx6kpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX8TAvbsaWlnUq
 xY3d7Q5OwcyE7KAeEPMwFs7OCC0YNxO/0+jrJXST2lgkS01PXCM1RrMPkDCogzWfAXvftL0lmNr
 BTMqThDeBj8R5GkUT32zIBFDzwURerChnLDvJrVyQ2BwVeDMtVnUqBRkJVI4mJrn9WQpksFeM58
 cFq/aWZltOZNwYrLeI7kvfLbTrDqMHDElKVFx3TYgGNeYKGhVx3QycYtP+HG5TNIehTPJnhTe1n
 AQ1aryIAXlTPmvZJnRyuA5C567NGsFEPeBPzwNY066OHqnkeqFZU6503LLEm8APE19h7mHJ3Lug
 tyqvsiZ6sB9384STE/MrpWuUq+aGF5bEZv5wWmtBQB97tFeGe/STU87rITxX5lQ4eLWZ6putdiA
 j5Yb4TzN
X-Proofpoint-GUID: Do3rDrNpbjOhTOA0wYL4e5lCliqx6kpW
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c04222 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=irr5gHPzP_QwJIvTEHAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:

  Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250909

for you to fetch changes up to 82e2be57d544ff9ad4696c85600827b39be8ce9e:

  wifi: ath12k: fix WMI TLV header misalignment (2025-09-08 09:45:18 -0700)

----------------------------------------------------------------
ath.git update for v6.17-rc6

----------------------------------------------------------------
Miaoqing Pan (2):
      wifi: ath12k: Fix missing station power save configuration
      wifi: ath12k: fix WMI TLV header misalignment

 drivers/net/wireless/ath/ath12k/mac.c | 122 +++++++++++++++++++---------------
 drivers/net/wireless/ath/ath12k/wmi.c |   2 +-
 2 files changed, 68 insertions(+), 56 deletions(-)

