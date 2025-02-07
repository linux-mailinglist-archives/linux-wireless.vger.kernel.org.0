Return-Path: <linux-wireless+bounces-18627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF88A2C25F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA8716B1C3
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761271F5615;
	Fri,  7 Feb 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9dxCTo0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E77FD;
	Fri,  7 Feb 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930533; cv=none; b=CviRxVN0nPS5W32X9Ty6Mw3E0UUS8nNsZ0NV/Owa9IVISmJvwRBq9wwC/GWQx/y1FeVDj/BdAe/VBgQWLbQhU++eLGNnvvw6+wjMz/Q0krk6Fckx61KNK1CgG5geYX2ca9CWrphJG7pttahGh2n8VgCTrdqW3H1aKNqUx/XFNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930533; c=relaxed/simple;
	bh=Ap1q4LgkrLbGyYRLWcKtA1t6kyY/N7ouDJbyAdy3y1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IISKxVEtZsUoFb2lxwhhheaZsxQEYZlJ9S4xr8kcubNTcbVT/RopdKJyvVDUD7dy46ZvcxFirFj1kOQmCP3+Xhv4idq0XU1usdm/eRuCqffslh34vkfMIKUAtuR5cojB3ujTm86jgO1CDFiE9P9cb6UttZ0hCBNsXnjCh5m3pgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9dxCTo0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43624b2d453so23228575e9.2;
        Fri, 07 Feb 2025 04:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930529; x=1739535329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N9nv58w02wJpkfqRyDXBfeCG5CiiQvz6kgd+N3dJY8=;
        b=Z9dxCTo09A5iFXdOFJX21o3zTmNfUnFPlTRgHvbl1ifkEcBId4lfmQv6IuNrV0fKEr
         /gdwiysWu2F6lm1dSEh/kHcaoAKAU3E2or/uxzE3br7dbtw0yW6GKTos5VVj+BFrZjO3
         bMEoggCJbdyv9I5iflpCPwUw0+BJj9wEBErPekK/4SYQvK9vlSX7tZS5RnHnJcal4vn8
         Lbb6aTbPPG3gVDhEdv8ydFdF7RRXdDS29Oxh4Z+ud682OT9/Ger9wtb6AC3J7e5vZJZa
         ZA+LixL/QgQ0SEduLfOmdnjuguqXvBgRCrqmNYqC7WROhMko4ik8/4fjw8U2qhFBcGAA
         RuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930529; x=1739535329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N9nv58w02wJpkfqRyDXBfeCG5CiiQvz6kgd+N3dJY8=;
        b=TpKzjk9YclDS50MBSATQOCjPDu1lkG/3XALHC70NjVJdm2zDpN0a6XpIMkjbBQ+uJ0
         8aVEWgMoTy/q3VtY4gCug6iqba6y7UUfqYRMrBnazKcgGxWCz64uLRVQnQsmvV4uOzqF
         kqFg8BW7Tt7j4rXVa0jXfIBTH3Ll2E76m2/Wr3ckzex8evufudmj5hT+8M0OlO3J0mMi
         6nGp+uodOaKgCKcRClYLk7JF0fFc1ISD69ZSAZ1cypZ05IZD49OBg+HclTq5Beir4AZH
         8iJ4iz+Q/t9h+cU1o5fU5EbzR3UllRSv3SAOFYQhV75Vd3dlnoTgYh7DgGE7I41NpUAJ
         /Lfg==
X-Forwarded-Encrypted: i=1; AJvYcCVRHRgh3WQ9PUZM8CCwvJWxGD/Jvlzjv4/6Pp5cpDEDgndUfbllLqy1v00iOyyEysKBOaTikYicKqLxMCjylQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PZwDr3MFWQaszf6esj0j2xY6C9lBCf8EFKD5r7OHJwDrt1K8
	RLUKW1tLjGb/Ye3cmPkXfk0Ghcfz2NFqLOmoEjXZviOHbJZMTjQ6Qwj0tw==
X-Gm-Gg: ASbGnct5sh6GBxp+CcImxqMg44US4ncEDR5EhXAoA0kIMYy7n7dL9INGl+5OsjowQ+O
	1EICCBTECvUK9zS498E9y0OX12DzgIAzrDajZlwm7+AcHjVrEVCKUSODDgDl3RZ8TzA7w8w5Utz
	9myoA4Z3J/PnKvZ/6u670tJnRQBZbyoVcZmpuASliMTZ6RV5rSejUF0xzVxp3ZfpLZRj1ZG22wJ
	ixPQPrt0BOQfN0vzN2uXGD1o34ycIcIVmSdwun+dgY4+R9uWm7otN1jOHILAuf59u/kYasjbHDF
	HeVjhThTz6fCvxoA+IueZ+JCEEnRi1bAIQ==
X-Google-Smtp-Source: AGHT+IF5ggEi+CnbvVSump+njtajj7Rg0JO/out533uPn5e88Q4sy0dM3pLdVxTi7L9e9pM3i25adA==
X-Received: by 2002:a05:600c:3503:b0:434:f817:4492 with SMTP id 5b1f17b1804b1-439249cddf9mr31080615e9.31.1738930529363;
        Fri, 07 Feb 2025 04:15:29 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:28 -0800 (PST)
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
Subject: [PATCH net-next v4 08/10] netlink: specs: support nested structs in genetlink legacy
Date: Fri,  7 Feb 2025 12:15:05 +0000
Message-ID: <20250207121507.94221-9-donald.hunter@gmail.com>
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

Nested structs are already supported in netlink-raw. Add the same
capability to the genetlink legacy schema.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index ed64acf1bef7..c02ed8089746 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -152,6 +152,9 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+              struct:
+                description: Name of the nested struct type.
+                type: string
         # End genetlink-legacy
 
   attribute-sets:
-- 
2.48.1


