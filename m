Return-Path: <linux-wireless+bounces-36210-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPkXEh2SAWrsegEAu9opvQ
	(envelope-from <linux-wireless+bounces-36210-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:23:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE350A094
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EC0E3030D61
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560F73B6C1F;
	Mon, 11 May 2026 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+zTVlho"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E03AE704
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486230; cv=none; b=cE5abwz3042FC44sc4K3PFT08fdnucMKWv5Ok1aQ28+doKDaPq9qFMfJrWE+zO09rI/DU+e6WLVrPh+TOsDFYewbFLEc8m0ctEhJnENYex7BOyUibmILrvWAfYHHqGgyxKkkpAAllpxVEvSxjhiiQFdJfrFdTJrjDG4mjxzlH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486230; c=relaxed/simple;
	bh=8fKsYpQ2rofgYvPFqVTqHqV3iwH1OdGnQ3Q0OFMQAZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVMdyZgs+9FgIR45HDySML6SMxqd/zahqTGpXhDckPrKqTyvCFUFlVWl+/Wp7ClU4DDRRuwJTV+dvbR/xvZDpHPQiIdYC9xkVbYtBPn0rFPdDLwtQQHpdvBCdLRzUDpRuZWSefGWIWnBxUXVdOLuL/18hlR2vyPN0kZoO6PJhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+zTVlho; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so2813392b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778486218; x=1779091018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuDIDre46wS+yv63NbwPzOOkKtvuj3ZvNxFH0y1TnKY=;
        b=f+zTVlhokB90lRHfBWoCedoqsBEu9XCTA9heaFXin8XTojburHmH+SIn+JKDuIRw0n
         Y3UrfJP5OGoexgkY5jz3u7jnNoM4/0Bryw8d0Nnpxem21KRPRGoO1ShO6aXdlHwZoGlN
         hafhJZ9WfF09VnVX25ORkuy1iBot5m5o/6d2rCk62h/+pFLLc8ef3QN3yEH0DLRKnBRd
         /iTGAyIFDTibOCIIQM3fcIptWCZ83SbUHQcRFIfFmD/5/pcg7r0443EOO+r/B0OGGXLz
         JSk2oFnAksQKlZNviHDUUOEsvxBYLVt4AylH6ROPUgUykgU4MAME9itgkNRASGa588fT
         DptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486218; x=1779091018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuDIDre46wS+yv63NbwPzOOkKtvuj3ZvNxFH0y1TnKY=;
        b=BWWXYXfntiY0orQN2vdOuWeDLDg9b1yHVjg9ExQRyw7Jpyx7nIKQGujzPI+9klFV2U
         G5/4gCr2l6Y/0fnTQ45lupdM6I7fG86EvfEnLLtni7Z1SWO4KqWPNcDZQyqI6g5eGizB
         8LtuSBT2lMDNDKyprhKaaRyXGKouwh7KBZAk5z2R6IxfTaouHAYolMKAb+v+oGaZ2xrb
         uVGJ9waSMks//QKVDqTdSak6ieQhvBMMtmOYfmhxPJdj3gbZeKIMc9YYEsq0cyrrpLf3
         McYnPxw56E/rA/fDiWA4b1Dl/A9jyCt3LQ9Bj4xOskDM0VG2xj7qAApn4atguu730qzE
         ScJw==
X-Gm-Message-State: AOJu0YxdtRjFrQw8JmYoo6ui2AnhqMTXJZFkvKfMS/TtPOOblu3GvNMd
	bI11JxQiQDcOHzEJK3WkW5Rp248aFmmztO2/ZuZMbxeiRyyucHBHmNDGNnRhbC70
X-Gm-Gg: Acq92OFupJCP0fDDxd0+rS9VkuJShPnz1dpA+mzTRxsXXnpDEPKWzDuct7oDJL3TUAK
	T/nR0/W6McaBw1cAfX22BSLXpfmjxP1YtAIiLoWnPDub/Zmvgd5KvlQoEghd95EQJMGPAxmNsfJ
	mLj1qR/3J59pEb0auZqvwfYUVNrhZ7KzB4TEBJQTFtmkOH1Wd2+HyaXBbVmis1AQBnZpt3vI4BQ
	THgaHzVC9Kpk3qdD3v6TveLloe18Psba9Og9U7cfB05XfB+Kl3XBCv3DJFHAmVwUt3A7Pt73Mqi
	rlksS3CAK+mlplOqld7WTAsGkqx70cX8/56r0qjGRxsMbnwDBoYoMQbfbffsiVEyV/Rm3id9sbI
	4zBS1TSQVP+cnshRavPdrXXuW3o0iNbwrXlBogfSIPUfwWw3k4MqBZ4gXvNMBNuUsM1p8fmpDyE
	D5gyGv6N9g4J15Nv+9c0jTHCfDpGw+cAYmwh6r+/MrOOwGWngQpsWeDAR65bqddcOnWPFrqukif
	qy35x2qYMFk7wbb5iPD74I6zEG26sewxxc=
X-Received: by 2002:a05:6a00:cc1:b0:827:2a07:231d with SMTP id d2e1a72fcca58-83a5c4bfddamr21886438b3a.17.1778486217918;
        Mon, 11 May 2026 00:56:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf36sm23680825b3a.41.2026.05.11.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:56:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Christian Lamparter <chunkeey@googlemail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH wireless-next] wifi: p54: Use flexible array for channel list
Date: Mon, 11 May 2026 00:56:40 -0700
Message-ID: <20260511075640.446181-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1AE350A094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[googlemail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36210-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Store generated channel entries in the p54 channel list allocation
instead of allocating them separately.

This ties the temporary channel entries to the list lifetime, removes a
separate allocation failure path, and lets __counted_by() describe the
array bounds.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/intersil/p54/eeprom.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
index 95580921d933..c617bec787a3 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.c
+++ b/drivers/net/wireless/intersil/p54/eeprom.c
@@ -77,10 +77,10 @@ struct p54_channel_entry {
 };
 
 struct p54_channel_list {
-	struct p54_channel_entry *channels;
 	size_t entries;
 	size_t max_entries;
 	size_t band_channel_num[NUM_NL80211_BANDS];
+	struct p54_channel_entry channels[] __counted_by(max_entries);
 };
 
 static int p54_get_band_from_freq(u16 freq)
@@ -335,24 +335,21 @@ static int p54_generate_channel_lists(struct ieee80211_hw *dev)
 	max_channel_num = max_t(unsigned int, max_channel_num,
 				priv->curve_data->entries);
 
-	list = kzalloc_obj(*list);
+	list = kzalloc_flex(*list, channels, max_channel_num);
 	if (!list) {
 		ret = -ENOMEM;
 		goto free;
 	}
-	priv->chan_num = max_channel_num;
+
+	list->max_entries = max_channel_num;
+
 	priv->survey = kzalloc_objs(struct survey_info, max_channel_num);
 	if (!priv->survey) {
 		ret = -ENOMEM;
 		goto free;
 	}
 
-	list->max_entries = max_channel_num;
-	list->channels = kzalloc_objs(struct p54_channel_entry, max_channel_num);
-	if (!list->channels) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	priv->chan_num = max_channel_num;
 
 	for (i = 0; i < max_channel_num; i++) {
 		if (i < priv->iq_autocal_len) {
@@ -401,10 +398,7 @@ static int p54_generate_channel_lists(struct ieee80211_hw *dev)
 	}
 
 free:
-	if (list) {
-		kfree(list->channels);
-		kfree(list);
-	}
+	kfree(list);
 	if (ret) {
 		kfree(priv->survey);
 		priv->survey = NULL;
-- 
2.54.0


