Return-Path: <linux-wireless+bounces-32270-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMvnCrsboWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32270-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:21:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C61B29D9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F75D3052DAB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE32010EE;
	Fri, 27 Feb 2026 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="es0TYmKJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65034DCEE
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165704; cv=none; b=XlsIc9FqNXsNsfgMgOivFcWAq79iASc7MsW8eDeChB2mqIH4lx6c28rict4oUGUFu27mVNAUZmi/cLk21f9/LGo/JMKXLCiFCMHBH5aXEGi7NH+WfY+613Tiwio1a3YU+IUU3U69nls9Nv62481X4ojYFshDZnQAJ3HbIzNfCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165704; c=relaxed/simple;
	bh=zIA+D0cfOdwllBufadNG5GljcECyt5qFPJTqx8Yj4Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+rUO2BDWldzuiCFWYrQARzAILOCXW7PMbCqm6sT48Yxn1xt/3FtrnaBIPgtLEx62OWN1Xg3XvYLqVGlg57PYpJCMIs5K0817/4mdem1CcmIpsrdA79bzxWmpEqZ2vA8hpUmhDZ0G79SQf1InSofys13H8zqSyFT3lxLWAc5PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=es0TYmKJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aad1bb5058so15310465ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165703; x=1772770503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP8qu6Q5Q/zP1mUdhVY9epA2SUWcs6MH56zDH9i6F6Q=;
        b=es0TYmKJ3b1hsD1gspJcgoLYSr50Xw2GffSZwsOPlIXMF8v0KJ8geHlq7Pw/7zTwUD
         ErwRz6bykgDPN2lVMnHYAEMYc0J3Wi31kXrAIuHCUbZ7KBnhUyOyrjwANc8vN0KEsTs/
         s5uPf3pLbiAQOLS+OZ4oSv1isXPpuIYVywZpVA66LfE6WMr7OHejBfX1CUK+5y+EA+fc
         oS/AbmY5Yr1NVGuf7m5w7OJShLeP4JgX9bfIH2iKshjXLbkMAael09ujLEcUi2GIG3Ud
         UwaUokVEdJDjhmnrYEWtUWqs0j8giGkAZX0VuxE3nt37z9xh4gmdUwiucVqUAcSz7e4e
         uTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165703; x=1772770503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QP8qu6Q5Q/zP1mUdhVY9epA2SUWcs6MH56zDH9i6F6Q=;
        b=bK0jI3sQmTl5ojbj3PqqRPCnT95CHhpF21DTYeRG9qp5/vKeQb/nveSSyJNkPOOfDn
         CykPfu4VnvoEoblbthv3WX4l0wQT99kaIlJcFoTQE52NPRQtf9msfDr1pLUVJKNKbLF1
         r08aAiW8jEDHMCzssAr1RcrBldqLUcpXz5NW5xeGpuNBwevkgnpuk+ZAJ0fd8MFjNP7r
         Ebm3gyJUslLQwK/f66jh7K0vVjPEaMBobga8a3TZ8YRWX8cwn3Rvua9UzDIcfeitG0mn
         PWgQSugsvjma0omYoEOu5IMJH7GzeMl2YtwxjfKvJMcUn8EkLlfKu2p0TllO9iUOvz2u
         dJGw==
X-Forwarded-Encrypted: i=1; AJvYcCU4gJlSDPZKMQBVxKsH4TCGf3HE8Y+aUqs3OwiJfWnwio3qykoFxZ09LF9p0ceQqjbXBoEunJ6ovcxKE6CgnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfCSD9ekH0C9y6eIj4GpsMRQVRbIDAwde7yggwZs3afLKB1mF
	yHsHwiNxF8WRrP5nu59OF60Xk+1SUEOXgA4Thy51IJlw+SQ6ChUxLwcQOCcHDjYRxK0=
X-Gm-Gg: ATEYQzyojDaDN6BzXngCcaybRdYqaqbfLFlhhc3bN1m7DU7oaIXOiDC6l0QdMPYHK7e
	Iz2hf1MgNaAENG5KfAxU52fGo+UiJUa80tHFhID06sYVECPs+TYUGwy28qeH9LT2tbehtQfpxwp
	Y/WI5zZ6aisa8qbFZp/BJ09AALhKMy8NyfkrfhWagQLqaSpuu7bXQPFYlutH5nOR78Ap+2oz45P
	s2e2IsEJ+TFOXfv2HS/TLGJYU1ekpKNNq65ldXfv5vxOMgOhTPQRjeU0aXgMKAk47vtPjYHQvyK
	b6PMOIlfgl7z2XdaI0ddeYPXeZMaHLUa+aBkMqRdn1ve2rHNR7/ihHVNSjrA+z4UOLFmpSci3yu
	FtjVoUvFD+oi/Go7S8Gnk3px4hXgIGGG6SqX8Xsh8Gzq/jyya3QeBgYim7cuzHoI0Gq0E5RBzwO
	a5e15kffqbTsBZGRk0i60cAngI2oh9U27Gya2tuqC2ypqUiMT91qA1JHoWs5wfNOPLFIFiFaNsQ
	8xkgNWlrTaYgoFlzcgWa5t2FnnOhp0=
X-Received: by 2002:a17:903:948:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2ae2e40a215mr13000525ad.21.1772165702734;
        Thu, 26 Feb 2026 20:15:02 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:15:02 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 31/35] dt-bindings: vendor-prefixes: add Morse Micro
Date: Fri, 27 Feb 2026 15:10:41 +1100
Message-ID: <20260227041108.66508-32-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,morsemicro.com:server fail,morsemicro-com.20230601.gappssmtp.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32270-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B70C61B29D9
X-Rspamd-Action: no action

Add vendor prefix for Morse Micro Pty Ltd

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..992edf0f40c2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1078,6 +1078,8 @@ patternProperties:
     description: Modtronix Engineering
   "^moortec,.*":
     description: Moortec Semiconductor Ltd.
+  "^morsemicro,.*":
+    description: Morse Micro Pty. Ltd.
   "^mosaixtech,.*":
     description: Mosaix Technologies, Inc.
   "^motorcomm,.*":
-- 
2.43.0


