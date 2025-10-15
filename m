Return-Path: <linux-wireless+bounces-27980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDFBDEF35
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 16:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775EC4809C8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BDE248F78;
	Wed, 15 Oct 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A5BGauFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oaAO6cAR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A5BGauFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oaAO6cAR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC020E023
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537598; cv=none; b=iTwrX+NCQkOXyKeRtA3BV8Ab6ujyUWQVDAv5eh/6zd8mCmBQClJacjha6gMfyU7eAoaQH4V8YnRYsT8Gx8SFyBZKR7PK7nyiqE37oDQhY/22rszAaBjvvBYsIGl49xEYsYKH3pDyvmJMHhl9Jne68C5By2A1FXD6a0pzcGyud9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537598; c=relaxed/simple;
	bh=6fyfdOsj96w60vhQza4bU5d2I+dvo5/dNO+MVZ3asrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fy2w0C/7NBiqI0tLc5qDn2eph7oPKgYEA2Zxk39Frf3hU+F/eeYjGHwQur6VKIVV0y111RW2ODlEDJXrP2qxxTXxK2Jj6EShhfLoBMr9VBxwK5qciAoIFRBzd+naIygHA2jYLNJMIADnQfqsUdB9VZOi6usfNYGCgsExN/3uWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A5BGauFE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oaAO6cAR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A5BGauFE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oaAO6cAR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3E452103A;
	Wed, 15 Oct 2025 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760537594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I39x4Kk6E6hSPen6AlSwzizFz0ehaSkqkpXQcL3JNBo=;
	b=A5BGauFEai+GIXPtF1znQ7FVO+ZsuMWpA38BOXjXfvDcKZaUruG/QRskWYtPFS7ZDzbl+6
	bOa/WumA1t/bA3Z32yp+uxl5xLQb1j8r1OD8v8ZV2dVNEizGE/hV80OUmOyNnA5DQUyvPp
	c/78vWl+ofeXo8ZFqSW8sO6itlq2U64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760537594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I39x4Kk6E6hSPen6AlSwzizFz0ehaSkqkpXQcL3JNBo=;
	b=oaAO6cARIfDZtcR+fZ3Nqsp0+kqoclZpx1Z0jj2zLYu9j8eiYF/wSwHG2lixmErEESpkbF
	mMxs3qLt6TVSzICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760537594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I39x4Kk6E6hSPen6AlSwzizFz0ehaSkqkpXQcL3JNBo=;
	b=A5BGauFEai+GIXPtF1znQ7FVO+ZsuMWpA38BOXjXfvDcKZaUruG/QRskWYtPFS7ZDzbl+6
	bOa/WumA1t/bA3Z32yp+uxl5xLQb1j8r1OD8v8ZV2dVNEizGE/hV80OUmOyNnA5DQUyvPp
	c/78vWl+ofeXo8ZFqSW8sO6itlq2U64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760537594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I39x4Kk6E6hSPen6AlSwzizFz0ehaSkqkpXQcL3JNBo=;
	b=oaAO6cARIfDZtcR+fZ3Nqsp0+kqoclZpx1Z0jj2zLYu9j8eiYF/wSwHG2lixmErEESpkbF
	mMxs3qLt6TVSzICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F03013A42;
	Wed, 15 Oct 2025 14:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GQgAJfqr72h2dwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 15 Oct 2025 14:13:14 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: Add missing firmware info for bz-b0-* models
Date: Wed, 15 Oct 2025 16:12:56 +0200
Message-ID: <20251015141307.25305-1-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:url];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The module firmware info is missing for iwlwifi-bz-b0-* models, which
results in the non-working WiFi on some installers or images.

Add the entries for iwlwifi-bz-b0-fm-c0, iwlwifi-bz-b0-gf-a0 and
iwlwifi-bz-b0-hr-b0.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1252084
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 3e6206e739f6..44a00acce81f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -22,6 +22,9 @@
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
 #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
 #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
+#define IWL_BZ_B_FM_C_FW_PRE		"iwlwifi-bz-b0-fm-c0"
+#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0"
+#define IWL_BZ_B_HR_B_FW_PRE		"iwlwifi-bz-b0-hr-b0"
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
 
@@ -104,5 +107,8 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_B_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_B_GF_A_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_B_HR_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-- 
2.50.1


