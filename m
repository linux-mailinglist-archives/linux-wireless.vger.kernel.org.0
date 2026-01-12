Return-Path: <linux-wireless+bounces-30672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C028D10C7B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F80630376BA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492A329385;
	Mon, 12 Jan 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="c3cVo4EX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F797328B6E
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201406; cv=none; b=kRA395frQzIBmkCrKLz/YqEDJGaLZYq5coU9bX+h8eOrwB4pDNmT4ODxyUkzZ5rXix8CVOaEbjkHdv7mBJnBWcbvsWmKroJhjVsoy8Ps+vaPcAWiIjTUTggrSbJzrIT6X2esnnQZat097rtaF79K8AESLOcIsViA0+6WYoyjRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201406; c=relaxed/simple;
	bh=wPOu1kdWdb9fj+mX+btu+5OChC2EVoxqPwOqEYCop0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FslBHM8IaptljB8clwThulnvgGBzgLQyMqEpdoa/ctRMtvgJxBgljzrnXIdJZt7/v3EqjSfWSCMRD/pjfO7EeZLZnIXSXtdM7h3QJX22S5UM3aYXlg4gv7vfG4ULOp9WX6ONrm3nrZHrQO6MHE3rGPCVc+AmasiyWDeRmA50ovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=c3cVo4EX; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 47324 invoked from network); 12 Jan 2026 08:03:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1768201399; bh=Ob480tGmLGwyzhgY92QflQS5aJMv1RupCem8tVO6mgo=;
          h=From:To:Cc:Subject;
          b=c3cVo4EX4uZeB+G/udmyw1M4XW1xvIGexHbrOobfS9uE/jdOgMQLV9l+PcJrXG++Y
           lEkhyvXfTXApAB5fKpCV+nOinFqCAnpMNPV+9HLEwGvWxrIkgDRObrbIUxz4ZwkPpO
           o+gll1JNXuAf3jeS9+7yYVk3Lx+OiJIDpawFVyw/HtrKJEbQ7TQdwvd62qqduXXjJW
           uMpPAIQcpfVz02h8bwS2mfY69/jYRUpqOrHpzR/lbtTqBXav9s9+W74qp9k3siFBe7
           f2vDohIH2/OXwpw8IDmdtBzscTcrMkNoJ8JpLRSnvS8oMz0IPKmmZF8+bZrlmxNhb9
           8v0e3cKRCgUeg==
Received: from 89-64-3-243.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.243])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <islituo@gmail.com>; 12 Jan 2026 08:03:19 +0100
Date: Mon, 12 Jan 2026 08:03:19 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] wifi: iwlegacy: 3945-rs: remove redundant pointer
 check in il3945_rs_tx_status() and il3945_rs_get_rate()
Message-ID: <20260112070319.GA115711@wp.pl>
References: <20260111171118.203249-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111171118.203249-1-islituo@gmail.com>
X-WP-MailID: ce195a2f2e1c31c56d3a10f6de6f0cf3
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [QUDx]                               

On Mon, Jan 12, 2026 at 01:11:18AM +0800, Tuo Li wrote:
> The variable il_sta passed into these two functions cannot be NULL, so
> remove the related null checks.
> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks
Stanislaw
> ---
> v4:
> * Remove the redundant NULL check instead of using WARN_ON_ONCE(), and
>   update the subject accordingly.
>   Thanks to Stanislaw Gruszka for helpful advice.
> v3:
> * Replace plain NULL check with WARN_ON_ONCE() and update subject to better
>   reflect defensive nature of the check.
>   Thanks to Johannes Berg and Stanislaw Gruszka for helpful advice.
> v2:
> * Return early for uninitialized STA il data and align D_RATE messages with
>   il3945_rs_tx_status(). Add a wifi: prefix to the patch title.
>   Thanks to Stanislaw Gruszka for the helpful advice.
> ---
>  drivers/net/wireless/intel/iwlegacy/3945-rs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> index 1826c37c090c..ecc6c8d2a4c5 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> @@ -448,11 +448,6 @@ il3945_rs_tx_status(void *il_rate, struct ieee80211_supported_band *sband,
>  		return;
>  	}
>  
> -	if (!il_sta) {
> -		D_RATE("leave: No STA il data to update!\n");
> -		return;
> -	}
> -
>  	/* Treat uninitialized rate scaling data same as non-existing. */
>  	if (!rs_sta->il) {
>  		D_RATE("leave: STA il data uninitialized!\n");
> @@ -627,7 +622,7 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
>  	D_RATE("enter\n");
>  
>  	/* Treat uninitialized rate scaling data same as non-existing. */
> -	if (rs_sta && !rs_sta->il) {
> +	if (!rs_sta->il) {
>  		D_RATE("Rate scaling information not initialized yet.\n");
>  		il_sta = NULL;
>  	}
> -- 
> 2.43.0
> 

