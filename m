Return-Path: <linux-wireless+bounces-31189-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCreIeq6d2lGkgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31189-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 20:05:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E668F8C525
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 20:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6F92301ECED
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD77D26C3B0;
	Mon, 26 Jan 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="SfIAqbMK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC720DD51
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454310; cv=none; b=CWVqC4Wlg0ATYbHedew/WIq93rwaBe6T9gQn2kDkr/wC/nztnNJ5mk/9yo61UYWcfq5+9Ywviq64WJW9YEWMXPdWwrZ9yejtddWhqLtFrQsArobDj6BKVvw9gneL38EW0zz26v/P+mXS5GeU+1T8Jc+ZPeQk+BSWSIJX8iDV4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454310; c=relaxed/simple;
	bh=ISwfiZV+569oavEMCy+PKDe/jP1ltI/Gghhxnp1Sbzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1miXmuWbPaZanITOOSNbVm+qnzkPvlhVWxuGXRvUapWnimhvvTQQ075PF0BOgm04D9MToP35h8GM9/Af5gSqSsBwtmILV7P1VooaJdD2wI2aQjMaqwMfvHRQVTjWVWsSnBX199CPMxDuAupkZu1uTBKRVBaYaUcG78POm8ix7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=SfIAqbMK; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30448 invoked from network); 26 Jan 2026 19:58:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1769453905; bh=kNsj8Fgky6FtKSyLbdUOoMJtwa05zl8L1fX74F6ambw=;
          h=From:To:Cc:Subject;
          b=SfIAqbMKjY31PYRV7HC/yDVtdEeib5nk58hvBwIHuuEhaXseK1le+bViz2rll00Qa
           s3MdXUyGhxo01R/5aiKaioEA9F89i5CMAoDSvEC22Yx3pc3YKmId1FBKeU+Pd0iOZq
           5m7LYpeMNleZjkBGF//OXuqnUbna15Ojt2REikhaiVW65hWc1SkcxDW+j+TfcrP0zM
           DSMqDalqs/i1hPGqb4OZHnpRIrN8c3tMXJBnV4UEjDqCKgIAEiFlDKAu670GNebIe8
           7QKRS1/8c7Vb7DIDsaEFYrWVQrGiHvbFoJgHbQ52rR5i7meiZ3Mg+3PsKs39y3Ytcp
           rtVD0ReBLOJOQ==
Received: from 89-64-9-58.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <n7l8m4@u.northwestern.edu>; 26 Jan 2026 19:58:25 +0100
Date: Mon, 26 Jan 2026 19:58:25 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: add missing mutex protection in
 il3945_store_measurement()
Message-ID: <20260126185825.GA6968@wp.pl>
References: <20260125193005.1090429-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125193005.1090429-1-n7l8m4@u.northwestern.edu>
X-WP-MailID: f4a42d53676d6f6374878adfd62a66bc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [AZIx]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31189-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[wp.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:email,wp.pl:dkim,wp.pl:mid,northwestern.edu:email]
X-Rspamd-Queue-Id: E668F8C525
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 07:30:05PM +0000, Ziyi Guo wrote:
> il3945_store_measurement() calls il3945_get_measurement() which internally
> calls il_send_cmd_sync() without holding il->mutex. However,
> il_send_cmd_sync() has lockdep_assert_held(&il->mutex) indicating that
> callers must hold this lock.
> 
> Other sysfs store functions in the same file properly acquire the mutex:
> - il3945_store_flags() acquires mutex at 3945-mac.c:3110
> - il3945_store_filter_flags() acquires mutex at 3945-mac.c:3144
> 
> Add mutex_lock()/mutex_unlock() around the il3945_get_measurement() call
> in the sysfs store function to fix the missing lock protection.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index 104748fcdc33..54991f31c52c 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -3224,7 +3224,9 @@ il3945_store_measurement(struct device *d, struct device_attribute *attr,
>  
>  	D_INFO("Invoking measurement of type %d on " "channel %d (for '%s')\n",
>  	       type, params.channel, buf);
> +	mutex_lock(&il->mutex);
>  	il3945_get_measurement(il, &params, type);
> +	mutex_unlock(&il->mutex);
>  
>  	return count;
>  }
> -- 
> 2.34.1
> 

