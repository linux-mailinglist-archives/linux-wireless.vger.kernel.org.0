Return-Path: <linux-wireless+bounces-30955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE6D3AA3D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61983300BB8E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12D36828B;
	Mon, 19 Jan 2026 13:20:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39536826A
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828823; cv=none; b=IdX1prd/VObJHLPCK/+P01xZVfhD//HV2wlRNWVLmVGPHy9+h0gUZ6FNFZolXl8n5wvS/+RNII6iPqvOlAZGBSm6kdipQLv8UxRpIWexrrP0fudZgSLEyfJjATa4VGRoJZoqCg2VeHMhe7xP/2uaObtMz8cIxUwfyGDV4HKHJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828823; c=relaxed/simple;
	bh=5bUGCWq+LnV/X27cmP/pjgH1GtLK6QHm3ALbW/6FBDU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NqscDASXo5K2fQzJuuVuw7DBQazP5/vAYDsvnuiaHANhsOgpPlC9cf3Z9ixVBU1mfXWTSTltYh1+fnsZre5noroUAgRnFRVYYMhslSSRnLLbeY3LQJ0LwMJYFAY/1qRMaySWsKLPGuUwcvCaywt6hyvmbSCkhFL9DXgoQtezYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-66107de5f96so10219048eaf.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 05:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828821; x=1769433621;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVNeYeJDjJjFou7aAMlRuPKSlq092RHQDhPaj02tUNw=;
        b=TJOEzo0k5wTqia8XjFcpLI6JJuvc6Sv6K1lTY60ym4pE1pIxB8wjQc224WQVSbnDPf
         MxzqXls70J/ZtB7/PLnn10gicLdUrYpfaCaMScbwmEACXyu5ZjU8kyw+bUcki9Gi2kTV
         4lS+XxiGYednHrEWnwxyrp+5jJPJyWM+lWyFqTzkdHSoSXVyg0FZWbcQ4iqEOC78XFf4
         XpNA+qOTTesTdlh4xaYUsr0Qvw5uIIpiYtAaGgAAYYz8qN5hl7FVwQc+SqWd8GgRyOvN
         bLVmCYFLgO3MojeJGmagMkQUGahcqTbHl88KrJL1mtefM1whWym+HQegO8W8FD1Jr9OL
         qrKg==
X-Forwarded-Encrypted: i=1; AJvYcCV7mVbeE87dGw+WkRpf9cypk59G5+ttrEkSLV69DFmIZ/j8+KX917heJFk+QgALv4FoeG8BcuvRR2lY5iHjYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTVpZE4ZeGmEdu8cbMflgzmMt4ejRYbWULQ3TaQwq+bw3yNBp
	ZHu3yGqiEo7tasBUMuBoFq82bvRTK3bYfTuev3nGGPkTKaW5zZQaSPeqv7o298h+JsZgRfQeCC8
	jCeXg7B5lq3SHcD11wsgN9Vc5P5Sdv2ZWdIcg4gnktmeOMDZVCQavaO/cu5M=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:da12:0:b0:65b:5553:8e9b with SMTP id
 006d021491bc7-6610e5c4c10mr5734346eaf.12.1768828821116; Mon, 19 Jan 2026
 05:20:21 -0800 (PST)
Date: Mon, 19 Jan 2026 05:20:21 -0800
In-Reply-To: <7d2a4fa708a6681fb5c17ae8420ccf762b3e83bb.camel@sipsolutions.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696e2f95.050a0220.3390f1.004a.GAE@google.com>
Subject: Re: [PATCH] mac80211: Fix WARNING in drv_get_tsf debugfs access
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net
Cc: arnavrawat2000@gmail.com, johannes@sipsolutions.net, 
	kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Mon, 2026-01-19 at 03:03 +0530, Arnav Kapoor wrote:
>> The debugfs tsf read function was calling drv_get_tsf() even when the
>> interface was not registered with the driver, causing a WARN_ON to be
>> triggered. This is inappropriate for debugfs access.
>> 
>> Fix this by checking the IEEE80211_SDATA_IN_DRIVER flag in the debugfs
>> read function and returning -1ULL directly when the interface is not
>> in the driver, avoiding the warning.
>> 
>> Reported-by: syzbot+15f88dfa580000@syzkaller.appspotmail.com
>> Signed-off-by: Arnav Rawat <arnavrawat2000@gmail.com>
>> ---
>>  net/mac80211/debugfs_netdev.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
>> index 30a5a978a..669e7c519 100644
>> --- a/net/mac80211/debugfs_netdev.c
>> +++ b/net/mac80211/debugfs_netdev.c
>> @@ -656,7 +656,10 @@ static ssize_t ieee80211_if_fmt_tsf(
>>  	struct ieee80211_local *local = sdata->local;
>>  	u64 tsf;
>>  
>> -	tsf = drv_get_tsf(local, (struct ieee80211_sub_if_data *)sdata);
>> +	if (!(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
>> +		tsf = -1ULL;
>> +	else
>> +		tsf = drv_get_tsf(local, (struct ieee80211_sub_if_data *)sdata);
>
>
> Seems like we could get rid of the pointless cast, while changing it
> anyway.
>
> Also seems we should do it for all the debugfs files?
>
> johannes

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


