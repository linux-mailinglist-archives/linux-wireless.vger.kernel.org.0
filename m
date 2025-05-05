Return-Path: <linux-wireless+bounces-22542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F409AAA7B8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541B917D15A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E9298C33;
	Mon,  5 May 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a63ABao5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF742298C2F;
	Mon,  5 May 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484666; cv=none; b=QzOBVM7YV4/EFOF5YwMMFgy0DsDPiuhxiEHkjL7WC1b4J0+7Iy7hPmGY7IAEl/T4z8tHhubkc8KSnj6w9UTc0UPzMLIa6zu7DFsT08LRB5U3xo0uNK583YhfAm6FCahMcu84OyFlOXnQcO8DJoOnzbiFG4pKasldMtzyj67IYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484666; c=relaxed/simple;
	bh=gCGZ8IC43+DkQANt32VMSEIBDoUerURJ64yGXKlNkTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oc+0SunQzIc6IWnWpGNl0VQloNnUJrJrQ30zd8zI8Ej+17YQog7BTqoGQeCW3/ba7e2Wf76Rk8xv36bFtmPuKU7ooTC3v27PMimiaV32vQI1oViE6HILwWLDanQqWDbsHQBDkAM6OpGO+6Fp2tE++ZZrcGvf+69o1wDBsfVx5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a63ABao5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB28C4CEEF;
	Mon,  5 May 2025 22:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484666;
	bh=gCGZ8IC43+DkQANt32VMSEIBDoUerURJ64yGXKlNkTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a63ABao51bdsVkSJBADVDH/I9hpI2NzTjNveUjPbZ6yBgKZoURZD/KpfFeAPmD0ml
	 jt6hb80zVxn6+K7xrYiUM5Qa4Yua3v1QE6r0PU+hRn2sW6AFdsS1my8w/yhpLd6KwQ
	 NWcy8fbb1Csz9Xinc4Y7C5AUhMCPLddWt+cYGPObhvP1Pgsq6FblT47Q2Sr4ssbAxm
	 Y30TfH4iSr3W3YpyjFriCFbBEvsyBdhn5JzJiqODBwgQaHK3kvHnqD/Ic7o3qV4gj1
	 ogjT5dRNSbnSUEINWY90swxI75MwnAB5zA/6JYaBmoD+qkPq+zZ3q0p1iE4TVgCLHF
	 nSEb2ruxn+UkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 595/642] wifi: ath9k: return by of_get_mac_address
Date: Mon,  5 May 2025 18:13:31 -0400
Message-Id: <20250505221419.2672473-595-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index f9e77c4624d99..01e0dffbf57ed 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -647,7 +647,9 @@ static int ath9k_of_init(struct ath_softc *sc)
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


