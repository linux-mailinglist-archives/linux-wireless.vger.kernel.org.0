Return-Path: <linux-wireless+bounces-32412-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIE1C2QNp2k0cwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32412-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 17:33:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E11F3DF5
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 17:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E26073061764
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743BA394796;
	Tue,  3 Mar 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hD0AiqE5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CWtHGlgI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4737186F
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555281; cv=none; b=Zg+6b6JQoTU0XAVKFtic+EGnsCYkM0hWlbqKT39Ld5EaxwyX/a+xEvzdjZ0d/4JGZ4w3udrJtEGmuvwUG8QSYkyVUOdMFs2BX0auYy/9UbA6RYfYYgmTMQS5FH14TKGjzhTie+VzMLjtrykPo2kL/qQ3xxwhDFVI5XtoZ3JmzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555281; c=relaxed/simple;
	bh=l7+eGeSrCVKwsuyvqHv0jz6rgNNo3zF/lih522pFzgI=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Twkp1Wd8opBgBxkt1kz8hI+7lvzpSjg6fMCwuXp19d3HVhBA0hUPKEYWVDq1GUKKparaqnfltSkJOcsRHaXQ39/Nlj2eZ1mJgyCTZG7i/bxta15ZKkCyMH1THRelRUfFbbsvIqD0LLekqvjYm+2Yn3A9WspwQBO0j2/f+rOkdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hD0AiqE5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CWtHGlgI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623FVqKW1060771
	for <linux-wireless@vger.kernel.org>; Tue, 3 Mar 2026 16:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KYInzzJjsnnU1zrSS2VPuJ
	6KrmGRMortrB9S+4pnuA8=; b=hD0AiqE5rRSUQro3xKz4TZduHfTaFPIKLOs74Q
	2mtGoArBTujZj1syc0yN8Q5twKRpTwQAFtYPzY/4tMdlBYuVwbnjEMFwVAfTuZYv
	/V0CE59OX+OetbaSoZYK1KeI1vvq0HU9o/3Ac3ZxAeNAe7v7JhlpdVK1734rXe1V
	bQVyx/rSjc0l2xDteMKPm2CJwIgFtE7NzHvNVZDWUURgsWHVUemjrlK6h2dVCAMT
	wZQsLywuMp9sS9ItHHFO/2FkyQRf6miZWUD++N1QDbWPs7idT9tkQPfDlHe4QB9K
	Tj4v2cAh0lJ7PyAFxBXcxNpi/DGs0xgFU7VBp8yvcnH5I+uA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp2c9g6e0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 16:27:58 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1276e71652fso10218947c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772555278; x=1773160078; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYInzzJjsnnU1zrSS2VPuJ6KrmGRMortrB9S+4pnuA8=;
        b=CWtHGlgI7QGC02zFahIhqgZ+eB+Nu5iC3hCmdbfoZHnclKyq0P85SZg9B/91jDFT7s
         nUAZTTbo8nroGMZkFx1TirLiu+yDkNoXHErk83w7XMYb0Gjlr9lXhSfhByhzlwl1i/Yx
         PZ3rGp7o58Vh/znyu1C8Sa9wasUhSPBhFHfGYlq7use8CvhMMhaBfJrPjfh0MP9IEnZm
         YqxzUIzwzvl2yJiiRLnWZEqqjgyicDPjxun0w7tbb0jhqJU5Yj8FxnJxfO0JHjwub+Yi
         fWETCUdNHUKYRzMRyv4Tw6P7M7Zr3X3G6axCqYXJdZ3yAd92bc6Gv/oKpcnehVfqpPLa
         d5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772555278; x=1773160078;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYInzzJjsnnU1zrSS2VPuJ6KrmGRMortrB9S+4pnuA8=;
        b=KxHn0W8RrWEEtToXoifnM2aIsqh/zxGAzWT0t6bG2ntDuN+ijVhHY41ZSjQx6Dh34F
         SdYmB7KpMHT+JBFZNWxBQjCy+138Tfje1x0o4UHbEFjN2a/Qn37BJ7y2YXjur+FCrohW
         nXHrZsgd7fCcG2nNh3ATpM96o39Ni5siHiQJU58x2p4tZFgRM1qV31E1I3Lujq2ovJAK
         /vtHV67DAoIPEDD17ss4zVdU2t7mer9pxVhpnQpOlm/KDcLviyXojpHglpOSyOhJB6aC
         TZeqpLWzQH/LI4vfP42F9t9fJIkltFAJqjZiJ1QAu8ZA9/zqD7QZyTCC0BR2UHyk9eEW
         +LIQ==
X-Gm-Message-State: AOJu0YykLDN9mG4Rk3Vez1GLH55QHjKszZjT4VryNm+Vkw2PW6R++lYR
	cP/BuZLeym0oMrzeNwFo4unPWw9wySLR1VKQi7xy29ulTGu0/mvh+f4B0KlMy15Hp8l++OK2sCi
	HUujYrXRtePnych/uXJPbibr7NDl3tGz3dh0gmKFloluqV+4aevEXt4vXGFFeE4WyVAT+kx+0QB
	z+xA==
