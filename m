Return-Path: <linux-wireless+bounces-32737-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKp+G9NjrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32737-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232E234190
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 909B0303BB00
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8262734E75D;
	Mon,  9 Mar 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="BjGcQJGm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1634E750
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036465; cv=none; b=RydGQVj/WGt+YNmtRq6mBJvAlmdcasNMJ8xU1nfagGvN0aQyex+FVU10tlJw76oNuPWzbpWJ35row1R+F87BQLvimvPNmJt+ED30jpusw1SnZpJLTt1RznyO8Vt96aizOtuDuK5onvkFLNPUOHT2sWKHABPScY/G6nP/gfP1wEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036465; c=relaxed/simple;
	bh=iRyhEPC5NeeguVCpXZKahYcGUI3gsglqkcaIewSKNUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tgre/TIH5fM2Ni4dNZc2UrB1b5WcuPcE7sQymDFWDH44RB6YCFDkzPLxG6qgymeLnszK0sx3KuCDxMosLkYTMAMzWpxJPDSKZGdij2w6+Lx7aHKOAGFHMthoPROLQoI3Kb3AB992X+v/mf6+CA2QCt6ZC11F9ihU9ldQ+uO8Rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=BjGcQJGm; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sBBtIBmlTU+KQY2W1nRDpA8SvT7gRM7VGeiqfHrYA4g=; b=BjGcQJGmQJoN92YoGt/xS+4jla
	6GH8sWpxCT3x6ILz5rdUUvJf6HofoF8HHVMkHpOdFn0Tr0GsOTWEe19sw1shU7mliIsMa7VVaOxJy
	MiaWmm+jPiXLeXRsrbUqMVsa/srUrIWEdq8cdoXkkbWZuE140voeaAefyOyfjM1SLFT8=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmC-00GH43-0U
	for linux-wireless@vger.kernel.org;
	Mon, 09 Mar 2026 07:07:36 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 04/11] wifi: mt76: check chanctx before restoring channel after ROC
Date: Mon,  9 Mar 2026 06:07:23 +0000
Message-ID: <20260309060730.87840-4-nbd@nbd.name>
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
X-Rspamd-Queue-Id: 0232E234190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32737-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.567];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Action: no action

mt76_remove_chanctx() sets phy->chanctx to NULL but does not clear
phy->main_chandef. If ROC is later performed on that phy, completion
tries to restore the stale main_chandef channel, programming the
hardware to sit on a channel with no active context.

Add a chanctx check to avoid restoring a channel when no context is
active.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index ae7b4ed27a5c..cfff50892a6e 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -324,7 +324,7 @@ void mt76_roc_complete(struct mt76_phy *phy)
 
 	if (mlink)
 		mlink->mvif->roc_phy = NULL;
-	if (phy->main_chandef.chan && phy->offchannel &&
+	if (phy->chanctx && phy->main_chandef.chan && phy->offchannel &&
 	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
 		__mt76_set_channel(phy, &phy->main_chandef, false);
 	mt76_put_vif_phy_link(phy, phy->roc_vif, phy->roc_link);
-- 
2.51.0


