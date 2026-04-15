Return-Path: <linux-wireless+bounces-34853-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ClFK6AR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34853-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B01E408A98
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC6F3147111
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934B39D6F7;
	Wed, 15 Apr 2026 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9mjYANX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403BE38D6A4
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291870; cv=none; b=NnN/ph8K1MtoZjt4fujgHrDTKapuCiF/5/4AL56UU+km7dnMKBSJrWC2E7RLONAIF09alptugB098RKBRWDgr9fesfvu5obl/wIpaIk6FNRWpS1/S9yIDKxdjOWfuDGlhgl+szCHSbPF0/Oora3aTnuiAUHO4MjnZOohAeOQ7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291870; c=relaxed/simple;
	bh=OIIquYNsbpPzXIEVc0fh/EZXP+sHbiVPU7wTKYd39cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thUKuuS8pII9OXu6BHM62jBOlnhsdl5o1ni/UUwAekfQSsfMstAJ0qq9dLrMQ78/FSzC9piqA4M3QDz+1dNGAggW4UIaA0OdQdtWJHI9FoCclQhI9J6eZ0unV7siWLGfK2lbx57IEZD61gSba1wYmejxh87PkdYQi1mOnzuBeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9mjYANX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so88749805e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291868; x=1776896668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UvqfCfAgGuJWO3zcP6mrlM40Xh9+MbBRmx0d87Lp0E=;
        b=J9mjYANXC9yrDbsJxz2CrlVqx5mSCX1OdiOlq6gFk7aIYahozSw0c4ISzdaOB4fuRz
         WQQ4FKaZylZutNajk8XK44crqvHvExpMBqhHn42JdmM22Rndmn7HAZr9iZEf/pzcnUiy
         ei/7X6vlOKNbDAdw15YbI0es5Uz2YBaavhyTDyuolj3spEXl+5F70HP1xbDl87R22wIZ
         FjrJT0G2zaqexqPQl3tGFY4ilmSVgW2TVeoLuCDUmnYVqIGQ4y4RUbdB4CWx8SElQDV1
         90EwuvEKuKLnekmcc/BZSKCBkN4Ea+QZeR0nfecPwFH+YeqJxxn6cfnm0liddyPV1fzr
         luIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291868; x=1776896668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3UvqfCfAgGuJWO3zcP6mrlM40Xh9+MbBRmx0d87Lp0E=;
        b=Ixd7DIPQLZRuT0jaxuhZnTvvmi+sHjmJQeWhMqXjB6xRq0PtoESHk+dtL0wLyB/WzG
         vjvAJyZ9UykEr/JX+kkMrAajSPBI9lpJcT3aIBWw38jSiUK/arTyC1uF/pWVdzlDZCvd
         1iGwAIjboFPhTRp2irbJ430g6ysJ1oXlv6629SMZKmfXoEoxzjPU65IaaQ+N7AO5O/cQ
         rfjaP1iGGusG1wnMj4D2wxY5zUOlGtkfGTPuHgPZmznGwi+4uzN4rR7KQKV4StnPlrFh
         dvWN+fbGD9MCqScZondlFANh5gIUySFP27Ml1Dugd9lAahMaAAuSg1zkvBmXjWHlK8yL
         UvJA==
X-Gm-Message-State: AOJu0YxP6cCQAmXGPkvnvtk9V37mrvbBVYlRrCFuB3bSM3Yl7GLVEcs8
	zf7CRtMMo6vRFx58URAL1sCF2VKQtVcREeZfWA1ftaMfH66v2m4s3uY=
X-Gm-Gg: AeBDievgnDIyyEDVwu+/r2FlCU4Xjnw3piWroSeeSSi9LmKsGjutg0qZ6GoGAqtuxrY
	lHa9MsKCJ+S+SkFjgRotfe4tclXgOD4yuhnUwSjsMNSytUlcZck0vacye0dip66VQe5JOPQluYf
	Iq1/60GHRp2rbufHC2YB3KBrGgzgivSTcwF8iCkwIGqkNO+WicCvNDfeKGNdJhpMK9LdteELreg
	aePk6wGNokStWZXSB+isonzE+hL4gd+Xzyhae88MKMz9noUv/yk1RLQo4GYSzCzAS/kGgiwxWyW
	KXFu/PYU7JBYomtYmmD/fuqKmunFIbXawCJVTlyT7GbyU9TWMRDsme5/O/zpe5nh3O5STl9+NyE
	9yQyDLaQFNF4N1ge/rUbwaEEy5bt12bCSAAn3zTf4tqEpvcphyaP/uz6MDCgAkEeAuiJ9Bj8bhW
	F+fwQ=
X-Received: by 2002:a05:600c:4504:b0:488:9db9:5235 with SMTP id 5b1f17b1804b1-488d6867c23mr319790915e9.22.1776291867682;
        Wed, 15 Apr 2026 15:24:27 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813954sm1896615e9.3.2026.04.15.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:27 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: b43: fix infinite loop from invalid hardware DMA RX slot
Date: Wed, 15 Apr 2026 22:24:24 +0000
Message-ID: <20260415222425.1544638-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222425.1544638-1-tristmd@gmail.com>
References: <20260415222425.1544638-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34853-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 4B01E408A98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

b43_dma_rx() reads current_slot from hardware via get_current_rxslot().
If the value is >= ring->nr_slots, the B43_WARN_ON only warns but
continues. The for loop then never terminates because next_slot() wraps
modulo nr_slots and can never reach the out-of-range current_slot.

Replace the B43_WARN_ON with an explicit bounds check that returns
early when the hardware reports an invalid slot index.

Fixes: e4d6b7951812 ("[B43]: add mac80211-based driver for modern BCM43xx devices")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/broadcom/b43/dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1693,7 +1693,10 @@ void b43_dma_rx(struct b43_dmaring *ring)
 	B43_WARN_ON(ring->tx);
 	current_slot = ops->get_current_rxslot(ring);
-	B43_WARN_ON(!(current_slot >= 0 && current_slot < ring->nr_slots));
+	if (!(current_slot >= 0 && current_slot < ring->nr_slots)) {
+		B43_WARN_ON(1);
+		return;
+	}

 	slot = ring->current_slot;
 	for (; slot != current_slot; slot = next_slot(ring, slot)) {
--
2.43.0


