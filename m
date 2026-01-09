Return-Path: <linux-wireless+bounces-30597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9902D07FDC
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 09:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BEAD3039AE4
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A8352927;
	Fri,  9 Jan 2026 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lYU2X1Wx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35DB350D6B
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948636; cv=none; b=QOChDkt+hwiUPJc8v6eNKfck2m6sjNFyl/nSpHfOhNPFGM6nZ9vO03zrZ6RhlRSvdK/amGXL49/5N5drvFfq3WeUAe3lZ3zqEu0+j7gn6dQwXczApM544ttbblEBqwe6L3yhYetLJd4dg6OFgjMrsdeY5gGiwOyRCINEnPkCfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948636; c=relaxed/simple;
	bh=lSeufJS3T3LgwBv96YQRdwwuKfMBE/cwFvzU4hKFlio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePL8bAkzx20sD1NdzM4wDYhllEjG/4ef2ucSunlyoB9p3qvikV5/2p8UUX/iiTl5zhb2cIU/E2mj7MyDBpk9q56hFbK1QzObk75XTclc/f+czeOU5AsWyQTqpDzF5M1Mn1RrgFKuZuqruaBNNoqnY6etH1CoMHRihG6XCHS6EIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lYU2X1Wx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=B2yYBQzLUC8vGUPsbzTQQoe4jC9aix8GRIDjito6qWM=; t=1767948634; x=1769158234; 
	b=lYU2X1WxeLJwwzRvZowW7IZkvbP2GeU+vpATm7yhRhveFS7P9+ITtkOym3FCiH17BMyI7zwNcaH
	jpFsWftP0X6yIxycidFDpr5+rF9UBhtIAlszwD41iW3fqeSJN9wXBjbSTxfuOJTWaVHFYFZllrs4S
	C9UOCaPbi7JdU4qaagFaZZgHsd2sD2uO3vfzxKQpDaBrhJou07Tx9OWem8bdhtR9U5d10t/9jNJlv
	AOZHa8HsYFvKKNRKzQcpaziRJFac1M21ZwRt6Z6ZBkH8qI5ca8H8Ydm/dXmgdhWQj96c+mvstAokD
	w32m2Pdv8imlLlL1blaU1qnxQEMZ7YmNtM6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ve8CV-00000007La6-33Mn;
	Fri, 09 Jan 2026 09:50:32 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: unexport ieee80211_get_bssid()
Date: Fri,  9 Jan 2026 09:50:30 +0100
Message-ID: <20260109095029.2b4d2fe53fc9.I9f5fa5c84cd42f749be0b87cc61dac8631c4c6d0@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is only used within mac80211, and not even declared in
a public header file. Don't export it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..df219e463fb5 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -101,7 +101,6 @@ u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 
 	return NULL;
 }
-EXPORT_SYMBOL(ieee80211_get_bssid);
 
 void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx)
 {
-- 
2.52.0


