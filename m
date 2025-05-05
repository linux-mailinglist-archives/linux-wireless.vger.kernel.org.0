Return-Path: <linux-wireless+bounces-22638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CABAAB3B2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E04189E47D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353AA239E86;
	Tue,  6 May 2025 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYWwZzlR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ACC239E7F;
	Mon,  5 May 2025 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486370; cv=none; b=cXJryjSWpuDa+e4EIYNB0jIwEDLdDzDe5n3aJjBMy1R8Ei71Ws0J5UutCMTsZkSdtpEdc7icwlK84Zz605AaA3slafshAh8DqxvCxUjuR3ISP6VkdKBZ/aWME5ng+b7EyYhRxAB+a8KrEQymBAce0CpX56JpLWZYNtbl23voqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486370; c=relaxed/simple;
	bh=8f+4JA5Io5v6P7QfORZw/DEeSg70+UT4TeDj9RGyMLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5WXcAciA+J2xcE1Yfk2QD2IStDPqgw69A5K7O5BMfGE+uD8ty6SPp/6oZURx7TBIymrCVQy/lqgv2yifHdqS3s/kVPCYSQPO0OE0hXzCl72CIXc2e1o/jAMxDfIJm4KsBAjxavV4yB0fAGtAuxxctdDlF1t+//jmDHTIfgY/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYWwZzlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89139C4CEF1;
	Mon,  5 May 2025 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486370;
	bh=8f+4JA5Io5v6P7QfORZw/DEeSg70+UT4TeDj9RGyMLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYWwZzlRLauDi3g7HPLwC0xK0gOKnWcFOl0rPIhSsRq1w7tl2WLRF2HWacn+rAg/D
	 y7LOCBncZEk/QvUx9DNImM8MomIyXXDFcEGNVNTZl83JPoPKPsUAIJnOi/lqqovD80
	 W6se4VerXb/pxVetlEdhqxv1XF3i+DGd2kO8ItCpIpaw60FJo5PfCqeGFIHgv5sBqH
	 I2NkX/mVwDBoimsmrxPaLw3xFde9j/mmL1M3Tb/rGToIPu+gQZ2lUEpW/J9LMb1ppF
	 e606rWIA0hVBYN4Qyxc2t2sEAj51Zu9LChtJkWcBxNfwftODqVghwG6YhQ7p1vwkIX
	 TABxB7WX+zY+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 288/294] wifi: ath9k: return by of_get_mac_address
Date: Mon,  5 May 2025 18:56:28 -0400
Message-Id: <20250505225634.2688578-288-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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


