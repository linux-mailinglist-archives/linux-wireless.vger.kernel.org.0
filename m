Return-Path: <linux-wireless+bounces-12595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58196F36B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 13:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8661C2428E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C111CC8AE;
	Fri,  6 Sep 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA+ykTYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB41CC8AC;
	Fri,  6 Sep 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623121; cv=none; b=e5b8AkIsX/Zfr58hdt0pnDBG3r5v/O5OgrP1rWCu5j3uYjFPVvgmDkK7Q5YawGBeWS4dX8LrzMFsAjkaSkzeDZYdVG86/kQMzlXe7fkAKAZkPQ4ZygKtKQmHdQNKt9yo+N4nUA698GwWLDwl67Km5kTmjU5mdRWnP/D2bOyYCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623121; c=relaxed/simple;
	bh=YY4MtiQuuKv/dti/LA9N8tzXF134v6ZTEYYwdq+qm1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lObBG+4QH0OZ7k3DSe8G+JwAOPRn6JTuueL4rDOu58AQwW4JRzA1RruDE4bdqXGL66EpfY5n76BhjB4G0NEzo5aNDn9SHqsLUqNUJVfEXZuhzQrPQzMMTgwTEcjog1whA4u9U075Z79uJy/SesiBMOMjoVWsNc+gR4szbraNhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA+ykTYL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d892997913so1344237a91.3;
        Fri, 06 Sep 2024 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623119; x=1726227919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Yzdn5+N47S5X8EdWk3yRUVLRKJefl6EeZW9B6Vfe9I=;
        b=SA+ykTYLiENWBmtUdWLHVGO8GLXxqe88zLDIED9NQxtti+AAhbPQ473sLpJDKVK6mu
         ovWgMK+EkYAN++DXidvY+Ga6tlw6IOMdGXjyBiP6xhQXJ7eDggZOZsjph0qdk0gYbmHp
         MUzwAEHHtTSGgrb4FceD0q0GI0jGIHoG5+7evl/OJNf1/VT5d4WlFDvMqJIYDMydlR9X
         CPB9LW4fQk6BkebvAigXzXZD7T4HZz1j4/UoH6vXPU2ioq29c/+IjvAYBS9oc/+THVi5
         7+W+/irk46PAl3qY7idypIumvXEZf7TVdMWZCMKSTU2vVGV4q+n6J0Bt2UYD3luH8rZI
         nSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623119; x=1726227919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Yzdn5+N47S5X8EdWk3yRUVLRKJefl6EeZW9B6Vfe9I=;
        b=wZ5dH3WgycMB6DWLsulHShKLwD2YzmgYLDhDI8aLIrcj/kooB+SElnUYzYoaPzUqa1
         eeJVW1PnDkbx/70Z4mT9cFl5uqZjCsp6gbHvGmjd0ave3B+l7zpGlrn4uq9v48exNreR
         yUUDlt3HmqHlEQnsyjtt7P9L+c2Z3QdSkRbXR9363J5dI8fvoUHZurr6+87c7gXcVYpG
         VXNz1p6jAiAGYfiWV/IZ745B47U6m1svrkkZOOFgP9lhVHarNCWoqZ4/m9+I6wuaz+5K
         RqzSnNXHapwTGYi0wFgT6oyHYzrmppYLHDGg/b57iAKftF7SfZ5nDJwT9/RZmRIOSUQk
         dYcA==
X-Forwarded-Encrypted: i=1; AJvYcCU/MmqI6J9zP7ueM1TrJbSr/OplnItBOhJP5kE336K3O12ntxNqc4TKMcxUlQH3/wExag4q7w1J@vger.kernel.org, AJvYcCUSaQmzflEDDldv28vMng4y8k9VHBG7qos5ilT/hdvYVlpbQB08DJbTZFucDBSWK/1DKw6+KlnCuBSxhSY=@vger.kernel.org, AJvYcCVwIkktgld367JoAsafm5Qc/qqBrNoSvCDchcY7jpRIY/bFDFydq3GdIA1/NqZeHzVccg9XquxixnBAfJiWSpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCs+h41M7+aZJ+4Hqr43FLVGJvNcir1KWNcKswYh/vQCg7l1s2
	sOVkM3YwaApI4T00jVTFM1+v3fOKEohkIYIPxi7kMnWa1A+92qhM
X-Google-Smtp-Source: AGHT+IHtiadvt77afRob9xTeuiDrcLZqDawkb4qmubVc0QiWBcneaNZ1k9gG4k+8aX1n+myXC+Plew==
X-Received: by 2002:a17:90a:c702:b0:2cb:50fa:b01e with SMTP id 98e67ed59e1d1-2dad512cb05mr2397950a91.41.1725623119006;
        Fri, 06 Sep 2024 04:45:19 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc12bcd5sm1330297a91.53.2024.09.06.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:45:18 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] lib80211: Use ERR_CAST() to return
Date: Fri,  6 Sep 2024 17:14:55 +0530
Message-Id: <20240906114455.730559-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 net/wireless/lib80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/lib80211.c b/net/wireless/lib80211.c
index d66a913027e0..87c0e09aa676 100644
--- a/net/wireless/lib80211.c
+++ b/net/wireless/lib80211.c
@@ -227,7 +227,7 @@ EXPORT_SYMBOL(lib80211_get_crypto_ops);
 
 static void *lib80211_crypt_null_init(int keyidx)
 {
-	return (void *)1;
+	return ERR_CAST(1);
 }
 
 static void lib80211_crypt_null_deinit(void *priv)
-- 
2.34.1


