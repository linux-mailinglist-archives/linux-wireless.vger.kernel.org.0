Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438DE623D04
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 09:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiKJIBE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 03:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiKJIBC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 03:01:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063024BE7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 00:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zVNQInZpbz1rnYc8Qie0xhvLWc9Lej0eX1kCfdCg/qY=;
        t=1668067260; x=1669276860; b=LRLfd2xeKks5uVd6KzlEim5EvA3EluulC1BIVSjEmhfXnjk
        ra1SPDUaOHoGsRyfnAgBW4IIE6qONQIowlVXRFz3wNCzXFDiB4lbDkTOSff6LYpk50wk8et50Dfrm
        lBsKGTkrE1zSkMoaANmUiKE1oDc7jO0dYHbrp5kpu3FXTH7/oz0BJb69lKbIG0+BGjeVhCsbIyoVR
        OGw7SygOS4BIPMQaUn3PbZdzE6lppvz9E1fw0Pn4jTYpCcHsMZ1pUrVlJd8HyQJoGuw3xd9qfan37
        ho7JUNicL6SEVCAYd1h+Pk1PSlZ5/+J9erzwXwuvuTJy4Kf3Nc5fgQKYVhFCzslg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ot2Uc-00DtPL-01;
        Thu, 10 Nov 2022 09:00:58 +0100
Message-ID: <8a1c1c6ba925b03920fd491407ad710d6bd0d80e.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: Classification of BSS with different
 frequencies in the S1G Band.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     JUN-KYU SHIN <jk.shin@newratek.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 10 Nov 2022 09:00:57 +0100
In-Reply-To: <20221110054801.7992-1-jk.shin@newratek.com>
References: <45be33863c53edc5be261950b2592a777690a353.camel@sipsolutions.net>
         <20221110054801.7992-1-jk.shin@newratek.com>
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

On Thu, 2022-11-10 at 14:48 +0900, JUN-KYU SHIN wrote:
> If the "channel->freq_offset" comparison is omitted in cmp_bss(),
> BSS with different kHz units cannot be distinguished in the S1G Band.
> So "freq_offset" should also be included in the comparison.
>=20
> Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
> ---
>  net/wireless/scan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 22ae8996ada3..6bba130ea670 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -1289,8 +1289,8 @@ static int cmp_bss(struct cfg80211_bss *a,
>  	int i, r;
> =20
>  	if (a->channel !=3D b->channel)
> -		return ((b->channel->center_freq + (u32)b->channel->freq_offset) -
> -					(a->channel->center_freq + (u32)a->channel->freq_offset));
> +		return ((b->channel->center_freq * 1000 + b->channel->freq_offset) -
> +					(a->channel->center_freq * 1000 + a->channel->freq_offset));
>=20

Looks like that patch would apply on top of your other patch, you need
to resend a complete new patch instead please.

johannes
