Return-Path: <linux-wireless+bounces-31384-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGBnKsPVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31384-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9ABC54B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D323005D3C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9933B6EB;
	Fri, 30 Jan 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8q3u6Wl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E7gCX06c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3232B992
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788859; cv=none; b=Hw+8e4tfNUeo+CvV9eXHGrriX4e8pHrsazWUA45ge278YmnSuuaphZ20aCjztLY0wAIjjd4FGyealUAC0/SGor+Ky2cfmzHMs4jtsXx73qUkU9UXxM1wVLpb9hktrRuIl9s3k4t4VYOBh+npgiolBRjz1VJCVuBqhQPzqYHEeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788859; c=relaxed/simple;
	bh=QmZ84cFH7sBoIJk+Yp4aXQisKszUhHCfft/vRHX/rg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gygvl/Wn5JBt1J6v4TxZmIo9pXsWnruvCbgb4hjaM7eQUMyl09GLs9+f6pUv88q7sfNDGIe37F8/jDm9Y+Mu0kUeqtK0OhHlw8WIqlXwqJEL6qvFzwsvriO+nJ2X7wXa5dXTdGpb4KI4R3wBMEFBB2bYU6cpqDFWgIaVPJXHF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y8q3u6Wl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E7gCX06c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UC4V2R555356
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IFsHmYxsU5SDeQ4jsNoJ+qMw2JDVOw0vFxa
	VpKQe6FE=; b=Y8q3u6WlHQUJFHvattFRpZvamKPCWN+Rb6GHtWui21vifQ3MfGV
	A6DIUv5p/j0k0arr7kmjKQuTY08kF0nv3jTDJurEsRwuBjH+cFrqZUk3Z7XMgvd/
	2YvIXFkVHJmGnM9QrYq9Eu8TkB0H+3DhqeGsZlKTdq+PvHb+LVaK7nP4DGw9QNjK
	1+ZTD4EewT+qu/FefJLB44HRlVXMBPKC9S0cr8pQjm2jQgrDEbFpuqB9DHydAy+V
	5juuoBeU9yYdhg5+Kaz0mQracsdumivRHbwGCMwWUUwNuWWACkhJbbMIALAnrB5V
	p+9cySSLM1Xw1eHYjRGeJV2WUvRHup1aXzA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59hwt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:00:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6124a9fb86so4548367a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788855; x=1770393655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFsHmYxsU5SDeQ4jsNoJ+qMw2JDVOw0vFxaVpKQe6FE=;
        b=E7gCX06cZ2Nmx1+hEYNt9wZz5T/tx9b86vt2DUmuKFboUOEJU4OyHqJzT5MTpLnloE
         BRelRNQ1+qpiIQ1cCmQgZ9Ycqq+ihWSDU2L6mz+JVgS1tc9r76FcqmPSNzzofA889lPa
         sXz7ImqXkW1JazR+xIc9lh6CoEe4q46PJVy9Lu6boADocGlVAbjeA/leBEs1pl493GuC
         LpXqyGEhX5llmM0UINQFpPDuQBO4GU92R7qTr1Of8MdVCGADbzPXiROz8Zl7+c8gk5aZ
         w7AtzhEk/RNUYSJsm4jjPv8Oy02fTqa5FHBFGbmrnclNqsgS1/mUwW0dKzTm/F/BRtZS
         Q4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788855; x=1770393655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFsHmYxsU5SDeQ4jsNoJ+qMw2JDVOw0vFxaVpKQe6FE=;
        b=UvCNoZckM6BY4EXH96Q+EW8oTGDp5RmR01yTBNGTtHmLSaT9RJuWrEClEmkSLkIakk
         MCSC2yvqbXlURR2RebuoTMYOEsPtfy/zJArcDCNjzPM/Msk4PcKbwlxfaNEUU7DQDZQB
         rjnkXhgEsn2mVzMckIw24WAhwwcrusSBXwXCnkHzHLtyJmovOa+b/KbkjNZBsHOXwx2P
         ExLEcosTjjPTwBuFx6vWB66w0EsNoX9ub5vLK+i7D+sZmDgu0Fr0J0IjffSf9Ts00o6X
         LI6nnr0knTZRsC5xAn1VRFtkruH4lgQ4bh06pR4GA4Bc7MsIddYdFXlYllPZvWO0kVS9
         io+Q==
X-Gm-Message-State: AOJu0YyBQpMn21X8XzZ9J4Y4T1joQrkZVMweRlrIAej7yjZrz3ut//js
	QB6NDCYxMw5au12gCcMFZrO6HDfCoYvX/48f5Ve0ARug6YEzrAVs41GG4LRPReRj+FtctZ3b/EB
	pHV8Q+AMzzYw5A7W1jcsffuazZc94s/IMBW5GDe3K7rbP6S1Ghh15lLItkAUQwfhu3YY/
