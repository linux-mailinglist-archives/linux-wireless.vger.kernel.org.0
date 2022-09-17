Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FD85BB840
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIQMkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIQMkW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:40:22 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B825E97
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:40:21 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 30386 invoked from network); 17 Sep 2022 14:40:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663418419; bh=aKm/EaQNbfRNjKUeL6cxNlVfwTJRcDfQt/US7SpF3jQ=;
          h=From:To:Cc:Subject;
          b=fsN9+2QBFZQJ4jeXxCpVFgD0taJQ7UEEbXHho2e4hQnc7TH3ryIAtrw1ysQFMYEvl
           xCfpazNIkA8YsRVl3X/Vmz/AEe3zCDmkuKGk7KxuW4FgjAlqL8hLbgAoytdPkRUSUu
           7vJYM3+1Evp2V64qQfaQYq7quT/+PaQIliMepERU=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:40:19 +0200
Date:   Sat, 17 Sep 2022 14:40:18 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 08/15] rt2x00: don't run Rt5592 IQ calibration on MT7620
Message-ID: <20220917124018.GD17901@wp.pl>
References: <YyUBf3hPNZMgGFM6@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUBf3hPNZMgGFM6@makrotopia.org>
X-WP-MailID: 3feb6dd92423be0b81f7c9838fbac39a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [sZPU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:06:39AM +0100, Daniel Golle wrote:
> The function rt2800_iq_calibrate is intended for Rt5592 only.
> Don't call it for MT7620 which has it's own calibration functions.
> 
> Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index 6e5a72cf2a81a0..55a46e27b59875 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -4365,7 +4365,8 @@ static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
>  		reg = (rf->channel <= 14 ? 0x1c : 0x24) + 2*rt2x00dev->lna_gain;
>  		rt2800_bbp_write_with_rx_chain(rt2x00dev, 66, reg);
>  
> -		rt2800_iq_calibrate(rt2x00dev, rf->channel);
> +		if (!rt2x00_rt(rt2x00dev, RT6352))

Since is needed for rt5992 that check would be more appropriate.


