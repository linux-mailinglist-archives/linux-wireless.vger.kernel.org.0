Return-Path: <linux-wireless+bounces-14837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA29B98A3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 20:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09FD1C21DD6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C611D0157;
	Fri,  1 Nov 2024 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nI76WWIL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2981CF5DE;
	Fri,  1 Nov 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489402; cv=none; b=GE0vzkXZuNUBXZpiGI7ibUYEdWtpeTQT9nDAR6g2vYKhWbWMPzD2Y5aQYVHQfXumpftWTHJIga8MjVsM9FaTB75tF7MyVJD+xICEB1Fp6/Wg/AzMmwSLMQGnVFpJaGyYQ8UVof+Mwl37PXbAMIQL+D8sRZD0F7RDxMWJMr6Unac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489402; c=relaxed/simple;
	bh=UHcOgKY60kHMORdxEhJ2bsmNACo25QXm+l4rjXj3v00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujLPzlcfNTtx7PBU5CeLAX1/cifTFMm8widJq+Bgn2KA0HEgIWNR9/+VzQsSmKsYhEbybTMcXYVuk7AjWKVALS5i9wtcdkwNAfTvt9j6R/0mv4TolQFwWGC1OcuUh4+JVI/NTEBzY0f8HhojgoaCLhPjtbeTLlID7KNQPpNvXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nI76WWIL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IeU8B7tRAGK68ZBx5T5o8+VaZhBGOgwk1ohdzdqEKIk=; b=nI76WWIL5gDscrNMeYsAedfhOY
	cUGETXe0Al45QIZP2OONBkpsgWYWgSZ9P4f3uG9FK4LxWfUZk2ViKN7E/Cb3y47TyX8HTk1a+8onB
	Hm+AB+zv6ceQx628ddbiMiNWeVKPrkzK3xIOzELjOGodBFa0rGuSt/pH7UxSHDvpGWzLYJW35u8Vx
	fvyIa3tvgdedkXJ0rDyIT2YRifIErTID06Q9BsAjnKBaWwPks61hwI780pImyMY9tAg8iLSoJRUDN
	75yZd+Chu/bjqGEYjShwLqVTdoDbI5MyzXgDCDQieSN+wxV9K9hvmtjI7ejWPF5AwapPr4u4u0Qlm
	3DMfnweg==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6xLA-000YRj-Bk; Fri, 01 Nov 2024 20:29:48 +0100
Message-ID: <5f87f72b-8768-50bc-4c0e-44c8fc12f5c4@igalia.com>
Date: Fri, 1 Nov 2024 16:29:41 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse in case of failures
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20241031155731.1253259-1-gpiccoli@igalia.com>
 <ae95544aabe74d1da801fed6cc73896e@realtek.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <ae95544aabe74d1da801fed6cc73896e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 23:26, Ping-Ke Shih wrote:
>> [...]
> Have you run checkpatch before submission? Above two information can be in
> formal form as suggestions of checkpatch. 

Yes, I always do that! Happens that checkpatch sometimes provides good
advice (or even point to genuine errors), but sometimes...it's OK to
ignore the warnings, specially if we have a reason. Below I detail more
about my reasons:


> 
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> #55:

It's like 76 long line, and helped readability on the commit message. In
any case, I'll refactor this one in V4, but notice that it'll continue
complaining because of point "[0]". That line has 80 or 81 chars, don't
recall, but if I reduce it by removing the word "Commit", for example,
checkpatch complains I'm writing a commit reference out of preferred
format heh

So, lose-lose scenario, I can't make the tool fully happy here xD


> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #72:

This advice would make sense..weren't it for the fact that this
Syzkaller issue is already closed heh

As I mentioned in the commit message, the main issue with this
reproducer is a race in the uevent path vs driver shutdown, addressed by
other commit, hence the Syzkaller report is fixed and closed.
But...this patch fixes a secondary issue there, and pointing to the
Syzkaller issue is useful first to give it credit, since both issues
were found by the tool, but also to point to the reproducer, so I kept
the Reported tag, but not the Closes one =)


> WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes:' tag?
> 

The fixes tag would point to the driver addition, ~10y ago. Stable bots
would attempt to backport it for all releases, which I think maybe is
not necessary. This is a small issue restricted to (old?) USB devices
and emulated devices (in reproducers), so in my commit message instead
of adding a Fixes tag, I've added Cc to stable with my suggestion of the
versions to backport (6.1.y and 6.6.y basically).

That decision is up to you and other maintainers, so feel free to chime
in if you prefer to backport to all releases or even *not* backport it
at all, I just provided a suggestion based on my understanding about the
issue and the relevance of this fix =]

Cheers,


Guilherme

