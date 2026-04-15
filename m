Return-Path: <linux-wireless+bounces-34862-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAMOLbgT4GmPcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34862-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:39:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11540408BD9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD64A315FEEC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569B3382C5;
	Wed, 15 Apr 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsZPNKzz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DC33A9DD
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292636; cv=none; b=OsqnLcVgd0gIeN8goZ77VZYtlwk988Xr3U/ctU0HwcPR1gDQAxZnMQPYVudVz0KeflOYrMvnTLe1GVAzdFsK7I6o1HINes5jPsOb69KGx0w6jG8ENlblDoihxRLZ4r6Z6zrM+rSIzC0Ze+1Y2eeWHpjrN8qdkk5xj8fWNjTWY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292636; c=relaxed/simple;
	bh=eLK8vtWrqe0f5ic7w+UWvm0VTGYRxuEc41R0Mr5KBso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJbTk2ugQBrYMsCRzIOGWfypLVWTYXLzQsnUobb1DArH4RuK2uais2Xw7EUtGf/BiM3mI0DnswogJaoLSPKeXiRnLyJgOC/j0qG54uccOiEMMYfPDXE841wvqIuECyn9gZPH0DRGMH1uUQyL9NaaVLa8T/G2E9XQbYd38+BrEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsZPNKzz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso87075515e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776292634; x=1776897434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWcnH4m44tyV9VYzXrBOMrFkiquZg1n+VHDLnpCe+x4=;
        b=EsZPNKzz95OsmgzMg1NrDX7f+XEAdknGUKvxwZhY4C7a/GhTF8nkieCULk9p+iGyoy
         6u2yMh4xzwodRTgdImMRVRnzndpwHntOU/063a0/kCLvxREOzq3On0tkAwXE1IiH8IrH
         k7lodyjTVWJO33BI3IUIhEZwphGaOH8zqgH6PGuatBzw4pH3q+2Bf9gCzxiB2S+A6c91
         7vAC6evmpqHSHoBqouwndbsCVmmUMCT2UrQ9q1WiOS9POTsWbPa8IGag77obErtqh7Ps
         JHI78mNwOxFddf28KXkQGUjXwb+QhqcT99YYrGh0bETdDY9Oncsu9j83NKv9AyCd9usS
         d67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292634; x=1776897434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RWcnH4m44tyV9VYzXrBOMrFkiquZg1n+VHDLnpCe+x4=;
        b=et0GkYzsWfPJQz0W8gixBIn09672QSxdroiWl/rOIctS0BPOzzr9uDsNUOzfwg5xVo
         Q72vD3iZppLtCee9Zre8GeBI+yAPE/LmA+WRVD7drKW9PKdVhY/JpZeR4Utj7hluOofd
         PESWwKfvJKHgt5uFQ3xu2HnDtZTsxD74ZB5td86joRk8w0klsB1giP387Cuh7sEgzMZV
         /mQWW2iOaXfJSfI56BhOWwicC6kBgT7xg1k7sXjPclTohWNY+mAPMi0F7jHjwaTWJ6y4
         TXxIPaXH2ydG0cXD4xxr+l3gBsges+vw71TAkXmCaQwXgJTGW5Sap31Te0VQI0NkNOMt
         TwwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9R6dBA5w+yNgZzYUGry2iG/8bszepbY9cxoT1jKusRRBouIhuJBkpErqtmVM5jMPrE9lAWpZ/qr7W0aiHicA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnCt9ffR1xtYhM1i1mo1dBx2OrPPbUoFDEuk7DrIjcwZoU7HA
	k4V+VyfsgXngE72bRFGbJzwm/QcpDPE7r9n16pun3Te+sYdNb/3pE4n79WILnnw=
X-Gm-Gg: AeBDieviVaZy2WK2XS18A4PcSTo7iRYAFTQhKkdwCJaOIehAs5h17niU48z++5jXdYA
	z1+hdypnpP1IAQX90zO7h3+HoRQhbGA0LJtWSGiOxnbiqsKC9vKJ12OCDUkURlWWLtsjos5iYp0
	1hbisDLpphIWSyzC98XUgGNL8X40vGMkqvTbKJuy5M1JldR8vLjU9goPWEYH1M1PC4gbTRsmB3a
	Cy4+ES82Wzbi9Ympzb3vEZquYT01MbFPKy8EBbVd/XG83SgknzK4DBdwlvP5BVMWadxF6Vqzbwj
	bbobSUhyUakwHXpGMPD3sASdCO81920Y4V/TCw5CMa4U26UWv0dc6YKvz2+GWubYcAIE2kJyWAL
	hv6CvpSn6dDQyQzpKlE7hLF2/NA3JZdEnSnSHMjQAxkpbO2fThet1vU5JCPcAi62QPwSd4m9IHA
	pSsu0=
X-Received: by 2002:a05:600c:6990:b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-488d67f5bf5mr339287745e9.12.1776292633482;
        Wed, 15 Apr 2026 15:37:13 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm2550345e9.6.2026.04.15.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:37:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
Date: Wed, 15 Apr 2026 22:37:09 +0000
Message-ID: <20260415223710.1616925-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415223710.1616925-1-tristmd@gmail.com>
References: <20260415223710.1616925-1-tristmd@gmail.com>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34862-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 11540408BD9
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
drivers/net/wireless/ath/wcn36xx/smd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2803,6 +2803,12 @@ static int wcn36xx_smd_print_reg_info_ind(struct wcn36xx *wcn,
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


