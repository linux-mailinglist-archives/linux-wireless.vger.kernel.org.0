Return-Path: <linux-wireless+bounces-22566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1450AAAA51
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A551883E60
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129CF2DC128;
	Mon,  5 May 2025 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qelmbq78"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CF2D7AF7;
	Mon,  5 May 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485762; cv=none; b=fsDBELk9iCXXFYIfbY6moouMC/ZAbrF3Skt8sC+cNOC7LI8P6PXL8/AxEjmVwor1Tc8mAtwG9dc5uDgui1zQCJzSonJErjTCYvpYYRP43UohLMBLQu4n9pYexzADzN7soYebEJoaBwAU0nWr4HHGzlW/p7NczQYQIDUe8pr1oSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485762; c=relaxed/simple;
	bh=SgI4QQB3OheU7ULdDzQTMVDQs2Cqi1Nn/noA8ypWu1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBYJF4Sk4BIQswNmx+ADFfBdXgRCCI1sqktZgEj0tGroexQsygzYohcV45IlCeR/ulZXQ9fuvijYrtcPdxk+e+t+9nf48GiJrsUmCvCYs3bf5h3A9mMQzfIWl7pHGQmMtG81KCDAglaUd+nyG2je5NsvqF05T0OhnbOGtOHVzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qelmbq78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E491C4CEED;
	Mon,  5 May 2025 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485761;
	bh=SgI4QQB3OheU7ULdDzQTMVDQs2Cqi1Nn/noA8ypWu1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qelmbq78NdC9twjoi+ohkjclGDJUfcykFT73kIoVusj3UlEhmtMNrqGEjMfkr9rGx
	 pcYEe6zXUqlKIpqkS3lc3CywrdwdTvr4q7tJh+3A6mowCO8hMX0IYkO7qIZ6nn3vpy
	 i015g/MHfVVdPvARWlkDAPWhZIG3h1a6+cBLEhntKMLZcn6cDx6R5HqOcrs3l2TWMa
	 BnrGYUvao+gsIaPgK6BENHBicXGyG9YazpaLsAUz1u+LnM43R0e0YszRCAxSpNk4l0
	 jav14hVCSlIpAx3dYsHnt6AOfHEEgC2XanGowDZ8BiYbiet200AaZv0kb2mmk2qXK+
	 zAFZFhxDJBdrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 470/486] wifi: ath9k: return by of_get_mac_address
Date: Mon,  5 May 2025 18:39:06 -0400
Message-Id: <20250505223922.2682012-470-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 7fad7e75af6a3..619bebd389bd2 100644
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


