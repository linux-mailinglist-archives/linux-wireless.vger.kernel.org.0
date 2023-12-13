Return-Path: <linux-wireless+bounces-732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507D81099A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 06:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777591C20CC7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378CC8F7;
	Wed, 13 Dec 2023 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AhgcvZ4d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA4AD3;
	Tue, 12 Dec 2023 21:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=x/Zgvs4f8I9sq98lJ2V+vIqYNZFeN0wHjrKY4LrcOgM=; b=AhgcvZ4dTiHzFmI/88FRjjtM+b
	BKiGaQdABhu2lFj6MwZ4N2frVG7/h68yh8R4OMTaVWltqVQ1ijR5GDK/qVu9dkJcAS5XduEU8UWF5
	JeuBXRVyvL+8tuKQRBAT/wGNqj9PA8zJV7AfuRkeNi4MJ8gUm+OUU3RlLKfApXbZyd5qk3yo2V5ST
	1FJcjYaI20d1tP9LAqS0/vcJ/B7KD+B9bYtI0Qnkfo02upHGoa/dwF0f1GbKejqqMLcUlMKviVXXs
	to3sfT2kekTZ6ajdAWVI+5RN5+ZX3yFzAmXfoZ2HUauJLYC5JpROCTj4DkARTwG6nqoUxS2j4k5LV
	mQfeIgWA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDI6M-00DgBG-1R;
	Wed, 13 Dec 2023 05:48:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] wifi: mac80211: sta_info.c: fix sentence grammar
Date: Tue, 12 Dec 2023 21:48:09 -0800
Message-ID: <20231213054809.23475-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct run-on sentences by changing "," to ";".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/mac80211/sta_info.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -40,7 +40,7 @@
  * either sta_info_insert() or sta_info_insert_rcu(); only in the latter
  * case (which acquires an rcu read section but must not be called from
  * within one) will the pointer still be valid after the call. Note that
- * the caller may not do much with the STA info before inserting it, in
+ * the caller may not do much with the STA info before inserting it; in
  * particular, it may not start any mesh peer link management or add
  * encryption keys.
  *
@@ -58,7 +58,7 @@
  * In order to remove a STA info structure, various sta_info_destroy_*()
  * calls are available.
  *
- * There is no concept of ownership on a STA entry, each structure is
+ * There is no concept of ownership on a STA entry; each structure is
  * owned by the global hash table/list until it is removed. All users of
  * the structure need to be RCU protected so that the structure won't be
  * freed before they are done using it.