X-Gm-Gg: AZuq6aLnEvJWOSPTwb2PBXm0Z/JWkWYsUvGEvu10ylH92roSq1BrLtENsMMLDgG5BwP
	gEN/NJQ+0MB/dronStXqgBTio2MrPzz0AXEEc7Mfm9HOzDvXX3t9PpiktVFHrVTPAgtZNT7vAjp
	KGdOk530JbVk4alKIFHLKIlivmfM9OnV2NZu32aMIw5QhPOlL7Cg8MRB7eN7JMNR4CsRS6Z714h
	IRXt8yFJ3dk+jIkWr4CkPVbEXEmo5EelM+uK13Tyj1Ut2hFNYCRVhguQ27jVFuQCp8k5YQKC5P1
	Z1tEow0yMJTHzUYAotY/zE2QoFGeEXHw+/2azO2VN6Mt/EiaWuRsGzMXL5IW95v7KcwtCR/L4I3
	nPxOP4feK95cQjW9xeKDdATq7rZFmm2EzijZR5SH+2eM=
X-Received: by 2002:a05:6a21:a42:b0:334:a11e:6bed with SMTP id adf61e73a8af0-392e0053615mr3588023637.29.1769788855080;
        Fri, 30 Jan 2026 08:00:55 -0800 (PST)
X-Received: by 2002:a05:6a21:a42:b0:334:a11e:6bed with SMTP id adf61e73a8af0-392e0053615mr3587930637.29.1769788854010;
        Fri, 30 Jan 2026 08:00:54 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:00:53 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/13] Ranging support enhancements
Date: Fri, 30 Jan 2026 21:30:26 +0530
Message-Id: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -2qKBZRZiXFX7Bx7hZHTBpMiKMEV4iov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX6q4QATc0/KGO
 scmQ84xLqASi9AzdOg1tgwRPIVxFy4Gas44FdSLLXyNzlnuQF6kU/JA1m2gJTEpsiPVjYqIh7Bv
 eKvNKKoMAPnfHljs0fiLKtE1MXuAM77UuWNEPisH6un1DqMTtKKf+wf6p1pT74jm0W7KTHhK9Mx
 rQfo5ZoTKDIh+ffhVS6OzIJ/PILX9yCCxWy9d0HcwK6lSBp0hVkdb+UkQHAJ++EOgJjd/mHTQsB
 UtEtXmRSoik1pvFCJdtMbXIXO00tKbojy8o4dBj+wxGMHMWHL7nwRPM10ZJWPBSbIeLZOSXw0SD
 DkAEPRw1HvOVpZkwlFo2edhaYtGKHRtoMPXyZcJLHlCmQVTiDfEiCZTw8wdXb194pdP8JgGu7dg
 knX4Tkh9mE7EhvsJbbcHjlVjFlfYDwMlQydJOqCqm/vKWjh71TkJiVdiDPoakxtaVl0PZc1xiKw
 7P/sOO7zaeHWMsMtiGw==
X-Proofpoint-GUID: -2qKBZRZiXFX7Bx7hZHTBpMiKMEV4iov
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697cd5b8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qu2inaDxBOJAkTJPEb0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31384-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D2B9ABC54B
X-Rspamd-Action: no action

This patch series introduces Fine Timing Measurement (FTM)
enhancements and Proximity Detection (PD) capabilities. The
implementation follows the Wi-Fi Alliance "PR Implementation
Consideration Draft 1.9 Rev 1" specification and extends the
existing peer measurement framework with advanced ranging
features.

Kavita Kavita (1):
  mac80211_hwsim: Add support for extended FTM ranging

Peddolla Harshavardhan Reddy (12):
  wifi: nl80211/cfg80211: Allow RSTA role to be enabled without LMR
    request
  wifi: nl80211/cfg80211: add proximity detection capabilities to PMSR
  wifi: nl80211/cfg80211: add continuous ranging and PD request support
  wifi: nl80211/cfg80211: extend PMSR FTM response for proximity ranging
  wifi: nl80211/cfg80211: add peer measurement abort command
  wifi: nl80211/cfg80211: add role-based PD peer limits
  wifi: nl80211/cfg80211: add ingress/egress distance thresholds for FTM
  wifi: nl80211/cfg80211: add PD-specific bandwidth capabilities for FTM
  wifi: nl80211/cfg80211: add FTM range report negotiation support
  wifi: nl80211/cfg80211: add result reporting control for PD requests
  wifi: nl80211/cfg80211: add MAC randomization support for PD requests
  wifi: nl80211/cfg80211: add LTF keyseed support for secure ranging

 drivers/net/wireless/virtual/mac80211_hwsim.c | 141 +++++++++++++
 include/net/cfg80211.h                        | 163 ++++++++++++++-
 include/uapi/linux/nl80211.h                  | 177 +++++++++++++++-
 net/wireless/nl80211.c                        |  87 ++++++++
 net/wireless/nl80211.h                        |   1 +
 net/wireless/pmsr.c                           | 194 ++++++++++++++++--
 6 files changed, 738 insertions(+), 25 deletions(-)

-- 
2.34.1


