Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81B84B3793
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiBLTNY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 14:13:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiBLTNY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 14:13:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D76A4
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fSnhDYupsK3DS8l/G7Y+JvdXSMW1Dg/GIo0vkfVGo+g=;
        t=1644693199; x=1645902799; b=iBRfV21QSVThormhOwNrvg1e/nnLTPNB2fjhXFPDHSBFRYo
        gb4ku8U55UXU8BRXeJ9e3GEOJ49XDmLc+TNvjNr0VCAR2rxTI5JyrDuA5BfHlu4EjpjT2wVC/xsU+
        CU4xwLMYfRCEoNdAQBg2oSViu5mFr9w1OqzUuNT2+AehOSbJmRqM+4seLiNfqX4QYZNZoCPzA1evC
        dGLCmA2LmrbP9zirkrrHWqenis34JEb3Vop7lEF3a6n8e/xOD/X5y7cMRLQgO0JjP0o7BLlC+G/He
        76+3xMCFGhMilOPHVerzgl6LdO6qDib/hrkcI3Eqk7UIDP2BoNo2aQIIjpz/MBLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIxpW-000LLt-73;
        Sat, 12 Feb 2022 20:13:10 +0100
Message-ID: <0d074b586c41975cb2ce59feb85ac7c91ca5b5c8.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix EAPoL rekey fail in 802.3 rx path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Sat, 12 Feb 2022 20:13:07 +0100
In-Reply-To: <6889c9fced5859ebb088564035f84fd0fa792a49.1644680751.git.deren.wu@mediatek.com>
References: <6889c9fced5859ebb088564035f84fd0fa792a49.1644680751.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2022-02-13 at 00:20 +0800, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> mac80211 set capability NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211
> to upper layer by default. That means we should pass EAPoL packets through
> nl80211 path only, and should not send the EAPoL skb to netdevice diretly.
> At the meanwhile, wpa_supplicant would not regist sock to listen EAPoL skb
> on the netdevice.
> 
> However, there is no contorl_port_protocol handler in mac80211 for 802.3 RX
> packets, mac80211 driver would pass up the EAPoL rekey frame to netdevice
> and wpa_supplicant would be never interactive with this kind of packets,
> if SUPPORTS_RX_DECAP_OFFLOAD is enabled. This causes STA always rekey fail
> if EAPoL frame go through 802.3 path.
> 
> To avoid this problem, align the same process as 802.11 type to handle
> this frame before put it into network stack.
> 
> Fixes: 80a915ec4427 ("mac80211: add rx decapsulation offload support")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  net/mac80211/rx.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 0544563ede52..57f5d5500282 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -4509,12 +4509,7 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
>  
>  	/* deliver to local stack */
>  	skb->protocol = eth_type_trans(skb, fast_rx->dev);
> -	memset(skb->cb, 0, sizeof(skb->cb));
> -	if (rx->list)
> -		list_add_tail(&skb->list, rx->list);
> -	else
> -		netif_receive_skb(skb);
> -
> +	ieee80211_deliver_skb_to_local_stack(skb, rx);
>  }

This looks like a really good idea even for the security fix in
ieee80211_deliver_skb_to_local_stack() ... :)

johannes
