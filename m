Return-Path: <linux-wireless+bounces-22590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AEEAAAC58
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E6217D63A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E963C6F00;
	Mon,  5 May 2025 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYNnwyhD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9A2F274C;
	Mon,  5 May 2025 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486794; cv=none; b=tiIebfW6mJsDIqbqBnqVth9L3Tp1UKE/B8LIpdtxvlq+0VxWebvkd7pMoywSKf8ydmtYsX0wgTPMeO4h9GIM58Cv9QTPiG5NJ+athX0XupjQ7hu5nJWdl5jWhXq+c/AaJKC2D3JcLBjd9e/ZdNH8W3mH1uwequ0hpxSIZHGvdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486794; c=relaxed/simple;
	bh=8f+4JA5Io5v6P7QfORZw/DEeSg70+UT4TeDj9RGyMLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1TY0IwduOssFG9rpTEvLaZ5gOjzdLp58XQdeaOD4551lGTcHdc/PUWNy8v92JsL8wBBHEduxRaK9+sZrHPgM/09ZWwyqs8s9Ezgl4TEyVjAkIa8u2m/fo2mXeT4ppxKT4AFULh14hytlaQT/ll4A+D7av5EhV3Yt8Ruta3Ok+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYNnwyhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC897C4CEF2;
	Mon,  5 May 2025 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486793;
	bh=8f+4JA5Io5v6P7QfORZw/DEeSg70+UT4TeDj9RGyMLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYNnwyhDCY30hqvkTkqpt399/1H7x+/xVDqf6dc089zvNHPzRPOlSf7ilqvj48tjp
	 lPU6uHfW9MvcfwlpTyDHUugd76YjPyykYwqbt+ZkphkPynopllhRco83uFs13iD783
	 usVHBH9oLHlfgb/isl1A9cQdr2DulprX3VuwfUZOgXNSD0qyhGqEYi0KCfF2Fjij/f
	 d97ZlnVKZ05z22VCYBZR/J+02rP+/mrttf49VboOP4iXpG1bW1Ji5/FWbwVuBvJTWZ
	 32ThPv/XjbwAtjZnC6DbCsC8Bo0NTPVq/UG0WZMZJ8lQQp6nike82wqPwQw6oOsKwh
	 ADUjwhINV4v1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 209/212] wifi: ath9k: return by of_get_mac_address
Date: Mon,  5 May 2025 19:06:21 -0400
Message-Id: <20250505230624.2692522-209-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit dfffb317519f88534bb82797f055f0a2fd867e7b ]

When using nvmem, ath9k could potentially be loaded before nvmem, which
loads after mtd. This is an issue if DT contains an nvmem mac address.

If nvmem is not ready in time for ath9k, -EPROBE_DEFER is returned. Pass
it to _probe so that ath9k can properly grab a potentially present MAC
address.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Link: https://patch.msgid.link/20241105222326.194417-1-rosenp@gmail.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 4f00400c7ffb8..58386906598a7 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -691,7 +691,9 @@ static int ath9k_of_init(struct ath_softc *sc)
 		ah->ah_flags |= AH_NO_EEP_SWAP;
 	}
 
-	of_get_mac_address(np, common->macaddr);
+	ret = of_get_mac_address(np, common->macaddr);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	return 0;
 }
-- 
2.39.5


