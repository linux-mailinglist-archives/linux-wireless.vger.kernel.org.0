Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEC153BAB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 00:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBEXKQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 18:10:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41419 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXKP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 18:10:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so1986668pfa.8
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2020 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rjZ1BE1+tmBdqT4ZzG4XZPhZyhsStFok3T+POKaIrY=;
        b=Qn3JBYUIhHFG2nHClrFYb+w0DziOtdwoLgzKUaPR8XXgVpnk2rXjK7MmTWJRNgMmrv
         uNbA3QiovEm2N+hX72jMjcrCNBkubOxUcBSKa5yJksVYTsRUVrCBGqNaedaTTBMj1uLt
         P+l6iyN4VAZmrfwyaTYQjiirzEskU2fftCpqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rjZ1BE1+tmBdqT4ZzG4XZPhZyhsStFok3T+POKaIrY=;
        b=oFreVKtxbKadSvm2+0guRCUUcVtzJcoEixZlOEfj+wyhs1RigYirJCnWznX4iKa9As
         qDB76qAGtwSxwT2uEwD1svH9sDpHjN+ccp3rDfJM6NVx3VJhf/FOMfOSNjiOjjA5hnSW
         6e5CBAnP0aNqIEBCiDRrH92bL8n0S7KPssmj8m3cseGsh8qUCclgI1yNSE84w8c8KbZh
         CzMbqXteYONIQTJiYGz2kbtW9HknFXPlQCmc2i98gx4ghirx9fYsBxP2SWjVcSIdfxYj
         On6Wao5rs8iqLysRS7mwedVtT9asp1d8guMOLesHOuDnK5yUlDnKpQULQG/jR+HFfX0h
         gNWw==
X-Gm-Message-State: APjAAAULMsxrx88yO+OhCcCMxcWsrNmJ0M2DWKEex6WBrowioY3IsA9i
        kn5HS9ss2sqzeC165k/4OIdzGQ==
X-Google-Smtp-Source: APXvYqw+sqm/l1v1ZKkGd+orF85F3NgOT+OuF6bzz5Pj5jWo3jMKTuJXJgJqKxndPkuGxbDFkfJqbA==
X-Received: by 2002:a65:5549:: with SMTP id t9mr247688pgr.439.1580944214992;
        Wed, 05 Feb 2020 15:10:14 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id t63sm567963pfb.70.2020.02.05.15.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 15:10:14 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/3] iw: reg: parse the NO_HE regulatory flag
Date:   Wed,  5 Feb 2020 15:10:01 -0800
Message-Id: <20200205231001.132595-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205231001.132595-1-briannorris@chromium.org>
References: <20200205231001.132595-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This isn't supported in wireless-regdb yet, but self-managed drivers are
preparing to report it:

https://patchwork.kernel.org/patch/11343173/
https://lkml.kernel.org/linux-wireless/20200121081213.733757-1-luca@coelho.fi

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reg.c b/reg.c
index a2368df39009..db1b12906519 100644
--- a/reg.c
+++ b/reg.c
@@ -209,6 +209,7 @@ static int print_reg_handler(struct nl_msg *msg, void *arg)
 		PARSE_FLAG(NL80211_RRF_NO_HT40PLUS, "NO-HT40PLUS");
 		PARSE_FLAG(NL80211_RRF_NO_80MHZ, "NO-80MHZ");
 		PARSE_FLAG(NL80211_RRF_NO_160MHZ, "NO-160MHZ");
+		PARSE_FLAG(NL80211_RRF_NO_HE, "NO-HE");
 
 		/* Kernels that support NO_IR always turn on both flags */
 		if ((flags & NL80211_RRF_NO_IR) && (flags & __NL80211_RRF_NO_IBSS)) {
-- 
2.25.0.341.g760bfbb309-goog

