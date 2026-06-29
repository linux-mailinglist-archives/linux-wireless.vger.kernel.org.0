Return-Path: <linux-wireless+bounces-38290-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qFbyFuhgQmpP5wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38290-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:11:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535916D9DC3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:11:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lGuZeHVz;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38290-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38290-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8FC330151B2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1973DE445;
	Mon, 29 Jun 2026 12:03:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253D35F199
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 12:03:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734625; cv=none; b=UMuXm6voq+wilfi4CHVNnvj/rtkBg8uVTLLDvNM9Xq/xQigQVqYB5v4uWneVi1gxusfVL6DB7+AKwfzta6h074UbN85TRSHPOC04fQOVc4XLq0HGATkJtVjeJXLLCFMvnUnOf/EbB/7KFvrHobDLnvNbyHVSTKkXhx04blnR7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734625; c=relaxed/simple;
	bh=JPQhTE1ilYziVDyplFUCiF/SSPEC+MDRphuZ0tc3WaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SjLy/BZnibZ+sp10GtRb+B+meTF228XsyQkMjDT9thoHGCko7vCKf+rQJXCklWxkQ07wbVchTqfzl+dUN7S4WXAvvyxbha9ekQixrOigb1WrPnjEWQWOiSiCwa79qpGZlCCKbHpG5a1lFk6EDs6dDRNBs9wWGQj0ZICxj8DbSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGuZeHVz; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so10554085ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782734622; x=1783339422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+5bXmtNzCzxBWxQXEZwIkJIi/t0B7p625QjeNt4D4A=;
        b=lGuZeHVzbd4lFXpmjO6yKPUnpBSFajnItokVTywysh3gTzGkcrk7GVCKkwTlN68Cez
         7bewNTEwwKEldDnMVZqJTxNBHy6Jp/oR3ydVxssXtPnENE21ztaVUx3jnGHC6la0KG0q
         ytERjQNM85EdH3PoPR8IvJwUtNdbRVP/z50pMQozVusqRV3CO673i5aC3YXpCW18FgKG
         sLvJKcLQTrSz8VCJvmaoCce83ZQzv29v0LoKhBJkbQv+Sb1vcVtuM6YD733Difx+gqmE
         S0zFV6SqbYEEUzLJaf6Q2MuY/D03cVyTDC26NDz4u/QRCPzNSI3V0gYzqVZu8Q/dYVzb
         cL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782734622; x=1783339422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+5bXmtNzCzxBWxQXEZwIkJIi/t0B7p625QjeNt4D4A=;
        b=pUu8RcoK3A8YyUt+jmwKKRv89qIzIj269m6OP6Ji5Op2rW0d+AafX+6aO9XZmrs+ru
         xJ7yyzYYZkEC4r9sgx7IBV3K5pksS/cb59h4n+lEPikF95Ozx3q6kYPz0cRsZTYN+n4o
         oSBuAde0DVEGARanMVi2jIF/9dPNJTYTQouwvJTU/4hKgXxS+Ket61WcrQZqWSTzkg/H
         L13MTsKmuDk1TWcuCua8vO+oBuNnp5I02krcHJF7vIC1O2Vj57WLgPpOtmUGXE9MwGmw
         ZUWqhmjEY04Nn4vmK80yc7KJPDMbRrjCR9zZbKiSFtaBgAtyBvwS90lL+s0bK585uD9j
         W7TQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRnGGRPyWo37FNcNJcBlwCOjib6tU4QRfq/Ulz8XDTZdlRh6Kd40RMqjm4IDDRjvKh/MNfZFwSB2puQjTGAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW5muF156TvhctVyH3H6QDpIHYfQQURmvk3At4uXcHrj4QzqTh
	Ty9c3tBZ+Ox2NYpGCbVj8hQXsodln9eS02wNmOzqgtES6/aZ+hcSc/y5
X-Gm-Gg: AfdE7ckFbo2+ayWaCjX7cJdySSlwT51WF3p4rXbRYdJHs1C+uipTAMnyfu40bZPOy/f
	16lAgWx3irw6VpY3hvn9Pk8gWZFg8pNFet7jMWUQUty4sF4S9KDX91Sd3qUV54qf4c1k3ZkUlN2
	IPxg8UwNGgbEcgvToGO1YrheBzObat0rr6faHv0loMtwQZNM42lTcwBUHM9RC8JkHPz50z0ctbN
	j4hU1VMym4710zocuEQE77ydH5+F3zIichgK9MUu1k5J7lPOvg+4i5otYXd41UaDhJh6rrfZgVj
	xbsr00vJh8unVzxm5fgMHezPS8WAv1U15ASMGTKvm2EjQgdXjNa/H1/nVFZmhp5UMHPKL3papOI
	un97BMWqo0uVOe40T/BWC62AGlxDHuoQWts9MtGboYuXO5TUU/PQElKfVkw4LDL8FZcBZn6V9M0
	7BsWibUcxnLeHkn/0Qgsp7dL62TritdXOvtLFEoghD/vvufBRQmVFFOUe1Ql7hVXTSAHsDUpif
