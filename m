Return-Path: <linux-wireless+bounces-28510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E337C2CD14
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B9B189DA70
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F001316185;
	Mon,  3 Nov 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFBx+cYX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbmCu7kt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472E2FBE0A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183445; cv=none; b=DBhyTyL4c6/9JPRCe7WQ5n5Zt4kn+88oTqTAV+ocEwNs9A4JqVSq8kDIZuMP/VztB5iRKSoR5XxhjaLLKwGCuItNFFFj9EDx/Yb3tp4G647EZhJjWwLe/l69VBd9U5mXPeYAJY7fS2JJq0saiZEIqq2yrUSrRPGDQc4wwhglDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183445; c=relaxed/simple;
	bh=oPCoCIxi3rKMgGBEs7VtaWREPFpUWhWjIksy+JOmX5c=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=u7e4Q1RntRU24UvjQwSvzNswnq2HVTCqzpj0Ddo0EgGgDQnuaeNghfjR4jKXntxhynVwL4S+ufxOO2oIfC7ol84CvlgQAmnZWtefG2jT2aQwTMUTdr9xh4YU6/kQC3kjjMGkDTZ/xPb8S+KKFEkAzmhnFc8O/nx2+fmjdfctPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFBx+cYX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YbmCu7kt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3ARnGV2890346
	for <linux-wireless@vger.kernel.org>; Mon, 3 Nov 2025 15:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O4woRQI0jpUKcLl/l0yKE3
	wmuW3/I5wz2p+nBq08PBE=; b=VFBx+cYXc8mTm/lZT6D4kFPFX55ZbrmDryGiBK
	2HCSU1WxAaKJqOalF6fwVYSzExQvLq+L9ZxOTWquqSWSppFdgDgD/y57JTu14MDH
	LBkmUg2JwSZJcUlY8gU47Eh85aaqoRNi2BRmvJm+8zqxYEYjPGIefJS8VgAbQv1g
	SnmGKe+F+4vekBPw5PR8qDXlfK7I8lwGY3B95FSqakXa+HdFzPTkjKwPtXu2M98u
	l2yacHrEZ+/NyMzu/hiJfY7zlBQNkm3S76IRiA944pOnyusNAX6UUwU234hFjSAH
	fIJHM8ESnFuuGBk+W/AoyBYQ5v0upqW34DYWMXHZqugLav8w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6tnrgr46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 15:24:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b92bdc65593so3052832a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762183441; x=1762788241; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4woRQI0jpUKcLl/l0yKE3wmuW3/I5wz2p+nBq08PBE=;
        b=YbmCu7kttzFxEFSuj+cM2HaBhvOBH9RrjvR9oBqqxPJFJ1V97axheX/Fb1/apzWo8e
         0ibscglDBzOvZhiYZHorvmQN+0KeeJEQjV4Jkwm7HKSB+yAh0myVrCsYuiejyPBNQHq8
         o5crcqodEfG02Bmkhdz/zw/IJMf62hJ6oUYPhwxAmYW39FMTOnMc07MLhm1qQwg7aEkJ
         AaAud+uJQuwpyVAdymdqLTeMXG05prXCMOZvx9+9yIafD6dX4GUCVn0rdFuTYmNMQJxr
         Yh0NJ8IWcoiJOGhSk+zhZecyTAgu1fbXYq7P27j7iT+bcFW/hXhEuXRZPUe7JvKVSC1z
         7+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183441; x=1762788241;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4woRQI0jpUKcLl/l0yKE3wmuW3/I5wz2p+nBq08PBE=;
        b=VrUAPmVZ2Gfmh6CsMbVswCkdiWNt90G9NqKr/mUkkMkUOcyFVSVP6FcZlED2oE5taI
         HpOzJKi/Mjnp7VvkmTf814kTwPvZQbZvoPXgn0OJrp3b4eKXIpG0v6f6sfMaXBM/T61J
         xTJuTHwGLixBkVpLW2VS3TkcNsiIDRK3nnfpSrl0Dw842qI5VCQsgRk7v+EqYOQTAxC0
         R9e2VOQMSe5jSOr3UM4m4neYKKDQRkLGq0pEKO6i+p6SlpjO7SZWo/ZIaoca0dn808er
         Znw8fC8S7o17sgDOv7LCBJsJz7mcpfx3ifEeTiNj6htnWWKGGEqlLJn/uGdqKXPaWy0m
         AIOw==
X-Gm-Message-State: AOJu0YyD3nM3S6Bf1wYAUMsgEQbcTbbqUFPTT95fZBQ7ARKmD851GjRt
	O1rfp7TeDCTcF13JcRb8cNBpj3DKQb69ddNNBroI72TrxmgyGNPkYFlzI5PugH7CFBHmKhW+xDG
	ViorVsWasjnIYSUCLTas/rf3zzRNK+7jSqCfJ/OjKsjECW4N3ksD641boLiwiiMq0XUDpqquMm3
	SHOw==
