Return-Path: <linux-wireless+bounces-32436-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SATMI1rcp2kRkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32436-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E41FB77A
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8452E3008284
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726D29408;
	Wed,  4 Mar 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nu2yV4CB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LxrsMfXb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29C30CDAF
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608574; cv=none; b=dc42EJ/d+QZzvrvYUg0zX8Hor3X/tnr71OVhaJrPogFEoex//2f8gevxRj7In1WUjvOeens/FnUsB3zx1pxmfgAqH7Oc8smRx9DRtLWyGm1Oge+ustTHWraEF+ukU8+liC6Npl7U02xsaxL4do/hpULLYHybh32+3BsdVp9/LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608574; c=relaxed/simple;
	bh=jn/4YVe/w4LO0XLMeSBzLoB69z99vrGhOgPwV9L/n2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X5sGMsMoV614VaxdnCBCdTk8mOUIWS83taH0806odJDngHAo9SjpQuOvpKTNysfWx+FTIRHSHvvEcys7v65bRhHHxf+g5h2qBBMq/4yJUZSvySK5XTcyJGZzMU/roFm4Zu6JG+HqTfmQ3Y7XhuRm4XbSI61ntim7qR1loIqfBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nu2yV4CB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LxrsMfXb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SOYv956993
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=atxk/2pngNbphCPjDcoDNmtt7F/wHuOn4yd
	LR3Jhba8=; b=Nu2yV4CBHq9MzA7Z66ijxvfxTuH1TkFETRBUl9uZKK5hTp8PwrH
	Yo0DFahrZx0yY8ZpkzEoeHNwvLIiYyUbds6ZqF2xdx25ev9aXubUdxdb8TArKBRV
	BTU7Cz6ZhrCEkVuobtc+1a27L+TP1igIypEGN9SkKar15k0+ahu9N6ZjCfJfjzLz
	rb9ffd0hknKG/Xka0O2pcN7WuGAO8gBVHff+Y2aIX8ioc7YNMomxxFVDccyJsRr/
	7sSh21yp8xyLb1haicFkAOhcAB6e5nRMsvHI5MtNPCuXsN/1cfVNK8jc+a9hlN4y
	v3JvaaAROuWDJB107xj7uKYmkTSWWVqNwKw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp6qg9ta1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so7330067a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608571; x=1773213371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atxk/2pngNbphCPjDcoDNmtt7F/wHuOn4ydLR3Jhba8=;
        b=LxrsMfXb0KOYPlgeJAwdfATnUy3dZGqTiyOSuTguUhloiwIWQuRi24PXHhPYSzXNwU
         5M9v9a/T5+Zr2a1cOQWmJJFI5QEWawTUaJX4oxg0jjrhW9pBeIZN0v1Ywr8+6CPTJIaS
         N0l/EWxuzQilUB1HaMS3pGyJZ4mv3I+ssFsgX2ZSTDx/kJybhVBPSH4e7FBuXOwrZna6
         VBJkfPoV2XIFeToIINeahcVURqE1HERKAwzhsLcQUw7ON9QGE/VrJplNzc9K/ww0Dp25
         W1D/1J2MSPFoU+Z+EOiFW+h1KKxqjUjOkALoAK8OXrpPpmDhqahe3mWJxW/kwsGj1QDG
         ZTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608571; x=1773213371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atxk/2pngNbphCPjDcoDNmtt7F/wHuOn4ydLR3Jhba8=;
        b=E8wp+XzD9Obr1eMsY1om+NUulRov68UCFInrPn1CFVeFLbhP2EtN9gbB8fPLV0oZMS
         /yl3XaCJm8j0CwuPevCZAItqfjBIdTEzXfv/PExPy9GalxJOnZfSgf/Ll7R9uv03tw2K
         P2XIgLLFmaWYwQ6LtFaBn/iOaui4R9fZ320x9WkFgRVMLms0v4tRDZD0uubzRBlryJp1
         xSJu4LjPEPMSdUGYVFJ/bbnhsaI3E1UXkYoGN9iJRFsR7BYRErcyniPogqZLmyD5ggHE
         ns1oi7tmlzkau5mTw/DaaBsBzJvFRAnaOzFojjlwDTpLag/REBrsaTak5YebFINc8Qz0
         wGcQ==
X-Gm-Message-State: AOJu0YyJUlLrA2i/tErIB+YU31+nL3L0V8ex648RhmaagW6WXjIyEKey
	q5bbIHQdIocqNrXxOLFvyjjkjlMQArmp5salXhEboj2PUNvRA3gaWPcv6bxxHrAZ19yPn7z+SqE
	V1TbV3O0sI19eQ1u/x9m7CWq0h6SNRFZ/5gg/8pENwd4+6/3JaCw3FrR4CKFWNoOJIoOM
X-Gm-Gg: ATEYQzzIczioFz63v/46UNTfjzSlhgO13knG1QAWzaSyPheQ0RYKDBtV+3R9G+T3g/3
	uDPYt/6sTfkYXIkwsTI/hURKgvDSR7iwW3M82x3iBSs/UKFwjwTYSso3grXeTz03bCjpE3b9xFW
	fGQp6e8yY0zcncZW8qVU985GqblAw0gci9kSwh4jnoP7Qg7qeKhexbkeH3Wff54HFDeW6E/s8Qx
	7xm0fXb8F0NmEQEz2db7olRWpt5U+zY1WszmqNSAUz6ySBqaR5pNJx+61LC3NpiBpZRFwHk7paH
	AcnnhKv9ZKFdqYdlKfTvYgKYpBgJxl0KgA/DZ/9lFPVi0ppv0nRgqdbid3uc90Erd7zGk1Nhjsg
	ipnoTlrcj5+QBI3zFq7noo6G0ZxS5hCSAOkGuNr8Ji172q8BUlYiGJsg=