X-Received: by 2002:a17:903:19cf:b0:2c9:e9ad:3ed3 with SMTP id d9443c01a7336-2c9e9ad4291mr30761265ad.17.1782734621062;
        Mon, 29 Jun 2026 05:03:41 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9d4822fd8sm34259155ad.66.2026.06.29.05.03.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jun 2026 05:03:40 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
Subject: [PATCH] wifi: mwifiex: bound uAP association event IEs to the event buffer
Date: Mon, 29 Jun 2026 21:03:33 +0900
Message-ID: <20260629120333.94222-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38290-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:kvalo@kernel.org,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skyexpoc@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 535916D9DC3

mwifiex_process_uap_event() handles EVENT_UAP_STA_ASSOC by exposing the
(re)association request IEs that the firmware copies into the event:

	sinfo->assoc_req_ies = &event->data[len];
	len = (u8 *)sinfo->assoc_req_ies - (u8 *)&event->frame_control;
	sinfo->assoc_req_ies_len = le16_to_cpu(event->len) - (u16)len;

event->len is supplied by the device firmware and is never validated,
and the subtraction is unchecked.  assoc_req_ies points into
adapter->event_body[MAX_EVENT_SIZE], a fixed-size array embedded in the
kmalloc()'d struct mwifiex_adapter.

On the ap_11n_enabled path mwifiex_set_sta_ht_cap() walks these IEs with
cfg80211_find_ie(), whose for_each_element() loop dereferences each
element header.  A firmware-reported event->len larger than the bytes
actually received makes assoc_req_ies_len describe IEs that extend past
event_body, so the walk reads out of the adapter slab object -- a
slab-out-of-bounds read (KASAN: slab-out-of-bounds in cfg80211_find_ie).
An event->len smaller than the header instead makes the int subtraction
negative, which wraps to a huge size_t when stored in assoc_req_ies_len.
The same length is handed to cfg80211_new_sta(), so a more modest
over-claim can also copy stale event_body bytes into the
NL80211_CMD_NEW_STATION notification.

A malicious or malfunctioning mwifiex device (USB/SDIO/PCIe) can deliver
such an event while the interface is in AP/uAP mode.

Validate event->len before use: reject a length that underflows the
header or that would place the IEs outside the event_body[] buffer the
event was copied into.  The bound is against event_body[MAX_EVENT_SIZE]
rather than the actually-received length because the transports store the
event differently (USB and SDIO leave the 4-byte event header in
event_skb, PCIe strips it via skb_pull), whereas event_body is the single
fixed buffer all of them copy the event into.  This is the event-path
analogue of the receive-path bounds checks added in commit 119585281617
("wifi: mwifiex: Fix OOB and integer underflow when rx packets").

Fixes: e568634ae7ac ("mwifiex: add AP event handling framework")
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
 .../net/wireless/marvell/mwifiex/uap_event.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 679fdae0f001..adca7da29f0f 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -126,6 +126,24 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 				sinfo->assoc_req_ies = &event->data[len];
 				len = (u8 *)sinfo->assoc_req_ies -
 				      (u8 *)&event->frame_control;
+
+				/*
+				 * event->len is reported by the device firmware and is not
+				 * otherwise validated.  Reject a length that underflows the
+				 * header, or that would place the association request IEs
+				 * outside the fixed-size event_body[] buffer the event was
+				 * copied into; otherwise the IE walk in
+				 * mwifiex_set_sta_ht_cap() reads past event_body and out
+				 * of the adapter slab object.
+				 */
+				if (le16_to_cpu(event->len) < len ||
+				    (u8 *)&event->frame_control + le16_to_cpu(event->len) >
+				    adapter->event_body + MAX_EVENT_SIZE) {
+					mwifiex_dbg(adapter, ERROR,
+						    "invalid STA assoc event length\n");
+					kfree(sinfo);
+					return -1;
+				}
 				sinfo->assoc_req_ies_len =
 					le16_to_cpu(event->len) - (u16)len;
 			}
-- 
2.54.0


