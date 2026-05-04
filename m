Return-Path: <linux-wireless+bounces-35871-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAv4IaC2+Gn1zAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35871-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 17:09:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D704C0702
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAA053014C1A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5B3DFC69;
	Mon,  4 May 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srOrwM4J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963B379980
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907072; cv=none; b=WlOTjUd2RcjUosDaRmbfOwowA88jEbmeWopvwMXIJzZ4jMRUNJnM6+I8KfRlnD1sHSYndpQCNaoEIqUxWzvyQXlpa4pEhaOwouKxHd5dgQ228ZIA3EHqQ/5rBQxTl1l/Pa+E94Ekyd8kISXcxbLFPVZ7KPltu0P2of7XB9nyg/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907072; c=relaxed/simple;
	bh=Yt4A0MzYN/tsaoVK2cBhR8wxZGV7tJn3Sln3wpgGGAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zid4R4tNas9imrBd4QZBYZB8nByR4tAva7VDnJ0vJw41Qj8bN+gJQILm+ObgqwJQSuwWuVkQzJpvfsDjMOk1IfhYHzOGnLJlnNXdJRhIk9xmrBUudG8pukVXT2aGZcS2299mJYpXHA5kclc1YBwPaUvYNcom5UwDNawNYZD2u0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=srOrwM4J; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b150559bso28583335e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777907069; x=1778511869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMwaaxyUMbb5vsWnM71O2zBL41qveZmApNGg4f9GG2o=;
        b=srOrwM4JHvL67iAK9z3n10OMwKO1mMyls2jRkpBqA3qb7If34H3nQCvDYCgu5oW/WU
         6RwxxpVP0gzRo27C8OJXLbFQ9PPKrPFamONqyOENsV85QfEkiQu9Q2FqRikit2k7GWv1
         vn6hXfq8tYAGyhr3bZGzWBqcx3uhA49mUnV6aMrL/gh0bbejoXmosTEYYGs7/d44kPkv
         Fpb6Mz4J3tZP/7lXC7wz9VTRKcFlfczWVxMrb4GOBqXKLXjQRfkQTCuQyeJ0ynPzojfZ
         nkQEqiMBzivbak4vhC67Vhn8yODlyfpFoGlZJbr1TH/zBIzENB4bcAK1rb7Fdo2/sjwN
         dBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907069; x=1778511869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMwaaxyUMbb5vsWnM71O2zBL41qveZmApNGg4f9GG2o=;
        b=MpGwjTvF4/Ry4DzuyqpbPJRWW6XMBXyylhPWEEGyNklZRcrBkOh1ExyUZ9VxaeP8y4
         2RkG/HFwc+dISIeZXgyVV1kgz3uWm86iSfwe4BUO7KAykcM2V1L8Ca/hbm4vzbXQobqY
         kk19XNcNk+7WSQEBrRhbMyiW6JZ56Bn2IuIWMCkRrLFK/TJ9vh4PIrQj6zwyLpYUdMJI
         2r97CvttwdutJBYw0zmGF7ckuhNuUWZizB9xXXWWyyPp/GeD+VhkPZwn6mP7sp/GjNlL
         K0d5KGW4S6E/urFR7kTTVXSQ7zjULGYoCPEKhdSp7bDeGO9TEV0R8inhaiGsiMTvEjN4
         Y9dg==
X-Forwarded-Encrypted: i=1; AFNElJ9i+XChEZPlNGe3gG+MfLk1Ji5m3Mo/WEJnXLNopPi+jRz8EZfZoiExEhQqCmmyYnnfk9mTDP9GgSjEYbxjlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAH6ZVuxLAf4VVTo9Ve+/xXLiAfaJusaGRycwaf0Y096IXihAd
	RGRT61FPi4LgfdsPpJn2ofTQRghMZSYtStElvdqqeNdZZ8yGp5ptVoU=
X-Gm-Gg: AeBDietwMb5zKhWvDQjIWBsIYQ/TLiHl7KkhdntlA80hzf4xBjUDK2+KWALLrIljSNb
	ggDajeAMs9i5cIp05gaAU9FGgAYIFBFNt5CX/pjDy3ZwnetmaMS/tFL5iCgvJNzyUisyS+DpkX5
	o35ya7UOTR6fGlynNzedJszblxzkBZorGWAOc0jxXSwqKtQZ9tTbnP5NLEQr+NGeTrebDun1xqC
	qARy3sZU+Q7i5dlg3aubhymhchzp/39zv9ICLRlbzS/0iQVZeL47H3sPgxKYV8U3gs5rOBwyZDU
	e6nVppkHH0DZDM5eSUjNg71r3JyilHSwdhOCepOnQSFPO2km5AcwLXu4iHgeO8JgikYx4MldXDU
	E/VsGO1YpOPHs0qTm5sT32jK6TbE7Z6lAVpYsAyMDk8d9FJ2ufGBGBcYlFLpb+75jHl+f6OvyQ8
	WQYMVbbZqifv81MKvOFsMX1IcvjCaQhvZP1NTWd0Uv6yY09yFVceGFnlELjZ/GOWidtTtqUzkzO
	7y0MaJLYD2r0nC8hqjaNE4VGW99ph2x
X-Received: by 2002:a05:600c:c058:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48a9867c8famr131209335e9.29.1777907069075;
        Mon, 04 May 2026 08:04:29 -0700 (PDT)
Received: from archtop.localdomain ([2a01:599:912:6541:1453:2633:891c:c05f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm462089755e9.0.2026.05.04.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:04:28 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: johannes@sipsolutions.net
Cc: dcbw@redhat.com,
	jakovnovak30@gmail.com,
	kees@kernel.org,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linville@tuxdriver.com,
	mingo@kernel.org,
	skhan@linuxfoundation.org,
	swilczek.lx@gmail.com,
	syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com,
	tglx@kernel.org
Subject: [resend PATCH v2 0/1] wifi: libertas: fix bug in Marvell Libertas driver
Date: Mon,  4 May 2026 17:04:15 +0200
Message-ID: <20260504150416.4853-1-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <57275e905a67e789ea438bf637be0aeb442fc880.camel@sipsolutions.net>
References: <57275e905a67e789ea438bf637be0aeb442fc880.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92D704C0702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,lists.infradead.org,vger.kernel.org,tuxdriver.com,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35871-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is the same patch with the suggested tag and message fixes.

Jakov Novak (1):
  wifi: libertas: add wake_up() call to properly notify

 drivers/net/wireless/marvell/libertas/if_usb.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.54.0


