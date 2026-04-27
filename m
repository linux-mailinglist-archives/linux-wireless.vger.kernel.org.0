Return-Path: <linux-wireless+bounces-35373-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLZeIFhw72mHBQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35373-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 16:19:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA1A47433D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 16:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89339300A658
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D213CD8C9;
	Mon, 27 Apr 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pkwAw36H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLVieosT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423073CF682
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299110; cv=none; b=g6+jYE4D+rd7wX5M6qp+qiUxbaWCbbojQW1IqTHMFyE1yLQwaLKMEEu7ywQchc56zdJW1eoH4AHSrHAHiukd4OvOmYmUT4D7rwhscCeJ3R9x3QOxR0pbttMyoZlwH2UoOimPJSm5889hLFB181kTVZ2SejTl36BH60IdhhP3RhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299110; c=relaxed/simple;
	bh=Vg0m7JBoY+uJfveLfww7yxAXvlrkh4WpMKpDvegB/L8=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=LplKvBu1zdPiqul4cZshRE52Ds3PZU1cWJbUnQotc620PdCilznrMY0ry/aADLOGdsVaPOjkgMDUx9292AUB0s5IRUYlmEobH5PalyvrmzCbn93rd2o13xJmvkJuyG+KmW1rNktiMq/9qX3yZ9wQJOUZTC4Cv1LNGQz0RDOH8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pkwAw36H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WLVieosT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDjXHA3962350
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aA8A2beOZ7PaJPh6gnoKuM
	WPVYV/5052moWZbH5LvRY=; b=pkwAw36Ho2+iE5B1Mzt8kXgT4DwZSZRo79Z+iX
	fXA9DJwzshq72ja/tCdp9dGo0QjhlPT+Oz0qRU5MsFAzIej1pb7D4rsolCheoKKH
	5v2napDN4XugCYzfh+BJc8OcPYWJCtwKYK+7iQzzsQ7C5tU2MgwvM3Df6T3ts4F4
	8NknCQnVJyLtbcEHEx+1/JZ9CVU7rsE/nI2jTUlw6ZMOqPvTrdg0jGM+lP2OHVlc
	EzNWIiBuc4Cm7uZ6/k/vG8XC3pxeUwrUW0o41junreK+EB98SJkF+hQ1d5QgMaf8
	DYnquS8MD9ta6NKbfGaIvYcahGsX3jmeVqNErWZ+R/SEIfsg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt4k31ehb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:11:48 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c91ef7009so29181058c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777299107; x=1777903907; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA8A2beOZ7PaJPh6gnoKuMWPVYV/5052moWZbH5LvRY=;
        b=WLVieosTWJPqEWmr3X9WdokcJ7GdTzqd5lJrbF50i1ooA+ueq+BWM4ixoulgg5D+wn
         d1HGqw+GCwRGYSgsqP5CvAngP/ZaIqYugYRDIw8z9zm1sriNMeJYEPAfaz+7gnzAjN5q
         GZzYWvFdVnPnTINWImVjHn8uyG8W+j8M9+QPDZu0EDfpgzScQ33FOlEVvLmXqigHqY+y
         4v9yc9S6QvS/zB+Z1isfao0vGuVHq+244yv8GPM6HdpjsroaJMMhLfrZBnKW95jbr/pu
         ztVx6BmhAz6WaXoLQAKTdVhT7RhkEM0iPrJZDRjNtUDUNtEvyz0k7FH7Y4KP19Jlh1C8
         +JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299107; x=1777903907;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aA8A2beOZ7PaJPh6gnoKuMWPVYV/5052moWZbH5LvRY=;
        b=GVrW2t3AJjlfWOLxzMJ4I3IKZ5c6BbR5U2sn/ArT9Q6etdKQzben5y8/tubljgFMKA
         RDCLJ6qnAsZucJXZ0GpNJV/qPMh8DIkeEvCSfIJgURa5B96+x7fH9MeHm0SU/wree1A9
         QwzJLBAM5sJj49THc+sRT8pEG3FLLQSkD8lFbIyoeUUZ7xh8A3r7l9hGM3/hQhP2ttvs
         i0gzufADLTDthCWNQo2eIvGPCuxySFwy/j+riyLfeKoYyehsGG4ah3rlDfzH/xCWcs7T
         A5uDWTwviTYEXdx6wgEoomKJN7xZfNavU48E60WcvAwGuvWqztzavR1g93X6zl7PLKP6
         PPTw==
X-Gm-Message-State: AOJu0YwUHeuBC+miWPy+6h9P2FnXegHRnQ9pv220ZUV3OPxFqdoKSbsU
	f1grNCmt0jpr7G4TXSri3TL8k+F+kRItz25XlBaKzBQX5qhLi0wIkhRWE+S5nCpNpxNOAWmYJmZ
	8bxWz8AMDRCvK0eYAl7oSGL4mz7eVeKVyoWqvF8eo79s8bDT5MD/518kgeqrTgLGsiRRey0rAdR
	z3jA==
