Return-Path: <linux-wireless+bounces-35163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEz0A4WC52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE943BA67
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20EBC30B64BF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CBA3D902B;
	Tue, 21 Apr 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwnKcPNe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B53D8905
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779407; cv=none; b=p277cuQW4d5oiUSIY+4G+FRaqUFPhxxqgPk3NaAbKEiImQ1YAXYl+Og/kYbwRbT8/a5gJxeGLNckGadGmhaDonaQMpKcCpuaXE0MZBAOGOF0jDOAmsZwWGkF9sGdIKkklL+rq4kkSwGO5re54vuwcVznkL5Kd8EOOZ67pc6ZSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779407; c=relaxed/simple;
	bh=0WadmMmBSrMaXObTN/0BFPJxNWReAf56WWu2RFpWY4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuELKlG0O15EwZuyTh9CKw/0ULdPbL4+/TN0GxuC2/hHccZKk786msZhEpl+V7/PrMOXqIa2CCK1cbjn/2iDX5KEqYBd5Tr7JSfGl1KcVCytLBUQoOr+Q3HOI55jK7Ja3HHAQSpl/eZgSgg+A5THP+vzcinTeDxdGtIMIaKaFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwnKcPNe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso33317235e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779404; x=1777384204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juiBeaqtjFI8sAZT4nFRqVjJwbOXXJpwXH5RqDi5sD4=;
        b=nwnKcPNehCdeqaN7L5PIApskbLbviOCcr/W8Xn3DE3koNWJwvCqHkK20//abxyzl6B
         aMpHaZYzbET6HQIIPOU1mxIT7BbxlUovvzu0K3zH41h+4O/3zdDS21rnL4Wm/jC+9+jc
         TC2CdnvI3c+eoOc2Z+6xgQGy6TzBGYbuLsMqWvd2kdLfzEIrBowoHY0qNznc+Da6peDB
         cAW6/WOm7LkkNTbwmcBCNzVWHzPYdaOYk6+kjY/PVs6pgRhrU5fIuG9vXuZ6QE7b4hru
         QV5WaX/QYikGZNkSQB9MVvjUVqhDiSJT8q6S6zFsoAwPrmIqvNGNstl6IFo41HTYKM+X
         W0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779404; x=1777384204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juiBeaqtjFI8sAZT4nFRqVjJwbOXXJpwXH5RqDi5sD4=;
        b=K7aFWgm1/ukCcrR7EBh9yVNz0M3u6O9st3FDG523R5J8sCmDZx0aCp4sn0zRPuAHht
         nCXqpvFciFVIYncH5VQTDIpemnvAGb1QO+Sj18VxwZiGl4L5IaIrjt4lXSeZEBYRHaS5
         87X6cC5leZXQ7ml3u47h9GKxoGEokNRYnEKT5Dfkv1HT7GiA2cqrDkZimhH9w7H8Y/bv
         FTg/ftyvGDO4To211LfGvOVkjGGJ5YUrfnaTUUeXt6SmW39j8LzbtD0bHyzQbfVrkon+
         9TCZncKDtawS+EHrjsLDe7A+1M5oIYewz8vXZHFWObVq0dO9AGhOFQLprggpfdmqharN
         c+2A==
X-Forwarded-Encrypted: i=1; AFNElJ+UhVVNg1KdeqcYAAI7ljsguamLSAjXXJo69LSdsIgf4qNKoMbCdjhjGYDldI4gx2SMNtA/M6Q55mLrlIG4sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7T1/2X0HuU24jLdcwrS1VHTzNEZeZL/DK9Rl/c+ZjEAMatfzT
	wz8m+hWZb2U3CwyitPEzkxgBC73vwEQCdURzr2eil3t9SHFhnlqfyPA=
X-Gm-Gg: AeBDieszFHgPfKrNUGUaLN2TwMNFsU48edYA/eMGsw2OQ9yPeh4xFHTuaQMDvelDtXu
	+INWwL0O3Pn8MtkmxQljKmktttitrMMjlRQb/zAjNncC5ooUVionN/QiUlVjGzSLX3/M4xGtYA0
	A5Uos3RhGj5HgfNRXV65SsovNkdj5uCrmnp8QRliGkqeXi6/CHk5qaX/wZzWLKGx0gDqoXfuiwX
	R+n3/dtmsQo+lVDnj1L+qtgLmi+/Wkoat6ylsIqXiuwmF8/IhghH9Wf3XeWH3gQrQj1+fso7MqZ
	9pLd4pqbwWotRyEOAOmcQMQhBc9qoPnLIJdNwjDq2MeottizoXianKvJKkEvKdwXk2uT8o7Cs34
	L+3hXLbkKaDDA7lYuVgFU4QTNiDTciW5s8/L7OOw41DBF2ZZK/K4sSiaWFLhpCKeKZhU+fNJ4mZ
	nLYXc=
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488fb792dd0mr256087335e9.23.1776779404352;
        Tue, 21 Apr 2026 06:50:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffad20f2sm157213795e9.0.2026.04.21.06.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/2] wifi: wilc1000: fix OOB read from firmware RX packet header fields
Date: Tue, 21 Apr 2026 13:50:01 +0000
Message-ID: <20260421135001.343596-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135001.343596-1-tristmd@gmail.com>
References: <20260421135001.343596-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35163-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: C1AE943BA67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled pkt_len, tp_len, and pkt_offset fields from RX
frame headers are used without validation against the buffer size. This
allows a malicious or malfunctioning firmware to cause out-of-bounds
reads from the RX buffer via wilc_frmw_to_host() and
wilc_wfi_mgmt_rx() memcpy operations.

Add bounds checks to ensure tp_len does not exceed remaining buffer
space, and pkt_len + pkt_offset fits within tp_len.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/microchip/wilc1000/wlan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 3fa8592eb2503..18024287f56a6 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1123,6 +1123,11 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 		if (pkt_len == 0 || tp_len == 0)
 			break;
 
+		if (tp_len > size - offset || pkt_len > tp_len) {
+			dev_err(wilc->dev, "invalid RX header: tp=%u pkt=%u remain=%d\n",
+				tp_len, pkt_len, size - offset);
+			break;
+		}
 		if (pkt_offset & IS_MANAGMEMENT) {
 			buff_ptr += HOST_HDR_OFFSET;
 			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len,
-- 
2.47.3


