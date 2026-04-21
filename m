Return-Path: <linux-wireless+bounces-35170-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF9cFMSD52m+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35170-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:03:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6D43BB7A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 070D730276BB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0513D9DA1;
	Tue, 21 Apr 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlH85NO8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589283D904F
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779424; cv=none; b=KQpqXjutYXql5UzgyqlIH2DdG2MFqH9YZYr/JOb9hjJG4R8tlehhxx8g9H38IkhyQV1olgbvrcK6AqdhHKZNIivExUPa3I1XizVw8UB4U3sFDom27DE9wZp7QYvEr83np1X3KT+jXXqduRQlSvmt+gXl26uLtrZfwtH3KSXHh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779424; c=relaxed/simple;
	bh=qGrlQNzLCeLmSFhzXqeiM3nkVvTjnCabM/bhMQwZ11M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0EN1vlMDxzMjsnJFbpr+piVYWEllTDPsb0QCLGD2//srbS6a5siAFs11scR+gjSJ4/gEycldTq6UUM9p2po9S+qwxyK3WuJB8A2GM5/KJod0YWlqnasLRoFO5NLkvzTtJaORul4fBQ8l8mIpCXLDRE5yUA+g8xfIgwb/zLEj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlH85NO8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so16601895e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779422; x=1777384222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGCRjJpRzFa7v0/x7sZvdJQqhqTv+jJkDadnVmuzH04=;
        b=AlH85NO8o2NZp8DJHnhMCtrr3k0m0j7ZnEXP6OZrBX2M+kUJFG8r2uZwT/FXSu8Dny
         ZXB7CIPD1phl38Bn3NyEp1TB+Anf3jVFy80/Hr+KJNCf3lKTzChSHw4xKltqsEJzLI13
         nR+buPCHGAlHXM6c3+k9t18PPUueJR53nLDPR0vRJiaGST+tBNiL+bEYOxB7jdrjInx+
         oqet57rOM+he3AQkMBPGkT+tafRtIqEZ7qooDCvI/yNq2ZnK+I/toSCabzOC826aioUH
         0NTPPcSmQPFpmaY/KQV1e9xbk3G1v4ZsL32lQ80dnXRgGS0bzfYE0Z0bDVYx7zgtg1MG
         BPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779422; x=1777384222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGCRjJpRzFa7v0/x7sZvdJQqhqTv+jJkDadnVmuzH04=;
        b=GC1lzbRmzbxbLlRbL9GjzFOJAnSyZtc5JIZUT4Vgm46aYeAk/rZJnjhdGPpMAk++YT
         S52Cd/z1cFxkRGWlnVyvd2/JjI8PACbmsmshaStBdmOQ/ZgbcEpq3OK0h4tcsDQ9m20d
         xFw9KXxh91uw821FPceSJ0is5LuMOhZIs6G7F7YVtHJKkAUCXxibif2b5yjZfYdZUutr
         mplP8/PLHmf3hoiIriA2Xsxpux/Z70eDNOIZQYnTPrN56Dss/aO0iSWV0OrKDr96Eut2
         rxvJA7x2OsOsfl3NwM11CVf9fcHvcph3MSmk0Wl6QQrHYlGeeAPCXCoGz4QL4islhEJ/
         YqPg==
X-Forwarded-Encrypted: i=1; AFNElJ/iphas78GNFlNbdaZIqlVw2UJ6R4Ja7J1EvM42aLjp9mkWsfK7gDv0BEU6FO8orSFshei/pvkVMAqtW6ZpRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDZ/MAGbzRwacqpu2RxdI4vC5H7qAf+7BueRD0kHrL46FU8+t
	eq6rJuc5lscZe8/ml7UV9EEkIXHViJHFZPHbH752ymiQWJLwkEBdpmc=
X-Gm-Gg: AeBDies4eWdnUUQI2Xd/bmqrF0H+ElzjL7vbj8jDlcdYRtUSPBq5ojWNpMs/Ugj6mbK
	BF9hNLumM8NWe9jWSKqlHcI8YbVH3zg9wLsMugM7bfGOt5B3vny6cxXt03AgjxXyi1/R2UOeslT
	9IJy33WXiYIuL1T78miXuqGBAIPiT6zdP2rAoGEkg7Ndkt7wlmWzkUydNvBRrA/HZzRMzaVSKrE
	GghiiyA75ZKhcYuoA+8E4HO32MLO09+NrZiEE8x8UNfMzYxlVzT/aRgcDilZPtLrBDa1Xkk+j+j
	ixYPk/IuKObl2EwYZck0LHknV3UxFHq0v79Hj0+aXQyl/UmEIpxZjV+62sXASyyhysVwyuAQ4yY
	DTeTPoslk8XSZJ5cgZY3vl5bROPKfMAf1Mb0TiCWwqhuwwn1i7cvSup7T8oubADQXrpJht+JCIC
	E9zKR8aTTtmheZgA==
X-Received: by 2002:a05:600c:26cb:b0:488:7d01:f67b with SMTP id 5b1f17b1804b1-488fb886646mr161954775e9.6.1776779421586;
        Tue, 21 Apr 2026 06:50:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a092sm2761850f8f.23.2026.04.21.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/3] wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
Date: Tue, 21 Apr 2026 13:50:17 +0000
Message-ID: <20260421135018.352774-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135018.352774-1-tristmd@gmail.com>
References: <20260421135018.352774-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35170-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 9BA6D43BB7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled rsp->count field is used as the loop bound for
indexing into the flexible rsp->regs[] array without validation against
the message length. A count exceeding the actual data causes out-of-
bounds reads from the heap-allocated message buffer.

Add a check that count fits within the received message.

Fixes: 43efa3c0f241 ("wcn36xx: Implement print_reg indication")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/wcn36xx/smd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index f65328329f4f0..2a0c946d81095 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2805,6 +2805,12 @@ static int wcn36xx_smd_print_reg_info_ind(struct wcn36xx *wcn,
 		return -EIO;
 	}
 
+	if (rsp->count > (len - sizeof(*rsp)) / sizeof(rsp->regs[0])) {
+		wcn36xx_warn("Truncated print reg info indication: count %u, len %zu\n",
+			     rsp->count, len);
+		return -EIO;
+	}
+
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "reginfo indication, scenario: 0x%x reason: 0x%x\n",
 		    rsp->scenario, rsp->reason);
-- 
2.47.3


