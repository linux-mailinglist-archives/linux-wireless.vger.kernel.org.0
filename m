Return-Path: <linux-wireless+bounces-13644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DCC9937B1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B091F23A08
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211271DE3D3;
	Mon,  7 Oct 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Afjxo+7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC213698F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330631; cv=none; b=oE+5iNiBhpHLyIKVxd79T58XpYQ4KYHDncfseHK+wgHVIAA6t70WPzBJ28TOok5QfYgtSqND2k3nKPd6vRBLwCh2eOVgwmaNFr3A/NRbeIH6b4iG/pWrHTejey3YSH/U+XCTBJtRVXN2rwfTnCju3i40Qk8NCnGNrM0pEYJPD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330631; c=relaxed/simple;
	bh=0KlEbAhm+5GjjzJ1TY4tXIsvZZe74tFodw+oXTe2p/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPwacFMykerK4xBCyyWkjr1KKai5rN4tyygtUM0fPsxAxx6De/4gIl156TN/QdJ56e9mMhKiqyEB13/zIuDR6zbYsd47bdFRGpvc7atPLpjqBbdPdG+9Geu54NBKhWg+cQFGA4edV0m9JioJ65Ysw9kfIHvli6meZGWWno7imfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Afjxo+7C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yp0rQH5P4+m4nE3WEo7FLDrCQTjFxQzs8OPVznIE2Tk=; t=1728330629; x=1729540229; 
	b=Afjxo+7CuIBbhWwPWvbMMGwZeBk3NhwYt0G5I6HYEr9pPmeUu96uUjCRzw4aVgO/PlUoYaZzNk2
	lpOKJE1ROE9CSiJe4Kb9j4bMmW2WJyQzS+ezraD7znh8PklEd6cYaBN/ZM0kpxjh6LkAyLgLV/81z
	3KgqqH71CVQWqsqCxMDO7rNi4oTbLaj4Exl2tZjvagBUWLfjuI5Lb/j1xee7jgYWcxJFXMqEbHfEC
	gNB9jlFKx4PbSjbwCAuP3J+xpOJdpUXcS6Ohd7jWTnNBuweSFNifOuJQEWZNcY2lk2y9PpXqzGMfx
	zttcNiijT8tHXuXVUuTrLHWRZ/fBrFRrb50A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxtkR-00000003W4n-0248;
	Mon, 07 Oct 2024 21:50:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: wext: merge adjacent CONFIG_COMPAT ifdef blocks
Date: Mon,  7 Oct 2024 21:50:25 +0200
Message-ID: <20241007215025.5ecdad1e02ed.I54efa895efc496e06ba41e1c39c9df9e23b0171f@changeid>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Simplify this, and also add a comment at the #endif.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/wireless.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/wireless.h b/include/linux/wireless.h
index e6e34d74dda0..03e5d3fe226d 100644
--- a/include/linux/wireless.h
+++ b/include/linux/wireless.h
@@ -21,8 +21,7 @@ struct compat_iw_point {
 	__u16 length;
 	__u16 flags;
 };
-#endif
-#ifdef CONFIG_COMPAT
+
 struct __compat_iw_event {
 	__u16		len;			/* Real length of this stuff */
 	__u16		cmd;			/* Wireless IOCTL */
@@ -49,5 +48,5 @@ struct __compat_iw_event {
 #define IW_EV_COMPAT_POINT_LEN	\
 	(IW_EV_COMPAT_LCP_LEN + sizeof(struct compat_iw_point) - \
 	 IW_EV_COMPAT_POINT_OFF)
-#endif
+#endif /* CONFIG_COMPAT */
 #endif	/* _LINUX_WIRELESS_H */
-- 
2.46.2


