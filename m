Return-Path: <linux-wireless+bounces-37088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGjyI+kfGWqnqggAu9opvQ
	(envelope-from <linux-wireless+bounces-37088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:11:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CFB5FD425
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446063050918
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702B39E164;
	Fri, 29 May 2026 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="hLTiSqxS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D937267E
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031462; cv=none; b=SDzMqcEV415PMCVlqWMU0yE7BELuPvUM5hd8OcW0m+erGty4YsqRumTHJy29qArmJMO7rfsltVqmwPs6oJtOkc6UBJcBeHLKRJ8YZssjgGYeUx7uy5z9jZ+LFCLyaq4me6SbUHDCAu9nRCcGRCt5ycvNfBQAps3KpuAQENMbQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031462; c=relaxed/simple;
	bh=Kvu7rWe521q64yjT3Nh2lIPAeOr6Yx40ExPu6Gftt0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlbNfONdj1GNsnasw6YUXaJfFAwH+3lTrxCdMCSvN9IvS/7a+EY7dI2+uDHLYLje0xzRka61YLqyWNaaAa5zeFu9RjJ/pWnI0MAndbZtUV8r6ufg2KbGNy04k0lk+whllM4JvY9LrUmcwIumWOeLtDzpNj+NfOg40dX5swZcOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=hLTiSqxS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b4583f0a1aso99221445ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 22:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780031460; x=1780636260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZgcHamsapWCO0q9FfFQ0Aoz1uBUQU66IVFs62fa5k0=;
        b=hLTiSqxSBiHQWopy5klocSA9jfEh+Gzyv4k60v5zlGzxyALhtxQngdTNj5aaXVgolu
         kVi5UniQrwYvJgDfTgg3YnWuM07FigT3qcoVzwTHWz9XfWcKmYWZDY41lTy2kiKqv+Gm
         5LPiG7w1Jl8RX4SiYFvnpq8sXj2F04xY6xtSmsAqLrG5wN8o2EiGSZ3uAuRpTVs4sltm
         QRSQ4pDR540UmtJsXOjWBqljXPDRErI5ivTvtZ4WnLW5vKgsoWlq2FYDvU9Hjab9Qtxs
         yJNaB4xMTvFeYZHhC9UOTZLSJwxTMH6/c1zhI7xsYT3lX7Mc0LbM4bgPwMiPRmD9KdN6
         BciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780031460; x=1780636260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZgcHamsapWCO0q9FfFQ0Aoz1uBUQU66IVFs62fa5k0=;
        b=W+tiQBG84ncDTDxViSNTzc4dNEJYSYvTx/Y2w+uxCnqqyHqT5dzfBT/JhO7TnowHYM
         t+XYfwkfnG8CLmYI0VlHMSbBa56slHHMWC6FdtDJThKyikVV5E5ZzaHsyGnPfluA7gbY
         v7RQZI9RoDvBI/dceVciii3g1/X39zLGniyxlMDtyqQBYNOXIQIc0LhtThzq/7oEzf8f
         NlE5WwFcfUPxeH0P5hF5G6+6+Txl6GnUjX8/3hgBWx/7RrpckdcVmmP6E6UJJfEbo3i3
         kBWAOc+c3SajyyS8Z9dD1wYtGUm1vfB/btpwQJFEAwK2NG3vwi0i9UQTXU/waTqpSmR7
         P4AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QqU7uOeUEPXprdKUm/hpToUU6kmieuICDpIX6H/G/49Vzq9JMXqg8eK/uiGSchQtBBRstae5BApf/Ux2E4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQbhJ5FyPeob4espQwCoBd612sTIMBGmKaSh2elWr/gsf47EX
	z82sGiHQZMVmIHCa3QxhDjF6sJw1EgXpBX0TUyAt/jjDzksjxPkN7SkMDtkuVwTGHgs=
X-Gm-Gg: Acq92OG8EN5MX8My1W8zqjTL7yu5n/ytgHGQYlhaXKhl8IJl8FwKdYRfGB52UmvSNw/
	mYyegqe/kjPdFVatwdgPrhRKbG1lUxvS3KSo38gJJ3WZPAYnStzL2QUSIRph4zE49pLDeVCV6Kr
	OZPfTrzT+iGvedsFJlZDhAVMYX6IFhY7n+RCP5VpnQ1PCvYxTabAF2mb9BpiPa6CkeP42sWPyg1
	IcpEH6RDrmGP8TuQDMGacrMVsJj4t9rTFSO7YDo9v8/SzdhhWJ53miK1CIM8q76P5g2dvKkpGFQ
	IenME375JsJ/sE9UJHvHLYgEmvNLqhvrfiEMYeDMRyxAeTcnWKxqID89uyu9Kth2O5s/YSo37zD
	MCOG+Y6mePA2S8/pkwlrgz3FsfW1YIhAX18vaVpJm5As8T0yChhaVnXUHfdBS4XeU/uEmpSTwu+
	xSnacRaro7vwcgbS8E28acOli6TVPXUlvrAJ4SxJlLP/RH4PxAZ7Q5wu6umoqlzIiX1aegvXTeh
	Yk=
X-Received: by 2002:a17:903:2343:b0:2bd:d4dc:a4f9 with SMTP id d9443c01a7336-2bf20991cc5mr18346965ad.26.1780031460594;
        Thu, 28 May 2026 22:11:00 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011d3sm4977125ad.52.2026.05.28.22.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:11:00 -0700 (PDT)
Date: Fri, 29 May 2026 15:10:54 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: meihaipeng <meihaipeng@uniontech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
Subject: Re: [PATCH] wifi: mac80211_hwsim: handle 5/10 MHz chanctx in rc
 update
Message-ID: <qrtsnjplvmg2pbq2cym5s3c5zxm5lrxw5dui26ks4jbbmmqhem@uwzblpmgdi5h>
References: <20260529040923.9816-1-meihaipeng@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529040923.9816-1-meihaipeng@uniontech.com>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37088-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c0472dd80bb8f668625f];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,contexts.so:url,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D3CFB5FD425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> The STA bandwidth enum has no sub-20 MHz states, so a normal 20 MHz link 
> STA falsely trips the warning on 5/10 MHz OCB channel contexts.so 
> a normal 20 MHz link STA falsely trips the warning on 5/10 MHz OCB 
> channel contexts.

There is also S1G widths :) but that doesn't really matter.

> Treat sub-20 MHz channel contexts as 20 MHz for this validation and use 
> the actual channel-context width in the warning message.
> 
> Fixes: aea9a6088ae46 ("wifi: mac80211_hwsim: do rc update per link")
> Reported-by: syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c0472dd80bb8f668625f
> Signed-off-by: meihaipeng <meihaipeng@uniontech.com>

Looking at the stack trace of this report and a few of the others,
it comes from mac80211_hwsim_sta_add() which calls the rc_update on
the new STA, so it would probably be better to do something similar
to what we did for S1G [1] since I'm pretty sure the rc_update()
path isn't reachable on 5/10MHz (just like S1G).

Though there are also quite a few 5/10MHz syzbot reports for various
things similar so maybe it's not worth it.. but that is up to
Johannes :).

[1] https://lore.kernel.org/linux-wireless/20260527033828.183821-2-lachlan.hodges@morsemicro.com/

lachlan

