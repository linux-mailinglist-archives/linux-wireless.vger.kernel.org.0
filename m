Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C836A5E06
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB1RQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 12:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjB1RQT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 12:16:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E6199C1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=w7uSfQkiqKRQxL95jF+ci9a56Rf+qUf/j+lyvWK7XUA=;
        t=1677604578; x=1678814178; b=RhEx8en3OnyuoivfJkv10gSnGe4elelFnsL/WzKWRE3qrjm
        0vyQIIXXIQ8AqUEqcTWc452FIBLfiluO5aJs0Y9+MTQz3DK426AChDHC/7J+C19Lw2pDjsFz4a/m9
        B6257moqkbHExnEqa3oDEsOLJeOfZSp2C5I5zFV/ePMYY0UtOdEhJ3Lrxz6iwHWmWW+1UvVR/Vsl5
        JjbNwcZZCjp27AvGWPUo3d7rxH+Gm9ZU1q0oPwYe6gsdV3BGhitlW958hh1dpNBYTk9Azm3ISaxAm
        +FyrbDSCIDMv1NuKB9raWKzRPMNl0HY7do7WJHoA5M359hc8EJv1Nuh8gEOAgniA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pX3aC-0083af-0F;
        Tue, 28 Feb 2023 18:16:08 +0100
Message-ID: <a8798dce4ae87aee64dfd56721b1668f8c969951.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: ipw2x00: convert ipw_fw_error->elem to
 flexible array[]
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Tue, 28 Feb 2023 18:16:07 +0100
In-Reply-To: <20230228162827.3876606-1-jacob.e.keller@intel.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
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

On Tue, 2023-02-28 at 08:28 -0800, Jacob Keller wrote:
>=20
> @@ -1247,7 +1247,6 @@ static struct ipw_fw_error *ipw_alloc_error_log(str=
uct ipw_priv *priv)
>  	error->config =3D priv->config;
>  	error->elem_len =3D elem_len;
>  	error->log_len =3D log_len;
> -	error->elem =3D (struct ipw_error_elem *)error->payload;
>  	error->log =3D (struct ipw_event *)(error->elem + elem_len);

I really don't know this driver, it's ancient, but that last line looks
wrong to me already, elem_len doesn't seem like # of elems?

But I guess this patch changes nothing here, so hey. Don't think there's
much value in the change either, this driver isn't going to get touched
any more, just removed eventually ;)

johannes

