Return-Path: <linux-wireless+bounces-26629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904BB35EAC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 14:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961625618DF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896B2BE62B;
	Tue, 26 Aug 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ4ortAP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381329BDAC
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208968; cv=none; b=b54riU48hElqEFsjKKC8x2tnK28M5TosRm7AhxRjKohf6+WTT9qZbxFoCh2hvlPyz88RzYmLWVyrehxz40P/ZBWHO/J4I+qLJ/4WqS7FdTSYySPAprGbRAC5mlGLYQ30ZRdjN9zEEa1y7tHAJM+fWiKba0QDQi+AL2bqB15SoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208968; c=relaxed/simple;
	bh=A1m8WdwKrnyqnHN8NxVIBZrBVCnCv/C4KpeETPgdDqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pVw3/tUbYh51hpo0HarVvNxnG02E0RyE/gujxNCYcYhK6O0xCp/pQC5RhNDo05oE/wwNwUzwuG1B3nqe1MFey55dkH/6FliJTPzuYNJyN4crZ55E2PZM2MPLNqVNlsuKu58nI4n98/cmcWMgqGOvOcjSKaSA+yAZT5E+8VcmtMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ4ortAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92975C2BC86;
	Tue, 26 Aug 2025 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756208967;
	bh=A1m8WdwKrnyqnHN8NxVIBZrBVCnCv/C4KpeETPgdDqM=;
	h=From:Date:Subject:To:Cc:From;
	b=IQ4ortAPFaeE230/vB5hP5SGlv7Ni1rqS87tbA1dd6y6wMZMnPql5BnlRf0jfGGjm
	 Wzw0Mskavgh4aO2ZFmn1wQ3IJbmQnqCVSInD7lIxQ6C+zdR4eTV+ORG20BooWsFKgR
	 YC+fvDAC2iBAthl4vWyF9Puq3YHTcMIDUBJ7a1woDILqdz9tcCpQJ0xTbuCjQ2XrMx
	 TSZlQSexsTcbi9+Tdu1mD9UAq3XHzJRjyPT0KmF/zwHpDG/1PcZAoUDopeWsCrnsr5
	 CvPwsDwrhSDPcoXVaSggNo5CsGUdQl5mEDc2NqKj4CGpwarervsNmtCuh7kJ+ej7P/
	 mQu3ZDTe4vs1w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 26 Aug 2025 13:49:16 +0200
Subject: [PATCH] net: mac80211: Make CONNECTION_MONITOR optional for MLO
 sta
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-remove-conn-mon-check-ieee80211_register_hw-v1-1-0dc7be11ac55@kernel.org>
X-B4-Tracking: v=1; b=H4sIADyfrWgC/x3NQQrCMBBG4auUWTuQRG2jVxEpmv5tBmlSJlKF0
 rsbXH6b9zYqUEGha7ORYpUiOVXYQ0MhPtIElqGanHFn413Lijmv4JBT4jknDhHhxQLAG2dtr5i
 kvKF9/PDYYehO/vi8tIFqcVGM8v3fbvd9/wHQTSFIfQAAAA==
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


