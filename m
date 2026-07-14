Return-Path: <linux-wireless+bounces-39021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRmOIdQOVmqDygAAu9opvQ
	(envelope-from <linux-wireless+bounces-39021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:26:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6276753603
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fIg0Efnp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39021-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39021-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7529A3038A63
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3EE36D51B;
	Tue, 14 Jul 2026 10:26:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1836F411
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 10:26:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024782; cv=none; b=Gl6l2h/17OvLfzByQb5hO0JnsFs/LUainQJkFSorXZQa0oVqDngBuy+huAipneIWFlwF8pJ9im60KKLS4P4lVPB85GmtLGK5meYCX8J7hxJ8qWuk20Ap90pjCXiICrkZkVoEz1Fhv0gNNeaOlxIaFPClpy7QIHT658qVFPa0oK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024782; c=relaxed/simple;
	bh=7kCG6wbCKXLsahDdJnrOKLAF9jhTwNhCixXjjgWTe0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rADpgc2cy6fEA/5rB/8ow7ZL+Tr66wvt119jKqx0Q3iYltsitIGUn8O9NtND1upcBX/omKEMWcX+TykrNEdzFTyYBFslEXOugCdmxYnSKdJSyXoD4f5m/+OCe+8x2N+BBzP6i7XKxFOJ0WDPaYn64fBTi6Xk59F3aOcwGiJHEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIg0Efnp; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so431018f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024779; x=1784629579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VMn+zsgq4KlhgLUxgzGJqjMCuofU/l6ZDLRETL0UxKw=;
        b=fIg0EfnpsupYntHtpHXFzjie8bZQn+W26tXfBuXvKpyUdc6L2d3cuW1NVQMAhEKBcC
         FaS71hKl3FbsK0OI4Ilx6KJpGE9SgKFXt44FPyz+ma8jyxGb39mkg5wbK35wIgpSUIOa
         cRwmFoy7BklJbakUWnFTQh02mox8270DRoMzZp0WlK8r+6JPVzRxwwD20RJCP77FcHSY
         jbYMmoHyWkhF7AhSVHBkyHdYqAkmNz3u+qirBBbadnA8/GHBJLBMJzaEXEv/3AWDxaXB
         pEEinTR6qHR9H0076KEMGBGiru96JHpJOWBbFeob/JyLduKaJOZveppbNbttOO93hmzy
         lGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024779; x=1784629579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VMn+zsgq4KlhgLUxgzGJqjMCuofU/l6ZDLRETL0UxKw=;
        b=aCwWXKq+tZcAtJ8eeoIwOUImY0YgHTPfKTPdxVEeAYNa31ro5Xum212Wk/ANoVHcv1
         SEghVwrkXupoZltd9tVN1tOsnjNK4IOPQG6Ukzy7l7DI6nAonIbZfTR7jHEZey5imdFG
         /jbNaJiPJtyWPxeCJsOpj8TW5jb/yKuminrlTc/EK/ygQk5rAD0WyHs6vWbgq13izOEY
         s9LDnYWTtORifRWsKiPNas7Df45gKYo+JkU7/JoPBhS2BCd7T9KGJEMcRmNUNH8wMygt
         FAnTq98tCiXDWyc3po32rjSTTYLKRpR7IqBUlgvWHzXLyDZytwUBSLVfqtqppcAlA4xD
         0hvw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+UWgyiw/VbS+2vzssGOZ5ktQtgtMjrUV5BtjT8mUBMcKR5DHzyRnYU8ggzDY2oRnk8z9kHKr89ieQtWGNWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoO3MEHeNkfKM8A7HWd2/YxBYnZg3CUG3AQl/X5MpysmDQomo
	N8gY/yCwh3UA005tWod8PHEIa+8hPgn62Q/nUbmuMbsC58hWKGFAM4Hk
X-Gm-Gg: AfdE7cljYcl5/wrEpujAjeRgnIbSH5UhcWZMXRyK5U7QSvF4qb8CHiIsV5khI3fbdG5
	aN1Ttw2rNSJmE/6hyS27Hi/lHd628luZUAyljqo7Pa2R5YsVM4Y668ES2wAmsJeR2PM0NhKIeGK
	eZyLMdIpsnHOuEB1d/p6axnSyhVhuyj6baR72XIHeX7Z378hNuJ/a0TxGadcgs6Bwj49RH7FBq0
	yBk0Bofe8f8H5MTQbfwpYIRg/ZXLSxkeVFrx0j3KLodrzIYduzv23hAJFNtFmOn8RQke+L43Bff
	BpOYO1FfDMgxfQFfzI6aTfuxHKJm2QsIySrEw8XZRgI7KIX90OQR2FzdgqUjJmARURelAVxoW7W
	e37VnssTjDEUmp1nVAP0c3zVWmiAkdsqkm5THMUVYA1F1A9kWm2hAZaLqwuIm34ANvYeQDWLVPu
	dzEM0TV7TPTpmw7DenrI6lEv0SvIKEmoqyBLbXLXh0R0oa+/r6nS5UExaE6s3lPojyEY6gP5W62
	jSbYWU=
X-Received: by 2002:a05:6000:4810:b0:47e:96f6:ab7f with SMTP id ffacd0b85a97d-47f2dcc1174mr15902133f8f.16.1784024778833;
        Tue, 14 Jul 2026 03:26:18 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c1f84sm7251991f8f.29.2026.07.14.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:26:18 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com,
	rex.lu@mediatek.com,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH wireless-next v2 0/2] wifi: mt76: fix per-band LEDs under single-wiphy MLO
