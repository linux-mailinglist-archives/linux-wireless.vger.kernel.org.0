Return-Path: <linux-wireless+bounces-36556-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD+MLY0/CmqbyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36556-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 00:22:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C3564291
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 00:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 741CA3006B0D
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C83D4114;
	Sun, 17 May 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hahzvdQm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7C3D47C4
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779056520; cv=none; b=b0UUym4qR/eOoFDSWWg4illz5BpeDyTYuc6JINGXvVwSjOpkPtuKhDXgR+6Kfm5Gg7Z6dIrTOORIRECPbtOCDPCtMO+L8/AWWHBLGf0kuS/7EZf9RFiTqvbBCXQzXlwIroKsaIi1dNhTmuz8soyRWuzT4pMugPFKqGEXgIsnhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779056520; c=relaxed/simple;
	bh=K0SSn60mCQl56nz9f9e2zbyY44JFauDepI04YuVqcic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fU7lSU/gzYkruc0QqugmsBnjdss3C3VGx+dBno3RXS0FvgvJleTsCGUsjMVA9WCPrgBRsHQ6ZJUNp/cdDmxD4vxE/oLBVbuqFRuufkKWhDeiJGm2CFhFWGrS6rf7KzBQuv+lyxSvVtHk8xL2m7sfBfA6i65uCtNtcozybdtn+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hahzvdQm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso666338b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779056516; x=1779661316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=za5+H7IhaEyLgXUVDAOZc+B91qrQGFaHEmPiC7q8H9E=;
        b=hahzvdQmKWjswZ7kD/6xBrTq0dn3p8xdfICAYiZpgnZ89frgSgDH/FlOLIGwWr7mWX
         EAsnrEcPJLGAZOrujqOXHolmsBGQP293w/Y5ht4ffgMgv1XzP3mPPg/XIla91Rp579lz
         GhBOlMRNm/ggLQpu7gLHyZw2cZI6lLCPrE70nVJCPiZWwcVuS6db60DvRqg1WJZfcPhX
         3aIaItgTz+97jrDzlcfiAHbRMAnjGQzhrMEw3dDLAaBv+Pos4G9pQHjkwscHvgsY/2m1
         EB3o6+ZDD2hlMFhkyImNCmKr3OWTe3/Gg06jEg+Fs2kVxjVdzIuMRIUgom/n/eFdO8k8
         Pu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779056516; x=1779661316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za5+H7IhaEyLgXUVDAOZc+B91qrQGFaHEmPiC7q8H9E=;
        b=DqY331lnkTKGpoJDy9CEpMFuJzcQhCF7fgl3qv4Uolz73vk6ibxgGJCU0ng2JgldYE
         Icw7Dsy8YBEqh84JS9z9eUmmLQDZFcsO+QYNdUURMZp0TH/kk1RIuPenbBGIucvZY3ZI
         LgqQujFsCMamATWokChCqAKg8m247A0lGwlEe5Q2c/dDpFzcXC4vNqyh8NuSn69lF31W
         KSPO3BgbecAP0/ZvwwG5shrKqLuOqHs5KEMZDcrqtdK7nQ/ZodHZd28me37V7yx0//fy
         49srUC+Ow0P5vQfbo1iLda5r1ySn34hS15GMTrOoWMFzIHsyyz0/C8F8lAfscIhnqh2N
         Yigg==
X-Gm-Message-State: AOJu0YwSX8T5gQ9KcpT9CLA88AaOxPd0IviBUeDfWwowt1nk3LArMvgw
	bUhivzivBSFLwJLVWmY/G4icVdE3ApZ6gbAfgTD/J9sZKh2yfHASDlb+uH/lGA==
X-Gm-Gg: Acq92OH4VYARXif4yUih3eICOgLaSnXB7RE3jtJyG7txvTvklfP2qq19jcSz1s+Zdax
	LZNiknPXLpWDzu/BldmHa9d9LXoZXpFauVkg3WpomcwlmYyszvlXg425eUuxtjfxF7zmGw8uYJt
	kqHSWBBVQPkGFwrjImalZ5+bG/I1JkbVMRLQG/kSFcmC0PAP2tiWODJrXX6O+q7yGmntUBm8omi
	MBCwDi2bYp+k1mOMVyQLldOtMd3C5qt8aXUv8tAom8msQ0pHkjORkmCLnMXTN1b8QPrHJh01s4E
	SDZdYFFG0ISqWmd7KjcqsRtBe/RjGr1vNUzgKDIm9wM5j5PeGqBNVSOQE4pHDuc/1Wxi/5y0QPI
	YQwA3ZdCXMnmermM8hufkNBMkCYaKUT1dcpSeUGDBC/Nz6CRFZ+O1yW8BJBPcqJ0ityVk1OEfY7
	VaJunGz9+xkbk2rpwaWrIBA+kAwjMfmyCyYvVxu36JxMh1qT0LTKBFYM8i0n5P+fs1Ec9sKwdbU
	5nKAjSjQDA6Pou7P0uSj7FnYiZJwdJZ1og=
X-Received: by 2002:a05:6a00:398d:b0:83e:d957:e5b6 with SMTP id d2e1a72fcca58-83f33de50e3mr11389471b3a.36.1779056515912;
        Sun, 17 May 2026 15:21:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664212sm14366243b3a.2.2026.05.17.15.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 15:21:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: remove TX99 power array zero init
Date: Sun, 17 May 2026 15:21:36 -0700
Message-ID: <20260517222136.1660347-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 234C3564291
X-Rspamd-Server: lfdr
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36556-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This array is fully initialized in the loop itself. No need to zero
initialize and then overwrite.

Remove static from the array. This was a holdover from when the array
was a static global variable. It no longer confers any benefit.

Also add a min() call to avoid the manual if/ternary operation.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9003_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index 6274d1624261..5d0433f2ae37 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -1811,10 +1811,10 @@ static void ar9003_hw_tx99_stop(struct ath_hw *ah)
 
 static void ar9003_hw_tx99_set_txpower(struct ath_hw *ah, u8 txpower)
 {
-	static u8 p_pwr_array[ar9300RateSize] = { 0 };
+	u8 p_pwr_array[ar9300RateSize];
 	unsigned int i;
 
-	txpower = txpower <= MAX_RATE_POWER ? txpower : MAX_RATE_POWER;
+	txpower = min(txpower, MAX_RATE_POWER);
 	for (i = 0; i < ar9300RateSize; i++)
 		p_pwr_array[i] = txpower;
 
-- 
2.54.0