X-Gm-Gg: ASbGncs9EDsrbpbZ3GifKdXTHiQoYjBjJYOc8TsHVOuFO0rHNdClm38zaVChMXv4aWi
	e+DVzVz869kuFG9rYi4GmgYH1o0qfOg+kyndGV4rC5iJTmPALPvN6yECEhgR2suFFt9RYGDm8RY
	5lO/KBpFR5ymVwvSIKFbZ+f36EtwvaA08SGvd8T7Vymlq8PxtlrlMvxRwTiVbdPui7G5LXWp+gi
	bSdelElzqpg7KQ9c1AQwvGvFo7Ua/h3bsabwe2yn2lb7nGlEppC7AHvFNq9p/YR0rRQdBHZj3cq
	Gfh7/oD96saYinapdCO4b9Aly7Vz6UDcsdFfRXQWANXDit/ah8p51LPYirNYyA5Ed67zM2F3tZf
	P5O4DG0G8J+YosG1K78i84KVAsl9q8LyUdFI=
X-Received: by 2002:a17:903:1ce:b0:27e:ec72:f6d with SMTP id d9443c01a7336-2951a36e6f8mr196389195ad.11.1762183441194;
        Mon, 03 Nov 2025 07:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE81KX5Dw/Ser8slGU94o0wfgS7d8oR2J9GcPMTjt9tMgbij5CwCOQwqqb6pSnep8GEANLVTA==
X-Received: by 2002:a17:903:1ce:b0:27e:ec72:f6d with SMTP id d9443c01a7336-2951a36e6f8mr196388845ad.11.1762183440630;
        Mon, 03 Nov 2025 07:24:00 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29530aac357sm117914315ad.86.2025.11.03.07.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:24:00 -0800 (PST)
Message-ID: <30db167b-0ebb-40f3-8beb-e3966a4922f0@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 07:23:59 -0800
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
Subject: pull-request: ath-next-20251103
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEzOSBTYWx0ZWRfXw327tv75OQ/0
 080+Xs/Y2ll2J1hbs5K4vZSUy7pdr+a1LWbxgJlxLQav7BUhFnzP2yDl1PheA13p5CN/CvwlmMU
 JEGz0xcmgDlSypb+/4c9IGAO/hNUTAw307r7w0ALxC4qI/pQujgQ+tZszFwqWIpXvXWXcwfFtam
 /Lv8WA7yYud7OtA1rHfijYJnyyIZBa/jVJK2AP7QNKCB7C/r0D+NEisf2nYYg9KF3barVlxVNVS
 A0Vc6bEL5GKMbMKNqFQFWiDY+eadgkOr2Pau730dVT9OeSEARhfYW+/ONd/4qdtvsdClEq3D4xX
 r4wsKvxCGbNsB0m6kx/spUwFDYaX+jNbyaHySHRbWNxTPzq3FOuoOTEzoOeMbplUeiliHz3UMPX
 Y3cIEr+zcejGn6LvvZDWtmSFkZolUg==
X-Proofpoint-GUID: o4g9to31fCXOmUVyhKct3hlLqVi9hPxV
X-Proofpoint-ORIG-GUID: o4g9to31fCXOmUVyhKct3hlLqVi9hPxV
X-Authority-Analysis: v=2.4 cv=BrSQAIX5 c=1 sm=1 tr=0 ts=6908c912 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NlKQ8RDDprgilyjO-nkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030139

The following changes since commit 94aced6ed9e2630bae0b5631e384a5302c4b6783:

  Merge tag 'wireless-next-2025-09-25' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2025-09-26 14:27:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20251103

for you to fetch changes up to 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08:

  wifi: ath10k: use = {} to initialize bmi_target_info instead of memset (2025-10-30 14:55:08 -0700)

----------------------------------------------------------------
ath.git patches for v6.19

Highlights for some specific drivers include:

ath10k:
Add support for Factory Test TLV commands

ath11k:
Add support for Tx Power insertion

ath12k:
Add support for BSS color change

And of course there is the usual set of cleanups and bug fixes across
the entire family of "ath" drivers.

We do expect to have one more pull request before the v6.19 merge
window to pull in the refactored ath12k driver from the ath12k-ng
branch.

---

Note to maintainers:

There is a trivial conflict between two patches:

From ath-current => wireless => net
9222582ec524 ("Revert "wifi: ath12k: Fix missing station power save configuration"")