Date: Tue, 14 Jul 2026 12:26:13 +0200
Message-ID: <20260714102615.2943-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-39021-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:matthias.bgg@gmail.com,m:rex.lu@mediatek.com,m:linux-mediatek@lists.infradead.org,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:petr.wozniak@gmail.com,m:matthiasbgg@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com,lists.infradead.org,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,get_maintainer.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6276753603

On MT7996 (and other single-wiphy MLO mt76 devices) only the 2.4 GHz LED
was ever usable: the 5/6 GHz band LEDs stayed dark and a WARN_ON() was hit
during probe.

Two issues are involved:

1. mt76_led_init() calls ieee80211_create_tpt_led_trigger() for every band,
   but that helper supports only one trigger per ieee80211_hw and
   WARN_ON()s + returns NULL on the second call, so the secondary bands got
   a NULL default trigger.

2. mt7996 assigned the LED brightness_set/blink_set callbacks only to the
   primary PHY, so mt76_led_init() bailed out early for the 5/6 GHz bands
   and never registered their LED classdevs.

Patch 1 shares the throughput trigger across all bands; patch 2 registers a
LED classdev for every band. With both applied, all three band LEDs
(mt76-phy0/1/2) come up and blink on their band's traffic.

Tested on a BPI-R4 (MT7996/BE14): all three per-band LEDs register at boot
with no WARN_ON(), and each blinks on its own band's activity (verified
with single-band and MLO clients).

Changes in v2:
 - Patch 1: reflow the throughput-trigger comment and wrap the
   ieee80211_create_tpt_led_trigger() arguments to stay within 80 columns
   (no functional change).
 - Cc the MediaTek SoC/wireless maintainers reported by get_maintainer.pl.
 - No code changes since v1.

v1: https://lore.kernel.org/all/20260628095313.7790-1-petr.wozniak@gmail.com/

Petr Wozniak (2):
  wifi: mt76: share the throughput LED trigger across bands
  wifi: mt76: mt7996: register a LED classdev for every band

 drivers/net/wireless/mediatek/mt76/mac80211.c  | 18 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7996/init.c   | 18 ++++++++++++------
 2 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.51.0


