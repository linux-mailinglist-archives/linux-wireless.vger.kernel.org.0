Return-Path: <linux-wireless+bounces-38750-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j49oKnnqTGojsAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38750-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:00:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F50571B2AF
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:00:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O6brfJq9;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38750-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38750-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7778030241AC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B133FC5A5;
	Tue,  7 Jul 2026 12:00:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DC3FA5EB
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 12:00:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425604; cv=none; b=QpUcbA43pQ0DqpQsgyeioiSZUQjGI80M1FcCZC7/ejvbi8oySbdDBzg2Cir0/klTzAYf4DW79DDUClr82OflQuvk2VZ8SYg69DQfIVjffrTOHv+sdfXTsw2q3+Eh3uwNaYsxNuErFHrm8wQpxV1y/kayeE9675F3mnow5yIIAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425604; c=relaxed/simple;
	bh=NH8KzkcpA2UkqkGy4ApP5rltY8b6jpgrZrvEARN4Tgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Awf8VhxAuFvdf2Mb2vhKY6sWkfufs9tOSDawMe7M5Ds09Z6oY4rLexvodevcf6J1VWypDEKJHVezI/PED14T7GDnNe23oFleR9my7CR/3gGYQ7LNsSI8K+dQPvCDD/N3OuqZTmpTqq3rPUUVUnDdLCM8pntPcP0AEzoAWDu+iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6brfJq9; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2929269a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783425601; x=1784030401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JrdDA/3Tx7GekjGo23iiSAy0AqP4qNw67v0Rs6Rz9B4=;
        b=O6brfJq9hrxpaP6LxatvKZIXsXc5nTZvc/njRCH1PXdckw7/WhGJK+XQKVZwt1bAr9
         vNFUtvjpd1bbixOD2vXldHvxMoHJMQKR7uCafIPxVMpjvNhR0mLml6xh2BUST5umK/96
         TWJmsOJ8uCxOFyDVMotA+EsoHdnPlzWNZIx01y0hvlCvBssLxJCQysKseX1fRDQuvqpW
         tDy+9/T9VgFXckN0h9eosQJ+uKTqH14+nH0aSsh84RaNEh9GR3F1jFFZXTXs/k1untdu
         VuI9yU++WWiL0YoPl+whmXoCQRZVmNRKu5hJk+WJEyYrJFEQvjF35QZBrx9OfATYJEqt
         /T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783425601; x=1784030401;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrdDA/3Tx7GekjGo23iiSAy0AqP4qNw67v0Rs6Rz9B4=;
        b=jakr7fKpkTsbse7V+rInybsN1skWunf5HCRRSsN/l3gTOfxV0f0MTveq15xnU6bZv0
         wJy5cIioMYTTCgr3h3ul43NTx/fnTIDi2xRBjg5/R6Tb/j5gcBmFV41Exr6iQoLtXYoi
         VXjYlldnaLe/wza6Sc+2DvZSrHHznUN2qCx6pXa70562nu1N28o6Aifw01vmvHvSH5TD
         lS/ywq1Rrb8EyV6+PdMn2g+vC8LaXUpl5bsAVBIPTcnAvgKY6Tl231r9EAq4jE7q0j0k
         y0lU1AVsjhqOPWxFzx8rDDtp1sF9iaX0LJ+vt5vgwlcF54PRWf0+8rHYkGYRpDhG9MtV
         i3/Q==
X-Gm-Message-State: AOJu0YwH1GCT/2pfZaS+7FIq1JIRPk71/2DQXU3TZhzU0zq2pc4K5bdj
	qOR/gTCpN1tzVh69wFrGhoI0lFevH1yeFNvFWlAFX2L0N3u/VuswDlmZ
X-Gm-Gg: AfdE7cnwiQ+kq5CxcfczOagibCEEZgp8mNmUcN1D4YnW18904qAeVD4imqPjhXYPJD8
	ArCzKvqQQc2nhQv0Oh52MV4aVOZNyFe5uHLwJ/wOtXktI5JlqfoTZWMGSCpK1iIEjnOyYF4QHFi
	5UCV0IR5krVnx5EwZO3aHD9HD9AIJyslCM0vNAUMR9FZQWDFzC4lblGQFGfbR+MTHIhPKEpwXEi
	9uah5DU91hCrmlT8JLwqer2/HkRASdxRSQlv495URU+4o4DLVgsxYWbuabEZa1R3R+fmizXwbpD
	6s/IiGZGxJxSgRtxc6Qy6XM9ibWoecY6is6zmzyjSRuP5VZoFeZhZa8+EXojaphRBDC5tMDJ3sl
	xFv5RLzaHAyaNAq/8AnldmBsgvludq0b9ySnpORnnGOkVDUjC/6Zh3HXxFKpLHOJ2LzTlw+c7Ru
	OcKdF5o2b6kKqUI6oMrp5nuRblTj16urd7pXE8NFKc
X-Received: by 2002:a05:6a20:9595:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3c08ee5177emr6231987637.35.1783425601156;
        Tue, 07 Jul 2026 05:00:01 -0700 (PDT)
Received: from localhost.localdomain ([192.197.201.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm7785716eec.2.2026.07.07.04.59.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 05:00:00 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sara Sharon <sara.sharon@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	=?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
Subject: [PATCH v3] wifi: cfg80211: bound element ID read when checking non-inheritance
Date: Tue,  7 Jul 2026 20:59:54 +0900
Message-ID: <20260707115954.21721-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626144543.5034-1-skyexpoc@gmail.com>
References: <20260626144543.5034-1-skyexpoc@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38750-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sara.sharon@intel.com,m:luciano.coelho@intel.com,m:skyexpoc@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F50571B2AF

cfg80211_is_element_inherited() reads the first data octet of the
candidate element (id = elem->data[0]) to look it up in an extension
non-inheritance list. It does so after testing elem->id, but without
verifying that the element actually has a data octet. A zero-length
extension element (WLAN_EID_EXTENSION with length 0) therefore makes it
read one octet past the end of the element.

_ieee802_11_parse_elems_full() runs this check for every element of a
frame once a non-inheritance context exists -- e.g. while parsing a
per-STA profile of a Multi-Link element in a (re)association response,
or a non-transmitted BSS profile -- so a crafted frame from an AP can
trigger a one-octet slab-out-of-bounds read during element parsing:

  BUG: KASAN: slab-out-of-bounds in cfg80211_is_element_inherited
  Read of size 1 ... in net/wireless/scan.c

Return early (treat the element as inherited) when an extension element
carries no data, mirroring the existing handling of empty ID lists.

The bug was found by fuzzing ieee802_11_parse_elems_full() under KASAN.

Fixes: f7dacfb11475 ("cfg80211: support non-inheritance element")
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
Changes in v3:
- Move the version changelog below the --- line and trim the Fixes
  commit id to 12 characters (checkpatch).

Changes in v2:
- Correct the Fixes tag. The unchecked elem->data[0] read was
  introduced in 2019 by f7dacfb11475 ("cfg80211: support
  non-inheritance element") -- the commit that added
  cfg80211_is_element_inherited() -- not by dfd9aa3e7a45, which only
  rewrote the sibling cfg80211_gen_new_ie() and never touched this
  function.

 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 05b7dc6b7..0a44856b1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -205,7 +205,7 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 		return true;

 	if (elem->id == WLAN_EID_EXTENSION) {
-		if (!ext_id_len)
+		if (!ext_id_len || !elem->datalen)
 			return true;
 		loop_len = ext_id_len;
 		list = &non_inherit_elem->data[3 + id_len];
--
2.43.0

