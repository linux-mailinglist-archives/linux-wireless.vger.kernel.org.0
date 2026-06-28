Return-Path: <linux-wireless+bounces-38226-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VmnfObIcQWqBlAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38226-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 15:08:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 363406D3DBC
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 15:08:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h7+ptJpU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38226-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38226-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5447D301CFB4
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649243A5E77;
	Sun, 28 Jun 2026 13:07:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9B355F41
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 13:07:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652036; cv=none; b=PA4gVDtkDw/QcB4b/hxanqgL7T3lMOLIMKIjpjG0aQmw/KFjN6535qPOu3qttvy3/xyL+qospa6enCG/F3ljKF4lWp28DTmzpd0SLjsyOx3ePwZJOJ+Miso/sGhGqfvP+mqYZPtzUo+cxcXnL5sum7ALwebETlt3cA8XoRDW7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652036; c=relaxed/simple;
	bh=NOV9k4bQmcTJj14SJdSkvZ+wA1tTmvIvaPIE5b6IdDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWB0XOaYoGUXsr6Ryb976KkB8xVePgwWPzPEuDkilQ924spK+5Qbi6J4IDfSCVDPBtv/dQStSb1p/VyyUKXxVeNUbuMWiLf4LhBolNWN5b72Nd3DpAKmNgmTScGJjF/vhnRYamIBEJieLXZm1VcLPWlD7GwigHthcbidnZ02lYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7+ptJpU; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845b733e82cso1492369b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782652033; x=1783256833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEXc+1vTiBJ6AKjHtSXADxnFDqbZ7Sr0UXeDibP7lJo=;
        b=h7+ptJpU30jMeTLb3rBsLKfnolpYQ9S78XbOLO0Mjp4aUZGjtNSPl5jeuw7Wr+/e/1
         /kyEl+9kYKXKziVw7v9A8D4zSbgiLV1hTJjBWnysQsILX28poPv4ygL4iBG/ra56MGRI
         aUHbeMMhGcfGRouEMbmvT6ktWpmVG5u51IZSPERgm7bjA0fpIDeLwsGndG8iVLKnc6Yn
         19gnFKylGUg9rJOq0S0uNNYwYBVbBcECzoIs/GqipfGBcwSCqEfn+qgfjgdosE30MIic
         fphYVv3LGlFdGd3YOoNrSUvvRJftkgLyFocqFPn8ROluMM+TcC+gKxz1eyVjG5sK1Lne
         8twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782652033; x=1783256833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEXc+1vTiBJ6AKjHtSXADxnFDqbZ7Sr0UXeDibP7lJo=;
        b=Lyh/1zbGy9llxlhIV6utqAWx+j/oVPEGH/9/uiXZYL49vYax3gZxJMWvN9/GTa78QX
         QPDioH0hB6HxR6EbPgWNdLBWaN/murPm/BtusZbRuYBNoB8MbaVw4IpSpxM2aAK0V15M
         WPMpfw2gYN2fpdWqV6PXqz1Niirju/ntstmR1umFpbjVgFJ7pH6A0SW6Fn7HckWoxmcw
         hxEu0Bzzs+wQnKLd3W2lv1UqNri2JECgVu2lr7mc2ArGslhW8R3M0JdETIpYwA9tzLui
         zEGl8wZKB1dHavWwiG6qStgEj617cCzLgu1TQbA7HdaeNnYXn2zGzkZSWklOu+qWOJg9
         I7sg==
X-Gm-Message-State: AOJu0YyNYADa6NvBkdHbARz/GzeQ62DBxirAw4hvr9ei4hARchNXEHBj
	w6B2U7lQaXHOilaXNLvRV7S8af9T4+G/RMJ29wohPODTGjMvxOl9BXPX
