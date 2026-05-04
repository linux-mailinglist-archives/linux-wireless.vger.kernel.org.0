Return-Path: <linux-wireless+bounces-35876-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA08Bw/o+Gmt2wIAu9opvQ
	(envelope-from <linux-wireless+bounces-35876-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 20:40:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A336F4C2B0B
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9933E30065CB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFBF3E5ED2;
	Mon,  4 May 2026 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBHC6DIn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DF3E6396
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920011; cv=none; b=cTZnqlW3sA7x91Z7mqPlnGIiWlWX+2+ABehHlXnHbZCkk/unc9ufGsrkZ6KianqZzGkEUPQnegwFg2xf3IKZ8AOxETYtog7QuuuPSwdERgSbi1UnVsygW4XgqTPONj6dToVqjofzGwCu5KD1L6qKO/pjoGPYvW5QSCWcZXFcDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920011; c=relaxed/simple;
	bh=VP1x5AwAX0eq4hpKhxnpIJ0wt/CJFm6/tUFZCloivA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6R8EdUDryT9oUaY3WOMUxAW/fbgYjWkJdC6UeFUvEDFJWJqP/UFXXpgsPPYgz+qUahr2iDBzOugaksyxg2jxITGmoGWafQDHClWHTRNPeQBmEBzQgZbbP34MHliL2W3HZdzoJb/B4Td95JjS1T8LYxaFjeMNxrOZ/YzVsL9nJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBHC6DIn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48374014a77so51338365e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777920008; x=1778524808; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP1x5AwAX0eq4hpKhxnpIJ0wt/CJFm6/tUFZCloivA8=;
        b=jBHC6DInLMl6gS3AwlZRXtx9Nm+4Y77iw5UlY4ldAjGg4Ushw27Dt+JSSbTbfb0a7Z
         gEU1/Boyn51LsX596gCkoBxVrVl0rgg4pdStP2oGV4JaHRqPcxgF9sdIlZMyJ+lEVOVF
         8xXOsGOnhxX3ioPtR3W5vFwGE4IjcCFgDPU7n83q5fA5RuaUykCqXLDV4qE3AWrTFD23
         JVGviYC1321eDxIB8zMsjetn5mVFVqtdWp9W3q/r9WuHZMGD3D5ZS+RolxcMeU1r6z8L
         G5usqrnrtYd34OcK4RNJuZ/jYsLPHhKdVI7ISfNZrOnnL6OD/uNxqDFRBqv0nBEaC4W9
         0cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920008; x=1778524808;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VP1x5AwAX0eq4hpKhxnpIJ0wt/CJFm6/tUFZCloivA8=;
        b=qE71f/Fix1TvEnmBecABMxri2taUx6ifpW0pzSNaNjPLSGlxijUFd0sllrOa8otdij
         Ze+RVMEmLlTKCYu3qQ9kB40B62pvdb/DEg1zhMDbj/VN2aZd4JOihW9Ax0weyZF8EIol
         Z2y1xpuM8j/OYvVsQHgxQVRqsGQ6WralEi/zhDYBGAinL/w6Nb0336IvvpVCvZhex1Ks
         qZ/WKT1My/xHrNRmJDMtIqecExhT/YdJJ5BTrjsI9q6/VAjhntfUlA2NeQWMLdI5Vw3R
         n2Xh/r7GdvyroH17Bl/BvKVyJgNX5vIFaiD+/nxwbZTC423d3kBfux1m8B7C6YTWxavm
         19Ow==
X-Forwarded-Encrypted: i=1; AFNElJ+Vuy1rYwClTi3GD7zLD0quAClOs92iadMq22Zh+z/+vBOoY93wmFIuWF2yjlQ1BKKjPn3n+ybcfOneziNvUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeeXZstboJGgkhSXnEB/cWDn+AWy6pEqIeeFyhdTHSkPQJbObQ
	GWlHRWR1V2N0MHzEYr6PfBrj3Pnc6zFBZ+MqLJ1cmPG2Xl2QYfeJtJo=
X-Gm-Gg: AeBDiesz8Dfd7f1Z55P7GQGc2e09Uhs7gHF1kI8Vt/WydK11tZV0wMjLlO0z6/4CMnc
	3DXPsHeREnFzAWdgqNY92MGm+uL4QzRHqgaVc7VT7uGGl//SVaK5N3SXB6NKIBUQK0yDmkhv0tf
	189PtFqbah3a7JTyZlhWKnL5aQdaUnCXgMXaEPERWSIdzIFMERGswsC9GsZiH75jf4Kfj+stDHj
	e9Gii9RpF4Tm3COxn+G4mXchGJFUpZyaujc724sAOCGGMi+p08JE4ZN2fh0dQXmagR86yTgewJ6
	fKWC40SuR/xuG/qasL/gjBH0UUC8U99GPjMIPpzq+SI8iexsgKKizbL4EPOZA4NysYmbnOMHHjq
	KEi/Bf2anhXL3iLImlY+E7T4s0J6TTl4is/xvlTAOPDI6jkmyOoN7JtllqlKNb9Q49mS5yIq31N
	nN
X-Received: by 2002:a05:600c:8217:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48a9852e568mr199287045e9.6.1777920008411;
        Mon, 04 May 2026 11:40:08 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d14c1f1besm1124295e9.25.2026.05.04.11.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:40:07 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Toke Hoiland-Jorgensen <toke@toke.dk>,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] wifi: ath9k: fix OOB access from firmware tx status queue ID
Date: Mon, 04 May 2026 18:40:06 -0000
Message-ID: <177792000685.1981216.17336161796486784437@gmail.com>
In-Reply-To: <177758464420.1848985.2616333328470266377.b4-ty@oss.qualcomm.com>
References: <20260415222343.1540564-1-tristmd@gmail.com>
 <177758464420.1848985.2616333328470266377.b4-ty@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A336F4C2B0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35876-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Thanks for applying, Jeff.

Would you mind adding a Reported-by tag as well? I am both the finder
and the fixer:

Reported-by: Tristan Madani <tristan@talencesecurity.com>

Best,
Tristan

