Return-Path: <linux-wireless+bounces-10660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983A94068E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 06:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161ED283CFA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4051465A7;
	Tue, 30 Jul 2024 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="we90atOn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3020ED;
	Tue, 30 Jul 2024 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722314409; cv=none; b=IcAVf40dqYrPoSqn5cljKh0pfuM/Teiq26kgOqLJqZdHsLCmOjteQISKr1FRVeCvn0bv/P4usEsadsFxak3pA5P2kqurrWu+B0VFmDeLA4MRWhFAlKjNrkIboQhAjcT0h4KDXOdXxVXJbB1bOGbrWQkTUTjTKQQKz8dXAr0YcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722314409; c=relaxed/simple;
	bh=XiDL188/rgWgoXNXGwzqWxsPOSadhzk3x3tftD8iX8c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gJRiaI1xtN3RJ+As2TYePFp+XlwOqhmse3l441K7OnHZRWJqsWKb3boarab6O5isKFR/zkBq1XABWj6M5wrIkZ9FxFFqgORR1WS0dEafLGhYp8RyvkzGPpiLzDoVL7iWGQURiFnlX96eoxfmr201EFRiA4Qx6QQ0yBjCo5sHfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=we90atOn; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722314094; bh=sXjNvFilx2rKAS2O9td9vsxI4D7EIRyA7lpp20L0BiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=we90atOn7vskodr94MLpq5vEo8/Kvot6vvEuXJaKxlwrTUxMgwGVkDYqd/t/9fwVj
	 WpYbMb377b8z3jNWGbS+KamGh5h9wPiqla2EPw+aTZux/5xc2zHWAI3SUM1zzuFJ/6
	 cLJIcV2sqJTwE1x7I/z+aPIMGFjAizs6M0nWi5f0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 7292ECA1; Tue, 30 Jul 2024 12:28:41 +0800
X-QQ-mid: xmsmtpt1722313721tx0nsplrg
Message-ID: <tencent_03969636CA4BC874A7763F66D23D15366009@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69CNCExPRim/rkPqN5B9qac3EvVYX3WJ+MsTfMG8+Tv1MIAbbIoH
	 KV9LejGW2Q8gufc5CFT6IAaLTzymZsRsOqok9jG3+xwM/tNtoW60JxjkDK7WsgkdXDs7vbrh+0g3
	 TzYp8XY4xxP1Pw2RX4Ces0JMQla+kVEhSEekk1tEG3Cs+fZlrIdQqug/V7gfW7FV4XiSQfEXemyY
	 OgLDHlqMXzqMgB3J5KXxdKvu6HDf8ISP/7O7ZCOkMt0Xi0lX/1Ziu1MRlKCI7bS6rFwboPS0uXr0
	 3o66x5fP3rcekkCD6V4iMlG0o38wk1Ge2k8PB0oi4048M+hCYAWZA71TiYvJjTkAOx5wnNoFm4pL
	 a0WvDTsSRENMt2dgDJF4x8Zpm8YtJ/iBjuwjpbIBWDScIjTgIjgu1SOO5liGiImO4H4rkqloSMqe
	 96WqVjDDHvvh50UIyanb2LBYo/ZXT6ql7ZSH70i07qCpE6q3FhKApvlLhoN2utyPLv/1HPuxPPvj
	 LddhP74BFheej74iE7GMrsKUxtO/ILM4fxje7Ov90ndBCLQwbHNWJVB0se+RQjJIlZUsEaJZQkSL
	 KRIDV2ec6Kok+q0g+6hMY3QRr91GM3XBoOnC31FFzjolCsctUHiq8lgdDUSWo3+BnSSJQkGiRwRy
	 02Ppru862dYlUsDzohT0VTE/XtXAwIHzk2XeLpNqz2+jO1Tbt1mDx/NOyGUjdDEGxam57nViGvui
	 PdaJWW5C60hu3HyaQEgR2LbZjsf/FefHhYFmGJglaX9qu8SURLUEd7wd+KzTGuIKc7hdsH6xL6s3
	 M3Zyn1GNLUxIVYTFc7ggCXOt7nnRzq9Jald/HYpbpVGRJ9APUKybx4JdoFZ4kB13Pmwpz32WpMqm
	 4X4/b+vTns60Yb0QCgjDDCLM2i4yqDFQVfFMQ+bJMmKc2ehrbAM4pSqmKYJlztm9XiY9w6rnbhNv
	 k2iorrs6316wpgvGrcNxl4bHuvsFTxENhRWVBdTOg=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	srini.raju@purelifi.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] wifi: plfxlc: remove assert for mac->lock
Date: Tue, 30 Jul 2024 12:28:42 +0800
X-OQ-MSGID: <20240730042841.99528-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ac553b061e675573@google.com>
References: <000000000000ac553b061e675573@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report WARNING in plfxlc_mac_release, according to the context,
there is not need assert for mac->lock.

Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")
Reported-and-tested-by: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/net/wireless/purelifi/plfxlc/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 641f847d47ab..f603fddead90 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -102,7 +102,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 void plfxlc_mac_release(struct plfxlc_mac *mac)
 {
 	plfxlc_chip_release(&mac->chip);
-	lockdep_assert_held(&mac->lock);
 }
 
 int plfxlc_op_start(struct ieee80211_hw *hw)
-- 
2.43.0


