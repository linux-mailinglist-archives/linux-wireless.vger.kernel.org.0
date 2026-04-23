Return-Path: <linux-wireless+bounces-35242-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KzEEUkD6mk/rQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35242-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 13:32:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18BA4514F9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EAAB300D325
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7B524887E;
	Thu, 23 Apr 2026 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYC0/WIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2020B80B
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943920; cv=none; b=Wr/cPNoRSLoxImP+uaD1xDXsradj+tKBXrz0ztgXME53Z63I5hry35nPTY344t5jU45NWaTL+N34kEilfoNfBkS2kLePxMlWqv7NR11EMK6jPCmh99WjmRonEX4ITNGyBnhESfHujeKKNe/AFeGB27+eds4FHtEA/fFJbL79xdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943920; c=relaxed/simple;
	bh=sNqc2IHHGZXE51XM9BY3L2IinRP76AhtsUz627y36/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eb3R+Cc3n/bMAKItkUm/y2/GeoYJsEkAqZDZ0SCmXYmGwVZ/NbZ530hhB4UsHq04hRABnoQutK5PKGBmekbpmfxCcEzbaMXa/Zv0XM6tFm2RsZDL5rhl2+nzfC+0YNE5FCVVhG0F3n6HJVSrCyMRtcr3mvMicoFefzKn1wnKhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYC0/WIt; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dea72099eso6730948e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776943916; x=1777548716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvJx/7YrmzLtOh5FuR6naBRpDEPyldYeuzc2zm3U/2c=;
        b=kYC0/WItnex/YIeipQY2Dw0BiM3c98MlGK6TJX/BgNO0xE46Ib3tD9JWn41ME3tURl
         zXvxVEgPOjSh86KDZ4I/RZAjERBqObvtAWcfhemFpke2/OhHtecrPurFHedEjWAYYoFc
         a/R/qkc/nFSwxvH7a8LhY1eizLPCZVQV1aLdcKkGtYJTdD2xzcvs97hjeZLAUmbo/zAF
         dueLw7RjECora9b4lleOc+0JWZFEUZd6QQMTUv3YnVTeYeln+tiDtlX5siHRSM9VDYBp
         zt4oavIefNPqLVIGHEm0svNh4vHIOZni73PT4A1GszQVb63CvJ/Lkttoj5NZQBwIz+RU
         g/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776943916; x=1777548716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvJx/7YrmzLtOh5FuR6naBRpDEPyldYeuzc2zm3U/2c=;
        b=jmqoV1h3SgW60U/T/SULJDYTVYrFoQi4uRwp4KXbUXdIXvaB6SMLn1LaFm7H82JMUN
         dlMcb4PlfUfjY02MpKviQLM4Z6kNmWqbw3eQeRhsXrXpJXsy8EBrRvzQGR7mpmKZq4if
         HTkOK8JEq2uYcwV3L/q+sG+mkZtM3iYwVNuGI4K8D6fV5MM/7+r/9CSq681VeGJKVstW
         ipjKa3bU/CrS46eqVgcfB5n+B0tWKLDRx4IBaXNrjoLcFUDKJ+yTaIQXaoTspnbDL2F2
         q9RkZZymHQ8MSbZ3AOIx0QlV15CjsW4hPoucZSRZqIvHot82CV5DNwai2XVRfzzLUbN1
         r7rA==
X-Gm-Message-State: AOJu0YybX+tdv5YsjR28lbazPadJOAMBJmwGTIDp8u2471ZDB6n1hoQn
	2qsE0+h3kv9lwgd8DUaEGWujYObLr1kuzJuxa4Z2Is/f0nhkC9rujOt8itfYZg==
