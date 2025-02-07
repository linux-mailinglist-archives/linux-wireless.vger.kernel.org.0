Return-Path: <linux-wireless+bounces-18624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57091A2C258
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0CB16AF2F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE381E5B97;
	Fri,  7 Feb 2025 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMFJavz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599931EDA39;
	Fri,  7 Feb 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930529; cv=none; b=k+oCwsquFiTPGbdHImwuErgx/L0Adh3Bi0opIyCQfjs99XVVqXFLjHZAxF1aUV2IOfHMi9PFwmSl4fGm19FAfSbacGvfrqXzocHIOwhRKoJ67FA4WiHf9gchR7ITJHpElyfc79OI0K5/V0fuRIqjORZ9hY0kM5Zkh0QB7rg42Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930529; c=relaxed/simple;
	bh=X9eINYij1abDhQD4o22GKAwE4z5ZgnCtWo5oJ7CpFNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+EPwjC1GAvHDjpQcVkqzhisPkwVGyFvpkabLp+MgvcU99VsCkkOh9Iw/Aea1qJG6Fhrmi7lZ5jeMiIHI2CYbY6lZ6SNW4m99B/HLW9+bm3qneIzcN3YkWOtaP/S0cuu1Oz+71fZY+vQ/QhR625Nhto2zo4f27yFAnQ5NpqcTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMFJavz2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43634b570c1so13721895e9.0;
        Fri, 07 Feb 2025 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930525; x=1739535325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK4EKx0QpFzSPEovyIzsmnHNxkclruHqA9dDekWIaVg=;
        b=FMFJavz2kaZD8BmbAHqWvOiOAjqcFdfaiWESpfLQ2jW3IoH1G9EBXqLb4cIOOSYh5a
         g7XprQsPiEk5pzHvCS3Ql2QFp9t/Q0aUUc36usBN5Y3vbQfhTFVZ5crw3cFKi2cCcNJN
         NnliuySzbav/6nwFS1xSL3xbhAjhsXCTqKE32i6B/gEiYTzHGOKeUm7iolkpeoI615V6
         Icc73jooJAxXbPRI8lUvN8kxvL347UezXrT2gVq1oVftX2PewnTB/KrWzJOHuxspWJoO
         r8AcKf4OIO9jVhuYmm2b24c1SCMbJPd+q1Bcqm/QyaAIlL45hkCG9825wLnTouaasFnV
         lqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930525; x=1739535325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vK4EKx0QpFzSPEovyIzsmnHNxkclruHqA9dDekWIaVg=;
        b=t87F4mR97oRLdQf7dcoYLqFOj/Xe/g6unGIdYf+XmS4yJq5caNdVErsjAJ+HcB9xvl
         le1n0nfDW4tY6oGRcUPLNBJpwTww2BkhK3n8sD1zhhuC8JlvsetiklYSDkrMol4S0hjJ
         zONUK6Kzq93B9nYRA00ORZ5fadhk4n+RbsE9d8NsfMYBxWesXM4D1IzoKnLV/tfLPCp7
         DGcmT6BTHMLnfBsdQYC7b9Ed0rD+VO/5vrkbBWE1l7sI4otBClSy/LO2arfOIuWhipMe
         ERKen43WptClfZkD9F4EYeIcAFnOXo4NEew+kxSLB3OKT4NmwmMhAgWZjtI00bhXopcE
         mTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7v95qJGYQt6clkjkB6f1axxNmJqaw/LBVZi/rEPs7Va1/Ir41sOENXkVn4dkQr0DUtK9B6JvFRC3l87H5mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZuJu5FHtqE7ozygZLui6uxGLgUIzJZLo09DaD7NP0e+x6mED
	cdXT6iXPlHR2h9HF2aeGT/08TT/MeZtoA7h1OuFCV5e56/W8v9FGaYWoew==
X-Gm-Gg: ASbGncuyERRdDdrnzZQUvEpRm4fWGbDFjnYUZf8Z6BBa/v1MInLk17GUnu71awNS7Wr
	olDyq+pO/6roFNWvulurXxGh+Du8I4fTL7TQ4gKdkPGK5se8rZYm7b6Qj+LbmRBENHZR3Ksj2x2
	eJWIGXZSij7NCBjSrIKBuO7lybEVhN193ckiO4QaIhZP06TZE8X3nTH2rg0MRJjgVlJjobMLVYR
	YCDB5NJQ4gsW/Agl/tNdcMD28ngzxIChFKeTLoHQBkXGHOSIKuLIoRc3lmNn1ZfW3QPp+0cjHHJ
	KtdHekt1/2YYDjXggXNMaG0RQ3rO/kp98Q==
X-Google-Smtp-Source: AGHT+IHW6MnJXojVP2W+xl19WFEGAzpupueF2gSXgd/PwMiuauNmAKMwZbuNPp+6UL2ULwcfUdCkvg==
X-Received: by 2002:a05:600c:511f:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-439249a8b13mr22912785e9.20.1738930525253;
        Fri, 07 Feb 2025 04:15:25 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:24 -0800 (PST)
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
Subject: [PATCH net-next v4 05/10] tools/net/ynl: add s8, s16 to valid scalars in ynl-gen-c
Date: Fri,  7 Feb 2025 12:15:02 +0000
Message-ID: <20250207121507.94221-6-donald.hunter@gmail.com>
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

Add the missing s8 and s16 scalar types to the list of recognised
scalars in ynl-gen-c.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b22082fd660e..d8fdee24ce25 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1440,7 +1440,7 @@ class CodeWriter:
         self._ifdef_block = config_option
 
 
-scalars = {'u8', 'u16', 'u32', 'u64', 's32', 's64', 'uint', 'sint'}
+scalars = {'u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64', 'uint', 'sint'}
 
 direction_to_suffix = {
     'reply': '_rsp',
-- 
2.48.1


