Return-Path: <linux-wireless+bounces-14637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A09B4ADA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 14:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EF92846C9
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8585206072;
	Tue, 29 Oct 2024 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEsamKzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4E205ACF
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208150; cv=none; b=T4vwhXOIP+6LE9f8tx9nhBlDczJCxH45YcUobSgqWOzsERD9/CtX0Aez9y0z2V8OXxvQc8aViyFiEj9SDpKrBneGH0KaHTeZoLFvkmD6oQz8VTKI2kIuCygSF65SklycsYnhB8N4LkFWw4OUWjDtMWrvPj+YIAFErNFLe0jkB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208150; c=relaxed/simple;
	bh=ChSlnsIaEJyE5TQiMvP4Xs35+QG7nfcXjtPvtlTkbVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RWct62B+T27XWlDflrUjk+eIGqc8hNfP41Nh1/dMsXank/e/R+I/CrTmeUMb3DF79nswSLQBS6AarOXtHqipSa2xk4SfM0FvY5YXxfJUjmNPHjk/sMY9shKgM5aqG+IJFRx5gtKjeLcYD5pUtiRxQheT6IfkKutgQ7KavioJXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEsamKzE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so4018712f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730208146; x=1730812946; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TmivirZP7oi5XcfMsLlW/n+BvvctncTBddPvnaQEmE8=;
        b=yEsamKzEo/YD9AMmpZ00ZVkOmRdiIb1hx08l4mx3ZBXaN5gGQ+R90Kbv7cqE86fTs7
         SH2w7cgspOWsNEOxir7whZIzFZNrTphRokCpPxQ3AO+0iCnnqDu6TJx5KldBNPNyqLHp
         5cyRhBNV2Eh4JNx95dL/MeW81uiKdpLfjXJPmqvdlKYbgDgsbKxfzX2f/ziFkEbTjxXA
         a7lWk8aUEWqjFWh7g5yWpM0Y5ejQ2WWvAUJENBSKXQaPLODljCATwJ0p2tmlvrPOG+Xs
         AfQ2ctzDIkH2z2ji2giXr4fWgmMHShoUdDNmlPN1p8ojj5Crk6gEiG2kNa18VHF4Qc3k
         KRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208146; x=1730812946;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmivirZP7oi5XcfMsLlW/n+BvvctncTBddPvnaQEmE8=;
        b=n7HPfrK6jpAz8DXg0YJpukf9PQS5XFU15nJgOCbetH4WCGHTmVST6SsD+yqBHsMLcd
         OBVTHlDDN9v9phN0wKj+vr/OwPYVv31yxynbL23x7ev+e1l+3Gc9SFmBeIAbe8A7Xzdb
         E0aAjeMxAkWX1KtAdghXWkUImRAoNanbLNpt+nQZfY7O5+VwwhivHYJ+DTh0H7ss6AHK
         1DU7tGaoySRck3BpJIub3zxi+bLubW0AWgR8pmY2cvMMSier8cpdk95eQA+J19ekvdLN
         JBPCzPu4jnAmy1olAfhYkR7wE+GWWzEh5HsHjCYsYR1ua66bQDTWibvV0yOgklcU2Sza
         gxEw==
X-Gm-Message-State: AOJu0YwzFu1JEQElNQFMGhOoVEzpLJUznyYcUQZBBjpzAm5XEmx6H9eg
	q3khG1rjxlcRJ1Du65wKolpLy7vpXRNHVe4T52FHqIswA3VVvtUJBv07M/rDFA==
X-Google-Smtp-Source: AGHT+IFNju1UNn9Y+9Asqmg8PGyztzLGMJa4AE6L7cP0Oa7tzLJFgRDefug/KVTmU2scx5IEYk1I7A==
X-Received: by 2002:adf:fb48:0:b0:37c:d276:f04 with SMTP id ffacd0b85a97d-3806120086cmr8303886f8f.45.1730208145659;
        Tue, 29 Oct 2024 06:22:25 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b49d20sm12407112f8f.62.2024.10.29.06.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:22:25 -0700 (PDT)
From: Aleksei Vetrov <vvvvvv@google.com>
Date: Tue, 29 Oct 2024 13:22:11 +0000
Subject: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
X-B4-Tracking: v=1; b=H4sIAILhIGcC/52NQQ6CMBBFr0Jm7Zi2VmxccQ9DCC0DNGJLOko0h
 LtbOYKbn7y3+G8FpuSJ4VqskGjx7GPIoA4FuLENA6HvMoMSSkuhDIbJCCVlM7eJqWE3Upe3DWj
 jK3SMWbg7Jez9G93ZaNVraU15gvw4J8p6r93qzKPnZ0yfPb7In/2vs0iUaG2phSVB1l6qIcZho
 qOLD6i3bfsCJRP5IOcAAAA=
X-Change-ID: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org, 
 Aleksei Vetrov <vvvvvv@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730208141; l=1602;
 i=vvvvvv@google.com; s=20241028; h=from:subject:message-id;
 bh=ChSlnsIaEJyE5TQiMvP4Xs35+QG7nfcXjtPvtlTkbVk=;
 b=Og5XeuaTfjSAXJ6W0QqYgXHvcHPaCDcuHiTceteHDnvKLY+bGPJ5jfBwN4DTbliVwXWzJBkkq
 W1Kr/9C8eyBDHA7V8zd4wg2QCycwQogpxb0L1dZtqCxkvYe13MLqh2t
X-Developer-Key: i=vvvvvv@google.com; a=ed25519;
 pk=b4c4Uc4EKDS3ie6P4xhkyobon88ZGFLMHyo8kw1IuM4=

The channels array in the cfg80211_scan_request has a __counted_by
attribute attached to it, which points to the n_channels variable. This
attribute is used in bounds checking, and if it is not set before the
array is filled, then the bounds sanitizer will issue a warning or a
kernel panic if CONFIG_UBSAN_TRAP is set.

This patch sets the size of allocated memory as the initial value for
n_channels. It is updated with the actual number of added elements after
the array is filled.

Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
---
Changes in v2:
- Added Fixes tag and added stable to CC
- Link to v1: https://lore.kernel.org/r/20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d099f7118ab5d5c745905abdea85d246c2b7b2..9b1b9dc5a7eb2a864da7b0212bc6a156b7757a9d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9776,6 +9776,7 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return ERR_PTR(-ENOMEM);
+	request->n_channels = n_channels;
 
 	if (n_ssids)
 		request->ssids = (void *)request +

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863

Best regards,
-- 
Aleksei Vetrov <vvvvvv@google.com>


