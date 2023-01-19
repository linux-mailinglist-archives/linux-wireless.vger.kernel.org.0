Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D82673D84
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjASPcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjASPcA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:32:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D881025
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=d3pvrWMx+ElbUkaPmv29vprlfZkjlOchKFEIUXI1z90=;
        t=1674142319; x=1675351919; b=YeztB0TAy7+xw2/aBN+snRjLrR7vNVEyN6DqO//Qeux2CKe
        OcrlEgZSdGs3SgoFGi2OKML2rqGgbdIvmseqzdFtWK9ZLnaXANAc/luU79TgGzIf1BGzOuVrZitOC
        g+bV+RUU6/I4Dw0+XsyLXCPp6kYcnP4T3qYBbzxymjgweAdrsFAAEdl/6XDw0IlPbfh1pdPCkWgFI
        NYiY2rr153+ltkdOXn7TKTuJZXn+ETRfVupzv7MCWoAjOMz43oWkphSqD652vQIuebd6owdb8FGfm
        xPXB85nhnlkGDuzI2zZo88Yyn4SAIlvstFEHT1EkQdr3agoIdddOn4ubsWzWKJew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIWtR-006Yor-1w;
        Thu, 19 Jan 2023 16:31:57 +0100
Message-ID: <b98e76416ce4edba699f2bb4d456489e69ceeff1.camel@sipsolutions.net>
Subject: Re: [RFC 1/4] wifi: nl80211: advertise RU puncturing support to
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>
Date:   Thu, 19 Jan 2023 16:31:56 +0100
In-Reply-To: <1670006154-6092-2-git-send-email-quic_msinada@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
         <1670006154-6092-2-git-send-email-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Fri, 2022-12-02 at 10:35 -0800, Muna Sinada wrote:
> From: Aloka Dixit <quic_alokad@quicinc.com>
> [...]
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>

You should probably add your S-o-b since you handled the patch.

> + * @ru_punct_supp_bw: Whether the driver supports RU puncturing, and if =
so,
> + *     for which bandwidths.
>=20

I find the definition in nl80211 to be clearer which talks about minimum
bandwidth, to be honest.

>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
> + *

unneeded blank line?

> +/**
> + * enum nl80211_ru_punct_supp_bw - Bandwidths supporting preamble punctu=
ring
> + *
> + * @NL80211_RU_PUNCT_NOT_SUPP: preamble puncturing is not supported

I see why you did this (cfg80211) but can't say I like it since in
netlink terms we'd just not include the attribute in that case ...

> + * @NL80211_RU_PUNCT_SUPP_BW_80: puncturing supported within channels of=
 at
> + *	least 80 MHz bandwidth
> + * @NL80211_RU_PUNCT_SUPP_BW_160: puncturing supported within channels o=
f at
> + *	least 160 MHz bandwidth
> + * @NL80211_RU_PUNCT_SUPP_BW_320: puncturing supported within 320 MHz.
> + */
> +enum nl80211_ru_punct_supp_bw {
> +	NL80211_RU_PUNCT_NOT_SUPP,
> +	NL80211_RU_PUNCT_SUPP_BW_80,
> +	NL80211_RU_PUNCT_SUPP_BW_160,
> +	NL80211_RU_PUNCT_SUPP_BW_320,
> +};

Btw why is this a minimum bandwidth - couldn't this be a bitmap of
bandwidths for example? I mean, is there a technical requirement that if
you do it in 80, you can do it in 160? It's probably true in general,
but maybe we can just completely avoid defining the new enum by saying

 u32 puncturing_widths;

and put there BIT(NL80211_CHAN_WIDTH_80), BIT(NL80211_CHAN_WIDTH_160)
and BIT(NL80211_CHAN_WIDTH_320) - and maybe even
BIT(NL80211_CHAN_WIDTH_80P80) which could conceivably be harder/less
supported, and you haven't covered (is it part of your 80+, 160+ or not
covered at all?)

That way also 0 =3D=3D not supported in cfg80211.

johannes
