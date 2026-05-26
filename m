Return-Path: <linux-wireless+bounces-36903-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPoVNpTMFWq6bwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36903-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 18:38:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D25D9D54
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1071130589AA
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AC937AA98;
	Tue, 26 May 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuUbKLhn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U5JpXPIj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8138F259
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812710; cv=none; b=WWpN0Ymy+owsFL8gegB25zEqdTDKzRJkEuqq5BmehWzfbP2CHJ3ZYoRmHtOq3w/otUlRVYPJKy1VnJX5VPwP0u3OXYwlQZYaf/xwWmKu7xuKasabpA6IG8g2GoXBZo7bpY/WB656JbGeUfsroOB4rf/CAY91xnvSFXzBE3nfmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812710; c=relaxed/simple;
	bh=fKTpl9+eroFu5DGRjD0p+NI2C7t/irpNNTKeveizf4Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=NYURZxXuYx8mvaRzCyjGWE6pxnmhlsBWo2Y2ISzlOktmTiQJQjdIazoqT5opEkNGweBZiGtOhcsQcbymZq7FhbKHUxznPPTwivNS9fPFXUGWjXbeJHMBfAhCfobfTYzD8nUUSSH03e0F3YD3foJYZB9wxux3Mv/cUOQO+JFbfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuUbKLhn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U5JpXPIj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QEuHi22671177
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 16:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c0i5VAlmRLgG+rEOSURd6M
	t9CnnTszTK9KxsVzAEs4I=; b=KuUbKLhnTZoKNWh+Kr7qo6zUp/C7vBmqaCcDmh
	0olPi26dIgkEz+OXys6OiZvQ800fjClvoDvj54GSogqhL84g15v7yK9N2CJZj7bD
	Us63pjPNnYW+f8/jS+r7xUYTxU1mGZXQeyStPHHM8aD8eFuwop3suyj6o6bbETYP
	ZB3alEZmm4GN+9FWZd4vgvNG4aCqKRReNtZ0bW0fD1Hv5lRnQGDr6P6FdkqG4hDA
	iE+nbe+kKylKPSarOMSA+se67XlrdMnfKEitiie9zejZZfClfWbWofLnUS8sd08u
	z+YYzt0rDVfk7yGCbqbUgPlUp3qfV26blrrt/kRlN/5J4PPw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddqkrf2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 16:25:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-132d631edaaso1321439c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779812707; x=1780417507; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0i5VAlmRLgG+rEOSURd6Mt9CnnTszTK9KxsVzAEs4I=;
        b=U5JpXPIjxpQhkHIOYA2z5bOdNvH1StblcK14IiLsYm/n7t+cLx2vv9v3GdggbUX2Pb
         YGqsrIevWYXW9xNwRKCpdtfwTWumH5Dk/kFjbicmmQbD/R/ZtyQcrqnIT3YEw+3GlVCM
         IN9/S/ljN/vr+dca5oCm3LOue9MJUlu6pdrtCJTbUym0rYXa/QWbnjiDwZkCVl3H676k
         XwdyDWdefHOuX8aXZ9NEoooQN4Dw5JkO/UAoD8pUg5Ii2vA9F2BQzehgFtcuQdmVhl91
         KAUrwmdcsN6F0e44WpnIpvIm5P7w0/DtK7EG7jqFL5e7KUgVajhOUy48qwn/9Cm+3nfW
         tpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779812707; x=1780417507;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0i5VAlmRLgG+rEOSURd6Mt9CnnTszTK9KxsVzAEs4I=;
        b=GEg/Ug/mAm1Mof6cI6ODAKhugph6sKwI8EpBipJMaW7qCCFy4Wb0RsErMVFG40jVzg
         CELpBV3bkpU5ZZIT/TOEEr1uobea7Is93rp4PX4jAfUsXof/eVXl+RYbIdrz8iCAn3qi
         Z8YHa7kJ4bcLKukwt5TdWfOEzkh5gKxtTyBKhqTbsSOoPrVorAaS5DpTwaQSC3Ka45Nz
         CsedsuNlTYOv7xVXU8++eYBilmXA+W08pfYC3PWmnj1lPdb0qUI6VzAxlVDLLFxnNjLJ
         mxxIYr0fz77O4TzbDx3w47RSzwvMOzYqh6mOL6YdRv6ZpWHG7FPT7uXc0Dh/OnKOr61L
         f7JQ==
