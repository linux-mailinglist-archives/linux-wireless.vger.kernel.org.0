Return-Path: <linux-wireless+bounces-36034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKafIbJi+2kuaQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 17:48:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001894DD8E1
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4C73305E88D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDBB47ECCA;
	Wed,  6 May 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZvDKsXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF53F0768
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082099; cv=none; b=UvNbpG9VJSmCmYW9q+RjcQh/vgjmqsdJ1VHwoxYraJvpf9eLxsRu3eaLPC4eqevg68G/TeOYeMa1jKbPvUt78dURjImcF3KY4r0ZjGxs5UJgV39X3WbVHCRlFqgjmrcQnE9YJMygHvw5wEDckF2SKXlFoc5tsbBNyLH4Upv3kxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082099; c=relaxed/simple;
	bh=tHsoAF7RHNYjkX7rX47/Yayej2P5Ket5MVerUw/DRro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDFj6SR2cUspQLzrjUIX+lN93I0aGNwKSXkqvf1/lFJW9oPTcZUSY/+169RrfrnyINhAuWvHR7NMJ/T56JAl9M2lTEg08zwyGr8WIvoXrYuYv1++Z3SkqkGdGhT2De7TEbhFXiJvCCYgS9L6oBTmCuRUHwCZKaAUJJmD2vzmxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZvDKsXH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bc188a20e0aso469024066b.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778082095; x=1778686895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/pLCe2apqY3FAy6uQLqb++X844fXdF9+Sq8UZuJttA=;
        b=DZvDKsXHMBUykL1uQdn8aGebF+ayT/509ou9EYcUXq06TjA5EhZnLyaxJkuZztwd1C
         mO2QL14H8GBkosbpo0BODlbJcOaLQ1gwbcVpskuUwdWw1MfkgtBfbCHrioIZFTwqqrwZ
         1fjdjSeToVp9sxKp/b2Oioe4vFOhhFVRuio0rAbVAV9Bm93DyeR9APgvQOpvr/lOvSK1
         YAoBOw4mWrex8b8Gf3yGlIcm/RClD/Kxx0hpSyhz+qJDPJFXu9JcrT8wlSfK1m+3hnTz
         XshQt2BAY4knJSMg4yQnzxqZjawBtdsCsBM1lVMSCokKRwDxvhVLCul/xD2dBvSuErgA
         U76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082095; x=1778686895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/pLCe2apqY3FAy6uQLqb++X844fXdF9+Sq8UZuJttA=;
        b=oyq9FY9EVGpfTQaToEcRI0sHH6u6MElUcRrpYugZUIIS/7XEFC0Ba7pNHUYdffVd9k
         tW3w0aEebp2LzXMjenuZYDcmbGGcmx1z9W6j0kl/94M/RHPOJ/S85heTlWMXt6ylA7VP
         DKGRcILrHEcIo3mm5EnRAwzYOzJ4WoT3kbrKdsyGE0SPmIfOhC4bokuAIKjeTGreWzXt
         Tv8BiyGUGl5ZLBAVoHS2xxeFsin/Zyy170icgJ6exHgdX5DJ5Kl6Bf/NJT+uVvjkPnjk
         vzaspgjDZpELpoc9sMZoZgRy7XvYWnXNfAgVw3KJ2Tk+js4TtQuI7aK2lc1EbsmqycJG
         LzsA==
X-Gm-Message-State: AOJu0YyZ6K3kuAg3bcfG9ynllsi4OZN4302Y3GFWFBsMnqdZsmbcBUSk
	P0ire2JVDfE8Aj6DONh0EJ4pd+Mxd2xpt6iZ9oTN/3M9vSwyd+vQh++V/zIrnQ==
X-Gm-Gg: AeBDiesT4MzX6P1y2wjd7BUgl3OPkAU5n06PerAkfs8c9BSN29jn7a7745HpUfDUkGN
	TCGn7IXcH5uH0Um1nC9Ztlkc7Gi0LJJ4HBw3C9zRMqoTHyaf+CIsIOkZFv2xXl8p+1kxYLv/rwr
	6AyLc3feVdeNDpsEryLIMj8qfXmjYV5sTK70rFa84cbJgSG+mr6rrIsQUW26//ysvgiviWL1kZl
	uHn6Yf8gPvpG19YC2fjT7PqBpQMN+z1nuC7ttZfn9tyxPg5+VVtN971sOYPtkBQHH6jItrPjj+g
	CXLCjGUB3Y1bIXkDGjwXgF2NRvR+AY36Of0ZkZomFDITZIVJP7VDTENI8eLzASdWXpG/R/Pc/36
	IDsPN06YnMJb4rSVUAWOc5zrWwGquzm4A9g6pYTNF39weid2F1i/kii0HvPBJok7+fYJ6OyuJLW
	DSvNbnYtyKXe7H8xnFncpWz00Ut5EXYzM6fHxeoNMIyOsN6ejGbxOnAei0QBXtQV8=
X-Received: by 2002:a17:907:c084:b0:bc6:4ad0:8822 with SMTP id a640c23a62f3a-bc64ad08a4dmr68620766b.2.1778082094867;
        Wed, 06 May 2026 08:41:34 -0700 (PDT)
Received: from localhost.localdomain ([62.141.198.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc6685e3e78sm12585266b.8.2026.05.06.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:41:34 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH] iw: channels: show CAC ongoing time
Date: Wed,  6 May 2026 17:41:03 +0200
Message-ID: <20260506154103.199563-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 001894DD8E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36034-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 phy.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/phy.c b/phy.c
index 03a7822..ab629c6 100644
--- a/phy.c
+++ b/phy.c
@@ -5,6 +5,7 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <time.h>
 
 #include <netlink/genl/genl.h>
 #include <netlink/genl/family.h>
@@ -143,6 +144,20 @@ static int print_channels_handler(struct nl_msg *msg, void *arg)
 							printf("\t  DFS CAC time: %u ms\n",
 							       nla_get_u32(tb_freq[NL80211_FREQUENCY_ATTR_DFS_CAC_TIME]));
 					}
+
+					if (tb_freq[NL80211_FREQUENCY_ATTR_CAC_START_TIME]) {
+						struct timespec now_ts;
+						unsigned long long now_ns, cac_start_ns, elapsed_ms;
+
+						clock_gettime(CLOCK_BOOTTIME, &now_ts);
+						now_ns = now_ts.tv_sec * 1000000000ULL;
+						now_ns += now_ts.tv_nsec;
+
+						cac_start_ns = nla_get_u64(tb_freq[NL80211_FREQUENCY_ATTR_CAC_START_TIME]);
+						elapsed_ms = (now_ns - cac_start_ns) / 1000000;
+
+						printf("\t  CAC ongoing (elapsed time: %llu ms)\n", elapsed_ms);
+					}
 				}
 			}
 		}
-- 
2.43.0


