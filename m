Return-Path: <linux-wireless+bounces-418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166A8051CA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D7A1C2036D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E755782;
	Tue,  5 Dec 2023 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFYFnmuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A127D2F2
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 11:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBD6C433C7;
	Tue,  5 Dec 2023 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701774919;
	bh=Tbzzrz0GhjjdIHOAsVLhTZq78N+oP5wAxgm97zPGVsc=;
	h=From:To:Cc:Subject:Date:From;
	b=NFYFnmuKS0WzyxOfAAasCNC/vmQ9bdu3V3dv4Q9p5PyEi9wTW/ulnWoPWDk+VBS7p
	 Id/S65IC4aLXQTpVDMX6mmlCw17Pkus2m5j7xtWZAulSLby+akXoZWV+kzmzjse+L5
	 NKu9v78OqIreSTKzBSf3vKlrHqQ8v0seet4qRcZRNnRGuhn60RZexC0I8UnjgjTrLH
	 K+bsprx8/Bd4b0b+l3PI4sXQsf0J/c/YJmfdW/zq+QRkT7Ns388ZwCJcnX8Ue/SzAM
	 aB1XZnmuz5R641+bVSevJ+hb4EDMLUCXZSNktWPU7ZOt5mMOW64jxNIf/OHyoUQZip
	 X3UEPoJhshlLQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
Date: Tue,  5 Dec 2023 12:15:15 +0100
Message-ID: <20231205111515.21470-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
parsing and add missing calibration data") added it, but did not use it
in any way. Neither, there is a later user.

So remove that unused member.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath5k/eeprom.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/eeprom.h b/drivers/net/wireless/ath/ath5k/eeprom.h
index 693296ee9693..e85b713950b1 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.h
+++ b/drivers/net/wireless/ath/ath5k/eeprom.h
@@ -489,7 +489,4 @@ struct ath5k_eeprom_info {
 
 	/* Spur mitigation data (fbin values for spur channels) */
 	u16	ee_spur_chans[AR5K_EEPROM_N_SPUR_CHANS][AR5K_EEPROM_N_FREQ_BANDS];
-
-	/* Antenna raw switch tables */
-	u32	ee_antenna[AR5K_EEPROM_N_MODES][AR5K_ANT_MAX];
 };
-- 
2.43.0


