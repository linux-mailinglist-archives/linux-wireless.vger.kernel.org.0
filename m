Return-Path: <linux-wireless+bounces-36485-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE3VAOsVB2plrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36485-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:47:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097054FE24
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9728320F565
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7598B480DC2;
	Fri, 15 May 2026 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLVrDdNX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979C48033C
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847152; cv=none; b=kk+IFn/txXTXMpVv0TEX3CMc9Yehl9JvhBqCtd7Ge4YogKek/ft/IoGjmxY27W80LEgnhlDSDe4dXZZzm7mwxl2uOGccTssl21UgSXrfbb2PyQyaW1KEx73WESA6FexG2C+C21nU7eK4ONjb5dm/El5KzGCYDw2CqBKbuCHhEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847152; c=relaxed/simple;
	bh=C8otXdXqe2mbvIpCi+y4ZxuYrmyZ1+jVBFbLm5wowDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOJtCRQd8N72niAmhat5CDilqU874dxKdZHvrsZpMbAw2deIBx7UJIGOA9YuXIQ0uNG6vVrOakaoUF5EKbTNFN0vLBRj9Sbm8f19RMjKn79G4fYUn5GHx6CifzfHrZJmjM4IyvZ7LCeS0KxAsB896YXodrNzZqTnvLsaY3ONk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLVrDdNX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fbd79350dso83838691cf.3
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847149; x=1779451949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R2gnYRUyTuipxUzgFJAVrQVtPiXN+G/kZsPRoJVzxw=;
        b=JLVrDdNXWVnw8mdwabCQzQY/4yzdEe7Wq9M/r7OvqmAoDswWkrPmZgJ/eq4xR6Azqk
         F0iM9QhAKRd3BOERQ/clHXPpweXKNDZBMtm43KeOARgvddhgTukiQ9sz/2XiZp5QW/g4
         d3YVoVRE8YivAUeb4ElwJiDHVN3oJXJ2XodcPR5bm5I6RURcMwR+eO8XEtD3m1BpdkJc
         oIBv53wiCeRLuEugnudSa5bOe0D7csa3PVgsOwHM75Rw3zrAMlOwD1IvrscZUDyYQWpn
         uWBVBrPloaGw80rwxNGd7Nunh1qZUm2I62kD66o+52uwj9HcajcM14kyF1UdrNCxHsE8
         JDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847149; x=1779451949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R2gnYRUyTuipxUzgFJAVrQVtPiXN+G/kZsPRoJVzxw=;
        b=J4OKTIsZoNkJDpJ/RJ8UwVoyhKb+wHHPw3NdGG1p6iSbFSdOJl/ovCrjaZjZdcQY6f
         IzOyp/VWOppsVOzltAjZTEAhDOd7qzjHJA1SLlq52yvJZ2lfGm/FEOvAfdcRQa844N+o
         +I/rtWDrC7mBxcUGxQps9MfUnO6oo2xSEx5JIhEETHKRJLOHJ1sdBV12xw9inL0NfjIK
         /XW/A69njthbQZqhlitOhtsnXEGa93Ir5ItQ12Z4buvS2PesbML1A84ksYWqT8HKeAam
         jtJgDu/voGqjbZxXYFqXhDJkLmAcJYCIBofkxTjX8IfGLJ1NpItxLI9F+vLWWDd2n7Kq
         yPKg==
X-Forwarded-Encrypted: i=1; AFNElJ/50w012I9Zb8Inx8JtlzA9OLVCYyqmQb/AN9F/LflZROZCb+vBE0cUedLLp7ENVz8vNWQ2RxhVzLOAx87Udw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtJeYjJU4prhovg34h2yq5mR6d6nbmeRWs7ZgHGIcaOfZqUkc
	R0grz0rknqtaVUGYAg/oUXsqiErcMg0Dg2iyzbnNDtYvoSoPxrFhvbbL
X-Gm-Gg: Acq92OHhSVgjFaLv87qTZL0lQXlNIC9AtQ9MS8oG77i67MifNjeG26nGfSV2AgqYDkf
	nkUMUVX3aLvMAMXVAD1BRYLQZEXPeIDLtIVJ7jINbiuONAwCz3zH1/CB2bexedZRElNNQ/C8Txj
	C+kbrmEx6f/IfWNME986JoLEaLmh/4fAVW99+1N6DpKmfThphNNRePlnSW7Hza1TzfZoYmJ1ubs
	6XdR2h+n52WlrEk3thT+MGJwI7ftHJFVPTK9p+iwlxJRAudAK4RFx5cjRqaN9CvI3uTw+mCvKv1
	cAYEOQRt6siOaINEMrQ/AZT19o6QVSnUWyZOHDvFQE78FEzaLUM6rGAFMsjMli52nupo1upyVYv
	6PhHeh3Ii4rxok+gechHsKKfI82zGXg9wcDtnXXfVIO3WNp+/KJFxLnNTc512SKFD4xzTmdWigm
	m/m4l2XGbx0CKdTM7fmpyrK6VM3veyV10UcGzk64hx6k84hnir+A6gmMeESr0G+2vnCefZXfZ6L
	ra8e92u19D062Re58fEXrmqV6N94PrJxZXueu8dOGzw8ZKP1Om3IQ==
