Return-Path: <linux-wireless+bounces-31609-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAGtBHQehWla8gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31609-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 23:49:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0D0F835C
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 23:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF36730498DA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184A33A712;
	Thu,  5 Feb 2026 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTPVYgO3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0133065C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331694; cv=pass; b=ZVbpJjOejVFU2M7M03cLlIxy6O00IOhZVEcu3sdy8i1HXereKIdfGS6plPaHrwbi0pFQCrawGCTHX0POIhQTAq3o/PopeG8vwmK+VjT2nkbAqG80PX7H4aNBPnlkfGB2U1CXK0YmYXemx+QhZ2oU4ep4kSXlgTzOeskBzASRAnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331694; c=relaxed/simple;
	bh=yhjBhVUq/JtHVeGH7sBlCcMZ4AP8+/yjN6oOKRTIC/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jS8vNFM42zs/QIN2+QI5LxDv+SkrEqzog5wcWU1Skt9mMjkgkIWr4QCenvEW22mUvfqRouvLqCp7VRogDwBfbbAf7yNYTpAzoA1z8e1qZVWczt5O/RKI6U1mkCfy+zoOa06JsL528FNOpqait9bLbZMfQyawQXyOio9CfRYC/Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTPVYgO3; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-658323d1c91so197331a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 14:48:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770331693; cv=none;
        d=google.com; s=arc-20240605;
        b=NXM93WTSXfX0TC9xJUhHUXauAtBKPRCoGu5PpJvgCCKmQ1bwDxClZqv1nyPtymsChh
         evHFzhjxXDvKpre9fNWnA7Re1X7cBeSfa/fgbt+1nZjw1NQjwLDcfgB6uiBKgPvLcybl
         UM/0x8y47ul3oMkqGY+Li2I2VrAJH4Sj9fNP6r6+XcELbXYTZXCLX1hA3bc78X1TWIgE
         +hVXqZlM2rfxpPoxZg/sook6P7tFcPWVhCcTB9iUSGiNVps9uTZaeIkO988sAIyjS2zP
         08sqXKkQOPd0wFvf7i/I9P+O7AOcJ/sYWFEJMpArglemrM8NAASeChSP5bXWP3V1wdrj
         2jlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yhjBhVUq/JtHVeGH7sBlCcMZ4AP8+/yjN6oOKRTIC/0=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=lHdnpiS+Vy4EvFp8xm4DiXKAC/gqhcWzVqm1FsoiEQYT74UsgYZS0mFDPLbTzVBgJ2
         tx0s/rb2ea13CixBHa5i/nHK2wI2nK+McDkBPRag9J5luRbQNjsN5mM9t3MDDluRvsYp
         IQonZ49Y7NC+ya2Gf+6S+S5W4aO9BKn6wtiC3rwYOQfJg9ylzq01l9XQJq4fwQHKeKUj
         /jkD4tQ0wGt9UpN/3ccDT951QXH284YFMzSAvDUUeHQadw0oiXTXt8el05rVcM6m0wxM
         Pwo3HCgGjnOkKuR65WPdR33ayEux22co2xtPTqi+vLxD3zdvuTmqDaHNvDHIcWZiEIct
         KHmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770331693; x=1770936493; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhjBhVUq/JtHVeGH7sBlCcMZ4AP8+/yjN6oOKRTIC/0=;
        b=DTPVYgO3+xQ3gjpB5p+9yHOvEh/4dbQBWkD0GyEPnZuX9kecVw+J3gvhvfgUewvTbC
         Ss/gLaakPt10jCq971CYQ5fKblVt3oM3EodyZqomRWaG4g4VRBJGmMcwKwTikfd0+dyH
         8zjQc1/GHrbex9IFuc1lPqWj83M605y2igim8vKsPaky3eAo7hrsHwzHsMO9o6Xsn3x0
         A1S1Ge2ext4bu2q9F0OHm9QUecJtGJ6WS01z95a/aPINOjn4QZEYlV3V7E6KSATtHr19
         u1l7YDJkoOVJwz8uaLBR62Kjral8EaXKvP8G0BGQE62111J2xCptVC4BjyXDdr4x9ixS
         7TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770331693; x=1770936493;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhjBhVUq/JtHVeGH7sBlCcMZ4AP8+/yjN6oOKRTIC/0=;
        b=O6M6VoXbNNcpOyxxPS0EF4vrz0pQ4nFTG622YuAFMF8fTvhFKVCJaDw4qb9is+szhW
         9QJ9oEjKmm5Mv+BkowN4A+xxr5XBn6BOhNmnP7iQWumA4/9z2H/ICPg92wx5KIx0txPA
         AgvKKZ13GrKwP1CXSU4mpWuOXTwnJNwj3B1RYJqhACCffearpKP9T9m5/fEp9eAZrAn3
         dp2m2ph2YJFnNv4/wiFKthFaOx3Wh9T89Y6QX+GcgDlh6xBNL9uCc9Zpo3uSyH9S3+Ni
         AFXAbmPp/LVJf4IUn9SeLJqSLunsX+NUgHCWH2zH5OSKOWA3pRV3Noet/IDrZJ6ATgCk
         1hog==
X-Gm-Message-State: AOJu0YwycFGFv1w/7Q45ZEhBDkgWohBJAgZpIrUrM6A6LxG38EsQlgrS
	Mtn4NFWs4n/YWmdGet2/TOG6lOn1D/lGQL7MXRuyaomuM0bMFlhMAVZ/fk4IZl59wtmeuPus3kq
	s+pP9AXWhJtuCQ55b/ZUcgKQ1bltNGT2sQg==
X-Gm-Gg: AZuq6aI0tXGVZQx6X80HRuNnDB/FtXxqfkMJXHRDjgRGihGS8tXqgOI+DSgKyZteefC
	Fjmgpee6pla+Yxg1NGl0qm3tXpY2Lbj0Mq4+xNY2HMfvQBGfU1oO3qr+4cq2x2WVPOiFV2iFuYF
	YdFMiAZw/892HTxTGm74QgW/l+3Zq/Rh+MsjfgArf3lnndyGBt0m0ERV4pMCgfW2w04u5sNETFQ
	EWSvnyCEXnioU07DX68pGKtIbdAK9lsRPa5vLidTHLChEV0WDC93NTK/Rpv0zgopqaGE4hyWSbl
	YBUX69ZOW16H4N6Komq4klAC4g==
X-Received: by 2002:a05:6402:40c2:b0:64c:9e19:983c with SMTP id
 4fb4d7f45d1cf-659841192camr172656a12.2.1770331692523; Thu, 05 Feb 2026
 14:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Schnaidt <alex.schnaidt@gmail.com>
Date: Thu, 5 Feb 2026 23:47:56 +0100
X-Gm-Features: AZwV_QgGo3PHfYVlSx5l8g_ywe2ZAVTM_IVpNV8lqlqa0ajzpO4lls4M0cFo_ZY
Message-ID: <CAFZTsKkFhRMF-9k-fPSroZ1EKYykLe_wEKO0NK=iuJFfadHZkw@mail.gmail.com>
Subject: 
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	EMPTY_SUBJECT(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31609-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexschnaidt@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7D0D0F835C
X-Rspamd-Action: no action

unsubscribe linux-wireless

