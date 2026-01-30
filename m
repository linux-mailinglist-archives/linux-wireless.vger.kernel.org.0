Return-Path: <linux-wireless+bounces-31350-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCnUBCk+fGkxLgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31350-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 06:14:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B3B73C5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 06:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672DF302BDCA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 05:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C662F0C45;
	Fri, 30 Jan 2026 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="HQkSyN02"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5F329C6D
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749910; cv=none; b=nYYlU/a90vioWiGhkp2ZgR+0RSzD4BPK2aoNwPq9o8IH4Mmz1ZKf7M44UIjJKK9Ac9Ygs7qHBGQJ8QUwm4mZC75xKA1AndBcQn9ch/7yamtxjctVM8xjEqxMyMPhsSS3WhoEwcktAYU8lY3LQO30ig1Ou0wBEPW23PiJZVJBeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749910; c=relaxed/simple;
	bh=JVw1mA3heauJ+Hx1KAUZYa082rsehFgBMKMDur02Pak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c4TMaiGbi696mBsGvzSghURBomsD7jHYMNKQA1zJ8NeBw4WUJidQ3/h4ctDqgkZy3uOi2iDqefpmUNZjyWTwWPzELAvRc7Rh08YvPY4oYP+CYhOYJTYsEb4Aa1xdwJCuj/DJRSaaN9vBgUfGj4GSkHByMtgn7zaEmkhJlfESa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=HQkSyN02; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3530715386cso1134707a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 21:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1769749908; x=1770354708; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqB7Ct/TfkgUyj66ml98s4FlfglvXgzgwPPwSU0a6VQ=;
        b=HQkSyN02sDDDi2+Ct0uDz4RtBQ0Dc/YRUnWcV++/cGBmK1B8YgNk0qSvQPvPTIhtBj
         0jPYcOfcr9CuKlmnOZZu7Y5fEkG+BI/jxWu7B0jp8Somum7N/rIS0gGLJvIvp0HWLGXk
         kHSry0m3iPl+m0W61dS7xHTp/CdZuxwAUAVRbqx4eQ9WGpK39ZKtptv/LPjfS0zjV8AY
         WJOMhWf0rJQT11WoOr9ZBhy3kLFHrncINHAjDP33qJdZAuFLmHOOHCH+thcGi0uTV/6s
         wtEP7kGh7RRqaRCrZ33ZHt3C/b6ADlcJYVFmwbmLOhx8Peh2/Hf0+jTEjBiADR9Ub5H+
         ED0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769749908; x=1770354708;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqB7Ct/TfkgUyj66ml98s4FlfglvXgzgwPPwSU0a6VQ=;
        b=vhjGDuq5S7akwJ0LIDidLTMelwDV2s2IXEaHntR+GJOSV+/AhB79DYD9VIBM4Ry/Cz
         7d9jxx8zIOym6S8M+ga7+8ZdwLdN/gGIlApNC19l0hs4jt54mBisYVaqo2bCaeWidrKd
         jt0Ng+z1IZPO5eaYWI5tlJS2XmGHmzEfDeCIxV1DugOUSX4b1cASGZvEcNCBbkRUY7HV
         +eSrNMQOBwzxkaxJs1zVxWQAI/M/N/WzPElGz8ivpQ1fKF0+OJh5XHXGcg89C1r9MJry
         aNX5q8rU/2J2vPLxH+FyKjh7EqG70lySD6Z08u3H8A9NoUC1RsZP5xetUUFlwe2MZFFI
         PN5g==
X-Gm-Message-State: AOJu0YzrOPuCbHJ8hkEV5Vj0cLHfom5eyoenqddLPTZJwgKkgP1xRgeZ
	8GcVg/XTqQPv06u9DBfKnTJMU3yMojZJW8CGULII7AjKPC/3Uh+ezHSSQBSLveVIj/ZRpxyZFRE
	aC1Fq
X-Gm-Gg: AZuq6aIjePnLyTDl13AFBFS2bJEsRlSykqFU2YXO5bvX5zYkZSW05so0cgjPQaWHFoR
	XMJsR7Hi6ZF9mSKG1lFaR8WpZzIUAP7V2MG6XMTUC4ertxzSFTnhniHuW4nhFypYGho4/P5YIV8
	r+RC5ibqYvr3/acSFyBA+tmTeETMl0Nk4Qdd754AYl6ahnEci2aP5mJW7LBS58jQW4Zj3Zz5pKe
	RR16QSkwuvP3ZEaeyE68cCyHLdPEoDxeGifZWq6YkAdD6L8kKs6QT7gRFwEjiNK9NPMmOFSTGq2
	W7o3+AZPcm2evwM5oxzTT7O9LNa4IodSTpjaAZUvdguBUieDnMamaJbdo2iWA420jCM1Gxk3Bee
	PTpzx9tOximEchE1zROn3n5L3rN+RpoLtRVrr3KQQBLiYMNlpDYijCDrRxLN+ZItX2WwqWHj04n
	wbyOVOEV+5eBwxDku8LsQNSQbAw9wyvEGxRDaL7MPOh4XSPWrx/J674szr4OnRJctvBwj66TJ3i
	SlAfaDJGWI=
X-Received: by 2002:a17:90b:4a4e:b0:34a:b1ea:6648 with SMTP id 98e67ed59e1d1-3543b2df76emr1689867a91.2.1769749908180;
        Thu, 29 Jan 2026 21:11:48 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6102679sm9725131a91.3.2026.01.29.21.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 21:11:47 -0800 (PST)
Date: Fri, 30 Jan 2026 16:11:45 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: linux-wireless@vger.kernel.org
Cc: arien.judge@morsemicro.com
Subject: [INQUIRY] wireless driver kernel-doc format
Message-ID: <dknc7nkkzfmbrhnfjhnmtz7tbacydiluzcbvtkrk65ml6u3mqj@3sjdk3gx7run>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31350-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B8B3B73C5
X-Rspamd-Action: no action

Hi,

I am wondering what the modern consensus is on kernel doc formatting
when it comes to multi line definitions. Take the following example from
the kernel doc documentation [1]:

/**
 * struct struct_name - Brief description.
 * @member1: Description of member1.
 * @member2: Description of member2.
 *           One can provide multiple line descriptions
 *           for members.
 *
 * Description of the structure.
 */

where the each subsequent line for @member2 is indented until the start of
the first line. However I know mac80211, cfg80211 and some drivers use
the following:

/**
 * struct struct_name - Brief description.
 * @member1: Description of member1.
 * @member2: Description of member2.
 *      One can provide multiple line descriptions
 *      for members.
 *
 * Description of the structure.
 */

where each subsequent line is indented by a single tab. This is my preferred
method but the docs say otherwise and there appears to be a general mix in
drivers so I am wondering is there any expectation on style for new drivers?
Or are either OK? Thanks in advance.

lachlan

[1] https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation

