Return-Path: <linux-wireless+bounces-18760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA30A30B00
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC03A166088
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFEE1FDE08;
	Tue, 11 Feb 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7UzVs9C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519851FC7D8;
	Tue, 11 Feb 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275306; cv=none; b=C2DZFSqFykc6QUC4QDuOPkWyM6fh3lKbBPA+Pm88nbTeQdF8Y5K6djLzjZTyA3B8pOTt2Sjf2lQQHpiCyIzBIEcxRpdwhKQpfGD6Nt47fw2yXDZKbiSmwmQdpWBveNp4PCAoQaIUmeH7aESdZu5pEHBExXodv90giEa0zs86zgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275306; c=relaxed/simple;
	bh=MIEBxlmM/JehrSUbCdGYuUJVphACPYc5J2/hOlFW8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJB1zf47h+IDDn5j7o48CR7qO6x9NEMBUPoR178b0iQWrnZryP8lJlHBvrZ5lZYiIjvmbCXeQz+CPxbdfUrDlO6kJn/O/JKiCNIjd7p9TB3I2HNaScEc9AgSrzAbZiIRo5DKQYSi6STmz93cD9/LD2FnV0wIyo2Y5VPa8eZ701I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7UzVs9C; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38ddc36b81dso1538527f8f.1;
        Tue, 11 Feb 2025 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275302; x=1739880102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1vk9Xp7oEUk84DuTuRzAw8DRnqd3iIb00KUqFXuLuQ=;
        b=b7UzVs9CC0h2XflcXseq3OSOF3joSDOOs8xnWqygQmmMmOc8bIfz6TabvGAgkeEQIZ
         8XqheRs3e+jNJryjtNCiMGv4nR8AplpKE514yMiILzut/M6ZleHz610rqMxs/bEYO5gT
         N1L8qLFML8u43S9Eo5O4rz2KVc00zq/SSUPB74mm/pcoqSTn6FsFdotpIKqPRQAdn9Bt
         6pxpyhQX0Oxnn0dDiCHwFLI7aIO+NP/DSvIdmjySWvlAIZhBvWIy9XRlM6+TOJ+QiYPS
         kYqlrFeUZxi6R7NU/tiQYGn6m6bfjz6Hb7gxNOLAo8bhFqyyHr23GMh/sBfrC7tR5RKI
         +pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275302; x=1739880102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1vk9Xp7oEUk84DuTuRzAw8DRnqd3iIb00KUqFXuLuQ=;
        b=LPlNLIB+m8DN3Ryx8Q4tHCyOWDaVl07oMTu1MnMvQ6FvGJAWvCC69hggNiPaTqZA4Q
         +qZLyGWKhTEUgINvS0ETn1vBNRHkax5MSyGrIMAHVNNr6wlnHuWprx/bX1Evy/hAc26n
         ZrQ8BkPAKPR+R6qozhU9RIheETsda/0JHQzLWeMffBkNh0PSoiBwg99e+ALkKvNn6JrD
         q/Jrq5606r5Y8rvT4jkU0GwD4Ugd1w1bhSJ6BpfWr8NnEvKiXZQfSNmY4iQGgy9/ZgZs
         iuTATpSSYuA/8I2ToK2f9B0lSz2W311BWWxbUbBcTG9MixVGKBiS1q2UfH2EKPZZB8yt
         uKyw==
X-Forwarded-Encrypted: i=1; AJvYcCUA2NmQgipcheTQCVCOz9BVY2XEuO5/4BZXUMn0ZahGvRJMcwyZJ+daJjtfprIEjjFWPBcECqJKmXgLBcfiXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhzzvAWu3CFMtHpOBo6zIr84CZoxSrdsUHiCWUSpQHu1fUAXK
	S/W9Wqfey/5no90fIYPhj4SneXLMh/8Ig1yeGDTCPmwZ3MVD9qIyOO/ohQ==
X-Gm-Gg: ASbGnctStyAP1pwnotMkuYolhvIm4rvPMh3h0I6fZHfgHA0YRj94pRonjmT76l9kOPX
	+cWREVYpt9zsZACiy/MLF3XUIrZ6vTUmiD3zQKUamHQrlcyzNPSsAULn1trM3pIEas++E9QJqml
	uGYioghUrK0MG7Z9TdVn83/mJfNJlAWBFqAdtUcbdZ+pwgI388+lNbi7Rpi25J5mDes1f8de14/
	8td/71L09LuOE5KDdDsagj65q83ZWPMQZMu5/byKaQzkoUH1jrhCxyO18czVSVnlL22GFRdfFGh
	KzMWtae0+Dn4bRbPDE4TdcfhAYtAyEpl+g==
X-Google-Smtp-Source: AGHT+IFB8cpnkDjjl3jOAGmdmTyeh9BTEj6B0xy/hVWXsrpCvIxsZRgcOFilil7WV45A5iWxqhA+DA==
X-Received: by 2002:a5d:64a9:0:b0:38d:d8c0:1fa1 with SMTP id ffacd0b85a97d-38de43c6f6bmr2504479f8f.18.1739275302018;
        Tue, 11 Feb 2025 04:01:42 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:41 -0800 (PST)
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
Subject: [PATCH net-next v5 02/10] tools/net/ynl: support decoding indexed arrays as enums
Date: Tue, 11 Feb 2025 12:01:19 +0000
Message-ID: <20250211120127.84858-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211120127.84858-1-donald.hunter@gmail.com>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
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


