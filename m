Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23757B19
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 07:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfF0FEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 01:04:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46771 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfF0FE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 01:04:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so916070ote.13;
        Wed, 26 Jun 2019 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsP4OPoyyuGVsj56a75vPqGS9PQmlg/dei1pXS0wrVA=;
        b=H4s1vftufXCodbOeURMTzz5H0zLx9FKRH5i4Lj1xJRnjKWBNUaMIvJRVpY3+WZm1wB
         d0oP9wM38G6/W7VbvJSsHCT4k5e60hSEnqZDbbshh05nthhn0nnFTZH2RYy2W6aglkee
         28VbZDzty8L2VLUBapKwa5oSY70Lh3LFwiadchO8ygReuPSJSO/lXLxFrFgvzoCjbK3C
         3l/he5/QsKgc4CLrWaXilKEQNbTUOoqqMvF9mlgGdoFzt3j+PPRjPolllNXXPvOp7k+i
         NjLVsZ2eu1wPm764ESk1JEcgR0YTBzw64uAepMmxF+s6WIfkWCiNNR5Y6XlDP0QJI4Ns
         XtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsP4OPoyyuGVsj56a75vPqGS9PQmlg/dei1pXS0wrVA=;
        b=N7MNr0jiqTZYNF5frdxJY48ia1gMjoXXO47sMCwxZE4It6eSOiA4wotYOLda0BkLdq
         rwWVI3ma+w5xNeMrG9gi4pQIl+a2W4tB9DsNGJVJoVdQXKWT9eXSGTJqPO7JD3Cspdn0
         1nRKjFJ7uOf48YclA7LZWOJr+SrHrFQelTVVLSybj29/lhd6QenJXv60MWAccQp1sfXx
         /cjJlrnWGWdrPMK5JeeaWEVM5eAtYBsGBfKAfx0pNnzkDDWw+3v1thZgeXrRe27Z78CD
         +lkXbca7EbKX38zVPjFwNc2U+WxlfYEG6mB6YnbJiwFvheP/D0PEf3PsrBc3IzQb9slw
         brqA==
X-Gm-Message-State: APjAAAX+t2rkqrNU6lThM0UPY39izbWMFAemxi4RSodJ/rMsZDtULbTG
        OqW1p2RmZ5DVtkmobqWWwCQ=
X-Google-Smtp-Source: APXvYqwxKC3A5AYTVKV6MY6xj+cu9+9YYA6FAWmYeB4ViGjNN5w8dp6BdGXjNfxZc2fl9W7cLd/a7A==
X-Received: by 2002:a9d:588a:: with SMTP id x10mr1832241otg.144.1561611869236;
        Wed, 26 Jun 2019 22:04:29 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id v18sm613318otn.17.2019.06.26.22.04.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 22:04:28 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        johannes@sipsolutions.net
Subject: [Linux-kernel-mentees][PATCH v3] nl80211: Fix undefined behavior in bit shift
Date:   Thu, 27 Jun 2019 00:04:26 -0500
Message-Id: <20190627050426.17925-3-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627032532.18374-4-c0d1n61at3@gmail.com>
References: <20190627032532.18374-4-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined.  Changing most
significant bit to unsigned.

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
Changes included in v3:
  - remove change log from patch description

Changes included in v2:
  - use subsystem specific subject lines
  - CC required mailing lists

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