X-Gm-Gg: AfdE7ck+YTwTHFSgVTaZuYq99Yty9A2564hBDW6+oMYuiFDlGdWBOk+4Gki3tItdk2l
	BYCXLQTubJ0KsKoffemAxbb5eXSurkjLm8YbfS/1aUrDsuNK7RTPJlBfP6GKjUhvumPiz/cLcKN
	1Ur+fN0EDTBqsZEte7QrQux4FIE99FYlUJ9ptUmmIJojKP0pw73V5Ktuz3pbUMhZPI0uZPQU2Um
	JJcXKytLccNKhxfonIVb9IR3GD9cNpNsTx8IgjXp265E9BTlkrpX7gGB9Sh4gKXZDcz0Ut7fRZi
	IErAZRW5y9U+TqPO3wAfHzIMqqXP4OAe0BBmyGe5qCF5QBg98K0FDd+ACINtIskvTTCT5X+OBmY
	d/jRYDP0CsKKO7gmhTAvl9qQjrqtjFQmId7xi0oKDQ7+V3FP66qtDa+nceBv2R4Q/oHP5KGfKuO
	gMPgR3TRBqwsTbIBbkRc4ZxIvbKbw=
X-Received: by 2002:a05:6a00:3004:b0:845:e703:3c with SMTP id d2e1a72fcca58-845e703122fmr2516476b3a.44.1782652033241;
        Sun, 28 Jun 2026 06:07:13 -0700 (PDT)
Received: from localhost.localdomain ([112.166.204.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40ee417sm9712281b3a.40.2026.06.28.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:07:12 -0700 (PDT)
From: Hojun Choi <ghwns6743@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepak Karn <dkarn@redhat.com>,
	syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com,
	Hojun Choi <ghwns6743@gmail.com>
Subject: [PATCH wireless] wifi: mac80211: clear beaconing state in ieee80211_do_stop()
Date: Sun, 28 Jun 2026 22:08:02 +0900
Message-ID: <20260628130802.7698-1-ghwns6743@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38226-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[ghwns6743@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dkarn@redhat.com,m:syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com,m:ghwns6743@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghwns6743@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,ca7a2759caaa6cd4e3db];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 363406D3DBC

ieee80211_do_stop() zeroes vif.bss_conf.beacon_int but, unlike
ieee80211_stop_ap(), ieee80211_ibss_disconnect() and
ieee80211_stop_mesh(), leaves enable_beacon set and the
SDATA_STATE_OFFCHANNEL_BEACON_STOPPED bit pending. cfg80211 rejects a
beacon interval below 10, so a zero interval comes from this teardown,
not from userspace.

do_stop() clears SDATA_STATE_RUNNING first, so nothing acts on the stale
state while the interface is down. But do_open() re-sets RUNNING without
restoring beacon_int or clearing enable_beacon and the bit, so the state
survives a down/up cycle. A later ieee80211_offchannel_return() on scan
completion then consumes the stale bit and re-enables beaconing while
beacon_int is still 0, and drivers arming a beacon timer from the
interval divide by zero. syzbot reported this as a divide error in
mac80211_hwsim_link_info_changed(); the exact sequence that leaves
do_stop() with beaconing still enabled was not reproduced.

Clear enable_beacon and the bit in ieee80211_do_stop() as well,
mirroring the other teardown paths, so the state cannot outlive the
interface. do_stop() warns on a vif that still has valid links, so MLD
links are already torn down here and only the deflink beacon_int is
zeroed; clearing the deflink enable_beacon is sufficient.

Fixes: d6a83228823f ("mac80211: track enable_beacon explicitly")
Reported-by: syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca7a2759caaa6cd4e3db
Link: https://lore.kernel.org/all/20251205153502.273426-1-dkarn@redhat.com/
Signed-off-by: Hojun Choi <ghwns6743@gmail.com>
---
 net/mac80211/iface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 086272c3ec08..c070d47cb631 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -719,6 +719,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 	sdata->vif.bss_conf.beacon_int = 0;
 
+	/* mirror stop_ap()/IBSS/mesh: also clear the beaconing state */
+	sdata->vif.bss_conf.enable_beacon = false;
+	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
+
 	/*
 	 * If the interface goes down while suspended, presumably because
 	 * the device was unplugged and that happens before our resume,
-- 
2.54.0


