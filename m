Return-Path: <linux-wireless+bounces-15678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB39D7BB2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 07:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B521B222ED
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 06:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792913D246;
	Mon, 25 Nov 2024 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="FWfHWpcp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F981E517
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517387; cv=none; b=GHQ5fGDLSq1Iwv8fMGdRr05aje7xZkYFcKx84uyc4AljYIqzV+skSVdkzV7FGpemc1HmUJcSKhf4/Btd9I4Xb6jTqCCtxt/XUvFhJzmALa81V/IEcRvrGXviUcxGX+Z8t8D7jzKOsVaFH6F8+tZqRDEcGU3LHjlozdRfnVxIwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517387; c=relaxed/simple;
	bh=4iHg3LYBmpe/kmjI67sP2A2uYQAW9wlyzWZM3xCHXG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqqlEheE63wTk/W2GHxBUntrrTH5eei1a/OL8zwhd2CpeqTTTaYBivpz5JYPfqqzymxwDQHpjbPxEd4Dz3mquv/aWKjLGRWoyLrylua16tNO1JIFkcZlDbYgRmIOgcNkw9M6CjHL4tGVPEHvTsOUzVVRxdJNJtvnbbGR9HsCKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=FWfHWpcp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21262a191a5so35002495ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 24 Nov 2024 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1732517385; x=1733122185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iHg3LYBmpe/kmjI67sP2A2uYQAW9wlyzWZM3xCHXG4=;
        b=FWfHWpcpxw+mE+GTR5fsIhqwf3rKZH4O0AZQWSxHZpEUs1XUFS1JOwEpVwxh3m8zsl
         VTNtarbKx8LvzhgsaQaTqWOM80tQsvzu0kBVgUaYoR+pQU+Ow+YVN+1EiptK1F832+VF
         CsL2KtU1GDbRju2ggPDZCHUqdUOQuWkizDi8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732517385; x=1733122185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iHg3LYBmpe/kmjI67sP2A2uYQAW9wlyzWZM3xCHXG4=;
        b=KKoasmkqUGrr+RaXU8f4A2bIA2CVnpahXRNEzAo1gO8ND+8UYDlxYI1V5r7kqV6gF2
         2ToXQS8QlxiWSFzZ5GLUktNcv0Xl0xHSNMGUdLzW6Gnym2G61NZGVCsnEkL1Czwu78VE
         kK9dpYNOs+5+mVG6gDzHCNcFrRD7eltDjyfrPZF43waMpPEyQ4KhnVRablBYNuIKM+kd
         /l3pnnIWWxwio4oMwYDQqjg57qEOo8WGU7gK3jwsQzp4wBGYa70TV2bwg0PWHGwg2fFI
         /Brqwz4uwOigTXmu+CTaaxjlMQDQjUPCIpxQyxpEfIvdcXVFwNjvmqcOofF/d3ISqyUW
         zSIw==
X-Forwarded-Encrypted: i=1; AJvYcCXH7z+JofUzvsE6R/UpA6bQEYCi6ouroIbYMRt4ZRn6caXptVWHKVVjBQIPO/Jr/5GdMRoGn0oIUBPF75r+sA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tiphMSKtwJ1vDiIrPUtAuXeYrY9pKbqZNA+9spGqXaHm5vsg
	IrmXi43DOIAPLy0xCQc8eoj9XLhM2Qh4Noc7r0ZuMWuw1OtsBQ5QEIKo86VdsA==
X-Gm-Gg: ASbGnctb3WC3H5Or4WB2xUAS1MpTknXswDHpL18xkHXJVgu9psZGyJcGNIeM6JC+WFJ
	JrlsYs7iL3blk2Brpq0L7IyogLfK/nTRPlhs9yiaxaQsq6FOMIzDY8u0cQl9a/tQF3mMQlt3YmA
	1V+5S+tFXrXBqHONaakptYwmJZQPzLwY3SkhmbBQOC00OVFcnzv2XewMMIv8N2/6M36HXLKT635
	u7TniPay6SR+p+95uy6gYKH0lEJYhZhyDqEkd6N36/01hpYI6PMWq1FxFRh7T0hoWM03p31fX/y
	pzUR4TE=
X-Google-Smtp-Source: AGHT+IElcdfnqcK17IIf0blVBNJq7u8Dr0V9C8rh4erdeBmraxr+YNDJVHKW/0x29+5jWsW8aumjMA==
X-Received: by 2002:a17:902:ce8c:b0:212:12a2:4011 with SMTP id d9443c01a7336-2129f23b59bmr158676685ad.27.1732517385479;
        Sun, 24 Nov 2024 22:49:45 -0800 (PST)
Received: from SE-151.formulatrix.internal ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfa337sm55949305ad.128.2024.11.24.22.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 22:49:45 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: arend.vanspriel@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com,
	aspriel@gmail.com,
	brcm80211-dev-list.pdl@broadcom.com,
	franky.lin@broadcom.com,
	hante.meuleman@broadcom.com,
	johannes@sipsolutions.net,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	marcan@marcan.st,
	renjaya.zenta@formulatrix.com,
	wahrenst@gmx.net
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Date: Mon, 25 Nov 2024 13:49:40 +0700
Message-ID: <20241125064940.11746-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <19358720a28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <19358720a28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/23/24 4:54 PM, Arend Van Spriel wrote:

> This was reported earlier by Stefan Wahren, but the thread ran dry.

Yes, I've read the whole thread. I guess what I've found is similar
to what Stefan found. Those channels are disabled by the driver in
brcmf_construct_chaninfo() but are re-enabled in reg.c.

I see there hasn't been any conclusion yet, so I just bumped this thread.

Stefan did a workaround by modifying brcmf_construct_chaninfo() to store
the IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags had
it. I see no further ACK, so I think that's not the proper solution.

> So what changed a couple of days ago? System upgrade?

Well, I use the latest OS from Raspberry Pi, it still uses 6.6.51. I guess
there is no significant changes from what Stefan tried.

Regards,
Renjaya

