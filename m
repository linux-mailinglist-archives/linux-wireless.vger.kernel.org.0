Return-Path: <linux-wireless+bounces-29772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E343CC0E95
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 05:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B001E30FF561
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 04:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0533DED3;
	Tue, 16 Dec 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5n4gzbj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA682F4A10
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765857655; cv=none; b=N/crNyo3Sw1Evg4wqlEemDEMoY1P9/r7IjirxDQ1zwekXG1CVtuuQO6iGh3kE1V58KeDrS0w+g3fmIaEYb/+UwsTUKrp+4zXR9vxhUClLU4FaHwV+6waBx/ftLbXzhBubyO30i2QYjWycoH8sS4FmpXZLdmoPxKUlkblLSp1Vp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765857655; c=relaxed/simple;
	bh=ITo4f1ye+3ONUsUTYHIV9+vq45fgxRSCb5RTsvRpKEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg0NLDuIT+9p5IFEf9wnf7yygQzDqMDYNIpbgHErmL9cMjMBfQZ+TPsEQ2V0TrkeJddILTGsFK159UVnBjV9EET4Hc3NJi6CORi3knzReHmWKI02n79swGRtSPAfwjTcPSVLp6xCE6cm5Zr9zFHA/HLM9wZnRKyh52Qc+DxVvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5n4gzbj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0d5c365ceso26112975ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 20:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765857639; x=1766462439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLKyDg7KGa0B81T7SZGWL6KI4wf1AUYvxVh+ahhXSkw=;
        b=N5n4gzbjncynyYA0w2JSsdTM20zwfhf2xcyQR/q4NbOOFfLSBWd5CNKJzM6BPg/zO7
         UpaTBtiN/y5lYmK5s+crof4t4SlYZ5pOIBb9pAxwwFxS0WKQwu45ktJZbPimdgXfv3xf
         HLmm6mpVQ/hqZHUY5bmkyUphRc50XgrHAH5vR+n6352eRSZYocW9Xph+8qDFXlz+cSfd
         3ghRi9q0POZGSgo0AFBCHD4A/k8ehwmzqAr5THjMsjACCy//qrAhkFLWo6I23sXRoMyf
         vc9IjjtU7kiHgAXwNxa+diPtlz24zWDsx/LKuoMpZF1qsNfoaRaIsIwOyHMmA1dkym9F
         UCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765857639; x=1766462439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLKyDg7KGa0B81T7SZGWL6KI4wf1AUYvxVh+ahhXSkw=;
        b=eMS4MpqIKP/cMPCDdJqUEtWDJnNopH1hsqI/4iUWfmz7gEV5peiMMYxvNLpgpm4DCp
         DNyCWdzzJtbxq7HVuzgKCOPNdqTWm0A33Q8Lh1SGsz3CXvBFYyZq2vn8gz9TUIDBOSHg
         cOaYBQ11ABScKwO2I3VeE2l+BXuuODZXMVSbpGBq0UAnZmc4Np4CDscl2A1OZtac3yd1
         2H8ndxqdX6Owi9zOLMnJHx6Y0+Sgc3dEaSZYsJte8uZogkHhEGf3N4SMUQGGQRXZa8ph
         uLvg4D2U5In99clZLdxGx2TOsTNI1rPO3+JbxnFC0zlAB+7T6A8sOizrfOUP0EbmKJ/V
         jbAw==
X-Gm-Message-State: AOJu0YyKkq+aIqxR4ib9BkBgKKzGTpZYtzZy/D58cyvqJmZga+Mf0bk3
	aKNjQyXyq61PL0fp86Erh9/8b96eyZvWGhkifbkBaCm3Gez1ShYEtZagqzvu9w==
X-Gm-Gg: AY/fxX7l3ZVsLxz6XZUEfjeL2vpYm7z/j6BAGW1YhRgkMIrNNKT61B8yBTZhhrGM/fo
	q5D6xNFkqfKKaW5nKXBMVhTkWS0pXPsv132qsl+HOcY+wyePGuFbVIqI8dRho6e+PRO4yKaJwBd
	w4UkHhaM9510pY2dxyTaiPuqGktczyz2ImltlGxT7JYspEsPQX2+laQcGRpqEn8kOfaAPxxQDU5
	l5crDUchzReM9mqDxNAi5jJbaqUFxu+x4DJezqUQXgJsGXcod0KPK9SzRPnWZwAPFG9rBJogEHq
	2fec/swl8le37FqVrdMyXZDRmo1hr4Vt3VjkownrOKtf83He+GFEUX0TB/SgIgUY1r6mucZ8usa
	soMRGQJCVevT8lZIREW3m2ZMRchLYl3xEYPPq51lU0ZcENz2HGaXHMUhuhbVWhuH4dfy8LkyBy0
	f/VjECtjwoguZN4xK9qHac7pI6JJzQQou9DlDlFOO8SM9qlb9PGSp++QiMGWgUGiZx
X-Google-Smtp-Source: AGHT+IEEhzEnRHF5lq+yL/BRtzeP7AhvEd4LTzPt9a719vVEkCoMqCzaOFQDfNuqe4rQ5yUe38aR0w==
X-Received: by 2002:a17:903:3808:b0:29e:fb50:5bd2 with SMTP id d9443c01a7336-29f23d29df9mr117486945ad.58.1765857639374;
        Mon, 15 Dec 2025 20:00:39 -0800 (PST)
Received: from work-kernel.moonhee.lan (d75-156-73-135.bchsia.telus.net. [75.156.73.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2c1664sm10289995a91.17.2025.12.15.20.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 20:00:38 -0800 (PST)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] mac80211: ocb: skip rx_no_sta when interface is not joined
Date: Mon, 15 Dec 2025 19:59:32 -0800
Message-ID: <20251216035932.18332-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6940d2ef.a70a0220.33cd7b.012f.GAE@google.com>
References: <6940d2ef.a70a0220.33cd7b.012f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_ocb_rx_no_sta() assumes a valid channel context, which is only
present after JOIN_OCB.

RX may run before JOIN_OCB is executed, in which case the OCB interface
is not operational. Skip RX peer handling when the interface is not
joined to avoid warnings in the RX path.

Reported-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b364457b2d1d4e4a3054
Tested-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 net/mac80211/ocb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index a5d4358f122a..ebb4f4d88c23 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -47,6 +47,9 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	int band;
 
+	if (!ifocb->joined)
+		return;
+
 	/* XXX: Consider removing the least recently used entry and
 	 *      allow new one to be added.
 	 */
-- 
2.43.0


