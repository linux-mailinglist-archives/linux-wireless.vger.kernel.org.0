Return-Path: <linux-wireless+bounces-11894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD6695E257
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528B71F21E0D
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 07:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BD555C0A;
	Sun, 25 Aug 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rCQdQiKq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEA54BD8;
	Sun, 25 Aug 2024 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724569814; cv=none; b=IOQYoq1WyosMAvQ1wIrsgn1VwsJGhscwjnb5eWItH8MLMJdp+dwXIxjz9qNIchk4M324zGnK5HjKzY0uJpS8RgtrFAMyGmz/oH5W8A1e+Emj0mOZNUfz+qhVQf3QCtEWt5xssF1NmNmM5qubxmoiOj72EjW4R74IVJOYRIifqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724569814; c=relaxed/simple;
	bh=Fj/EmX7ib+Lfvn/AxCnJP32ADVfuI4FzB2LfAg7KANc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tYLirvwmdk4KgF99ASAG0ZkfKyzOAyipnJC6ERaIfXJ6SM4NFW60gxK2oXgbr2j+zznuYHoYXP10Jp7U2dgmKv02G9o4t5zbRxDKc3zGupILAbPcQdrTs+bm8gp0K9luiDUGBeh7dlm6xXkrtpoLr78Azp4tbhx6PoCplwUkIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rCQdQiKq; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724569805; bh=/semDDU5zsCaTr6xGw92C8FIyWfsAShZ+BMdvutBH7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rCQdQiKqdwBpZo0lLWp/KeDov4Lmng+Nrl4p0iIuXV4UwluS0jLjo925APk7JrquH
	 X4uGT7aL1tFpFk9VH6hSJknXoobn4ydij8Ogyh9lR5SUlAmt12DpRJJSjaVmnsIGcM
	 WPdPyuMfJEVqCfGC90y5+iXLxDqllTjWgenMM5iE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 282166DE; Sun, 25 Aug 2024 15:10:02 +0800
X-QQ-mid: xmsmtpt1724569802tzo9ofaex
Message-ID: <tencent_8D19734F828DA6A5938DF1122F5DDC5DBC07@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcri8+zm2SchNSIlQI0PU8lRV3EsHnwgGb1XrYFR/S8hz4dSIvMx9
	 xXqqhxW7elDd5E44hOZSxQiaMbhnmYSTz3CvwSYxiFodjRj5nYkLylGLpkUztXyaJy+ElKFbl8AE
	 tZ0yVV2R+YhZa9mSmbUKbmYNXV3sqry0x5oTPa+DbvMP1pWzywfDCgMMrXdF/sapBAGBmJsx6WDN
	 QIa/9DdZhgzxSz99JZE1HTb5KVar88esE5LUttT/8ba5gGnCffUr2ncargrCEpht3IDBKWoPpbh4
	 ls3arvy2tS7lXgA0eA0AljB/FNKiQJ1ilqRUfzNbe1HgYdWNMSsA5YNHqbgGsr3LkDZTxlWCzZFE
	 +KuqyhdTUStiU7ccIrUOYgN0peKkiw2cClVKGhkhOJIQUsCd1xG0vRZ1n03fAETw8KeaH59eVBiq
	 JdU5Y+z0qcvKiUYuXdGGxTQH4fni+YW0gJXri3h1caacj0imKTZOJvem/gmTiJh5U/aAYuWVT2az
	 uJwUYadWcG6c86CD8ET6Chc9T2vYUjj8PW4yLirwwdrXlJCY2ZVDB5UUkuxH93iD3a9V2rMO0TmA
	 QWsdzj02hGpENA8Z0WEbA0q6n6wcWVBOE2iDf/7/vBdib2H0Lo5Rq8l3GvMJ/th+0Q8FKUs9CLRK
	 FiVFVpUCykP+MLX3o1Ny4zGA7vnccoeSK33x+3qppNswFtGaHKXG1Ta8/djhH8VM9vNXXROAxLz7
	 oAZkG7ueftWinU2fYhyNaUk7ri6NJ/U8yueFC0AJzndn3ooBzAQcK4SpGwVMO3wvbbx5fo1nZCP0
	 BEHkID9eEZWEObjwzp1maB1SoCW8NcgOtJzQadpB9Dr1GKYQCQ/iyjBcKMtCnOfLSX/z5xAAjMIM
	 LpMb2baDKJ9fPhWBtGt4j5r032tD/9MOb9EczCA8PWsa1Dmfqyfl3RlngUMUayZAxYICtJE7u6Bw
	 HbJFSdhLI=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] wifi: ath6kl: Check that the read operation returns a data length of 0
Date: Sun, 25 Aug 2024 15:10:03 +0800
X-OQ-MSGID: <20240825071002.2186643-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <00000000000096ee8f061e991433@google.com>
References: <00000000000096ee8f061e991433@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the data length returned by the device is 0, the read operation
should be considered a failure.

Reported-and-tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..2a89bab81b24 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
 		ath6kl_err("Unable to read the bmi data from the device: %d\n",
 			   ret);
 		return ret;
+	} else {
+		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
+		return -EIO;
 	}
 
 	return 0;
-- 
2.43.0


