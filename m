Return-Path: <linux-wireless+bounces-25609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF8AB0911C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9C216361F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C12FA654;
	Thu, 17 Jul 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="gcKKc45F";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="DaFGmY7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542E2FD58C
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767757; cv=none; b=OIfiqM4nxQPbH6p5hlnwZZ3IMQQ8v6MyZzNsNW1rwiKiVBBYvpIAbELb7qRwvehLpcmBO2z3BtfHqGQEBp2+bhIsRkElqadEPXHILpx2YSjgBHtuIGF+I/zktjwr5wX68ONuAckDC1AvIAr4Tuc5Q9Tj12HT2sh0l3uHrXTPrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767757; c=relaxed/simple;
	bh=nB3WuwalJ9U/+bfO3AqJtL5A16Qj0C4J1YopVLVq6dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSCZHli16mDemECXQHaC4VNxHq1fUnJ8mi067SKtN7et9R0/ty69cqkCADsjRNlQUMiXtbWngxk3J7gHNzZ+PHWhmaCstEs49c/BuVibaHOVdkaow+amUwy0PoLhtMJ/m3ZKaS8t9YL78X9z9M1bKKWMbGZu+A1B722WWMdD/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=gcKKc45F; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=DaFGmY7o; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752767752; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=9ZDHBHMgGYp8rnsczho/Xwe4hAvNHcAACUmeGw53gPw=;
 b=gcKKc45FwLZi3YvME02BP8ZeRtBE6Vx+S4bTi38ZRAIrN8CsA0buA+Fd4OCh2QJVHaH0m
 iE8SYa1udRuV/zBdiddhbPiWSwusNoU+UylHfaVk3nHslbzg/SydydhP/PnBWEuSuySmK2B
 2euyYMdprbpD9n6oJ84sIJBbXKn3BTIwKBS7huNWfyWvn3BQN9MRAZIAsEwDLUlBtWp5CrR
 dO4a2WunqgCUv/xKqi+U8fjV1VWJzRniABqshi4kP8FhdPdsWWnLslKvD5GCpcVd7omy5EU
 gpVt/O/8WW8BzCKn1TCtHWyKMDrKAeD7oVFkP/L/FygUIgJSsTJguDaZVDsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752767753; h=from : subject
 : to : message-id : date;
 bh=9ZDHBHMgGYp8rnsczho/Xwe4hAvNHcAACUmeGw53gPw=;
 b=DaFGmY7o/RLqIBGoisKPkl3tGxBCtZfyvVhVfqXpTrGL+H7Bp+vNij5XGB4CLhDlEAuZN
 vngOZL4Y4wClMajorKQSPZrZ3TdSpNFVHRyvD4a4EUp6AAnkonRs+ZZuxtmyYxlALINJbr9
 qis2fI6ENvcU8ZrMpKAf4S8wfTEDE4ohYCcvKW4Ic7uYXVJIArdT8sOitbZgl0Ip4Qwoc7j
 qaFoFDPnp8xZyBix7h+OpRQOuptJpIYQepHrGAZnN1EIT7/0lhUST43xslkzKo1NFXg1nKA
 qYWYncvcR4i7iSjojkd/RxfsxDhxqjJASomlsm3Ivb4ebAPIrHd8dRUW2o6w==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucQxZ-FnQW0hPwcJx-nuXC;
	Thu, 17 Jul 2025 15:55:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Remi Pommarel <repk@triplefau.lt>,
	Bert Karwatzki <spasswolf@web.de>
Subject: [PATCH wireless 1/2] wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
Date: Thu, 17 Jul 2025 17:45:28 +0200
Message-ID: <1af4b5b903a5fca5ebe67333d5854f93b2be5abe.1752765971.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752765971.git.repk@triplefau.lt>
References: <cover.1752765971.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sYIRlMKefe
X-smtpcorp-track: KfiwfC3WyBVM.G0JJJIZMeNX6.Y7eXYAe26ho

With 802.11 encapsulation offloading, ieee80211_tx_h_select_key() is
called on 802.3 frames. In that case do not try to use skb data as
valid 802.11 headers.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/linux-wireless/20250410215527.3001-1-spasswolf@web.de
Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d58b80813bdd..0af5bf9aba6a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -612,6 +612,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 	else
 		tx->key = NULL;
 
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		if (tx->key && tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
+			info->control.hw_key = &tx->key->conf;
+		return TX_CONTINUE;
+	}
+
 	if (tx->key) {
 		bool skip_hw = false;
 
-- 
2.50.1


