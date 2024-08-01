Return-Path: <linux-wireless+bounces-10781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5071943CDE
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C7F1C21F1B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA920FA9D;
	Thu,  1 Aug 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgVgRfti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0C20FA99;
	Thu,  1 Aug 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471507; cv=none; b=ibL9juJ3MBImv/Y0waPMuI1DqofW5y85rXi2oK01pEAY5TRM13UBfr6RNr72bn7bBfT13yhnmsDp9pYNUUcZqg+Bd0vAHZSUOAOqggmSFl+Y5xAwNOEf4cYfxLkXFTrwM0Wbl8p1DwrFhYhFvFtS1hSyjoXsP/KMa0oYlO3xSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471507; c=relaxed/simple;
	bh=DQsZN+L7tyPyjFnHY3CpZlj+2RiczkxigrIH2ahdNyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIQywW5CdSdDsOMxGRMbRj+fqzf+KX9cFNFqj84eaINlJU8z3uLdvluwxH3iCbL+IvClZJ4P+EtgrovQrGE2OB3Wbz+qR3S6ZaO0LaLnpklgsnTXGSqu8ugx3Yq5KXQMppxBC/aeifnf1rULzzeSRptmHQONyYDUd804TrXtb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgVgRfti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B4DC32786;
	Thu,  1 Aug 2024 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471507;
	bh=DQsZN+L7tyPyjFnHY3CpZlj+2RiczkxigrIH2ahdNyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgVgRftibOK7kPinr6nXAOEjwGFaMYkntzTEC0PTcQexAnVFrAm6GRqp+r1ZRZxxt
	 zLCHQR2neM/s/q43zV0zAtyj9TyVLF033YleiqOZmDPCBUePKnF3pHWWtByoTLecrK
	 ziUZ/PP6acbVK9fnc/0FSmkRjvpPRocnT1DyLKj99wz8lmC69+htq+QFzOTwEskGAg
	 pHjEJq0NesNB2VeeD+9Fmx4BLfQZYVGeHUubWeTuWamDIAxrmTWF0twUEETkpo5YZY
	 uScKc2Mt4RzFW4pXXo5WbYMxxlf3foPhHXz8Ft59YYODgI7VHUupSqpLjI526XVW+c
	 PbUjfearn0dqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 119/121] wifi: mac80211_hwsim: fix warning
Date: Wed, 31 Jul 2024 20:00:57 -0400
Message-ID: <20240801000834.3930818-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit b3603133d3b727b0b07a7094ab74cf27c8aee3bd ]

WARN_ON("string") will unconditionally trigger a warning, but
not really do what it may look like. Use WARN(1, ...) instead
and add the mode number as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20240705133921.a50aa5b15ece.I9a25b7448b0498c0c2e503986978dae165c8bdf8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index c5d896994e709..53a725908f742 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3260,7 +3260,7 @@ static int mac80211_hwsim_switch_vif_chanctx(struct ieee80211_hw *hw,
 			hwsim_clear_chanctx_magic(vifs[i].old_ctx);
 			break;
 		default:
-			WARN_ON("Invalid mode");
+			WARN(1, "Invalid mode %d\n", mode);
 		}
 	}
 	return 0;
-- 
2.43.0


