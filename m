Return-Path: <linux-wireless+bounces-30342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D2FCF233F
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0134B300CA1C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB82D948D;
	Mon,  5 Jan 2026 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZMguoIIl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VHabZC6H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E902D877B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597912; cv=none; b=tEG+UUUjx6PvUwE3tTfVsXg+JGV79xTZzlPGvYtCeLTUabcY9zS1nLS0GBJBZ5ULKt8rEPHYlEdNMg0/tdNSH5l7VZdGLVb3yTCw4MWoFHJozhvJx29lWuvxNHEF9YoUob4X4E2K3AIvN23uAilQdXzVVE0rHw9t84ptF2twkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597912; c=relaxed/simple;
	bh=R09JJwTo/W5Tm0jlHXBF1ooGLhA/UWZZQ26Mxf24YBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkE0DOwK3R9nP8VkvMEloNtrszLWXdc2jwyEKC7z10mBl1Mdc87Dxhk9hR7V2WPlNXTKBpWyzcPijaaJQsX38V4k0/YfDHE/OJWzwNkeKnk13WDRtzFtSm/A86VjHJ6UtLGrs2qFdRj8Bu8nfKKw4AZRxlefx+HgNQV7zlaxexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZMguoIIl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VHabZC6H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604HOgSC3017042
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JTRoF1HYVCzjIy8nYESzRWW9j2CbNhwi6c5
	AEwUr1T0=; b=ZMguoIIlMpzBJVBdne9zAh1ahEAWwLkjZkud48f4mF66mCgCOkq
	Czdr/Y0wZ4FBpXMKG2fiqcczQzRYEsmJpRBRIRrH7c17tJu2KHfFtiAnNp6TMW0o
	9oVWB5JIhWNpdIaSfewM0KwB2TieFs49IG5u7KpNZERDZ45xvSMr+JmAokTOgSez
	FK9yhbEksEvTU/z7hF3eIjQICF62HSyoX8PIl8T9OvTUlCxNVpxVi13jS76IoN9s
	lJAa5WyIUhg0ZHYzeXNTRL0/X6MArXRLGjYFvlvt+nf6rIg0lIOwRp3MbLdspVTG
	GhkncNbtAOVb2rZLU/7vE0Dbe4Sh1vt1nvw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beu6t3j1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7d481452732so26008333b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597904; x=1768202704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTRoF1HYVCzjIy8nYESzRWW9j2CbNhwi6c5AEwUr1T0=;
        b=VHabZC6HUsFyKKh1Iy4sisow2Tiyq3B0iT1AJCXK6W7wn074dI+B2rl3Eq/CFoOcfD
         GDXzCPfcDoVkwBdFHAy5AxKxHCeFh8eYKJ4CO/PBPUJHR6epUBjyUVsLs+gsR45Y94GG
         YLs1WVpqEi0kWC+Vlr/41mvPHvVufh+DWk87nDeL9NAw6tsIWr+DxBx0EEz4UIS6WbAP
         EaqRsoknZcJbXnfNLFfGmQbtxXLWWKqVZ5GPxmjw7exobq75idJDWYvwXyffbvnTUxWh
         h8HXgnu5zT697gmJqF9P5CqAElpSX+9zPcbYUcAudWn6uVRzpmexPRW5V8AtJtUxsQRy
         VWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597904; x=1768202704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTRoF1HYVCzjIy8nYESzRWW9j2CbNhwi6c5AEwUr1T0=;
        b=gO1OmGsmEX7S4c/j7mAy0vUszaxDDqOPEUeU/sQXTabNXfGGI6E0sLrmtA9+xTLwvD
         euSrhrQIfYW8/4f7rcjY9wH4I44ZwjQD/n3uRTbGSisIDeBnoZLVxz4/N+DcjE3lPUrs
         YuWIfzA63ecazSkdJn940lMB1fTdYRzCwl2xq3XyLIZmPjtqLh7GlSaJyw46hUooEYOw
         l82MKr9YacrZE2AubBnkjG/46G5EHZjh/kUfMczTQGhhCyTXpDrDYU3BqI0yEiSL+NEI
         MT68Iw8SyCNVkms2JTjQ++XG2TiD/Ko3FAuJAr+m6KY7zecsHlUjHniMZfxeV4epteJ9
         oMXg==
X-Gm-Message-State: AOJu0Yw/ndBgZ66VzuJCgQTChXheI4Z3NU2adLTn0bbTlh4AXWUyH5zo
	f9DtZbLj2smLyOwYTOUSuRRYqy3wChCB8FXvEdMKCdM0/j+0R5NVJ9BLSrFW5NE87Vo9e254ovu
	GyoIHzldTkadGVwr5jQPkaoMfpfv8nl05wQEzg5AebixmmkY2w63ova0KPyNEbzvY+g5SPg==
