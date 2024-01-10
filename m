Return-Path: <linux-wireless+bounces-1663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDD829B77
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701911F217C8
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3A4495F9;
	Wed, 10 Jan 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TgBFwqHI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward204c.mail.yandex.net (forward204c.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E4495F4
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
	by forward204c.mail.yandex.net (Yandex) with ESMTP id B5D37669E0
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 16:30:33 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1215:0:640:367b:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTP id E28CD60AEA;
	Wed, 10 Jan 2024 16:30:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OUioTjPwR0U0-gp35Xlqy;
	Wed, 10 Jan 2024 16:30:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1704893425; bh=juwuPDl4uqnBvOF7vL8FPFfRT2cdTQ/A3G/zNPWGOmc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=TgBFwqHIBiPJFNNjAHyCm5k6aCmX5WTnf9BjgaBjqB4MIvtdSoHAeWVIGQ3CtT22q
	 7fDrlloWlfwMn8ytzM02/1vivJIOh3lOsw3Fl8AJFVw5z6raslLUUCrNMyWJlEmVK2
	 5K89VWHCvW6kMnT6iB33WLHSsv+XH9tRuieI94GE=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtw88: use kstrtoX_from_user() in debugfs handlers
Date: Wed, 10 Jan 2024 16:29:28 +0300
Message-ID: <20240110132930.438828-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'sscanf()' is not needed to scan an input, prefer common
'kstrtoX_from_user()' over 'rtw_debugfs_copy_from_user()' with
following 'kstrtoX()'. Minor adjustments, compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 44 ++++------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 1b2ad81838be..5b2036798159 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -316,23 +316,13 @@ static ssize_t rtw_debugfs_set_single_input(struct file *filp,
 {
 	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
-	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
-	char tmp[32 + 1];
 	u32 input;
-	int num;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+	ret = kstrtou32_from_user(buffer, count, 0, &input);
 	if (ret)
 		return ret;
 
-	num = kstrtoint(tmp, 0, &input);
-
-	if (num) {
-		rtw_warn(rtwdev, "kstrtoint failed\n");
-		return num;
-	}
-
 	debugfs_priv->cb_data = input;
 
 	return count;
@@ -485,19 +475,12 @@ static ssize_t rtw_debugfs_set_fix_rate(struct file *filp,
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 fix_rate;
-	char tmp[32 + 1];
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+	ret = kstrtou8_from_user(buffer, count, 0, &fix_rate);
 	if (ret)
 		return ret;
 
-	ret = kstrtou8(tmp, 0, &fix_rate);
-	if (ret) {
-		rtw_warn(rtwdev, "invalid args, [rate]\n");
-		return ret;
-	}
-
 	dm_info->fix_rate = fix_rate;
 
 	return count;
@@ -879,20 +862,13 @@ static ssize_t rtw_debugfs_set_coex_enable(struct file *filp,
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_coex *coex = &rtwdev->coex;
-	char tmp[32 + 1];
 	bool enable;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+	ret = kstrtobool_from_user(buffer, count, &enable);
 	if (ret)
 		return ret;
 
-	ret = kstrtobool(tmp, &enable);
-	if (ret) {
-		rtw_warn(rtwdev, "invalid arguments\n");
-		return ret;
-	}
-
 	mutex_lock(&rtwdev->mutex);
 	coex->manual_control = !enable;
 	mutex_unlock(&rtwdev->mutex);
@@ -951,18 +927,13 @@ static ssize_t rtw_debugfs_set_fw_crash(struct file *filp,
 	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
-	char tmp[32 + 1];
 	bool input;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+	ret = kstrtobool_from_user(buffer, count, &input);
 	if (ret)
 		return ret;
 
-	ret = kstrtobool(tmp, &input);
-	if (ret)
-		return -EINVAL;
-
 	if (!input)
 		return -EINVAL;
 
@@ -1030,11 +1001,12 @@ static ssize_t rtw_debugfs_set_dm_cap(struct file *filp,
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
-	int bit;
+	int ret, bit;
 	bool en;
 
-	if (kstrtoint_from_user(buffer, count, 10, &bit))
-		return -EINVAL;
+	ret = kstrtoint_from_user(buffer, count, 10, &bit);
+	if (ret)
+		return ret;
 
 	en = bit > 0;
 	bit = abs(bit);
-- 
2.43.0


