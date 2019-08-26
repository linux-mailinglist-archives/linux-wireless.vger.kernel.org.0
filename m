Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016109D409
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2019 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfHZQcH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Aug 2019 12:32:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33669 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfHZQcH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Aug 2019 12:32:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id l2so12600641oil.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2019 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fb0QwIjd9kVxm7bmZY33jC6+4BAbxlHuDMwTWmk/7w=;
        b=GNrCjqTd07LzcYtuwYSzYoUncAhmcvAI3O/EHYVoN0sh/GcZmfz8n96PDYZULXl1R3
         qn/Dxc2GXkQ/X023tGux3iC1oh3Z0CefFnojM44sJiRD4FEFNKgdxDxpwklSSshEVP1C
         EznlEA0daR6eG9fBhpDVFne7wr4j+c06frNSzO+pbpchiEDAPRGDVBddV4p0IKvP9r3h
         GpEiR98++1tKAVDj41XSN232WKzQ4uEIDs6aI8AaUVaE67NRkvejy/yLFOL9eCqTroGk
         d+/P2l8qC6tC2NCRWUs61PUYhX9yWXX2tXyW2LIRy1zKg0+Q6ZlG0dXMYrrtX55BJ2zV
         7kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fb0QwIjd9kVxm7bmZY33jC6+4BAbxlHuDMwTWmk/7w=;
        b=gEwD91ij2idmZ+5k3LgLM3mR0VrpaKOaXFgSAPvJgy0YkgaQU3UgICeCSSsI6b0NhE
         e9hIfJ43F6msdWHgx117cR7UJCSbSLtpB7eEimzwddHtLGKVf7cZHBB0M61pOT52xPZo
         CyYjZrqtnSi8CNBPStkRg+Eq1+iN7WKqXD65oiCYhE/f31uRDDBJTxoXCpjQMqYSDNfG
         TlV8OHE95KcjoeYfKj3xv2stinwvKoxxz8jyUQGRsD5oF3Ay1KeZYrUBL9zotSL6efLB
         v+gjnrFdNdCVTT5IPAUXJg14G984qUz7+f5tKMY95VItfwAsLbFZ4V0NpnjGw6tEA0oO
         +VaQ==
X-Gm-Message-State: APjAAAUiTIAvuV0Yi9RRjS+eGpfz+P18wIsw+s7nCuW2gHYDR2E+aSM0
        YaZ2/Z6Kpew16WYWAzYHsgehTZRV
X-Google-Smtp-Source: APXvYqy2HeI8y36OJ6DPK7DLqdaRqmWrWiCHsah4KLiqwnduU0LMKGofdJasYmi1UUNu4wbNnZvgug==
X-Received: by 2002:aca:d558:: with SMTP id m85mr13526171oig.0.1566837126106;
        Mon, 26 Aug 2019 09:32:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id t18sm4151278otk.73.2019.08.26.09.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:32:03 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] mac80211: Set LIVE_IFTYPE_CHANGE if op provided
Date:   Mon, 26 Aug 2019 11:26:37 -0500
Message-Id: <20190826162637.7535-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190826162637.7535-1-denkenz@gmail.com>
References: <20190826162637.7535-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 net/mac80211/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 29b9d57df1a3..073e5d10a48e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -597,6 +597,10 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_RRM);
 
+	if (ops->change_interface)
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE);
+
 	wiphy->bss_priv_size = sizeof(struct ieee80211_bss);
 
 	local = wiphy_priv(wiphy);
-- 
2.19.2

