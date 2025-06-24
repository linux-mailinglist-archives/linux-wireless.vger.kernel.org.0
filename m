Return-Path: <linux-wireless+bounces-24435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1439AE69EB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B032189C0FF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67002D8785;
	Tue, 24 Jun 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBpJugnz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC62E7637
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776268; cv=none; b=JCiibXjrxwC2mP0hzHtnYxwCFWCzgSCn6bRPh0ZSBzmWBYGDC1u5KZYXFAt9bTnE+ubdrccESpWTvvtjOkz0TppcTeQlDB7m63EQRju9FlsbCGJ32LAS3+ZlbcFjQn3uUbMSeaEkNjzy+/mXjWD+DdpcYmcpDdgcVpZS2nF4Dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776268; c=relaxed/simple;
	bh=G5rvDW1Vvt9/W6MY+kwgPlQANeZqP+GpD1Li93SdZps=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=ip9if8bkMxXv9JjwD4GzSzJAZwj+vjDidLnUvJdAQ2okJQvsfqFtN/JIg/OfTAmOfwysD0lE8eDvL4TEQGBaaKBo8B6sGvRqMYH+KToVBD7auWntomWD8xWIuGNIY2RVx7yTJwniD6J6PYFcxs955djv+KnbEs+1Ch58IsTSCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBpJugnz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7ncOa027614
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IhE41DpoTR4z03SkvEPcC3
	3iwojowxS+ZkTlZkD1bgA=; b=kBpJugnzA7Spx9xxiVMn5elexslgWXE4zM95TW
	OT0upiLndcNLZf1l/lJyiyef7upVtBBvHAf3lGvJnx53/9Bs/NFrs53O6JhQcKel
	aWygqUMpg8A/wyZTDrgmkeUB8JcfZBFAfACYfAPXRVzhjve8B24w7vGqnMI0+/ej
	YkMKrfsMR9FiNbUJniCWjDOnLM+c6tAHAH9599TazCbwyKg0jexgs8eznlEDm31i
	WdfWLnr1zh3vk4Vyra/B2PEGwuvweqga3YGzBvbXxuVjB2v78PkgzhX4acXRIF8H
	5RVTeg15+IhBUmF3Vs6jhhySoxLxNY6jxAqNkxy/hzUo688w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqjyx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:44:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-237e6963f70so6703415ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 07:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776264; x=1751381064;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IhE41DpoTR4z03SkvEPcC33iwojowxS+ZkTlZkD1bgA=;
        b=PvxjjlM/lfiIm4drjflWKrd1bgmyOESmcBm/rVegDMUb1Qxy6O5q39KiQPfVijScUh
         FtLHwcQuV3WZsP/cQbUOWeHLEQ6rN7HiJAhOvYn4Y1EAF1bPekY6aw6BgotDoG/IpcFM
         9paNJCmxDU4wItbAKd7sY2mgqIUwXXpx+Z0U29h/ANDb4PDK7raitGHK5x6ooOWSZPH6
         dJhxNkWpn04pBdfZT83eE4AAQbLvDmTVZNhqT2WAZEsHi/J2bXXVkC3V/SUCQA4zSY+F
         3i/VL+vLvRAYBsIAp/5g97vGmy8Hr+2jJI963cLtPslQQh0Z0dnLSGIAMptib3xZ6FhH
         pSJQ==
X-Gm-Message-State: AOJu0YzAxiTWpekTjOOkVN8bsoB9nAQt6FuyRf9KCVOfivbMG1a7w1L4
	c9sBQnc+M1JEAZQZXJqE6Y+zWJTupx30qR/6EfD5hL3+8O74E67+Fz3YMZiUeC65wjT8Yh9AiGc
	zTRdFJgm3U14gYn9Dtc+iE5KLlVTcmZ+sRl61LfDrFUbrsJr/43YO+eYkzJ1ZRdKXDnUsuNRXmd
	amaQ==
