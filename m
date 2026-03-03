Return-Path: <linux-wireless+bounces-32387-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBQJCSrKpmk0TwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32387-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 12:46:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE351EE778
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 12:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73912305149B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA87481FB3;
	Tue,  3 Mar 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WCeFynyV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B1481FCD
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537872; cv=none; b=mPZOjCx6qQQwoDVL3z2wTYebH9XAdzoufeE+kcU5clwTRnV6x2HWhKmFA3IeifrqXgWK9wOkqU+TInjg1jsYQvcbcda58So7QuX9xTW4jKKSurb9WhBoOHPJRFm84pJ5n8NeCdvM+cYXpuB+6aeGuR5my1wHU1co8Z/kIFq2NPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537872; c=relaxed/simple;
	bh=UniZezDxZbXui06KiZ6aGm/Kb9fj3U3kzRe22JM7I6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgNMgzBFLlkw0mXtdeDtmlQ1LCznJxf/eWJkg7NMBgjC5wCcwCJYVuY1CQgxcBnU76CxX7BEEGVD5R104Gii1dpXwYdBUtk/4ukKvIzlB7B0N1Rm4ySscz2swqJlNhLLLphGtTOCe/aJro31HJpZSm8aLaQC7BzkPaL9IW1mUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WCeFynyV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=gneMzFvKkBlXFNBXiRu8Z4Ftalgil3bW0cybToqz074=; t=1772537870; x=1773747470; 
	b=WCeFynyVbDeJPMT/O13CHVL2+lcgQJ/7iyujgxGLLpT8d9GtCN0uW9IWGhvIPI+Q1mD/l+uhHVs
	GQyPqi6NVc8/+6l/bmjgPCuF2S/7gP8cvSEnR1D/goJQHW23hcETHHvxnvUlc7LMok9R1adJiAfa8
	Nlf3EVKAcDaqdAylVDKcf3fuXkLlbqUm9jdN6FtR93h9bTuafpZsiD2EfZ+eO9k/hzGaF2n5yieUT
	pr5uvQogkExlAOxozlx/KKBcX/Ky+LeDfG7a2YLZG3X99/AtYPpvmuHFLN3pw2S7en0Mmvt4Ad+M0
	FEbv1x3d1rVr+B6SSgJkFqTRaGoWGnkRhxzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxO4M-000000074vA-0cSF;
	Tue, 03 Mar 2026 12:37:42 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+c686c6b197d10ff3a749@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: mac80211_hwsim: fully initialise PMSR capabilities
Date: Tue,  3 Mar 2026 12:37:39 +0100
Message-ID: <20260303113739.176403-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ABE351EE778
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32387-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c686c6b197d10ff3a749];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Since the recent additions to PMSR capabilities, it's no longer
sufficient to call parse_pmsr_capa() here since the capabilities
that were added aren't represented/filled by it. Always init the
data to zero to avoid using uninitialized memory.

Fixes: 86c6b6e4d187 ("wifi: nl80211/cfg80211: add new FTM capabilities")
Reported-by: syzbot+c686c6b197d10ff3a749@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/69a67aa3.a70a0220.b118c.000a.GAE@google.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e89173f91637..f6b890dea7e0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6489,7 +6489,7 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_PMSR_SUPPORT]) {
 		struct cfg80211_pmsr_capabilities *pmsr_capa;
 
-		pmsr_capa = kmalloc_obj(*pmsr_capa);
+		pmsr_capa = kzalloc_obj(*pmsr_capa);
 		if (!pmsr_capa) {
 			ret = -ENOMEM;
 			goto out_free;
-- 
2.53.0


