Return-Path: <linux-wireless+bounces-26436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EAB2AE97
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177A71771E7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F927B358;
	Mon, 18 Aug 2025 16:56:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE21F9F47;
	Mon, 18 Aug 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536167; cv=none; b=rScWxgKaN2ZmJ4ESyjd5SvPMYLKxL5fs1QZAGctdqUaL0tqjVpm7pKEZcsATOz7c5lnUqOKJalHOKZzbgjZo9SEj7RJI1xs6XXD2KKDFPcn6ltRSVa63vTHi8hPyc1NarRD/5QN+yyKmKBrC4z2hkj5t3/oxNR4UbYncYXO/Gg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536167; c=relaxed/simple;
	bh=IFg0D4g6Egie7/QmgFZH3hnlqMPxOHmfSJD63T/Ug0M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MKu57J326Q8TaRBSJ/L6RvnAQPYCYDXuXClI03jfRtxUOPnD50FyEe4JwJCQprJ+H1bEcSBtLelDxeEQNcoZORk8p7agb331LQaBC9dt8FqZ6B5SgjWWie4zXD3fVEB2ztDDKqEsfajw676rDJtcEvkDtbFK/7d4LSbFs2WOByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-244580692f3so4647275ad.1;
        Mon, 18 Aug 2025 09:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755536166; x=1756140966;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcw7UQVd8NcuUoJtmjMZ4xGFWAzLft8voRj5P/6UCyA=;
        b=MhjN6XgAtyyJ3f9BlFko52UEvvZDC/2C9msJl68sKheiyBtZ9aX+mgam5yWv+7iWjx
         HL7zVoIBi/15SgCW/MBD0xgChPFr7aUmZjgZ+/UVCVI0G3kZqsGJfSPKaF3FeT3ZFrvP
         Ki4tOTWlIern2+3cY/agu5YdyXJVYij+7CZr2re00yvykQkEfU6gQLIUd6tQHuHrNNDd
         YhW6EFPkEcWkx7ChwyHtuMCT/6eCg8JZUJKuBdjvXvaC1r7FqOkMtDMRjdAApEiLj7H8
         aTdHSZUhtrzbLBlXHjdol422KCC0wX3mR404xIgLWxk/8Q02FVQmBlw9MS6ocfpkClYO
         WevA==
X-Forwarded-Encrypted: i=1; AJvYcCUBxBP2S23IlxLDqnmEJj72NFNLYtJrB8G+mdZ76wrbDsjfH9k9eWG5hUgbRWF75qDPNzBCyMZ/Fjz+m0cfh1A=@vger.kernel.org, AJvYcCW+UNZM+aYiYYP+c//0RC4v7yLRrXGPnflUQhYO5oQsMiBhQfNUSR6a0uHftnZur5KdKzZVsnBwAe0r7DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkYCpPGoS1jgVYyBtp7nXTDWjncsgorTwx2RnccMwPbYk5pz5
	5BwEcOcNtjvIZffTq4QYnyoPo6Hg2/7Kxo0JQOLKQHysYUmRhF7TjZsN
X-Gm-Gg: ASbGncuvz7/2fwb98FkZSSrhyCx9Tg+NjPBGHWV5VbO00xwkkI1qCzHgCPbAiwz0nv3
	tBf0+7JsigiDSV4VmIQ5TaIXfExZ2CWnzxgDrCv8OnWd0m1zEKpEUJfhzvxlssD8Iwu0HlbPqMV
	31ATbvAVTXNktSIr5Ktmo7gILyMu8CL3dlr7ROspmwOnMGGtNHDwBs6hCf/uBvZB8Hss8QjNVjz
	PB0AaotQ0EBCZBefUfSGna7rP/XG7l43xEKR8VxKT3PLWQazgoKMa5l/X/UNJjkWpk8uM/DLftC
	rK9zIJhaHWpGpph7YoClA+m67emPXfVXU9AImlCiGtndanCf/gJouvZggK5mN77mdaSrnN9NlXS
	FEfuQsNtnZCsDozse+LV8fzl/bt2y+db/
X-Google-Smtp-Source: AGHT+IGnVrA59DmOzJy5E4sN18kKqIy9b2FRTAzN1UkHFYriAbF897/ODgMzzWDNmt9+Bqs94Fa7gg==
X-Received: by 2002:a17:902:d4c1:b0:234:df51:d190 with SMTP id d9443c01a7336-2446d756119mr88110485ad.4.1755536165478;
        Mon, 18 Aug 2025 09:56:05 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb09ff8sm85254045ad.50.2025.08.18.09.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:56:05 -0700 (PDT)
Message-ID: <c15a819a-51de-467c-93fd-c321dd2e8ec9@kzalloc.com>
Date: Tue, 19 Aug 2025 01:56:00 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Berg <johannes.berg@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Jiri Kosina <jkosina@suse.cz>, Aaron Hill <aa1ronham@gmail.com>,
 Lukas Redlinger <rel+kernel@agilox.net>, Oleksii Shevchuk
 <alxchk@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, linux-wireless@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [RFC] mac80211: Potential sleep in atomic context in
 __ieee80211_wake_txqs
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I found a potential PREEMPT_RT issue I noticed in __ieee80211_wake_txqs()

 static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
     ...
     local_bh_disable();
     spin_lock(&fq->lock);
     ...
 }

This sequence of local_bh_disable() followed by spin_lock(). On an 
RT-enabled system, spin_lock() is converted to a sleeping lock. Calling it
immediately after local_bh_disable() creates a situation where a sleeping
function is called from an atomic context, which will lead to a sleep in
atomic context if the lock is contended.

The conventional fix for this pattern is to replace the two lines with a
single, RT-safe call to spin_lock_bh(&fq->lock).

I wanted to bring this up for discussion before preparing a patch. Is this
a valid concern, and would a patch to correct this locking be the right
approach?

Thank you for your time and consideration.


Best regards,
Yunseong Kim

