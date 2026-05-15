Return-Path: <linux-wireless+bounces-36483-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMmsHTISB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36483-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:31:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951654F9A4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 788FB31352AD
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C747DF96;
	Fri, 15 May 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C48BC3qt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859047ECC8
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847149; cv=none; b=UYGQwhkeyp+NRMTIMpqnQcullx4FcpjpiDDB//o8ZKItgBxD73hWW0CjaecZ1d1yAUaB/CK1qSMKk4jzcZS8wVDY623HOOBg0bb36rVdqSA0eEYUlmmHWX1IXguc2nUJkpzIyoH178np6YRkzpcr+sU0gLgbGyoK/XRRmcDSyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847149; c=relaxed/simple;
	bh=nHcMBK6wG0TOu22YqkQZEX4prF+OO2NceKdzMNQ1dEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHkFtTtJOCh0BCCY28ybXMd6QeobABDznlWvZmyVm6I8s74QNkNxt6eXePTKU2MMplr9NLcqxqPggC30eRBkfzDTopzBJv2qEY34KjaXRyY90xIifSTcLCWA5hH9Q4scRYteGlTRhBhVFJ5AktKp8ctyt0UiPJHAvZzgmZNuCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C48BC3qt; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5ad864a6so88930141cf.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847146; x=1779451946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUcmngTs7ey+uIUzuqkXpKib26TeG2lJPiT+fn8FBYQ=;
        b=C48BC3qtQ/OEIcT6iVMy8ZntDBUF4J7uQIHsgV7vRP7+l7C039gUMXoe2zxXsxTfPB
         efexjD9gl7Akx9q8z6Savg0ii+7yBfoyczswGzXDfjR1Ec2GAyTpYRKux4TRubgPSi8R
         4IYjUPqXDm50QzDc2Q9pORCCvrqcaewyuphXPuOAZWjINFskWsiyMLqga7r9K56152wT
         0Uj+uM1gQRVy6ozQYHgZzFzm3SKKeBvntzIyzxdydXJz6wRiWngnvD9cqa6XwwD9RIRI
         v3j+xjCLdEZD718L/uvZ6kwEqls2Jt0zqDAAeiIOkNtS4CLiTm9y/gSxxRTgL3F86dOG
         43HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847146; x=1779451946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUcmngTs7ey+uIUzuqkXpKib26TeG2lJPiT+fn8FBYQ=;
        b=j8SJ2DbQ3RrIkYvmz3yLmSADUPSMnvBaAdJjlWEnYB1pPFsVdAu2N9SES3+XRO4RHu
         VJY9utLhx68Cj77775BXFoWOGZ9GffnH4s7JkSmtpit37Gwz4zdIOHJb9Ci9Xzy3Syig
         QyR/Pvamzj6XAZbLBHZCVa8mpvFmWxpJrxop7WK3JS0mHFayDe54sxXaPM2T8ssnK+yd
         +TadN5t66ThqRgrFR1gV8jLjzntMbigMs99zkbd7Mj9kOViS2YFyGNRgWzWcvfnT9B1i
         Iruf2IIXBh0WHZotkshvaZb4zGUqrPCPVU6bbkb1qDEBNFpFnkvUmvCmeE2vBDWQR2TT
         htfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yz4D3I+G6XAkt7tI4Afj1pAlWAbVUtCFSji1HJ+Nb0u9Ou4eLdKj2AsXVMr2t8sTDfLJPSKxs++H1H+JBkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTkkstowo+pXpyDAvREJ2NY5ESnQ/7poXyzRZ8ZEbk2f/RPs1
	oSdRhAvWwfobtCQWaPBPSlHSBXyvj2sdzuuPkSI6aMJ0xddJK9lhaCl3
X-Gm-Gg: Acq92OFxyAVArsverKJLnBCWRs7dy3UcbNkRNPC/j1Lpl2l68bQi42SBfYI+8mQ2q8l
	AbVAzwJbNrDSsCBODUwFKVV06z8mRvVAu0mNqn6kx7TpomgxxJtEZdQjtioElAmJxNn+7eT0V7D
	8sMELilTxfSVTBH35PVKzSXlnbkap6KwADjKb3MKfkmr5kd/DSFPnGSul1goBkg72EfE1pShSd6
	kUE7Zp24LpRAvdDVgQkbpLdnjrSdB6cJO76Bmh3DdqRdhkfTLk1j8886uTZ3bHjUwfGrRHoeVmU
	zjB6jBcQMyQn4AyWF7yfc4lx14ix1v867ozGkt5u/aVnKdnJe7NbBNYqBdqzJSfQVtqzdzbJvnl
	fRcbzVFKHA3WNfADqB6SpNdhxKjGjdPuc0iHworEB+A5BKdLq1RWqazV2obe6YIFucM/hm3+qBH
	zVoc9bN+Xc7RUvj2nk+hLzYt6Yb3zUmsgyDBYF2CDnqaBPAPeKpwpztQzex8tpTZa1Qa84fr9Gb
	7+J4IS5M5JmH2P/HwUbPLxglytS2Seq27ksHJdCGWM=
