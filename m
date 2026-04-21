Return-Path: <linux-wireless+bounces-35149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODfbHpqA52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E3543B8AF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F9CC301D615
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920203D8914;
	Tue, 21 Apr 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enzZt690"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6E3D7D74
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779377; cv=none; b=hQmg1cLO2+/Z1qcXSoagaIekT/qKd0yiUU9W/4S8+EyJHhEWV1UrGbz84ZKjkYQdwgOES43bChOY7Ni95Fuz1yTzY7/5ORnFdnTiWGYmx9y5EcSnAKDlAMEIMbU8b4nWq4GAUSKQQvJzPgEorWVeck30uBRBhKXDdXQAv4U1alY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779377; c=relaxed/simple;
	bh=kYvWMaR/h7jQFecF2mQH90g51Vwmu+kwPEDpTh4He54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFQ6MHPAqPYcQ7wjI6tBt/2yc74u+Y9SWUv4DRIBGqNgHaIp6zGRriRlQmryVU5muJlJ64khDSGDuS3WWMVeCDD3xv5mmIZAgmXE6ZmkMhlBFq2Xh0tO/MX28s+7sXqFaIEkOrjRIl04+4kCZ9VhA9d4ETYKZhSMK/xIc1jsxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enzZt690; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891cd41959so23287955e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779373; x=1777384173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkPIrWAw2BJnj1bF5bBeqq1kiMLomS8oH1yW25eMUD8=;
        b=enzZt690wIPTv8rUnsAFMXS8anbekKv5SfZ6ttWmeKmxORRtH697jxdLj5xN1oQMH4
         2t27rlT4/iCOGYmnYIhQ3rgK/i55ehAmZhh2kXy4IQK+5hibGipTALO+IoPqdB24id3e
         s84MFWWIHmPmPvCwUDhxtpC9gEWGE0cTbFNGEHpraYWUezYKVMngiZnxlH6ZmvaFrJRc
         NuQnLUqgdX0Bvsb5kThFeRNm/EzYmNztqxrWmhxdUjUOnYVz5aPm0udHr5wHPEnO7XjN
         awx+gQ+7zdhljwzXfo8Q69tRkpNV6TRXdTxHNJLGaptC35QofJhIf136Imcx7fCFmWM4
         qixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779373; x=1777384173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VkPIrWAw2BJnj1bF5bBeqq1kiMLomS8oH1yW25eMUD8=;
        b=HF5kQXhTeIAmcgEBP2cGzz/3EFnuT3zGLkvTV80cYd3OTlXjYMWw3ffI8abd5UtF5Z
         LokkajeaHaTe0F7KCMvanIqYO1LXWyVuvegx/xWzYfDo+9z0mjYTlwRrJ8A4UT3LkT4e
         5w6WsLAFhZvojYDsV6sf3ZiMqAIdaAfXejD/QweXZSOAsswLwX0EiWP/oMy+7OKbTZcJ
         9r3XXMHbHU5ve4mEIl6Fyt+OEb4gQ2srx/rGeERxXPOFtJrBNUKfrZZ3YKT1HMHx0/Mr
         dBkRGWp28gwOvLXc1J8cAEDzy8NG4bHxe+8Wtb/PJhExiQ81pyqHZeXTag879J2pBeVA
         ez9w==
X-Forwarded-Encrypted: i=1; AFNElJ9V4q8oitVTbxSU6GGbN2FBddGPAFUHoNXfxzXs7+l94Fe/JPMNPVCDd8hyyoCt3XWkPIPj4t7eKYLgY8zbnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrmhhrQJyjMh9hF5chUEhtF5Ml+LVciCJQ6rc/TEOYS/lLX3b
	SO7VU/Cl6i9cTGLOukXklDP0aX9wqGuYod35M6IsAPO6uaoZOZZbjh0=
X-Gm-Gg: AeBDietGFtstllB6OO4Vc/BIwa/G14h1eIQ7GzqNaWf9UlZDBU4FIDfxp6Q4vOp9dH+
	2xoAmq286Ub69oWLN52P5iEgskyTXxdKhjo6EiEGbP5vH6H6rGrBVBpm6vhVBDiLxXMEqnwgfP4
	HoOB+7UZOoIoIzKwuZQTkYr/fLkAUANJegIEVTXz78JPWp6pBZICk7Wo5TAgT193ch25nd8nIw/
	MR0WBKmSkoXhug+PsVdNLCbo/VEQ+efr6c1E2v34fIt1WBeArecbN+8nV7Na1k0crj/h/B3K4xt
	rmYZJ8k4G0Myvba+Df11y0gTV9uBnszibrt59rNfPpZBrKFzy1Tup3oaBOx8yTJ04DH8N5SM1x1
	hbrT9QP1b7KXZ6kDiJGDlNU4ZnjIRu9HlPivRT+38FDQHyQOTns9OZzI+xN7S7p0V4dnKtr7h2Z
	CTwj8=
X-Received: by 2002:a05:600c:c090:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488fb74e130mr187792215e9.8.1776779373034;
        Tue, 21 Apr 2026 06:49:33 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c318636sm168157785e9.7.2026.04.21.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 3/3] wifi: carl9170: fix buffer overflow in rx_stream failover path
Date: Tue, 21 Apr 2026 13:49:28 +0000
Message-ID: <20260421134929.325662-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134929.325662-1-tristmd@gmail.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35149-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 23E3543B8AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The failover continuation in carl9170_rx_stream() copies the full tlen
from the second USB transfer instead of capping at rx_failover_missing
bytes. When both transfers are near maximum size, the total exceeds the
65535-byte failover SKB, triggering skb_over_panic.

Limit the copy size to the missing byte count.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - Use min_t() instead of separate if-check, per Christian Lamparter.

 drivers/net/wireless/ath/carl9170/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index f6855efc05c0f..ccadc46385240 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -918,7 +918,9 @@ static void carl9170_rx_stream(struct ar9170 *ar, void *buf, unsigned int len)
 				}
 			}
 
-			skb_put_data(ar->rx_failover, tbuf, tlen);
+			skb_put_data(ar->rx_failover, tbuf,
+			     min_t(unsigned int, tlen,
+				   ar->rx_failover_missing));
 			ar->rx_failover_missing -= tlen;
 
 			if (ar->rx_failover_missing <= 0) {
-- 
2.47.3