X-Received: by 2002:a17:90b:4ace:b0:359:8957:7285 with SMTP id 98e67ed59e1d1-359a6ce6902mr983671a91.3.1772608571420;
        Tue, 03 Mar 2026 23:16:11 -0800 (PST)
X-Received: by 2002:a17:90b:4ace:b0:359:8957:7285 with SMTP id 98e67ed59e1d1-359a6ce6902mr983664a91.3.1772608570927;
        Tue, 03 Mar 2026 23:16:10 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:10 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 00/16] wifi: Ranging support enhancements
Date: Wed,  4 Mar 2026 12:45:22 +0530
Message-Id: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX0cEEe6p9XxH8
 Sz9vHeSyKLAElIgoItRcPjUGlIrIz1uXou69YK8LmL6bRhuW81ahPHxQ7Gk+onQaUeghQeLRhzr
 svtcwIJOFqpa6KOfRHFsOWTRpRduo3aOhk3jZ8o6aCctj3jTleGvkc6tZg2DyUidCR5lWjsdckT
 tJJtwDyVgzS6gmqomBmSDD0sQzu0GOwjAxIbAg7AwCy/UgtSGx2wsmJkCiLUazEpV2R41DNEm6A
 CUhYnLt1903MTig2XYukvN4qXj/uGA10O7G1YZyktqImC6ajEclhrrF+KGZHp/1v7kbh7lw7PhN
 k7IZxKzAW8MDOfQkaQWyczXtVjo2ixKNzW0/p50FtFQlbzoqBlOi7sYo14MX2R35OO5/o8lvTOp
 AuqjBQ50KKJcWADcHwTnl7D1/CKGl1wXCCzk+avu/jZNj+W+tZ/pQCixWauh18A7h09O/pUqaKE
 N0UtOGD7MvtiPz4++hw==
X-Authority-Analysis: v=2.4 cv=UJ3Q3Sfy c=1 sm=1 tr=0 ts=69a7dc3c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=_1k6ZK4AzPOUXZl5XPoA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: PAyvlepHoKsaxa371h_46UD_9fbpY3h2
X-Proofpoint-GUID: PAyvlepHoKsaxa371h_46UD_9fbpY3h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040058
X-Rspamd-Queue-Id: 351E41FB77A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32436-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patch series introduces Fine Timing Measurement (FTM)
enhancements and Proximity Detection (PD) capabilities. The
implementation follows the Wi-Fi Alliance "PR Implementation
Consideration Draft 1.9 Rev 1" specification and extends the
existing peer measurement framework with advanced ranging
features.

---
Changes in v2:
- Addressed comments.
- Removed ABORT command implementation as it is not needed.
- Added a patch for enhancement of Remain on channel command.
- Intoduced a new interface type PD.
- Added a patch for suppressing ranging results when requested.
---
Kavita Kavita (1):
  wifi: mac80211_hwsim: Add support for extended FTM ranging

Peddolla Harshavardhan Reddy (15):
  wifi: cfg80211: Allow RSTA role without LMR request
  wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down
  wifi: cfg80211: Add MAC address filter to remain_on_channel
  wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR
    operations
  wifi: cfg80211: add start/stop proximity detection commands
  wifi: cfg80211: add proximity detection capabilities to PMSR
  wifi: cfg80211: add continuous ranging and PD request support
  wifi: cfg80211: extend PMSR FTM response for proximity ranging
  wifi: cfg80211: add role-based PD peer limits
  wifi: cfg80211: add ingress/egress distance thresholds for FTM
  wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
  wifi: cfg80211: add FTM range report negotiation support
  wifi: cfg80211: add result reporting control for PD requests
  wifi: cfg80211: add MAC randomization support for PD requests
  wifi: cfg80211: add LTF keyseed support for secure ranging

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |   4 +-
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   3 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c | 171 +++++++++++++++
 include/net/cfg80211.h                        | 181 ++++++++++++++-
 include/uapi/linux/nl80211.h                  | 206 +++++++++++++++++-
 net/mac80211/cfg.c                            |   2 +
 net/mac80211/chan.c                           |   2 +
 net/mac80211/ieee80211_i.h                    |   3 +-
 net/mac80211/iface.c                          |   6 +-
 net/mac80211/offchannel.c                     |   4 +-
 net/mac80211/rx.c                             |   1 +
 net/mac80211/util.c                           |   1 +
 net/wireless/chan.c                           |   2 +
 net/wireless/core.c                           |  31 +++
 net/wireless/core.h                           |   2 +
 net/wireless/mlme.c                           |   1 +
 net/wireless/nl80211.c                        | 183 +++++++++++++++-
 net/wireless/pmsr.c                           | 169 ++++++++++++--
 net/wireless/rdev-ops.h                       |  26 ++-
 net/wireless/reg.c                            |   3 +
 net/wireless/trace.h                          |  32 ++-
 net/wireless/util.c                           |   4 +-
 26 files changed, 1000 insertions(+), 49 deletions(-)


base-commit: 5d048bbed1bb2bbef612dad0bb9c177c434e63a4
-- 
2.34.1


