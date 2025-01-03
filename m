Return-Path: <linux-wireless+bounces-17037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C0A006DA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 10:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C125B3A2F9A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F861C2335;
	Fri,  3 Jan 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="J9ozDVkk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1ED1CEAD6
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896145; cv=none; b=S4SCdtd1qQh3jHmPKKzcFpDYlythpWTqT4ue9NOeZRX6M4KyDpgS+TLwSXH1D6cqnlTiSnPoMMJsgkKH/3MaCZLHw2TcC630lBFoH6vnfsigt5IFkVtBTQypOJyIGZC9kcbvLssmSggUAhCSQkpfP9gHlk9iZ3ZNlBbWBiCGW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896145; c=relaxed/simple;
	bh=CtpIcZ+uMgp832pH13wtr03ahZTx/KGoTuQTpC1vyBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH74u+/E22IHXGZ4PM4HXPy3lMhc13r2EVW39tXdO48udpd74Jjfqhhq2UdqOKLBdf0Ksa6ogKIBt2ifiu66CheUju5KrVGR9nbvOOtYsdQt78eGewWRThx3J4k0Zb86O46NmzXThTjL/dh+zwEbsbTwqOLzE0kz+lj3mZBKC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=J9ozDVkk; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 9744 invoked from network); 3 Jan 2025 09:55:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1735894541; bh=kR8u14G55mBiCvnHB6XuasmXPZ+aNP3XsvXhAil8rPw=;
          h=From:To:Cc:Subject;
          b=J9ozDVkk4KHNttDggHRV9979z02xHORMkpWeqz1XVdTzQUXm1d2HScRCKev0zr01I
           Z1wGCkYilM9StMyOCkGElIDYrG1MfK4qgWtGqFqrs6tUNScd7lD+7cBTj1B8yYPQMG
           DQc+RlcVFTNZIIMzKw3dIdkzGjP1kvPVGii7vhTy5pVXbRVL93FA9O/bw2aZqGGJE4
           JpytIgQ+VIEpSH3GNfzAUyApabsOW4vtngbW0oPBWCM8U1ClLr5wQoVpoOyL3+mP74
           AfZYw9WBKCWVfJ5GDsaF1tQ4EDqvxVxLoUIQF/lPc90Q7a0Qz6M9JtpwMFcCCjkekd
           O1Sc5V1k7et6Q==
Received: from 89-64-0-140.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.0.140])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <ariel.otilibili-anieli@eurecom.fr>; 3 Jan 2025 09:55:41 +0100
Date: Fri, 3 Jan 2025 09:55:40 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH 1/2] rt2x00: Remove unusued value
Message-ID: <20250103085540.GA94204@wp.pl>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
X-WP-MailID: cc7567f25501454dd1d5e2b154d29223
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kQMk]                               

On Sat, Dec 21, 2024 at 01:39:32PM +0100, Ariel Otilibili wrote:
> Coverity-ID: 1525307
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index 60c2a12e9d5e..e5f553a1ea24 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -8882,13 +8882,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
>  
>  	for (ch_idx = 0; ch_idx < 2; ch_idx = ch_idx + 1) {
>  		if (ch_idx == 0) {
> -			rfval = rfb0r1 & (~0x3);
>  			rfval = rfb0r1 | 0x1;

I wonder if intention here was different, for example:

 			rfval = rfb0r1 & (~0x3);
  			rfval = rfval | 0x1;

For me the patch looks ok - it does not change existing behaviour,
since rfval is overwritten by second line anyway.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

But Tomislav and Daniel, please check if this code is correct.

>  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
> -			rfval = rfb0r2 & (~0x33);
>  			rfval = rfb0r2 | 0x11;
>  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
> -			rfval = rfb0r42 & (~0x50);
>  			rfval = rfb0r42 | 0x10;
>  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
>  
> @@ -8901,13 +8898,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
>  
>  			rt2800_bbp_dcoc_write(rt2x00dev, 1, 0x00);
>  		} else {
> -			rfval = rfb0r1 & (~0x3);
>  			rfval = rfb0r1 | 0x2;
>  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
> -			rfval = rfb0r2 & (~0x33);
>  			rfval = rfb0r2 | 0x22;
>  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
> -			rfval = rfb0r42 & (~0x50);
>  			rfval = rfb0r42 | 0x40;
>  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
>  
> -- 
> 2.47.1
> 

