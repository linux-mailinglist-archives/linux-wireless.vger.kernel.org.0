Return-Path: <linux-wireless+bounces-21137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFBA7A9CC
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBF43B65DE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91D253B45;
	Thu,  3 Apr 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9n5dyQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C325253342;
	Thu,  3 Apr 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706938; cv=none; b=KTlSB2E3tyogLs4HXDQn+K1tu4tZ/20QRR34pR9J+to3lME4tBPevZFhncSKluUjtd/chrtt4oxTKjQ3unQvpXFh/GyC8myVBqVSSuvIhRV0A/2YyAw44mk07CkeKlXphvb3dtL3ZKcHmd5R5R6GnIKGbAbQVZ/ncaVwukpo9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706938; c=relaxed/simple;
	bh=4jPalTCX1rcN6gPwd8+l4zwythtZrx1tpKadoOQC8sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BlyTqBV2nz7E32yU97m/uDxgeBBTVhznsKlDozSXdyCvajqKZKKq7ACDX0xK6JETBH2sxLskOtHbyFbEOWbQDNudDGYTw1Bp8rAxGsfk3N+sX8r7K1Uk7X+37HNuVtG6Gum67KU4fyzBk7cW5NbxwgCdjZKAStNzW36X42E7YvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9n5dyQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC402C4CEE3;
	Thu,  3 Apr 2025 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706935;
	bh=4jPalTCX1rcN6gPwd8+l4zwythtZrx1tpKadoOQC8sc=;
	h=From:To:Cc:Subject:Date:From;
	b=U9n5dyQiEmIWvVcJB/xs6+knEcuDSOcEz8ORhy2J0ld5CLEjdIhDeA4RrZ13X4Td4
	 AfhseBRtD+zp1T1aV3FJ1aUhteF26GlwqE6fyCP5qZ9amETpRO8SHJH1oRad/cdWR+
	 kcRNOpUUfR1dLEmxsKp8Jb6gXCifd79/iNcFqbZFfTvGw2vJoJkKv5WsRzwGlA1esv
	 9pd/0Ra0j0AzdqOqS8dj7WTQrIQ0yT+FqR2CovnYDh+18zlL6WL81awGH7SGLctPmg
	 /c0t9rRYIGspUgEW+YLNJySqzxbkoET0tH9hPwt05g5vWG2UiFMpJVgIYQziT/iUlg
	 YMg575j0N1uLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 01/54] wifi: ath9k: use unsigned long for activity check timestamp
Date: Thu,  3 Apr 2025 15:01:16 -0400
Message-Id: <20250403190209.2675485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 8fe64b0fedcb7348080529c46c71ae23f60c9d3e ]

Since 'rx_active_check_time' of 'struct ath_softc' is in jiffies,
prefer 'unsigned long' over 'u32' to avoid possible truncation in
'ath_hw_rx_inactive_check()'. Found with clang's -Wshorten-64-to-32,
compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Link: https://patch.msgid.link/20250115171750.259917-2-dmantipov@yandex.ru
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/ath9k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index a728cc0387df8..cbcf37008556f 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -1018,7 +1018,7 @@ struct ath_softc {
 
 	u8 gtt_cnt;
 	u32 intrstatus;
-	u32 rx_active_check_time;
+	unsigned long rx_active_check_time;
 	u32 rx_active_count;
 	u16 ps_flags; /* PS_* */
 	bool ps_enabled;
-- 
2.39.5


