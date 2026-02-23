Return-Path: <linux-wireless+bounces-32084-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHYVNYrAm2no5gMAu9opvQ
	(envelope-from <linux-wireless+bounces-32084-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:50:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E891717B3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8052F3008D30
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9F314D36;
	Mon, 23 Feb 2026 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAC3wGU0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2B315772
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771815044; cv=none; b=Aqml9WMrEMCwSm0+qwZGA3ZZQMICDgyv4S31EGs1eeKXsEe6h5EzXU2y38dHcncdmK3U0KhsNf2qK76UCBnLxTeThwgebDdlAzONIf8QUr5fHdFZ+ZvKLnqoZ9xpFmE4oqlHa1KAbc9uMs18GhqMK3yHTvjXDosoTsRwut4Q8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771815044; c=relaxed/simple;
	bh=Ntjd8dKDHxN3QmLDOEWdwIAvZz+E/hihNfgf8IZ13CE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+bKJ33EIIHxKfq/tchiRRDDJfZPEIz20rskgjGU+JYC4gtehBhw+Q1xIfNX37vEA8tjcZN7GlN0Q2jSI41QviOOQZ5XcY6q/OG5u7cI20Gz4Jjh5KkOakylVvHf7+m5h8pq6wfA19aY0Dqpi4qFqydegGD3ibxnpT9haXSCzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAC3wGU0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82310b74496so1942777b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 22 Feb 2026 18:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771815040; x=1772419840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYwEqMTDEkYIz744K9YIkM6qtwcmFRZsZtzxibEPrqg=;
        b=mAC3wGU05dAGDWhyiarJ2+W6cr7yrBORPOK0ZKMYVenhmR3mkdMYxwhvdcI1773fIi
         BXcfBw13147gycoKfzQ3mcqO9sSkpu2REC+WAXwqSZGzWE/I4HPAylPpq1iPh+39hTBh
         s79uGJGHEQ9p5RTu907/B4EVCwOHjQa9oSh/2z0W8i44zyls3tbIbIuXrpv0APXWSNYw
         iJq/3uC2W20qtwpHTTV42EthlE3aucJrJuhqoB/ee0RRD3RupN+gVsNl1/72O1DyUI/O
         yTald1jinx9P30vzclJSMSYTqGHeaGJ6PjmTdyludCCbibcghoTPLuo3695bslPW7/kb
         Y9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771815040; x=1772419840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYwEqMTDEkYIz744K9YIkM6qtwcmFRZsZtzxibEPrqg=;
        b=GXEONrq4kB4erFx8JgzxGyYZPTbbEDRds72mVJe1u3hBUcjENnd1ZwXZ/SeHC3BXBj
         iGk1YLO+Wi3TBprmHvbqVYEdwqd68fqaHLTa8xh/nXuo/2DdWmQIoaqscZbi8tecZxrL
         EQhHpNVs4qVZfC7L24UmzBWRr9+evrRjWIbj2JoTbtiwxwq02d2s70xlp3Cs5iHbGtry
         x+a5NS54qEq5ynUlWaP+7MK/41AUQksJ8UqSgi0m+ldysSMzgTvzQIBKmvccOr1Jivin
         v2yAqL0SvSHx7lCWe+IrLTjDso+dw3aMzh5b5vwyJKATfc94cw9bZ+tL5iBG09zCTRpP
         ZL2g==
X-Gm-Message-State: AOJu0Yx5BjFhvrMP5ihbgSzWWtBrwVY+v3R7wqb8/GmSlK2iwHcAxH0W
	XxpMZwiv3ecFEPNUNl4YQWCSaXAqZc2BJP+KUfPn02HlZUz3isGGygpVZhBWGAAc
X-Gm-Gg: AZuq6aK7XasGyF5Llt16Y3MhBmiq9JI1xkG6HH+zUXNdxlS8Mpdt1a3o9IZjayBCsJv
	MRw/vxF9yVTTYNEoaXUpTnQ9fKTsevLH4Ls05dw5WuFQkdQIy/GCDg7JEhH4ooFK9JM22h1FyUy
	06LVkjmVnAi+Ui2H+9fkTeTp4+BU5n4dnGEveg1hBz3lSFWveSErBXlXMQe34Y2ENfW+mPWB0jo
	qNTa6prgFgVxylTK7MW91I9eesMQQmp01nQgl4BQKFNaseAESsolFu3HhwDlKRk6P9xLv9HkJOM
	MxLRTNClHZ+jgeA4OEHYrAbchs9Bjv69S6JYwXXljOkplPFIr6oB1dJjwYSxyUBsQ84haNVOXZZ
	BW0KWL1om7xuZiKwlnsz1euzAsTIhuXKe9r6EB4Nkg9EyBQgQSfsc2LbkFG8tWkFnWYYdz0d8Jw
	/8sdpZf1frxjivrqB/duTqw+dUpxS3brRfnouaF652KDILcLT7VVFlbw==
X-Received: by 2002:a05:6a00:23d2:b0:81f:4a0c:c584 with SMTP id d2e1a72fcca58-826da8bf420mr5571458b3a.1.1771815039470;
        Sun, 22 Feb 2026 18:50:39 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86c5b6sm5633439b3a.32.2026.02.22.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 18:50:38 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: use non devm for nvmem_cell_get
Date: Sun, 22 Feb 2026 18:50:20 -0800
Message-ID: <20260223025021.19008-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32084-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30E891717B3
X-Rspamd-Action: no action

There's absolutely no need to extend the lifetime of cell to post
removal of the driver. It's only used in this function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 28dc6c0e27aa..38fb1e763c6e 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -588,7 +588,7 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 	size_t len;
 	int err;

-	cell = devm_nvmem_cell_get(sc->dev, "calibration");
+	cell = nvmem_cell_get(sc->dev, "calibration");
 	if (IS_ERR(cell)) {
 		err = PTR_ERR(cell);

@@ -605,6 +605,7 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 	}

 	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);

--
2.53.0