X-Gm-Gg: ATEYQzzQE5Uio5ushMHHeIk0ndeCRn6PkPMu+oRdEfFowHsOvbKnarH3PCm9beMblRY
	r69WvvwqlXqUL8L/4LsnYlC5KAgPmLq34/ZPcnxcNL0EB5ot+IIOYcLa25PYgb1jEWOy1XWL6q1
	gRqxI1bBJQZcEZRgOjrYbNHGGYUS5SsCxjJhm2c7wai5EwlYa7IIXvucvGPyfGT9B5Ddxkc/Ipz
	65GMZqzATRtFPHW0f0W3xO8U2fq3ySkumpFPhWdFEgS0Y7BZqo/RTjU008TAOTJ+IKYniTNbYyV
	f3VbNgK2lR/DrpUNBTLURFK5KSsV0DIhEPcFoxcBW8N3PvoTXw/BtsKCCC9NGlr/n1swb+cEoYt
	nNSD1tRVx+bCBFL1I4scwcssrgPC0bNTu6s0xqbRCXaxAC+qAHUw40WP73Q==
X-Received: by 2002:a05:7022:6296:b0:11b:9386:8265 with SMTP id a92af1059eb24-1278fc7e36bmr6954130c88.42.1772555277489;
        Tue, 03 Mar 2026 08:27:57 -0800 (PST)
X-Received: by 2002:a05:7022:6296:b0:11b:9386:8265 with SMTP id a92af1059eb24-1278fc7e36bmr6954110c88.42.1772555276815;
        Tue, 03 Mar 2026 08:27:56 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32633sm19601264c88.9.2026.03.03.08.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 08:27:56 -0800 (PST)
Message-ID: <79e82568-e951-43f4-ac87-2319245a5490@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 08:27:55 -0800
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
Subject: pull-request: ath-next-20260303
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEzMSBTYWx0ZWRfX93nXwcXZ34Bf
 ZfOym7J5OyW8FLCqNwh147yryx1xklnil0ISUNA0jY6vOtO3bGDee2zK6TZQwM/JNASzyYkhLLE
 M3O5dc0lQqzFMUhekj3nmM++LPkIVnNZzeutKGIXAEl2svhXu/nF2dbVr8YQuoKLpf0sSNkwCTZ
 f5jlTO3LuOVqqrLY/OMJMSsUWlIKPh/Jgrz3lhoc6stWuDTPIDABeXlGHcbXQ/0SgAlYG1EvR2H
 967ZAZs99vYM4gUnxr4UHubAalDiL6cWZOYkf3yqERVD3N4NZXYFcKrE2BizHcilACQ+VuTpEyW
 bzMOssploH9JHEUc4fa3ZMbA70JQDS3FN+cUvjpbxgXeyqrIxGP+h4bmswQU/0CPYxaV3C8skqv
 W14tJkDx7D3ljx3pf8gnju4GbCDOxsLuIRXwlBuYbmhN2c/u1FSAnO26lMoCrGw2UMSq24RB+y0
 5cAIWJR+wHbS2bMhFTQ==
X-Proofpoint-ORIG-GUID: 4lRTHOlFEmtFIa5c2yt-2DplL6pg0wx2
X-Proofpoint-GUID: 4lRTHOlFEmtFIa5c2yt-2DplL6pg0wx2
X-Authority-Analysis: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=69a70c0e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=bNXkL-wRCx4twWDb0eEA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030131
X-Rspamd-Queue-Id: 766E11F3DF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32412-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The following changes since commit 8bf22c33e7a172fbc72464f4cc484d23a6b412ba:

  Merge tag 'net-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-19 10:39:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260303

for you to fetch changes up to cf7cbf97c630c3414302945617b8ac405e2b0dd7:

  wifi: ath12k: Remove the unused argument from the Rx data path (2026-03-02 13:02:05 -0800)

----------------------------------------------------------------
ath.git patches for v7.1 (PR #1)

For ath12k:
Add basic hwmon temperature reporting.
Enable monitor mode on IPQ5332.

Also a few small cleanups and bug fixes across ath drivers.

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: Enable monitor mode support on IPQ5332

Alejandro Colomar (1):
      wifi: ath9k: Fix typo

Baochen Qiang (1):
      wifi: ath12k: fix indentation in ath12k_qmi_aux_uc_load()

Bjorn Andersson (1):
      wifi: ath11k: Silence remoteproc probe deferral prints

Karthikeyan Periyasamy (1):
      wifi: ath12k: Remove the unused argument from the Rx data path

Maharaja Kennadyrajan (1):
      wifi: ath12k: add basic hwmon temperature reporting

Ramya Gnanasekar (1):
      wifi: ath12k: Set up MLO after SSR

Zilin Guan (1):
      wifi: ath11k: fix memory leaks in beacon template setup

 drivers/net/wireless/ath/ath11k/ahb.c         |  10 +--
 drivers/net/wireless/ath/ath11k/mac.c         |  28 +++---
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/core.c        |  23 ++++-
 drivers/net/wireless/ath/ath12k/core.h        |   3 +
 drivers/net/wireless/ath/ath12k/dp_rx.c       |   2 -
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   2 -
 drivers/net/wireless/ath/ath12k/mac.c         |   4 +
 drivers/net/wireless/ath/ath12k/qmi.c         |   2 +-
 drivers/net/wireless/ath/ath12k/thermal.c     | 124 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/thermal.h     |  40 +++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  25 +++---
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  57 ++++++------
 drivers/net/wireless/ath/ath9k/ath9k.h        |   2 +-
 15 files changed, 255 insertions(+), 72 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.h

