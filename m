Return-Path: <linux-wireless+bounces-30595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8604ED07BE2
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 09:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7CD33011A5F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E292F6582;
	Fri,  9 Jan 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="WRz5imbN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6259218E91
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946502; cv=none; b=KYyQmMjNTND7zUGBJQV51DrSyFCa3f/RvY2iFt3Bwit1vVmLjJDhuf4xsdqgySvL98IbOWxVpLWo0cUyyZCPpsAm+DewV3RBlqs55PWFjyas80YKVrwSz5Wn3e6nIAV3Txv9HkM+9Y3LMooq92YIT+7vYz8jhcx8n0KlABFDiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946502; c=relaxed/simple;
	bh=HtpzpbuMDYssEgv48QmcpE1kKttQ4FVBY255yFf85OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6nKM/JItXuUo18Taq7LCZIjOJwABKZ4MDMyFFyglsHtmjjFwPwYg1Apu2OWcf6svbZ0Gnkgp3QycBW8DHZR3ZvZoWWTYyne15Ib3Ho3tH1hyA/iuORgr/hM7a1OLCCBS8K6QAlKtYt0QvFEukYPzb97X00Y1Uj35Dl7nYyoTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=WRz5imbN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so128386b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1767946500; x=1768551300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzz/2AMUuZtSx+eGZvnc+fNVdNKRF3ddPFFtx+7DkFM=;
        b=WRz5imbNy5vfgOxRwXjg3xtyzHv9rEQqQj5EP746BHuPC5VKac33LFyGn36cpiYU+y
         xHQYWmE818bG40K+apnNA+VgcvhZcJhdlPH4da9O0Y2j2JRxiLpUQSFbh3s8zWeZ9xW4
         WSIhYAYXb2WQGD+4r4pYLXr2FCrYv92EdCahYoDwfqQM0Fju+wCzAmS6CjMqRSjkoOWB
         ErBhH7BG9DOClD7Ikx3Kg2KM6f9Uy1OJ54sjfPgb3PyzDfJJ1yACznt5Sy+NQXMs2iLQ
         bFO57zAkE2gYytIkoM5Z8Syy4lPRjRNKJK7kIrAwx+eM8xEBl3he/XlSRO9dEjUSZYKN
         7PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767946500; x=1768551300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzz/2AMUuZtSx+eGZvnc+fNVdNKRF3ddPFFtx+7DkFM=;
        b=XJxoiWVtcMHLnsdiqYWRlGM7EUlnVFNwr3wRzZLgI+fNDRxPI1F9LujHEwAdosNS7k
         O87N+QsXOxhwVsbKGVzzYCwvnaoCzGpgmr++yOtt+B0DUuUgE6A/NAkM7kj9twnBaYgD
         JnOHqcfCqtH6EEsECj2f1nOFUmii3tSfF936pcbBpPEgMDJUmwpH5BFAfC0wJmWQeMj+
         Hk0/YJDcGHd5TxcqHbrJ3bb0qYP8uqThzqRz5IvhPUFGMeDYltiIGbKDrkM5ETaEvUKf
         AV0xwRL9MW3CLnkNt97UFjMXPUeqIuxDAWuTKdTnc+VWbKWwQptp9jbE29VvFSgDmY1K
         KQ/g==
X-Gm-Message-State: AOJu0YzvjJ0e1aR2FvYUUYHgE5CyAk4/C+4ofKXwGhWZzFq0yppxUucY
	k/2BUOZVAoOZCd8KDPbngyfrMcZN0R/F3XiH1wf+Qyw7MIscJaF/TRyjJsBN1zluPAs=
X-Gm-Gg: AY/fxX4W8DIoPzmU13lO34pd7Msbpwx4rcogyWF65m2aei+oJqqwAJQl1oUKiukfZG6
	2zHExj3OFpx6dea4BRtGjuR3isFePQdxJp4iFxKm+PjrPrCCmsKzP0By0u15UB/XpyU1mwom9U7
	YIR97tjyESjogut/2dEXy7HjWJXckE1KrOBtqD/Y3OnQBOsn4cQ0BaYpYNi7QqDRvMyAPXCRiS+
	bzVavcpUAgLdHWypYfo7p1hLrDcDk2U9a70otlRImT1RvUR3fTFQJ5ZwCWxdVYT7YIfr9UQSrIc
	Y3fVF57xriwoQqt+MUQ8zH5QnjsoEuKC8ZRqQK+eh4nDOErYIJeRBnZlNcQowAYhjGnJQmgo5YM
	OXAgiFZ4aHylkSMxr500YW5v57KsWjmIk1kSv+NCCIjCQUVxWRkWDJLLTfrgyxqvaWRhODmILDl
	fHNJGj4ElgjhZE8stSn7gCyF7FyCo/eTVT6ebHdCV2Mm15GcaOUoZVqkhCl0B+5Kf+g5am4WI=
X-Google-Smtp-Source: AGHT+IHGj2A68IKx5rL0ZYwmkjjP8zSapopXWnga4haNirOdr8Rv8UA2umLjemoEN9jPEYaPbZOgAg==
X-Received: by 2002:a05:6a00:2c85:b0:7b8:6a99:f795 with SMTP id d2e1a72fcca58-81b7f3f2689mr8535614b3a.32.1767946500166;
        Fri, 09 Jan 2026 00:15:00 -0800 (PST)
Received: from mma-H9MHD44.lan ([60.227.235.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5edc89esm9634556b3a.59.2026.01.09.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:14:59 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: cfg80211: include S1G_NO_PRIMARY flag when sending channel
Date: Fri,  9 Jan 2026 19:14:39 +1100
Message-ID: <20260109081439.3168-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending a channel ensure we include the IEEE80211_CHAN_S1G_NO_PRIMARY
flag.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/uapi/linux/nl80211.h | 4 ++++
 net/wireless/nl80211.c       | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..964e1c779cdd 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4444,6 +4444,9 @@ enum nl80211_wmm_rule {
  *	channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_NO_16MHZ: 16 MHz operation is not allowed on this
  *	channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY: Channel is not permitted for use
+ *	as a primary channel. Does not prevent the channel from existing
+ *	as a non-primary subchannel. Only applicable to S1G channels.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4492,6 +4495,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_4MHZ,
 	NL80211_FREQUENCY_ATTR_NO_8MHZ,
 	NL80211_FREQUENCY_ATTR_NO_16MHZ,
+	NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..225580507a4b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1314,6 +1314,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_16MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_16MHZ))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_S1G_NO_PRIMARY) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
-- 
2.43.0


