Return-Path: <linux-wireless+bounces-22595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3EAAB02D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EE87BB847
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD429288CBF;
	Mon,  5 May 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eujfoZYi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E212F70F3;
	Mon,  5 May 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487093; cv=none; b=FrAPeyu78S+rQkfx4ODgNO3mP5BUWMPlr3Mn9TDdkLRZDUk79TRIuo3GMM/j5GnXjN4HhfHLU5zoWFcQeNy/a7fO/Mv2JpgwOcVHX+1yDHMZZvwRBKCx/oEwmi6oBwW7D7YgHnNvF+SGiS6FbZOLmCUx7fUq6uErm88Bhh93VWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487093; c=relaxed/simple;
	bh=6XW+BGhGYA0ZBnIVGxYRGtcl7XkNpFc4+JVYXCPQkew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDHluRf8YivoMVJIq193B9ODi7LKFy0jGezmgNcG7//8sWA/A8r/06dn8+fibO+lFjTuzHUoGIFAM1DlqOBjzCvwcs1hW7KdOfj10V6JWwl45nFlCq1AoHLV60TuSBCBSfQU1oMjdyvw1JSLzdUrS3LqaiEG5ELImtH2kHk3GPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eujfoZYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A2EC4CEEE;
	Mon,  5 May 2025 23:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487091;
	bh=6XW+BGhGYA0ZBnIVGxYRGtcl7XkNpFc4+JVYXCPQkew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eujfoZYiW9LyUUp5GaukLdBlYTKAZmxlsv3lvmVG0MootJ9WtYGaUJ0TjWrMcJFrW
	 qFCtcIDU9k3XVvKfDPAf2O0ZC2Y1mwCwQFp0gU61TZuHU1HfPBxk5naq7/1gL4qlwn
	 ofPIlrBlAgBkKWBmFV65cRoMkce5WkiQrED4fKwnHsG7ZXa3HQue/JhDzGZFauNVSv
	 3XkCCn68JJ7XujtUdgzakQnmy+peMASZheQNmXQiH6xILgFxh3JxlGtkFQHOJQWj6D
	 zDjaB8yOGlGKrLlBVw6RHwN2CHtzcEcDz9P+6ohyntnowYfh5jxG0/S8V0r+xE8I9+
	 Bt4758ChocLKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 151/153] wifi: ath9k: return by of_get_mac_address
Date: Mon,  5 May 2025 19:13:18 -0400
Message-Id: <20250505231320.2695319-151-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index e9a36dd7144f1..bbc9d570c4e3d 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -639,7 +639,9 @@ static int ath9k_of_init(struct ath_softc *sc)
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


