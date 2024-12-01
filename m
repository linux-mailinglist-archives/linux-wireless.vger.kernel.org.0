Return-Path: <linux-wireless+bounces-15811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D3B9DF73B
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2024 22:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF52280C88
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2024 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5AD143895;
	Sun,  1 Dec 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzS2RS9P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAD18AEA
	for <linux-wireless@vger.kernel.org>; Sun,  1 Dec 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090127; cv=none; b=BrC6ljVJgNKSmNcibfpf0Vr8bGcS8bpsAqQE5wcq9RCp8YA1EfhVvfaNlox9m8OuZA+DInTDuJr78mKuQes+A51nz1daz9LvldgkEl1vsAOh0MzPYyyXooBmCD70Kblav270H7toM7HLoN2Fq2m7IP41QEEyTRHrgzIc2fqegow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090127; c=relaxed/simple;
	bh=tM5ehvJLXerzZUUAgNOqXFSno3J6A2OURd8ccftg72c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=f1B5F4BnGqYpEXTcLjSYWTOsuEDQKbOLbYg+jN6Oq70clue4ZzGLg4no9DRAat19LDVAXGHoCqSnkLAGtlZe3S2bS9zPZIiFD3m8BygVKNxhOnlAbrDLSdGacWm2OcrHgyeJbo50hIBb7HLqEhBU1k0ViCxLPgjROIZPC6RjvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzS2RS9P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21583cf5748so4332865ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Dec 2024 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733090125; x=1733694925; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tM5ehvJLXerzZUUAgNOqXFSno3J6A2OURd8ccftg72c=;
        b=mzS2RS9PRnkUn46zv5O6eSXJ6ObzF+V2IyHauVEhXMz048jULBD4o1wFLzUqigWAVi
         H7Y7qCvOh0r4Fw1+MT1aLvLnyG4vM1jfcxOZ68LT+ucdu76CaV9CeBpMgGLKCxo0WbKC
         SvNE4qRpOEYK7LjTUDSyV6xUr7WcPITauD2mhDN/xrI06VmsOJkpUPfltO7tk3lsmlsT
         0HNui/xVAodXVjBNg/pV5oEN3eimiQgqIMoSePrk5vOCAWvhwnGzAK776bLvn1hMffHG
         aS1Hw7Kjvf2AnrH2K80p3xWA2wXSlpgpam2JqBuIJy+IvAASnXbHbzI5EtsoCiaWFXeK
         DwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733090125; x=1733694925;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tM5ehvJLXerzZUUAgNOqXFSno3J6A2OURd8ccftg72c=;
        b=sc56shgv02CkhkzJXkMNo9RMAZqVddJsUtPVKEftcZI8Dc4UdGQz1OdoCrnmLtLVYB
         QTK7k47UhZdMpui8t4qxpdqRzvjOMO7ywJ23Bs2p0sOyVcWauY9Xk9f80NAr4nGggJeO
         6a5fGIkkVnJnhmwTd5oJGxMW0LDubM/mL/7aYHrUaxIzi8vXHOemHk0LR98f6vDHHEeI
         DHiKqeA948aldP4xw5ygX9X0jeFgPjHMisA4mbkWiDDYOBJCZMBTeFokV3kagZRZgOpP
         IZQ4/pqKGsNl56E1WGdHwswRrK4Lo+TO06iUmTQUADzdBTggWKUyclL27lzFfFMuqEn/
         gGzw==
X-Gm-Message-State: AOJu0YxUPxOKmPsdFet3VI7vzSJ040uR7e3Gv4qphCfyQ0LRlue3XqY5
	QjPY5qFfY7GNm5fqVhVySBuMF+oI78pBsnZD6uEmb8nj1K2OdKUavXw9YEJN51JI9YH3y/rKt9Z
	nK9Ji6WUPYZID4b7Vurv8P93vy8OXbjUL
X-Gm-Gg: ASbGncusMhC3BHafxqA72j7jCPqdgzn73my6nmYw3Z+iL6wHJuZcDx6fpM0sSkmFKU4
	tOg4AvFO9XUi878iQ+4Yo74kSso2lbdI=
X-Google-Smtp-Source: AGHT+IHPdOdnAka/twUnjIPcAdXLE4UlLveWtPtghBdqd4LIluTv6i1eRN+qkINwB7byBzikMhvpm+a6WDCFfa0kFZ4=
X-Received: by 2002:a17:902:e811:b0:215:781a:9181 with SMTP id
 d9443c01a7336-215781a9384mr69208875ad.48.1733090125532; Sun, 01 Dec 2024
 13:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 1 Dec 2024 15:55:14 -0600
Message-ID: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
Subject: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: linux-wireless@vger.kernel.org, 
	Arend Van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

This floods the journal of my Pi ev ery 6 seconds:
Dec 01 15:51:30 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
0xd022 fail, reason -52
Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
0xd026 fail, reason -52
Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
0xd02a fail, reason -52
Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
0xd02e fail, reason -52

Is there something that can be done? Is there something I can help
with to fix this? I can test on multiple Pis, but cannot actually code
anything. Is this going to wait for the new infineon driver
development? The latest kernel where this has been seen is:
Linux pi5 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.62-1+rpt1
(2024-11-25) aarch64 GNU/Linux

Keith

