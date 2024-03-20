Return-Path: <linux-wireless+bounces-4995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3561388161C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E314D282FF3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2096A01C;
	Wed, 20 Mar 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqMp6IT4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E616A033
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954422; cv=none; b=PGK9KD6JWOeYDZMjWyvWuHwA77UtLcCz/Sqf2iFuc1nqtK01Z5nsVYf9KnAzJKPHh4/luqn1zJrH+CJFp9bH9yDZzlXFuEKfqeZFSFTL+QE6cmPn4TGr1Gu4BJtLtta2KYLXWtP0zCl+90MI9q2NCYOAuBHyTyRydNIvJb5WTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954422; c=relaxed/simple;
	bh=MJIuwMNyBaP6c/MES5ezK1cro0kM8LG+AbXPwf4yrxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZf0KpV8I8v7TdF3+K6xTU4lcmpHy+2DaKCr+fbPnfkN9TROq8XzbP19R7TzEjo/TZPHEXkVOb/06XtznxmHxiXX7xR/VIBXN9iRF/kKXnX5j+7PYlUSphZ24SvXpiLyvs5yLdUkTXiqRHldEO+ThkxioE/k5UgrOl6Ba3dkIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqMp6IT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABD6C433F1;
	Wed, 20 Mar 2024 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954422;
	bh=MJIuwMNyBaP6c/MES5ezK1cro0kM8LG+AbXPwf4yrxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqMp6IT4pJbQRgiBGOc4ANGThv5cYwE50IPjsvgI2Rc+Ie5lRmYD5wnXZJnl2084P
	 65APS5YUKUAk25hjUwJ+kPu8GqYNf+hAx268YGdo+GlARSl1I91QExghoWxOK3rkQF
	 W4L8+lk3LyK0ycbr1Ibyzloi+NreWL1SEjxGL8WmAZwD391+3uSCaM2w7sS+rim60n
	 eqvfYnFp6GepmaVOrj7x0qG1JwltlXIgCHEnMN90zyXHLshx9Myave9vsQPQIE5s6t
	 uY8UIcvbg2UAZyiSmQJuhgXkF7EyNvR3+GE/oWZ+P0DMA5xiYQwMhottXnYAZuBqHV
	 HOIb8EsX5fQ3w==
From: Kalle Valo <kvalo@kernel.org>
To: toke@toke.dk
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] wifi: ath9k: eeprom: fix sparse endian warnings
Date: Wed, 20 Mar 2024 19:06:56 +0200
Message-Id: <20240320170656.3534265-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320170656.3534265-1-kvalo@kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Sparse warns:

drivers/net/wireless/ath/ath9k/eeprom_9287.c:82:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_9287.c:82:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_9287.c:83:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_9287.c:83:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_def.c:138:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_def.c:138:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_def.c:139:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_def.c:139:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_def.c:140:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_def.c:140:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_4k.c:79:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_4k.c:79:9: warning: cast from restricted __le32

antCtrlChain is an array of __le32 so le32_to_cpu() needs to be used.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath9k/eeprom_4k.c   | 2 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c | 4 ++--
 drivers/net/wireless/ath/ath9k/eeprom_def.c  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom_4k.c b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
index e8c2cc03be0c..27b860b0c769 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_4k.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
@@ -76,7 +76,7 @@ static bool ath9k_hw_4k_fill_eeprom(struct ath_hw *ah)
 static u32 ath9k_dump_4k_modal_eeprom(char *buf, u32 len, u32 size,
 				      struct modal_eep_4k_header *modal_hdr)
 {
-	PR_EEP("Chain0 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[0]));
+	PR_EEP("Chain0 Ant. Control", le32_to_cpu(modal_hdr->antCtrlChain[0]));
 	PR_EEP("Ant. Common Control", le32_to_cpu(modal_hdr->antCtrlCommon));
 	PR_EEP("Chain0 Ant. Gain", modal_hdr->antennaGainCh[0]);
 	PR_EEP("Switch Settle", modal_hdr->switchSettling);
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_9287.c b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
index fd5312c2a7e3..d85472ee4d85 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_9287.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
@@ -79,8 +79,8 @@ static bool ath9k_hw_ar9287_fill_eeprom(struct ath_hw *ah)
 static u32 ar9287_dump_modal_eeprom(char *buf, u32 len, u32 size,
 				    struct modal_eep_ar9287_header *modal_hdr)
 {
-	PR_EEP("Chain0 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[0]));
-	PR_EEP("Chain1 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[1]));
+	PR_EEP("Chain0 Ant. Control", le32_to_cpu(modal_hdr->antCtrlChain[0]));
+	PR_EEP("Chain1 Ant. Control", le32_to_cpu(modal_hdr->antCtrlChain[1]));
 	PR_EEP("Ant. Common Control", le32_to_cpu(modal_hdr->antCtrlCommon));
 	PR_EEP("Chain0 Ant. Gain", modal_hdr->antennaGainCh[0]);
 	PR_EEP("Chain1 Ant. Gain", modal_hdr->antennaGainCh[1]);
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_def.c b/drivers/net/wireless/ath/ath9k/eeprom_def.c
index 7685f8ab371e..84b31caf8ca6 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_def.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_def.c
@@ -135,9 +135,9 @@ static bool ath9k_hw_def_fill_eeprom(struct ath_hw *ah)
 static u32 ath9k_def_dump_modal_eeprom(char *buf, u32 len, u32 size,
 				       struct modal_eep_header *modal_hdr)
 {
-	PR_EEP("Chain0 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[0]));
-	PR_EEP("Chain1 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[1]));
-	PR_EEP("Chain2 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[2]));
+	PR_EEP("Chain0 Ant. Control", le32_to_cpu(modal_hdr->antCtrlChain[0]));
+	PR_EEP("Chain1 Ant. Control", le32_to_cpu(modal_hdr->antCtrlChain[1]));
+	PR_EEP("Chain2 Ant. Control", le32_to_cpu(modal_hdr->antCtrlChain[2]));
 	PR_EEP("Ant. Common Control", le32_to_cpu(modal_hdr->antCtrlCommon));
 	PR_EEP("Chain0 Ant. Gain", modal_hdr->antennaGainCh[0]);
 	PR_EEP("Chain1 Ant. Gain", modal_hdr->antennaGainCh[1]);
-- 
2.39.2


