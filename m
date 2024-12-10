Return-Path: <linux-wireless+bounces-16170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCD09EB5CF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B341D281032
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5194233150;
	Tue, 10 Dec 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzb1Xs2H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7EE1FD791;
	Tue, 10 Dec 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847303; cv=none; b=KaRUaX7nUUwXFSKk4qOGNOOEqughd4zdyEqEr1q3r0UZ+SkbgaTXDrG+CGaGdN1tYRvSHXdc2HVpJLnytjlada5pGtJez1IxV94td89qI8UYHmXmtCzXkBfo0SeFz+e0Z6XIFG7iIV07kcX3Nh8UZrocU/0juu764kjDJwyEHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847303; c=relaxed/simple;
	bh=Va3nsLmUl2P+rfyolzkwe9gtnla6bGra5Fmnc9s9mr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/hnR9TNU+Rdi1dc0WbSratml8ULNGFbCXxZf9nLWQ9nMFLgI++Ff7ei2Atkrf/oIea9N3oC5aePokXglzCQ7vPPS4hWI4/T9I+Kq63CVcTMqoO9c5PjCUEMxmFEdwpbosKXK68kLzEuc+yBiZlEIHH7TNGSL+plCyyjZVrh/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kzb1Xs2H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso1748305e9.0;
        Tue, 10 Dec 2024 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847300; x=1734452100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UheW5bGpPD5LwKX8nwzQTUxDQM96C2pEIHtc6nLg4Ng=;
        b=Kzb1Xs2HHRigemuBrhhjHt2y99giGzTTBsu/zOp/yCZ0yJBR/k1oeK/Ef+yMfYE6d5
         e62cDONqDttR0r3LbS0VowCLftXCEZ5PZKm9MXP2qtgMdcj4KuuTCiz7MtIgsei/cUmy
         cUb/29QMKQ4mj9FxRVPjuIRAkx0LkG2ZGePqkETDkP53TzJe1G4wpssE9Fw9YqcTJra6
         2avuyNHuIveaBy7QHA2UP7kaXWJlFcpzldsgtyXKNZ2XUEavwLu6zQnUAt9qAp9NcGEF
         hsx16mAWtvluqkrG8lht4bwfsxpgGMp6kgQxGgBeyWke/QXZUwtLDtD9Tq9GPT2bAvbw
         Xnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847300; x=1734452100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UheW5bGpPD5LwKX8nwzQTUxDQM96C2pEIHtc6nLg4Ng=;
        b=k+mJo8vks32vQmifMNrOjphWZGK+sW8btO9wnI0uIb5lgBbe6gSGRx2s29EHh31HcQ
         VbJX2/ra2W7Kbtlj2by5U23uNnGyCV8+syexRofSe5oWbTwjgorVUASyIgfcPNMpIxrT
         YZ8kBPrclaG0Y7Xyyg0PLrzq3yft43bIM7UDjB+4n3ePlweK1MxLO3ercBN+oS3Zulv0
         emWReeY2mjU+IyV+ltzim3QxyQCnqbdxWR3WaAVAO5sEIEB1dzXuZALd3eQdCrX9Qp5E
         /QC7NgmBzzXuF+3IFycZsMf4+H3t1MrhS4vJijK46aZqwRHGtA267esLaXpMYzdcGlIV
         /Zmw==
X-Forwarded-Encrypted: i=1; AJvYcCW5gO/PFDFWWP6oPEB8MtOW7N5xft73XtbWdk/JW9xUUKxsjqhmAQYdtzBXYqhVsw4PpWsft0H5hfZa8lEBNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXgvJ9q3XtS30rjVlgF6V6FM1BWOnbJ4Czhk8KEcIThW5xqsu
	2veA8axc97N4uReWwBfV/eXqW3W5ZcXtF5tMVBxb6N3oDKGrkRYK3drBMQ==
X-Gm-Gg: ASbGncu/wcoGXwGCJ9IzVXqqkawJmq7NiX2bRRy0tieFy9ohAo0uXW9M1SpGeB+lqIO
	2cnDDyIWrmsKN7+J8O0FW4EWyAD0g3I9WEjPu1s80SItapvDi1lpHEw/V524QUmi47Z6iPfbOjY
	MiRPOWCL+UeuT9PiK+GHJxby6b17qnC5X5OyfDhsN6yU16d4YerTC3eGhXwFs0HI/9isvFC65xb
	xr/D8uZOGi4sx6mksZeuw0Tc8oKMHRmD1WCDx7TaRXA/q4Ry8osbN/cllNNv61HQ1U8yoWS
X-Google-Smtp-Source: AGHT+IFuNL26PchbijBb1B5gEkQZE6B1k3FRETLVS9dcHM2Zyy+TYFVoXST5jWZm/NO+RlaouPB+SQ==
X-Received: by 2002:a05:600c:4712:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-434e29f0392mr122500705e9.5.1733847299474;
        Tue, 10 Dec 2024 08:14:59 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:14:58 -0800 (PST)
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
Subject: [PATCH net-next v2 2/7] tools/net/ynl: support decoding indexed arrays as enums
Date: Tue, 10 Dec 2024 16:14:43 +0000
Message-ID: <20241210161448.76799-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241210161448.76799-1-donald.hunter@gmail.com>
References: <20241210161448.76799-1-donald.hunter@gmail.com>
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


