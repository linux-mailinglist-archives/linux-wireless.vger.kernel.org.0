Return-Path: <linux-wireless+bounces-26277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474F7B2168A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 22:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8535621E34
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B812DA75A;
	Mon, 11 Aug 2025 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLrA8t1u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945E26AA91;
	Mon, 11 Aug 2025 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944498; cv=none; b=Hrc/gvE4BFz97xwOq8TIWfGT04kzIIKcfhsvbsqfliVoUnL8g6t54fZnoA6odpDh/Unizx3gVNQnhTJxeC03LeThzRBDm4LqRAfIDlAfEKEiT3YSonNtZ3hsB+WEjDyt9yYvj/FzL0kprTuKg9tYehtr4gvGQoqdBWNhYdnJxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944498; c=relaxed/simple;
	bh=PKuaobGsqr9y6MGExJ9G+xUKI0OFSduvz+0yQEhoz5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeSesrI8VKewh7qurFp5KoR0E9+DsPIrOWYxs9WjvuQn9TXXw8+kMhQkvgxTOA80g7++KZlZVBiKJG7Sya2hXE/FNe6xBNJZWIkiA7hfDb1atrFfDVVZQukUne0TFo2INGbDmc/chnACLpkJIfnP2LCOtrGlN0gMfDXOAJGIWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLrA8t1u; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0c5d57713so29629051cf.0;
        Mon, 11 Aug 2025 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754944495; x=1755549295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGdw+3/eqo8YkV2PsrcnOH6vTKbUsfuUgKSwYeGkCMc=;
        b=dLrA8t1uoRdF5C6VYr0VMfdyw/Zmfs8jk/oey6gQClQGg2dssbrxu9mFxDLE53C7Gq
         4SDpE38aA8V8r5JnexMzFDd1eyqwEJj4ABqXGM5LNpKIusOmSLa/RuWPYK1ypYovQOUk
         tXnKPE2wQ8H+qYiQEpz2/HRJzaKOUV+L9il5htDwVuCtKyr8tkGoPLCvK9pf/RjDmhoL
         JrAEStjw/7aIwgqHJT1/QWzU2rZiKqBrGsAHnSgzWx5w81LToB4UU39+kAiujTkKjpkE
         zndgC9VfaTQn1WSGKtarunCmVBKi/2jSz5LakE8b2kAXZBLEgnncpFk31qbNUkdYAuaB
         aOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754944495; x=1755549295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGdw+3/eqo8YkV2PsrcnOH6vTKbUsfuUgKSwYeGkCMc=;
        b=ZWtNQM82fx870EuRjzMfwKOCFxB5uf16q3/Z0UTTVNYJf2Cekv5vx1IRsO0gIpOJIr
         IeqJClqttdtlMiBr7ajJgKfuuufmccLPA+0fwwd2ofnqIkX82jAWLsiskj1qKqJXBRd1
         GO4XKeDftq8SfWUIXiBuPcwHl5/xR7UosvhCBxfVF8fm9G6OiVBhTkLfnuyn1zU5ZAqq
         D/uwq736DCwilgxVlZvhHcj3ouPP5U8gVG5cRCRJSIdbga9hHsKNVShR6e+Cdq8nABSA
         0lL6+wP60jNoTx2IAG2AMAdYEiI9JDuwbKv+g2BQPj5jaIf3QTOg5IHWm2yzNn+Ii2Rc
         xDig==
X-Forwarded-Encrypted: i=1; AJvYcCVeLEY/Bum5YJIUkCXS5iUhkA2p8XlHXfg938Cc8051d5ZRjAthAIHaMj8oDCQ+FKhMzRjuoQqFruZTfsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRg7tWiRZrvwld7+aJ14uoqxMTZ9YZErqDBQ1VwPr2Pt9H+uYJ
	6UAV3y+DK67E93169E3soC/exX83LMyETi/tR+Ml3vT+0lCzWK+e2ROoFfEghA==
X-Gm-Gg: ASbGncvMoXm10swch8+vSRm8qRH5LJCySC2wl/eh0r1kRFMG2iczt2xejfGOy8cIdD5
	AGS1PZ60HIXmaDansvMdlmF2RMRO1iqwuq9uKrTCNcEt/gygOwEyQOHXRQJaqoHm8qZt2n3DnHs
	Nkeu0gy8ZG5q084AjbFG2kefM7tv88JxnsjnsI6RHZtsqUZIl/QIXACAGayZb9UXwkXTuOPjOaH
	DnJYMQf2khIwIjSXOhMBhgFbDFvddVlkCz8z/1Ai3ZrWPC9TkGXxuApBedBX745KspPa5qKrZPe
	ieA75rNylewAOYm6wZY6GTOmEh4yW8gXngGxWltFJhrEAMMZuyw4M76S1VIogDVsVZtlK0Oo2LH
	JeSGM5xPug75WLQ==
X-Google-Smtp-Source: AGHT+IH5oYNZbp6lFLpvzwx/XO/iWNKukKsiHkMjSLleCkQatdFNfPyBQ5+VfWt3odmW31cO1Vz8hA==
X-Received: by 2002:ac8:7d43:0:b0:4ae:f961:4f57 with SMTP id d75a77b69052e-4b0eccd7751mr14047561cf.55.1754944495184;
        Mon, 11 Aug 2025 13:34:55 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b09da0eaa2sm72432321cf.49.2025.08.11.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:34:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	miquel.raynal@bootlin.com,
	ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 ath-next] wifi: ath10k: add nvmem support for mac address
Date: Mon, 11 Aug 2025 13:34:51 -0700
Message-ID: <20250811203451.3763-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_get_mac_address is a generic way to get the MAC address which
lacks NVMEM support, which tends to be used on embedded platforms.

In case device_get_mac_address fails, try of_get_mac_address_nvmem and
handle EPROBE_DEFER to wait for the nvmem driver to initialize.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: keep device_get_mac_address and use of_get_mac_address_nvmem
 added Miquel to CC. Maybe he has insight.
 drivers/net/wireless/ath/ath10k/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..8214b0c0ea80 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
+#include <linux/of_net.h>
 #include <linux/property.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
@@ -3456,7 +3457,11 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 		ath10k_debug_print_board_info(ar);
 	}
 
-	device_get_mac_address(ar->dev, ar->mac_addr);
+	if (device_get_mac_address(ar->dev, ar->mac_addr)) {
+		ret = of_get_mac_address_nvmem(ar->dev->of_node, ar->mac_addr);
+		if (ret == -EPROBE_DEFER)
+			goto err_free_firmware_files;
+	}
 
 	ret = ath10k_core_init_firmware_features(ar);
 	if (ret) {
-- 
2.50.1


