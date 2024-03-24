Return-Path: <linux-wireless+bounces-5164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4CC887D83
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Mar 2024 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB7F1C20BC9
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Mar 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4605199B8;
	Sun, 24 Mar 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1tlIh4P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0519199B0
	for <linux-wireless@vger.kernel.org>; Sun, 24 Mar 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296422; cv=none; b=T0jknfDvnuv3FgYn5v8F5gAYN1o+YbCzR0ZpfwOd8KiSORM4gUk1kEfZlHGigoxsHQkya2Vr9lTBdcF/gmK9IoqJQouaifX4Mwmpe9amJWA9/UjpmzuGeUni2zhVZkUXeZQQ4NzkGgs0kLyykcsv+QPyIE5t0nnyKdOjrarJ0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296422; c=relaxed/simple;
	bh=iVhnDxz9MTinVm/uA2zbT4tsKoT4A27ZcdGCSypZg2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUpkXslKde3BvYw20P/jCXquuqSmXxF9+y0C+vL2GMUwtvKCCz2KErV8noc86K7W3UNjMG5mG+Zvu1fYtjdjCNFC4kjJkRK9ckXZHfXpmPZZT1gG/jBiOnMZcSd/66D4H1TXy3McTg2VMZIlXy3ypQVrvPht+CmjZBC7w/li39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1tlIh4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42023C433F1;
	Sun, 24 Mar 2024 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711296422;
	bh=iVhnDxz9MTinVm/uA2zbT4tsKoT4A27ZcdGCSypZg2A=;
	h=From:To:Cc:Subject:Date:From;
	b=H1tlIh4Pf6GuhzS5vziyNotBFaWFawkJ93gBo6tDLQqQhc7XEg3EMCW5r5HzYednF
	 ICf0KVK/Ko/b2mhvHjrQlNM19G1JxUntONZkVEhL+Mh8qXlFhLK4CHhFTHUAEFZ4vb
	 fOyhyWVChGgDy5a6sNaZhMTauzxEgEuL19H5RCtHvBbM7X098XP0DnN9cQwBz/o4xM
	 JZNwJ6xErVbuFiX6ZzqgX5J3HDCdwfoBhXJV1fJSaiJwhSklZiJY+nZgRxrYnR2Zeq
	 jWO1cRAcbUft1AVqeT4C+TDwVbaLwxTmoi7CLFycX1/JUy09w92Ve/XqRUaqKFghM+
	 PpxmuaCeTaV7w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1roQNJ-000000004uo-0Iqu;
	Sun, 24 Mar 2024 17:07:09 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] wifi: mac80211: fix mlme_link_id_dbg()
Date: Sun, 24 Mar 2024 17:05:59 +0100
Message-ID: <20240324160559.18861-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that the new mlme_link_id_dbg() macro honours
CONFIG_MAC80211_MLME_DEBUG as intended to avoid spamming the log with
messages like:

	wlan0: no EHT support, limiting to HE
	wlan0: determined local STA to be HE, BW limited to 160 MHz
	wlan0: determined AP xx:xx:xx:xx:xx:xx to be VHT
	wlan0: connecting with VHT mode, max bandwidth 160 MHz

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 net/mac80211/debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index 49da401c5340..35a8ba25fa57 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -158,7 +158,7 @@ do {									\
 			_sdata_dbg(print, sdata, "[link %d] " fmt,	\
 				   link_id, ##__VA_ARGS__);		\
 		else							\
-			_sdata_dbg(1, sdata, fmt, ##__VA_ARGS__);	\
+			_sdata_dbg(print, sdata, fmt, ##__VA_ARGS__);	\
 	} while (0)
 #define link_dbg(link, fmt, ...)					\
 	_link_id_dbg(1, (link)->sdata, (link)->link_id,			\
-- 
2.43.2


