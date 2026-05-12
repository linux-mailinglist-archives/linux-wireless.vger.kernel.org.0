Return-Path: <linux-wireless+bounces-36275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFY3FJmHAmpXuAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:51:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A976D518777
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A85A307BAB8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCDD29BDB4;
	Tue, 12 May 2026 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9vG7Nlq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AF2874F8
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550301; cv=none; b=KGXEtzwTIHPAguirr9KV5nsU4mHGeSeu9oLrgiLVNdbCqa6d0atrVCtDZGydbsx8VUoAupn9mWvV/adjXXZhUYd0UihkDn2juJNSM/a2tYfoaokN0lYBPj9S7Z7pHzCbA1vQ3YtyccjrEwYaiRP6vPqNNgrvifA8TzQqsAdrc2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550301; c=relaxed/simple;
	bh=CM1/CZ6HdJnVUKbVAC2ZuNemS78xv0T3WdNYnJONcu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZMYOEUcChwzWAXqdajqjtXTHlg0wBkrsmpm5O9oAn4VWgxIZVo36pawrQ8UoGxsBqbNpNdnFK2YQQmzxPr6hm5sONvxReX3S4irVx3oZ8JmgB8reoRZcPxyYGtnXF1HfxwoqaL67mELFppvPRzbVMy5vrKoKoS7A8Cj4lKC2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9vG7Nlq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso8653393eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550300; x=1779155100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zoZ3CghkLfLolXcFlwo+7ShlWPK5OjniN/Ru2vBn9zw=;
        b=O9vG7NlqOekDNLmP3JUnFI2aVVfAq4kSKx6BxEvSeU0InmO45uYMH8koG5wi+Y7ZY7
         DMEqEvxHrqaDPi2d2yJ/UjnBN3ZMjFnCvcCZM3bFPzIVA2RBJbcv64AKIDRbsFvw5IxC
         GhCs5uUfR1uAd7B24oZ0egwaB+zy0mOF2EvY7q/lz3Yn0v+jIVr3H9S5bBMRif+740sd
         OkNVHh7Ubdr+RDdwSeZ6Wgrgy96hbbuKw76a6QBiryksMoQtse41TiDKAbOZVLfeifW+
         i+kPTwPvsWgMvnrEbm98Qxpz5eG7GOr6PycBcDJK3jNGC3pNrZ2XclUdYhMnKI5+RBPy
         a8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550300; x=1779155100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoZ3CghkLfLolXcFlwo+7ShlWPK5OjniN/Ru2vBn9zw=;
        b=B/kk6icyfai2WLz1XB9hW7OlTa+FTCtcLwm+udo8sOPuE0B5kex34ck0WrwRj2QCHP
         x2rwpeQ9aKSzJQH2tPQxwaZRE6WIXuwS2bPbfRXLrLuGamTAShE9jzX/ET5k/X18Kobo
         GZkKqpdU0uUZ2EpGagmYE10ZFwheR/3uc4tc5MZBe7mYmaD260as2sHVW4NiJWpw0jin
         4V66qFV6eMsUcQLXWUU4aO6exuQ7nTLWEZh69rT+KsBQENJVE9ITYObypn2IxCDfzYv7
         UbiS1dcy0QXb7zhboLFmDuRkR2/PcTFNfBMh9c4aRQF1vKkNBlNQyClvTj1U218B9whL
         NXTg==
X-Forwarded-Encrypted: i=1; AFNElJ+HP4qWW/PYslFDB5xl8DbHDnbTo8ThHNAmCgXLNscTXOlsdMURj0FrUD0VZWO3Cm8QLQlc96tF3d89fvwEfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZTKm94xpu81838R93Hhri7aeJW3toVQdhbk+SiwaH5nlFHVF
	oxAKr4+02VT99NKFuDtn9Fk9YBPeji4/BETr2cgBbhcZspASrTcmK70B
X-Gm-Gg: Acq92OEx6F6dd985EzNz3JsAmqAt3njWzZA8AIjl+E5gjd8zziUbPVwht8phTM5Ursi
	mHIEnWYmg60N57gSJUxL9zBwbiIJuoO1htQJ8xJBWQXmgq2TVrF1gGeQZqRhRMil2dGDYCRVa46
	IDshO+unTEcfB+qR0TmbQzr9yqJrXpqRD/T9hxKyvyOd8GiPemJEaOz+wW/e0D4c9yTtuO6SYXV
	12deydTd3in4VtftKol/4H3QERNfoj0vDSZYTxkty4COduAjC2t6IG56q8H9C81vNJfAg1jN5Bp
	ZJwfSv7sIhsoI1L6cvfFmxPj06vZGnYQis2UIAgGD9fjbRrruXYSJX9Oc+Ty783jK0pVNgE1+gr
	8GZtr9btmoTz/Jq6L7gswAgHU0IrEDBG1q2MHK4zItKvLAtru3n+jC4vA2TQNtXYXOXWLE+rVx4
	IMSLHxdVzeGaWi4PljfpAE7JVKexrz9/Lla7owidxG4FDTWdGvQ/ItVTGAaM7+BmeOD82KNT0f5
	IT5g6I=
X-Received: by 2002:a05:7300:478f:b0:2f2:6dde:df53 with SMTP id 5a478bee46e88-2fb4b733e84mr6826603eec.17.1778550299405;
        Mon, 11 May 2026 18:44:59 -0700 (PDT)
Received: from localhost.localdomain ([50.231.3.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm15816499eec.28.2026.05.11.18.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:44:58 -0700 (PDT)
From: Shayaun Nejad <snejad123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shayaun Nejad <snejad123@gmail.com>
Subject: [PATCH 0/2] staging: rtl8723bs: fix two remote frame-handling bugs
Date: Mon, 11 May 2026 18:44:54 -0700
Message-ID: <cover.1778550157.git.snejad123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A976D518777
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-36275-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snejad123@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fix two rtl8723bs receive-side bugs reachable while handling remote
802.11 management frames.

The first patch fixes a use-after-free in validate_80211w_mgmt(),
where decryptor() can release the receive frame and return NULL before
the caller reuses cached pointers into that frame.

The second patch bounds the combined SUPP_RATES and EXT_SUPP_RATES IE
lengths copied from beacon/probe response data into the 16-byte
support_rate[] stack buffer in rtw_check_beacon_data().

Both issues were found by Kuzushi + deep-audit (Sonnet 4.6) and
manually verified against mainline.

Shayaun Nejad (2):
  staging: rtl8723bs: fix use-after-free in validate_80211w_mgmt after
    decryptor()
  staging: rtl8723bs: bound SUPP_RATES IE length in
    rtw_check_beacon_data

 drivers/staging/rtl8723bs/core/rtw_ap.c   | 6 +++++-
 drivers/staging/rtl8723bs/core/rtw_recv.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.43.0

