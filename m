Return-Path: <linux-wireless+bounces-27797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F76BB63C1
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C293AB13A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEB22259F;
	Fri,  3 Oct 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="14xecNcp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vw88Fs9B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nyCstLD6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cnAYs2Bf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723381E5B72
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759480224; cv=none; b=r2uAn5TGeX1LR6LP5nNVSag7xCgX+Ta6gTuiq2daBWwgVazhMsbA5jaVigRxK0yV5PlPIohFc5nnvRsLWHXb6/BP5yJfleiJ26NKhmel5EE4/3JxH54wND6i1hBpWMjKWiMha7NaE6NmXTQdh0UufoKYhRIzoIoK1OYDx5oPxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759480224; c=relaxed/simple;
	bh=hxiopByHQgebHK/J46wdzxPCHA90vaIrQ7lVkl6QIBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZtbKxJCfTF16zt+nAWBEOPdTqtBCXjYxbdgqu+AUgEnjV0FYyWmcEtO5EZY6TyKoVwglyqSaYraBRrthS1CPS/4H/AxCifvaius6RtuJb4kVXOxB8Da5tollFks6C6aRhZ4OMJOPPfpx7sbeO86IyW+x5/Sjyhyt/3MNql6PbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=14xecNcp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vw88Fs9B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nyCstLD6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cnAYs2Bf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFD023389B;
	Fri,  3 Oct 2025 08:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759480215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VzysZr6w/xIjpP4+Ic7Xq2b1Ypk0eDMeYx2zloqFxuA=;
	b=14xecNcpxAHy1bHacuWxvZOidgRf+l0ExjYSoGFNPFkJYtaLs0jG8/N+jVF5CRtwnW5gWo
	rgA1lhHXJsK0vSgNExsg5pNTmuWKlqZZ/eu4i+fXnf9l6SSAoDzkg8cqmm+qUwYINy1ldL
	BeTmoAzKJx8cVm9vTjyIy6pGjq7kxmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759480215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VzysZr6w/xIjpP4+Ic7Xq2b1Ypk0eDMeYx2zloqFxuA=;
	b=Vw88Fs9BNbrWN9dmzdxAhgd1VOZKPWeqGcBzjSONxDwE2OG8bdek+8AFmzFBYSZ123/X+C
	5zqR68OLH3WaGJCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759480214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VzysZr6w/xIjpP4+Ic7Xq2b1Ypk0eDMeYx2zloqFxuA=;
	b=nyCstLD6KCcAe8PN4AuYuGG+QjTOOEz4UrkLpeyquQRUAcpPXcWCLmfJAXJMWHnwLqmeit
	3Xm0nkBbU58vbBFT3kadNFMlPe9NYKtdTLMGDgFLodPWMZa3xMG64lD6mOQNZjRIbc05Qf
	yqN56mW3qKUcpLPcqhYlEREaUsxTzt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759480214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VzysZr6w/xIjpP4+Ic7Xq2b1Ypk0eDMeYx2zloqFxuA=;
	b=cnAYs2BfR8eMuAar7/1K3hq+wNngrn9I4yLveHbPC0odcMgA28mlLiifAQS489PW/BPehs
	3c/gP+ToFcKORQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD3C813AAD;
	Fri,  3 Oct 2025 08:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rzwkLJaJ32iTcAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 Oct 2025 08:30:14 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH] wifi: ath12k: Add MODULE_FIRMWARE() entries
Date: Fri,  3 Oct 2025 10:29:19 +0200
Message-ID: <20251003082955.11436-1-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Some systems such as live-image or installer require the firmware
information for each module declared by MODULE_FIRMWARE(), which is
currently missing in ath12k driver.

For addressing it, this patch adds the MODULE_FIRMWARE() entries.
Like ath11k driver, we can just put the currently used firmware
entries for QCN9274 and WCN7850 with wildcards.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/ath/ath12k/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index c729d5526c75..48161db6af57 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1871,3 +1871,7 @@ void ath12k_pci_exit(void)
 {
 	pci_unregister_driver(&ath12k_pci_driver);
 }
+
+/* firmware files */
+MODULE_FIRMWARE(ATH12K_FW_DIR "/QCN9274/hw2.0/*");
+MODULE_FIRMWARE(ATH12K_FW_DIR "/WCN7850/hw2.0/*");
-- 
2.50.1


