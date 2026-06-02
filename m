Return-Path: <linux-wireless+bounces-37301-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M8/lKCLrHmpUZAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37301-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 16:39:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0562F5AE
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 16:39:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BSZKg4do;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AAdKM6LM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37301-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37301-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A75A304FBE3
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F433EF653;
	Tue,  2 Jun 2026 14:27:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAF3EF64A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 14:27:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410477; cv=none; b=jRTROuyFSLnhJQeXZ97xDUcse6LjTP3jn6J/dl1CYraFTSfoopBOvVZHAoi+RSmkDPiY3jb22G3kYFVSqDz9CyAUmq80B/BQvkEcRekcgqHVNhPI92IsG1814wCOH5nW9SKgK/jFlCNBxU9OsqxhOg1nr8LEIlaEpoQtfWBdMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410477; c=relaxed/simple;
	bh=UaXHuLTl6/gxmdxuI38ARvUEc6EnTmD+BW9D8wA8jI0=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=dxDi0jN1pul1x2tPcuh8TTZvrRjFJ5qU11LXIyUByJqS1mM0gfQ0c/T47JRApii7yQsl9SHw+KwOOqyZ5QSAfUAfNF4rAVZZgmbke3Cs860HmGbAN+yo7htNGSbOZSIo8QJCEeg957PsnFv0407xQQ7XbthWKzAwcjGncfasIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BSZKg4do; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AAdKM6LM; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652DF3oo2884681
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jun 2026 14:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O50jApDYHIgJb/YLiCc0da
	KUWGbnLsbEGopktQ8wurA=; b=BSZKg4doFi6Yc7w23PyEnxn/ermC+HXymQi7Gx
	MTU84Gmil9/HLIKmzjmEahYtYwns6qU+JfYWVddLJIGejMzJMGl2TRTAGo1t5C/9
	ARFk7VZljBobBnQG2/hebyoAoWfqsLjmD9bzxhJAZyBQ+q0sRz2OQQd/RxgWNwRd
	n84sqh+fDfOjml3+8tPdiUmRN7TzBw+j20fBbh3zPRup0CoYCDhDngQFnTmzn2Sx
	bsXxviE5PaMbGAsvWkjuTQQajnvsyUW0NzWTlrR8rALOokUoRrv3mxg4Q4LM1ntX
	i98okuppxifQNnDcQXYI3leyR4weTvds3fVh6D2EsSqp+aoQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsu11u3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 14:27:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304d8e9563eso6259704eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780410474; x=1781015274; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O50jApDYHIgJb/YLiCc0daKUWGbnLsbEGopktQ8wurA=;
        b=AAdKM6LMnyJysvixGXA6ciypIG/QkestTZjw/HiLirWWyYi5eKCAwbKtQLll/bVQQk
         69b7EZlHJyQXhcEqjSXwb4zqZYPPDLgZZIETQmozMh3Shs0CBwCp1+iyqdyAjaA+W9jI
         08AH3APSCB3tiF8qHdOe6Hoe8p+W7gqXcoH/ofwnPL+7XxexxayWdAgMr4hmGrEOnCbi
         G4dYqQg79wviXMHTRa/31YwBSIF6iQwq6s1MmbAna9mrTHhfh2pWyxkndnrj71ZaLoHH
         euHmTgy1gZqkynyuXyzMHGJKMVpJK9GrJZckaYfmH8DaUYYcJzKDm1QsAGx7TTD0ibkh
         45tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410474; x=1781015274;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O50jApDYHIgJb/YLiCc0daKUWGbnLsbEGopktQ8wurA=;
        b=Ps7qWwN629zLmI4fhHJ22k42JIJHgGP726fapdLHix6xrUXgoiY11w7e03BpXAKSg3
         ODokpTOG5jyFNN3Ai9idP+J8+kOXtxWZDApxY5gIhTmsw/hEdSTyhg4ykoLD5H0PyD/k
         th5plc6GtHxiJKStI4uqv5vri3SisIldHwmTjogvU41vzWpTjTpxoJ+OkOhPA56wJgtq
         V8GiYFFTAK11T6s/1Y6r6QQaTZ0QCDmrLmkWc68kCrpW65nkhakgGdDGmUiAqhnEorHU
         uS98wINZublyiBrOR9hQ/4+tV4S2RDb4cTZ/s7xtkRlomcixWlQct+AIBaznRFVu6mpy
         iQog==
X-Gm-Message-State: AOJu0YyfpDJanw1Cdw8jQ/v4vkLF9Kji7cRwJxL0XkVac4DItgAVSPRa
	P9GuJ7oK2GdwvORIv+fAOfjOvh8UAjoWPppJ6+lzaHv+AtgJ6J7gXKVsCSS9NcfF7t4UU2jFQ5f
	5j9OF8SMgm2eRsI1tFBmvRGF58Qt01vtT75DEq2Z7CKeSDX8OZiVTeRZukTIeeh1a/WdBzZG37S
	GRUg==
X-Gm-Gg: Acq92OEt3o5dXmVBle5Dj8LeEf1aHt+N9Hp6BBO/d5jR43JjUY2CjwRWggnR5EtgQhf
	j5gRCgf8I9+sgRwRwTR+X6AQd73HTexFwiEiXUbD0ZZLYfjyXYdnPofpaxnmhW5VHn079GDtPHh
	yLywq5mzRIMSpwqJAcLADHwKmagWW5JMClX7U792DOLiBh6qW7f01neBhlPb7561QPfw0NryH9X
	+yn5xaxqhDIfQaadc4YIf/3iUrw+H2M4SFi4pPpEY3s/mo5+4Ro2m6+P1gf6I1euqryzAM8O1Qo
	ebrORDiX8TRS1dZMErK1eNfCwWqistl9SXDokXsVkZmZ1vDKRVwsVHSMGqzrcRnL/kOtggcmXrP
	gjPwKz8h5y4TY7wXvpM6zah6V0Dp28qT5eMOd6+QI7WaBD2uuRNYgl3vXqvfQyxsSDYAr
