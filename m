Return-Path: <linux-wireless+bounces-16163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A479EB3E0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9934167EEF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1551A76AC;
	Tue, 10 Dec 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="et/I215R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA391AAA0E;
	Tue, 10 Dec 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842123; cv=none; b=DuQDx71yHw3wMKNTOsUL3DoJ0SD36nHLB1Yzf0vQmgA7a3UQ5yl90QNi+hKF1+QPobgdnG8wbWjMV/Ucs60j9ajz/EMKBjoqEWeoueopODwx0GZJsJzqkcPGbCV5EOFCh3dSNt1XyGQp7AWsr2L9tmaQHo1+r45irA0kHXsiEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842123; c=relaxed/simple;
	bh=Z/Vo7ZQSX8rGYLrNrs6sr86a6WbgE90w+dn33fnZAc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXrG93ZSy4tNZOJ9lnebOGjkrMLUknt7r2jk6HiOpsPU6iZpmrjgeldnUn6IrgcJuZYkIIU2ozW6sdKxMsvMtf6ehfEF+TYcBZbM5/Ev3XLK+aF3NGPItQ5mRVDdH2YygHaWw5Gt6XL3+V3Let+AwnWrlW+sWwCNgebotdurjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=et/I215R; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id 77C5E67ED5;
	Tue, 10 Dec 2024 17:40:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:200:0:640:1d5:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 172C360B54;
	Tue, 10 Dec 2024 17:40:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0enkiN2OgCg0-K3MRZehN;
	Tue, 10 Dec 2024 17:40:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733841601; bh=eUKNwPVhYHVXCqE0/sWtIYARC/uoQkZRf5whvudtY58=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=et/I215RH01FzyCioiIvxXGar9oHaWbxENdiZSWyYxCggMMqyaUETRymRv7ClsKsA
	 c3HDz2hzeAl5YTn3suNGLhCqtWpe4MwFBMwAIp4g0nk8tAAIpR66ujEwYS94dRdrHh
	 DXpvH+PXIvBFGFzA3o2GbRPbKJrls4YZckuxQgpY=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: cfg80211: annotate struct cfg80211_mgmt_registration with __counted_by()
Date: Tue, 10 Dec 2024 17:39:50 +0300
Message-ID: <20241210143951.5685-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the '__counted_by()' compiler attribute to the flexible array member
'match[]' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE, adjust 'cfg80211_mlme_register_mgmt()' accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 9d577523462d..4790136758d5 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -575,7 +575,7 @@ struct cfg80211_mgmt_registration {
 
 	bool multicast_rx;
 
-	u8 match[];
+	u8 match[] __counted_by(match_len);
 };
 
 static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
@@ -710,8 +710,8 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	if (update_multicast) {
 		kfree(nreg);
 	} else {
-		memcpy(nreg->match, match_data, match_len);
 		nreg->match_len = match_len;
+		memcpy(nreg->match, match_data, match_len);
 		nreg->nlportid = snd_portid;
 		nreg->frame_type = cpu_to_le16(frame_type);
 		nreg->wdev = wdev;
-- 
2.47.1


