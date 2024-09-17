Return-Path: <linux-wireless+bounces-12920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D3C97B1DE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9EF1F254CF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F4176227;
	Tue, 17 Sep 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqVvosu8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160517B4EB;
	Tue, 17 Sep 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585798; cv=none; b=tdWC3USUv3aWV7N5dhVPP3GPPpJcG2PserCrAU4KOr1zRmyFDZcgkyr1K4dVFjJVn1tSx0XTH+voA1dg0X6CpBOdrukrrnNBsRPgn2mbZG8o8gC1RAUUYnN9asb4euQDyr2m5f8Zw/KzKq6UaXkMOVAF3Dh+XIpMdPAnBipVV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585798; c=relaxed/simple;
	bh=y5UUah+7XEoExIjlt9jR6GVTs4STljBV9pNfNmvvk6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cll2IDrOrlCxSwYkR73EgKhOw9elHxzIevv+nClJYjHyfJ9ivZQ0Iyj7NHmd3MfSYI4RyyOc5iuKxo3o/DWfqaUVxResqRnHpzvWA6/RT2J7kXeUtf2PaKiq6tgzUAlEYLQSjqpsdR/3uGZBACkl5JkixNmhDkujN4RneGBd9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqVvosu8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f759b87f83so61852601fa.2;
        Tue, 17 Sep 2024 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726585795; x=1727190595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CjhnNYdjfR8iymklXGS4JEEO/9GUVTLzwmaNZensn4=;
        b=OqVvosu8VMerO6lUYWAZi71T36ncYUgxuZ/yKus6ooy0BsRF8juH928QuBgrQ9qegL
         CVdKk8NnkRyz/usu0vsodZHRaTaXCXiKKLzU58XfrR5NnpO+MCaRdlZDGtAHDm2xsczY
         lWFlFjcOQW1U99bQ+hpnSvLH+RKcGRoVq86Y3U0ycZLcNSSfOXF34UypGKErpLbrktN9
         qGJxV/1zupwCsyMmpjQGwOryLgQJ78AAzv2OPA2YGRhmu6xzL1RPn5bqWQw9zAoM6fYL
         BJkw3RvZabkYWrNebhis2l4kFBQjMkTDktZzca+ma5IY/zEBLQE7O0Z+vmd86/o4xR89
         waQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585795; x=1727190595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CjhnNYdjfR8iymklXGS4JEEO/9GUVTLzwmaNZensn4=;
        b=M2+70McNerZOeJFu4JnxjRwEWPLcz/gD6/Sr79M5d6GsK/kwC+a2DZV47niO10kvma
         oooHtuqJfGHk3EzV0zsAOZhi65zn0ydrFAa68L2L8B6raYq36gUFbd9/DBWsK9umcYCS
         HsIlzVUdV3ru6Ekzm+OGxHbCkoF3JrJ3ZloPt2LmFVT2BvfR1vzxOxoLV5nWCqUdh8tN
         same1Aukb7jYKA2RoUZ1qmZPmBDut7VzUowAf5d1vBIFO1Y0xvsYC4Nia/07IzWnAf6e
         MAre25u4WU5O/a8LEdyvADaSmQH92D04Pu/4yOW/KOfid9It7WseZ4gDH90erj6jrly0
         /bKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiMngrVgm4so6mb1flWIRz1qU1z+eS6DSB+7BnJX7e+bLusokO5Rqs8SWegXNSMqjrupjMcnlaCo3+AHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCu4sQj8quM7NsdAg9KshsmeqGdsMfpOR1BCfopESF0i7zFGhV
	yvpmQwJTSAxdt9zHLwK+NWv2rw2Q3FdOVkJWLMZfbqTWI9VS5BNcivb7pvYDytk=
X-Google-Smtp-Source: AGHT+IEpNLYCMVCYH/kSs/UdyPoS4v/580SHSCPjm7FyhuUQaUjmvM/PX60h6XFdyMi5a2Q05WYLFg==
X-Received: by 2002:a2e:a54b:0:b0:2f4:36c:9c4b with SMTP id 38308e7fff4ca-2f787f4fc1cmr107768911fa.39.1726585794328;
        Tue, 17 Sep 2024 08:09:54 -0700 (PDT)
Received: from ALPER-PC.koi-vector.ts.net ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e254dsm10880721fa.5.2024.09.17.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:09:53 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lin <yu-hao.lin@nxp.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()
Date: Tue, 17 Sep 2024 18:08:41 +0300
Message-ID: <20240917150938.843879-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace one-element array with a flexible-array member in `struct
mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
on a MT8173 Chromebook (mt8173-elm-hana):

[  356.775250] ------------[ cut here ]------------
[  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
[  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]

The "(size 6)" above is exactly the length of the SSID of the network
this device was connected to. The source of the warning looks like:

    ssid_len = user_scan_in->ssid_list[i].ssid_len;
    [...]
    memcpy(wildcard_ssid_tlv->ssid,
           user_scan_in->ssid_list[i].ssid, ssid_len);

Also adjust a #define that uses sizeof() on this struct to keep the
value same as before.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
I found these relevant patches that modify other such arrays, where the
second one removes a -1 from some sizeof() calculation:

https://lore.kernel.org/lkml/Y9xkECG3uTZ6T1dN@work/T/#u
https://lore.kernel.org/lkml/ZsZa5xRcsLq9D+RX@elsanto/T/#u

So I think we need the +1 to keep things same. But it appears to work
fine without it, so I'm not sure. Maybe it should've had a -1 before
that I would remove with this?

 drivers/net/wireless/marvell/mwifiex/fw.h   | 2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index d03129d5d24e..4a96281792cc 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -875,7 +875,7 @@ struct mwifiex_ietypes_chanstats {
 struct mwifiex_ie_types_wildcard_ssid_params {
 	struct mwifiex_ie_types_header header;
 	u8 max_ssid_length;
-	u8 ssid[1];
+	u8 ssid[];
 } __packed;
 
 #define TSF_DATA_SIZE            8
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index cab889af4c4a..50af78ee935b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -32,7 +32,7 @@
 #define WILDCARD_SSID_TLV_MAX_SIZE  \
 	(MWIFIEX_MAX_SSID_LIST_LENGTH *					\
 		(sizeof(struct mwifiex_ie_types_wildcard_ssid_params)	\
-			+ IEEE80211_MAX_SSID_LEN))
+			+ IEEE80211_MAX_SSID_LEN + 1))
 
 /* Maximum memory needed for a mwifiex_scan_cmd_config with all TLVs at max */
 #define MAX_SCAN_CFG_ALLOC (sizeof(struct mwifiex_scan_cmd_config)        \

base-commit: 4f3e012d4cfd1d9bf837870c961f462ca9f23ebe
-- 
2.45.2