X-Received: by 2002:a05:7300:5714:b0:304:1fb6:88fd with SMTP id 5a478bee46e88-304fa693196mr8120238eec.29.1780410474022;
        Tue, 02 Jun 2026 07:27:54 -0700 (PDT)
X-Received: by 2002:a05:7300:5714:b0:304:1fb6:88fd with SMTP id 5a478bee46e88-304fa693196mr8120214eec.29.1780410473495;
        Tue, 02 Jun 2026 07:27:53 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53d06asm12573698eec.14.2026.06.02.07.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 07:27:53 -0700 (PDT)
Message-ID: <10edc8a3-4d0d-482b-9ea0-30d827f67b2e@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 07:27:52 -0700
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
Subject: pull-request: ath-next-20260602
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4tbpvZEZT_RjOadbE2ERJctjIzEoW_iH
X-Proofpoint-GUID: 4tbpvZEZT_RjOadbE2ERJctjIzEoW_iH
X-Authority-Analysis: v=2.4 cv=MKFQXsZl c=1 sm=1 tr=0 ts=6a1ee86b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=lSH6NSywkKVUnX8X2cAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzOSBTYWx0ZWRfX/vVsDPpwEy0A
 ICLUZdefSuLB3GT3CN1tX+WlrRQL+QoEvzWUGouoiwSWS4TyR/Fq4XfjKrIeyCmDjoj3VNdVRUU
 sSLTHjeJ5FxpOxTEPzyRu/Fu88C4DFzPZ2fHbI3uk/O8ynZHQ8Sum2qLob1XUNk2Z2izyKMzqbU
 tZOZkTM2ZB/4xvkMtOy+cpG6/QWjdPd1aTxgARVQNVWiDlBfBVgeNXdk3woK/p/A6vMslbBtFlT
 1Nabr8tv7af3AdgPj1fRvJ/6A5Gz63gT8G2hn+/onqy3sAQ7lSO54xWhvP5ylCwCBJeMMkz7USY
 80Y28220DXNabnhcDf4XiTTWomSwGxJ9T6mT5wi6Fz/f+NP1KzlW/lSDkL6fjuFNdrxZeg4fF5N
 MYGhWfYLbojIPciMVKt7iUiSB+CJMg8h/6s7TKHer4bFpNoQK5LUFKAXCVRxGTVMO8GSKfwRl3P
 CLEjz8iQMPQlLYoCeVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37301-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:ath10k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46B0562F5AE

The following changes since commit e7d6bd24e883bf7c328d73c99bf6bcde19bf5e61:

  Merge tag 'wireless-next-2026-05-28' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-05-28 17:05:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260602

for you to fetch changes up to 565257a857690244211d85593b2cd490ce86783a:

  wifi: ath12k: Handle 4-address EAPOL frames from WBM error path (2026-06-01 09:58:06 -0700)

----------------------------------------------------------------
ath.git patches for v7.2 (PR #3)

In ath12k, add driver support for WDS mode.

In ath11k and ath12k, a number of cleanups and minor bug fixes.

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: add hardware parameters for maximum supported clients

Aditya Kumar Singh (1):
      wifi: ath12k: Prevent incorrect vif chanctx switch when handling multi-radio contexts

Hangtian Zhu (1):
      wifi: ath12k: allow peer_id 0 in dp peer lookup

Kwan Lai Chee Hou (1):
      wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode

Miaoqing Pan (3):
      wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
      wifi: ath11k: add MSDU length validation for TKIP MIC error
      wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()

Rosen Penev (1):
      wifi: ath11k: use kzalloc_flex for struct scan_req_params

Tamizh Chelvam Raja (6):
      wifi: ath12k: Set WDS vdev parameter for 4-address station interface
      wifi: ath12k: Add support for 4-address mode
      wifi: ath12k: Add 4-address mode support for eth offload
      wifi: ath12k: Add support for 4-address NULL frame handling
      wifi: ath12k: Add support for 4-address frame notification
      wifi: ath12k: Handle 4-address EAPOL frames from WBM error path

Wei Zhang (3):
      wifi: ath11k: raise max vdevs to 4 on hardware with P2P and dual-station support
      wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
      wifi: ath12k: fix NULL deref in change_sta_links for unready link

 drivers/net/wireless/ath/ath11k/core.c             |  10 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  59 +++++-
 drivers/net/wireless/ath/ath11k/mac.c              |  72 +++----
 drivers/net/wireless/ath/ath11k/wmi.h              |   2 +-
 drivers/net/wireless/ath/ath12k/core.h             |   9 +
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   6 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c          |   2 +-
 drivers/net/wireless/ath/ath12k/dp_peer.h          |   2 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  13 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   3 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   4 +-
 drivers/net/wireless/ath/ath12k/hw.h               |  25 ++-
 drivers/net/wireless/ath/ath12k/mac.c              | 228 ++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   3 +
 drivers/net/wireless/ath/ath12k/peer.c             |  11 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |  95 ++++++++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |  41 +++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h      |   4 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |  16 ++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |  16 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c     |   4 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h     |   1 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  16 ++
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  48 ++++-
 drivers/net/wireless/ath/ath12k/wmi.c              |  47 ++++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  17 ++
 27 files changed, 642 insertions(+), 115 deletions(-)