X-Gm-Gg: AY/fxX639MaqRo7J1SpRf1JEQNytWpzUNq7klKsptd7Vs1kEA0TwNscT4brhFfjck1t
	206iGAKsDJGMX88wLfPvscdhibV5dx6Ao70v5oOZ2ubMd2REKboSNpLbdfbW3w8Y6ILUZh98wlc
	EzLpgjFTU8TMQ1Fw3681XuOmwNTe1Is/E3rE1AWKnrSwdANU/++ftuzEMJYpP3D1Uczj7rn2Yi3
	IVCis5CM6yPd4Wrqyr/HsRk9d5QJhzkdyAqJnwosdiS0u3+0hr6EJo7tnH0M30ld/I4b5Vk1PyI
	xTCBrM6YcB21UOmfdtD9II0IcemLmWslgfhnP4WIJKS1Odn3Q8lXGCpIhRufybVJympBgEuygnt
	Z7wqG67hyFq2iMSf+boa4nQtXIyQni/Mm+dS2nYIVzw==
X-Received: by 2002:a05:6a20:939f:b0:364:af5:d599 with SMTP id adf61e73a8af0-376a7eec539mr50983187637.14.1767597904489;
        Sun, 04 Jan 2026 23:25:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQcBCOucEQyVSIVMvbgU76o6f9h4QgiivsFLFLHMooYxe73mi/HN2nJkg41SfVwqN/zkSU8w==
X-Received: by 2002:a05:6a20:939f:b0:364:af5:d599 with SMTP id adf61e73a8af0-376a7eec539mr50983165637.14.1767597903987;
        Sun, 04 Jan 2026 23:25:03 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:03 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 0/9] wifi: cfg80211/mac80211: Add Support for EPPKE Authentication
Date: Mon,  5 Jan 2026 12:54:06 +0530
Message-Id: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfXy3LOF580VZFz
 qSlNufNq5dpLwu7aVl2ErIiR8oYV0D28gbdzsDJgqVwvixF/ucRue6yW7yDHw0767BkWHZRDbou
 RoUE+L34gq2BSKy1IRPJk9XzLFb65GgapnRBZlMsI/V5KP1cnLzDY6ptisuI2Wd0oD/lUCKNSym
 cEZ/0xCyMztMNnEVPtW73bibP4bTL+Mp5aMdHYCjWgDqwbtzApcvB1ijwD/fxRdWVLP+ySE2mOL
 HrnluXtDvgODQux88AjASOejH91pyEOaO3ZyhWkBgXHvQhxJ5wyovYCYKnHNX4yjuCht69abgwo
 6mstDyxC6WuLixsxK5uucwin7vAOGZToXv0rL0kHQY3ZX3zuyjmhOKqu1we1pgtmoXYZjNno5jb
 A24SrocYpnUiGgqAdD2/4sCeipM4NoYGDLY9keFQQX69078HXfmePe+ikF1+ajJ7nAZJqcBB6fR
 F4BG5qKGO0Hg0YRiGvg==
X-Authority-Analysis: v=2.4 cv=HLbO14tv c=1 sm=1 tr=0 ts=695b6751 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8xgW8lJkV5295r88nJMA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 9d1j987MAA4_eYWtbnD3yjKgKlWINt4w
X-Proofpoint-ORIG-GUID: 9d1j987MAA4_eYWtbnD3yjKgKlWINt4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050065

This patch series introduces support for the Enhanced Privacy
Protection Key Exchange (EPPKE) authentication protocol, as defined in
"IEEE P802.11bi/D3.0, 12.16.9". The implementation covers both AP and
non-AP STA modes, with clear separation in the commit descriptions.

The changes have been validated end-to-end using the hwsim tool.

During development and testing of EPPKE feature, we encountered an
issue in mac80211 related to incorrect AAD/Nonce computation for
management frames when MLO address translation is involved.
Depends-on: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce
computation for management frames with MLO

Without the patch, EPPKE functionality will fail for MLO connection.

---
Changes in v2:
        - Resolved reviewer feedback
        - Removed few patches, no longer required
---

Ainy Kumari (2):
  wifi: cfg80211: add support for EPPKE Authentication Protocol
  wifi: cfg80211: add feature flag for (re)association frame encryption

Kavita Kavita (6):
  wifi: cfg80211: add support for key configuration before association
  wifi: mac80211: allow key installation before association
  wifi: mac80211: Check for MLE before appending in Authentication frame
  wifi: mac80211: add support for EPPKE authentication protocol in
    non-AP STA mode
  wifi: mac80211: add support for encryption/decryption of
    (Re)Association frames
  wifi: mac80211_hwsim: Declare support for EPPKE authentication
    protocol

Sai Pratyusha Magam (1):
  wifi: nl80211: Add new NL attributes to support (Re)Association frame
    encryption

 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 ++
 include/linux/ieee80211.h                     |  1 +
 include/net/cfg80211.h                        |  5 +++
 include/net/mac80211.h                        |  5 +++
 include/uapi/linux/nl80211.h                  | 39 +++++++++++++++++
 net/mac80211/cfg.c                            | 18 +++++++-
 net/mac80211/ieee80211_i.h                    | 10 ++++-
 net/mac80211/mlme.c                           | 42 +++++++++++++++----
 net/mac80211/rx.c                             |  8 ++++
 net/mac80211/tx.c                             |  4 +-
 net/mac80211/util.c                           | 15 +++++--
 net/mac80211/wpa.c                            |  6 ++-
 net/wireless/nl80211.c                        | 28 +++++++++++--
 13 files changed, 166 insertions(+), 19 deletions(-)


base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
-- 
2.34.1


