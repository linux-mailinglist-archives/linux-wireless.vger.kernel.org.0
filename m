Return-Path: <linux-wireless+bounces-38805-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rZmvGmmsTmrFSAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38805-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:00:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79472A0CC
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JjL0JHQk;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38805-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38805-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A35733028C50
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE23E51CB;
	Wed,  8 Jul 2026 20:00:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB33D0934
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 20:00:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540831; cv=none; b=kzIaDh18OfOsP/qYJyotNb8WRAfLXPEE8NCk9hWm1M5gC7y502z7M0jG3WJIPxDN7azOfJDFtSfI0EFxdWf9OzPm5O8514TEhuDazh7AWrZsgdeM9oiG5CfQh31kHJmmYNEEucJSBMXhIJ7mAufTMrQB9HVF+WtOXm/b6UKW7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540831; c=relaxed/simple;
	bh=/SAxxMsThDq0O9UGIQ5XY3LxNEdloDeHiKs04VUJlxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUq8G0RsyVIVyjUl/MCzWHWOQOxWZXeuSeuV9GOC982DglwS0fOQEX8v1ZqZUfDRion8zfxXB8bQzf8r9WUpEEQZRj1F0+z9Jmo0oV640cyPs1OTuyC0aI+WaYI7OxFf01o4R7/6lbeitBfIgMqtPHXOpZBfueTeDGYKc7ltj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjL0JHQk; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383adaa461fso797585a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540822; x=1784145622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/bLDuoO7MLFyiV+1ELXwNRC5hxUInQv9JgucXzus9M=;
        b=JjL0JHQkr6ZSgGezlP/uJApZSanXGuYHGZR9v92JeaJvRma9PSPeLwlRgiolyvAqIa
         guGTG2kcSii5X8nFQdyynEkTk0KNwNzs9XcUJHgP0CmKr+tEPKrAIbYbn97jC7E1/Dw9
         Z1T3snpXPJ6Rf65hRnWrAgyAFZw/mz3RblGS5FjDrDutuTlkerehtkxnuPO9PNPEUljb
         mBaNR6Bw7fOmmsIYFw1z9lg4vv1KExsmG18g2GYoT3aZazQoCwZT1Sry9rpCyaNn3ooM
         +Yyb11J0YG5hbQdJy3N4XOqbgtBtlzHsdq/cXiaspv3h5PlNSm229vWVEsxGGzomrzZZ
         LomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540822; x=1784145622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/bLDuoO7MLFyiV+1ELXwNRC5hxUInQv9JgucXzus9M=;
        b=ZD0cfiIh96qOk6Z3231y9hGq4uw2lQ5T5eay2NGXtJBL1uipMkrKkdKNFsoAxwsN0O
         nnpGnKjSIH7zYE3ddc7Qn0q6w+ye+hmWBxFVFisc3GRLk/C5AgGRLbHG6Klpla3Ok0BB
         PG520Rz4wB9j93/lPKmZRJsCW7z9q3UyedO/AOTv6frCrnFLIk182aPSKp4UegK+7hi2
         95ZaqQoFFO6Ew2sj5eyRoQ0KTgRW1XJRaeLCeb5OdOOHynoJy5q0Vnz99N2ZYa3l2+Bs
         tBZJSmnBr6mjXpp2LsVqkgD6Fs1zEXPI7W1iL5wZw2npgLLSys0W2gr5zVUvHK70m3o+
         RGYA==
X-Gm-Message-State: AOJu0YyIPOU7TjQTivj7S/kkhzY3FPqfeg7GL8akaNglDjM38+VLlWN9
	CPlMNo47W/HT3A7yhhZfdscV93uvrtjgjnYQcOaS1bTqnatRSrT0mHHPBSTp0HBpYWz4Fw==
