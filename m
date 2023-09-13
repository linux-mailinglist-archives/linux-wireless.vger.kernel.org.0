Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB779E43A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjIMJyH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbjIMJxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:53:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65462D62
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Bmm8ROjiU7jXVvIzKcZfOvVErcHfo8gWfx2kFUdED7E=;
        t=1694598795; x=1695808395; b=yO6PYzf4h13loclhNT7jrK/SoKWzIhvsimRL4T4HoNXG3AM
        s3JvU+wHlTc6ZoPyvAkyb53FSLHZmkAlR8pGovC432zqaajyQCDVU6QL7t/0VvypXO8OP72xguC8q
        3A1hMGmAXon5Pm9yFRTqns3yPwIqf8Bf7ddamFlZ3u3j0NH8rr1kgpjm5xRaBT7oRXVm/C0ywKv10
        FYholrDUQpCagDDGfUPU6MzvjJAFKX0vB4rInUrN8JoUGMyiTHUgjOBucElk8O/QercHt4qgLn2JS
        TPU9PO+B14rynC9cLnjwlqwJOZHYV1ySQ57pxFYvBybH2Y88e4uG0w2Wkyc90gHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgMYZ-00El0k-2o;
        Wed, 13 Sep 2023 11:53:12 +0200
Message-ID: <7fe399002ba482ee8e55a937b5075e0f78d77898.camel@sipsolutions.net>
Subject: Re: [PATCH v6 3/3] wifi: cfg80211: Handle driver updated MU-EDCA
 params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Jouni Malinen <j@w1.fi>
Date:   Wed, 13 Sep 2023 11:53:10 +0200
In-Reply-To: <1682960363-15452-3-git-send-email-quic_msinada@quicinc.com>
References: <1682960363-15452-1-git-send-email-quic_msinada@quicinc.com>
         <1682960363-15452-3-git-send-email-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>   *	The number of peers that HW timestamping can be enabled for concurren=
tly
>   *	is indicated by %NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS.
>   *
> + * @NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS: Updated MU-EDCA parameters from
> + *	driver. This event is used to update dynamic MU-EDCA parameters in
> + *	management frames, coming from driver and now need to be reflected in
> + *	management frames.

Not sure I'm happy with this description - it has all the right
information but feels a bit odd? And the first sentence isn't even a
valid sentence. Please rephrase.


> + * @NL80211_ATTR_HE_MUEDCA_PARAMS: MU-EDCA AC parameters for the
> + *	%NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS command in format described in
> + *	P802.11ax_D4.0 section 9.4.2.245

"in the format described" or maybe "as described"?

> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index e9e939706630..af36440f2a51 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -816,6 +816,8 @@ static const struct nla_policy nl80211_policy[NUM_NL8=
0211_ATTR] =3D {
>  	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] =3D { .type =3D NLA_FLAG },
>  	[NL80211_ATTR_EMA_RNR_ELEMS] =3D { .type =3D NLA_NESTED },
>  	[NL80211_ATTR_DYN_MUEDCA_ENABLE] =3D { .type =3D NLA_FLAG },
> +	[NL80211_ATTR_HE_MUEDCA_PARAMS] =3D
> +	       NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_mu_edca_param_set))=
,

This is output only, so arguably should be NLA_REJECT, or just not
listed?

> +EXPORT_SYMBOL(cfg80211_update_muedca_params_event);


And again here (adding Jeff and Jouni), we have an exported cfg80211
function that, as far as I can tell, you have no plans whatsoever to use
in an upstream driver. Yes it's only 130 lines of code or so, but still,
someone has to maintain it ...

So please resend this only when you have a user. Until then you can
trivially use a vendor event for this and I don't have to care, and I
don't even have to review it and address all the stupid little issues
like missing documentation that you'd have found if you had any internal
review worth calling that.

johannes
