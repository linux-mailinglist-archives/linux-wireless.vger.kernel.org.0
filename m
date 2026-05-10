Return-Path: <linux-wireless+bounces-36161-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPN9FunpAGqMOQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36161-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:26:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C99506384
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89E1C30055EB
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E06331A66;
	Sun, 10 May 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4c8saF+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC83264F2
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444690; cv=none; b=d317zd6eG2U6RGhiOa8OfHDtw7PZPNO3oCJ7kU23Hvl9C5YFwH0BRv6Bf+Qvh5l7ZmFcOESmZajF5+WyeBPJ2Ya4A4ZHQ7k4QRLfmw3hOXWaWQrUqA/+hWI6lbU221cD1SXlBWkhoH6akd3FFRScxo45takb+61KVL5/5ELAPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444690; c=relaxed/simple;
	bh=7LxAgAe9FAQ/KXXxhJ/6cfjklYMy3iMv32YBM66xjRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3rD14QcQaz721as/Q3M2beKjQdrbfu8jmexWZwaEcs6O/Jos4Rb5J5P2VFjGQfNz8JYS+wuiNcT4ydtoha6YrMipaFWauC8c3UAT+NoPMEYhVdETeG0ejVHuBky0wd0ePsPauaqs1xrHqc5hM1VW+k9TI2VW17u2qxXlTOd32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4c8saF+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-836ebdeb969so1596548b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778444688; x=1779049488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cs7RR8UfZiloMc+0grbX4/5pEgc7tdI4TgsBvtMnf1s=;
        b=U4c8saF+uJIMKpb+HBj3t0WwSgb/2V+uHb0znP9U5RyIHyL3eOgz4335L9KuGj1OrS
         h+DYgGD14jQMpsPOklnzXwgFCsBfLjU5cMx4YwzbHnDOgbMIb+s1SJ1vILSqEH2HUVN+
         WJKzDEIo5BGbGRk4Q7C0gB3BsCjTMZJ7L9o+hh2H1/Cto6XSwv2+gbutifEw9ZdRIUdB
         7wFqUXmBpXUopMf9zbnTqvM3lqZywgPkr/q1Wyc95YwaKYfY/LGTQ4VuOHNqaW4wBaFx
         1gzO2RDJOvgPeMXLHFvjeY5TatdHaArs5F4PoEpu2f16xzSLeUbrbo+iitGjbNXPNdj4
         n3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778444688; x=1779049488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs7RR8UfZiloMc+0grbX4/5pEgc7tdI4TgsBvtMnf1s=;
        b=RG0hS+LDYEIRI9Jrmso/FhzWM3633xbg1P35qCUu3QgsDcqjmuu4x6gcBg+zQfo3T/
         GXRPsqyn0Qlux/+WqjQO18BjjuKmF6udgak5zkWzu9u/jvuR3+KO85871BKZKCkN2xKY
         44Rny8QyIcSnJLrdpdDk62IIhbZrnrIcuqB3RdP98uc0k+tfM+r4s+fjd0h1JFR2gmE+
         Qo4gjp1Hx/3/yuxBqZHwHsA8E8jTJVZ9kZ/mt51t2/kf5EtirEQAh7/N+f9FTSh6s2eb
         sXJ99VEVBgTdY2Cnc+lbrytVqAYfGfcKTxLva9DxOWT08z0/PApVC2rYL8k6P5FKp7bc
         Ru/w==
X-Gm-Message-State: AOJu0YyoSEgTx7BalgFh75dMhkA3ndLWXHoq32R764pkoJF671VHWxKG
	TNcnYXakDY/uBEs6zeOrtwEtHVNr5Yb2vRTj8Vd1QX+szKINcq7bdlRDIEA06PMLliuH6ygS
X-Gm-Gg: Acq92OFyFUUPa3vV7BVCM3k0/NvDZqrK3HqriNorhfnj+7QRoNQhSVg9o1wLZYmuWn9
	tXVr1L5mZlDXFNXBkvaS60FDntTVly41pHa87wuZ5KWdaROQ44vQwW+GXDRJNeyKZTk1h+Rv7ZA
	Ug8IeaUPG3SGRBEobVGU82Ln/j4BvmeNKF14SnRZiyUljCdAODDXd9JW4zwMc37CzwFgld0rmcz
	J4axv3aIi3Yi3FaxqSlODpglT2RDdNt8rSk7IGY8AL22wAyArP7mjUB7+gsaqbPvWe6OGT1Va1m
	9aAU88yKU06P8+k4PXLhqlVBLOPrYqpWOZ22lDyyMqt3U5TvkH3G8uQpPk7kYWWoIHquQQm1oBx
	FYi3EqDiztK8dnboVE7Hqaz/ooGi6TQGNNTx0CrT4hQeK19cKmBoVTy0cQGaAm2gbvOF99r7qI6
	MmyHg+GI3HtUnJXJrr1qPugWNGLFri27Wt8GdwK2m7Fvl2g/bbOk/YVH+/noS+J/keP1U=
X-Received: by 2002:a05:6a00:3e21:b0:838:af72:fb2a with SMTP id d2e1a72fcca58-83a5b0db426mr20339848b3a.4.1778444688053;
        Sun, 10 May 2026 13:24:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f2:38:d6b4:286e:7088:fd10:80a0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm19908156b3a.50.2026.05.10.13.24.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 May 2026 13:24:47 -0700 (PDT)
From: Kartik Nair <contact.kartikn@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kartik Nair <contact.kartikn@gmail.com>,
	syzbot+02a1a03b8622d3c7d1c9@syzkaller.appspotmail.com
Subject: [PATCH] wifi: cfg80211: validate chandef before calling cfg80211_set_monitor_channel
Date: Mon, 11 May 2026 01:54:37 +0530
Message-ID: <20260510202437.7857-1-contact.kartikn@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52C99506384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36161-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contactkartikn@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless,02a1a03b8622d3c7d1c9];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

cfg80211_wext_siwfreq() constructs a channel definition for monitor
mode but passes it to cfg80211_set_monitor_channel() without first
validating it with cfg80211_chandef_valid(). This causes a WARN_ON
in cfg80211_chandef_dfs_required() when it receives an invalid chandef.

Add the missing cfg80211_chandef_valid() check before calling
cfg80211_set_monitor_channel() to return -EINVAL early on invalid
channel definitions, consistent with how other callers handle this.

Reported-by: syzbot+02a1a03b8622d3c7d1c9@syzkaller.appspotmail.com
Signed-off-by: Kartik Nair <contact.kartikn@gmail.com>
---
 net/wireless/wext-compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 22d9d9bae..63d145b52 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -789,6 +789,8 @@ static int cfg80211_wext_siwfreq(struct net_device *dev,
 		chandef.chan = ieee80211_get_channel(&rdev->wiphy, freq);
 		if (!chandef.chan)
 			return -EINVAL;
+		if (!cfg80211_chandef_valid(&chandef))
+			return -EINVAL;
 		return cfg80211_set_monitor_channel(rdev, dev, &chandef);
 	case NL80211_IFTYPE_MESH_POINT:
 		freq = cfg80211_wext_freq(wextfreq);
-- 
2.50.0