X-Gm-Gg: AfdE7cke8Xfq24V3jDYvz/wvSP27UUXnjabwRDRCjfbtwX8LZsViZBUD4yvjJLDmqfL
	mKS5w+t3KCJ6rvRbewwuPYItfpJf7dAq6+pAyWr9lzZcCZ67L54q1bq22qLfBNe7qSTojWee+Qe
	nEIST1Kza7AGiNyTiVjH26cc+4dClEXxgwS5xJcvEYhRLo5x39iIY++3TbP0OoYsvP3fh/qvvv0
	WG3DQt0tFr11zQ5iapGOlMg74K6o1MLO6/bf7lGF7hu0RY3sjJegHwslZ9xtU/jTF0mHjUrbFt3
	aqNZpHdyu/UX9U3cBTKXcoj68NQDeBEHYIuTBFmcmA0Mq1zYT0wAVePS9jdg98j9vaFWfzQ2VXh
	fZwl5dcciybU8fZPfGpk7OeeXRybRJz67A1Z5TjU+I4j+r0LfbOWEtqQlL/yp9U1D+4EADWHk4j
	v7Bq7b1Sxnot5g9U4chVK5+NL1QnzhUtiwgOzEI55y77aJECAgxeBN
X-Received: by 2002:a05:6a21:6e43:b0:3c0:adec:b3bd with SMTP id adf61e73a8af0-3c0bd19ef91mr4672746637.49.1783540822437;
        Wed, 08 Jul 2026 13:00:22 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.13.00.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 13:00:21 -0700 (PDT)
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
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/8] wifi: mwifiex: validate action frame fixed fields
Date: Thu,  9 Jul 2026 03:59:10 +0800
Message-ID: <20260708195911.84365-8-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,chromium.org,dolcini.it,sipsolutions.net,google.com,oss.qualcomm.com,kernel.org,phrozen.org,marvell.com,tuxdriver.com,quicinc.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38805-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:johannes@sipsolutions.net,m:jaewan@google.com,m:daniel.gabay@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:pagadala.yesu.anjaneyulu@intel.com,m:peddolla.reddy@oss.qualcomm.com,m:lorenzo@kernel.org,m:john@phrozen.org,m:patila@marvell.com,m:cluo@marvell.com,m:linville@tuxdriver.com,m:quic_alokad@quicinc.com,m:enderaoelyther@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB79472A0CC

mwifiex_process_mgmt_packet() accepts an rx_pkt_length as small as a
4-address struct ieee80211_hdr plus the 2-byte firmware length prefix.
After the prefix is stripped, mwifiex_parse_mgmt_packet() can be called
with len equal to sizeof(struct ieee80211_hdr).

For an action frame the parser then reads the category byte just past
that header, and for a public action frame the action code at the next
byte, without checking that len covers them. A minimal-length action
frame therefore causes a one- or two-byte read past the end of the RX
buffer.

Reject frames shorter than the header, and require the category and
(for public action frames) action-code bytes to be present before
reading them.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Fixes: 72e5aa8d2a6d ("mwifiex: support for parsing TDLS discovery frames")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/66f148d83eb9f0970b9abbccc85d1b61244e54ad.camel@sipsolutions.net/
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/util.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 7d3631d212236..e2d76c2d9b05b 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -313,13 +313,22 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 	u8 category, action_code, *addr2;
 	struct ieee80211_hdr *ieee_hdr = (void *)payload;
 
+	if (len < sizeof(*ieee_hdr))
+		return -1;
+
 	stype = (le16_to_cpu(ieee_hdr->frame_control) & IEEE80211_FCTL_STYPE);
 
 	switch (stype) {
 	case IEEE80211_STYPE_ACTION:
+		if (len < sizeof(*ieee_hdr) + 1)
+			return -1;
+
 		category = *(payload + sizeof(struct ieee80211_hdr));
 		switch (category) {
 		case WLAN_CATEGORY_PUBLIC:
+			if (len < sizeof(*ieee_hdr) + 2)
+				return -1;
+
 			action_code = *(payload + sizeof(struct ieee80211_hdr)
 					+ 1);
 			if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
-- 
2.50.1 (Apple Git-155)

