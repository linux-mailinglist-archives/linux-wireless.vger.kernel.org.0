Return-Path: <linux-wireless+bounces-35875-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB3xAULI+GlQ0gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35875-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 18:24:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B04C1505
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 614453012BD5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E1392C32;
	Mon,  4 May 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+oF/KBu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317C3DF000
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911870; cv=none; b=SSczY5LWjiAjbhlJuldBxaAiNX1o4W5HzlQouja/E477QbEZdYfs5yRRgRpJ1HESu9VeADbhw2p98aK4e34YCg+vj2fWayzy8emoNPtL3juaJVGReO2wCHjXSgpyuffA9gFnGhNQsBDUlBqtYOsjXB+HeMWxnATHtJUMiupzJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911870; c=relaxed/simple;
	bh=xfAO+pK2b9Twu27Oojf40iWWw7/hTmzTPGS80iGcUBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7hB8i+BLVXOfVhBGTMsxaex9/4vxN5JTa5hPKcL+gZEg3vmMj252nXp1KA7Eo0tKMoECh26NVC1kpgLWpxCgI58+BNWssBBIRTPXTajpiG8JS3KuAycJjGny0kh43K1rEvhojLpQnZi1IcZ18RbxT9vXR9TsjTdsMqlM7Ofi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+oF/KBu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso52086565e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911867; x=1778516667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XxaIq3T5Mc+yT3K+sss6W5ruPX+3m8vGwZQZ7mhSm8=;
        b=T+oF/KBuEO/+ay9Z4Ygq6Gy99pBKX0ZP0pdiyam5zR1zNfWU6XyVbG37MYCkzPknmc
         mYuTn4Sw7ExpdTeFtry0QNImByvcpHphfGQMVmgJu6Vc6/BK+f5AZhQXCss6Rv9RGTrK
         eDs9S92X0S1Y0tr0Mr56mQWDc0VnYo06jZCikp1nYBuvnT6u47aUd9SSmjlERHdtu5Xk
         mwiQWsciw15uy4oxefGjC0l9aMYv4ykuKLeDgfCcS674E83y5GJq4qrjoyjTzB3MOj5h
         +zCs2y2HvOiVD/D8BUu372EttAPbZ9C8B+ZaSFtsNMqKHPmOq1KGfKlZmHyTppgf+j9i
         FbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911867; x=1778516667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XxaIq3T5Mc+yT3K+sss6W5ruPX+3m8vGwZQZ7mhSm8=;
        b=lQn0EY/xToUkr0y3N+HH/mlkwIv8S7WG0yTODlpm1n8X+ofRwLPxjyKvP6ODwHQFfo
         f+D1eb9qBx0pOdw6nA51pXLCe+YTHfRqi8kJE7lHw+u3kSb95Pkjx8vyCDH5PFV1JV8H
         41uAgYNVDjTmQFBMOJIB4enz7437rNNxATM20+DQeAxlVK/A7r8LnJ+grECkpNh4F1Uo
         bV+azoM0ibsTSZN5mjl6K3jn1wFYa5K+wIs9r3ksDCJq3HkbLBzUNZv3FJ5iQkG2re0U
         LjtHePLnFMjuRo8xMx1jDitMkVJU0Ds4onfjdL6vsHMwfmDimWU7hUaJ0YRZN5R55ujO
         +whw==
X-Forwarded-Encrypted: i=1; AFNElJ9mtXX9aYZEXimlqoZ4DltH+tigB0eVh58TVrBtUa+U+XtApYPaoqlu/m2Ulpz9YNoKiWkPT00Di/2ZD2T0lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdzt+oajl5OQpiiwet6GKbMaPxwpcPYbNSgPADl+lMngfZWU4u
	RSpo0wSI9+W7p6AjITDQbZVQpseSoRtSUtkyXp4fQeaK101TP7TPdkk=
X-Gm-Gg: AeBDieusrFpfI+eXp9jDFbB/gqVdiJBMERUr9QY8oCtpmHmXwUNDCNvML7Sg77VSCRh
	pajTkSMMNLbk7QJir12sbKOQz1Dq0r8dlpQ3Q3uHJ+2YBElRleM+j5SkjfKI0NT/8Hs2fZ23AI+
	b1AAIK3/DBNvUziLRNweVHtNZk8HZXDVTAWbzOyIMQatmIbdIl76MZelg4N7UQBkxvLE3dS86jV
	8Cpd9cY3yoTT5MPa8TM7KIUTv9F9MCkfRTwvwCfn+wHsC9hoq9WLa5ddrk7UBet+jwEwQYpyUu/
	N4VIWU6t1bkqqGB+iJ+MCKKQ1stmsqBSfpBsJHLE5RukNGud3IlmVJ/3S3GXBfsT1iRu9oSGlpR
	+o8yNpz7FpdfsZlJ0TkFJwrVtE7aldz4GbX+T279lPkpVadj354R4zrZzoseHaI7sXoi8Og352R
	f8TDJDngpacSfhytHIXatG1754/1kkv5vJg++quRK5SfqHjtWWRmrfRQ7Zd5EK2CgXeuXNhNA+M
	xX+5/5GQNnqR2EWqGzJtGyvszfU6rlV
X-Received: by 2002:a05:600c:4f8a:b0:48d:46a:6e43 with SMTP id 5b1f17b1804b1-48d046a7074mr113324415e9.5.1777911867283;
        Mon, 04 May 2026 09:24:27 -0700 (PDT)
Received: from archtop.localdomain ([2a01:599:912:6541:1453:2633:891c:c05f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fede418sm105107585e9.6.2026.05.04.09.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:24:26 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: jeff.johnson@oss.qualcomm.com
Cc: dcbw@redhat.com,
	jakovnovak30@gmail.com,
	johannes@sipsolutions.net,
	kees@kernel.org,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linville@tuxdriver.com,
	mingo@kernel.org,
	skhan@linuxfoundation.org,
	swilczek.lx@gmail.com,
	syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com,
	tglx@kernel.org
Subject: [PATCH v3] wifi: libertas: add wake_up() call to properly notify
Date: Mon,  4 May 2026 18:23:57 +0200
Message-ID: <20260504162356.17250-2-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C7B04C1505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,sipsolutions.net,kernel.org,lists.infradead.org,vger.kernel.org,tuxdriver.com,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35875-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]

Currently, when the firmware is not fully loaded and if_usb_disconnect
is called, if_usb_prog_firmware gets stuck waiting for
cardp->surprise_removed or cardp->fwdnldover while lbs_remove_card
also waits for the firmware loading to be completed, which never happens.
This caused the reported syzbot bug. To address this, the wake_up
function call can be added in the if_usb_disconnect function which notifies
the if_usb_prog_firmware thread and resolves the firmware loading.

Fixes: 954ee164f4f4 ("[PATCH] libertas: reorganize and simplify init sequence")
Reported-and-tested-by: syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c99d17aa44dbdba16ad2
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 4fae0e335136..22f0bd6a141a 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -310,6 +310,7 @@ static void if_usb_disconnect(struct usb_interface *intf)
 	struct lbs_private *priv = cardp->priv;
 
 	cardp->surprise_removed = 1;
+	wake_up(&cardp->fw_wq);
 
 	if (priv) {
 		lbs_stop_card(priv);
-- 
2.54.0


