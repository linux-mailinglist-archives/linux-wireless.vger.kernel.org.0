Return-Path: <linux-wireless+bounces-32204-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLnzHQkooGlIfwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32204-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 12:01:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F31A4C12
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 646CC30180A5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6E32BF52;
	Thu, 26 Feb 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="vJ8Ua994"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE2326D73
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103462; cv=none; b=WzVqbQ26W/o4kUBR6dnNkEZMZO1liUQyymuiB+jbaVFNLlVf1lpsoKdNZ0yTa759+Hd8S1uiOMJGSSn9b1NnJqI7g3xMFR9yP00kONJMD3QZyqr+6gGmeYmbXUgwSdviasdnBgBU60uTTj9aq17FHuaJooEI2BsLn2dA1M7qihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103462; c=relaxed/simple;
	bh=3NxDkscihvOMXUatkmnZ5KCQ7n44ImwWEn7+zoox+ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYRQtBL63Ls09ivB5YaFjRipMlhJ9ebHCo4Umy5EP+UVzhRD+81YlJB3BjDZr4B6lwNzEdf6Fb7aFPc2/7+QcySkSj6NeJXI8n20taMVw11IiDTtB5Evd6N6zz6EOcniB4Ot+n1r0OLRDT6D7vvOtYerk5HBnASLVHt7pYi2xI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=vJ8Ua994; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358eac0571aso411480a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772103460; x=1772708260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcwgeJihxUHf/G70RUA2Nf6KlE2/AnZU2vplC1gEXXk=;
        b=vJ8Ua994lLJrsnVFd2RTtxYzVz/6fRuYFyEcGDKT5YdspNTIq3URZ6IwzFVKnBMeVZ
         WUEVp/ycjkuynA9sFdrePDEs1/L+H5+oS0n/jjkEUfX3RO9HP+uHeKc8FcvHGbJiHJwP
         t63+R4UGJ0JMDQUsShC/IVq84Ql/xA24anhnLpREjowZE7bd/CX79sja4hwtUHwFWw/l
         vzBJ0wodVAqYYNDflEb8v+3mfPmcpj0NbXzvGVt0lAA9edYsy5VZT8HRrS9ao/T/eKeJ
         tJnRqjRMo2/DqVKYXuoWulN3uFLAMthqF++/mlwpVbS5cQqdThmu0YIsBYxrjjOjS9C4
         /RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772103460; x=1772708260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcwgeJihxUHf/G70RUA2Nf6KlE2/AnZU2vplC1gEXXk=;
        b=dgUofZ8MKiRzTZTyoY0Akx8P/1sSYDhL/eaNjD71huPc2IMI/p9La2j/Ec+fx2DNqg
         Rugpew/ZwgETAw1eVuS+AR5f2U0PetdBKX7s99w6e37jEGEHHXKVFEMKkxGYrDe56ROy
         HxTy2/zQU4Ouz6v2qDhB3/Hc7yuzXLNazXYG1gLqFB8VrtJj4pNFLx+8NOmLSQyOMzBd
         5HGuBoknoEww/mXrK4/60I1bc1aRbjz6L+ZTPXaWXkIk2sZqSpUjvr+tod7bh3vNZrxg
         yvRvSpZkVun426AzpxXuHngpLJQ/IOdfL521p6QLAtM20wrcOryW7U2EqDrvd/kV3zIj
         Phig==
X-Forwarded-Encrypted: i=1; AJvYcCVtNBZr+RyT1MPyvDJMfidUSIJA7Wurfln1wRGcLNzKjfDAtcfIsaN7nU8dRT9HhsDKOx1BAge9C13IM9e3vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFeFqFRYwS0/Waytu8GWK7Xz8kSzIvgLiTBxE46z6wmLK9P8U
	Xu5PQSoSjaU8PYLC3n7MUGIqH+nZENr3pk431TnPSyHc5GkcG6bOUolvbDcFsMJkjyc=
X-Gm-Gg: ATEYQzw1L+TtaPTT4KKZ/e3aTn25J5LX4apnFO55RMtCsFizvoBN1Wpx9a3syHauJTE
	dOm6NbfuAUHaKRwrh7MKyB9DcQW6qp9GU1JmOwLNu66DBR8QnssfE/UCqpkbQiuTRLbBTMiANZ4
	Bf6zsKtFmzi/SoM9MLL20POAvpOYxu5xS4O5bHwMu+i7qTI2LH4ykrINuFfV1Vry2LGOsLPo2Lz
	zrZQNmOfoiKlEUEoRtsrXGkL7jAsTXgmJxOt1gYqHyLGQ+qV9lYhxAy3HsyX+IUOxT3eGQ3tAgQ
	hjRRuyugYz8zw0sNB73hR2j1xe0jzt/2WjUaQrCkxk9XhkN0/yQ+UGwqLqegORu9V/L77qNa8kM
	JDlVo7r6H2toqzTpby8MJaEgYo9Vvh9nmVC4kXbRu3kzLso1piyY4WmUylgesu/dONM3WoBRGhf
	8v6QMdfh9a36pd3KKKhMlllt8BKWpm2ySUufG12U1uRSwD+JHtIxuTdLlpQgH19oFD
X-Received: by 2002:a17:90a:c88e:b0:359:dd9:3de7 with SMTP id 98e67ed59e1d1-35928a44ae4mr2996335a91.4.1772103460059;
        Thu, 26 Feb 2026 02:57:40 -0800 (PST)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359019780bfsm5739988a91.8.2026.02.26.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:57:39 -0800 (PST)
Date: Thu, 26 Feb 2026 21:57:35 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: kexinsun <kexinsun@smail.nju.edu.cn>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg, 
	ratnadiraw@smu.edu.sg
Subject: Re: [PATCH] mac80211: update outdated comment
Message-ID: <b6tb5zvgfnu2tbttnd6fqlnwkvj2lzgoiwl4wz7urobdeptivs@xiefjb2zch4r>
References: <20260224021548.1394-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224021548.1394-1-kexinsun@smail.nju.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[nju.edu.cn:query timed out];
	TAGGED_FROM(0.00)[bounces-32204-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmane.org:url]
X-Rspamd-Queue-Id: ED5F31A4C12
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:15:48AM +0800, kexinsun wrote:
> The function ieee80211_start_scan() was refactored and replaced by
> __ieee80211_start_scan() in commit f3b85252f081 ("mac80211: fix scan
> races and rework scanning"). Update the comment in
> ieee80211_tx_h_check_assoc() accordingly.
> 
> Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
> ---
>  net/mac80211/tx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 8cdbd417d7be..85c48b42474c 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -288,7 +288,7 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
>  		 * sent and we should not get here, but if we do
>  		 * nonetheless, drop them to avoid sending them
>  		 * off-channel. See the link below and
> -		 * ieee80211_start_scan() for more.
> +		 * __ieee80211_start_scan() for more.
>  		 *
>  		 * http://article.gmane.org/gmane.linux.kernel.wireless.general/30089

Might be good to remove that link aswell and update the comment? Looks
to be dead.

lachlan 

