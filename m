Return-Path: <linux-wireless+bounces-31618-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHKQHnoihmklKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31618-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:18:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98F100DDF
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80DCA3007206
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AAE32B98A;
	Fri,  6 Feb 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt+svTkR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9C3148D3
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398323; cv=none; b=GVj7+qQTs/EchbL95S9bo0jP+WioRUDOWItVuMbYEhTiX85qHdfz+IkfWZrjXL3ISyWcq5fUPTuLuIUQDj9q97blK4P6JPeG46wJS+bVFdz7HWOwPN/JNb9gyc2qWnN738noE3Aq4K3xaZGCUQ9wynLEWft7ovxq2rIs73N/Nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398323; c=relaxed/simple;
	bh=5L02b5S8WrMD6pdvRZiXqMVBQPYLV+VXMQ07aTitZNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZ/P9WmYFoWZ9SwTZyxpCeqFh/uJmlC7e4CRwfr8mEih1CCd3L95lkTRVbk23iIEixlQ3fo+PofWK0V2SKLR4RstB7akT7WpIeL/IakHWXjN4QyD1WjVZi3U1psEJINtwX1/NjuA1awnhwEXmsCSX5cJbYXn489AkRIqwJT0f7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt+svTkR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359249bbacso2105909f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 09:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398322; x=1771003122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHLfwHamig3o+/rBZWB/HbkqcDb3bvgGVyMVqKmCT4c=;
        b=Kt+svTkRqnzkMTfgT6A7A1ZUe8ZssGs0xR9+J+DZZg3HoulNGxSJDY83LGXIbXUBRP
         lXeOFgTwJbRRSBf+9gqJQl7WxPx1QIx7WEp4A0F5PQz3L+A3SJq19nQzvE8j8QQdgp02
         yjhIWKRmXKSjEU/dbI/bqon6kYNYT4OtgGCEFvyxpLyYuPbnsbRyeOYRJxTvuadOHGPs
         ymaNPqU0wHsvoJn15JjdfeW05kQp+myNpZWGVpvJ6eUZorYvHq5OXCe6CfcZgpfunLgH
         RoMbw8UTWRbl5NHQ9uCuaAa0fgTFWBtjU5oZpqVk6wydLPatqNJ8WGaMDQRviZt+d7Te
         xS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398322; x=1771003122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHLfwHamig3o+/rBZWB/HbkqcDb3bvgGVyMVqKmCT4c=;
        b=BpwXUc6tv9Ae8ldGGoZyajt1cuDojx/0Txum68ul7QuDn5/OKATfwBdmthI2VmoxIj
         vkxaWAKT7rMGkND5hfkea5i3v81444ui2GIaEU8Hd4yQBcjkKGlt+BeNBzpvzmroIxxp
         27e+qoykxcTfY2HrusCCr/voxaPr+MpjszAwPOoGi2FmoK4b2Ye+7FAtxpDIBwqo/uS5
         tgr8aOcF2WaMaPTl6OJfiO+xPhxLNd6pArGjqmpcHlXb8ph9y5+7293UDxweEq3ubWuZ
         RcyYL5CCk+snqhjGaZ/iMR+6NDKiTUirs+5Ysv78korTeiVTqeEB+nh34dRNrnJWAl+g
         gAEA==
X-Gm-Message-State: AOJu0YzvSLFqG1GPUwDgX2le9dZgW6MNQdsdr2zRbmKppJWcIF+qRvdq
	R+K9T1nm4nhm2FTSbNDbkLNYrETW0zrSgeR0uC57qEovVhjqQxcNoBVVfEEDOqal
X-Gm-Gg: AZuq6aLg7J4QbNOGs4xAOZfTQidPidZUay5ybKO2b+msWWf3tUULL95/v9DwOeO8ySQ
	K2IlmdCUjLiD8iOHyYIwY8BJYJsWi9TRoWSlY7DcbItyQhx4jAnysSdPSZ/YbDdgiPH6LNg0p6K
	Bx3z7jXU/HCtXj2JBs85n98QlSUB+qH6QeX5QlR6oZaiUajyTv4mEk2cZAdfl9mLrYQGctHZlMF
	Ft5XrSWG2+oBw5D6hyhqOPN9ShS6jR7K/7Af/LpgUlPAYwK78KlW4REHzFLuUM4DXSuEX07ZAqp
	EIqWSQlEdlgtHT5Zxas5ImrWeDmDxcR4Iqi03g5MpdH+S9+E40CjPQtPBWor5kphsrhE+8f1INt
	+jQzLwAG6Ujfb3LsBpVJgKTnniTE3YZ3N5qCdZFm60SySyf4513xLaIKk/2X0dW9/f/6Jyjw9dA
	JnqGJA3yAA+KVJD0zlIGSqO1ljOcfuSRf5L34KM3Yo1/RSoCeK
X-Received: by 2002:a05:6000:250a:b0:432:88c4:e180 with SMTP id ffacd0b85a97d-436209bfc2cmr12380308f8f.15.1770398321404;
        Fri, 06 Feb 2026 09:18:41 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm7986208f8f.31.2026.02.06.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:18:40 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH v2 wireless-next 0/4] DFS/CAC changes
Date: Fri,  6 Feb 2026 18:15:47 +0100
Message-ID: <20260206171830.553879-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31618-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA98F100DDF
X-Rspamd-Action: no action

V2:
- fix warning and fail of hwsim DFS test cases

V1:
- report CAC ongoing to user mode
- add hwsim support for background CAC

Janusz Dziedzic (4):
  wifi: cfg80211: fix background CAC
  wifi: cfg80211: set and report chandef CAC ongoing
  wifi: cfg80211: events, report background radar
  wifi: mac80211_hwsim: background CAC support

 drivers/net/wireless/virtual/mac80211_hwsim.c | 77 +++++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  2 +
 include/net/cfg80211.h                        |  3 +
 include/uapi/linux/nl80211.h                  |  6 ++
 net/wireless/chan.c                           | 27 +++++++
 net/wireless/core.h                           |  4 +
 net/wireless/mlme.c                           | 51 ++++++------
 net/wireless/nl80211.c                        | 14 ++++
 8 files changed, 162 insertions(+), 22 deletions(-)

-- 
2.43.0


