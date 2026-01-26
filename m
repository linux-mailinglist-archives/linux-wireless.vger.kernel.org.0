Return-Path: <linux-wireless+bounces-31188-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCLEBaS6d2lGkgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31188-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 20:04:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B558C516
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC93F300469E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB514245031;
	Mon, 26 Jan 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="G4jMWHkr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D526B755
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454238; cv=none; b=rJEI77CQ7eEfpMOosXp3wX8SMOlAAQhXvRz/IlChUcg3z0aS3ANjOxG0aECbS4M6CUP217DVznPppwkwxtQ7pRmHLcmZwelA1zD6cYLbFXaaAAHVHQU6GFLgU+Bx9epah+A4Wl6w9ew0V4aVlGIY2OyuoaOWmoHNPZr8ocWjp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454238; c=relaxed/simple;
	bh=ocSfGwCzmKEofvcqqj1LbB4+bRzelQlLPMY9yJqjuhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxPlkfzQhkvA/LNFkWJAxi/l0me3tc/9eofXZn52SyuoVK8m7J2HmAX7pNiJAHmccUjNx/dlPdzTWROUv6KCIqOe3Zgi59C8SztrqT36UhnBGydueos5+eNCpqijSjG5rpy3TjdlbyL66JaUzLb9w8PpJye1CZMWxyCpPx4ILG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=G4jMWHkr; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 31748 invoked from network); 26 Jan 2026 20:03:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1769454233; bh=69YQQXyzuTdrQ4ARHO724FsLS4A2M7o6h/attti+jU0=;
          h=From:To:Cc:Subject;
          b=G4jMWHkr2sYvRH76xm2pV9y0C4ZIIGiBSCpqzOWZXuXQrA4CEzZ0xOdtobijbnCZB
           ptBARVQeCkBp/jPq1pvzjm7GHY+FNtEfKg8uYQT/ZW5+irJbX8eddq79NEaUmrfoSQ
           LUXOL1lCojHx4T0ZX6KvdYVhZEKvZx1xzwIDF8S0pUcT6DTka9itfcxcn+KyElNP53
           Lu7lE7Crs3O3lYGH/7nN9at+3hp/ieZ4xZthBXlsyLR93XB8sAX84RlCb+Jg/ufSOr
           cDvJcgNOM7wSraRIva2Ou7prjZisAzVwiutYfo1VNNjVTItWHQVTamoujV4Yvt4Zd0
           EX8+btsudNw9g==
Received: from 89-64-9-58.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <n7l8m4@u.northwestern.edu>; 26 Jan 2026 20:03:52 +0100
Date: Mon, 26 Jan 2026 20:03:52 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: add missing mutex protection in
 il4965_store_tx_power()
Message-ID: <20260126190352.GB6968@wp.pl>
References: <20260125194039.1196488-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125194039.1196488-1-n7l8m4@u.northwestern.edu>
X-WP-MailID: b85706ce12ebc2c740674542934f4a1b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [UWIR]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31188-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[wp.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42B558C516
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 07:40:39PM +0000, Ziyi Guo wrote:
> il4965_store_tx_power() calls il_set_tx_power() without holding il->mutex.
> However, il_set_tx_power() has lockdep_assert_held(&il->mutex) indicating
> that callers must hold this lock.
> 
> All other callers of il_set_tx_power() properly acquire the mutex:
> - il_bg_scan_completed() acquires mutex at common.c:1683
> - il_mac_config() acquires mutex at common.c:5006
> - il3945_commit_rxon() and il4965_commit_rxon() are called via work
>   queues that hold the mutex (like il4965_bg_alive_start)
> 
> Add mutex_lock()/mutex_unlock() around the il_set_tx_power() call in
> the sysfs store function to fix the missing lock protection.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index 3588dec75ebd..57fa866efd9f 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -4606,7 +4606,9 @@ il4965_store_tx_power(struct device *d, struct device_attribute *attr,
>  	if (ret)
>  		IL_INFO("%s is not in decimal form.\n", buf);
>  	else {
> +		mutex_lock(&il->mutex);
>  		ret = il_set_tx_power(il, val, false);
> +		mutex_unlock(&il->mutex);
>  		if (ret)
>  			IL_ERR("failed setting tx power (0x%08x).\n", ret);
>  		else
> -- 
> 2.34.1
> 

