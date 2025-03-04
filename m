Return-Path: <linux-wireless+bounces-19771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FBFA4E7FC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D001898816
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B01292FB5;
	Tue,  4 Mar 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="F20UWdmX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A568292F8B
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106661; cv=none; b=NumfWV0xVu55wraXAzcx+SClQ5Papn5fsE2MhwkOeOk3IINNSga+S0BXUYTzcMRCVmjtV+6PBY/dEHR84Z5+eFcs3rv7lvOi3kCFEsAEnJKULBGSfmmtOstgQhTzXL9PTlWIz3bNROySQay7KkK9B75uUDW9uszoqa9knzUDBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106661; c=relaxed/simple;
	bh=guJBGzO1Eha8HKDWqHhA8DOn1M/7asKrN5QKZ8a9S/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syPZrbtR8Q1bt3Euzi4DbEYyEE1Fypr32kY1qXjuGzZPvMC7hVHlg2AQ6vQ3igzOd8L6DYV1d0qzcZtzFD7A59LgzSr0+i5hWxT8eq/k/Q7J+nTY8yIt6/Gu+5Ho/DK/Y8qQ6ySNwM9kWMRXwDtdrUSAbjeyzdJLqtcZZlaT5qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=F20UWdmX; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 37206 invoked from network); 4 Mar 2025 17:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1741106648; bh=C5H8MPAgBlTLIuqQ/Qmct0NSdBHozxJNJSqyQOSH4rE=;
          h=From:To:Cc:Subject;
          b=F20UWdmX0fzyD7DH6Tk+FbkxEP9fwGqZT5bVw1CJKXvp8+iQgHW1hX++YI1Qkr1S1
           us8+PuXP5jKFx8eFPq7sxZpxnCRDcrZqqoPlhazFPfr9EyTP3Pe8SZUQBZZrWyYj91
           VwwTejvKtAstp3XE8rH4Xe2NTPlJIR2M3M8X8dhExZ1STjkuD+EVD6pfVjsNxLOIS6
           dwdgJxfJxRrMMfGv1tQ8jEy7k9OpH+I2/Vb/+xNO7YD57AMYsOCSlCqIGYcXFBduTI
           Hce2kTUdQRAy/bMzBZVsrjCXThkWcxFbsCC1WBw3xTxnY3Q1XFsnCrfUUJNqKIyati
           5aHIERV2VPPjg==
Received: from 89-64-3-211.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.211])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <vulab@iscas.ac.cn>; 4 Mar 2025 17:44:07 +0100
Date: Tue, 4 Mar 2025 17:44:07 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlegacy/4965: Cancel deferred work on device init
 failure
Message-ID: <20250304164407.GB67578@wp.pl>
References: <20250304031603.1989-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304031603.1989-1-vulab@iscas.ac.cn>
X-WP-MailID: d28b2ad49f0eaad49278b304ef4372e6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YUPU]                               

Hi

On Tue, Mar 04, 2025 at 11:16:03AM +0800, Wentao Liang wrote:
> In __il4965_up(), deferred work is not canceled in time when device
> initialization fails. This is harmless if the device has not started.
> However, in il4965_bg_restart(), if the device remains operational
> in any state other than S_FW_ERROR or S_EXIT_PENDING, a dereference
> operation needs to be performed when __il4965_up() fails.
>
> Add il4965_cancel_deferred_work() to the failure path of
> __il4965_up() to prevent potential errors. Even if the current code
> does not exhibit the described issues, adding this change can prevent
> future problems at minimal cost, improving the robustness of the code.

I think preventing potential future problems in this legacy driver
is not necessary since the driver will not be developed further.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index 05c4af41bdb9..3b21bd79f3a9 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -5591,6 +5591,8 @@ __il4965_up(struct il_priv *il)
>  	__il4965_down(il);
>  	clear_bit(S_EXIT_PENDING, &il->status);
>  
> +	il4965_cancel_deferred_work(il);

We can not cancel here as we have il->mutex locked, it will
deadlock in case of some pending work that holds the mutex.

>  	/* tried to restart and config the device for as long as our
>  	 * patience could withstand */
>  	IL_ERR("Unable to initialize device after %d attempts.\n", i);
> -- 
> 2.42.0.windows.2
> 

