Return-Path: <linux-wireless+bounces-34632-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KILsGLlJ2WmkoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34632-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:04:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684E3DBC4B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C120301C5AB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E328FFF6;
	Fri, 10 Apr 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="TpMnJ0+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB91514F8
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847843; cv=none; b=mReg0owfj8uJN4/xO0oFQlSpgpIQYK1QSj0nuPAN9GMdLWGuHDskuzzD7zpQA7eKXb0bHJtkyX3hypc9g72Tjun5dGyimtR5NmNSD5T0EfY6gEovQl8YdEwI07+7ipVIZVrCRHDpAuQhM4ctz4e22SczYNxwDoQx76WvwGJWqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847843; c=relaxed/simple;
	bh=exzWL2Yt9W5/vG7WFviOyppf3vQlygWb/ADH4zh5X9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx1H3tLeRAkOD7RPn4lgTDcE0owfdAFhzuWUKpAT0XBIjuUq9YZMN6WEas2Ljb4G5UZfaEaIAduV+m/10TPXLdEzdTwxcqUDlf40pZHvYtO3ls9p802ywPAT7a3N2+Gc0ofvGMi/cek0A78iL0Pjyu/DMkq1N80+ny5br32OVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=TpMnJ0+p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8efed61so21700465e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847839; x=1776452639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goGAUjPGXD9cgM33AB25WgZi3cRENmGNELxGDocOawI=;
        b=TpMnJ0+pxsz1aeuJjTS3Ht/8C85lEj+w+OXwrHiEXovQJGKZcIp+E8mXv+oY91xRQa
         ES40l2+cTI1bHnRcMvd6+vAeWrjUvyKnFpMRJ4UVjxIepmXdbrfDA0kkVv9mfT4tY5s6
         W9/Jn8dDgTHWCCKPYa+HG2fTEtXATZs30GePreNC2GlodM8v0PPerpls/1wA1hS+c3xT
         irisHH00ry0AY3RaHmx7ZpD9h4/2eXCMbujIKDR/Gmp2HjP7HMy+i/wQ9Vs0VNRs4uK2
         LrtOrGlOsLzEsmy1/bUUgyTbuibcPZIKnFDJPSlMaZWv+pXF7nGDwwlwo/Xp3zZlTjyD
         OM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847839; x=1776452639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=goGAUjPGXD9cgM33AB25WgZi3cRENmGNELxGDocOawI=;
        b=j2fLphwyKH6E1KQYf5hzocCcN0Vg/f8QKlOVumc6aqXtAjZ/V+qCtmRmWGpM3mr937
         0rU4wnnT1jpVQJdN2/4L21Tz/Fdli1j8jNiFfZJ3Zd7HhbjZu/d/bxIwDZy7sT/HlK3D
         d+SUHHqH+os8vy5kFuQPNhEqO2rmmqnuOHNlmVuK9SkRvigwO5BvtvyDdXcQCpJ2uSx3
         ei9t2FFiJrWs3PN/6qpsdpa2gmjjxObcwUMiXgTKhHxrcxJ5Lxvz62EW/Cpn6j0TPROU
         oJZ6JfwoFcUuX/redsPjX8/Au5D80oYOPjYGHpHRBk4TddPucnW8IGYQ4+BnQqk57fNf
         KYGQ==
X-Gm-Message-State: AOJu0YwYoBeyEBgPrc4cGaG5xww4Kdlgkw89caRqZ6J3WXl4tuXkxBu1
	zlY8H8R73moK9K5VOuMKjF9x/d/6+h3Sk/RMxmqM5JINlTJAISosRJi2L8skFh7fh+aiQ8p+4Rk
	rnj6J
X-Gm-Gg: AeBDietuvQsCAq0b4K8VWJwlQT7UAbOx7uz4b1VaI5i5XeIpjmcjd0Fg//P3ZvFJiOd
	vFaW7NOdYupZArwkjrFAqK77o0LNPLN0Ln29jHUHZVwNjQR4uD1d9x/4AM8S1bJkfCUcajmbONP
	dDRUo+SWYu4Rby5gWIgniPeL2a1ozn/2ApQZe+kxFvqNDHcwM/ieouOaPipPHMktAov33FR3rgp
	05Yh0Wd5XIS8MwZ3j8QQilP5g5jFi8SHuifP848Y32NiYzPa7RFkQoiTnRjV3EN1gTTLC0vpDTZ
	zu0iP+v0YSuPNgEnA1gvrJ8LdxHb/dsvTYdRc3pKpgVWwiHtnVHqjho20/6BbE1O6mM4tbgaInu
	GGfGyFVupKQgnJehkUTdXVnLrHLzFo/NI/OqyjGOEGWmQGXuevbVdkkZC1YHXcAXu9qNgxReuvm
	KkUUCfxGQcqNjktcEj/ECUnJxuLGG69LdBGACBbBWT1tm1IfOOWuOZsrMmJQH5JsjTtwaTUwOuq
	SqS6XpOuUoj
X-Received: by 2002:a05:600d:8453:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-488d68ae9b7mr45056405e9.11.1775847839251;
        Fri, 10 Apr 2026 12:03:59 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:03:58 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 1/7] wifi: nl80211: remove EHT IE size validation
Date: Fri, 10 Apr 2026 21:03:48 +0200
Message-ID: <20260410190354.394742-2-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
References: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34632-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4684E3DBC4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove ieee802_eht_capa_size_ok() calls from the middle of nl80211
packet processing paths. There is no reason why EHT Capabilities elem
size should be checked here while HE & UHR are not.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 net/wireless/nl80211.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..fb0bb4a957d9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8624,12 +8624,6 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
 			params->link_sta_params.eht_capa_len =
 				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
-
-			if (!ieee80211_eht_capa_size_ok((const u8 *)params->link_sta_params.he_capa,
-							(const u8 *)params->link_sta_params.eht_capa,
-							params->link_sta_params.eht_capa_len,
-							false))
-				return -EINVAL;
 		}
 	}
 
@@ -8984,12 +8978,6 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
 			params.link_sta_params.eht_capa_len =
 				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
-
-			if (!ieee80211_eht_capa_size_ok((const u8 *)params.link_sta_params.he_capa,
-							(const u8 *)params.link_sta_params.eht_capa,
-							params.link_sta_params.eht_capa_len,
-							false))
-				return -EINVAL;
 		}
 	}
 
@@ -18550,12 +18538,6 @@ nl80211_add_mod_link_station(struct sk_buff *skb, struct genl_info *info,
 				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
 			params.eht_capa_len =
 				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
-
-			if (!ieee80211_eht_capa_size_ok((const u8 *)params.he_capa,
-							(const u8 *)params.eht_capa,
-							params.eht_capa_len,
-							false))
-				return -EINVAL;
 		}
 	}
 
-- 
2.43.0