X-Gm-Message-State: AOJu0Ywd/PsywMeSzaM+lLFrrUM6faEeNRg9PIN35o1lIkH8RyT5KaaB
	YygToAhYqhkkUfs7kyNSIrwjU7X0sTUvmmUKr/YT0ZdOCpAP4rte+5usMde/55RyMysW88WgiyW
	GJ4MFMQWl1x39sWy9ekStScylgEbP8tjG6RFxYLUe5HqB8XUgmwmNo1ehNiNwlSKaUb8bqTq/Ay
	CqOQ==
X-Gm-Gg: Acq92OHggZR5ZRdoXMITPFggi+9MzxVkpLDVRkaa32fBNGHoqhM4n2DYV8dwEOUasHl
	xs3pp6n3emRENpmfFOsIzzFvY3vezHImMPja65sRMABJMxH5P/NrjcGI6B3CBFSVIDc6cMtEnWU
	TvCOyLIe4usy82/h4g0Gam1dzc9phm/auXgKzV8bQVQg1HOGu12MG72U31rw9PUUq670FS5GRgF
	hEr5lkrOB1tAf/dCYi9OqQcUfVyGcMmmjAZVejHtUB0Bvjshg3xmgfmQaydlD/+28a73W9kKYII
	tQZVMsMvkG9sxSqDeY9X3CdG0v4YnLbYDmA2sJfAOVZaR7HIMXOu+DVMMsAD6nJlJtfKN1WcLl1
	QYPHMZCd5GUun2lxa7XEgKeyAU9Ly0qn2T5W7bh48u3CPuN8DoWElUGHRCw==
X-Received: by 2002:a05:7022:6ba3:b0:11a:3734:3db3 with SMTP id a92af1059eb24-1365fc6d6a9mr7904472c88.32.1779812706428;
        Tue, 26 May 2026 09:25:06 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba3:b0:11a:3734:3db3 with SMTP id a92af1059eb24-1365fc6d6a9mr7904454c88.32.1779812705815;
        Tue, 26 May 2026 09:25:05 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13669c6a2adsm8721944c88.0.2026.05.26.09.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 09:25:05 -0700 (PDT)
Message-ID: <4fe17cef-7cc6-41fc-960a-385366861c52@oss.qualcomm.com>
Date: Tue, 26 May 2026 09:25:04 -0700
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
Subject: pull-request: ath-next-20260526
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zubd7d7G c=1 sm=1 tr=0 ts=6a15c963 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=W5QCRmDefjtvIb0_0ZIA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0MSBTYWx0ZWRfXyzfbqwwsQ4w+
 6m9hx1yO9QyLIlhXsYRyQJbewpNumJm8aPZGHORiThyW/1S35tUEbU4TSIe6c6EYoGfN68Zw09r
 yz6IaDxMI0k40hFIRJGyaCH8mYJRXHwKnbrV8Ywa4WEwkGxzqRkxzg6n+yAB3oW4EJsVhUymo0Q
 bSbE7DBLOidc2AM5uZPSQCIQ+i3069t+SpsMV/ut54PvBTZbZGftpqwCtaneqcj373aqU9obyCd
 MkijKypWyj0iMDVrBTT1OL43wD6XHzRdkP5muvjhiMGLJx/ObdvDykh0GXxbk+odZOty2gM28Fw
 /eHY0w+39h+PmGOD/024HECFbqrQ62AmszzbUIkJv1gsOVQ2fz9YmO4ETyi0/GlkSLC1IcU6G3r
 B9QAAvTq0Pb5ASmLEyHlo5uciDane/QMhQzSDQxNc49oFFDNbVVmo8YHU0ESEhJZKl5+u0bothB
 qVo7wtrKzeNhP5Ni8QQ==
