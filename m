Return-Path: <linux-wireless+bounces-35643-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHcINJ9z8mkHrgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35643-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 23:09:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426749A709
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 23:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A82B3032999
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F82765E2;
	Wed, 29 Apr 2026 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp+vSbCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159438550A
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496895; cv=none; b=o0gY1lkDp1b+bOtQ4iAtWuwQnxSkp87sVFz7KWPV7o4kBVj5y/Jw6joHD2sKaxe0eZG/LstjnywzP0LNFgLt6WyNRcR2cQdo/ZpMeczknOtK2cdCj2ctwbc4x8VaDxeS9s1fC/B3LG9qPjUszYGMau8XEz9+uDlzBjctiyzmkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496895; c=relaxed/simple;
	bh=2xn2FE/nipx6Gff92Gc5jRtoymXTKtwUU+/d8mVpNg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZ6LVnTr6YUvgA0Hatb1EErnGtONU7j0hK3kMg9+ofZaFQ9Y7bGFfFF9hb2zDPzBkIayK0lr01INkJ3QU1jcpjr5evx6uLv+AHGMYsqGoRcYXZV37+CE26UdM1xR1Um1cLgbNhgN3A0GO7vJDv7iKX+hm0kdNef/7zMRcWay/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp+vSbCQ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38cc8708d76so2015271fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777496892; x=1778101692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvdwtXe5nVJYgUkU3MFgUxfYGNhWT3fF9Sx6u0vD0Jo=;
        b=Lp+vSbCQXa71pLEsv9ecCVpKkpL44in3dZDqmg9GOONL1j5BEYD1JXJdb8tRJgIVZY
         ENKp5HxbuoKhAWINeQsMszrMDDGD5j+Imfj12VkCsgk/QmMXuLj1hQPsCsGgz3h7RZJS
         QEzgvlqRUoPp0/G3Xwcet6QULvfc73E9yLuH7AEw1iKeXA/YG9UJ3xMkzLZNqQ2G/YAq
         yyOSxV9W5lSTYUc9o5Y85xmi5Zo+LMBFEB0zUrX3rmX5xLVvK+fZVip2gF8cCakTo5a3
         KfVcHX9XrHRg4t+p02asyovoFukIa3hH94v07jRjOLJrgkMe/iR0XS/+R5KToEa6MlfS
         Y+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496892; x=1778101692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvdwtXe5nVJYgUkU3MFgUxfYGNhWT3fF9Sx6u0vD0Jo=;
        b=BkZmmyW/E6ks6zjcZjn59Fyj8IWRfYM/cShcdHfSGatUql4LqjqaI+7ZD1RiX7rvLx
         r06sHOERpYgBDBYGp+Qc847xL6vgT5VVjLaeUMAaa0OzLy+okzswjqaDBZwbU/aNtZ6Y
         uKXo9+98/5PvZ6AIRZNcBm0MY0LB5hA7OvXiit8MXMZxVEtqzuG4gv7zI5umMLwWlf0Y
         Gjr4gckPxFi+5ouSgsnnukn/0Xu9kTmv+bKgWUwh7EpI8tKpNjjY7CQCd4EG9326rLhT
         9mRMgSEdlwcQgCDcvMTdDg8zzwCaN6xJglwsJ+sfEoDgB/H6ZjoGDhels2m+TZevVxYo
         fdgg==
X-Gm-Message-State: AOJu0YxDjuxbTM50R3Ff32REj+buaRNNEbVlrQ3FHMFUlX4VTMf/ISrG
	4CJaJ34OFrO1xAt8nVZfeuRuoGdGlGlefbVdIdpfO4y3cGWL8W9Mwb166LOAHQ==
X-Gm-Gg: AeBDietrZIYZpCa9UHobpOBxyR3fPylf+Chlsv+XzgH71lTYmYmmhPgArltVbePtOSs
	75yL9jeRbNKFWscwGd9pLb4hDdbq+PksmddhPKgXV8oAY34tO+g0TdF5/pt+6jaMQ7Dd0JEcXYI
	CP/tAgMTGkgbrmXASRWnonpvjOgD4hHTsC/yKlsWXY/0j2jGaqB3zVabLbIKhM0OQ1zQdNZStk/
	Cabvv+UaGO7+UQ8D5vJAwUdqj1Icxk2v/6ELt7C+eyqM/RQAk/bkCovwEcyS+KhLut4BohgtL3N
	E9jq5k8PsRTnqpL8hVtRsooSPP/mcgHfgpCmMyAiRldOW/oA0fI3NV/4Zo0rSIaqByoif+DW7t5
	BLBe0YyVv+aGHgrr9aj+CcBWkPKrZDvvAwUnSYAGYbJ93zvejvgryp8ctYm/vgzfxVpDlvCTW38
	bipdHuM8aTurg5zoNFnL2uKzKpx6IIaCaX7Vg8pZKEAd45IiPbAWLXNa5FOwzSwrLFFSZkOQ9Dz
	Ikg5iLtsSQ=
