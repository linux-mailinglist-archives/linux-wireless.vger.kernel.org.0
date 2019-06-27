Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2116579F1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF0DZo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 23:25:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36082 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0DZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 23:25:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so788040oti.3;
        Wed, 26 Jun 2019 20:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hc7mop8BgLXIBrsAE7S1CcsKtIxDEdShT9TGYrFuBVM=;
        b=kDgKIYFvpCDd06zbFNhGDKpCEVgTWTHJedUq3olGtuZiBWkkL/5WYAk83Z5x0qurfn
         ZoYhXj7MnMeA5n4IXjc4NT8TSzahy7sjeb/mSm9jMSgtFdiz6bEo7SUfnVJ7joymz6wr
         axNSjCZB9zGaUh6CV1BwRDiMduet4in0XO+l+088UM4cN8pRdP4AlYl++CDSM0Wr4AfA
         ++QB73ZAeYCfNiOaphzN5/9UGI3pq46goPKSWmwieRXbsk7mj4tNvnEMBvfazH1N85nh
         etWSYB14oxkRmyvGx/nBhe7DgmUn8zMw19do81yz/KU/VIUWO6SXSn3p/WZA7dtA9MZU
         rSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hc7mop8BgLXIBrsAE7S1CcsKtIxDEdShT9TGYrFuBVM=;
        b=JYFgic/iocn1F21P7OPYNxT81LTcvX/erm0ZCLn1c0DyTvmB8qjWG9m6MVZfULU+eF
         Yf/0pYJfvYoKEG0fzIdQ/Lw0o4NLhmj1q71YFZo6ApOkbhZX7o3tXd2YRIFp2bdq0W7x
         1JYsb1aSsDAc9bbzIpFfESvprZHPEkJH5ZCNxZrpMp6FeU0cIWfLsrNyTPQYlwyT/g3T
         oxMNzS6MDKnxa0Ycb5eTHnzu+ek+Srt1EgDPCF59ldaFpmgRCzYDHeMp7G6XJIG9oSqM
         8fKBC15T9jgVrcDwEj1jH9blyXSPCF4xe0EGBa+tTz5yhRIgNRJagShhmRRquFa66q4A
         qDuw==
X-Gm-Message-State: APjAAAW1mddOUfq8xFYTSJbSJqortGT6ae5KKR/PlOeCTQjpmsCCKYv5
        AfIzBvqaOTFaPiWST9f9Fss=
X-Google-Smtp-Source: APXvYqyUkf1iuH/PhqzkOu7tkOamu6aAFWoqbQOhA5ot8fzzL2lRFkE9lDvw+U7oYWHLZ27WZXj8Qw==
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr1529107oti.50.1561605936459;
        Wed, 26 Jun 2019 20:25:36 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id y184sm417647oie.33.2019.06.26.20.25.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 20:25:36 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        johannes@sipsolutions.net
Subject: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined behavior in bit shift
Date:   Wed, 26 Jun 2019 22:25:32 -0500
Message-Id: <20190627032532.18374-4-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627010137.5612-4-c0d1n61at3@gmail.com>
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined.  Changing most
significant bit to unsigned.

Changes included in v2:
  - use subsystem specific subject lines
  - CC required mailing lists

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 include/uapi/linux/nl80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6f09d1500960..fa7ebbc6ff27 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5314,7 +5314,7 @@ enum nl80211_feature_flags {
 	NL80211_FEATURE_TDLS_CHANNEL_SWITCH		= 1 << 28,
 	NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR		= 1 << 29,
 	NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR	= 1 << 30,
-	NL80211_FEATURE_ND_RANDOM_MAC_ADDR		= 1 << 31,
+	NL80211_FEATURE_ND_RANDOM_MAC_ADDR		= 1U << 31,
 };
 
 /**
-- 
2.22.0

