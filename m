Return-Path: <linux-wireless+bounces-18621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB379A2C253
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27544188CBFE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128D1E47A5;
	Fri,  7 Feb 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDTqMpfu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6721DED70;
	Fri,  7 Feb 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930524; cv=none; b=ZdBlxAkn5G/mTNgkLyN6n7ZT05iwikgJdvAkeT3/FYtbLUevIEs7iopRr2646bLDYKRebbFrNZAhUCpoWawd7CmC7+F0O9/DSoFkXNds3XFlrBj3myx+nkcgARz3ezZG+q2ABIQFdsA1TUrHPKt+/A4S13UEdLtsXO6oF7A1gCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930524; c=relaxed/simple;
	bh=MIEBxlmM/JehrSUbCdGYuUJVphACPYc5J2/hOlFW8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O54XfuctEz0dE5wMZz9TQfmZiy0HIfuhuBLhf+Vn+/jguBwqWEs59IYyzUy+hgtSAAIsV69ZU+7z9r7g+iC0NeulrvWXEEDY67VeZdy8HOL0sqwlEdwPsdmPpXwl99rkzo4dxDz0307D8REC2hg6lPAyEYFwTihQLdG4No+PvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDTqMpfu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dae70f5d9so981893f8f.1;
        Fri, 07 Feb 2025 04:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930521; x=1739535321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1vk9Xp7oEUk84DuTuRzAw8DRnqd3iIb00KUqFXuLuQ=;
        b=WDTqMpfuSWJx195IUsvbvQWVTetV11kxHRXaJXeUngO5ftRpZbu38Ru7s+bAjpotMA
         SsuHZnOODcolicN9ZE0vlwSo/eAG3ZbzOJtTT1zAGBQeKwZVqa1DI+iDKlPNKsCTdOz3
         scgdyLv7hzw2hIKU+OsU2dQ32aRRPM+CqX9gWgTjErhQvJLCu0nhl9Wx+tXcAmczM0ap
         DkQmpY+oSL3BRW6WFvvbAQjH7IHdWF+k+eN3ydtWcW4B16wU/1PFxwOv0volDecwOQlG
         BrweB6Y8APgt2/jpqiTcSEzJl3vDfq5cgNIsq+tcjJTonK3bqt1c+PLppQiP34whoIPL
         GbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930521; x=1739535321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1vk9Xp7oEUk84DuTuRzAw8DRnqd3iIb00KUqFXuLuQ=;
        b=qwdeul6If6zOYw7Ro3vN0/8SIgAk47rOfQVWK+2IkWX4qbBPFXfeYDY0FH/YvOYvwg
         tYGftwHsYe4Icxtiv/fvNgSiQxyTanKSf6Qi/XNIt/mVQOPy0v/uRHEeE2+pCpCoQmvV
         Jb0LTGPWtSyiHfWyRzMlvX2b33Gb2vTaQ/6eRyUMog3ie9w1n8T+ZDqia/ovRWH35Vzr
         BDjHRWy12LcxrT9mETrxgsHOhE5mG/5sjA3oJBn76v94tQtydIsvAs7ICYMgKJiWHVnl
         LAixwfE3P7FTvBEGShLQvylr7MxA3oyhDBE2AjNWNCI8tKJkOC5rxavLWszDCD9aL1YO
         PdTw==
X-Forwarded-Encrypted: i=1; AJvYcCW1/MtXVZcGihWz4Ej2cS9/ul6rhOi6YcF0oBjID1QvgVAWodfbxxFS7Dyuz89/BCl/K5LAIGG4dRnUVzdxXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6606i6NEEvmdS5+Jno+a1dfvL6Mupvs1CfcSgiZ1ZF2Ql6dQ
	5vmqjhvLxUUuztmGFf330y57HKUnBGAgQa/kSvB+lBK4bUIgZAjZSmy1Qw==
X-Gm-Gg: ASbGnctNkhsErn9yYxSqTxYWIeObhUv40u6soJxHm/OeQkEfgqBg0Vb5NhdtmSq5an8
	MduHaNBUol1ZiIfBcDJd1/Vg5mNilIpnQuAgEsMUI8GfPSY0/v82vpyoRwPx4Wx5igKI5ttXvSW
	aphqFyhZ16iCWn2oqRbkAMdacHUZ/xruX745EIWbbjNFVHN4HBy94Fq+WFzekZzTzhTyIet6Jkz
	2u+lUCpuKb9ZyQjFFcmBBSwoCx2GIuGzY8vi9Ook/icI4AWRvQC4/Mxq6ckFX6VsiTbyLsrh5uy
	WiZE3Jhb0UVvFm2vAxwNors6eA9M1tePqg==
X-Google-Smtp-Source: AGHT+IFd3X8nCmxvTdVHSI5AyzCJNDKsm85FCH8nXcYKbP0k712HM/D7C18aiVLDI+Uq87gfWWEbjg==
X-Received: by 2002:a05:6000:1888:b0:38d:cab2:9218 with SMTP id ffacd0b85a97d-38dcab29523mr1458633f8f.15.1738930520940;
        Fri, 07 Feb 2025 04:15:20 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:19 -0800 (PST)
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
Subject: [PATCH net-next v4 02/10] tools/net/ynl: support decoding indexed arrays as enums
Date: Fri,  7 Feb 2025 12:14:59 +0000
Message-ID: <20250207121507.94221-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207121507.94221-1-donald.hunter@gmail.com>
References: <20250207121507.94221-1-donald.hunter@gmail.com>
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
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 8b39d8b1eaa8..b73e07f1f60c 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
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
2.48.1


