Return-Path: <linux-wireless+bounces-37828-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1O/VA0O+MGqxWwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37828-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 05:08:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50B68B9F0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 05:08:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eOLmhALu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37828-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37828-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84D3E301AAB7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 03:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B913237BE75;
	Tue, 16 Jun 2026 03:08:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CB2F1FEA
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 03:08:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579327; cv=none; b=RmKmR8sZKGbagGxu299JYcuLPQgq43OuMM9+oBXHB48E3a7+g3iVJaBoha8JHd8lsXPf/Vv5LHJtNDlFRRNV2MngCM0dP/gtu7Lg6s6DfJaURbNzwny2avddR/FfLweEapcgH/djijqYTdG1PfiDlfCkefk8rUPFGlJQ42/1oUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579327; c=relaxed/simple;
	bh=HCQ6qtKhF9EMVm1CRWI7J25L2G3MnCmQf+c04h6eW/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVsY1BFJMVX/JrmLCJtk1Q5dZwryp4oET6ssQ2laTZ7TYQ2RhAffu4Y5SHAnjeVttE27qbSFUk6vBh3Us+qMu2EX7cEDlp6vA35JvSWBvTEiCZrDa4+WTCup4liBeaauMmjFpmAFK1XrFuO+OnY7xeLvsuYohyO3lRiEkhs+AZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOLmhALu; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so3366850a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781579326; x=1782184126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlE0MRVFcLUCpfu4xttIQYVS/IifqiP8sdgnIGomkDo=;
        b=eOLmhALuT5T0iquZmdnbNG/6IXhDz2ji+GnrfhxYYXEtZmmSiOuGS/Knf97VPN9s1s
         BXxighdfg/Z0BDsYZSQgk5BmZNuUVSDdX+ORDarkq1eSh9WHF96mCXICz74ybnun+3I3
         IrHfNEwCmiwCoVCU67f6bzZenovb1lHzrnmNOoDSP0Lba0z4mMPJ5jTc74X2vG4WIHx2
         g4PjOwnmvkb5CM2SWdqtwPLuKcaC1DWMxGVE5IkxQoSCnvpSys+iRW1rN+x3jxjQFSXL
         42+pD62V8Cz/9tWH4jQC/zatrFdN57lhfyxNfNBMafpuSVYZFv5AYdD4PVOne0LV+o+a
         c/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781579326; x=1782184126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlE0MRVFcLUCpfu4xttIQYVS/IifqiP8sdgnIGomkDo=;
        b=rXjsmoiJ6x3BByjR0k9qzq7dfXGY+X8Q1ubOTbDEwJuyHKQ89936dHGkhg243zVc4a
         aDS3pmsVqCdjL4L+6tfQKOfRYvde3hFBLDHDmHe3uXRnwy09ugnM5mb0vQYrtlboBkme
         smHYksqmzxIHCX6TWJ/ccMyDTgxJJk2PLEcb4IZ7dfncoz1KQYJzSZAOgomd/Ox41KFE
         /ZDygGtc4kLSY1cdU9NguHDaXqgIzXs+7M6ZGejeYJ4feWWAi0nMFkcV5EU+Gb4O8Byu
         xBZAPXrmO1FzrJ1iPpc3A9T6ycf+4n4ps6rBkOCvdZdVApaSRyKp1ZrA2ueDcU3OQTwe
         q1tw==
X-Gm-Message-State: AOJu0YwNS2rg2CWGLMAkVkL8BvU1CytZcHBlr3oFSxWHEoH9bzpo1/o7
	6NsuECXIjGvnxaWoi+KR56BFQLL1CWeQT9uMJ3f+0eI815EtwQ5AXCEezyYkrA==
