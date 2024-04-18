Return-Path: <linux-wireless+bounces-6512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A38A9564
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5391F21732
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783D15B0F5;
	Thu, 18 Apr 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JQ7hSYG2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45515AD87
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430358; cv=none; b=W8O+ZvzysTaZG1Q81IrH5pJWqFuqdkh1yzmD5TQ6iHqnD98QBkR9bBWn7CtD246E3fqmt9Cni+vOHwjQqm/UXnxfBj8uiEahl99xzGcELqrMTX/VVkeYu0+n0zdFvuAVZVstL9FJSEfEyUcUOh+fZtgMqTw35E5eS2Wk6kBXzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430358; c=relaxed/simple;
	bh=mvruYw4saUDVm5zPI1IzfDgLRoWPqMCaiNXgNnuk/vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPSi/fiDk/+n618OGUEG6wxW9O8Xdrz600MAFJhYflEjPmnC5wlgpfczNyufYcxQK9SZX5/k5rlxbA96S+W9hhY+GaA/HGTDoaeulAJuSE+Mkutz0LE/lrGspvLNEXTj/Tldc94Zwv1EMOX1QdNwqpr+JWQ5mRMUQSnS7CgLpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JQ7hSYG2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kNli9u6orNuA7CdJECIvuq1y8pxjKPckEnOk9fMa+CY=;
	t=1713430357; x=1714639957; b=JQ7hSYG2wKhiEWe2KPZG61eO//ZDhV/+6950prxd7jYTW31
	ZkM/2DjpQmH2GZlUC1sZzQi7IHDaPLY7du9wsDl45QLRaWq0FpKTJCI9TAXGNzRjvZuweY9yRabWw
	9NHLyCTVVPQREAYkHpUEBmeQVVJkr8g4GYA3Jr5gkZvm5B7h4xOBLlWBaJppe8llNIxE0J5MmlJLw
	W2KzUVlEGhuYYOcC5tp8BF8SZieCHeAQSTH6U95UrXiqBowZJphxbKSD3RGPnq/GegGKdQZODDLyh
	MmsUKHRmhEzPVJ4h6xVvHADVb9KyWYiOIome0UTUWa8lwLrtJCyIC1sWVlGOiPQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVM-0000000CIvO-1aX2;
	Thu, 18 Apr 2024 10:52:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 7/8] wifi: mac80211: remove link before AP
Date: Thu, 18 Apr 2024 10:52:25 +0200
Message-ID: <20240418105220.03ac4a09fa74.Ifb8c8d38e3402721a81ce5981568f47b5c5889cb@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
References: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the AP removal timer is long, we don't really want to
remove the link immediately. However, we really should do
it _before_ the AP removes it (which happens at or after
count reaches 0), so subtract 1 from the countdown when
scheduling the timer. This causes the link removal work
to run just after the beacon with value 1 is received. If
the counter is already zero, do it immediately.

This fixes an issue where we do the removal too late and
receive a beacon from the AP that's no longer associated
with the MLD, but thus removed EHT and ML elements, and
then we disconnect instead from the whole MLD, since one
of the associated APs changed mode from EHT to HE.

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 502c34d52fbe..6f0880ec89da 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5844,8 +5844,11 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 			continue;
 		}
 
-		link_delay = link_conf->beacon_int *
-			link_removal_timeout[link_id];
+		if (link_removal_timeout[link_id] < 1)
+			link_delay = 0;
+		else
+			link_delay = link_conf->beacon_int *
+				(link_removal_timeout[link_id] - 1);
 
 		if (!delay)
 			delay = link_delay;
-- 
2.44.0


