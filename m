Return-Path: <linux-wireless+bounces-38526-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cg5NBuBoRmo7TgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38526-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 15:34:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F206F865B
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 15:34:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EI4t39Oh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38526-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38526-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA2D73004601
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6C4A2E12;
	Thu,  2 Jul 2026 13:24:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280E4A2E1A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 13:24:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998644; cv=none; b=izqnxdNnYjz6Zoa1d5RvWnJnnrxWWDnmC3TLNy5pm2i6QXdA0bxVSf6z2J4SR2QcXzjJlGKHMwR2k07oOPxwdT1QORhHmv1KoyzByV0wHns9q18Pu2sjlg6ydjusGyp3PN54I3YqNrjjmSL+2piSHRoEDlwg/cWABzB02D6vUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998644; c=relaxed/simple;
	bh=6OLzllzFExpGwGDLlgVxn9YLJ4LtANbQ2GS7WJEbA2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F424pxWKvY5eVqWcUzXEGYWcdWEUyO+JK6D/Z5DTumvTIXwDEnjjTyGiZJ99i6mQGhP1wHkDXl776bdeAB0302m83tc9UdJBGiORnpMy5TIQy9ACoZJ70xnH3HGHN9hu535z+mj8/w6SkJYPxxPkutPrjDRYGj+uZkdx4eV4Big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI4t39Oh; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9abe1c505so12549265ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782998641; x=1783603441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bW6TEhTcOed39E7NunySAiOrkDGx2+KTs52503jzKEA=;
        b=EI4t39OhRBhucqUicUNCeBHaeyBS3ql1lFEmbPXNSr/YR43Mi53ubhQaPGZfmfYi12
         mRFRAHz9hDTwOyMgUDapSKswUFh4SpTVk+JEjALfxPMIOYXW2qPty5nETwIa3cKuon1r
         YVhKfIsuiPtgSc0BZSWOknJossRPZyL7lGCkvA/tKQvBvXNTwY9eMssxsr6PynNrth3o
         D1M5TkAIrhS4JZWdp1AJRdV2nFek9r78Vu71zWJOc4xgfDJdrdFyOzsCDnUqFc6mvuCq
         +viiY1/u8HX2CtyMfDmW28jeKXP3GX7PYsNU9VPaosOCnAE4m8jxJNsyelVJXU6uYyRL
         l/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782998641; x=1783603441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW6TEhTcOed39E7NunySAiOrkDGx2+KTs52503jzKEA=;
        b=GaknEF2jVDhM+/0ZBrzlhVtUmYkhYKqeelBl5Pw/puiO6m5fZQzZXNN0x2j8RdkHhC
         PwLmVO7i643O6UIBpzXqtve8vbnZ7ueu1qol3uMMGl1HpBsWVpF/Lq4w2Vhg6M8RQqcZ
         HcEIzOtr4WxB4xy4Rc+NM25XAKDx0tXtr/I9oX4P0cewK6SHV7zDVZ8ozIQrRp597jmY
         S0JVjUYjlJYLtYmowFcmugCKbLz1QEUG15oQ5Qy7d4/h6G2y3yVb+DKjXJJBOQfJdIHJ
         JTq6KitDvbeBr2hvYyufo+EGRVqUsqoBb+pnbrD2VGhJLPyGNqidhjD1yIijE883xnKx
         iYdg==
X-Gm-Message-State: AOJu0YwBN9QNIC4dKlMryZhBUpSZNPvaSiicjq3jI76Kq6PT0yRjq29e
	s1f7q8VL6WKqY+X2Zr5aqEZUFiECHK3VDEbEccnEIbSqwJBWVvPvCZpB
X-Gm-Gg: AfdE7cmPlKNRq1DgqcCTQi+aStNnP04irMI49q8avOXT1UHocnAKTkPLvkDN0WRN/42
	Igbf5JAm6hLnvJl20sBVsCEZ3uDPS/jK/ik6bIvjlXGz4KqDNQ6+oh641JbHq7/PDaBGdCmzgDJ
	AVAZ6DxayLTlNZi2n9ZoORl6euzmni1lVoIyu1b4IfW6MIh0CWUW2n7DG7Xi+e8qblHl9zLhuPd
	cGb/CTADxfYtV+VGPN6J2x4IoEaHe6HzcDGBxLdbGBW1MdRmQ5KoOzybmylfSvV4tptV9Yozo4f
	A+12+3k9wQSgTzYuq/Pp0jlAQ+bVPIF3szVDFBQrFpg9WOgjnjdSyuCoeLUBJ53TFUY6DLTalJL
	CHX31g49WJNrNsY+Nq87tV00OUvkdpOt/pVYVhdBBt7sA/jTATXgtNMHYsxry68lR7yZ7KwgfDZ
	kk13vnTXw0OlOYg9LtSmCm3LxTj+Akv/J+2u3KHHcWO5I+nzkxA3fPsPCy1OZpRLc=
X-Received: by 2002:a17:903:984:b0:2c9:97a9:2095 with SMTP id d9443c01a7336-2ca91229282mr51052305ad.41.1782998641154;
        Thu, 02 Jul 2026 06:24:01 -0700 (PDT)
Received: from frank0988server (36-236-219-120.dynamic-ip.hinet.net. [36.236.219.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9cd487sm13574905ad.43.2026.07.02.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 06:24:00 -0700 (PDT)
From: Chun-Cheng Chang <frank0988855428@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Cheng Chang <frank0988855428@gmail.com>
Subject: [PATCH] wifi: ath9k: use max() for pulse duration selection
Date: Thu,  2 Jul 2026 13:23:39 +0000
Message-ID: <20260702132339.415072-1-frank0988855428@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38526-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[frank0988855428@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:frank0988855428@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank0988855428@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09F206F865B

Use max() to select the larger primary or extension channel pulse
duration in ath9k_postprocess_radar_event().

This matches the RSSI selection just below and improves readability
without changing behavior.

Signed-off-by: Chun-Cheng Chang <frank0988855428@gmail.com>
---
 drivers/net/wireless/ath/ath9k/dfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 2fb73a5e1d51..370346450675 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -239,10 +239,7 @@ ath9k_postprocess_radar_event(struct ath_softc *sc,
 		 * Radiated testing, when pulse is on DC, different pri and
 		 * ext durations are reported, so take the larger of the two
 		 */
-		if (ard->pulse_length_ext >= ard->pulse_length_pri)
-			dur = ard->pulse_length_ext;
-		else
-			dur = ard->pulse_length_pri;
+		dur = max(ard->pulse_length_ext, ard->pulse_length_pri);
 		DFS_STAT_INC(sc, dc_phy_errors);
 
 		/* when both are present use stronger one */
-- 
2.53.0


