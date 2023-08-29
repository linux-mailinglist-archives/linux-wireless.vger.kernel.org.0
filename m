Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6376378CB94
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjH2Rw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbjH2Rv6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 13:51:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2B1E9
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=CJ2v8S/1ryLAOPOChAyE7RA+AtxjatbuAELG+GRkPik=;
        t=1693331516; x=1694541116; b=b1KSG4G5iOTsmgkcHfJzpfPhw34lA/sb7qovlxOdEqTmL3H
        4Q9vdTKo8a5ZJyLcxau51npH5gY4AO0joOJWszX2SmU58XcBHxGCLxxZNXEfB8vxvo63UAlXDfnTF
        PGSj8HQGsf2niJhdBm72lMhBcpSHuUtGcDlv5TwxSb+urUHdZwJk4hqdoyO4D0pcrgsMNTRHekyGy
        FoRY09v6zUcxe7rCPaifdtmm3mu/ZWkYgadQr6gUEp9WsPO6Uge9qr4EmlH1b8ftK/fZGWQEVU6oC
        PjQvys0A4Sl7dAlVmQ6K75m+IuiZiTFE098HI2w6xN9GdqUvk9doejY48dNAFrBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qb2sb-001Qjq-2M;
        Tue, 29 Aug 2023 19:51:53 +0200
Message-ID: <59e2364e9085f725c03d05e3f720f8fae7b336ce.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/9] wifi: cfg80211: add NL command to set 6 GHz
 power mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 29 Aug 2023 19:51:52 +0200
In-Reply-To: <20230315132904.31779-5-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
         <20230315132904.31779-5-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:
>=20
> +	{
> +		.cmd =3D NL80211_CMD_SET_6GHZ_POWER_MODE,
> +		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit =3D nl80211_set_6ghz_power_mode,
> +		.flags =3D GENL_UNS_ADMIN_PERM,
> +		.internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV |
> +					 NL80211_FLAG_MLO_VALID_LINK_ID),
> +	},

Why is this even a new command, rather than a parameter to start AP or
similar?

Why do we even set it in client mode from userspace?

>  static struct genl_family nl80211_fam __ro_after_init =3D {
> @@ -17409,7 +17473,7 @@ static struct genl_family nl80211_fam __ro_after_=
init =3D {
>  	.n_ops =3D ARRAY_SIZE(nl80211_ops),
>  	.small_ops =3D nl80211_small_ops,
>  	.n_small_ops =3D ARRAY_SIZE(nl80211_small_ops),
> -	.resv_start_op =3D NL80211_CMD_REMOVE_LINK_STA + 1,
> +	.resv_start_op =3D NL80211_CMD_SET_6GHZ_POWER_MODE + 1,
>=20

Obviously, this should not be done.

But in any case, I don't think there's a lot of value in doing a
detailed review of the code if we haven't gotten a good grasp of the
semantics that you want.

johannes