X-Gm-Gg: Acq92OHbgQX6khWmoYHKHvtpDtK7t2gcUseF4GTXJpFornGOIdHOe3tcDmqOVE3ygGc
	bBEpbX84qX81gI5U2P25MnQIc8OnHfgs9SCsxxUBKzyygtNJlvubhHvxnhypmEtN3jIBcGPM0qF
	GGFIZ3ebq0gXnWhyTuA9P984M2jo7XWd2EYg5DSVPLDA/e5OA5AtfKBVPnO5rLQZYrkNGis+Ek8
	Vd406p/VwKjUNo2hp/t8sW22qs6KDxU9se92qE7ZbxSZl5t0puNzzQZ7T9HlHU/z+peTUJZfUPl
	vGCiVZls4DJ7GgZU337F4DKeWShB928k+hJ1hGBfHz+wh0pjfkX5+DEa96I2gSTEM3cMOU7qwgp
	3iy+5NAoRue8oCTCktaFCTepBoJf0jt2iYJaHF38Ek2d7bZiIuCgPdSmA1zESMshfXCWpbl7GKy
	N9zhboq+GW8U72TlSLVDRFleLmvftq6H+i6sWWD6KazTK8rRdF+Hv6CXVXiZQ4DHe7z7Kwmm9ng
	+K22DhYNCIGLgnK5OOVuBEA2TRfL8oI4D0=
X-Received: by 2002:a17:90b:3c03:b0:36d:b12f:613c with SMTP id 98e67ed59e1d1-37a0202ecdbmr18758831a91.10.1781579325886;
        Mon, 15 Jun 2026 20:08:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:33c4:7c66:bf93:6ee2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae039sm1054607a91.1.2026.06.15.20.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 20:08:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: drop static from local pdadc and vpdTable arrays
Date: Mon, 15 Jun 2026 20:08:28 -0700
Message-ID: <20260616030828.655310-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37828-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B50B68B9F0

Remove the static qualifier from mutable local arrays in three EEPROM
power-calibration functions.  These arrays are written to during normal
operation, so static storage is both unnecessary and misleading: it
implies sharing across calls when no such sharing is intended, and it
makes the code subtly non-reentrant.  The sibling function in
eeprom_9287.c already uses an automatic (stack-local) pdadcValues,
confirming this is the correct pattern.

This keeps ~1 KB of data off the static data section at the cost of
stack usage, consistent with the rest of the driver's coding style.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/eeprom.c     | 6 +++---
 drivers/net/wireless/ath/ath9k/eeprom_4k.c  | 2 +-
 drivers/net/wireless/ath/ath9k/eeprom_def.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index df58dc02e104..fe5eb0d68b2e 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -460,11 +460,11 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 	int i, j, k;
 	int16_t ss;
 	u16 idxL = 0, idxR = 0, numPiers;
-	static u8 vpdTableL[AR5416_NUM_PD_GAINS]
+	u8 vpdTableL[AR5416_NUM_PD_GAINS]
 		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
-	static u8 vpdTableR[AR5416_NUM_PD_GAINS]
+	u8 vpdTableR[AR5416_NUM_PD_GAINS]
 		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
-	static u8 vpdTableI[AR5416_NUM_PD_GAINS]
+	u8 vpdTableI[AR5416_NUM_PD_GAINS]
 		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];

 	u8 *pVpdL, *pVpdR, *pPwrL, *pPwrR;
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_4k.c b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
index 3e16cfe059f3..eec7efdc21c3 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_4k.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
@@ -288,7 +288,7 @@ static void ath9k_hw_set_4k_power_cal_table(struct ath_hw *ah,
 	struct cal_data_per_freq_4k *pRawDataset;
 	u8 *pCalBChans = NULL;
 	u16 pdGainOverlap_t2;
-	static u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
+	u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
 	u16 gainBoundaries[AR5416_PD_GAINS_IN_MASK];
 	u16 numPiers, i, j;
 	u16 numXpdGain, xpdMask;
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_def.c b/drivers/net/wireless/ath/ath9k/eeprom_def.c
index 5ba467cb7425..a1b10c826fe5 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_def.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_def.c
@@ -769,7 +769,7 @@ static void ath9k_hw_set_def_power_cal_table(struct ath_hw *ah,
 	struct cal_data_per_freq *pRawDataset;
 	u8 *pCalBChans = NULL;
 	u16 pdGainOverlap_t2;
-	static u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
+	u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
 	u16 gainBoundaries[AR5416_PD_GAINS_IN_MASK];
 	u16 numPiers, i, j;
 	int16_t diff = 0;
--
2.54.0


