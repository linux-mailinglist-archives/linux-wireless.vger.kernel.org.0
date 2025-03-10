Return-Path: <linux-wireless+bounces-20123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65198A5A712
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC1B1894093
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C01F78F3;
	Mon, 10 Mar 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ0EwmFB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94B1EB5F9;
	Mon, 10 Mar 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645417; cv=none; b=u2W0P1qP8CZwlp9Tj0TR29svxS3anVcSHogu2Uy0uswqeNtmIYCbZLLRmgEiSKpo/+E//pj7udUOws87h/VtvvEbdsqp05XzvGEYXi6jtsPkeqbcaRbwH1iIslPsqpmBkefntIReJOrE2fLrRjNTgNDo8NUVY5OnpjBXpVD01ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645417; c=relaxed/simple;
	bh=2+6ZO/oPRxkdefmrk9PnkzTj44ztwhJRZEsFOK1nMd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iC+1ArKY8N8vKaGeWbDFtfTauXnEE7IUMnRkPElNKvtivMfIrUAjabRZg00dF+m7XpJLzFOfm1qq/Cpe5tsEPXIXaWQdmRPXYhUWoF50veN+e1zRzQehCW9pfhf2GK/GRkiI5rMBZ+43GvcjL1HAAHo17+Tk3LonfMIraFZ+zxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ0EwmFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367ACC4CEE5;
	Mon, 10 Mar 2025 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645417;
	bh=2+6ZO/oPRxkdefmrk9PnkzTj44ztwhJRZEsFOK1nMd0=;
	h=From:To:Cc:Subject:Date:From;
	b=eQ0EwmFB7+RaIqaQzFiGHK8O5dp56NgOgoJISZ++0/0oIEnPNXWsR4NP0rPM6J8TF
	 TaICbmeVSGtw4HcfTQTB2BScijURXCUdiCujy7VixpdQCa1Tm3+fRW9n+JhHlIkC4i
	 BstgQLM2Zw6jH/1CVDCg8AvuCYaFnecos0Bqmg76kZlW3sSbIAwiAUixX1VkRSaxD2
	 Cjd+ZaDzt4yjT93H5PwCfCrQIXdh3jFBOsLWGHxcoWmIsQYw5UvQyb63OOfKCwUJPv
	 HGNwKL1Gn5Qp5BbeIOaOjIVaMz0Y1MX5/sSE3TNpvKryNOZdtLsbTV0fke8UaU+ssZ
	 FTtFMPV1FEVvA==
From: Kees Cook <kees@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Kees Cook <kees@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Allison Randal <allison@lohutok.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:23:32 -0700
Message-Id: <20250310222332.work.202-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=kees@kernel.org; h=from:subject:message-id; bh=2+6ZO/oPRxkdefmrk9PnkzTj44ztwhJRZEsFOK1nMd0=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn01LOWq1Kfx4mrXAg8v6PoJh0cWb/2KDjRxQa81Miz lZv5OjoKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEhqOcP/qkSnbR8r/+ctWBjf 6xk0dVfyC59lJwX2u87cclpoxTdWMYa/Ii8LNomubpM/ajh/78SzhbNFC9ydJbqcbbITjl1eKXq XCwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Allison Randal <allison@lohutok.net>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/cfp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfp.c b/drivers/net/wireless/marvell/mwifiex/cfp.c
index d39092b99212..d7fd79214bcf 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfp.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfp.c
@@ -150,7 +150,7 @@ static const u16 ac_mcs_rate_nss2[8][10] = {
 
 struct region_code_mapping {
 	u8 code;
-	u8 region[IEEE80211_COUNTRY_STRING_LEN];
+	u8 region[IEEE80211_COUNTRY_STRING_LEN] __nonstring;
 };
 
 static struct region_code_mapping region_code_mapping_t[] = {
-- 
2.34.1


