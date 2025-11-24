Return-Path: <linux-wireless+bounces-29285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E33C80D5F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 14:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A65B3436A7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181126FDB2;
	Mon, 24 Nov 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0CaxQpM0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FfQkaUVn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kPHLtjK/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9v2W0yf5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319630ACF7
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992045; cv=none; b=Auip/cg3zphJXSIZ/rvGV3Xu29viNLaLm6b1BUlCvx0/jaGLk2lYjS+PtFTmWi9aNwj5/cb5Og3wl1sl7snA+lTazkIFCRez+KE1phGzVDgvQ4DxY6XjyExjkbxg/45jfPFJSSyHgKw1WGOVX3iocuh4LmxtkGvi09F9uBtj3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992045; c=relaxed/simple;
	bh=cOvad/9gf8rVRemZVb1jojjqXcVWNWO8KgAbi901na0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqB9/3mpzofrOacIRrRq09tj2vzSfDmWutRIWoEy1AFVQbrgzXcVzm4shz1opAhDu5CBMwcfcIgNnFHphUrN/z345eImkAOHPQhLrzjIYONt8e0zufBBm0EflYqzlHqvy5lcMmECUjYL6NVD9vT8pXDAZdIAbzjhBCiClpR2/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0CaxQpM0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FfQkaUVn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kPHLtjK/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9v2W0yf5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFF9D5BFB3;
	Mon, 24 Nov 2025 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763992041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hu3rqTOV07Z4uALBxeFw7U3onLp/b7eW48Jo3HeMsvE=;
	b=0CaxQpM02koMa5b4PS1OekRH+mdROL3buPHnI0wApeUO7COvsn2XvpXEu9NunmwRq6Xzu+
	vSwC34XbS89P6lbwzjCYZ09FgKjzoIIUmwpX1NWn5D6mndOyXRjfPcr/kZ/qnJtmZORluB
	IZUoZBK2l3ylj2MjHVtOPzBwRtioWnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763992041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hu3rqTOV07Z4uALBxeFw7U3onLp/b7eW48Jo3HeMsvE=;
	b=FfQkaUVnRTyzjRFi2bpKXRgD+XpMBgmueWB+K9wpezt/ZbrJPcW8YiRI8HEcxI3c3+kzDh
	2UgfbgPJVwIyeBBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="kPHLtjK/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9v2W0yf5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763992040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hu3rqTOV07Z4uALBxeFw7U3onLp/b7eW48Jo3HeMsvE=;
	b=kPHLtjK/OezWf9oFgPin8xQdOJOAn6/XMAMGbTgqdEmusc37ErWsR3AZuiCd6j1gL9zctY
	DmKdaBSsnTF4gb5GShDgUwVJEoz8298yfVYRZt7YkzeDTOMbrZaHsZVpZaYkmD5XTxhD9+
	Hi+/Vg0SBxqF4McN2pf/IC+evsDugeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763992040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hu3rqTOV07Z4uALBxeFw7U3onLp/b7eW48Jo3HeMsvE=;
	b=9v2W0yf5XlillUk5K3j+mkEApXQNh0gMHNN527hvJMtDPmPM2gJTTewMseYHL7UnFjXKKp
	v2izazYKm0M7fLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5F1F3EA63;
	Mon, 24 Nov 2025 13:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tUNFJ+hhJGmAaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 24 Nov 2025 13:47:20 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
Date: Mon, 24 Nov 2025 14:47:12 +0100
Message-ID: <20251124134713.5819-1-tiwai@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CFF9D5BFB3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

The recent kernels showed a regression wrt suspend/resume on Lenovo
Thinkpad T14s Gen 3 AMD model; it fails to reconnect on resume after a
long time sleep.  The only workaround was to unload/reload the driver
(or reboot).

It seems that this model also requires the similar quirk with
ATH11K_PM_WOW which has been done for other Thinkpad models.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1254181
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

I'm not sure whether this model has another DMI entry, so put Mark to
Cc.

Also, I wonder which Thinkpad models are rather the ones that should
*not* take the quirk.  Since mine is Gen 3 and I already see Gen 2
entries, which else remaining...?


 drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 812686173ac8..3aa78a39394b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -924,6 +924,13 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* T14s G3 AMD */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
+		},
+	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
 		.matches = { /* T14 G4 AMD #1 */
-- 
2.52.0