X-Gm-Gg: AeBDievbEu88/bLbCxZ1CP34RXJKb05ePPpCwpBSsxyRcleB3AB6ZACy6mYmv31QAcs
	pfi+/MTME3IVs7K3ZU0VwxMkjMLmUQPi7JlTYe07uo2fSrWN1HSai6kntWwRRMV6WQRXWmnMHGP
	3aITKUMgJgFzZKgchZawa9yOs/EjvBJtOfimq3aoaizyUUDShf6qiWiYVKxlvaJC+HJBoQp8HqC
	GCtRHyroyYED3bWP9CPTFMCanwPrEB8CAcYLVRaL7Mh5Q1pwXmLmcWMBMj5Ad+/xlcoUTQ/lbWG
	mfW6YtIDIHZTkwjixGrqeQT26RPGgDmr/wOofeYZGHiQZ7zXMTwchriXPFGqUFuXRJbBYgQ7JUg
	vVJY6fBMGjDojjnt+g+qJWCTsE1Ggs1faNcTDyuJTv6ks6LpOfJ66zRGo/cGzVXw5L0CEpImuXJ
	cNUdSl4afb2y91c+hGTVokJkpcJZ/BoXk23j8qux60zIajunVhLcQEHL3CMw+nn830QQewn0egH
	C+uCCvQi4I=
X-Received: by 2002:a05:6512:234b:b0:5a3:fc79:934 with SMTP id 2adb3069b0e04-5a4172de2b1mr8625353e87.30.1776943916076;
        Thu, 23 Apr 2026 04:31:56 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi. [2001:99a:a58:9b00:9119:221d:45f0:de83])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7b22sm5059394e87.62.2026.04.23.04.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 04:31:55 -0700 (PDT)
From: Maxin John <maxin.john@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH] iw: Makefile: support out-of-tree builds
Date: Thu, 23 Apr 2026 14:31:54 +0300
Message-ID: <20260423113154.1070521-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35242-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxinjohn@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,version.sh:url]
X-Rspamd-Queue-Id: D18BA4514F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable out-of-tree builds without modifying the source tree.
Out-of-tree builds are required by build frameworks such as OpenEmbedded.

Signed-off-by: Maxin John <maxin.john@gmail.com>
---
 Makefile | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 2652fac4e6ee..fbbc3042cd37 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,8 @@
 MAKEFLAGS += --no-print-directory
 
+SRCDIR := $(dir $(lastword $(MAKEFILE_LIST)))
+VPATH := $(SRCDIR)
+
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
@@ -21,7 +24,11 @@ CFLAGS += -D__SANE_USERSPACE_TYPES__
 CFLAGS += $(CFLAGS_EVAL)
 CFLAGS += $(EXTRA_CFLAGS)
 
-_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c)))
+CPPFLAGS += -I$(SRCDIR)
+CPPFLAGS += -I.
+
+_SRCS := $(wildcard $(SRCDIR)/*.c)
+_OBJS := $(sort $(patsubst $(SRCDIR)/%.c,%.o,$(_SRCS)))
 VERSION_OBJS := $(filter-out version.o, $(_OBJS))
 OBJS := $(VERSION_OBJS) version.o
 
@@ -92,16 +99,18 @@ endif
 
 all: $(ALL)
 
-version.c: version.sh $(patsubst %.o,%.c,$(VERSION_OBJS)) nl80211.h iw.h Makefile \
-		$(wildcard .git/index .git/refs/tags)
+version.c: $(SRCDIR)/version.sh \
+	$(patsubst %.o,$(SRCDIR)/%.c,$(VERSION_OBJS)) \
+	$(SRCDIR)/nl80211.h $(SRCDIR)/iw.h $(SRCDIR)/Makefile \
+	$(wildcard $(SRCDIR)/.git/index $(SRCDIR)/.git/refs/tags)
 	@$(NQ) ' GEN ' $@
-	$(Q)./version.sh $@
+	$(Q)$(SRCDIR)/version.sh $@
 
-nl80211-commands.inc: nl80211.h
+nl80211-commands.inc: $(SRCDIR)/nl80211.h
 	@$(NQ) ' GEN ' $@
-	$(Q)sed 's%^\tNL80211_CMD_%%;t n;d;:n s%^\([^=]*\),.*%\t[NL80211_CMD_\1] = \"\L\1\",%;t;d' nl80211.h | grep -v "reserved" > $@
+	$(Q)sed 's%^\tNL80211_CMD_%%;t n;d;:n s%^\([^=]*\),.*%\t[NL80211_CMD_\1] = \"\L\1\",%;t;d' $(SRCDIR)/nl80211.h | grep -v "reserved" > $@
 
-%.o: %.c iw.h nl80211.h nl80211-commands.inc
+%.o: %.c $(SRCDIR)/iw.h $(SRCDIR)/nl80211.h nl80211-commands.inc
 	@$(NQ) ' CC  ' $@
 	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
 
-- 
2.47.3


