Return-Path: <linux-wireless+bounces-4147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B486AA68
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282DB1F245B2
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A72E642;
	Wed, 28 Feb 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h7wdCHUj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B32D61A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110151; cv=none; b=Z+mF8V9QnVVqpodnYvxZuNaAuA5vBdvgnAeuUrzTzHMb+bJ04Lc24MS5IkYoGEYoWl4RbAaj3EcLgRJTdGlCtHNKx6FWB9m1GA8eT5EBbtmlmfYpmX78ZboYOZYoZXhFC0Rz1+ER3FfCthEZS6yWUugfrkx1NlPayoIOVUi92So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110151; c=relaxed/simple;
	bh=hOinKWtUg5W4CrkwaEyr458E8imU8uIRCSZhyha97rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izPkyz8bpCr5zJQL6TUak25rd84TBfoYJqi1U1Fpq7RmgDUCoOOZ+QSTDqaNL7kATGMeqtt6PlKd6uoeNYjfKEyjRmCB54hXLi8+3d0eSPCibh6UX5Eq4g9qeTWittkhEA//98MQvzPm/eietCnNwTDI+Mp6dGZdk7G6lVAF8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h7wdCHUj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j5oxcJP2A8Odjp+ntNsOu7pyOW3a2wG4g7laIEkEmao=;
	t=1709110150; x=1710319750; b=h7wdCHUjj4Otbd6jlKOGe9yhZCOA77ZPFlTd8yxJ5clNKOl
	olX6CwSB8dl5oTv6qrhjY0JUKS0+QmpDVihWesl/xdqCKxq9xSdWynbXkfAM6duACLzoH9rEE4Lb9
	rP9ZBfcENw0D2aM3uyMPF0BnZugoUjgecvoL8aaV8xMs9QcBd0dehJ32pM6vzeIsW52dEgIvKGUuE
	YgsuD4l3b6iDcI5grbdzAMoyGxshAexqWs6NNs2V7/8qAF9tVLGW4EREVALz/IOsHH7QjVpdTYghU
	yosOVk0ZcOIaUPyi5ju2IT+h6h594p/T35du51GSOgieH/aEjv13vBWzr3+BriwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFch-0000000C0BC-1RZf;
	Wed, 28 Feb 2024 09:49:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 4/8] wifi: mac80211: remove unnecessary ML element checks
Date: Wed, 28 Feb 2024 09:48:12 +0100
Message-ID: <20240228094901.9e32c4b63875.Ia2ee0aafdc8a48bd21b485cc36a9866f950d781b@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084901.18661-10-johannes@sipsolutions.net>
References: <20240228084901.18661-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Given the prior changes to ieee80211_mle_size_ok(), we
can now pass NULL to for_each_mle_subelement(), so no
longer need to check for that here explicitly.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index ae0f14bd952a..d231aaecc219 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -720,9 +720,6 @@ static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 	ssize_t ml_len = elems->ml_basic_len;
 	const struct element *sub;
 
-	if (!ml || !ml_len)
-		return;
-
 	for_each_mle_subelement(sub, (u8 *)ml, ml_len) {
 		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
 		ssize_t sta_prof_len;
-- 
2.43.2


