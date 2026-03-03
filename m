Return-Path: <linux-wireless+bounces-32416-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGYdNCwfp2mYeQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32416-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 18:49:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7B1F4C9E
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 18:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E43EA301E3D0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C607A35836C;
	Tue,  3 Mar 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9K+JVZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3197351C3C;
	Tue,  3 Mar 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560169; cv=none; b=qJPR1GV8QOn3xoKB4OFq6ge0BZZXqq1Z6JVmgPlSnURmR49CSapt7YEOmZIn9JsB8ztMSl1v84mwC3kCar7y8VV4b4vGqEh6oMcfnlW2OrN2cj+FN9gyQjNfcczM7wm0UC203GEzUtiAK3rSfdA1qnfJzuD7PomalkicuBzpJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560169; c=relaxed/simple;
	bh=uHZP9Zc58JPs1zf3ErnShsl9dbMSFMLrjP7EZrcEl/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TrrGPqfo1aY+DPSztdLxltICFPQIIW+Aaqr+KQY+ce3XWvQ5btdDRSv9yAHHyjxja8VMDvSaaUQqee3w4fzYpwzu6R/fi5l0YwYxwiUXF25shp5JjCPM8Cl9npiggKfOgoj2CaSVktIAwS7Qq3SJrFn/Fu4UVp+7j7CbNxGxkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9K+JVZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56003C116C6;
	Tue,  3 Mar 2026 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772560169;
	bh=uHZP9Zc58JPs1zf3ErnShsl9dbMSFMLrjP7EZrcEl/0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=i9K+JVZDPF7kNH7vYeKcStAyYkodl7utZrTRJMWoKZMFqm6gNjFdTeNXkUDxtJal2
	 t8jnFh/X942rI1x8oTPcwwvIy8uS3cSk4FrSeg6P/S1GLluTRzED6zKaVlwrJzIWyo
	 PlINImVWtkja6HPFFXhf+4lP3tC0TBcRNr0ROuHP0utWcW/HDGnqYxa5PUSzxNCVOc
	 puxFuP8iTXicv/DhuNDS39nVl6MAtlhg9XWvh2lGvg6I8LqMm3+FiTv1FRAUKrRsnB
	 cXP7yxZitTy3w3p8T7AkIxckowg5klXBKpQuVLCtddn7BBg8PikfnAi1vEB9iK3LO/
	 VVdIepEiQ2fnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEDEDA697;
	Tue,  3 Mar 2026 17:49:29 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 03 Mar 2026 18:49:25 +0100
Subject: [PATCH] wifi: rtl8xxxu: Mark RTL8188ETV (0bda:0179) as tested
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-rtl8xxx-tested-v1-1-291a38a6ff2f@posteo.net>
X-B4-Tracking: v=1; b=H4sIACQfp2kC/x2MQQqAIBAAvyJ7TihDs74SHTK3WogKV0II/550H
 IaZFxgDIcMgXgj4ENN1FmgqAcs+nxtK8oVB1UrXRmkZ4mFTSjIiR/Sy65u2KGuccVCiO+BK6R+
 OU84fjdymjGAAAAA=
X-Change-ID: 20250625-rtl8xxx-tested-791302586b6b
To: Jes Sorensen <Jes.Sorensen@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772560168; l=954;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Y+HsudM93dZKBpUAqc5IIpt/+w920paNDH5/6c+0JkQ=;
 b=+wfBuV9IGxwlL7qY7wV4hknc0I39+Q6H1FNGDGouOs2tkdepviDwoUVA49LV33IFy2ss4fJwy
 ANJkj5bD2sFAnNShHC2RhLgBqppXCSwjXG16BxflWQ6P/vsCi3gIsI2
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net
X-Rspamd-Queue-Id: 3CB7B1F4C9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32416-lists,linux-wireless=lfdr.de,j.ne.posteo.net];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[j.ne@posteo.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "J. Neuschäfer" <j.ne@posteo.net>

This WiFi chip appears in the "TCU Fernsehfee 3.0" set-top box.
I have tested that it works in WPA2-PSK-CCMP client mode.

Cc: Jes.Sorensen@gmail.com
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 794187d28caa09..b4efc6f00a379a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7703,6 +7703,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	switch (id->idVendor) {
 	case USB_VENDOR_ID_REALTEK:
 		switch(id->idProduct) {
+		case 0x0179:
 		case 0x1724:
 		case 0x8176:
 		case 0x8178:

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20250625-rtl8xxx-tested-791302586b6b

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



