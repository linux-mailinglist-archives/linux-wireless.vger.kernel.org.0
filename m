Return-Path: <linux-wireless+bounces-38803-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dNBRIUqsTmq5SAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38803-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:00:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD072A0B4
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:00:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NS1rrI2l;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38803-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38803-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8562301D74B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 20:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2613E172F;
	Wed,  8 Jul 2026 20:00:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFC3AA4E8
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 20:00:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540808; cv=none; b=fDjGbxQoRq3NhsiEcqoK0OT4Z2cl73eyOfnRB+JHKlgYpQET5QryiUe1gQQzPfEPz6FmblsiEYmgVyTxZL2d7FBMfcKg62sfuNuRgSei+3h/c4iZDIaV0VQMaW7mSPJ9P0N+N6gQL2ub+CrdWA/UR+EF/+oEJ8RCTESy/7syTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540808; c=relaxed/simple;
	bh=DjR5LQ1tNI1HuSIMzpG5/0eIkvkw+hOuWNdmJ16ZyZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOq8uN8g7BGpAO3WtdWz/ef35fc8kWZdW48ibhSMxvLnHK7nu+fz8qiUXsvz10UOWTJiPmYTQGedPqf3kM94PFK2gEfwoqACbd8oUcbAwPCjT4LMOclQJ1XLIcSVyYXDIPJknRBLgDAh0Bj3sZgHtbc5kYx7DFquF4GUUcZrvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS1rrI2l; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-388b404ea89so260794a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540806; x=1784145606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbBFKyXB4yXB0DD+UuWj3GkBzIqJgXli2HxNGrv0Y4U=;
        b=NS1rrI2lStZmfXKnVtsfWxKQEhM+fieJ8Lcd89HK/jc6hA4VGGirMy3ECyJA6Tni/G
         ipwB1yzWRDA+FEwMJfSJfgcXSoqDvGVgok793hODkXgfWd5/nP3KulBpTP8PbtVsaR5F
         n7BrphyTc8Ra8g/dswKj9D6L87FP/DaBJNimPtPatAN6uecfmpmFEWpRcdB3KV47Sm6K
         MiAvWP+Bw4NLCYtGhLCFATHQpf03lSSIFxPDbKkkMBb8Z5gz16j//F+xlya+OuICi873
         KvPvsJ2Bk4XqpngU9Cj0hiuF5nuEtLtzF/eAicb3lobvI14ELkg5hlPqCkfvCFsYYgdR
         uS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540806; x=1784145606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbBFKyXB4yXB0DD+UuWj3GkBzIqJgXli2HxNGrv0Y4U=;
        b=rcwo1i6arlogdBwrm7K6kSxJuEldm73LRoOoFFSvOtRo2OvovKeaqUKDvGqJY6zjVE
         NrYJ6omPnMHgNfnEk57gzhrh0RAsmIDN5DJnaXlXTcBCU5ZT8c2AB0wncQjOm9rw7vbu
         PhjBXSXvLSWhDtq9sHl3PrBdSrIR+bQDAOCBpg8yD9nJXpdGeHLnYnB3nmH3Oy+hJ8/a
         V6G+1xRkdW6BZDcTHw0cAUmuC1hzpb+hl4Pm0ElJ3bhvQsQzpLL2/DOWOWXHCv0K2HIO
         4Vwk0b63VZYuB1+OQQ02yQ+rZj8jLc3f0IuPNOD0wlsv+BoVkTizBHQxwSEMvrDdillT
         GB4w==
X-Gm-Message-State: AOJu0YxmU9Do5qgGNZQyt42S68PLC7eA+cwrtll4NrE0Cmw2dQ/MPMF0
	cgRfzEX+07b2ki62m/EPufkpGBpBhGK6HIA8Y/wje1YAzikWWAKuffnLtNiRBdbKAKTOqg==
X-Gm-Gg: AfdE7cnnmzbkQrsH/lQk4Kxt2Q2xBUaVX6V3HX2hoai0J5IsiB4zw3PBiKKOu8Rvs0Z
	SjkwXlgxHOknph+St/MQ9UJ5siqHYnH0EdVYk8fIgRtc+ivGENNNBuNuAeXe9Y2jPtAtjRQyCmL
	JhjVG78vBqpoHh6UZ4KGKsMB/NxKOFbkj+94NeIDkxWyIjXnxcKtQuzurDXdwiAbqDHBskIwVaU
	gLIQbb1guA4ZirU3U0LktXP16iCNelFMB1lxH76Wb3HLZUkMws9l4YQpryAT/81Viayc2HWcz8n
	0yiyfFhp1PKHxLPYG/Z7k+P746C5pO/CmBdc6Pi0BMq1bNpiFwUv2921JKTKhdrTT24bgM7pq1O
	0xoYM0aivymdy+G6ZUoZteEaBpP1YIgvns0t53FAmlxboeKKreKO/fbZEs2EpHCaywhCuW6spt2
	sknWpvC1gzB5hudZqCUh/RT+FTcBg0iw3L3Hr/MPVxtUr0f0pXpXHl0zaUPIeIx64=
X-Received: by 2002:a17:90b:5746:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-387d8ded9c0mr8619185a91.14.1783540806257;
        Wed, 08 Jul 2026 13:00:06 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.12.59.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 13:00:05 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH 5/8] wifi: mac80211: validate probe response countdown offsets
Date: Thu,  9 Jul 2026 03:59:08 +0800
Message-ID: <20260708195911.84365-6-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,chromium.org,dolcini.it,sipsolutions.net,google.com,oss.qualcomm.com,kernel.org,phrozen.org,marvell.com,tuxdriver.com,quicinc.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38803-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:johannes@sipsolutions.net,m:jaewan@google.com,m:daniel.gabay@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:pagadala.yesu.anjaneyulu@intel.com,m:peddolla.reddy@oss.qualcomm.com,m:lorenzo@kernel.org,m:john@phrozen.org,m:patila@marvell.com,m:cluo@marvell.com,m:linville@tuxdriver.com,m:quic_alokad@quicinc.com,m:enderaoelyther@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20AD072A0B4

ieee80211_set_beacon_cntdwn() writes the current countdown value into
each configured counter offset. For the beacon it skips offset 0 as an
unused entry and bounds each non-zero offset against the template length
before writing. The AP probe-response branch reuses the same
counter-offset array but indexes resp->data[] with neither the
zero-sentinel skip nor the length check.

A probe-response template whose countdown offset is 0 or points past
resp->len therefore takes a stray or out-of-bounds write. Apply the same
zero-sentinel and length checks the beacon path uses before writing the
probe-response countdown byte.

Fixes: 5f9404abdf2a ("mac80211: add support for BSS color change")
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 91b14112e24f0..84b6eda46a8f0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5249,6 +5249,10 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 		if (sdata->vif.type == NL80211_IFTYPE_AP && resp) {
 			u16 *resp_offsets = resp->cntdwn_counter_offsets;
 
+			if (!resp_offsets[i])
+				continue;
+			if (WARN_ON_ONCE(resp_offsets[i] >= resp->len))
+				return;
 			resp->data[resp_offsets[i]] = count;
 		}
 	}
-- 
2.50.1 (Apple Git-155)

