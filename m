Return-Path: <linux-wireless+bounces-24093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A818AD92B6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498C317DF24
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1603BB48;
	Fri, 13 Jun 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="RjF8sb8C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE731A4F12
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831522; cv=none; b=ceagTU6JY4Q3Dq3I6by+pLKymEvemYwpT5pyVrERtJE2e9DVOSsQpZ+AzEfovGgXB0BLg/Tz75suIki+KyGU2skYrGZBlhJ+l4BtLlPh0C4tiFWfIfn4kYSlf3Eu+N2wocoH5ohje8EkIKXaulsLD7boOlD4/6omL2+NWowjpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831522; c=relaxed/simple;
	bh=roc1nCKlU6+zFLiSIX/Jhl/yRTEwG8T8BaH8kRNG7Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoCDi5ipgWwwCqKtzPnTOFRd/tuKI5bv+BdTY/XsKXavd68gnAGS+RrPb1gcxYZLCrSGRzFC/px8rdQbAydpd4BZl7yeS2pqYnixXh9Ll2wmcrJ1lHxfPRF3B8AB1qSnz/M4ycAo171FacYCKPXqhsfd1eO+C7+vrEd+3BjF1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=RjF8sb8C; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 25465 invoked from network); 13 Jun 2025 18:11:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1749831112; bh=pQ8jSxcfR6n8gUoPxMTzQFYregg2HENhHGC+FgDSA2o=;
          h=From:To:Cc:Subject;
          b=RjF8sb8CrbdHhCC6jDD9N7HMHFV5isWVNKCOTeUPxLqKKbrDDvuy2lywNs3KZueX5
           AngMFD65LIXZU2CDnQqMj+/CofqapTbbJsAj/vwSEIzqSpB/t4wxzXpA3WUNDiNI24
           pqrW0a8f7ltcbJtx+e+IhOR94DASfoedAiNQR0kLLHuPcKxkc2lhElzAf4aQ/0E4Fu
           6zQ7hhPFsWWNOpCAveQjXSj4jUWac/G6CvtF1hlQ52/ukeQkNIlmK/x+E8G1CTB4p3
           EraebbWEmF4TYdfnsfOfFpAv4Iu7kyGrO++t7RTqogDZAlnZoRe+DBDcz3fuF2QxtA
           U0NVtm2hM8z6A==
Received: from 89-64-3-149.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.149])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <liyuesong@vivo.com>; 13 Jun 2025 18:11:52 +0200
Date: Fri, 13 Jun 2025 18:11:51 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Yuesong Li <liyuesong@vivo.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] wifi: iwlegacy: convert to use secs_to_jiffies()
Message-ID: <20250613161151.GA205720@wp.pl>
References: <20250612021446.3465972-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612021446.3465972-1-liyuesong@vivo.com>
X-WP-MailID: d62c7ddc87a6b367d150880345504c38
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [keMB]                               

On Thu, Jun 12, 2025 at 10:14:44AM +0800, Yuesong Li wrote:
> Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
> use it to avoid scaling the time to msec.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index 8e58e97a148f..24a39a968db0 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -1382,7 +1382,7 @@ il4965_hdl_stats(struct il_priv *il, struct il_rx_buf *rxb)
>  	 * we get a thermal update even if the uCode doesn't give us one
>  	 */
>  	mod_timer(&il->stats_periodic,
> -		  jiffies + msecs_to_jiffies(recalib_seconds * 1000));
> +		  jiffies + secs_to_jiffies(recalib_seconds));
>  
>  	if (unlikely(!test_bit(S_SCANNING, &il->status)) &&
>  	    (pkt->hdr.cmd == N_STATS)) {
> -- 
> 2.34.1
> 

