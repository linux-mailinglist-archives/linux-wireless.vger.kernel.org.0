Return-Path: <linux-wireless+bounces-18577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A66FA2A43B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C103A744B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F322616D;
	Thu,  6 Feb 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPaSffdo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2E226187;
	Thu,  6 Feb 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834038; cv=none; b=aZf+11vpQGRsg126Q9gWR9Z4SUIL5yjMR+P4SIhMZy2aeW2X2ok4PhnNoLOMqWYqIZan8gxdyWwtc/Zc9p58Fc5J3L+eWtOVWPp2xtfhq5H4Ojg2j6fKJKW5vQPrl5BjNhmwQfDn5Hb8PdY1NzVMwbNnp9aEKgrSx8o+qHJTPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834038; c=relaxed/simple;
	bh=MIEBxlmM/JehrSUbCdGYuUJVphACPYc5J2/hOlFW8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSVVXCORaiDMRxpcCiD6daU8ODIdm1gYM1Cv6yJbDgnXZZygb4ofSYfdzCx2LBNszBS+KnIp5SsNbXaNnrvPGGoRFLxlKQ9jDm5w9siE/9RWxGq9hsJRQlOvdXJ0r+5v0s+bLLxhLPuQsskvj5JM5X3NwAPQQeP1RdHac6+kIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPaSffdo; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dabb11eaaso306127f8f.0;
        Thu, 06 Feb 2025 01:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834034; x=1739438834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1vk9Xp7oEUk84DuTuRzAw8DRnqd3iIb00KUqFXuLuQ=;
        b=LPaSffdorUg+Qs656HxlJhdeqqar6z7WZY6Rn0dTYLxyh1W2X5AOLk/bM9rHx9TMBw
         /CjiXP4JCEUU4aYMsdCoZBb9FuX3nJv1osRbCGH4gEm+63eZkT4nKTp/AvRekOoO3/uc
         NUy30TrvjAbY/Yv2cuE/oDbaE6W/VF/MBleQkfhnfpRPzLXf6QYpPMJEP9FqUgyhIPpZ
         WwQgA8m11BEXcqaHgUw9Cz+PhHFjkPjKcVq2qtxp4DEDcbywWAe8ehi2lt0nwkjH7fxu
         VIIxzE+B8K/ZqSgqcsnXRneelU12NtUW2nEdLsGtEDX+d9yzHQYo/emSGaT1om9oToto
         O+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834034; x=1739438834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1vk9Xp7oEUk84DuTuRzAw8DRnqd3iIb00KUqFXuLuQ=;
        b=iF9IbXKK9Hr4O8vXV6O/2KNRX7zdskXEodc4s2vaqlM4SIUsPZmKLDCk7gVXUe+uIc
         sRlMVKFcmVs3sf7PpxnXIKz6qZuc1XO3hf2YXiED5QGcyFXCY82EzWt+MUT1NhleAk4B
         w39cRXMijZqJmsvwRAtsBCS9ZPt9Wx5ABJqGKkqPbyib83vbFF7BLVqc2q+1ku9kik9x
         k0tIB65+6upkA87JCYucxqlU76BwW3hazhK24/bZCNp/+k9WFr/c57L+msr0ZzFgrO3m
         9NFlSA/0yjCJwz8QIl3Kw3HiMgTTzSEnX93Z3G2XuzCxnEYj9yomqS/eaMxlzRt1hm+e
         1sDA==
X-Forwarded-Encrypted: i=1; AJvYcCV/pEf/1HmQJyAJlEjh6w3nktCQGHb4hsZj+PkIXNMwCiCBClUE8fT7iyz8XqEiHWHO6P9bgQFmSLxlpM3kZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mgCTqgc1e2QJpqj5by0LGE2Euy4nkhaCczzEw6LNLsMDR2p1
	bsvy+aFRz3xoBDr7IMmWiD1BgZdlFT533SQcPK8G0QMS0ZTWIYoZLDcB1g==
X-Gm-Gg: ASbGncsUoTksKQOD6DSKxn0OAQ+pUzfysd+UB0YuXw/L+7h4jyGSaeir8zE+dSJKTzk
	hcMT1WQKXIZ8Lp1/yg+yU7PmYIY67aeHFlqP/3IhhtVT5GmFUGLVRegXsTdtQb4pMQ/AkbOb4uT
	EUWg2QL1kh2nL78OBnPjSsTEUXfPq3vfRAmSWztpUxhPrU/7sCyWLi0I7iQ2oCtlVYuNc6ka6NO
	Jy7VWU5EcNyxsQ/yBotABW3KyeBa1cxajhNMHCVW3vURjfLdE4L5RgVGIEBtXyym9MRt3GRgJUD
	8tlWL2V7UIDohy73zt4RB3QkHOsermj5OA==
X-Google-Smtp-Source: AGHT+IEVnvjK7wZFL1PKzBZVNeJCKllRpJAMMNZ3nV752+filVyzoxF59KUh7RPhMwKxRwW9pM0K7Q==
X-Received: by 2002:adf:f810:0:b0:38d:b1ea:506a with SMTP id ffacd0b85a97d-38db488dea7mr4286616f8f.28.1738834034420;
        Thu, 06 Feb 2025 01:27:14 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:13 -0800 (PST)
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
Subject: [PATCH net-next v3 02/10] tools/net/ynl: support decoding indexed arrays as enums
Date: Thu,  6 Feb 2025 09:26:50 +0000
Message-ID: <20250206092658.1383-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206092658.1383-1-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
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


