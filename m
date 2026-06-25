Return-Path: <linux-wireless+bounces-38059-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qao6OfZzPGqqoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38059-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2916C1F39
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38059-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38059-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAEA2300BCAD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D11A9F96;
	Thu, 25 Jun 2026 00:18:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1692E757EA
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 00:18:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346736; cv=none; b=VXWznI9VwG+2QIkN9BcuqTG/A6jJL0nRV2th7WnSkoS4SBAbyS7gTfQlVtIBg2d6qHgVVM7MkWytq+WUuOFt5+myz2w6KG3NTt4ZXd4JvCZJ41tmCvcmLagq2OJ9aMdgnzntbfZACylwbBao8g4DWqka053apFPUM1r33YBiykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346736; c=relaxed/simple;
	bh=SEk72dIGPqJAK88aY20EMblCzHWB5xz7KVQtwVvby7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7R3diAzX0BB+p2QCK2R7Qte0N4AD7OR7D5gW/zHd+bW6ijSfxv+gR8vj8Z5hFwgnb10QVJvCwTSVrncxpb+LMcr+tBVwDxKbTKww4ph6Q4rjp9D42N4Jf+Xkcv4XONLqkt3jt/KKSVSyoo0Y045CMuJu1DgPsWfErBxD7F2VDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37de8008910so720236a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 17:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346734; x=1782951534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlR8b0vC5oVW3TqsUHgYLtphTYj6J1CxyewvuGXJDbc=;
        b=ZZDqwQbzhYQtFXUFGU+m2wlUjv9EsIOy7k3j444kSEqV8R4zG9Py3NjOq4YGYhyg77
         tvP/oqJ6bTzCx9v9y9F1ckGmkC14rrC8TWoFrOhfKbEaDytLf5YonpawhJC6I6Ahmai7
         8F9QNSObEMATiw6uIzYCjti1dNNB653LZX8XLrv2dJftotR1CAz+haHN3ibrHvQlsRCM
         0uAgaWNsJ5xvS3NVF460LixCF2tdYBxl9IOEpRZJf4t9qbcrUK0O6jqGNVPD/WgySrvr
         tiEG2IRJd8jtr3nUdU8gIke0Tc67rAq6HWAovKdossi1c5ykRmzI1HGNcIR2TK9S0wlr
         YUoQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0Xo7iaQ06wMNrnb1hnh1/eUmbx+bvpV/K8Sf6KZjPXpnP1F0S/KTql2SAMsNxlmYQ+xN798XvIQXVvcBcuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysveQPuhOvbXbE0LeOS2lNjtTjJUmQ+xLwoVU47CS43eQvXgFP
	iyAwYUbzY6zmf4OK1RzMjoTZoAR+jGCyYODqH/hXULMTCHEFQqvKyhff
X-Gm-Gg: AfdE7ckinTmJnFqTlWzN5t+k+FJ6ecbaK4VS2/CnxVd9azyuizi5BVGVd3A1PBy4EiE
	OoVpvxKP0KvKXDMoK7P+osE9HNzBwbOOxvd2JOWvSZ0YYJlpkJIGTa0lUbLA2oS3lgCgrJdU5BP
	NQB34vuQTXtA1glf8Zi7gRObpg4dORx7jVOCUO2Hk/kXgGRUaBO2vRJ9gMTTd7eddg8rrDhe66T
	13ZwAfYBzbGcJ7+/U8Uzk3JFCQxSCoFqA2tWeqRNX5jc9Xg77kaDN9lqpPvOdV51tOmMET11gWq
	EL/dPRQv69mcniFaEn+k0/88AIonskmJ+wrjkp22wE90JMeTQQanFLY0ARhw+VO4RnAP6Q+SN9P
	qYIvFTFsEBDf41/5YIPLH84AU7x+a+9ft4Jff1SuHmfy8kfHEceF7sjFwRoo3IxTdQMHWYMNp/i
	onjMRBF5Q0pV/Tw9OQqkdwfi/u/CfOxentqNqkQzL65Sa4vpgBMKGsAJdXEVgME0UJDRl0D4LHL
	BxR5rKM+CLIg76h4G4Rg+0La3+0ng==
X-Received: by 2002:a17:90b:534f:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-37df9d41bb8mr159654a91.0.1782346734311;
        Wed, 24 Jun 2026 17:18:54 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm586839a12.21.2026.06.24.17.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:18:53 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chengwei.yu@mediatek.com,
	yu-ching.liu@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH v2 0/9] wifi: mt76: add mt7925 NAN support
Date: Wed, 24 Jun 2026 19:18:25 -0500
Message-ID: <20260625001834.475094-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38059-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:chengwei.yu@mediatek.com,m:yu-ching.liu@mediatek.com,m:jenhao.yang@mediatek.com,m:posh.sun@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF2916C1F39

Add NAN support for mt7925.  The series first advertises userspace
management-frame registration and hardens BSS capability lookups used by
partially configured BSS state.

The rest of the series adds the connac NAN connection type, mt7925 NAN 
MCU helpers and event handling, a generic init_wiphy callback, mac80211
NAN operations, firmware-gated interface combinations and NAN data
advertisement.

Changes since v1
  - Rebased and reworked the 7-patch v1 series into 9 focused patches.
  - v1 patch 2 and 3 are folded into one BSS capability guard patch.
  - v1 patch 7 is split into a framework-only interface combination
    patch and a final NAN/NAN_DATA advertisement patch.
  - v1 patch 5 is split into NAN MCU helpers and mt7925 MCU response,
    event and NAN-specific BSS/STA TLV handling.
  - v1 patch 6 is split so NAN PHY capability setup uses a generic
    init_wiphy callback before mac80211 NAN ops are wired.
  - Order init_wiphy before the mt7925 NAN ops patch so each patch
    builds independently.
  - Define MT792x_FW_CAP_NAN in the patch that first uses it. 
  - Move common NAN MCU command/event IDs to the connac patch and handle
    NAN_DATA as a NAN connection type.
  - Add NAN_DATA interface support, 2.4/5 GHz NAN bands and secure NAN 
    advertisement.
  - Add NMI address programming, DW notifications, local availability
    updates, peer schedule updates and NDI STA mapping.
  - Add cleanup and rollback for NAN peer indexes, NDP contexts and MCU 
    failures.
  - Drop temporary NAN channel debug logging and fix checkpatch issues.

Sean Wang (9):
  wifi: mt76: mt792x: advertise mgmt frame registration
  wifi: mt76: mt7925: guard BSS capability lookups
  wifi: mt76: connac: add NAN connection type
  wifi: mt76: mt7925: add NAN MCU helpers
  wifi: mt76: mt7925: add NAN MCU handling
  wifi: mt76: add init_wiphy callback
  wifi: mt76: mt7925: wire up NAN operations
  wifi: mt76: mt792x: build iface combinations dynamically
  wifi: mt76: mt792x: advertise NAN data support

 drivers/net/wireless/mediatek/mt76/mac80211.c |    7 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |    3 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   14 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |    4 +
 .../wireless/mediatek/mt76/mt7925/Makefile    |    2 +-
 .../net/wireless/mediatek/mt76/mt7925/init.c  |   29 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  201 ++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  125 +-
 .../net/wireless/mediatek/mt76/mt7925/nan.c   | 1091 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/nan.h   |  440 +++++++
 .../net/wireless/mediatek/mt76/mt7925/regd.c  |   30 +
 .../net/wireless/mediatek/mt76/mt7925/regd.h  |    3 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   43 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  125 +-
 14 files changed, 2077 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/nan.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/nan.h

-- 
2.43.0


