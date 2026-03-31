Return-Path: <linux-wireless+bounces-34212-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBNHNzrby2lHMAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34212-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:33:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5648136B060
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E118330AC69C
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F113FBEDC;
	Tue, 31 Mar 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aYdhKZyA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kxYMy5Nd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D53FB7F9
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967107; cv=none; b=M55LFHSqMe+jKI6zSOmVFmVGXuVwBx9AJuGFvL3c2mikkQYwjX2Z2aa/douCp2+XgSll5O80MuwSoQyOaMdVVTOcA/h4TfrDML4+kHBTj3fbFZvrOpYqkv34vpam738XaoBrajUolfR3j0RrVci5WQtfLLiXdDRmjS6mPXCymAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967107; c=relaxed/simple;
	bh=pP0nhGH1kfQpC//PhUwwLWcgkkC0ZpP+hBC6Xl0YT0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rIN0dMPb2EDKAPkSiEQ24iAgghXAgBbz7IXKRtVsryozVaL+9OezWVbyi6VIuMnxyzhafhNYGnT/u1774+YLx4wtuqcUegi8FccJSb5hz2lXkTCxgh0LUyZlqRixKhKabjdVldlx0dVZjeA99chKjwPK6yVK7zF3xpgpa5xDTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aYdhKZyA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kxYMy5Nd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VBVxpo1841101
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YECTTdP1I+PzZ/SFGYlP2fyai+r7MYYacG+
	b94gym80=; b=aYdhKZyAR+ZWWlPWEkgihsndvQiK15XqjLPW6JnsCMuqmrPxglH
	UJ28wIOtAQXDYM25ty09yMPaMMwJ6grARRVwe8u+oYg9+xrn79C6Gigaecc9FF9J
	nSQJ6xYuQhu0K86WXideX3SR2xD6ujaMtBeyfzfTqusroHIAzG6Ua9fZvaiCj6qJ
	K7K0kLn2CaMEvkSODx4JYPAobrHD0foV+h69lHJ9GgN24F0fN/T3bCyr5MpkqogS
	9y11OUAUonUBn9JWpeR43UiJu2YqMrY59svDEgXuEuA+7GK1bDKu03J5TKlXLNb1
	whkqgjAjNS4DtbbsK0dh9sYn8GdaCbskApQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80rskk6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so29317505ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774967104; x=1775571904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YECTTdP1I+PzZ/SFGYlP2fyai+r7MYYacG+b94gym80=;
        b=kxYMy5Nd6l87SkBKESqNPuMfNBzABUjnuYziGPGSJVs0q23LUdkWL26k4vRGa3JToZ
         kbwdeA9XXUuj8FNi5UAc0+akqaCSwZDRAIBnSw9t0eoDy2D4DCYJ8817Q0NVbAtZnlW9
         NjcYSDZw4U4/sjSoA+xK1CbQKXcntVAp8QVoYU1lfVr0FTLgAsmns9dfZ9rKxu05ODst
         BW/G5a9erD0+dTnaZxN2LfOovvHM7j5N1dz0P3g0UTyKuyDBkyDl+OjcEiDESuqBwDvZ
         g02Omzfhed3nWUwTY474ohtjsHr4JlsaEstpXPLm8r/6b3R469qExcDcwhLyys6L6a7s
         1Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967104; x=1775571904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YECTTdP1I+PzZ/SFGYlP2fyai+r7MYYacG+b94gym80=;
        b=cj3rpcriMe3DYaUr/8294Be+wkxCibopsXV0TRFKgdz1IvCd0KkIYkVnKyx21JpxA2
         hyrsplYU9Zt+sx9JfF3GdjBPUfON7/O4AGKI0IOyG4yCkuDzWje5ZQhEUS9hPV0uy1DL
         Rz6KqHbdxDVdTIJFb277OC8TQ0swxSQm6aAUGv2MH2qRJGRv6+M2LifTHd6CiSojcWXs
         RIQbLVxB+PMmV4Awaaa+eLChr9xcwqRyKQED1sGu0xhRCH4WcYvPlINrbZaBFGt5JP8i
         AaU1NKt3KQnPtPP7TuCwB5BEMCAFWEr4ft9PnB/ySwfhgjdw4AkGX+is0D2cDzXkJ6bj
         LHoA==
X-Gm-Message-State: AOJu0YwkXp4UjEGOjQ8zoxssh/qTdzH8heDZBgOCcasdGfvsJOOykHqn
	Ky53Pdl4aYVoRFeWKnwAAkIHcwZ+paccRFItrRWYWd6fMREHHLyf3UxO0exKLVxLXN340MmRDGQ
	XoBx5Vep1BsazuLCclkY38gCTm9J1e2jRGUDHPLnIvG+w+M/WdUJ8jDv4iHVNT6DYstiiCT+bL6
	R9Hw==
