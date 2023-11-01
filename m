Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C311F7DDE20
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjKAJH0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjKAJHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 05:07:24 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C4DE
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 02:07:15 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 43345 invoked from network); 1 Nov 2023 10:07:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1698829630; bh=121BPoDMWPx6YwuwAG9rHJJa1dX+XjyAWL8FmojSdJ4=;
          h=From:To:Cc:Subject;
          b=boW0JQwWixKRBrnQxXhH9WmgMnIRG0oNhvbtqhy53LpCMupo76+ghLbF4msQl49aO
           1urI4HnxKVmYqA/yboohHnf5fwpECKpskLIWwgAxP5R//xTjtpIx3fX3LZ46ty+Qfq
           T7ipn3uC+YQGLj4LmoiPHJ5a4+p65TXZHpKfk2XM=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 1 Nov 2023 10:07:10 +0100
Date:   Wed, 1 Nov 2023 10:07:10 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 3/3] wifi: rt2x00: restart beacon queue when hardware
 reset
Message-ID: <20231101090710.GB552433@wp.pl>
References: <20231028121532.5397-1-yangshiji66@outlook.com>
 <TYAP286MB0315339CF8B38FC1286CF39DBCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315339CF8B38FC1286CF39DBCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: 7de18f60d326fcc96716c3bb08d056fb
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [obOU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 28, 2023 at 08:15:32PM +0800, Shiji Yang wrote:
> When a hardware reset is triggered, all registers are reset, so all
> queues are forced to stop in hardware interface. However, mac80211
> will not automatically stop the queue. If we don't manually stop the
> beacon queue, the queue will be deadlocked and unable to start again.
> This patch fixes the issue where Apple devices cannot connect to the
> AP after calling ieee80211_restart_hw().

Should not this be solved in mac80211 then? ieee80211_restart_work
does a lot o diffrent things, why beconing is not also
stoped/started there ? 

Regards
Stanislaw

> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 3 +++
>  drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> index 9a9cfd0ce..ac58a56c3 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> @@ -101,6 +101,8 @@ void rt2x00lib_disable_radio(struct rt2x00_dev *rt2x00dev)
>  	rt2x00link_stop_tuner(rt2x00dev);
>  	rt2x00queue_stop_queues(rt2x00dev);
>  	rt2x00queue_flush_queues(rt2x00dev, true);
> +	if (test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags))
> +		rt2x00queue_stop_queue(rt2x00dev->bcn);
>  
>  	/*
>  	 * Disable radio.
> @@ -1286,6 +1288,7 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
>  	rt2x00dev->intf_ap_count = 0;
>  	rt2x00dev->intf_sta_count = 0;
>  	rt2x00dev->intf_associated = 0;
> +	rt2x00dev->intf_beaconing = 0;
>  
>  	/* Enable the radio */
>  	retval = rt2x00lib_enable_radio(rt2x00dev);
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
> index 4202c6517..6fcbf534a 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
> @@ -615,7 +615,9 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
>  			 * and keep it running on other interfaces.
>  			 */
>  			rt2x00queue_clear_beacon(rt2x00dev, vif);
> -		} else if (bss_conf->enable_beacon && !intf->enable_beacon) {
> +		} else if (bss_conf->enable_beacon &&
> +			   (!intf->enable_beacon ||
> +			    test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags))) {

>  			rt2x00dev->intf_beaconing++;
>  			intf->enable_beacon = true;
>  			/*
> -- 
> 2.39.2
> 
