Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B584623D72
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 09:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiKJIYf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 03:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiKJIYe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 03:24:34 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C71EAC4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 00:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Ej3qQBeFdjJqnPAFbtn5+eKx5H3Yc6J85bZ6xJ4B50I=;
        t=1668068673; x=1669278273; b=IPvXIhxLNLITPek15DeEUAj5Ik9BLuK4JFmGPn77xQd9NNM
        hWWuodaN1gxKk4eNKi0EwHopehyeyeDKKEF69llRY211f7DaJ8+TT/ki1zXXYacfMwrW9sQOnYOrz
        /VxSqOy/q8P5iUj7vJDo7KMDEI9zxiknPtxXqsFBMzXfnm+uUEHAL1z7UzQOrGPs2K1yn9C+nraHN
        qwZurVrXLO6TkNpec+p/YZSiQT2sdyMKaxeqfFR8AZWrs3IzCmrcfYVaZ1brWiBSZ7VyXLPdP+zzU
        a+wP3WUISFtiXjndYofO0/JDNVTgX9IsekL07QV9qFIGoLzgOKU0+ha8GFjs6RaA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ot2rQ-00Dtmm-0e;
        Thu, 10 Nov 2022 09:24:32 +0100
Message-ID: <8f818ad6977306a2ce42234f9c1326863e9ee67d.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: Classification of BSS with different
 frequencies in the S1G Band.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     JUN-KYU SHIN <jk.shin@newratek.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 10 Nov 2022 09:24:31 +0100
In-Reply-To: <20221110081758.16927-1-jk.shin@newratek.com>
References: <8a1c1c6ba925b03920fd491407ad710d6bd0d80e.camel@sipsolutions.net>
         <20221110081758.16927-1-jk.shin@newratek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-11-10 at 17:18 +0900, JUN-KYU SHIN wrote:
> If the "channel->freq_offset" comparison is omitted in cmp_bss(),
> BSS with different kHz units cannot be distinguished in the S1G Band.
> So "freq_offset" should also be included in the comparison.
>=20
> Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
> ---
>  net/wireless/scan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 806a5f1330ff..6bba130ea670 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -1289,7 +1289,8 @@ static int cmp_bss(struct cfg80211_bss *a,
>  	int i, r;
> =20
>  	if (a->channel !=3D b->channel)
> -		return b->channel->center_freq - a->channel->center_freq;
> +		return ((b->channel->center_freq * 1000 + b->channel->freq_offset) -
> +					(a->channel->center_freq * 1000 + a->channel->freq_offset));
>=20

And while we're at it - you don't need the outer parentheses on a return
statement, and the indentation could be lining up properly so that a->
is under b->

johannes
