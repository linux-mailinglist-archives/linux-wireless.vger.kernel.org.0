Return-Path: <linux-wireless+bounces-23232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA4ABFB4C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 18:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5474D17C935
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B92153E7;
	Wed, 21 May 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7u8I4zG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF31E2307;
	Wed, 21 May 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845159; cv=none; b=ieECE/UH0CC8XjRBz+Cw3UOEDx/mcOHiph+TkfYf7HqEhfUarffLnp0g6378zgjtdlmIMKKyDXUyOS/NPL3C34zmn5eHDM09hy0uQGsLCIKvHNpO96OhxReIbkBkt+EBwzkB5BMliI+NS9NTn71TZOgisvq9UeHGIdI//57fRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845159; c=relaxed/simple;
	bh=CxFBtbqE6O8KFdWC7PNN6oTL6F/r39hQAYdVnyawXk8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IB5ga2S4cpkkto0kDB0jswczXuSfujJRBmePFznOK5jYcFB41mV8fIV5NCJ5NRkIq19mZjiQp8Lk2HnZb5WTocw4SAV4vs+LZsiKy608tyad/M7uNHePJjhPo05pSCGJn9ZONbzyGvzW+eaWn6W3t50ea46RNbI/mWEdhxDviS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7u8I4zG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so8287726e87.1;
        Wed, 21 May 2025 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747845156; x=1748449956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wqw2BMQBJjCL136c8REdV1FyhKLQ5JB4jzpcVqXwLKQ=;
        b=Z7u8I4zGGDC3NkRg2IjRr9scKgP4GwseSASti9vVXyr8w//gsheFVNu7mAw5FIBcME
         sZ1Gr8kvQ5JW3HXoWyfitgi8nQZU9hFbzLpZKYbp87bG0nDCXmwvsu2DS8eheEr2pzFC
         rU+5KwtXoHQmc/GeO4cUhvKzCUtlvlyTvfLkUXjbmsIIJPW+8G4f64kaDNdkkdi1/aFC
         yLx3aTiRfSTAhaABXL+zQKeNGgGH/OHFMwiHm8wzDQKXYVE3O3ScVgCj/5DXzcrSgPUo
         cSseMje82SeAqrRkpJYUoe+cY/8AQdofGurW4fcaGqUBQ6MnFvKxURvTIV9139EP3pEi
         9Tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747845156; x=1748449956;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqw2BMQBJjCL136c8REdV1FyhKLQ5JB4jzpcVqXwLKQ=;
        b=iR+RrO7LPjqsEtGAScrOSyFxdVPMHmWYC3MFnVs6/+frRyPgG+wuVABVBSyqcmig8D
         Ykt/o25V6uQxtpLvEiJBw3+7IJChDJ4o2fx/JOuwFZcy/sSou5igiO3i+z9dq4S0InCB
         0iyeV6zEMjjhbGHlhQlpa3koATBGOwcl772XAaLkJUiSXpkrj//+H81rcOKI55Qq08pC
         SzD99T3nd97o5u2KVROQ8SppAcG+Gh2rics9hBscn1wyz2Qise+/HueBnfp/JNkS2062
         kiDC6QS3LT8Ni91JtyriW3UV/N7iXH83NwkLQ7IvxUnLdSEhbY/zp6YauAA4H9SU2ja1
         i4QA==
X-Forwarded-Encrypted: i=1; AJvYcCUlmiB+Xj5Hdm0J/eBOWXgPPCpW54r4iey5+2cESMD3qg8FBJy561HET4Ir7NSiLmgnTxaYUWgSbyFC8oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARfqfwHeDLrO/rvPFsZEB76obym1iYpJkXi0tKmENaXYIAkwM
	H5DVjWgRxP8+ndOOR2nZRqNjLQOraDixlvgY+hT+k4xpCcMMfEINI8A0bfK4WDqO2Rv4K2+B9T9
	M2CSv9JKmmx2aPn11i1HnOHqaKUY5VSPWNfeynQ==
X-Gm-Gg: ASbGnct4jPTy16oA5huUpOEBdwSzZEmPt9GXwJTQhOL/mqR/9pOLBosoVl3Hicbp28t
	Oq5JMn/BDfdiL4vTep1wzkSOAS/8lKK+HFRc2Iiuowp40PvwLpLAGLov6YtUBs5le3ZPGgZiF/W
	VcFDbrn0M6Y3FTurCNMi5bUdX54nfgTF96yavMhOkHdJrr3saTCSLBlA==
X-Google-Smtp-Source: AGHT+IEBYlQoA7n8N3tMPtS3LuJtZhx9PZrKBPTf8VglWh1jOBclQbJc1jjvLkgeXdFEZvLPKb+wOVtU0YDeoKmGxNk=
X-Received: by 2002:a05:651c:552:b0:30a:2a8a:e4b5 with SMTP id
 38308e7fff4ca-328077917e1mr73943941fa.27.1747845155623; Wed, 21 May 2025
 09:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 00:32:23 +0800
X-Gm-Features: AX0GCFvTRuIskle9KxRKlV8qOJd1z7EdYacQGs2qwbi4rDWWZARTsS7O6gQ7GXQ
Message-ID: <CAP=Rh=PV2nqPkBV8rALZRHLO4n58XwKTYRGYkS5snNc0Zo0YuQ@mail.gmail.com>
Subject: [Bug] soft lockup in ieee80211_handle_queued_frames in Linux kernel v6.15-rc5
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15-rc5.

Git Commit: 92a09c47464d040866cf2b4cd052bc60555185fb (tag: v6.15-rc5)

Bug Location: ieee80211_handle_queued_frames+0xd9/0x130 net/mac80211/main.c

Bug report: https://hastebin.com/share/itequxofas.yaml

Complete log: https://hastebin.com/share/opasimohab.perl

Entire kernel config:  https://hastebin.com/share/padecilimo.ini

Root Cause Analysis:
This entire chain is triggered indirectly by
cfg80211_update_known_bss() from the wireless networking stack, as it
tries to update BSS (Basic Service Set) entries for scanned wireless
networks.
This function uses kvfree_rcu() to deallocate stale BSS data, which in
turn invokes kasan_record_aux_stack() and then stack_trace_save() for
KASAN quarantine bookkeeping. That leads to complex locking and
backtrace operations, especially involving lockdep.
The deeper root causes include:
Lockdep recursion while handling RCU-related memory free paths
(kvfree_rcu) in cfg80211_update_known_bss().
Excessive softirq processing time in tasklet_action_common() and
handle_softirqs() due to high BSS update rate or malformed wireless
frame processing in a fuzzing context.
Potential deadlock or pathological behavior in lock_acquire() due to
corrupted lock dependency chains or misused locks in the wireless
networking stack.
This loop fails to yield CPU time or reschedule, triggering the
watchdog soft lockup detector.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

