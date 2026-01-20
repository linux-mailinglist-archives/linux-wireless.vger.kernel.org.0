Return-Path: <linux-wireless+bounces-31009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEBD3C145
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 09:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C14F81F5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112AD3B531B;
	Tue, 20 Jan 2026 07:55:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0D3A89C4
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895701; cv=none; b=LG7FzGtsJGfEfMtX4hAJma9rD9Aa4MRLqys7ym5Ct8am6FGHIYEQHVQ/mz4pAL5Mn2DHX/rrVMoTH0rcnVZ7KprSiaZMWgojWpTN3C/wqOxSKDAg1oig1MQsTVVtw63SEcifxcq65ysuCFbQ4GJbxTwvAEWrcsMgnRXJhHJlJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895701; c=relaxed/simple;
	bh=8mJcvFd4e6Z0onxk+tHHydjoN9wcP3W1cW3oRNQ5zLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ON6CUohh91Hi2e0+pZ/v6Sha3Of0YW0NjNzH0IzFnBOH2whpja1Gfn9yubDWhxTFwUAqTZ97vHETK3CmZ+9JeSd0+hqLITBFJCPd0P6DtE3gBt2IEP9p2LQaqpc4IPoQGWlXA2j1fhZQWeYitjzqGO2SKV7WKkyQihDLjqx4XA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4040b9ea153so6631745fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 23:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895698; x=1769500498;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/3PGJs1oVMllznobx6ZsBCrvgUhaEU1VZu2qHu1Fzw=;
        b=ug+DOH0YLMXYmHJTN5NFawviziyIUa/q3FrV7Tp74OvQBvQlnJDseeUKNbU3qAgW6G
         /4ffMJy0kB7ZE3qHQE5TVsDGZCGODJSHDtWl4JMB+ZPuF6tHlEddFzYifqGwl2WxpQK5
         RTFzbaGjeKGUiFXNVjmO/mnMH4HvoVBK3knsMG+G5eeoNZJIixabeTJaZ2lm6A6uoeDk
         KQFQrel1DtE/Sr24M6BpKaUTZQ4DNbNBd9O2Q1ioqmpy6zE9+gK4J4/g1I0FBGgCSxi2
         4DV7J2utXOhyGegml/nJFmOB8qa3FS+7mNQkhZ2GTz+p5F3iRlRaYRdG034n1f22jcBT
         hPwg==
X-Forwarded-Encrypted: i=1; AJvYcCWlpxcu9/X1wTzqkTwowx3vIg8zImvzNXRO9fAn9WmQoeXO/CtiF3rZF4mhc6700D0RYQHndxTY0KCEaDKbYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwddUGIbShbdu1lo8zk+MefeAFQhO4z1AX4VoG5pE2ADFKmVMF
	oBaEoqz1JbtdFmZuZJNPpsj9I9K4Hrp4I+7WOUqY3QcHEskksmw1OdzmKb/EYNescJnsU4zWjat
	W+WK5lVBiUi8qE4PT1kiALfBDRcNkDXTp/ftIJ8QXQTRm5QWJolVOjLv7PL8=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c14:b0:65d:ba7:f672 with SMTP id
 006d021491bc7-661188fa442mr5042056eaf.27.1768895697999; Mon, 19 Jan 2026
 23:54:57 -0800 (PST)
Date: Mon, 19 Jan 2026 23:54:57 -0800
In-Reply-To: <eece33b4580bb35d28be8ffba7957bde509f59cf.camel@sipsolutions.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696f34d1.050a0220.4cb9c.0003.GAE@google.com>
Subject: Re: [PATCH] mac80211: Fix and improve debugfs TSF access protection
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net
Cc: arnavrawat2000@gmail.com, johannes@sipsolutions.net, 
	kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Tue, 2026-01-20 at 01:10 +0530, Arnav Kapoor wrote:
>> This patch comprehensively addresses reviewer feedback on the debugfs TSF
>> access protection:
>
> Please go away until you understood how that contributing to the kernel
> isn't dumping reviewer feedback into an LLM.
>
> johannes

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


