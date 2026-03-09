Return-Path: <linux-wireless+bounces-32734-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJtBELtjrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32734-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:07:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D67BB234174
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E484300DF5E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66E34F257;
	Mon,  9 Mar 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="sA1yVwqL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FB34DCEE
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036464; cv=none; b=RFmi0MM7Ibxv1F2ucQA0VsQ0Rddb19YGUVhyOj7ykGavumUJA0HWaCD8FzV+jG8gujWHk12wGGMC1kaZFww00XGrPen+liMb/nYpdf7E1EXt7dGyYxz6SkudKT1NhYGBAyoXdIgmL0uUOLFN5HJyJSD0Hr+85WPwp9JtS1JC78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036464; c=relaxed/simple;
	bh=FCeNw9YWD/x1Z1iiiL1av2no30ZSiKs3OAPiDqJoqq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yryj27uXP0yE4iOa1wD1eFqnGqDHsywXKRg4RUaXZyW+f9vMq/aJ01UYHDy4X6XDkrh1VI3Dzddv99HtdCFtRWUE88PzOwNMOhwWmVWLZBzbmTJnFeM8C1CIMBwgVEpRR2Ol9N+lNSopeqgzzoGoJlfl3E7XzTL4MMA3WfgEaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=sA1yVwqL; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=L2+xUBBpfnoTqkREqqeW30YyzAJv6BYQqgLxp/9xrLg=; b=sA1yVwqLN55RSnEMRw2iCgcRRz
	QDicUccec1kdms9U2fAjmlpm1Fk3il3O9BZVQuSwTkpoGuF7/hCdzkIlzlt6pEsrBtZ/+Mt20iPqO
	yoPMtp/euYrx1P8oGuj2AW6cJ59YwToTnzbUZ8RyxXk5XGSey/UbQZZFWpD1kvSnuIFc=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmC-00GH43-1b
	for linux-wireless@vger.kernel.org;
	Mon, 09 Mar 2026 07:07:36 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 05/11] wifi: mt76: abort ROC on chanctx changes
Date: Mon,  9 Mar 2026 06:07:24 +0000
Message-ID: <20260309060730.87840-5-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309060730.87840-1-nbd@nbd.name>
References: <20260309060730.87840-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D67BB234174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32734-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.575];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Action: no action

mt76_change_chanctx() calls mt76_phy_update_channel() which switches
the hardware channel. If ROC is active on the same phy, this switches
away from the ROC channel and clears offchannel, but leaves ROC state
intact. Mac80211 still thinks the phy is on the ROC channel.

Abort any active ROC before proceeding, matching the pattern already
used in add, remove, assign, unassign, and switch chanctx functions.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index cfff50892a6e..8d2e72c68c6b 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -88,6 +88,9 @@ void mt76_change_chanctx(struct ieee80211_hw *hw,
 			 IEEE80211_CHANCTX_CHANGE_RADAR)))
 		return;
 
+	if (phy->roc_vif)
+		mt76_abort_roc(phy);
+
 	cancel_delayed_work_sync(&phy->mac_work);
 
 	mutex_lock(&dev->mutex);
-- 
2.51.0


