Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4F666FCA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 11:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjALKhl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 05:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjALKhC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 05:37:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072F85564F
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=luEXFw626dhG8za41fmR6A1vogQGB2NTKy3LMejrliQ=;
        t=1673519468; x=1674729068; b=Nd0gB7cppRDHBKklMkzEk8P2tdyytbx3/wI5tjk8VrAzj+5
        T2Qu0e2AT8g+0XkuVxFgWE5JbKyFbtTaaIj6h6XuiPz1vc515EtxkC4Ex4c5pqspXRz8fHxNkbJw4
        jHhxR2ywnx8DENQkr+jtEkfHW7g62+3lobeqVnd2vglWaehWHlsCc9bkb+0orLSiML1Ny1WRR3hQs
        Wb848rZ5xoIFsPOvLVpgN1cUHi0Yi0dvkSAUHqg6Xx0j6X/j3q2wc/h7sklWOYG6rC2NkI7DfSGIQ
        /7TmcfZke86lcbEeuxBg+TfGLJaltKjaCeS3zvobPkdR6nDxiyFN8ITzIonHR4vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFurS-00H3Id-0f;
        Thu, 12 Jan 2023 11:31:06 +0100
Message-ID: <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name
Date:   Thu, 12 Jan 2023 11:31:05 +0100
In-Reply-To: <20220920104032.496697-6-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-6-jelonek.jonas@gmail.com>
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

On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
> Enable RC_TABLE in hwsim for TPC support and replace the
> ieee80211_tx_status_irqsafe calls with regular ieee80211_tx_status_ext
> calls to be able to pass additional information, i.e., tx-power.
> Add some variables, members and functions in both tx control and tx
> status path to pass and process tx-power.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> ---
>  drivers/net/wireless/mac80211_hwsim.c | 175 ++++++++++++++++++++++++--
>  drivers/net/wireless/mac80211_hwsim.h |   1 +
>  2 files changed, 168 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless=
/mac80211_hwsim.c
> index df51b5b1f171..a56fb2505047 100644
> --- a/drivers/net/wireless/mac80211_hwsim.c
> +++ b/drivers/net/wireless/mac80211_hwsim.c
> @@ -57,10 +57,15 @@ static bool paged_rx =3D false;
>  module_param(paged_rx, bool, 0644);
>  MODULE_PARM_DESC(paged_rx, "Use paged SKBs for RX instead of linear ones=
");
> =20
> -static bool rctbl =3D false;
> +static bool rctbl =3D true;

should we really change the default?

Is there a netlink control to set it for newly created wiphys?

>  module_param(rctbl, bool, 0444);
> =20
> +static int tpc =3D 0;
> +module_param(tpc, int, 0444);
> +MODULE_PARM_DESC(tpc, "Support transmit power control (TPC) (0 =3D no,\
> +		1 =3D per packet, 2 =3D per mrr stage)");

Not sure I like this either - I think we should probably create the
wiphys dynamically for most features these days?


> +static inline u8
> +hwsim_rate_get_vht_mcs(const struct hwsim_tx_rate *rate) {
> +	return rate->idx & 0xf;
> +}
> +
> +static inline u8
> +hwsim_rate_get_vht_nss(const struct hwsim_tx_rate *rate) {
> +	return (rate->idx >> 4) + 1;
> +}

odd indentation for functions - should have linebreak before {

> +static void trans_tx_rate_to_rate_info(const struct hwsim_tx_rate *rate,
> +				       const struct hwsim_tx_rate_flag *rate_flags,
> +				       struct wiphy *wiphy, u8 band,
> +				       struct rate_info *rate_info)
> +{
> +	memset(rate_info, 0, sizeof(struct rate_info));
> +
> +	if (rate_flags->flags & MAC80211_HWSIM_TX_RC_MCS) { /* 802.11n */
> +		rate_info->flags |=3D RATE_INFO_FLAGS_MCS;
> +		rate_info->mcs =3D rate->idx;
> +	} else if (rate_flags->flags & MAC80211_HWSIM_TX_RC_VHT_MCS) { /* 802.1=
1ac */
> +		rate_info->flags |=3D RATE_INFO_FLAGS_VHT_MCS;
> +		rate_info->mcs =3D hwsim_rate_get_vht_mcs(rate);
> +		rate_info->nss =3D hwsim_rate_get_vht_nss(rate);
> +	} else { /* 802.11a/b/g */

again what about HE/EHT?

> +static void mac80211_hwsim_get_txpower(struct ieee80211_hw *hw,
> +				       struct ieee80211_sta *sta,
> +				       struct sk_buff *skb,
> +				       s16 *txpower)
> +{
> +	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +	bool tpc_per_pkt =3D ieee80211_hw_check(hw, SUPPORTS_TPC_PER_PACKET);
> +	bool tpc_per_mrr =3D ieee80211_hw_check(hw, SUPPORTS_TPC_PER_MRR);
> +	u8 i =3D 0;
> +
> +	if (sta && sta->rates && !info->control.skip_table &&
> +	    ieee80211_hw_check(hw, SUPPORTS_RC_TABLE))
> +	{

misplaced {, should be at end of previous line

> +		struct ieee80211_sta_rates *ratetbl =3D rcu_dereference(sta->rates);
> +
> +		for (; i < IEEE80211_TX_MAX_RATES; i++) {

those loops are weird - prefer to spell out 'i =3D 0' in the loops rather
than common initialization above (and remove the =3D0 from the init then)

> @@ -4846,16 +4989,32 @@ static int hwsim_tx_info_frame_received_nl(struct=
 sk_buff *skb_2,
> =20
>  	tx_attempts =3D (struct hwsim_tx_rate *)nla_data(
>  		       info->attrs[HWSIM_ATTR_TX_INFO]);
> +	tx_attempts_flags =3D (struct hwsim_tx_rate_flag *)nla_data(
> +			     info->attrs[HWSIM_ATTR_TX_INFO_FLAGS]);
> +	sta =3D (struct ieee80211_sta *)txi->rate_driver_data[1];

That seems dangerous - what if the STA was freed already? You don't walk
the pending list or something if the STA goes away.

johannes
