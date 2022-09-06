Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F95AE49D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiIFJpe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIFJpe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:45:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1970E5D
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jg/ofF9XJhqwR26TdOCE7VGtjcrhOtTmyZohe4yqJWg=;
        t=1662457532; x=1663667132; b=K383aSkAJyPnG0qvY8BQHXfRqDwlHwuTnkzF6HR039IA1uf
        fuIgHAPbjPNOV8lti9clFTC0S/vWfmWwl7qrP8V3BSV7RliVxObPSGY3MDvz4uiTAzWS6YnWgOnGq
        5ScLrEaN3nxSw18dgAigdLi83xe6HTO52rwKBNZxQdoNWHR7d6OuTo463ufCsd/azATjjI5O8BBXb
        jc0zTziV5glWvSshgxLYKHF6/LAF77MJllu0n/omAxK7Pr48Qo+WhUBIuwT02sSq/B3AuLH7+he66
        SFuNtMhqXjU088GYEY6ZbLMUpP1wcLaPNVoP4jA0G9xIodNYe+SVd7NvA7YoiUQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVV98-009Moh-05;
        Tue, 06 Sep 2022 11:45:30 +0200
Message-ID: <c2b9720065e9d8b1b364a4dbb851cd4153b1f093.camel@sipsolutions.net>
Subject: Re: [PATCH v3 06/12] mac80211: support ieee80211_ext format
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Date:   Tue, 06 Sep 2022 11:45:29 +0200
In-Reply-To: <20220906044812.7609-7-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
         <20220906044812.7609-7-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-09-06 at 16:48 +1200, Kieran Frewen wrote:
>=20
> +		if (ieee80211_is_s1g_beacon(fc))

maybe use "if (ext_hdr)" here so it's easier to understand? Even for
static checkers :)

> +			rx.sta =3D sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
> +		else
> +			rx.sta =3D sta_info_get_bss(prev, hdr->addr2);
>  		rx.sdata =3D prev;
>  		ieee80211_rx_for_interface(&rx, skb, false);
> =20
> @@ -4999,6 +5007,10 @@ static void __ieee80211_rx_handle_packet(struct ie=
ee80211_hw *hw,
>  	}
> =20
>  	if (prev) {
> +		if (ieee80211_is_s1g_beacon(fc))
> +			rx.sta =3D sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
> +		else
> +			rx.sta =3D sta_info_get_bss(prev, hdr->addr2);
>=20

here too, I guess

johannes