X-Gm-Gg: AeBDiesgU1pS4EJQpbsi9UXpBwnUEYg+iD7q/mZJ5BXletwWGT0WVXjRW+oYc9Ghn8W
	CmD9npDY3Xd/ISY81FHbzxFO4NSWQuv1689MWwsljgotDCWSCMq8HTnV0+9KUXJfRVsrb6lA7x3
	yWnY5qT81H9T9MFXbmjRn11W92/34yzv/wH+3tblVjylao6X/hl8e8BPGg7yWjM4/eAyNW+0BLi
	UMaS0rJxKi/plh06F4zA54Bd39ryhfGgok6VbaG1oZIKNXa28KQsWNtDgfIGHe29DSozwE+xP40
	hrtJhxk4DHKqNmG9dUNGpbyLCrwiuqJbsMuOZ2w5nZt8ZPOr8PS2D2fxS7nmNobqZvbjLZ05X1Q
	czYKjKJ7clbnULhF64OpYGWhwcbsWrJUXQnz6Q2++JFwMtJm2LNRIMpGqcFlScau+aVKV
X-Received: by 2002:a05:7022:f016:b0:11a:641f:ba11 with SMTP id a92af1059eb24-12c73fad616mr23542076c88.29.1777299106988;
        Mon, 27 Apr 2026 07:11:46 -0700 (PDT)
X-Received: by 2002:a05:7022:f016:b0:11a:641f:ba11 with SMTP id a92af1059eb24-12c73fad616mr23542050c88.29.1777299106265;
        Mon, 27 Apr 2026 07:11:46 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm67154071c88.10.2026.04.27.07.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 07:11:45 -0700 (PDT)
Message-ID: <b1071639-e724-45f4-a1f0-51706acb7ccf@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 07:11:43 -0700
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
Subject: pull-request: ath-next-20260427
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1MCBTYWx0ZWRfX8pIyYdKlsA7e
 hn2pP5YVVBMe3ejBnfXPaZ2Dx5fJ40q5RKdaoMmseF6svG+zAR3f/47ykD4basuI5zuMdk4XB3C
 6BWE2xAgdCblXlQaFi+n8aNkGvCDNLTw1bekUZh+UVYdJOjGwdrAsmgyFKeOlO7Hw+Rrggpaop/
 ag1kVyNuU2GgTwjKjtiRH+EU/fF4b1xSBxylXUj/9wdbWDroOapHAmXVJ6AvAyE6wE8OGPrYhwk
 D0q6NAkjTIUSFAfhdbmjobRIKKvtft/r3hqJTH5KqMLuThdTPEkwhuXk7SV8ue5tKiQOqAHKI8b
 DxmNR0l8GLJEMQ73+k0/mRaBzTgUkFEtmJzUZT7PALXl9DTtukPqSy0Q1tTEMf7so10qgLB0JxA
 AQegFzYNlAIPe0374Z56CGFgtQxuifhP1s0he8+LzowSIxX0ekeLFuiTp6Jzs5eBbx9ys5+h2F5
 4QJuS+IBnCGWvX7tiJw==
X-Authority-Analysis: v=2.4 cv=a7QAM0SF c=1 sm=1 tr=0 ts=69ef6ea4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=m6NHjSuB-jaKV5Aw_IsA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: Nflpvr89eCcWNgytWVarVKvvh5d2Cvbn
X-Proofpoint-ORIG-GUID: Nflpvr89eCcWNgytWVarVKvvh5d2Cvbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270150
X-Rspamd-Queue-Id: 7FA1A47433D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-35373-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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

The following changes since commit 929298742bb5dfacd53ea99cf989cc81210f90a3:

  Merge tag 'ath-next-20260408' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2026-04-08 23:26:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260427

for you to fetch changes up to 34a5329beee86a22a446e27eb37f06caa63479ca:

  wifi: ath9k: Obtain system GPIOS from descriptors (2026-04-22 06:57:12 -0700)

----------------------------------------------------------------
ath.git patches for v7.2 (PR #1)

For ath9k:
- improve the GPIO interface.

For ath12k:
- replace dynamic memory allocation in WMI rx path
- avoid buffer overread when configuring IRQs
- code housekeeping

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: Fix invalid IRQ requests during AHB probe

Jeff Johnson (3):
      wifi: ath12k: Fix HTC prototype ath12k_base parameters
      wifi: ath12k: Fix ath12k_dp_htt_tlv_iter()'s iter() signature
      wifi: ath12k: Remove macro HAL_RX_EHT_SIG_OFDMA_EB2_MCS

Linus Walleij (1):
      wifi: ath9k: Obtain system GPIOS from descriptors

Nicolas Escande (1):
      wifi: ath12k: avoid dynamic alloc when parsing wmi tb

 drivers/gpio/gpio-ath79.c                      |  57 ++++++-
 drivers/net/wireless/ath/ath12k/ahb.c          |  25 +--
 drivers/net/wireless/ath/ath12k/core.c         |   6 +
 drivers/net/wireless/ath/ath12k/dp_htt.c       |   2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.h       |   2 +-
 drivers/net/wireless/ath/ath12k/htc.h          |   8 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h |   1 -
 drivers/net/wireless/ath/ath12k/wmi.c          | 217 +++++++++----------------
 drivers/net/wireless/ath/ath12k/wmi.h          |   3 +
 drivers/net/wireless/ath/ath9k/hw.c            |  33 ++--
 drivers/net/wireless/ath/ath9k/hw.h            |   3 +-
 11 files changed, 188 insertions(+), 169 deletions(-)

