Return-Path: <linux-wireless+bounces-33982-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIP7CB9TxWmD9QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33982-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:39:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D645337B5F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDD2B3006920
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC8405AB5;
	Thu, 26 Mar 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBZS+hHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC0407108
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538559; cv=none; b=kes7BQDpXvbU8LPLfBHbF/DuNPdW1B8Wc/mPCW+OjEhiX5pBrHG/WJI3eUccxkfgcnVJyHLtfo6UjPH8JJsCJV4Lm8Ii0PcIX2LQagDldHw+Dt3E7Ks+dkohJ51JvG1/3m1XKCE7yIJ+sHAKD/NkEyiin6vl0mwEQww2VPlzcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538559; c=relaxed/simple;
	bh=Z6N6qAzbNUdKD+XYgNO0O+1MIg0+wrBX7lyCLu6aj5c=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QLny/DXXpkWZ2szPFNs9TtQvYyW5x7aDcj+eLeKYI18Z8Aev2J7cLAarRKTMMaJgFEslZ4f0pgwhgSg4uyTx0Ewy+kSvyke6z9DeszcEy5V6JRYuFqcA4Yic1/PzYaiChdsOmLrr8z+H0KewXmm8WkkMZWzwIYxv9KiV3IyMLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBZS+hHm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so9766645e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538556; x=1775143356; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4PFOcF5HE+7OeOjbhfzCQjr8us1/sPAAYr/tjk0X3I=;
        b=FBZS+hHmyGYqkoMWPmfcuFNsM46/G1dMpuoKcEUHUoRm4jmWarrKtgjHACez8CDjHy
         m2mo2Os7Vm8FB2H9PBlEwrtPQB4jgE7SJVakhlfcfK9MwuYqeZh8zOEdRTtKOv1mEHbg
         aZ03ZJ9hmFiuZlUa4AAlvE1hq+biLSNbpXoSofHVEL3HfUIA/2TcNfiJWOGiW1+fUrvl
         prdNc/wmTB/GjA9PyQu0RhCjf/V0VZj6ykJVfXOhSkPFxgZcSXRmoXfMBTIUBA4R0bH9
         BT43YCdjFyWm4BIyLVJRzP7ek1YkRGek6qM416RF1uqSN4mOA7j44r1QVtnZh/HB+lqS
         7f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538556; x=1775143356;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4PFOcF5HE+7OeOjbhfzCQjr8us1/sPAAYr/tjk0X3I=;
        b=ccgWtCMSEJ1AEWNQEZYSWFkWD6VEnKOHXHOQQHRkTbB8vpOPhsbNnmi8zNfLfnhk0V
         h+PjKHDvpDcDagYubabs9PZjxm8oJFhM+/mlmlEswICUdOUgk7Ho/4zE5e5wkZXUtv2n
         UmXPWFSxm4SURPfjfw2QSgVXGHo1axJzVW40yrpY0sjiEKTM4Ze7vvqJsvh5OIplnwJV
         zMpBn7x2SCVV2YbFK//Kxlfxx7VQdce1z2nBUpF3/2URrmPSC/DT3L+5tU33h9UFhwvx
         /aMjOmUoQl7pZzVh0hW44sJCg6pPJqdk5TR/YIs8RJWr8rRdCqjZ0pl3rJrQXRGMshBG
         m+7g==
X-Gm-Message-State: AOJu0YwnTiOEqRZ94xE4HvX7egnW9gx0sA0phE40vzjhHi2PP5wNZclZ
	KqkEbLQxLj0RBT3nKgI3158YloXa93OUY3Z3Ya8KHFxl9rNR49LSYOVZ1YRtaQ==
X-Gm-Gg: ATEYQzy6WZfMTxmRgNuOjunAWr2bTuyaBHSfWhvySGB0bgl7bsJX1wT+h5sd/ZGj1q2
	xymu9/D4QofIzeDNjlTH9sXO0S5PYJwQPXB/YXI+7AAGWvvl19XmPUJPyTpRVWedFhAG1D+M3gy
	xg1YBqX5Ywoqx506EUpDoHz47/JMUn/0W2VbNnbptiKBdgA5G11V5C1P/fSbqTbdmsAyfgfXBP0
	GjnvGtg27kctXUc62QLLfoH7RnehYPCdrTJ/41ocEVvdwYLCkFLRJs2yyS78YMBnApFnBBi+GzM
	AoR0TU0cMao96yZH2eM5/dQSIOWNyjYAQVUgvKeVoXAD+Pfv0/lQavQIuO6kEGSHj0efk1/cUvX
	WOWbRHBc7opkwRylgMAQ5R3a5D4qzcozeVH1KMllf0s5z6e9k4NM9vxSJ9CJ5DBBgewS1SxnW0Y
	ajbxL/fYe/QsSjc9YvnaPXkjgeVjBc4w==
X-Received: by 2002:a05:600c:c10e:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48722b93132mr22577305e9.3.1774538555752;
        Thu, 26 Mar 2026 08:22:35 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d49c18sm35491225e9.14.2026.03.26.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 08:22:35 -0700 (PDT)
Message-ID: <a46ed12c-387c-4063-849c-c6457bf97810@gmail.com>
Date: Thu, 26 Mar 2026 17:22:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2] wifi: rtw89: Fill fw_version member of struct
 wiphy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33982-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D645337B5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let userspace tools like lshw show the firmware version by filling the
fw_version member of struct wiphy.

Before:

configuration: broadcast=yes driver=rtw89_8852au
driverversion=6.19.6-arch1-1 firmware=N/A link=no multicast=yes
wireless=IEEE 802.11

After:

configuration: broadcast=yes driver=rtw89_8852au
driverversion=6.19.6-arch1-1 firmware=0.13.36.2 link=no multicast=yes
wireless=IEEE 802.11

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use local wiphy variable.
---
 drivers/net/wireless/realtek/rtw89/fw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 45d8c5e70084..af9e1011e9b5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -730,6 +730,7 @@ static int rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_fw_hdr *v0 = (const struct rtw89_fw_hdr *)fw_suit->data;
 	const struct rtw89_fw_hdr_v1 *v1 = (const struct rtw89_fw_hdr_v1 *)fw_suit->data;
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
 
 	if (type == RTW89_FW_LOGFMT)
 		return 0;
@@ -755,6 +756,13 @@ static int rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
 		   fw_suit->major_ver, fw_suit->minor_ver, fw_suit->sub_ver,
 		   fw_suit->sub_idex, fw_suit->commitid, fw_suit->cmd_ver, type);
 
+	if (type == RTW89_FW_NORMAL || type == RTW89_FW_NORMAL_CE ||
+	    type == RTW89_FW_NORMAL_B)
+		snprintf(wiphy->fw_version, sizeof(wiphy->fw_version),
+			 "%u.%u.%u.%u",
+			 fw_suit->major_ver, fw_suit->minor_ver,
+			 fw_suit->sub_ver, fw_suit->sub_idex);
+
 	return 0;
 }
 
-- 
2.53.0


