Return-Path: <linux-wireless+bounces-24229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C9ADDFFA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 02:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F51642CF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 00:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6D6944F;
	Wed, 18 Jun 2025 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nGL1kajB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057510E3
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750206472; cv=none; b=Zz4FZdBt8mzdpO31nfkwIAbLBQunkuQcNibX4q/wUIKbTtYZ1D+5zFrzVooT4POr1WIc5KlTEYqLIWCxyv4LUyef1/+7EUHjyAoRGEIXxdgIcvekQ6bOS1/sAucUcnsTX0eNr1Mjbfxe5+rXIe1U/7m0yagMHzlyzgrZ2/Hgxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750206472; c=relaxed/simple;
	bh=yvw0sczwB1g2t/+FriexJqFGjfemUd8xYXuRRfJ6MHI=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=JEKzxkKS6lWQHSDUSYbu/RbLv9LiMzlUY84mMQT9mxtWpWWzUmYJ4uD4r8yRKREsHmHcST08GAmStI+4Cal/1P7JGNAFrqSup+npdXExseRn5LKV94zN4X4DT7LMv6HUsvddmAZGMXFhPk5Jieopxqf35Er1qXNoZkyYMe6QfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nGL1kajB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HE8DDQ028159
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M0UFGlCDLAmGlSRbv4ia+Y
	pJ/DiudoV1d7kt9nUTgaY=; b=nGL1kajB0G5RdQgvMHvzMqr0claUc2qMgsKbOf
	eQ4OHmPb+0oCL57L87CZqI2/rLlM//p/OZbv8m9fp7gqyJJGfb5BRjA1/udsrlb+
	2AaOo2LkAFI2fWVEQMqC+K4CZ003hf3rsj6+KpWYyZ7nqBRr9gs7HtmnZp1aQ8BB
	/v7myCAft8EAud0iOd3/HaEhAiWcVxp683bJJ7OyjM+tmYqKyqMwzGctlDS6eo8p
	ktWNcnLoGwE7NDHOi+J8jCiw690mTjG7w2CEn+CjRdyx1TlstRZDJHh6YBGiJQup
	tYszus5Ni/hQgOTUAN8gCcGJ6bu6KDPhTpwd0YiFQ4ugQeyQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791f7a3p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:27:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso3326286a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 17:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750206468; x=1750811268;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0UFGlCDLAmGlSRbv4ia+YpJ/DiudoV1d7kt9nUTgaY=;
        b=appCt6s1/0DXQvexAMAdLGTDwv1eoB+oZyIR4D3DD8viuBUeARm3zpREnZYrfIVRjJ
         Zwp8bdDDH4tExbM0eawTkBDQBVyCjcAIiRcCluqYs1VyjKXSuzt+93zFKa7NsijGAmd4
         8LIuBa+w4gy3ThjFa806IBocVCopMJXnLYH7h61UXA3CocYxmC/pu84UKwxwi+xoRpxB
         zACTDUiOFdR4YlvCDHKv/rd8hAkw6/o5UVisyVHbF+04EGIfo7+1yFoh3p11I1biYjb4
         YALORe4UJgmUHkwAkKBE/ujjrlCvp/v0QzFBBkfXb4aH03gA3E5CI4d8vsa2q9fXky57
         3qRg==
X-Gm-Message-State: AOJu0YwlvN4NK/LN7Vc88mjY7SqDXcoHuJdF4lPaQFguKb9+ItgtY7pH
	JAcF2mElKxDvEgHgrjL+MbZoVqQShndzppRGcbWUZ9koPQ8coI31F4zKPKltpdaNgkc7E3l3YNJ
	6XzOwhu5fJt8UQHOaKQasDvMEC7qi9d10/kt2SgPXyHU8aSDk4okqJgIjQLh/R4XBRFl/0on6j6
	i0PA==
X-Gm-Gg: ASbGnctEUSe52P1MR5L+hESnyeb4DYtc8L2m2FWllkN/yZ8soiomq6Znh6KZv8qLwpM
	edaGYsqiipN64iKp9oGY0hJ3hH5UUxYmKgs4mWsqENraGr5l0b3rWGDA3B09caDV23SSsENVHAJ
	U+olLAZvWnP+v0ERQeimJ/hoM3yFWEfO9/BkUdCZaP8PWg5jAVlzqXiRTIWL8AdOXHoaksf2ObC
	QXqLGJH8TakVkQ64Wxel2wnDqwBIgHL+j9enq9KQ+7Dz+Ep+ve++3X0Ym/msJU1IhgrA6d36W21
	Kq4gboKptu1JC6foaMcpD5rtBkQ15cN5y14GZ3iTuxfLwtleRY7sztdJpyc=
