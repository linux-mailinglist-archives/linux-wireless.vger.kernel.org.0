Return-Path: <linux-wireless+bounces-26758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE3B39E2B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 15:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2327568427D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5F30F937;
	Thu, 28 Aug 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="caTlX08Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723213C9C4
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386399; cv=none; b=Tl0TWVLzNUZUTAdEPcDON2I2noqFCK2lS21KnE/2emKcNL30gkY4XjessMZzgUgpzj+7I67eVxGylZ0OvsZRcbd2ed+6klxP+2hq/Ap2ZHRj/QvLx+WMqJkrVLKRK9AQlpLZf/753Z6U/dSIZUOJqEvwnLFmVazS5G1eB8Qr+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386399; c=relaxed/simple;
	bh=YEHYvX6w3ji79C97ortc44BdLf1fAHx9M8Mf60WyRAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcgWkndMWvn1OrktVy9y30Vz3XkjMkKjtW2hLxNXM5pKsqfA8C9Y8LyBgV9f4Jp3dSLtjw7EVFWplr80BeiugVB7+cr0qDMz13p9NvvtdOig7t8ojC9BPBGaitV7RcmS4cGoA9CECPO//NCs0HZ/Ysx5WaR29DCYAOKu/ZXCTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=caTlX08Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FDM8az0RI/E2zwjYDMMJvd0qydO1t0IhrXrob3Sp/Q8=; t=1756386398; x=1757595998; 
	b=caTlX08ZGVqzoByR3CZUM2TjqQp8CucrtVK31sNMjXJe27qWFEmzFahWLQkry2Jt5ahYPkXl+5t
	vVMBJT0cKuvtwutiHWNyrb82b9+c/EL0xBziWNuKfVLtSyQ34J34AQyJrdqILaluwWAaT5b25zK2N
	t2P+uDqmALu5XWsZBxtV2ewQq3Pc7T26zDCPxN2QofP1VFs+SmU6TXuj2pWaqKgNYXlf5FqmWS9FS
	Db87QQjFakcjqx8uaBUztIwO/NjuFpBRqGhbWnlXMIahBgZeSFRGEuytYLTesGhLdOnoyFJ7QUMX7
	Pzhw9cZYwvtRnsmKOSYi0EPQoatJHfH1IYEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urcKp-00000007aQm-0Luf;
	Thu, 28 Aug 2025 15:06:35 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] iw: don't set stupid socket buffer size
Date: Thu, 28 Aug 2025 15:06:33 +0200
Message-ID: <20250828130632.1170501-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Setting the socket buffer size to 8KiB is completely stupid.
It seems I originally though it'd be smaller by default for
some reason, the real issue there was something else but we
never got rid of this setting. Remove it.

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 iw.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/iw.c b/iw.c
index c99edb1292e7..6a4a9ad2c5fb 100644
--- a/iw.c
+++ b/iw.c
@@ -35,12 +35,6 @@ static inline void nl_socket_free(struct nl_sock *h)
 {
 	nl_handle_destroy(h);
 }
-
-static inline int nl_socket_set_buffer_size(struct nl_sock *sk,
-					    int rxbuf, int txbuf)
-{
-	return nl_set_buffer_size(sk, rxbuf, txbuf);
-}
 #endif /* CONFIG_LIBNL20 && CONFIG_LIBNL30 */
 
 int iw_debug = 0;
@@ -61,8 +55,6 @@ static int nl80211_init(struct nl80211_state *state)
 		goto out_handle_destroy;
 	}
 
-	nl_socket_set_buffer_size(state->nl_sock, 8192, 8192);
-
 	/* try to set NETLINK_EXT_ACK to 1, ignoring errors */
 	err = 1;
 	setsockopt(nl_socket_get_fd(state->nl_sock), SOL_NETLINK,
-- 
2.51.0


