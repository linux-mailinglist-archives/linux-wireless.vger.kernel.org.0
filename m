Return-Path: <linux-wireless+bounces-31634-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACQXENwbh2kgTwQAu9opvQ
	(envelope-from <linux-wireless+bounces-31634-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 12:02:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37744105B35
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 12:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 295D130028EA
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Feb 2026 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C4C340290;
	Sat,  7 Feb 2026 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2PPG9JS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB633556D
	for <linux-wireless@vger.kernel.org>; Sat,  7 Feb 2026 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770462167; cv=none; b=mASyDPaDpvis4OZdDqfErQBJjbAjp8ZqTgsZhaaBZZN5idL5/HcHlSE4i9ttO+PCuz6EvMaAbIQk/Ha301O6WpaMfEk0h4051+YH5EDiNCv5BmIHyP/T0DyBU4zAItwIYwQAymAK/B8OGLeOGIr8oYbhT340YeGV/HjHyUuBKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770462167; c=relaxed/simple;
	bh=+CEugQJalqAvwDquR/WIi4tpqt3psdmfDSD3UiMI0cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKMVtk5NJ5E8X/nM9VtkLp6E7xiOLARV+cbqrQAEOFVIJILbfEsWVOyHeD0jNY1WrsJQOiCg/wUo9UgCTOW6kqsIQG2HZrvTz1TdCa9gRis7W505mQjyqrmdjY4B66RczLiyE39ifPnYF/bVC45kGSO0GVCNMl12Of+1HmPdTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2PPG9JS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824484dba4dso1276066b3a.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Feb 2026 03:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770462166; x=1771066966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbtDKCFJU4gVYxj7ivUbEj5t5uKlYVsXLHCtb4Ekpdg=;
        b=E2PPG9JSwtrf4LqX1ShTgBB8NER9YQL4OX7C2LjBZ4jeNFLvCpmAp3jafY+Wawlmkk
         WoDShm+xah7wrOT+7W6p6YgV97t6pOeKqOiYsbq6y13IbQ+wtsRuA/N2PGO3QUWT6Fms
         KKrpZGE7WlAFzjDT0ZW8lOouy3sIpQoq80yZNPy3u8fHm0aeogYIkF3R9IIThLz7Z41M
         L6ulq/tjXMQq8SxgwVTT9sTJA48z9G9R18QrqHyVjF7V94ybdHOJ2yV8/KAH3Y6lY9jP
         aq3mprmIj9QMZX9MHtfWwDoR29QtlESlay5iiUK3ykP093ifmnGZjPruxF+2fqBi8+nh
         B7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770462166; x=1771066966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbtDKCFJU4gVYxj7ivUbEj5t5uKlYVsXLHCtb4Ekpdg=;
        b=W8qmKxoW1CPXO4wJNSJM2r84BGeRZJDHE/C8NRRBT5rz6fAHWnRaJQAKVWYtHPVuet
         tftEZdhrtC65fz2C6N1PsLxrFZodnDnRpFMqnGvzPDrrhJhd4o7LNxjZSJ7ltWPEUYIM
         iVZIU/ciXhAEK4qJHBsEtVc08dyrjciuxNBI347DoxiE6LQphnd3TK7P2Q8uvfEnuEUD
         b4VSFUEG27nbMN5h6BB+U5OjM8QsltqtEsYyhlCpNfTrETuyn5RdanRYwGVnujiKxAKq
         POO/Jzpfk8SEhNYwMhZ+9EmxAoWKeO4zPgiqulKaxk1FJirroH5Q39Xa0vQUTQrRNDRD
         J+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjVO0nad5+Zn5he/AS7yUjuUpwQW4jdZnzT855wHg2x0bSCBUWwxk9WW2I5s7Kd18/iMBr9eYaHBJdC/5lPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNUw20DKK707LmmLotAoEzYm0xT+dXEPUYdFfHPxYJ96/OBziV
	DiTxYlCwz6cJetDXV4YgP3k2xjAt20/6CIQn/MvuxdBxaFO6BCMCpNme
X-Gm-Gg: AZuq6aJoBsQIlakNZK7k492RUjGj5e+uI1EjtVW/fJya09gWM0vrorkpzklNBOVjog/
	hDJwGdBC5MUz25PdmHigacDlHVbaygU2pefria6kJZjwC+VKAJheyouaJQDmyo8qMa7C9ekdUs5
	fZ6vH3zEYRvdtqIHfXR2XutSDD+bGDsV3fCaXSdNXhHS1v8R5LyuVOqzxU5ovU63IoVPIu9z10p
	UDXkpBBi8Mt8VoLENg+ZFOghubq7ONdNIC7J1D+NiZZQTGlrC1rUH59IHcGHqAr4TE3oPOlwP5C
	0cPiw5pmruT1sMQCmPZ9vwNGjelcX/BbRb70SvWfUFofcxcwb761WpaaR7UaSC0jqK0bSUAnl0i
	6yuotq8IoRInY34zScbozYMAm55r+2e3xAkgbAOUdroSJ4ae2zCQ0DfCdIMF0yYL5bpdHAIaQow
	eM4twbnQ==
X-Received: by 2002:a05:6a00:3c95:b0:81f:9bf3:6deb with SMTP id d2e1a72fcca58-82441632cd0mr5152277b3a.15.1770462166136;
        Sat, 07 Feb 2026 03:02:46 -0800 (PST)
Received: from mint.. ([27.59.95.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418856d5sm4424201b3a.38.2026.02.07.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 03:02:45 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dhyan K Prajapati <dhyan19022009@gmail.com>,
	Dhyan K Prajapati <dhyan1902209@gmail.com>
Subject: [PATCH wireless] wifi: mac80211: skip BSS_CHANGED_TXPOWER for monitor interfaces
Date: Sat,  7 Feb 2026 16:32:24 +0530
Message-ID: <20260207110224.32755-1-dhyan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31634-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37744105B35
X-Rspamd-Action: no action

Monitor mode interfaces do not maintain a BSS context, since a commit in
July 2025 monitor interfaces with WANT_MONITOR_VIF began receiving link
change notification duing ieee80211_add_vitual_monitor(), when
ieee_assign_link_chanctx() assigns a channel context, it triggers
ieee80211_recalc_txpower() this sends a bss_info_changed callback
receive link->conf as the bss_conf prameter, in monitor mode it isn't
initialised leading to NULL pointer dereference in drivers like iwldvm,
as BSS_CHANGED_TXPOWER is not applicable for monitor mode we can just
skip it.

Fixes: c57e5b9819df ("wifi: mac80211: fix WARN_ON for monitor mode on some devices")
Tested-by: Dhyan K Prajapati <dhyan1902209@gmail.com>
Signed-off-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
---
 net/mac80211/iface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 515384ca2..47f6bef0e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -76,8 +76,9 @@ bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link)
 void ieee80211_recalc_txpower(struct ieee80211_link_data *link,
 			      bool update_bss)
 {
-	if (__ieee80211_recalc_txpower(link) ||
-	    (update_bss && ieee80211_sdata_running(link->sdata)))
+	if (link->sdata->vif.type != NL80211_IFTYPE_MONITOR &&
+	    (__ieee80211_recalc_txpower(link) ||
+	     (update_bss && ieee80211_sdata_running(link->sdata))))
 		ieee80211_link_info_change_notify(link->sdata, link,
 						  BSS_CHANGED_TXPOWER);
 }
-- 
2.43.0