X-Received: by 2002:a05:651c:2108:b0:38e:81e9:bf11 with SMTP id 38308e7fff4ca-3934e5a936dmr720931fa.9.1777496892103;
        Wed, 29 Apr 2026 14:08:12 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi. [2001:99a:a58:9b00:9119:221d:45f0:de83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3934ee25309sm112001fa.30.2026.04.29.14.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:08:10 -0700 (PDT)
From: Maxin John <maxin.john@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v2] iw: Makefile: support out-of-tree builds
Date: Thu, 30 Apr 2026 00:08:08 +0300
Message-ID: <20260429210808.1497335-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3426749A709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-35643-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nl80211-commands.inc:url]

Enable out-of-tree builds for external frameworks like OpenEmbedded,
so the build can run from a separate directory without changing the source tree.

Supports kernel-style out-of-tree builds using: make O=<builddir>

Signed-off-by: Maxin John <maxin.john@gmail.com>
---
Changes in v2:
  - Add support for kernel-style out-of-tree builds using:
      make O=<builddir>
  - Make SRCDIR computation whitespace-safe by switching to realpath
  - Remove ambiguous use of "-I." from CPPFLAGS
---
 Makefile | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 2652fac4e6ee..91961650269d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,29 @@
 MAKEFLAGS += --no-print-directory
 
+# Support building in a separate output directory (O): 'make O=<builddir>'
+SRCDIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
+
+ifneq ($(O),)
+$(shell mkdir -p "$(O)")
+BUILDDIR := $(realpath $(O))
+$(if $(BUILDDIR),,$(error failed to create output directory "$(O)"))
+endif
+
+ifneq ($(words $(subst :, ,$(SRCDIR))),1)
+$(error source path cannot contain spaces or colons: $(SRCDIR))
+endif
+
+ifneq ($(O),)
+_goals := $(or $(MAKECMDGOALS),all)
+.PHONY: sub-make $(_goals)
+$(_goals): sub-make
+	@:
+sub-make:
+	+@$(MAKE) -C $(BUILDDIR) -f $(SRCDIR)/Makefile O= $(_goals)
+else
+VPATH := $(SRCDIR)
+.PHONY: all check clean install
+
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
@@ -20,8 +44,9 @@ CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -D__SANE_USERSPACE_TYPES__
 CFLAGS += $(CFLAGS_EVAL)
 CFLAGS += $(EXTRA_CFLAGS)
+CPPFLAGS += -I$(CURDIR) -I$(SRCDIR)
 
-_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c)))
+_OBJS := $(sort $(patsubst $(SRCDIR)/%.c,%.o,$(wildcard $(SRCDIR)/*.c)))
 VERSION_OBJS := $(filter-out version.o, $(_OBJS))
 OBJS := $(VERSION_OBJS) version.o
 
@@ -93,13 +118,13 @@ endif
 all: $(ALL)
 
 version.c: version.sh $(patsubst %.o,%.c,$(VERSION_OBJS)) nl80211.h iw.h Makefile \
-		$(wildcard .git/index .git/refs/tags)
+		$(wildcard $(SRCDIR)/.git/index $(SRCDIR)/.git/refs/tags)
 	@$(NQ) ' GEN ' $@
-	$(Q)./version.sh $@
+	$(Q)$(SRCDIR)/version.sh $@
 
-nl80211-commands.inc: nl80211.h
+nl80211-commands.inc: $(SRCDIR)/nl80211.h
 	@$(NQ) ' GEN ' $@
-	$(Q)sed 's%^\tNL80211_CMD_%%;t n;d;:n s%^\([^=]*\),.*%\t[NL80211_CMD_\1] = \"\L\1\",%;t;d' nl80211.h | grep -v "reserved" > $@
+	$(Q)sed 's%^\tNL80211_CMD_%%;t n;d;:n s%^\([^=]*\),.*%\t[NL80211_CMD_\1] = \"\L\1\",%;t;d' $< | grep -v "reserved" > $@
 
 %.o: %.c iw.h nl80211.h nl80211-commands.inc
 	@$(NQ) ' CC  ' $@
@@ -112,7 +137,7 @@ iw:	$(OBJS)
 endif
 
 check:
-	$(Q)$(MAKE) all CC="REAL_CC=$(CC) CHECK=\"sparse -Wall\" cgcc"
+	$(Q)$(MAKE) -f $(SRCDIR)/Makefile all CC="REAL_CC=$(CC) CHECK=\"sparse -Wall\" cgcc"
 
 %.gz: %
 	@$(NQ) ' GZIP' $<
@@ -128,3 +153,4 @@ install: iw iw.8.gz
 
 clean:
 	$(Q)rm -f iw *.o *~ *.gz version.c *-stamp nl80211-commands.inc
+endif
-- 
2.47.3