X-Received: by 2002:a17:90b:5847:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-313f1c7c54amr23328144a91.2.1750206467647;
        Tue, 17 Jun 2025 17:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE47uJ5OhWhcQUshu3iRdTlSHkJeUqFGAtI4R66G6CQxenFgnSEHCf6F2kwyiWPrYnb7iu/3g==
X-Received: by 2002:a17:90b:5847:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-313f1c7c54amr23328110a91.2.1750206467179;
        Tue, 17 Jun 2025 17:27:47 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b49834sm11294893a91.27.2025.06.17.17.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 17:27:46 -0700 (PDT)
Message-ID: <9fb699ae-3f30-4459-94e5-2f7bdb29177b@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 17:27:45 -0700
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
Subject: pull-request: ath-current-20250617
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAwMiBTYWx0ZWRfX9wq9LtJYDOIu
 Us0czzjPr8iDaZSoz2bcrQr8aejjjDN3miHvT2QKLbX+lm3WOmxHvF/hq110HmtrPRPr3AOQtPb
 uDRaYY48b78l8LSlhzHJGuSgdh3fw4rUO1DUdw5nCg9ffaSeVWxDdKZJflj94JUzDA3dot4hX9S
 qQde4jmHBMQI1bM1MvCYLh4YGqPby96oUabuBcMVMPPaQiI7JBDIFurn1Hk4HzSS1WgeUuunkrw
 jnm8TF1TtW1/bRhfZpF/DsqwNzdSJNLRjFf/HOm4bGaUQRXz3GnfsBnMcVjw85ww1QVSnnCQDkd
 DWZSsA9HqAA8Qt8oLtMKpFSL0ImZypdfl6vtJ18fRqGyD2/sRLEbCD9EO6tcCpM+b4oamfCgzSR
 VxHRYpsUSsRw/ktQmlo6dxWzaKTny8CRi9PLQuJXTkm4c/STK+aV7kB3ovj+GVx8AQ8XJLtg
X-Proofpoint-GUID: lzc0DXMGCvbL5SnawPWCpK5q5GnhS4ks
X-Proofpoint-ORIG-GUID: lzc0DXMGCvbL5SnawPWCpK5q5GnhS4ks
X-Authority-Analysis: v=2.4 cv=FrIF/3rq c=1 sm=1 tr=0 ts=68520805 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=v6iAXbONLxioC5Ttwi8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180002

The following changes since commit 27605c8c0f69e319df156b471974e4e223035378:

  Merge tag 'net-6.16-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-12 09:50:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250617

for you to fetch changes up to 15d25307692312cec4b57052da73387f91a2e870:

  wifi: carl9170: do not ping device which has failed to load firmware (2025-06-17 16:28:35 -0700)

----------------------------------------------------------------
ath.git updates for v6.16-rc3

Fix the following 3 issues:

wifi: ath12k: avoid burning CPU while waiting for firmware stats
wifi: ath12k: don't activate more links than firmware supports
wifi: carl9170: do not ping device which has failed to load firmware

----------------------------------------------------------------
Baochen Qiang (10):
      wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use
      wifi: ath12k: parse and save sbs_lower_band_end_freq from WMI_SERVICE_READY_EXT2_EVENTID event
      wifi: ath12k: update freq range for each hardware mode
      wifi: ath12k: support WMI_MLO_LINK_SET_ACTIVE_CMDID command
      wifi: ath12k: update link active in case two links fall on the same MAC
      wifi: ath12k: don't activate more links than firmware supports
      wifi: ath12k: fix documentation on firmware stats
      wifi: ath12k: avoid burning CPU while waiting for firmware stats
      wifi: ath12k: don't use static variables in ath12k_wmi_fw_stats_process()
      wifi: ath12k: don't wait when there is no vdev started

Bjorn Andersson (1):
      wifi: ath12k: Avoid CPU busy-wait by handling VDEV_STAT and BCN_STAT

Dmitry Antipov (1):
      wifi: carl9170: do not ping device which has failed to load firmware

 drivers/net/wireless/ath/ath12k/core.c    |   4 +-
 drivers/net/wireless/ath/ath12k/core.h    |  10 +-
 drivers/net/wireless/ath/ath12k/debugfs.c |  58 ---
 drivers/net/wireless/ath/ath12k/debugfs.h |   7 -
 drivers/net/wireless/ath/ath12k/mac.c     | 394 +++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h     |   2 +
 drivers/net/wireless/ath/ath12k/wmi.c     | 829 +++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h     | 180 ++++++-
 drivers/net/wireless/ath/carl9170/usb.c   |  19 +-
 9 files changed, 1395 insertions(+), 108 deletions(-)

