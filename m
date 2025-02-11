Return-Path: <linux-wireless+bounces-18763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B8A30B06
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6E6166560
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F74214811;
	Tue, 11 Feb 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKOO4ioG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A01FAC3B;
	Tue, 11 Feb 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275309; cv=none; b=i7fVmCAm34685F/+IQ3nbjsYf2Idunn03DJytXjTKZZdHeKXIUAbz0SYxG+iUj5FO50eZaxX6ixr8NIsBIOMAE/1yexyoSwlK2yxNJ9kQi2CkIPxQSyEoFJoFfOgcGdbkJ5hjkdXNyb4yPkfJ7HmeWPCu3tWSYDSValAYhfA1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275309; c=relaxed/simple;
	bh=X9eINYij1abDhQD4o22GKAwE4z5ZgnCtWo5oJ7CpFNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLlH/vfdSy6+7fZyrfKEUnjj+maBebRVosZd3yMriStrCUxfCHd79LG5fDaZH8RTgJ3SxFKifFJkFYwVuq6cPk3JNAzbqcvKMqqtISslcSOVSZdZqQ4LZZNoXMm7TEJCVOnv/YEwQHYJX4g+bRUJX+7iJtovzHMe2g9G+azpIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKOO4ioG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so15431795e9.0;
        Tue, 11 Feb 2025 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275305; x=1739880105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK4EKx0QpFzSPEovyIzsmnHNxkclruHqA9dDekWIaVg=;
        b=BKOO4ioGzyvt87z9XjhdPWF5DvJTmfWbvOO6BifuC/5494UJ7yyxwfD5+Reo2GGlNO
         VFD4DJcffw8KDh0/fFdTdR95FBvSbX4ebbkHUCbEaNWMKbhIe8QZTUaDHLDydaOrF9N1
         8/as6rRzLo3GJAg4f5R+kf1jafQuaV6w8bPH7XNv/A+6qrA72cIh+sRHpBqDUZX4Pifu
         sGk4sYDfl09y3pithTnqZedY2aqvY+hk69ubclWDapqbHUKlr+2c57TfjsTntCCw1Llq
         vg2FZmqspqaE3WI5rvaoHLYtrd7GsAk6QAw2xxs/IfLMpy2/kCqjHyv3RGGGw4/QnJe1
         3UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275305; x=1739880105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vK4EKx0QpFzSPEovyIzsmnHNxkclruHqA9dDekWIaVg=;
        b=t5H3umaMVd75YdmPcX9h6G4jpVvfuaT+x0io5mWnhKcnZM/LfBefZSN8IIw9gqvIkV
         A6ldEADhNf0Sen+zr7lbKZ241CXk7UVr393guPXz5rGqLeNUlfWAlp/hYLjKdlAsQjsr
         VU3Dfd5njbu77FSKqBTooP+s1BNPc0+ZjTENTXgqPN44sAx9uBzHR3ouD0APEylVwHOc
         cK98T1KWU+Mynr6mPMh61B+NiIXybx0L6tHrvCYs1Xqz+G9Umio44VUc6mSeXrLcM/RU
         eyCUQEZjk6soKAroboJVvTwaWq38e7DfRn+IoYGrWzAJDXgjAlatWp3PF6MpdplR5zdO
         WHhA==
X-Forwarded-Encrypted: i=1; AJvYcCV08+YG1z/pPwrcMPWtdmh0Ej95l9c/yGj7rSCM7JbqNdSPqcgB2/J4iHBE7jabXy0HZep7uW5e/fpVdHbPAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkH3XGoV4Y8Y3lw3jLe8iZNz6W8quaCsFuD4gu8iNiyRfdXdg
	ves//O0zD+eSNO6ODIEIx4CUBs4RDcZaggMg6zXez5gXqo4SettF04adHw==
X-Gm-Gg: ASbGncssPUcxVc/ixv23PiRdzDLNEH0TEh2PFI0RqsncTs5i+sEhaqEJr+KBLlo5Iiq
	WdgSWeDK/SvaRHjHIaCwJwGW3kVyVa9DfJv0QpkUcSx0/dXv0S0uonW6/2kKDer4YAC8milQubS
	mxW9TN5+OWSjJwYIgv91ymJey6m+hUtQcWTntj6VX/Gp7CBJu8a3UzhQV+JizULSu05k9eK13LR
	vymPUzXVSJo1bLIqeUiKEvuUN/ThjIwzQB2REMsVv5oH69JVMqhhJMCMPXEQnnvx0sVZHn8LMz4
	26v+IXdGKmA+JHw7G5pa4s/DvXHzq00y3Q==
X-Google-Smtp-Source: AGHT+IGs8lV7qlxTvOWv7qiI4peYrnEgyMDaAYVrmBbNIP1y2YGvlGBA1jLheec5QHZSHTjEvHCJ0w==
X-Received: by 2002:a05:600c:450b:b0:439:4a9d:aecf with SMTP id 5b1f17b1804b1-4394a9db33bmr40246325e9.25.1739275305393;
        Tue, 11 Feb 2025 04:01:45 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:44 -0800 (PST)
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
Subject: [PATCH net-next v5 05/10] tools/net/ynl: add s8, s16 to valid scalars in ynl-gen-c
Date: Tue, 11 Feb 2025 12:01:22 +0000
Message-ID: <20250211120127.84858-6-donald.hunter@gmail.com>
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


