Return-Path: <linux-wireless+bounces-33199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPxmMlfZs2mzbgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 10:31:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05428082F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D187831BD3B7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D7382F28;
	Fri, 13 Mar 2026 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRHQxG3L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D537FF69
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393864; cv=none; b=cGS9/p+5tB/vnWTzfsMthlULLU6OEA3qh7YBEjO/5WewnCn3MQemiU9ErtrMX3pCjCR3a9lFdZ1kaJsZx8SYssHFer+1WdGFgnIom0d5ecjBTyA6zHY5t+a3uce45bm8ViF1idRW8tFDEO1eftqeBWrdFYt+DxLIXeslu5/wwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393864; c=relaxed/simple;
	bh=bJtZp/g1t5aRXKT40egBlv1Iw5I5veOn/a0XPTXdUNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LajHNpexqIOjUV63OD2jP92dIf+zA5nLbKLKzPvQJVdcAJViBRkSPUUJwknUlSlNkloYlSvkamL88FxdIcRikzj7Jajr1l+m22ZElcJxM6Od2Pj/AMIPHkGza2L0S2tP90tE55DsXhqsBhj2ooKTqzBM14D/f1kRwW3ZtoZzflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRHQxG3L; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a1dd9c842so750493a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773393863; x=1773998663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+BldRy3ZbXzdECIRaixOoHSFInvXcQLoOU0Hapl1bs=;
        b=nRHQxG3LPk28jGoBWdrlSPoPgkhnAUvegNhHDDdm6YhnmDVAc5JcJaC12XfPgEpwBh
         LOEFGSzkHfCqNOqwnVInTTXPB+Q9/oMBaekC9hQh+/eV/yWeITpWtYuEVR07V6V+ky1C
         y0c87XqBIH7u5p8hNPmlnAvw8UIXaUS+ve1EhueqTfFMvx5psN7LDrMLKriVkO+/YaZr
         i7Innlop+uLZgW5hoyqcDDIFMrh7r4J3JmZqmBcLMW/2kUJ4i7R//YxdsTG44i8FFiLz
         MGvsQF09/hIQeN8ehHKCqlyJpKX/lybzstmO2VAE2XCcJuP0mHUUkMbJ/yvwlmMQbjFK
         Nlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393863; x=1773998663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+BldRy3ZbXzdECIRaixOoHSFInvXcQLoOU0Hapl1bs=;
        b=SRxAmjzqgsct7gFjVsYFPLCO4smcnWBDiaMf4vlxsGUlAne0UcpJzemVC01kTCsGb7
         ljZBROcasHgMjRLQnPe1VrgnCe1Rr9OXdoaC9El4YNnRStmwcUS1Z6EcRzvJY96KA2kq
         f+dFpkZKZz6nbx5pU9NvJybv0szDFlXONc/B7NrQGI1i3RsC2Z1TdPxgI6hftOFDa6U6
         YtvRGg+3YjDhgbkAXp9+gGP3N5+bk/lqcXQwpILlmjCTgB6tOv7P+3p/NZeZpPHuH3zm
         NDuzyHYVoQcNYSUulas6/OTNwkq5dv/wsSTbvatcK9tReTXvOAq+z5GME7a1MsME5dyn
         Lyxg==
X-Gm-Message-State: AOJu0YyhgMfwMPPcJ+kfj9y3f/kiK/AstOBxmRP5sVlipUkMHLifaTgr
	u+l71bwUGwUo3WoFegwPYVxZOQRnio/rrn6Vliy4GeYGUClzgZ8syX0Q
X-Gm-Gg: ATEYQzzmuelgye2KvI7q3+SKY8Uf9XMc2AnzUBMkQ9lxVIo3azX86LrHRoYpPIqLIOE
	1ZW9tyh/ra5fVlvl6fUDg01CL2gpcZgaWUFtNxHqZn6DY+hV0CeE2wT91fogwDgzdUUldj/DPYq
	FkjBICLZ992PnDYVA/bX5eFTYzkKoog/FYZw5PNnzJKLhOgAecuLYZtsFpJ/FERAhzkRR9BTEkB
	NgQrigeu3NfUq8Z7IbRZZsI8Qr9xJqeuoLqgXzSy0M++UDLSoKxfAKWpbZCyMJ2OzUS6gCwg04d
	933ykUHrN8nvG7I/1WJnQEeg4q9F2CKYffstq9RqLCxVAF9855dIeJI7y6qK6ZXbZy0I3//KctO
	+ZGfIg5vikuWWYm1cGCsYaTOyVlG/soQ+1JUP9ypivORqf/oL6fnpPT31xytkyx59aDdO7Um478
	+9PI2aTZIgIakCWSfxufRuvYFiRSp1yH3PiTHIPJuOdswnnsq2KwlqqqF92vcpt96il0rel4hbB
	ve85/6eUdNIX8GLdQ==
X-Received: by 2002:a17:90b:498d:b0:34a:8c77:d37b with SMTP id 98e67ed59e1d1-35a21fed5f1mr2440302a91.16.1773393863101;
        Fri, 13 Mar 2026 02:24:23 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:e777:51d4:3ebd:b21d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0f6d190csm6196259a91.14.2026.03.13.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 02:24:22 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Subject: [PATCH v2] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Fri, 13 Mar 2026 14:54:17 +0530
Message-ID: <20260313092417.520807-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33199-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,56b6a844a4ea74487b7b];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,sipsolutions.net:email]
X-Rspamd-Queue-Id: 2E05428082F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When NL80211_TDLS_ENABLE_LINK is called, the code only checks if the
station exists but not whether it is actually a TDLS station. This
allows the operation to proceed for non-TDLS stations, causing
unintended side effects like modifying channel context and HT
protection before failing.

Add a check for sta->sta.tdls early in the ENABLE_LINK case, before
any side effects occur, to ensure the operation is only allowed for
actual TDLS peers.

Reported-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=56b6a844a4ea74487b7b
Tested-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Instead of replacing WARN_ON_ONCE with tdls_peer address check,
    add early check for sta->sta.tdls flag before any side effects
    occur, as suggested by Johannes Berg.
---
 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index dbbfe2d6842f..1dca2fae05a5 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1449,7 +1449,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 		}
 
 		sta = sta_info_get(sdata, peer);
-		if (!sta)
+		if (!sta || !sta->sta.tdls)
 			return -ENOLINK;
 
 		iee80211_tdls_recalc_chanctx(sdata, sta);
-- 
2.43.0



