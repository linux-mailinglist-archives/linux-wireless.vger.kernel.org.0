Return-Path: <linux-wireless+bounces-764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1D811FAB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 21:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DD01C2040D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9577624;
	Wed, 13 Dec 2023 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="KOjQTqgA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F1C9
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:06:20 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 42379 invoked from network); 13 Dec 2023 21:06:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1702497977; bh=oYqT+z3zv+88VX7/KyR98U20ZSfEL2KkqJKJNS04oJc=;
          h=From:To:Cc:Subject;
          b=KOjQTqgAILsY/CFqVWa2OhiEcou6fDfpoM7vzWafunMYhjokmbcx10MFw8mnsh7gv
           C0/N/ldXW+gjFl/5VYxsbvrK22dfCnfpgzOdxKKFV2mcDJKWd2oSbfmN6dxcXrFrVa
           Rl8FTpO2ctnOFkWPNdT4HFBjvoruIXTKGcAbj8JI=
Received: from 89-64-13-61.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.61])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <dmantipov@yandex.ru>; 13 Dec 2023 21:06:17 +0100
Date: Wed, 13 Dec 2023 21:06:16 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, lvc-project@linuxtesting.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] [v2] wifi: rt2x00: remove useless code in
 rt2x00queue_create_tx_descriptor()
Message-ID: <20231213200616.GA63361@wp.pl>
References: <87il53nvqc.fsf@kernel.org>
 <20231213051449.126963-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213051449.126963-1-dmantipov@yandex.ru>
X-WP-MailID: a391f45dd210ab3d53d92b195197980f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gTNw]                               

On Wed, Dec 13, 2023 at 08:14:43AM +0300, Dmitry Antipov wrote:
> In 'rt2x00queue_create_tx_descriptor()', there is no need to call
> 'ieee80211_get_rts_cts_rate()' while checking for RTS/CTS frame
> since this function returns NULL or pointer to internal bitrate
> table entry, and the return value is not actually used. Compile
> tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: avoid scoped locals (Kalle Valo)
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00queue.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
> index 98df0aef8168..013003777fee 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
> @@ -416,9 +416,6 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
>  			__set_bit(ENTRY_TXD_RTS_FRAME, &txdesc->flags);
>  		else
>  			__set_bit(ENTRY_TXD_CTS_FRAME, &txdesc->flags);
> -		if (tx_info->control.rts_cts_rate_idx >= 0)
> -			rate =
> -			    ieee80211_get_rts_cts_rate(rt2x00dev->hw, tx_info);
>  	}
So we do not choose rate for RTS/CTS. Maybe we should actually,
but the patch does not change the logic that exist here for 
more than 12 years, since

commit 55b585e29095ce64900b6192aadf399fa007161e
Author: Helmut Schaa <helmut.schaa@googlemail.com>
Date:   Thu Mar 3 19:43:49 2011 +0100

    rt2x00: Don't call ieee80211_get_tx_rate for MCS rates

I'm ok with the patch.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks
Stanislaw

