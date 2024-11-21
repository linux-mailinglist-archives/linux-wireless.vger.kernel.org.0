Return-Path: <linux-wireless+bounces-15569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A129D5134
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DBE1F24FEE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B4130E27;
	Thu, 21 Nov 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kw8KMGxS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jRTJ3JuV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kw8KMGxS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jRTJ3JuV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722E155CBF;
	Thu, 21 Nov 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208592; cv=none; b=uIhnBcoij9uvCV+fBksOB+hgWICsxEtmvDZro/JsatGxHkUkGo7QqBVnTaaGf06n0paOkbHDELOEMIMULG9g+bNB1XvHHyAkUiqtsK0bqvJhDtSx0YUqcRvUvL3L9Hpe300deCkJPb5FO+FW9HpYL7ktElB4DtTUYmWFxs/CA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208592; c=relaxed/simple;
	bh=ETuVPTT97CvsZzZcWxJfVEpaFVBhNL/nzYNN4iEgBjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWNd83cyCTg5LV50B4v4QFFe4sDK/NjAlkv3OBBYB2Kl5uoVblGBNyGpQVUafuY9Rmwwjnkcv8SYwjVWfzxneT5rqHTXLr4lfZCgkeUDwegJXdI+q7e9CdLmYlUOcfmmJKhPG4QmL4dAWs876iddg66byni6nJojLOOzsxgncM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kw8KMGxS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jRTJ3JuV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kw8KMGxS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jRTJ3JuV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FB2021A21;
	Thu, 21 Nov 2024 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732208589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwG7AxuiiYPfThnC0iA0U1eLd/gFoEF/ZqTxDY6XnZM=;
	b=Kw8KMGxSd9iHLVcbjxO0k/kaet+ldFxW3Zp5PokRSHSso157LOWYBeG6w02BVr/N5mK/Cp
	YpZoAoQ5rmKEvjyScnn4+/EFZITvZVa/1ZJvCYFJ7eV9GFxci2nKMRXVG6tzz6Bx+XOLx4
	jQyDINmGkAQx06TZFw2yKbTZTabpn0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732208589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwG7AxuiiYPfThnC0iA0U1eLd/gFoEF/ZqTxDY6XnZM=;
	b=jRTJ3JuVyho0Qk9wVmQw/Y7QnIisz2f3zbNRj9R/WS6GXlheuJGFqH+Wn+fWR53IFE9+b0
	lo02LO6LOwpp0cBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732208589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwG7AxuiiYPfThnC0iA0U1eLd/gFoEF/ZqTxDY6XnZM=;
	b=Kw8KMGxSd9iHLVcbjxO0k/kaet+ldFxW3Zp5PokRSHSso157LOWYBeG6w02BVr/N5mK/Cp
	YpZoAoQ5rmKEvjyScnn4+/EFZITvZVa/1ZJvCYFJ7eV9GFxci2nKMRXVG6tzz6Bx+XOLx4
	jQyDINmGkAQx06TZFw2yKbTZTabpn0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732208589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fwG7AxuiiYPfThnC0iA0U1eLd/gFoEF/ZqTxDY6XnZM=;
	b=jRTJ3JuVyho0Qk9wVmQw/Y7QnIisz2f3zbNRj9R/WS6GXlheuJGFqH+Wn+fWR53IFE9+b0
	lo02LO6LOwpp0cBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D668137CF;
	Thu, 21 Nov 2024 17:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x2XzI8xnP2eVawAAD6G6ig
	(envelope-from <pperego@suse.de>); Thu, 21 Nov 2024 17:03:08 +0000
From: Paolo Perego <pperego@suse.de>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Paolo Perego <pperego@suse.de>
Subject: [PATCH] drivers:wireless: Fix a dereference before null check issue
Date: Thu, 21 Nov 2024 18:02:57 +0100
Message-ID: <20241121170257.275607-1-pperego@suse.de>
X-Mailer: git-send-email 2.47.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This patch fixes a dereference before null check issue discovered by 
Coverity (CID 1601547)

In iwl_mvm_parse_wowlan_info_notif() routine data is checked against
NULL value at line 2501 but it has been dereferenced three lines before
when calculating sizeof() in an assignment.

Signed-off-by: Paolo Perego <pperego@suse.de>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f85c01e04ebf..f733c16ffd8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2495,8 +2495,7 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 					    struct iwl_wowlan_status_data *status,
 					    u32 len)
 {
-	u32 expected_len = sizeof(*data) +
-		data->num_mlo_link_keys * sizeof(status->mlo_keys[0]);
+	u32 expected_len = 0;
 
 	if (!data) {
 		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
@@ -2504,6 +2503,8 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 		return;
 	}
 
+	expected_len = sizeof(*data) + data->num_mlo_link_keys * sizeof(status->mlo_keys[0]);
+
 	if (len < expected_len) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
-- 
2.47.0


