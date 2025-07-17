Return-Path: <linux-wireless+bounces-25610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949BB09118
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114591C42C5B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBDE2FE324;
	Thu, 17 Jul 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="TZnj3xAg";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="UQdF/fml"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837C32FA653
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767758; cv=none; b=LkBG/9nlcG7DGlj749rzi2kB5+5AjdtVqTfCgcKMykMuPOIDWunqPb/7c3IainNOarI6coMJuz2ke9weQ+tdNv6LtnGeEO7Et16EYWUUwp/sA5yLf3nwGPNu5T/PTqJguchUZZJ67vqsYrwj3acZ7SQvNF+arordGJv330zRHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767758; c=relaxed/simple;
	bh=2WMfvBNE2F2EmCmzIXntmRnTPlV59NtALx1Yw4oHVMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILRr2Ex0ifF54sH6zRk2pZU1Lb6RYPFRSnloN4PMrlWOd+atnIdGvGTnKWihKPi5sRJBZfLY9r3Zz0z6Ol2M4CWm9f+VlbSXurMSMj1iy2IdJX3tDYIV7GUeMvugg8c15jQeZcnSttPlAuvydhGprUXfbWgnpT8JN4xWCIhEGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=TZnj3xAg; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=UQdF/fml; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752767752; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=l8lNZs8wsHBELGPqY5Il4azRpO25P6AXof6ovV0cSeY=;
 b=TZnj3xAgvfrRW/zabo3p5BpurSWroiRC8QZ9hz21mh0HDrGThQDaeDrno/kYz4mSObTse
 U41XgjDYEMjA4Vl76kleQNlcV7IQ1E1nB4N9MUDgIdW1JdGJgxxddNgB78DX3258U/kyiqB
 bxWmY/fxz2xQ8iQm11yYjNtx3UUFU+7QHpKaMVSsYbpyezD+220KUY/OLi+JdVaBeoSbQDp
 NbrlaOUiIuLOKGyE7pPq/SIiEk0c+ZIt9LQiAV+dYe0msHAX0YTNRuOCrb/QFqbd16SqV5+
 elQmT8R0ux2pdEHc6mxTkJT3NEHrTNkJonfuQtT/3Z5KeNy6D9Ug55NTdhnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752767752; h=from : subject
 : to : message-id : date;
 bh=l8lNZs8wsHBELGPqY5Il4azRpO25P6AXof6ovV0cSeY=;
 b=UQdF/fmlUugh5PLZ9Kiv10udADFO5Y54nccAYZ1tsdjGeAgWPdgxzeVmU3aiSt5Z00b8S
 VhIzZNNncZPMnZr19dXKPy5t2bg9ViZhVQ+kL9IWwb1AbwtOCZw2yLZgxYe4ZKqbpJAtU2Z
 rr/qn9vUHjWlyUtuEZ5PSDLQWDDK69Wy7NGtBvGERM8GIpa3pNdQV32UsfeK3W6qUUYJzsT
 2aMM77VD8U1QK7DwKc6X9jzfsL94PpBcKpj3IRJ24EOK1iqV+mAsy25XyLrI8xowfTZjrSr
 4dHQlF4iukEH6RcAM5xP6oqcs65NPslV9DiH2Q7tqim8umER9DvGaUsOro2Q==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucQxa-4o5NDgrfb1E-lJpi;
	Thu, 17 Jul 2025 15:55:50 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless 2/2] Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"
Date: Thu, 17 Jul 2025 17:45:29 +0200
Message-ID: <66b8fc39fb0194fa06c9ca7eeb6ffe0118dcb3ec.1752765971.git.repk@triplefau.lt>
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
Feedback-ID: 510616m:510616apGKSTK:510616sZs8vCkADn
X-smtpcorp-track: pa9hLoAIvJaR.ok4_b8HPviHy.oC_WAgK8Z9p

This reverts commit 0937cb5f345c79d702b4d0d744e2a2529b551cb2.

This commit broke TX with 802.11 encapsulation HW offloading, now that
this is fixed, reapply it.

Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0af5bf9aba6a..fdc994d8c9c3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3882,6 +3882,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
+	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
-- 
2.50.1


