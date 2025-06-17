Return-Path: <linux-wireless+bounces-24199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FBADC6E9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 11:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5E5168D7B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A00215077;
	Tue, 17 Jun 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JO6RzNpD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0520D4FF
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153545; cv=none; b=o8C9FPX5NoUQiCYBnJdNmEQS48VYHEb3kriOizYG+mQhllCFn0z1BZ2N0/DVnJ9lO+US/lkvtT+zGda9zOE2pdtb1xzIz79wKux63ThuWb+yT6DogF9UJUYcBU9CRSgILjUfgWk1i8sMFGIMfPjBDukxJWphANGhGPSwMKjxrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153545; c=relaxed/simple;
	bh=6MUpb5AMt2hAFpk1Ese/eZH9fwhRR+59LNQaMvfSeUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPBT1JgJGuHka4G4Za6JPPMQ5Uqu86ngGp2yE4wZbIKBsftYpnpm2KAWPU1Gny9YRwna5nRK8Mh43BGFae3ohXezowV1lCr4o5mO6GPzUTb/iU6OtIc0khmO72LWhqG1VWPIqnN0XuMPio1bjvjAPWSQR1YX0XHdheqTnTuSF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JO6RzNpD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=dbhIe1tDrcQcyb3xQNa8Ma/lXsGr/L0N6xYZA9zsANU=; t=1750153544; x=1751363144; 
	b=JO6RzNpDPj8NUac8exwMUc6SYuIMBkCsaN8G+hSgrGzrXV9NBbUsQsjeoO9Q+f1Bh0/cXoxHoHW
	JmdnYDrgnmF1F8ONM0pgFU0bkeG6Q8v1HgUPHoAU5Altk/DQkbnEAgthXaAFtW9DPdw22tHFvUdbP
	/25/jxeuO2vztwdFiNYsQAaQ8b5Eh6eR8A63fYmCUyqlq/Yyzc0q9kNMsL1XlvNLmWB2ESJnBhRhK
	KLuUFZxdDRsi9wRH9FCbgBzngd9kMhbFOODkzTeMdH8peAOq+V35LSpZYXgsWnLYySFS72oCW9zH/
	TRSWBRs/UGN/LfI8wYXhlC2EpPT8XUoOk8ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRSso-0000000EFHC-3fs0;
	Tue, 17 Jun 2025 11:45:35 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: ath6kl: remove WARN on bad firmware input
Date: Tue, 17 Jun 2025 11:45:29 +0200
Message-ID: <20250617114529.031a677a348e.I58bf1eb4ac16a82c546725ff010f3f0d2b0cca49@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the firmware gives bad input, that's nothing to do with
the driver's stack at this point etc., so the WARN_ON()
doesn't add any value. Additionally, this is one of the
top syzbot reports now. Just print a message, and as an
added bonus, print the sizes too.

Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
#syz test
---
 drivers/net/wireless/ath/ath6kl/bmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index af98e871199d..5a9e93fd1ef4 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -87,7 +87,9 @@ int ath6kl_bmi_get_target_info(struct ath6kl *ar,
 		 * We need to do some backwards compatibility to make this work.
 		 */
 		if (le32_to_cpu(targ_info->byte_count) != sizeof(*targ_info)) {
-			WARN_ON(1);
+			ath6kl_err("mismatched byte count %d vs. expected %zd\n",
+				   le32_to_cpu(targ_info->byte_count),
+				   sizeof(*targ_info));
 			return -EINVAL;
 		}
 
-- 
2.49.0