X-Received: by 2002:ac8:5703:0:b0:510:1b61:d0e4 with SMTP id d75a77b69052e-5165a0e34ffmr47763431cf.35.1778847148790;
        Fri, 15 May 2026 05:12:28 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45534491cf.3.2026.05.15.05.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:12:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] wifi: iwlwifi: mld: clamp netdetect channel iteration to n_channels
Date: Fri, 15 May 2026 08:11:00 -0400
Message-ID: <20260515121100.649334-5-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515121100.649334-1-michael.bommarito@gmail.com>
References: <20260515121100.649334-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5097054FE24
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36485-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

iwl_mld_set_netdetect_info() walks the per-match matching_channels[]
bitmap and emits one center_freq per set bit by indexing
netdetect_cfg->channels[]:

	for_each_set_bit(j,
			 (unsigned long *)&matches[i].matching_channels[0],
			 sizeof(matches[i].matching_channels)) {
		match->channels[match->n_channels] =
			netdetect_cfg->channels[j]->center_freq;
		match->n_channels++;
	}

Two problems here.

First, the third argument to for_each_set_bit(bit, addr, size) is
the number of BITS to walk, not bytes.
sizeof(matches[i].matching_channels) is
SCAN_OFFLOAD_MATCHING_CHANNELS_LEN = 7 BYTES, so the macro only
visits j = 0..6 and silently misses bits 7..55 of the 56-bit
bitmap. This is a functional defect (per-match channel reporting
is truncated to the first 7 entries of the bitmap).

Second, the loop body indexes netdetect_cfg->channels[j] without
bounding j against netdetect_cfg->n_channels. netdetect_cfg
->channels is a kmemdup()'ed array of pointers sized at exactly
n_channels entries (the user's WoWLAN net-detect channel list).
If n_channels < 7 (a 2.4 GHz only configuration, or a small saved-
SSID channel allowlist) and the firmware sets a match bit at any
position in [n_channels, 6], the indexed load reads past the end
of the allocation, and ->center_freq then dereferences whatever
that wild pointer fetched.

Reproduced under UML+KASAN via a KUnit harness that lifts the
iteration logic. With netdetect_cfg->channels sized at 5 entries
and matching_channels bit 5 set, the kernel panics on the wild
deref:

  Kernel panic - not syncing: Segfault with no mm
  RIP: 0033:mld_set_freqs_buggy.constprop.0+0x116/0x1c2

(The selector 0x0033 is UML's user-mode segment; under UML,
in-kernel code runs in ring 3 on the host. The trap is a
kernel-context page fault on the wild-pointer deref.)

Building drivers/net/wireless/intel/iwlwifi/mld/d3.o under
x86_64 allmodconfig with the fix applied yields no new warnings.

Rewrite the iteration as an explicit indexed loop with an upper
bound of min(bitmap-width-in-bits, n_channels). This addresses
both issues in one step: bits-correct iteration over the bitmap,
and a hard clamp against the channels-table length. Address the
two together because applying only the bits-correct iteration
without the clamp would widen the OOB exposure from j < 7 to
j < 56.

A short comment is added because the clamp's purpose (avoiding an
OOB pointer fetch from netdetect_cfg->channels) is not obvious
from the expression alone, and a future reader could otherwise
"simplify" the bound back to the underlying constant.

Cc: stable@vger.kernel.org
Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index e89ec531cb06..51abf414bb1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1165,7 +1165,7 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 
 	for_each_set_bit(i, &matched_profiles, netdetect_cfg->n_match_sets) {
 		struct cfg80211_wowlan_nd_match *match;
-		int idx, j, n_channels = 0;
+		int idx, j, max, n_channels = 0;
 		struct iwl_scan_offload_profile_match *matches =
 			(void *)netdetect_res->matches;
 
@@ -1192,9 +1192,19 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 		if (netdetect_cfg->n_channels < n_channels)
 			continue;
 
-		for_each_set_bit(j,
-				 (unsigned long *)&matches[i].matching_channels[0],
-				 sizeof(matches[i].matching_channels)) {
+		/* Clamp bit-index iteration to the channels table length:
+		 * a firmware-set bit past n_channels would otherwise index
+		 * past the kmemdup'd netdetect_cfg->channels[] allocation.
+		 */
+		max = min_t(int, BITS_PER_BYTE *
+			    sizeof(matches[i].matching_channels),
+			    netdetect_cfg->n_channels);
+
+		for (j = 0; j < max; j++) {
+			if (!(matches[i].matching_channels[j / BITS_PER_BYTE] &
+			      BIT(j % BITS_PER_BYTE)))
+				continue;
+
 			match->channels[match->n_channels] =
 				netdetect_cfg->channels[j]->center_freq;
 			match->n_channels++;
-- 
2.53.0


