Return-Path: <linux-wireless+bounces-26631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7617DB35E41
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 13:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0A53A6179
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B89A29D26A;
	Tue, 26 Aug 2025 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2kSN88Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4A8635C
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209294; cv=none; b=ul1X3io+6mzUgAyVdvqX0xaeeGXR8/UDwb/p36ROqEPusXo9WBLAXfxhGcBCNQWrloFV7ohNccCS9Uph7u1RXO9srWtSztAt+xQW0W5IzXTgacJ6gOOV61rtit5V9qnD8EHVpN6VxrrSHqkGTpMfv0hCTWceksSLkdaxT/kqcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209294; c=relaxed/simple;
	bh=zMl59GGpc7VGfGxTapbkAveEn+2bbxe0Gn1LV1wL5K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=euGBXhBoE1Oa4W5purc901l6dMh9dKun3vHoYSH1JcrjGi+ssHaywcM+09GI2+HQcdlILqCfytZ35ZzHLe9mlpXGMn9TMXXmxTJscLVPGOEDTvnYiLzWEjEU4BAr1CqzwkO9H3PxzliIumgIdTMWPoU1YWz10vxSUu9yOh04nfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2kSN88Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C5AC4CEF1;
	Tue, 26 Aug 2025 11:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756209292;
	bh=zMl59GGpc7VGfGxTapbkAveEn+2bbxe0Gn1LV1wL5K8=;
	h=From:Date:Subject:To:Cc:From;
	b=e2kSN88ZiZEPdtBOKTW/A4JNIo/Ijnfo+8w5ewrZTIk+48TE9hXIxeRztzTgMA+7R
	 J+N21242YYR6iAfrsR1ArsXL8vxlcik7X9vsQLG0+/9d4k+UvgpchBHdE4xPkP99Kj
	 yiLZ9MLMWwv7ktIzO35pxrYotm3htErYAi/Pp9k+MztSihz9boghRBmd+8gd9s6vFM
	 skP9u1usxTCffJOQ1478B7Ra9y77nvoKUCBo2p1Tk6+XaXp5kB1UE5JuPZCKCJ3ZUa
	 NAj3KYOWzY6moMQhxZU/jffuIY6DhbpThfUhsR8elPiVFWxIpCUHBlcKGx9GQhnd2b
	 Sei8foRb03XVA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 26 Aug 2025 13:54:31 +0200
Subject: [PATCH wireless-next v2] wifi: mac80211: Make CONNECTION_MONITOR
 optional for MLO sta
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-remove-conn-mon-check-ieee80211_register_hw-v2-1-5a1e2f038245@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHagrWgC/52NWw6CMBQFt2L67TW0ykO/3IchBMqBNkhrbk3VE
 PZuZQl+zsnJzCIC2CKIy24RjGiD9S6B2u+ENq0bQbZPLFSm8qxSBTFmH0HaO0ezd6QN9EQWQJU
 pKRvGaMMT3JgXDSX68lQdu3OhRTI+GIN9b7Vbndikp+fPFo/yt/7XiZIkZb0uO0jZ6jy/TmCH+
 8HzKOp1Xb9MJwIs5wAAAA==
X-Change-ID: 20250826-remove-conn-mon-check-ieee80211_register_hw-f7ed7483b96c
To: Johannes Berg <johannes@sipsolutions.net>, 
 Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Since commit '1bc892d76a6f ("wifi: mac80211: extend connection
monitoring for MLO")' mac80211 supports connection monitor for MLO
client interfaces. Remove the CONNECTION_MONITOR requirement in
ieee80211_register_hw routine.

Fixes: 1bc892d76a6f ("wifi: mac80211: extend connection monitoring for MLO")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Fix subject line in the commit log
- Link to v1: https://lore.kernel.org/r/20250826-remove-conn-mon-check-ieee80211_register_hw-v1-1-0dc7be11ac55@kernel.org
---
 net/mac80211/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 9c8f18b258a68c2c92981aaab68032931c6144b9..beee51354931165cac9e0d864c5ca2babaaf92b9 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1164,9 +1164,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		if (WARN_ON(!ieee80211_hw_check(hw, MFP_CAPABLE)))
 			return -EINVAL;
 
-		if (WARN_ON(!ieee80211_hw_check(hw, CONNECTION_MONITOR)))
-			return -EINVAL;
-
 		if (WARN_ON(ieee80211_hw_check(hw, NEED_DTIM_BEFORE_ASSOC)))
 			return -EINVAL;
 

---
base-commit: ee6960bdbb74499516261b84eadb19acc01cb361
change-id: 20250826-remove-conn-mon-check-ieee80211_register_hw-f7ed7483b96c

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