X-Received: by 2002:a05:622a:1e89:b0:509:30b0:8323 with SMTP id d75a77b69052e-5165a0a4269mr49097671cf.31.1778847146567;
        Fri, 15 May 2026 05:12:26 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45534491cf.3.2026.05.15.05.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:12:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] wifi: iwlwifi: mvm: clamp set_freqs iteration to n_nd_channels
Date: Fri, 15 May 2026 08:10:58 -0400
Message-ID: <20260515121100.649334-3-michael.bommarito@gmail.com>
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
X-Rspamd-Queue-Id: 0951654F9A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36483-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

iwl_mvm_query_set_freqs() iterates over bit positions
0 .. SCAN_OFFLOAD_MATCHING_CHANNELS_LEN * 8 - 1 (= 0..55 on the v2
path, 0..39 on the v1 path) and, for each set bit, performs:

	match->channels[n_channels++] =
		mvm->nd_channels[i]->center_freq;

without constraining i against mvm->n_nd_channels. The pointer
table mvm->nd_channels is kmemdup()ed at suspend time with
exactly mvm->n_nd_channels entries (whatever the userspace
NL80211_CMD_SET_WOWLAN request supplied as
nd_config->n_channels; typical real-world values are 5..50).
If the firmware response contains any matching_channels[] bit
set at a position >= mvm->n_nd_channels, the indexed load reads
a u8* slot past the end of the pointer-table allocation, then
the immediate ->center_freq dereferences that wild pointer.

The pre-existing caller guard

	if (mvm->n_nd_channels < n_channels)
		continue;

compares the bitmap's popcount to the table length, not the bit
positions to the table length. A bitmap with three set bits at
positions {50, 51, 52} has popcount 3 and passes the guard
unconditionally, then walks 50+ entries off the end of
mvm->nd_channels.

Reproduced under UML+KASAN via a KUnit harness that lifts the
iteration logic. With nd_channels allocated as 5 entries and
matching_channels bits set at positions 7 (immediate redzone)
and 50 (far OOB), the kernel panics on the wild deref:

  Kernel panic - not syncing: Segfault with no mm
  RIP: 0033:set_freqs_buggy.constprop.0+0xc1/0x15e

(The selector 0x0033 in the RIP line is UML's user-mode segment;
under UML, in-kernel code runs in ring 3 on the host. The trap
is a kernel-context page fault on the wild-pointer deref.)

Building drivers/net/wireless/intel/iwlwifi/mvm/d3.o under
x86_64 allmodconfig with the fix applied yields no new warnings.

Clamp the iteration upper bound to min(matching-bits-width,
mvm->n_nd_channels) so high-position bits, however the firmware
emitted them, cannot index past the pointer table. Mirror the
fix for the v1 fallback arm.

Cc: stable@vger.kernel.org
Fixes: 8ed4e659f34c ("iwlwifi: mvm: add channel information to the netdetect notifications")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index c17ac62feec3..b04d8dd26cd0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2514,16 +2514,20 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
 		struct iwl_scan_offload_profile_match *matches =
 			 (void *)results->matches;
+		int max = min_t(int, SCAN_OFFLOAD_MATCHING_CHANNELS_LEN * 8,
+				mvm->n_nd_channels);
 
-		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN * 8; i++)
+		for (i = 0; i < max; i++)
 			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
 				match->channels[n_channels++] =
 					mvm->nd_channels[i]->center_freq;
 	} else {
 		struct iwl_scan_offload_profile_match_v1 *matches =
 			 (void *)results->matches;
+		int max = min_t(int, SCAN_OFFLOAD_MATCHING_CHANNELS_LEN_V1 * 8,
+				mvm->n_nd_channels);
 
-		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN_V1 * 8; i++)
+		for (i = 0; i < max; i++)
 			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
 				match->channels[n_channels++] =
 					mvm->nd_channels[i]->center_freq;
-- 
2.53.0