X-Proofpoint-ORIG-GUID: J-61lCTzqKO2lSKSaucqmnNVN7_6scjW
X-Proofpoint-GUID: J-61lCTzqKO2lSKSaucqmnNVN7_6scjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260141
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36903-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA8D25D9D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 7baf5857e15d722776898510a10546d6b2f18645:

  wifi: brcmsmac: phy_lcn: Remove dead code in wlc_lcnphy_radio_2064_channel_tune_4313() (2026-04-28 10:43:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260526

for you to fetch changes up to d5c336161088c588f85da64f48ba6deead194afd:

  wifi: ath12k: fix error unwind on arch_init() failure in PCI probe (2026-05-26 08:54:27 -0700)

----------------------------------------------------------------
ath.git patches for v7.2 (PR #2)

For ath12k:
- Add thermal throttling and cooling device support
- Add support for handling incumbent signal interference in 6 GHz
- Add support for channel 177 in the 5 GHz band

In addition, a large number of cleanup and minor bug fixing across
all supported drivers.

----------------------------------------------------------------
Aishwarya R (2):
      wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz
      wifi: ath12k: Add debugfs support to simulate incumbent signal interference

Arnd Bergmann (1):
      wifi: ath10k: drop gpio_led reference

Daniel Lezcano (2):
      wifi: ath: Use the unified QMI service ID instead of defining it locally
      wifi: ath: Fix the license marking

Jose Ignacio Tornos Martinez (1):
      wifi: ath11k: fix warning when unbinding

Kexin Sun (1):
      wifi: ath10k: update outdated comment for renamed ieee80211_tx_status()

Krzysztof Kozlowski (1):
      wifi: ath: Unify user-visible "Qualcomm" name

Maharaja Kennadyrajan (5):
      wifi: ath12k: handle thermal throttle stats WMI event
      wifi: ath12k: configure firmware thermal throttling via WMI
      wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
      wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
      wifi: ath12k: add thermal cooling device support

Nicolas Escande (1):
      wifi: ath12k: unify error handling in some ath12k_wmi_xxx() functions

Ripan Deuri (1):
      wifi: ath12k: fix error unwind on arch_init() failure in PCI probe

Rosen Penev (4):
      wifi: ath9k: use non devm for nvmem_cell_get
      wifi: ath9k: owl: move name into owl_nvmem_probe
      wifi: ath9k: use kmemdup and kcalloc
      wifi: ath12k: use kzalloc_flex

Tamizh Chelvam Raja (1):
      wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023 type in Rx path

Tristan Madani (1):
      wifi: ath9k: fix OOB access from firmware tx status queue ID

Wei Zhang (1):
      wifi: ath11k: cancel SSR work items during PCI shutdown

Yingying Tang (1):
      wifi: ath12k: add channel 177 to the 5 GHz channel list

pengdonglin (1):
      wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock

 drivers/net/wireless/ath/ath10k/core.h             |   1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c           |   2 +-
 drivers/net/wireless/ath/ath10k/leds.c             |   8 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |   4 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |   1 -
 drivers/net/wireless/ath/ath11k/Kconfig            |   2 +-
 drivers/net/wireless/ath/ath11k/dp.c               |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   4 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   8 +
 drivers/net/wireless/ath/ath11k/qmi.c              |   3 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |   1 -
 drivers/net/wireless/ath/ath12k/Kconfig            |   6 +-
 drivers/net/wireless/ath/ath12k/core.c             |  50 +-
 drivers/net/wireless/ath/ath12k/core.h             |  12 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  46 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  68 ++-
 drivers/net/wireless/ath/ath12k/mac.c              | 110 +++-
 drivers/net/wireless/ath/ath12k/pci.c              |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   1 -
 drivers/net/wireless/ath/ath12k/thermal.c          | 252 +++++++--
 drivers/net/wireless/ath/ath12k/thermal.h          |  35 ++
 drivers/net/wireless/ath/ath12k/wmi.c              | 565 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h              | 125 ++++-
 drivers/net/wireless/ath/ath9k/ar9002_hw.c         |   6 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |  31 +-
 drivers/net/wireless/ath/ath9k/common-init.c       |   8 +-
 drivers/net/wireless/ath/ath9k/init.c              |  11 +-
 drivers/net/wireless/ath/ath9k/recv.c              |   4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   7 +-
 30 files changed, 1180 insertions(+), 196 deletions(-)