From ath-next => wireless-next => net-next
6917e268c433 ("wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon")

The resolution is to take both hunks, ordering them in reverse xmas tree style.

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()

Aditya Kumar Singh (5):
      wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon
      wifi: ath11k: relocate some Tx power related functions in mac.c
      wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
      wifi: ath11k: add support for Tx Power insertion in RRM action frame
      wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION

Baochen Qiang (7):
      wifi: ath11k: restore register window after global reset
      wifi: ath12k: fix VHT MCS assignment
      wifi: ath11k: fix VHT MCS assignment
      wifi: ath11k: fix peer HE MCS assignment
      wifi: ath12k: restore register window after global reset
      wifi: ath12k: fix reusing m3 memory
      wifi: ath12k: fix error handling in creating hardware group

Dr. David Alan Gilbert (1):
      wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params

Jeff Johnson (3):
      wifi: ath11k: Remove struct wmi_bcn_send_from_host_cmd
      wifi: ath12k: Remove struct wmi_bcn_send_from_host_cmd
      wifi: ath11k: Correctly use "ab" macro parameter

Kang Yang (1):
      wifi: ath10k: move recovery check logic into a new work

Loic Poulain (1):
      wifi: ath10k: Support for FTM TLV test commands

Muna Sinada (6):
      wifi: ath12k: generalize GI and LTF fixed rate functions
      wifi: ath12k: add EHT rate handling to existing set rate functions
      wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc
      wifi: ath12k: Add EHT fixed GI/LTF
      wifi: ath12k: add EHT rates to ath12k_mac_op_set_bitrate_mask()
      wifi: ath12k: Set EHT fixed rates for associated STAs

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: fix TX and RX MCS rate configurations in HE mode

Rameshkumar Sundaram (2):
      wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
      wifi: ath12k: unassign arvif on scan vdev create failure

Sarika Sharma (3):
      wifi: ath12k: Fix MSDU buffer types handling in RX error path
      wifi: ath12k: track dropped MSDU buffer type packets in REO exception ring
      wifi: ath12k: Assert base_lock is held before allocating REO update element

Takashi Iwai (1):
      wifi: ath12k: Add MODULE_FIRMWARE() entries

Thiraviyam Mariyappan (1):
      wifi: ath12k: Fix NSS value update in ext_rx_stats

Wei Zhang (1):
      wifi: ath12k: add support for BSS color change

Zhongqiu Han (2):
      wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
      wifi: ath10k: use = {} to initialize bmi_target_info instead of memset

 drivers/net/wireless/ath/ath10k/core.c       |  28 +-
 drivers/net/wireless/ath/ath10k/core.h       |   6 +-
 drivers/net/wireless/ath/ath10k/mac.c        |   2 +-
 drivers/net/wireless/ath/ath10k/testmode.c   | 253 +++++++--
 drivers/net/wireless/ath/ath10k/testmode_i.h |  15 +
 drivers/net/wireless/ath/ath10k/wmi.h        |  19 +-
 drivers/net/wireless/ath/ath11k/hal.h        |  38 +-
 drivers/net/wireless/ath/ath11k/mac.c        | 455 +++++++++++-----
 drivers/net/wireless/ath/ath11k/pci.c        |  20 +-
 drivers/net/wireless/ath/ath11k/pci.h        |  18 +-
 drivers/net/wireless/ath/ath11k/wmi.c        |  20 +-
 drivers/net/wireless/ath/ath11k/wmi.h        |  18 +-
 drivers/net/wireless/ath/ath12k/core.c       |  22 +-
 drivers/net/wireless/ath/ath12k/core.h       |   3 +
 drivers/net/wireless/ath/ath12k/debugfs.c    |   5 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c     |  19 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c      |  74 ++-
 drivers/net/wireless/ath/ath12k/hal_rx.c     |  10 +-
 drivers/net/wireless/ath/ath12k/mac.c        | 755 ++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h        |  14 +-
 drivers/net/wireless/ath/ath12k/pci.c        |  24 +-
 drivers/net/wireless/ath/ath12k/qmi.c        |  11 +-
 drivers/net/wireless/ath/ath12k/qmi.h        |   5 +-
 drivers/net/wireless/ath/ath12k/wmi.c        |  86 ++-
 drivers/net/wireless/ath/ath12k/wmi.h        |  55 +-
 drivers/net/wireless/ath/ath12k/wow.c        |   1 +
 drivers/net/wireless/ath/wcn36xx/hal.h       |  74 ---
 drivers/net/wireless/ath/wcn36xx/smd.c       |  60 ---
 drivers/net/wireless/ath/wcn36xx/smd.h       |   1 -
 29 files changed, 1554 insertions(+), 557 deletions(-)

