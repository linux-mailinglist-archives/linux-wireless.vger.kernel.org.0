Return-Path: <linux-wireless+bounces-11684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB84958667
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C331C247E9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126E190044;
	Tue, 20 Aug 2024 12:00:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780A18F2E4
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155233; cv=none; b=UhKhPCZNh5nzcwca3DUeEHtCpS9ib/dhxBNqF+oqklngJK3zkWzlH8KWQp32GI/FSFX2BcWeBExzt/bSASicNd2/XqENL1zZ0yKRBihjRVfSD7wfksl6rHW+HpGCcIXWsyI1Ak9qxQ25pNp3nLU3JZ41UFZYV4xIktecsdkKo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155233; c=relaxed/simple;
	bh=oyVL8KPtVxuWDBPQLbQk7Ogha44KgKtRargadCKWJ+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+vmdWjLNyG3j7BGB8EXQgBzLBQuBid+zSZchgLSsaiNlj4SlvZScl6Cc6p1eWb3oEKgPojLvbdjwgTRxK/BIU7fOBmaRHiz9yDfjiofWVHdBbW7oKczHxWOw8qFbl/KQktji6wmC7XfygKf4p4JjIZcyRHuDQFzH7tJsSeMidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000ve-Rf; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNQ-Aq; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1K;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:39 +0200
Subject: [PATCH 14/31] wifi: mwifiex: iterate over privs in
 mwifiex_process_assoc_resp()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-14-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=1321;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=oyVL8KPtVxuWDBPQLbQk7Ogha44KgKtRargadCKWJ+k=;
 b=C8pJmMyeirF19M7RABFMcLN9fk37FGwYUTgpaY/chbnEvCS9v+U7dC/vNZPnAxihZmWLf9L9U
 MArRWDyZNfyAU2m//VYtXcIgVCRw3bqBfJ10CacrVDfWgOoADitxeBq
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_process_assoc_resp() only checks the first bss in station
mode for having an assoc response. This breaks when there are multiple
bss in station mode, in that case we have to check all of them for
having an assoc response. Do this by iterating over the available
bss.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index d91351384c6bb..c515887cc0623 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -921,10 +921,15 @@ void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter)
 	struct cfg80211_rx_assoc_resp_data assoc_resp = {
 		.uapsd_queues = -1,
 	};
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA);
+	struct mwifiex_private *priv;
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (!priv->assoc_rsp_size)
+			continue;
 
-	if (priv->assoc_rsp_size) {
 		assoc_resp.links[0].bss = priv->req_bss;
 		assoc_resp.buf = priv->assoc_rsp_buf;
 		assoc_resp.len = priv->assoc_rsp_size;

-- 
2.39.2


