Return-Path: <linux-wireless+bounces-36142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAwzIwxeAGoGHgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 12:29:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8549F503A00
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64E0A30028D8
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E06257854;
	Sun, 10 May 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxfqNKKl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AED2032D
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778408965; cv=none; b=kBINnUm94+1aicVXwi4hSeCeNG/Vgwv55ImmnwiQu10Ef4OQCqVXbOUI3i2+7LpfmnJNbyvleXtoSeB+rY4FIT2T53NMiQsWI9FBoKBu8KekfyC/9D+zFhS1PZ/ozI+Sk3U03NOqdBEkURBvrKp3h60HmokOZECRy2gsGUoRzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778408965; c=relaxed/simple;
	bh=ltj5jIJz3jYCHSiK7lEvLQu2k3TOuna65NztmtuWlN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2hIB9lT7ZaiZBZpyR7i+QJybfgouX3ue9oETgbYPw/1W052bM5o5INGRdPfxQyvBh2LXWINbL5RM+HbWeO+npDN3cUubvbHPTPakJ8+SC+pZvHx7tzmCXPKsO1NLAcdDzS15FUOvyqOA6GaCZtjb1WGezi/+iwsq8ZsuZv8ZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxfqNKKl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a86e4b950cso2443351e87.0
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778408962; x=1779013762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm2NpUzclqN0IBZ/9uP+FCJu6yyefdMO0RcOxoVsf2Q=;
        b=UxfqNKKlhNz7TptZw63JxTCYHmpvvb+yc03dxmmhAVCKe0I5RUR+8GS8tvLj8jbKVg
         8+0L4UTLnpbzt5XEBx+4tLBIVwRyFJiVtBF2UBf211BAcb2kZEKbo7kSbyvvhz1edahz
         aRzazfYoOuKLvb3Y30QioNqJ0DLlJl0FxkdxBYIRbbOhMKV/mAmFeoMwzeFUHg4jrDGN
         2/a+hUXsgfJqUoqXiTSboRfY6WHdqnI9WENLGdL2Y2GBGVk9xUiftlaVZyZhYLDo6rq5
         8KtM7IVbmAmZ1MNAzry8zQ5bMNdNNMIFsBOb2KvzZYLt6/NnHGLSiEGFclf6zZjm8au8
         v/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778408962; x=1779013762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jm2NpUzclqN0IBZ/9uP+FCJu6yyefdMO0RcOxoVsf2Q=;
        b=H6l+nzA++sAcGxvVjwiLNKX10DaSMKaGjhK6k1xLTz6Szg4N2ZkzXlVW06rTITu3h4
         AhjwpBfrfd841zr4qlUKQOtTaTS6iiE2uuB3/C3h2JPWt+qIIjRkduWaG32MzJy53QX1
         4Bz1tzEnO0+eQ6A0UIF7nDwS2zRjCS3mVI0zwTac3UGM4p6AKxMCWEomDs/fEima+H/p
         gL8IfTb7JpNU1P/qsOUxAEqhPurR+FbPCbbqpepqWj4kQHNlMb5O/6Q0siyK27KhFUw0
         olARdodbUPvGRESj5NnUp/pNg9UFEv/z3j7nqxxHOsKD1U5sdZ798UYN7XYNmCzhBAba
         y57A==
X-Gm-Message-State: AOJu0YxXE8q/Slo6eHNDoiIU3+RKfqFTLvJpIxfYoSsqEmRxMESJYYAb
	q5J9qaPP9DAxZpCnNZeZZwHanMFkCJcKLcJzRBPgi6V6i5kfQ2I27/Pw8kxNDhsG
X-Gm-Gg: Acq92OF+r5JEt0DraLjfmWf1ZH5mHHqukxKoRb+dH2yMgAOwZkBEwAYNowedvxSsr7/
	/k68BCq9Wrq1O6YWIENE5DjdLNK5f7xX4fCEXuG49ARjRena/rTCFXJ5+FSChaHo8W7MYi1giMS
	owXCv+45Qo6qKvqXh3OkXJFgZyfzjxNHkiRr9RHCyVTcQu+QgVtWb4I/1oAi34TD627zkhYS+Ii
	Dsg1AJiWS6if0O29une0OW0e5sOphTcQIHyBAVkjdZ8l6bdEszsdu6JJzfKNF0uVnfdeumhJito
	Hv/U2pdHOC/nA9h4lMoOO6OrrcEsh7GyWr/742BmbxncNd1kQAao7F56cW77TdwzEo2+qM9hDjt
	nNIZD/JC7PFFedm72tgkDao036KTN+hhsbXhJv9lUcqOgsevyzw7ZVrYnTKOCbQl7XLtRjZfbLF
	XM5NcUiYQk//WIF5i9txaTvjRts6pnkw==
X-Received: by 2002:a05:6512:3e04:b0:5a4:d44:99f0 with SMTP id 2adb3069b0e04-5a887ada973mr6764095e87.6.1778408961711;
        Sun, 10 May 2026 03:29:21 -0700 (PDT)
Received: from arch ([217.76.176.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db2f3sm17956511fa.22.2026.05.10.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 03:29:19 -0700 (PDT)
From: Dmitry Gomzyakov <nicerok11@gmail.com>
X-Google-Original-From: Dmitry Gomzyakov <kyoto1337@protonmail.com>
To: linux-wireless@vger.kernel.org
Cc: Dmitry Gomzyakov <nicerok11@gmail.com>
Subject: [PATCH 1/2] wifi: mt76: connac: add MT7991A (0x7991) to is_mt7996()
Date: Sun, 10 May 2026 15:29:10 +0500
Message-ID: <20260510102911.1883849-2-kyoto1337@protonmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510102911.1883849-1-kyoto1337@protonmail.com>
References: <20260510102911.1883849-1-kyoto1337@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8549F503A00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36142-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicerok11@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Dmitry Gomzyakov <nicerok11@gmail.com>

The MT7991A chipset uses PCI device ID 0x7991 (MT7996_DEVICE_ID_2),
but is_mt7996() only checks for 0x7990. This causes MT7991A devices
to use incorrect chip-specific settings, such as:
- MSDU_CNT_V2 instead of MSDU_CNT in TX descriptors
- Wrong WTBL BMC size (32 instead of 64)
- Incorrect prefetch depth for MCU queues

Fixes: 63a4edf1cb74 ("wifi: mt76: mt7996: add macros for pci decive id")
Signed-off-by: Dmitry Gomzyakov <nicerok11@gmail.com>
---
 mt76_connac.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mt76_connac.h b/mt76_connac.h
index 51423c77..db07f3dc 100644
--- a/mt76_connac.h
+++ b/mt76_connac.h
@@ -230,7 +230,8 @@ static inline bool is_mt798x(struct mt76_dev *dev)
 
 static inline bool is_mt7996(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7990;
+	u16 chip = mt76_chip(dev);
+	return chip == 0x7990 || chip == 0x7991;
 }
 
 static inline bool is_mt7992(struct mt76_dev *dev)
-- 
2.54.0


