Return-Path: <linux-wireless+bounces-7578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F08C3D61
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E384D1F21EF7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A2147C89;
	Mon, 13 May 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="IvXICKXz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3B1474BF
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589391; cv=none; b=FPR9v2YB3AcKA/+XmnA2+m9Iah158XrMuPq1FJylndYIHnVGvivgnVq16IV9L73okFfs8XNi++faz5f2pXpLVU483/3T3eq0dZmBPDToTeTDLBotQm/4maBRWHUUbSuQhUgcHh0gaqmyi8e2nyZoxhjG0PeBefrfM3DQu08SEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589391; c=relaxed/simple;
	bh=t7PMDf2rrvX6tfQNxWNnMVy4qxBUKQAMFLifA7YdZuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqkfj+5MY6GWWUPvBipL7mwbVMDkReDBiQH7dgaL7OfT42pE66oDt1EJoaFI9iQ6Zqhl/X1bgg929zQ503WjrCuuz8LbVvPEB7Z/Ga1bb28HUAPlM5os15GmgDzHT2YE67ZQiaQR3M390qWJ2WFFqd+YQaE9UrsVt3GJcTAzVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=IvXICKXz; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:de2c:0:640:e39b:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 163AA60B42;
	Mon, 13 May 2024 11:36:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HaZQu3Ho9qM0-8Jzux3U1;
	Mon, 13 May 2024 11:36:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1715589378; bh=hiJdAG0IiOqJzfvr5ICD+P1L13jouUZ1sJj6ghGQ+Sw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=IvXICKXzZsHICeftrEAKYm06U+ldpYf/W0W2Dq/WWAolK3Qcj1uWze9m1puAg/6ku
	 G4nuFf/lVoPO9lzz8Z1MDm+TcUcptMguRDK7MUiDtv7ii5Cr0eyHnbTnjeXd8YDVSX
	 2/lbZQVTVAhzdMhnnT6QwmIG15iyor81tr3a6A34=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: iwlwifi: fw: remove dead branch in iwl_acpi_get_wgds_table()
Date: Mon, 13 May 2024 11:36:11 +0300
Message-ID: <20240513083611.49064-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the first loop in iwl_acpi_get_wgds_table() always terminates
with 'idx == ARRAY_SIZE(rev_data)' unless one of goto branches is
taken, remove unreachable code. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index fa339791223b..7fb3cd06edbb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -745,10 +745,7 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 		}
 	}
 
-	if (idx < ARRAY_SIZE(rev_data))
-		ret = PTR_ERR(wifi_pkg);
-	else
-		ret = -ENOENT;
+	ret = -ENOENT;
 	goto out_free;
 
 read_table:
-- 
2.45.0


