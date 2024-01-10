Return-Path: <linux-wireless+bounces-1659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E440C829A11
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAE31F215D9
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32647F47;
	Wed, 10 Jan 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="MrY5VSu6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205c.mail.yandex.net (forward205c.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1647F5D
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
	by forward205c.mail.yandex.net (Yandex) with ESMTP id 1BBEF6651A
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:54:54 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTP id 8AB7060AB0;
	Wed, 10 Jan 2024 14:54:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hsgknrDjA8c0-CAT8gXYb;
	Wed, 10 Jan 2024 14:54:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1704887685; bh=7Rzw0yOYbXR448P7VBVS8s0ZMczc6x3BvrVsOrngqBg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=MrY5VSu6Ku9bZjil6vnqEJT+2DhbBjwiwpmmsbYiz5c0o9Twk4mE/ZGLjzRkoB02j
	 cNHebFaAAi1Ppn9sPA7CwuC0bisewWUsRtHvyLzBDUnE1m8VJUkQZgSEDqH2GzNXIm
	 JetLzxXToFXeCwqpB34mw2+Eg6vXUj2kXTFIPDtw=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mwifiex: use kstrtoX_from_user() in debugfs handlers
Date: Wed, 10 Jan 2024 14:53:11 +0300
Message-ID: <20240110115314.421298-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use convenient 'kstrtou32_from_user()' in 'mwifiex_verext_write()'
and 'kstrtobool_from_user()' in 'mwifiex_timeshare_coex_write()',
respectively. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/marvell/mwifiex/debugfs.c    | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index f9c9fec7c792..46061bfd0c84 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -566,14 +566,8 @@ mwifiex_verext_write(struct file *file, const char __user *ubuf,
 	int ret;
 	u32 versionstrsel;
 	struct mwifiex_private *priv = (void *)file->private_data;
-	char buf[16];
 
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	ret = kstrtou32(buf, 10, &versionstrsel);
+	ret = kstrtou32_from_user(ubuf, count, 10, &versionstrsel);
 	if (ret)
 		return ret;
 
@@ -874,19 +868,14 @@ mwifiex_timeshare_coex_write(struct file *file, const char __user *ubuf,
 {
 	bool timeshare_coex;
 	struct mwifiex_private *priv = file->private_data;
-	char kbuf[16];
 	int ret;
 
 	if (priv->adapter->fw_api_ver != MWIFIEX_FW_V15)
 		return -EOPNOTSUPP;
 
-	memset(kbuf, 0, sizeof(kbuf));
-
-	if (copy_from_user(&kbuf, ubuf, min_t(size_t, sizeof(kbuf) - 1, count)))
-		return -EFAULT;
-
-	if (kstrtobool(kbuf, &timeshare_coex))
-		return -EINVAL;
+	ret = kstrtobool_from_user(ubuf, count, &timeshare_coex);
+	if (ret)
+		return ret;
 
 	ret = mwifiex_send_cmd(priv, HostCmd_CMD_ROBUST_COEX,
 			       HostCmd_ACT_GEN_SET, 0, &timeshare_coex, true);
-- 
2.43.0


