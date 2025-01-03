Return-Path: <linux-wireless+bounces-17034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B0FA0066E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 10:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6671B7A028D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548311CB9EB;
	Fri,  3 Jan 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="MEkda1B5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377B1BD014
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895148; cv=none; b=FI9DgaEw9471GPN6aZURE0YGN2ajmlWjLse8eOZ3/9OHQpFyJ0h8r/8aoEzGur34lGkMJQH/lSOEBpwjBw64xnaUd2WpzFkg1eUSu3rzwesqwf7XjVoIvgNMXXwnyZ6CAVeoG0eP99JZGexcL1WFyTGkbtkxQrfnh/CYMLZI7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895148; c=relaxed/simple;
	bh=IWStqOLiqkHqwe0N8VdpyJocyJDJ2sjAddYJkF8iYHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOpcjw4/EFQyMfeFitMj8kp1rpZg+u1Jxx6ONgPFbPnGcInlnUbDfXg5hoSNY8+z+LwSdm7R+l4vJgEUEUcQRftrExcQ5K8o8Z/1aN4MY4FbStPYoUOYtjD6uuCtsBwVYMssiapFhvAnqwvVLqFBtnYNaDqqx3PCP9wPmGqgiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=MEkda1B5; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 22532 invoked from network); 3 Jan 2025 09:59:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1735894743; bh=twUetRoZ+cMl0c+AVb9dbaaAwMQbIG231VDTgAbVxuk=;
          h=From:To:Cc:Subject;
          b=MEkda1B5gPjNj7ww7BdPqjOKXkS2CDIvi/PFGyzNDimIKi8c2vWMLl2+XBvQJNi9q
           QcuGfGsi9q9Wfp01XxBMeHW+JhVJ7D3WRwa/hyG3qfhKFps2LI8zA64uHGfl/CQyQ/
           Yrnp+A6ITUgKDf2hTK9NZY1C6FYBXDPpfaOPMOgfnzLdGCQYeQwF5wdL4Chp/avssC
           fgy+i06bnKVfA96t1+qbbzatwLLleFfzCvHRjscBOuatqOhlqhyI6lP4h+j1+0ChVG
           b3x8umZA/EmQViQt3w5uUqRuA5QnhXllxrylZhx32vl23x5tXezxVhywezq/vUhUYS
           g+AqVk9SX60XA==
Received: from 89-64-0-140.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.0.140])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux@treblig.org>; 3 Jan 2025 09:59:03 +0100
Date: Fri, 3 Jan 2025 09:59:02 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: linux@treblig.org
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: iwlegacy: Remove unused
 il3945_calc_db_from_ratio
Message-ID: <20250103085902.GB94204@wp.pl>
References: <20241226011355.135417-1-linux@treblig.org>
 <20241226011355.135417-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226011355.135417-2-linux@treblig.org>
X-WP-MailID: 01fcfec198de8c3d899381c49c48f3fe
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [cZOE]                               

On Thu, Dec 26, 2024 at 01:13:54AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of il3945_calc_db_from_ratio() was removed in 2010 by
> commit ed1b6e99b5e6 ("iwlwifi: remove noise reporting")
> when it was still called iwl3945_calc_db_from_ratio().
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  .../net/wireless/intel/iwlegacy/3945-mac.c    | 38 -------------------
>  drivers/net/wireless/intel/iwlegacy/3945.h    |  1 -
>  2 files changed, 39 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index 74fc76c00ebc..4013443698a2 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -1127,44 +1127,6 @@ il3945_rx_queue_free(struct il_priv *il, struct il_rx_queue *rxq)
>  	rxq->rb_stts = NULL;
>  }
>  
> -/* Convert linear signal-to-noise ratio into dB */
> -static u8 ratio2dB[100] = {
> -/*	 0   1   2   3   4   5   6   7   8   9 */
> -	0, 0, 6, 10, 12, 14, 16, 17, 18, 19,	/* 00 - 09 */
> -	20, 21, 22, 22, 23, 23, 24, 25, 26, 26,	/* 10 - 19 */
> -	26, 26, 26, 27, 27, 28, 28, 28, 29, 29,	/* 20 - 29 */
> -	29, 30, 30, 30, 31, 31, 31, 31, 32, 32,	/* 30 - 39 */
> -	32, 32, 32, 33, 33, 33, 33, 33, 34, 34,	/* 40 - 49 */
> -	34, 34, 34, 34, 35, 35, 35, 35, 35, 35,	/* 50 - 59 */
> -	36, 36, 36, 36, 36, 36, 36, 37, 37, 37,	/* 60 - 69 */
> -	37, 37, 37, 37, 37, 38, 38, 38, 38, 38,	/* 70 - 79 */
> -	38, 38, 38, 38, 38, 39, 39, 39, 39, 39,	/* 80 - 89 */
> -	39, 39, 39, 39, 39, 40, 40, 40, 40, 40	/* 90 - 99 */
> -};
> -
> -/* Calculates a relative dB value from a ratio of linear
> - *   (i.e. not dB) signal levels.
> - * Conversion assumes that levels are voltages (20*log), not powers (10*log). */
> -int
> -il3945_calc_db_from_ratio(int sig_ratio)
> -{
> -	/* 1000:1 or higher just report as 60 dB */
> -	if (sig_ratio >= 1000)
> -		return 60;
> -
> -	/* 100:1 or higher, divide by 10 and use table,
> -	 *   add 20 dB to make up for divide by 10 */
> -	if (sig_ratio >= 100)
> -		return 20 + (int)ratio2dB[sig_ratio / 10];
> -
> -	/* We shouldn't see this */
> -	if (sig_ratio < 1)
> -		return 0;
> -
> -	/* Use table for ratios 1:1 - 99:1 */
> -	return (int)ratio2dB[sig_ratio];
> -}
> -
>  /*
>   * il3945_rx_handle - Main entry function for receiving responses from uCode
>   *
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945.h b/drivers/net/wireless/intel/iwlegacy/3945.h
> index ffbe11902628..fb1e33c89d0e 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945.h
> +++ b/drivers/net/wireless/intel/iwlegacy/3945.h
> @@ -173,7 +173,6 @@ struct il3945_ibss_seq {
>   * for use by iwl-*.c
>   *
>   *****************************************************************************/
> -int il3945_calc_db_from_ratio(int sig_ratio);
>  void il3945_rx_replenish(void *data);
>  void il3945_rx_queue_reset(struct il_priv *il, struct il_rx_queue *rxq);
>  unsigned int il3945_fill_beacon_frame(struct il_priv *il,
> -- 
> 2.47.1
> 

