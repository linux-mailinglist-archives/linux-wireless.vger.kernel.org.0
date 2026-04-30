Return-Path: <linux-wireless+bounces-35721-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCXyCASV82m35AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35721-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 19:44:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D5B4A68DF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 19:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2853230028BE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4558449ECA;
	Thu, 30 Apr 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RiVAYPsm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3344BC8E
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571073; cv=none; b=BKUkKQbNP7t77qfcAfBnNoRnSk8qPCh0fVJ752vxltc+CLDDHVX6+3qbQwDjEXQpNAzvLYQHw039Fhabqqv8SjhI+WPPYIm4x3C9MO8wOpalsOnp1v9oU5ap9azqw6zo5AoIo0a4Qg+Nj+Wj06uOC+fIEhHrOEVm7X7zJUnxHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571073; c=relaxed/simple;
	bh=fazZ074G9rAIz9AX5nhIFO+Bzp/EdU5S4aYSd7VZ4a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4O0ZvfGN2le47ZT2mtMC4FXbQWPn/YKKckxN0sKAnpfGnknciZzyzclDKmyuCZz+7lJ05GbU4Z09i1EdkmTeagDPZDYFDCZoY/RC9OeCXB58oi9iVo+jOhuQAwxSG8qT7V1ABT3xxqXZU4oECwpB2TJmrmv63oui8qEk6ZWQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RiVAYPsm; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g61l369Cvz1XM6JS;
	Thu, 30 Apr 2026 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1777571068; x=1780163069; bh=glASWuYUbNvY/5xnloOKysvZzxBobd2zdzJ
	yMqbPJRc=; b=RiVAYPsmBeT5M0MSK106KAjyXfrQiOr/9IcTbKYg7L8aKYi94Q7
	smmSUglmsHUHxpyR3i0PY8UpK0ki3vDXo3Pu8yyUe6OCA3fD0KnLr1BAuCjfh0sd
	wTdB26XYfPoSnBlJhLSZgrvrfvLHq987GqCT29yqPrqzQT+PG7I+SYDYM78DwN/7
	DkVZ4/4ycUOEh1SosiZP9eHg3IcjF6oDUupM3S8NZa6j9q+ysbfaDljvFJsIh22N
	m04RhgOcvBfSuwwtvNUXXOoAdCQh7trg479OBQriOMkqaQoj+dkGzdlYj7sqUDSn
	X85iIxDQ8KIB5n9V7U9Sfjw4uRYvwHI967g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6qsgm4FTpE9i; Thu, 30 Apr 2026 17:44:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g61kz5yyPz1XM31H;
	Thu, 30 Apr 2026 17:44:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] wifi: cw1200: Revert "Fix locking in error paths"
Date: Thu, 30 Apr 2026 10:44:15 -0700
Message-ID: <20260430174418.1845431-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B0D5B4A68DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35721-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,decadent.org.uk:email]

Revert commit d98c24617a83 ("wifi: cw1200: Fix locking in error paths")
because it introduces a locking bug instead of fixing a locking bug.
cw1200_wow_resume() unlocks priv->conf_mutex. Hence, adding
mutex_unlock(&priv->conf_mutex) just after cw1200_wow_resume() is wrong.

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Closes: https://lore.kernel.org/all/408661f69f263266b028713e1412ba36d457e=
63d.camel@decadent.org.uk/
Fixes: d98c24617a83 ("wifi: cw1200: Fix locking in error paths")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/wireless/st/cw1200/pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/pm.c b/drivers/net/wireless/s=
t/cw1200/pm.c
index 84eb15d729c7..120f0379f81d 100644
--- a/drivers/net/wireless/st/cw1200/pm.c
+++ b/drivers/net/wireless/st/cw1200/pm.c
@@ -264,14 +264,12 @@ int cw1200_wow_suspend(struct ieee80211_hw *hw, str=
uct cfg80211_wowlan *wowlan)
 		wiphy_err(priv->hw->wiphy,
 			  "PM request failed: %d. WoW is disabled.\n", ret);
 		cw1200_wow_resume(hw);
-		mutex_unlock(&priv->conf_mutex);
 		return -EBUSY;
 	}
=20
 	/* Force resume if event is coming from the device. */
 	if (atomic_read(&priv->bh_rx)) {
 		cw1200_wow_resume(hw);
-		mutex_unlock(&priv->conf_mutex);
 		return -EAGAIN;
 	}
=20

