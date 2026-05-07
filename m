Return-Path: <linux-wireless+bounces-36060-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAnvI89x/GkEQQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36060-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:04:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A724E733C
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05A243001BF2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56654358363;
	Thu,  7 May 2026 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnw1Q3hu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0183C3168EB
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151870; cv=none; b=p/XW1MhT2uw6tdaLLJr2gb4Dd/lgecFhQZrhjrjYBs5mZw+eTe7ZaEENhSpYTzBAXnBeIJOuBLyzWGssw8yfdF/d78sdcnI/dKoA2KEv+sFHkBZt92uLQcZQ41LhtfPHGOhfZ6ITjaJ1x/QsnTl0zkTZcBoyzcjzdKEnSEj+XS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151870; c=relaxed/simple;
	bh=0SGyG17o2tJGzWQ0udzyOUcT09bMtcXqi5lkxseaC4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUFgL56q8m5xKypmWYWrwcafe/E79B/Cfjj8Ol13f1EvOB4FWNQuDO/fwOOxUEuwzJ82AwY9Pv2RuuxMTOFH8nPG9IlylPOcMT3wz02DgW6U/nfg0vH08Evyl9an9dMNby+LlZukAUnulgwxtnYSZDS8YOXz1TGOn8v2TLR75a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnw1Q3hu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-364eef1891dso489949a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151868; x=1778756668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbHKY59I43VJu3Inx5ITaB5XIt+9MgBqVQXP8HKYePo=;
        b=Hnw1Q3huyHTUbxbRFlKpSA06o+Q/8ukNrnjtHoaKw4OGE8i9DpLhYUVqcp8TMA3ZVk
         kDerwMPs+wB8JuusqsYijD6wmCB9DJNFfjgFTLiV5dlxxSkbr1bX13D/KwPlo7GA/FwG
         ce/nLHCIrdJ5eMJw491p4S4qSd1vIYzyjxrCFYqco2v9OMHh8oDnruUpwLk9mc93KLvw
         aqw3j8sLQH8l1EwvSzh+erNdjp7s0SY+7TcKoR21JIvWUwlxqN3qMPBsOgr1lwQPgRDA
         DwCqxV9403CBXh8iabP5MsgwgRB8FXb5iVKIWGZBQe5BEWAYhCgXUhcC2Lkv+pYLITCS
         lEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151868; x=1778756668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbHKY59I43VJu3Inx5ITaB5XIt+9MgBqVQXP8HKYePo=;
        b=VfoHJsMNXsU1edgWWAj8nPhW0Tppl66CF8EiVoHfX9ftEvhtKabWd9ysjUwWfeSMKf
         hHb8ivW6tUotm1Bapr4C5NEdiN7MobinneVtkh/1+eiC3BBQdHuwZbweJU0oU9Cc0TyD
         7XZMfwSiXPQfNIbZSBpUKQVs5SkAghr89526CkQlzANQOF/xIijDaX4QPLftMnM6FuY+
         +gsryq3wmT0DYcmy7wilC5Un8prHR2zwDfQYyv0lyWHqR1rGtV/tb67J0KKYNqEpDFBL
         3NoVB/B0PMw9OS3T8Bst9d4AvGluA2+nRmZrPxz9fXGJEbVktMYqj9weMxhkYxQDXPgH
         wn1A==
X-Forwarded-Encrypted: i=1; AFNElJ8te5eXpLEAkow2LbTJzFBQVFrRqePNcn2rnNnfZknlSNacsyJOMlc2AMz0xw9+2sFpcTd1Uxl/0TWf26Qkgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSeUJ04ilzWFkKbi7or/HD7iW3gDIV7FW/8V7cpa12npbp+7H
	cuZbXTUh+I1y+nFuNhao0A8D9scm4a9hMfd7mw0rHqPHlMoK5d0O0TolJa36yQ==
X-Gm-Gg: AeBDieu+JYqdTqjrZFPPL4paBtjcKZBRV/xeKe9gLJ2oyWakG4w2e0HUq4ld7f2JNRM
	7McpU2fYavP9GphHXjL34dk0mWGveUZg4UqyetFitgX8WIQO3rdJ+9DN0wMr5qyviMpEFc1igwT
	fZFGT5vanjzxdtlKn1hqu0V8T7YxGNPA9lezGoC9jCcFxeb2RLVWFTgd00wzAP3dwhu2svnrPyP
	S0lQEfgP3M2yNzknr34RPrRGzKiauYq/jM6rg/AEPVwHO4+zy0z6TZVnYZ65MRzcg3irjp6awOv
	4ivNIJCSl8KJEa4MEJkxQyNpWSS/KUdCsbmgmVW46SKOSW2+Sswnk8KhmedZRImVjqo+LwL2TR6
	HYeB5kTwWWUT4U7Pja/c9hGKy2grgdPFIigxhN9ZyKcrYBBca3NuRL7JAFGnjzNT2qAtbC1OHAu
	dQzjJbdG6PqX2U3hu6443tD4GL7hOyCe0/UgqCeaG0
X-Received: by 2002:a17:90b:2d4b:b0:366:527:3c9a with SMTP id 98e67ed59e1d1-3660527402bmr2738189a91.15.1778151868319;
        Thu, 07 May 2026 04:04:28 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c28b1asm5720264a91.8.2026.05.07.04.04.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:04:28 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH v3 1/3] lib/string_choices: Add str_alloc_free() helper
Date: Thu,  7 May 2026 19:03:22 +0800
Message-ID: <9663db399276de3ce91a77b8a8be8220132e74a8.1778051552.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778051552.git.jqqlijiazi@gmail.com>
References: <cover.1778051552.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03A724E733C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,transsion.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36060-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jqqlijiazi@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,transsion.com:email,mingzhu.wang:url]
X-Rspamd-Action: no action

Add str_alloc_free() helper to return "alloc" or "free"
string literal depending on the boolean argument. Also add the
inversed variant str_free_alloc().

Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index ee84087d4b26..65f346db95ba 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -17,6 +17,12 @@
 
 #include <linux/types.h>
 
+static inline const char *str_alloc_free(bool v)
+{
+	return v ? "alloc" : "free";
+}
+#define str_free_alloc(v)		str_alloc_free(!(v))
+
 static inline const char *str_assert_deassert(bool v)
 {
 	return v ? "assert" : "deassert";
-- 
2.49.0


