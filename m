Return-Path: <linux-wireless+bounces-18309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43386A261EE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BEB3A12E7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62DB20CCC2;
	Mon,  3 Feb 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPP+tjQH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C91D5176
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605890; cv=none; b=iPWV6hkm2ZM71SgEp9Nerydhpy5jyX60H0AjUZHLxnYrQDkmKk6chYV2lTDx86pyACscWTcQWHVo0IenfvFJS/D3ldObkFIQbI8LZsrxx6jiI60jIOJa6uOeIxnSri7rM/5RLZ2Cce8FzIV1n1FAuC0W+WRhBMXc+ysx4jiHWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605890; c=relaxed/simple;
	bh=eNIW6WQcqPXhIWN6S46qWzShZTr4zretpTw8PTTRw9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cD8uaNFe1Gg6nXE8m985tF8bn+vQ4JIf7oqqI4HvfEFc4PNIR6hs9B5VgceNeh6tyEegvPjNE6WoMiLhNwB7ojwU7e2HfhELwUJQqQM3Xme0O0+2rEA6hU8aPo+NKfXvHfwtyLOiJCiFEGWH4ICnA9Ls8ecEE8GuDQpLq1BZ5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPP+tjQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53290C4CEE2;
	Mon,  3 Feb 2025 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738605890;
	bh=eNIW6WQcqPXhIWN6S46qWzShZTr4zretpTw8PTTRw9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPP+tjQHgZHPt2+r5AYhupMEyj4Nkh3Ak81oPBn8bnZ4PmdwEhcAiJIdlrWqpynFT
	 yZ9u+SBv/a1tjViGGNhOSLtdEF/20tZEt6WVjuinRWOhZVTbkftLVi7XTSXtYdjltA
	 3H06+ELtAFsIVvQQB5Dlkwcu8MZgltmEYsMAI0siY8nKGYZ2Ho8PkiHbSi5F+uuVBj
	 L3t+Y+cR5NIfLXck3C0TP9S5MKxhUy+KrNi7nIuND9koTisbb0V9rqg6S1CijrRvZh
	 gSOvV1UXH8BrrEULK9/G4H1l6oObEJstg9U30MvAV5Si/VbCg0HbNlE28Ai3oGgXbd
	 jFY27HTRbUkmg==
From: Kalle Valo <kvalo@kernel.org>
To: ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 2/2] MAINTAINERS: wifi: remove Kalle
Date: Mon,  3 Feb 2025 20:04:45 +0200
Message-Id: <20250203180445.1429640-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203180445.1429640-1-kvalo@kernel.org>
References: <20250203180445.1429640-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm stepping down as wireless driver maintainer. Johannes kindly voluntereed to
be the "custodian"[1] for the drivers until a better solution is found.

Link: https://lore.kernel.org/all/21896d2788b8bc6c7fcb534cd43e75671a57f494.camel@sipsolutions.net/ [1]
Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2048c75c3c42..6401e59ec2cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16341,7 +16341,7 @@ X:	drivers/net/can/
 X:	drivers/net/wireless/
 
 NETWORKING DRIVERS (WIRELESS)
-M:	Kalle Valo <kvalo@kernel.org>
+M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/
-- 
2.39.5


