Return-Path: <linux-wireless+bounces-29102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29BC6955B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 13:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 572E2350D0E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66F34E755;
	Tue, 18 Nov 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0oHxEhnp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MZW3Tr41";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FoFOhbiI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zxeMvUS9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD22877D7
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467978; cv=none; b=idM+E/CYh3DUc66LOUaUGaYxdemsf/tjX36+P6P/adDUy3jRQtDZSrCVGc/D6fpi3WHbZHPbLbgC2LiJ3gYRqCtLF/2w6/ZSSwALXXRGw5idN/i/EcOanLTYHBjrOOw5PPhl/2B7pjCtR6mGp1b6GaKiGyz6HKU5gdBiy+ko8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467978; c=relaxed/simple;
	bh=R8X8ttS1wqcQgQO7F6Z7yuTK4+dUOlpUKp1B0lvkdUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMJxg1urgpd/D+wCl9cuQcUEcyYfjL907nig7AW9gqARVjrMLJffyypYPZpliDiNCohH9OJ7V1JcAJGNF7Hg86miKF/yTBDQaKmReXkhxLAGLGuq9SBN8WIqpbnVEDzcp/u0W0GbrHkAGhKv13h9Oaih5TykMG4F5bLTng47eeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0oHxEhnp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MZW3Tr41; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FoFOhbiI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zxeMvUS9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 256CC1FE30;
	Tue, 18 Nov 2025 12:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763467975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eB7iFHFuXmPzQhoLKoMNnUNJPEIgMHEzq+xw6CuGlEw=;
	b=0oHxEhnp1UFt020i1yYVFx2CgUOSBZQL2WRXTc6SxpV8b+WlmywgrsMQr1/ZRJ5hzg4qjr
	bWyu1kDw3UNRTFWLhn6GP2LA3wRw+BN3Xzqeq6Ul60LBPdXxD485ynABxFn0b1lv4puLmM
	WrZkZvgM6k0gpdJnOU/EVf4hakyGOus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763467975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eB7iFHFuXmPzQhoLKoMNnUNJPEIgMHEzq+xw6CuGlEw=;
	b=MZW3Tr41pf80SL1sh1CbAEw05Dn6+og1FC1ZYmVPPo2S6iXSC61hkc9rHjrpT6O3Y/MImJ
	DEa/c+zhyEBSpnCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763467974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eB7iFHFuXmPzQhoLKoMNnUNJPEIgMHEzq+xw6CuGlEw=;
	b=FoFOhbiInHAWqNDaGZXlbSYG1qOfcUPhF9n5EqP5jAJ/Mp91Wrt8jypmhlgYcPZLdYVgkb
	QsmsQ2t8zf5sKzNQYVTHJ85cEczdmZibNBaK7esDjBmz1UBnlPmn+kpOYPwsqPBBjEJn6H
	00IHZm3ZOFYg5wMQz0Q6Y6JSjymbYnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763467974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eB7iFHFuXmPzQhoLKoMNnUNJPEIgMHEzq+xw6CuGlEw=;
	b=zxeMvUS9wy/CZTSKNYhKf5au+hfmzLFGyc1jQEcXITbhH8i+iP5ELZxp6thFZM0SkdWVrz
	WXAw8NQbFE9a1DDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 162E43EA61;
	Tue, 18 Nov 2025 12:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DkXbBMZiHGmqegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Nov 2025 12:12:54 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next] wifi: iwlwifi: Add missing firmware info for bz-b0-* models
Date: Tue, 18 Nov 2025 13:12:44 +0100
Message-ID: <20251118121251.149922-1-tiwai@suse.de>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The module firmware info is missing for iwlwifi-bz-b0-* models, which
results in the non-working WiFi on some installers or images.

Add the entries for iwlwifi-bz-b0-fm-c0, iwlwifi-bz-b0-gf-a0 and
iwlwifi-bz-b0-hr-b0.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1252084
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1: https://lore.kernel.org/20251015141307.25305-1-tiwai@suse.de
v1->v2: rebased, apply the change to rf-fm.c

 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index ad2536f53084..b0e8b4af6891 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -8,6 +8,9 @@
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
 #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
 #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
+#define IWL_BZ_B_FM_C_FW_PRE		"iwlwifi-bz-b0-fm-c0"
+#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0"
+#define IWL_BZ_B_HR_B_FW_PRE		"iwlwifi-bz-b0-hr-b0"
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
 
@@ -60,5 +63,8 @@ const char iwl_be401_name[] = "Intel(R) Wi-Fi 7 BE401 320MHz";
 IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_B_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_B_GF_A_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_B_HR_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
 IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
-- 
2.51.1


