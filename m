Return-Path: <linux-wireless+bounces-4801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1F87D940
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 09:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAF281D1F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCAD14292;
	Sat, 16 Mar 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="IKi0wQkm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A514285
	for <linux-wireless@vger.kernel.org>; Sat, 16 Mar 2024 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710576432; cv=none; b=aH7N3QwvNzhoTI6ZF4nEpnX/2dvoVB1wih2d/KCuZVFPfHbSl84t2m9YtThkoaoS6bYgvr2DCJYKmVcIYXQWDjN+Ub5ALaRcyltIO85ajVkiaRhIvICIz55Vn0ru7BJzFL51U4bX05du5xfoYRCc+Z/NOx92NxPYwy/9rg7HZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710576432; c=relaxed/simple;
	bh=EcEqCt/gI5CKrSy1aUfIGsP28LobZx/2/cc2QtK5Iqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcUCtjhcu+FWupgURIiZ84j2rVJB1vV29D+vVAd+4JNQZIgrLFkqItbxSxiWh10Dp24BhmKpPCsQyXhmGF+akvTpHzoHRfshvg9l6BI/gzQzgExBUW1EpJx/ErGDJtqGas+R1MHcoHHPcJVrOn6rkHZ2xOrrHrbiRRB4F8rG1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=IKi0wQkm; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8gu6F+HwtRJvcvAIGUPu2uMMb2AS7khduuvgjS0HqLA=; b=IKi0wQkm+pNQg+4CzUlhSqtoxe
	xgrEjFyKtWuqJVpLITPLJQUGTOiZtpXqLIdhjnCvWoLPcuCBaqU2oN0yVT+Vvui3GBOWz3EDZF9cJ
	LxxpAIpRTgQ/BEeMIhzk2D5336X1iym9RYzQiDBLPaELA6t8DLQVV13BL7pYIlqhGDT4=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rlOhd-006OCE-4C; Sat, 16 Mar 2024 08:43:37 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless] wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes
Date: Sat, 16 Mar 2024 08:43:36 +0100
Message-ID: <20240316074336.40442-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When moving a station out of a VLAN and deleting the VLAN afterwards, the
fast_rx entry still holds a pointer to the VLAN's netdev, which can cause
use-after-free bugs. Fix this by immediately calling ieee80211_check_fast_rx
after the VLAN change.

Cc: stable@vger.kernel.org
Reported-by: ranygh@riseup.net
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/cfg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f03452dc716d..f67c1d021812 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2199,15 +2199,14 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		}
 
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
-		    sta->sdata->u.vlan.sta) {
-			ieee80211_clear_fast_rx(sta);
+		    sta->sdata->u.vlan.sta)
 			RCU_INIT_POINTER(sta->sdata->u.vlan.sta, NULL);
-		}
 
 		if (test_sta_flag(sta, WLAN_STA_AUTHORIZED))
 			ieee80211_vif_dec_num_mcast(sta->sdata);
 
 		sta->sdata = vlansdata;
+		ieee80211_check_fast_rx(sta);
 		ieee80211_check_fast_xmit(sta);
 
 		if (test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
-- 
2.43.0


