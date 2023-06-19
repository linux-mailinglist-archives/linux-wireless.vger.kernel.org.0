Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714337351D2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFSKSX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjFSKSH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 06:18:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408291BE5
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=C4Pr+mM27mQbrdaZ0f5H147CZGJ5dKtO5TwUJzPhIl0=;
        t=1687169855; x=1688379455; b=yVbUGlw8+iqj2LWnr4ZWiTrlFwUmf4EUV1B4vvZAYHULkFt
        ao5aQJNS7ZMiJWQavboFyzjTZSiTAQRr85xfgDBxXQ7EcupBiIV1v76SrZia7ur783yKg1KhJWZMT
        LRfTI1d2Mc8MYTe5w1dYfS02oqI6nutnQ8D9gvDprlkEWz+BI+QANnlMqhBCRJETebquxtxRqrY24
        i3heE69b7NVbaN7N+1CpXygbc9/Kkgo54dHUMSndT66CJdd3aNuoArKK94XIRs0sSuLyCXMASNvKA
        mGX2ccBmse69u41bwOC7tpbVAebrSPHlV1ijr3hPEgQerV1X/8no8aGj4sV2I6qg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBBwo-00BI5f-0a;
        Mon, 19 Jun 2023 12:17:22 +0200
Message-ID: <6abc24f254fd265f8f533ef52e2798c617e30359.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlfifi: fix -Wunused-const-variable gcc warning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Mon, 19 Jun 2023 12:17:20 +0200
In-Reply-To: <20230619100030.284920-1-dmantipov@yandex.ru>
References: <20230619100030.284920-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-06-19 at 13:00 +0300, Dmitry Antipov wrote:
> Fix the following gcc 13.1 warning observed with W=3D1:
>=20
> drivers/net/wireless/intel/iwlwifi/dvm/rs.c:207:39: warning:
> =E2=80=98iwl_rate_mcs=E2=80=99 defined but not used [-Wunused-const-varia=
ble=3D]
>=20
> This table is actually used in 'rs_sta_dbgfs_scale_table_read()'
> only if CONFIG_MAC80211_DEBUGFS is enabled.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wi=
reless/intel/iwlwifi/dvm/rs.c
> index 687c906a9d72..ecad7403ec96 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
> @@ -203,6 +203,8 @@ static const u16 expected_tpt_mimo3_40MHz[4][IWL_RATE=
_COUNT] =3D {
>  	{0, 0, 0, 0, 277, 0, 478, 624, 737, 911, 1026, 1070, 1109}, /* AGG+SGI =
*/
>  };
> =20
> +#ifdef CONFIG_MAC80211_DEBUGFS
> +
>  /* mbps, mcs */
>  static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] =3D {
>=20

Maybe move it to the existing ifdef, or even into the function?

Also, you have a typo in subject, 'iwlwifi', but should probably be
"wifi: iwlwifi: dvm: ..." since dvm/mvm are hugely different.

johannes
