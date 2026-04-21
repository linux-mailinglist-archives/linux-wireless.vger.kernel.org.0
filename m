Return-Path: <linux-wireless+bounces-35132-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAC3LSlc52l87AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35132-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:14:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2042D439FB2
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F6930210CB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558213BE17A;
	Tue, 21 Apr 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7RTXeAQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA83BE16A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770087; cv=none; b=gwBTUrgcctVPjz9hjjjS1IapBoB737tJsjgsOISxHKxroZDGCyjMGHDauPYY+WWLnw7wbJWd30mzbZ6fbmSsqGVSW58p6arkhgXhvfNLLDUvB+dK9QPZTMh2EOdp+l8EdaqbFQ88PyGeguQpgkMrpKxKhPpv5J5h0WzlyBDBMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770087; c=relaxed/simple;
	bh=L19LSPbholYz6v6UPdCXtnAtyG6EQ+0XSqoB9V1gx8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ud6X48PzMMR0XnWrQ8Ozfn+kA49zJCa3HZXdINkSDRxJTOaLrvMZLNrvktVyIpZJWh12K6LwfNdC2CXUMgXIJjFRE5tjhO47Nr9b8aaZ4Ne/VDMkbff+HHkzr8aTWtnGnk+3GTjpfO+7vB3OYnR+LBlm79KbPKA3J6P0r5nGYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7RTXeAQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so38797545e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770084; x=1777374884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upuDlDdqiwpaGhHfy9R50RdiX8TV2a08ka4MwC5Mgoo=;
        b=k7RTXeAQcgKzmiYdG4D8PeUzKXy+IrzmJTAe1KdX//uUYx7SIihge7xoSNRvee1Pag
         J3uBARL8WuAm4oEth56IXQztRWOfx/W0HmCD8s0CvNXawEi/b8H0r/Mww12A+d1egODy
         6f4qhrNQqvw9T5JoqSsGI/H7Fc+xiMKQLHsZDoP+VyaEJIJL98VI1Yg1OGnbHjjZIoTk
         QrZVY5HbQ3Bq9Nrin6DSyVPpdrkjBs1p/rRoDE+Ne5ChYozWw3TDwH0kMr+S9B082Y4s
         LcC/PwSQHuIq55z0mxhv3PgZ+i8fK8O2tM+SeoWIRtZxQHir9Pix2hokZIljMMZOW/37
         aTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770084; x=1777374884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upuDlDdqiwpaGhHfy9R50RdiX8TV2a08ka4MwC5Mgoo=;
        b=V5kcXMWRtGT0ijvFjxM9ncRO13ndBxZy1SMycwHdMwEEzLiEsLpXcXDFVe6Hl8j76c
         ZC4bMY/l91frOjow4rmxAtSnTWYy+wPP0ePxnoAtKwk6n3uMICAOBqLN9dgyX8rZCAI4
         RTQjlUP7Tf0CtDZEC62hE/YOrlSO7iOcMYPbDD3j5cZ+779i1NLtg+51Yveyn9G/d2N4
         EghGZNCMJ2VdfKujwv5Fu3hYMXU07m/0/lwMNHH+lRnxgNU+EBnLXZkkC6dBZ4HS1Ou6
         /7k/gfgxXjOug/QsHU4yGsbkePJOIb2ixjgTdUhl2TO61RXKYuKexflGPITsBmPjxIfq
         9wTg==
X-Forwarded-Encrypted: i=1; AFNElJ8/2UZ+QI0aJ7IkDfrKMAD1rBwuUZfKq3HhWN89j/4iXN7F//QhtMMujpxV07fTkQRlngXqcMg+QQkm4nQwXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhXEdxO/Q2Pwv9s7kGvfk9Iid7sOYuK9ISKpcQ5jZAfQH4tD5
	1yzbGK/nvcvlqKcf97ZQdni2cOGJ19CaDR627E8++tcGbp39XG2X9V3WmC7c
X-Gm-Gg: AeBDiesqyYRJ7pk9MfcbpWEGjR/2YSK7eCJoTXHXSDJkHYUmHhg7zief7zUvrggY2x0
	q4ap2zJbD6qgb2JuwymajYHo9VJ5+NDq7PUOawQUmND5BM15RmtrUJVkSSahY1FFtdinktsra8r
	S+PCK5KTaFDQLVlY4qzYjohrU70ZJQrC3MuYhaNJQaCW0XK/wakNki1oOSRvOvvywuyXPzTDPXw
	5fu1VPiXK8Jvbovm1lXvB1DbJF6Wlb9/5GcSVlXB4xht/TdEBYgMWsEJKFhxAZ2UgmC05GyONx9
	NPeCPfcl0bGh+eiPNbTa5f5kIkkcQ6Em8J6QLZ4QNyQLGXfgzTY3sF7db/LqiVjFc8t13BYYK3d
	Qd6dIF+IA1v5IguivWC8cvOXtaNtdo6QOms1ZvYoEnCTXzRgLZlwbk5Zjo2/KrnW9drgxSX72aO
	1ZaXE=
X-Received: by 2002:a05:600c:1907:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-489201cdf13mr91392655e9.12.1776770084032;
        Tue, 21 Apr 2026 04:14:44 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891ffd2030sm37397485e9.20.2026.04.21.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:14:43 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] wifi: rtw89: add bounds check on firmware mac_id in link lookup
Date: Tue, 21 Apr 2026 11:14:42 +0000
Message-ID: <20260421111442.3395411-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,talencesecurity.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35132-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 2042D439FB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The mac_id field in RX descriptors is 8 bits wide (0-255), but
assoc_link_on_macid[] has only RTW89_MAX_MAC_ID_NUM (128) entries.
While the driver currently assigns mac_id values below 128, the
descriptor value comes from firmware and is not validated before use
as an array index. Add a defensive bounds check in
rtw89_assoc_link_rcu_dereference() to guard against out-of-range
firmware values.

Fixes: 144c6cd24b35 ("wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Wrap check in unlikely() since this is a data path, per
    Ping-Ke Shih.

Changes in v2:
  - Plain-text formatting via git send-email. Per Ping-Ke Shih:
    defensive framing (firmware assigns < 128 today, but descriptor
    field is 8-bit).
 drivers/net/wireless/realtek/rtw89/core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fd29dbbb120d2..05adf20a65be1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6492,6 +6492,9 @@ static inline void rtw89_assoc_link_clr(struct rtw89_sta_link *rtwsta_link)
 static inline struct rtw89_sta_link *
 rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 {
+	if (unlikely(macid >= RTW89_MAX_MAC_ID_NUM))
+		return NULL;
+
 	return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
 }
 
-- 
2.47.3