X-Gm-Gg: ASbGnculaI9LRuZbMaDi8RDHVEsz8q/brqd+P4Gk8blTFi33tZhr9EIZG7wcm+VDX02
	lf1V0Rzbj8x4ae678We2A0uzDclO3kR8c2AeQtGjXttB5BuMbbT0a/h/uLYXESTB+QlUi+GsnE6
	N3lsUckO94Nhv049j38TeOApFmhiNqCcz5mJoebsU4oaKJFs+i0Xl5HKDU7Ama+C3X4Xtf9yLol
	9DQaWcibOGRH1BukfAwnVSdIizFp+IvCSIq/ym+Z7p9RcLBRsucHuBu9jPL9tNMfSgwJxWU6QcW
	ze3kD3OWJX+77j3olLJ2lYcwHtFS+a89YeMQsSr4vNCU6tMApyKupCZRHrE=
X-Received: by 2002:a17:902:db12:b0:236:6f43:7051 with SMTP id d9443c01a7336-237d97a0078mr249634055ad.23.1750776264500;
        Tue, 24 Jun 2025 07:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtpvWaNXtgEovlpWkppj0lj2kPpVgXDcGxLVefBJ0YMbF5YswDncyNNJZgRock4Lo1EOpRRw==
X-Received: by 2002:a17:902:db12:b0:236:6f43:7051 with SMTP id d9443c01a7336-237d97a0078mr249633385ad.23.1750776263866;
        Tue, 24 Jun 2025 07:44:23 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8672498sm111316915ad.166.2025.06.24.07.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:44:23 -0700 (PDT)
Message-ID: <214e0531-ddaa-47cd-88d0-f73057253e44@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 07:44:22 -0700
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
Subject: pull-request: ath-next-20250624
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zegvEEXZWdrg-8VMdr9qlfRxLTN3FDIP
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685ab9ca cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=43BLvgXLegQtNCW6A6UA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: zegvEEXZWdrg-8VMdr9qlfRxLTN3FDIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyMyBTYWx0ZWRfXyR+7iC3yJ3jW
 daVkluvHG1HaKL99j9au/9Z8+10+Rme7p8pXwufmpCdJU5DoOhT/W6wvb2jQb3twHUqV+qrGcTv
 TXhOfbMCZ+R8aozrN4MTFSP8BVAlx1m0fZR7JEeaJLScr6hJVwKtI61+Q8j9jWLTG6yeWPteYjb
 PvtOEaQeYISZBjqsC57+k2nTIPT5zLkaVSFHOXexXei8kQT58qOMPqSEkdPNna4ShGjhs+GUrHp
 nWL32guY8646YKAoKnB8jf1KeMjfeCpjiUhOCVkf2uvKHfnkRco3IQHBsbVGP0v0a6cfh5RjEJ9
 KqSbNCY2xqk0asXcKBfNuuAuvV+RVsCtKQoAeiMpUb98zRiWPzsmrhgSOD0GLiptUgHbKMvcytN
 4m0wtNiyrQhFNihhqDfpQPK0FQEaX2qa4aUt6/PXbldwF8dGUXNjJkT4ZGAjCGQcgj7aKg4+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240123

