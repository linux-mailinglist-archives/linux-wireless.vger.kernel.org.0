Return-Path: <linux-wireless+bounces-15853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A859E1D0E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C6D164B27
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD281EF0B8;
	Tue,  3 Dec 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtZBHbgg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2221EE039;
	Tue,  3 Dec 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231229; cv=none; b=Q75aHQSNH5nlHOpZl/mKm47otaXPSCBVASLx5xLrx/oXpRKobt2o2P2PpgD0/Ddu9XHDeObaVxtDeHtQIzBmT3bYnvBsExKTE07KatC/yONycqUF8rqXELLWlvwh2sHk1bIle/HHLEtyzmqDJD1hYKu5gTn2cvPv8ZdZGbamftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231229; c=relaxed/simple;
	bh=yuzXuqy2BaLA+Uhi8hRYFXu6LIoO/lrOwNGMwxjrVEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp4YY5IelW4znY9t7vX4ZFujybISnQsOBpZl4DsWU3oQf6f/3LXLN6sk+8jOVhozZfVpHloSVA5Nxbz8RNIPixTU+jEQH3G173DB+RSUeZlDEAuUueTnRC1TZjVRHE0b+yxk0xNo4W4Y5DKE67tNmfSmW4g3Fx0FwliqcRkjYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtZBHbgg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso48140125e9.1;
        Tue, 03 Dec 2024 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231225; x=1733836025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmXxbD9V59NvLKwy5cyKdu57L2KQNure18tEYHT0lFs=;
        b=FtZBHbggLuE9hWZCukLwOV4mO0W5yehsmRVuOzVbWOoKjzrRujpCNGgtS3PM7Mfuul
         3HBOXHAXbIsMR09i2CZD6EbhJP9jemxSDaCl8LZ2Rn1Mf5GhRAiNpSHqMwcjRuu9EG+3
         EdmMb57Km5YCU5bmwHqMAojWPClfMpB5ewHBspb8qxkVtjtc3as7F1GD6IJ/r0hPg83k
         W1xV8sQSDo0ksXpyTnja6FZ+MhZjCcEf321jCUAQ2DcJCJHyYzKSLTKiwgK85KIi5YWC
         HmixvB68hoNhNT5GEeeS5kHLxlr497SO/6MrgK4ndgYxaT8k7xkQ9SrZz6TRNsHkH+FC
         Qz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231225; x=1733836025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmXxbD9V59NvLKwy5cyKdu57L2KQNure18tEYHT0lFs=;
        b=P8sx/6kR5CR9qAYH3F0DbN8tlsJ7siDrY4V4LKfySGByXpctCa3fIoBIN+wnyZMxUX
         bxUV6yn8GDP7VEZIn9uKSgorz1/2xQnTkg8JGGSIVRkVAYfuQCWsKopCzEmXFDAxti2l
         jykgGDvlyKS4LSZ82zCvzZMkdxruW4g1U3sS62veFVPE28z+M9DApSLQ4LMYXMFp+YGp
         VgB+xtTW2XXGYFQjE08LGTjuTOYlodtRv7QxA0U4MDwfu63bmODq12Ft1Kg+8KBwP4P6
         h9rPBJKJ5fDmY/jDIychWMFtGggrk+uSz9DKWZmoJMfzpz/FkhIVDQDvsnFWiWik3Mkv
         4yTA==
X-Forwarded-Encrypted: i=1; AJvYcCW68mMmXXFJ+pXxlNtgOQkF5dyAvzfUmn2iRfU4Bnc/1BctA5DZK+UJCbTi70ysoESqcWMcl/3P+lYxOfitDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyjU0hKcRKdnzjC/4nqQIYi2XeiSABoXsT6nE+UynY4iKYPsC
	QCF++g/r9tQFF8TNWODkuxmllddZghHdonehGFtQ6leJpqvavLGhbESa8A==
X-Gm-Gg: ASbGncuQ0WbAXW1djT6YYb/G9fsgsd1W6InNQgArNpKW7VqtZ3fCW4lU3XiOfoUhSSV
	D7tMGcuMzwtdOK1+tiSW2plgyUWC2VZNIHOwMCB6xL2y4j7jAXIDSqkwfgsQlZ5AFGGsqnOcAzC
	o0XJAkMdN8TzgIg5PnbPTeESsPuP9nmftV3hqM8E4FT3T2GHFcsRTErWzBhSWFlNb0X23nO18Bp
	Jr/VVns5KiV6KOAmDM0ZBU5vnkp+ZnDEfSKcS/hZgu5lByw+OgLxhHSqMP5HgJyfmE=
X-Google-Smtp-Source: AGHT+IE5ZZ2tBelQCb+cLoNbhTP1TbRBwi87+rDkodFTFJOuv8fgBz179LlU7+mbTye78HiDiV6beQ==
X-Received: by 2002:a05:600c:6016:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-434d0a06603mr16236245e9.21.1733231224505;
        Tue, 03 Dec 2024 05:07:04 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:04 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/7] tools/net/ynl: support decoding indexed arrays as enums
Date: Tue,  3 Dec 2024 13:06:50 +0000
Message-ID: <20241203130655.45293-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203130655.45293-1-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When decoding an indexed-array with a scalar subtype, it is currently
only possible to add a display-hint. Add support for decoding each value
as an enum.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index dbc7a0a6ae68..0d39a83574d5 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -650,7 +650,9 @@ class YnlFamily(SpecFamily):
                 decoded.append(subattr)
             elif attr_spec["sub-type"] in NlAttr.type_formats:
                 subattr = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
-                if attr_spec.display_hint:
+                if 'enum' in attr_spec:
+                    subattr = self._decode_enum(subattr, attr_spec)
+                elif attr_spec.display_hint:
                     subattr = self._formatted_string(subattr, attr_spec.display_hint)
                 decoded.append(subattr)
             else:
-- 
2.47.1


