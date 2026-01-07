Return-Path: <linux-wireless+bounces-30461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E2CFE0E2
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 116A5303FE17
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115033EB0A;
	Wed,  7 Jan 2026 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Vl9BO5Ti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165DDF59
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793092; cv=none; b=DnkxjVG3wEwpU8cGIq9syY5IME7fbDlXK9dhj1bd8H+o0BSs8laXmITNA3qbqj4CZK7d35WgRF8jPjfKZsfXv2mfWOT0SoD/plS+aKVvcLCnfYmicr4fA26AY/Rg7d/bXfSzXk4j9fvLRMZW2wxZ4aDVmNDHA6XmycTqmqOjycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793092; c=relaxed/simple;
	bh=vevEgaEwJemmbMIW7k9AhOOVY7bSq+yx3LMrtF55Oqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaUh+1mpvr6DtQA4sXOWb5Ju3Wdc6oypYWJrx/3IA8J7qo66Pg9uAw1NUiLhacLafldvD5s3Xi7TdmnM80BHRh2aRGnV5UgyWQbGAkbvlMXVMOUcrjERJUDylU7+S6ZM1/h+gwBozKO2ZhsxU5M0Y7pinkIj1nDmT978WjU3+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Vl9BO5Ti; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=d4taPGQy8h1Dnbt4tSfOhBlC46CLfMwrRjOUXQZCn3Y=; t=1767793090; x=1769002690; 
	b=Vl9BO5Ti8i6MaR/MtSWgQ9eYkBC8MuflSuPHVoRePfminkjRJIiXXlF3gtnGvHZGfcxXFtV14Z0
	HIRTpK/GX1641SOVQ4ZektFFo6cjaLw5hJostxqBb5XKxppBiylHd3Cgt2Hl4yy3InwgRqGJYR29o
	tgCPU6AFo0zd5Jxj6zieRiIUvwNUwiyuZT6y/PdwvCmeuoj3S8/95gKKKtI3XztPD2BbPIQwevZdd
	HpEZCLXOJjPRAqvtkmqX2h89LMbbFvc1JI73xOa6nPam1ML3Ud9L4NOigoXYlJHG+M1k2zjRGhxGA
	S+GkbvWPonrfJu/ZKyAnfwHXD8qdS+tVzUBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdTjj-00000005ZTv-3BUn;
	Wed, 07 Jan 2026 14:38:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211_hwsim: disable BHs for hwsim_radio_lock
Date: Wed,  7 Jan 2026 14:38:05 +0100
Message-ID: <20260107143805.ce7406511608.I688f8b19346e94c1f8de0cdadde072054d4b861c@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The hwsim_radio_lock spinlock expects bottom-half to be disabled, fix
the call in mac80211_hwsim_nan_stop to ensure BHs are disabled.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 92427f527286..79cc63272134 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4112,14 +4112,14 @@ static int mac80211_hwsim_stop_nan(struct ieee80211_hw *hw,
 	hrtimer_cancel(&data->nan_timer);
 	data->nan_device_vif = NULL;
 
-	spin_lock(&hwsim_radio_lock);
+	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry(data2, &hwsim_radios, list) {
 		if (data2->nan_device_vif) {
 			nan_cluster_running = true;
 			break;
 		}
 	}
-	spin_unlock(&hwsim_radio_lock);
+	spin_unlock_bh(&hwsim_radio_lock);
 
 	if (!nan_cluster_running)
 		memset(hwsim_nan_cluster_id, 0, ETH_ALEN);
-- 
2.52.0


