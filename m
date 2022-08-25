Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13145A0C2F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 11:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiHYJCc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiHYJC3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 05:02:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535D4F664
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TzCYlDNiVvmXbs381yU8jvL/C2667hpnhrK4Ggtij3c=;
        t=1661418149; x=1662627749; b=rN2fZmGX/FMr67tsk0BNkEVDK0fT35A4GlTFqJmustIH8OB
        A2BjhWFNWecJcrVQ0BTpBXQl0vEbLtZWceb+YGYq2ohiAsHxvaCzKGf/gySATtrEnIiSG+aTFbMXv
        cQDv0Ytnu4tTwBLo8qj9LQpomcfpLTMD3HDDBc7NlXN/J4/usZBcVxHfFfkHobPHi8kImQlgy5965
        j63DzOtXV8d8JiUtkcuKoNZ0Jvl3DvjVTKS5XS1wVYfOKq3IZVDvg+scN1ihcc6iJFKq3sTHV+0Sd
        Xtr7nICfvcmRQ8PR01tN+aDaiv7h6Lg3LBRXtTW/oM8aLWYc/qr3xNfTJlx0EkZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oR8kt-00Gzg4-1K;
        Thu, 25 Aug 2022 11:02:27 +0200
Message-ID: <e898282f0766bdf0bd9cbb92d2a3551ff28cdf6b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] mac80211: Support POWERED_ADDR_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 25 Aug 2022 11:02:26 +0200
In-Reply-To: <20220811231338.563794-3-prestwoj@gmail.com>
References: <20220811231338.563794-1-prestwoj@gmail.com>
         <20220811231338.563794-3-prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-08-11 at 16:13 -0700, James Prestwood wrote:
> @@ -217,7 +275,11 @@ static int ieee80211_change_mac(struct net_device *d=
ev, void *addr)
>  	if (ret)
>  		return ret;
> =20
> +	if (live)
> +		drv_remove_interface(local, sdata);
>  	ret =3D eth_mac_addr(dev, sa);
> +	if (live)
> +		ret =3D drv_add_interface(local, sdata);
> =20
>  	if (ret =3D=3D 0)
>  		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
>=20

I still don't like the (lack of) error checking here. As far as I know,
eth_mac_addr() can very happily fail if the passed address is invalid,
so we really shouldn't overwrite the ret value by drv_add_interface().

Also, it seems like we should only add the interface again after
updating sdata->vif.addr (last context line), so that the driver
actually knows ... otherwise I'm not sure how this patch would have much
effect (unless it updates the FW all the time like iwlwifi, which I
guess is where you tested it, based on the rationale...)

johannes
