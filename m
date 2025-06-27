Return-Path: <linux-wireless+bounces-24634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2828AEC1AA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 23:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D8C3BEF37
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB2296150;
	Fri, 27 Jun 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="papPZq3m";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="CjjT0DDN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E839293B72
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058259; cv=none; b=mzEinRk5XyndI3fDeZ+ruzv/NnEuhx6+Qh/MzX2NZ6puhagHgfo0yHJCN5l1qMnizbH799I9EMjspIvOMlekO6ySyBYdm2YdbtFWWrYdn1i9ks2gduWXa1hf/hDDrqIHiH1wpi+TRJlvwOSWCAbqGDHaJYaobwbRq8zzdUuAESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058259; c=relaxed/simple;
	bh=PB5y9/HTjxCPGTDbN0DPdqlQpv1FQay+Az8XF+7AqUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LS4SeAIsFWiMCjf3Sr1Bm4bzJPNq9CE1B3QKzAqsTuxZDS8Jnu5TlxnTBtOSBHa09Vl+vSOpNezHPu5awQL7wUTDlD/k3/wjQJdmzVJCqM/XBVQKCW1rsMudikEh7/9oO8OF72dtmid+h83nu0D+wj8Fu4v3zjWuAgtDVaJPqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=papPZq3m reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=CjjT0DDN; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1751059157; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=KI3j6h+4PHiZ7IiGHZy/tubXugs/QE1IKxzd+gUImrA=; b=papPZq3mSwWTMLdumMz491hMnR
	PPXUhsMiOgadGUpNyI8vzevxxe2RuJ7MPqN9KViDqE9ZtY1Qq7iZ9Rihccx/B1y+W8fKNDxOJqErB
	Lo9da2j7yc+Vv74j7d666+rkJwGm4p4sMzpqSnoUIOnRydPs1EGmvx3za9sMv4NOgShXYxHMUPTik
	aK7wgbAuzeLElGe+2+U8pzz9ENAL1ff0wBK5/PV1rESombtVN+P3FaB/jdpjtLJWk/dJIIZJBQoJo
	fZ2gbhezmfgS+1n3yXdtAGaii5T/Ruid/mc8nqUW0XyCB/MdXTTbIZ0k0x29MyZtIK0eIRyLB7EXz
	L2XvojEg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1751058257; h=from : subject
 : to : message-id : date;
 bh=KI3j6h+4PHiZ7IiGHZy/tubXugs/QE1IKxzd+gUImrA=;
 b=CjjT0DDNK7jNy/pjgXXf6dYOLZBiBzBTZk5omwRve4qKB1z+3IHEPuyxLRi2CuM7TEy7Y
 x7+Cuq4MA+dbSkh4NJ2T406MmLKXkKqRZxz8R0XGVye2ksAFavwdbrrOhzoO4VTZjdVMKaU
 XVk7uCUhWa2iMnajC/eMbxWJLGIeVt/apzSA9FPNMRmOGM8vVMkE3WJ8F1laW6N5Fs6UXPJ
 mrMKqRL1/WP3KrQblneu7PyO6adTDHJpnWwlW+wqLUIanQo5DVQbe8x5UBSI307r8Tznhmd
 lnHkOPfCuWMw8U+9MYXtzMW+rROpwFZoVuz+9LlN90VGM8bkebewzt8hXLmg==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7U-TRk3Us-CZ; Fri, 27 Jun 2025 20:56:24 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7U-4o5NDgrn9kc-kei5; Fri, 27 Jun 2025 20:56:24 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless-next 1/3] wifi: mac80211: Do not set link_id for
 received management frame
Date: Fri, 27 Jun 2025 22:46:47 +0200
Message-Id: <8701dbe48fae509bc8cb6d8ce5e6f96f75ad57af.1751057146.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1751057146.git.repk@triplefau.lt>
References: <cover.1751057146.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: m3uqiY6PYhEy.BmczBGTcQhXJ.yTfsOgjMTXZ
Feedback-ID: 510616m:510616apGKSTK:510616sqE7JnFGBJ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

A non-MLD sta could want to send offchannel management frame (e.g. to
do a offchannel scan). Because ieee80211_rx_for_interface() fills the
link_id information with the link the sta is currently using; hostapd
would send back management frame responses through wrong link causing
the sta to miss them.

To fix that, do not fill link_id indication for management frames,
relying on hostapd instead to infer the proper link from the received
frame frequency.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e73431549ce7..deebdce6d9c7 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5112,9 +5112,14 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	 * have the link information if needed.
 	 */
 	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
+
 	if (link_sta) {
 		sta = link_sta->sta;
-		link_id = link_sta->link_id;
+		/* Do no use sta link id information on management frames to allow for
+		 * offchannel scan, roaming, etc.
+		 */
+		if (!ieee80211_is_mgmt(hdr->frame_control))
+			link_id = link_sta->link_id;
 	} else {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
-- 
2.40.0


