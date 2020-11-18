Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75362B74E9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKRDmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 22:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKRDmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 22:42:18 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B0C0613D4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:17 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q10so565553pfn.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQEG9lGjRyun+NVxBQxKRLJCfXxOi94FoslIBSyCrw8=;
        b=ncH0FAieyWAoMh5s0sdFfGDjcaffhIFAtiFHIBrm8mtVleG72qMgfrqeTuCP4lP8Tf
         MEEz1pQEsMo/Xkty1uS6wGSwb/gVSpQZe6WxA4T1J9hhYcrtID9nmTM3GjDuNPWuonJk
         W/kEDRKgGuPbqzsQLjCo2zFgSbje64uousP3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQEG9lGjRyun+NVxBQxKRLJCfXxOi94FoslIBSyCrw8=;
        b=DVq4XXR/X1R3vwvbrAl8MP56icUt3zsIVwgquE8wMZdtyTEPtMSaP5u2NChAQKVHwq
         Gd3dk4Aw9OUP6UzzxBNvzXxrqOlIlgSYFZvM521GqHerJbx3BCYFxjQJpYjuHtG2j53f
         yNkIMN3D6qhxgXizYSjd614NjtxT2a1oTcEQKNCLCGfAU8urfWlHqtgP+Kk6JwHzMl5V
         1G1JwRNHzekw45ubvwG1tqJJlaRFERdQdVSilql+KrDpzsFtrcfKJ6MlEr5uqbpyaePr
         Zw2ofrln+OrsYfiHedopg0QSTHEqoeSdp7wDD33Lv7CUga7LWTPP5Q8tzpop63/Cv5vy
         9P+Q==
X-Gm-Message-State: AOAM5336FUSPGQlhe7mNr871Cn7echo/lWEinNDIfCOhF/eRx0q+bnuC
        yCVNOvtpJ7fDftoXaO7B+bSZAw==
X-Google-Smtp-Source: ABdhPJzV3zte1JhSqqODElM1DggxOI/hkTdjU8slbRR9OX5zeeRKnC+xGhOI5qy7aJmcvnDizScs/w==
X-Received: by 2002:a05:6a00:c:b029:18b:eae3:bff0 with SMTP id h12-20020a056a00000cb029018beae3bff0mr2506827pfk.9.1605670936641;
        Tue, 17 Nov 2020 19:42:16 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id w2sm16097617pfb.104.2020.11.17.19.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 19:42:15 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        David Poole <dpoole@cradlepoint.com>,
        Ben Greear <greearb@candelatech.com>,
        John Crispin <john@phrozen.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/4] iw: scan: add extension tag parsing
Date:   Tue, 17 Nov 2020 19:39:33 -0800
Message-Id: <20201118033936.3667788-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201118033936.3667788-1-briannorris@chromium.org>
References: <20201118033936.3667788-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HE IEs are part of the extension tag (ID 255).

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 scan.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/scan.c b/scan.c
index 8c23483ecede..58a09983c5c7 100644
--- a/scan.c
+++ b/scan.c
@@ -2272,6 +2272,36 @@ static void print_vendor(unsigned char len, unsigned char *data,
 	printf("\n");
 }
 
+static const struct ie_print ext_printers[] = {
+};
+
+static void print_extension(unsigned char len, unsigned char *ie,
+			    bool unknown, enum print_ie_type ptype)
+{
+	unsigned char tag;
+
+	if (len < 1) {
+		printf("\tExtension IE: <empty>\n");
+		return;
+	}
+
+	tag = ie[0];
+	if (tag < ARRAY_SIZE(ext_printers) && ext_printers[tag].name &&
+	    ext_printers[tag].flags & BIT(ptype)) {
+		print_ie(&ext_printers[tag], tag, len - 1, ie + 1, NULL);
+		return;
+	}
+
+	if (unknown) {
+		int i;
+
+		printf("\tUnknown Extension ID (%d):", ie[0]);
+		for (i = 1; i < len; i++)
+			printf(" %.2x", ie[i]);
+		printf("\n");
+	}
+}
+
 void print_ies(unsigned char *ie, int ielen, bool unknown,
 	       enum print_ie_type ptype)
 {
@@ -2290,6 +2320,8 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 				 ie[0], ie[1], ie + 2, &ie_buffer);
 		} else if (ie[0] == 221 /* vendor */) {
 			print_vendor(ie[1], ie + 2, unknown, ptype);
+		} else if (ie[0] == 255 /* extension */) {
+			print_extension(ie[1], ie + 2, unknown, ptype);
 		} else if (unknown) {
 			int i;
 
-- 
2.29.2.299.gdc1121823c-goog