X-Gm-Gg: ATEYQzyR/94wbCOfpf42WYjzDNwi7wc2CXmCdW33cBjq+9Df2IN2pXUhlyNre/weYNh
	pzu4v0MtuZklo1PCrmeNKTvoxnYbymNfE4M2uBKifIdurbrdTRZ8L7ZdBP1kuumiLEsykTQognw
	1yf6M/x7PNYMD7xDrlej+wkB4SwLTSV+4weVrqix0v97SFwIgZABwlhDvZVcZ+I2NzZOWEeObKa
	iuuUp3Q0DRsNYHG2pmyVp5ALjxhGb3DhMFzaLaYHQw+rz5lv0rFAGslJSI7qqtnFQ3XIbD+ZShM
	5FncaY7SRO3OynSFol5D9o85bbBv/CpTvCD9BP0/QA0SCyMJg1l9jbLf0sNLyrVjt7K/5lFkMb2
	8lS/GtqfSKy1k25bdz/HXhxf5doIlmkTTjRPj4HaPYYU19hpctQDdqIn9kzjHYy9x712V8fLJwh
	zDvayEmK5557uLTRJNrBRWPyDYXzUhB3dZS4GUen1jr/8xaS2zzRo=
X-Received: by 2002:a17:903:22c2:b0:2b2:5515:661f with SMTP id d9443c01a7336-2b255157499mr73483165ad.9.1774967104124;
        Tue, 31 Mar 2026 07:25:04 -0700 (PDT)
X-Received: by 2002:a17:903:22c2:b0:2b2:5515:661f with SMTP id d9443c01a7336-2b255157499mr73482855ad.9.1774967103618;
        Tue, 31 Mar 2026 07:25:03 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm112030225ad.38.2026.03.31.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:25:03 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 0/5] wifi: ath12k: thermal throttling and cooling device support
Date: Tue, 31 Mar 2026 19:54:41 +0530
Message-Id: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CqWUcg81vWDaRarDSyDj97XKiKWIHEKL
X-Authority-Analysis: v=2.4 cv=VInQXtPX c=1 sm=1 tr=0 ts=69cbd941 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=kPw7zogRYXnG0GdHtlcA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: CqWUcg81vWDaRarDSyDj97XKiKWIHEKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfX15XfJocmhrg5
 eHS62T6KxC2MroqpZ7+Ce50IlEDNklc0/FlTC30jSf5FvuGm3eSRXVUSUBrQx5456paqrUZL03q
 9ZfdZdf3kSlCYLpGzsMTAab7k8i3bfmdBeCR4sU/xVVRY01CVvj717SUGeJTsQZWPpLX3w4ONRd
 5WSITXvfmGubfF7Qiu1Lnfgtbkz56tTDLYac6rfWu3KrLff5XtY34fwa6x9lOswV0x/NhTBeG0c
 147SVSv69IEKXt7xxRcTgjs44xi2c4pxxRUpUrRcVBSbcFRtjEsoSq0p9J6rZHWf1AB8uTUnVO2
 bxvWtxH2vWGTqNrdgMGovgC8ewSGxPOAtyGPTVsNLQuHcEv5tEhLuO7RnWkN615FWdQ3uWwmVtl
 Sq+rmNt4qWrdkEiovBGJkkL7NQfMCKMsTusslAHMl88Vy+neHdURgI++va5/zIDIJtqFjpIfWKK
 D77Syo/058/BZn7PMhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310139
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34212-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5648136B060
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 handles the firmware stats event so we can track the current
temperature and throttle level per pdev without spamming logs.

Patch 2 enables thermal throttling at bring-up and programs default level
tables to firmware via WMI_THERM_THROT_SET_CONF_CMDID; the driver picks
IPA/XFEM defaults based on the firmware WMI service bitmap, supports 4 or 5
levels as advertised, and only fills optional fields (pout reduction,
tx chain mask) when the corresponding WMI service bits are present.

Patch 3 refactors per-radio thermal hwmon cleanup to reduce code duplication and
ensure consistent cleanup across thermal register and unregister paths.

Patch 4 reorders the group teardown logic symmetric for safe thermal sysfs cleanup.

Patch 5 exposes a thermal cooling device per radio so the kernel thermal
framework or userspace can set the TX duty-cycle off percentage; writes
are validated against the throttling state range and host state is kept in
sync with successful firmware updates.

Examples:
echo 40 > /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_stat
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_state
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/max_state

Maharaja Kennadyrajan (5):
  wifi: ath12k: handle thermal throttle stats WMI event
  wifi: ath12k: configure firmware thermal throttling via WMI
  wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
  wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
  wifi: ath12k: add thermal cooling device support

 drivers/net/wireless/ath/ath12k/core.c    |  50 +++--
 drivers/net/wireless/ath/ath12k/mac.c     |   9 +
 drivers/net/wireless/ath/ath12k/thermal.c | 252 ++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/thermal.h |  35 +++
 drivers/net/wireless/ath/ath12k/wmi.c     | 107 +++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  50 +++++
 6 files changed, 446 insertions(+), 57 deletions(-)


base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
-- 
2.34.1


