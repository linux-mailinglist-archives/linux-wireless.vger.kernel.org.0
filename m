Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8F7EBEED
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 09:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjKOI5b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 03:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOI5a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 03:57:30 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F7114
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 00:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HCupE9/tnBdses71DbNxEh3wT5H5TcT70vzQqZr30Es=;
        t=1700038646; x=1701248246; b=Vpvd2DTB1M6Dk64TxldCDJDOO+bqavz1BliuDaKFHO8Tuup
        U1gAqpWs/CLvwG0WRXBFtRN2hVykWP07yyz3M8U04t7Cswaqkx+PkQlq5mbFUjXdd3yRYtOleD0VW
        PbK+UtF/gZudWY1lcL/AGcCt6B2gdC1Fv+KvFnnkCVNPIeCe/8WDDX2fmOVITwgCecw74pbNm3ZlN
        WfbNKf32ZHYAEPHP3sGPOftcdYmXQUbzgR0vmi3koDtP46SzFiIsQEX5QKRBZEammoVSq4Eb+bzGu
        HE3oSGonipSKBgQQGJ+I1wQeEvaSgLOisq5+eJf+wbqZobUOSUWrNMP5dZOw16KQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r3Bi8-000000093pV-0nQP;
        Wed, 15 Nov 2023 09:57:24 +0100
Message-ID: <9574407e2be4c97b1ef2d9f73b5eecb08791ff56.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi:  Add debugging around scan failure
 warning.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Wed, 15 Nov 2023 09:57:23 +0100
In-Reply-To: <20231114212309.2180281-1-greearb@candelatech.com>
References: <20231114212309.2180281-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-11-14 at 13:23 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> Provide additional information that may help debugging why
> the WARN_ON is seen.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/=
wireless/intel/iwlwifi/mvm/scan.c
> index 75c5c58e14a5..ec24ece7c877 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> @@ -2356,7 +2356,10 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mv=
m *mvm,
>  			link_id =3D ffs(vif->active_links) - 1;
> =20
>  		link_info =3D scan_vif->link[link_id];
> -		if (!WARN_ON(!link_info))
> +		if (WARN_ON(!link_info))
> +			IWL_ERR(mvm, "scan failure: Cannot find link info for link-id: %d act=
ive-links: 0x%x\n",
> +				link_id, vif->active_links);
>=20

It would make sense to put the data *into* the warning, rather than
separately? Though I'm not sure I see so much value in the long string
(vs. just the data).

But honestly I'm not sure this really even is a problem at all? Some
confusion can happen during firmware restart here, and not sure we can
really fix that. Though maybe with the new locking we can.

johannes
