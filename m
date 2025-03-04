Return-Path: <linux-wireless+bounces-19770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C688A4E6FF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F5D189EC44
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88A205E0D;
	Tue,  4 Mar 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="bLTIdQEm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AC25F997
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105525; cv=none; b=qUCTb20zj8BbnGen6mgW/9oymBP5LfxjJCoPCb2fQJiw0TTMx9KZCqf+BsVcg39ssosqiRQWOb2OSkevnliIskpSF6FSBFyd+RSzP5RlNsFT4CZg+VnghMeSD0r/2PeRzE9zwkKE3//eqxrOKzmYIXJdN3sp/i20pNvNk30Xe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105525; c=relaxed/simple;
	bh=bPuiev1Lj/xPqCqcLWdPqKYecCN/NiFoBvd8HHeacFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO5oVHJR1NWir/ecH2pvWb55YAStx+0rn8Qzix9RpVtVjGVi5It69LD2LTN9fCFzCIJKcndxXeNYOln6nEcC5ShoRMMIOY1GE8BAzeNvBFOOvgP8BnwA3Cbvn2f9KFLp/6kbj6Rxu2i4LjYLtj/etYnJWkwBJPzeKwCtDVC3eRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=bLTIdQEm; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 41216 invoked from network); 4 Mar 2025 17:18:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1741105118; bh=YGaOD8qb+M12OOf2VHInJ5YTUjhilS5zhgPt44cDZ9U=;
          h=From:To:Cc:Subject;
          b=bLTIdQEmOvl6EUcI1VLNyMjC227FlQib2a5cM1ZwzhogjRMHWSFGUDDvGQzaEX4ow
           s1O8FLApZfTisOwIKrSJpRhXaP5kGQ3Tzgn9tq6jkzCpy+DRSDuEa35fZy+ftHVLLk
           pjFAUkuiafOqHEJcRT098RlCgmVDtB5y+SuPDWQyIgmlfKRTmz98CrxaKXo5ytpeRM
           0Rx/aJiTgYjlaLNybImt/H8WXrH4jaLDiXxNR0iqC6i9ZJ6Zxu5AmJnVXwcN7vTFtR
           q4Xf/zy6fjOk5QuzWrpbyMHOJKVL8Q5F8E9URoSEqKecquJ1OuVDlUfbZusQyUCpdZ
           uyUBR9EkLXzUw==
Received: from 89-64-3-211.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.211])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@kernel.org>; 4 Mar 2025 17:18:38 +0100
Date: Tue, 4 Mar 2025 17:18:39 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: avoid size increase
Message-ID: <20250304161839.GA67578@wp.pl>
References: <20250304144210.997531-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304144210.997531-1-arnd@kernel.org>
X-WP-MailID: 4aad8192ebf0d930be3400092d1eddae
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4XPU]                               

On Tue, Mar 04, 2025 at 03:42:07PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> My previous patch caused a slight code size increase when DEBUG_FS is disabled,
> as Stanislaw Gruszka pointed out.
> 
> Fix this with an added IS_ENABLED() check.
> 
> Fixes: cf6b9ba172dd ("wifi: iwlegacy: don't warn for unused variables with DEBUG_FS=n")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Ideally this would be folded into my original fix. If that's not possible,
> please apply on top.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

>  drivers/net/wireless/intel/iwlegacy/4965-rs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> index f754fb979546..0e5130d1fccd 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> @@ -2495,6 +2495,9 @@ il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
>  	u8 valid_tx_ant;
>  	u8 ant_sel_tx;
>  
> +	if (!IS_ENABLED(CONFIG_MAC80211_DEBUGFS))
> +		return;
> +
>  	il = lq_sta->drv;
>  	valid_tx_ant = il->hw_params.valid_tx_ant;
>  	if (lq_sta->dbg_fixed_rate) {
> -- 
> 2.39.5
> 

