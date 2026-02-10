Return-Path: <linux-wireless+bounces-31678-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAamEAqUimlvMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31678-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:12:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 204DF116302
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81BCF300D4E1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510112D73B9;
	Tue, 10 Feb 2026 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlW4B5Z4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061F2D839F
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689539; cv=none; b=Z2gOM+/yeqdWaGIWsfJg4/sLVveDZXehI07A53sO2CCQ9P7tKK0EeCvLu60rsPV1b6xSCyl/vnvdb+x6UpGdDMo0iuTF4+/LwXWrXHXYQTMZJuc8/T/5Pbw9Y5LJt8YjKZohHDnB1xeIe4w73PNyusKydndddgGHsVRXqtZCSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689539; c=relaxed/simple;
	bh=6bX8/xMGRWsvR+wM2XFaVaxjGc8kmMMKCV9NjfDvkC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBr17IjI4Ex/Vba91QZODFHJIF+ArnB9eVZGqPhoaJmIps+QIV067aYG4U9fugBf7u2Zw2Rm+Ku+cgBQtKUJUm0JUsZD6LPZjQ30lQogW3Zh6qq5nr1evnf9kSeBda22qrN3tsYC2QK8cboIYE6ToRUaZaNea+jXzaSpAqFzKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlW4B5Z4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896f6d4b6c1so27001656d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 18:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689537; x=1771294337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TmkS/sB9P0u36IZlhTWRyNkfWxpJICu9oh/U8A60Y0=;
        b=QlW4B5Z48ZDDiZqi6apNAFBypdSxUJaNi1vZO+rssD+301Iq5kCRbCdl7z5MjHDy/h
         Xb33VHMIo0wLeFFnuJtUFyRFVyV//aVeU6xRPnmeBxKocCreE/7jNdpYbOG4de0w3jli
         zFSM7JYJ8IE2WTFMlDH2shEQhoURCDU/yCxw6AcXEySrndLPzh3P2tXVkIfdZHJYzHWv
         LTGkR0zdi2tHDnPqJxYP7mbnvvJsUBRYBDDn4EPzX7m0yv6ujmNS7zsWP6GqhuPI2xfn
         IwBZn8SET4aZYhgAnxBtepK52hNSBkknZC397BMzD2qaOGD2NB0p1FfGvJtbmcru7HOk
         YE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689537; x=1771294337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3TmkS/sB9P0u36IZlhTWRyNkfWxpJICu9oh/U8A60Y0=;
        b=D38X3btZfvmpeKKAm81BHM1+F+U9AuUXoCWipE6zrChvuIeEMYuG61TAzWy9QLT76H
         cG5HmkSzipwuKtMmmoZ8+7pGkFepk5Y97DkUS29Ec/Lo/f3/6DX8tfVnbynvtoIFU2DB
         eo1kGwAOV0lYX1FIxpm+yg0Zsw2AgJAriSoxzcGgkUoNeBQhslUU0jgWu2ebPd8fTwmS
         EgRP10xNKDSdvLvtzGOX2k6KEHLD3SwKK0IhRWVJeh81jTw/BUNEU/98i/nUYs9h1Q8b
         SYThgIEJTYhnpyUVmH4wexm3NVxJI6H+v47DmDBhfyDr4VBergquNFh++yhaTm2/Hfed
         wjMw==
X-Forwarded-Encrypted: i=1; AJvYcCV75RuEHuV8mQDTsqOK+0teNOUWznYfdvLIKZ+HInCVAi83c1/QWkzyhlfM7G7DDh45eextrCHory14kNHobg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6cHk1rq0ysggnqbkfc35QgRXTgRvO2LdJkA0/DjI7Qf6rVuc
	NtI809H/8xDbggES8V4vs9r91Zg1/7EecxqxuZl04jeLvft6L7ruowKo
X-Gm-Gg: AZuq6aL+HfklFn2ap42JcWrjy4/1cfSLla+pmpLsDkXLnpUcqx2dP/mBUfqtui7kJJI
	AU7Y3l7pOyQzQHhl0yD6GOTQ40MpSd15xDx8TplVcBvvdaKxQv6AKqOM60JYOriaRttW4zCeLBs
	Uz76G7RGIhX7zNVhecZXhKyw+LkXArnBqGtMvBqubj00roqniRKS3ub3KyPWuxR9US+hyeJkhJr
	k5gsAQRGLlL0s+tmCrYJaeCO8LVJnIGJL0ambswu+lGsouHUARWRawEpPdSMLU13aeLWYcPaHfP
	K3uAs21zEAYsqznunaLjM1503Ms5nsebLc8b82ErxOgpmwIiwmO6BUCALcAN2YVD6Cmjbkc4/M5
	IpGOsTAG+dTcWZX6CEK48yv0eQfhNldTaFKwKsp4DAo8hMpYhbI6QxGLS4mYFXvMNpxDfrw4A/u
	xmsCVERdklzxnoRi4I95CAO03ZKO8jJpbQoZVHdleT3lfNbUjlmg+4OPm2FjHyDcAHmFSeJWZxQ
	KBxxz8XM+78PGQ=
X-Received: by 2002:a05:6214:2604:b0:896:ff71:fc74 with SMTP id 6a1803df08f44-8970e515dfemr9778796d6.36.1770689536988;
        Mon, 09 Feb 2026 18:12:16 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c077a8asm91300896d6.52.2026.02.09.18.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:12:16 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Michal Kazior <michal.kazior@tieto.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
Date: Mon,  9 Feb 2026 21:12:49 -0500
Message-ID: <20260210021249.12132-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210021249.12132-1-mailingradian@gmail.com>
References: <20260210021249.12132-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31678-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailingradian@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 204DF116302
X-Rspamd-Action: no action

When sending DELETE_KEY, the driver times out waiting for a response
that doesn't come. Only wait for a response when sending SET_KEY.

Sample dmesg:

	[  117.285854] wlan0: deauthenticating from XX:XX:XX:XX:XX:XX by local choice (Reason: 3=DEAUTH_LEAVING)
	[  120.302934] ath10k_snoc 18800000.wifi: failed to install key for vdev 0 peer XX:XX:XX:XX:XX:XX: -110
	[  120.302996] wlan0: failed to remove key (0, XX:XX:XX:XX:XX:XX) from hardware (-110)

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index da6f7957a0ae..73aa93043f8a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -324,9 +324,11 @@ static int ath10k_install_key(struct ath10k_vif *arvif,
 	if (ret)
 		return ret;
 
-	time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
-	if (time_left == 0)
-		return -ETIMEDOUT;
+	if (cmd != DISABLE_KEY) {
+		time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
+		if (time_left == 0)
+			return -ETIMEDOUT;
+	}
 
 	return 0;
 }
-- 
2.53.0