The following changes since commit 757259db79fc6054780e07bb284f768b01cf8fa9:

  ssb: use new GPIO line value setter callbacks (2025-06-20 10:55:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20250624

for you to fetch changes up to 05062834350f0bf7ad1abcebc2807220e90220eb:

  wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type() (2025-06-23 07:28:34 -0700)

----------------------------------------------------------------
ath.git patches for v6.17

All ath drivers:
Add "#include <linux/export.h>" to all files that use EXPORT_SYMBOL()
to fix a newly introduced 'make W=1' check. Note that check has
subsequently been changed to only test when W=2, but keep the fixes to
suppress the warning for 'make W=2'.

ath12k:
Properly handle scan requests on multi-radio wiphy devices.
Perform the usual set of bug fixes and cleanups.

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: ath12k: handle regulatory hints during mac registration

Baochen Qiang (2):
      wifi: ath12k: avoid bit operation on key flags
      wifi: ath12k: install pairwise key first

Jeff Johnson (5):
      wifi: ath: Add missing include of export.h
      wifi: ath9k: Add missing include of export.h
      wifi: ath10k: Add missing include of export.h
      wifi: ath11k: Add missing include of export.h
      wifi: ath12k: Add missing include of export.h

Kang Yang (1):
      wifi: ath12k: update channel list in worker when wait flag is set

Karthik M (1):
      wifi: ath12k: disable pdev for non supported country

Karthikeyan Kathirvel (1):
      wifi: ath12k: Decrement TID on RX peer frag setup error handling

P Praneesh (2):
      wifi: ath12k: remove monitor handling from ath12k_dp_rx_deliver_msdu()
      wifi: ath12k: Fix double budget decrement while reaping monitor ring

Raj Kumar Bhagat (1):
      wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0

Rameshkumar Sundaram (4):
      wifi: ath12k: Avoid accessing uninitialized arvif->ar during beacon miss
      wifi: ath12k: Prepare ahvif scan link for parallel scan
      wifi: ath12k: Split scan request for split band device
      wifi: ath12k: combine channel list for split-phy devices in single-wiphy

Tamizh Chelvam Raja (1):
      wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type()

 drivers/net/wireless/ath/ath10k/bmi.c            |   2 +
 drivers/net/wireless/ath/ath10k/ce.c             |   2 +
 drivers/net/wireless/ath/ath10k/core.c           |   2 +
 drivers/net/wireless/ath/ath10k/coredump.c       |   2 +
 drivers/net/wireless/ath/ath10k/debug.c          |   2 +
 drivers/net/wireless/ath/ath10k/htc.c            |   3 +
 drivers/net/wireless/ath/ath10k/htt_rx.c         |   3 +
 drivers/net/wireless/ath/ath10k/htt_tx.c         |   2 +
 drivers/net/wireless/ath/ath10k/mac.c            |   1 +
 drivers/net/wireless/ath/ath10k/trace.c          |   2 +
 drivers/net/wireless/ath/ath11k/ce.c             |   2 +
 drivers/net/wireless/ath/ath11k/core.c           |   2 +
 drivers/net/wireless/ath/ath11k/coredump.c       |   2 +
 drivers/net/wireless/ath/ath11k/debug.c          |   2 +
 drivers/net/wireless/ath/ath11k/debugfs.c        |   2 +
 drivers/net/wireless/ath/ath11k/dp.c             |   2 +
 drivers/net/wireless/ath/ath11k/fw.c             |   2 +
 drivers/net/wireless/ath/ath11k/hal.c            |   2 +
 drivers/net/wireless/ath/ath11k/pcic.c           |   2 +
 drivers/net/wireless/ath/ath11k/qmi.c            |   2 +
 drivers/net/wireless/ath/ath11k/trace.c          |   2 +
 drivers/net/wireless/ath/ath12k/core.c           |   7 +
 drivers/net/wireless/ath/ath12k/core.h           |  13 +-
 drivers/net/wireless/ath/ath12k/dp.c             |   1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c         |   1 -
 drivers/net/wireless/ath/ath12k/dp_rx.c          |  18 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c          |   5 +-
 drivers/net/wireless/ath/ath12k/hw.c             |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c            | 425 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h            |   7 +-
 drivers/net/wireless/ath/ath12k/p2p.c            |   3 +-
 drivers/net/wireless/ath/ath12k/reg.c            | 117 +++++--
 drivers/net/wireless/ath/ath12k/reg.h            |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c            |  26 +-
 drivers/net/wireless/ath/ath12k/wmi.h            |   2 +
 drivers/net/wireless/ath/ath9k/common-beacon.c   |   1 +
 drivers/net/wireless/ath/ath9k/common-debug.c    |   1 +
 drivers/net/wireless/ath/ath9k/common-init.c     |   1 +
 drivers/net/wireless/ath/ath9k/common-spectral.c |   1 +
 drivers/net/wireless/ath/ath9k/common.c          |   1 +
 drivers/net/wireless/ath/ath9k/dynack.c          |   1 +
 drivers/net/wireless/ath/ath9k/hw.c              |   1 +
 drivers/net/wireless/ath/main.c                  |   1 +
 43 files changed, 557 insertions(+), 124 deletions(-)

