Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0E79E2EE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbjIMJEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbjIMJEi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:04:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E960719A6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+2hcaoJP5aajGwDX7qpJONypAVfCQ/NTzjrYDO0mpow=;
        t=1694595874; x=1695805474; b=n/GsNjmR8eJz5APKtt2Sv7PQoXXqdfW58MjgIb4pS2hsBXW
        UAXSh4x6xaoqVzSS/OC/nS65KrqwZSNDi1b1MLJ/+fM8V6NHgaWVY+NaSiMTMKaLrIEUqtUxomfzM
        trdFQqyOzJtl2nqvZxVOH+/dtpJ/fy2FOO2X9PEQX+ESyZMa7rln+itzbO4v/Di1nQcdm6PKb50bp
        SGVhFXkZ8LgwmDGCd1bCK+9CZSNKj/f56aeD/xy+m8tdwGarltJgfS/vbHNcX7LBed9iuxmu69fSw
        gcyL+Xr84RwgnIOfpMeK7Dkrn1dQboL1oTZZw+5k+U94DqtTHtkf9EPrTVmglnjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgLnP-00EiA6-2u;
        Wed, 13 Sep 2023 11:04:28 +0200
Message-ID: <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] wifi: mac80211: update link RX NSS by
 ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Sep 2023 11:04:26 +0200
In-Reply-To: <20230906103458.24092-4-quic_wgong@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
         <20230906103458.24092-4-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
> Currently for MLO connection, only deflink's rx_nss is set to correct
> value. The others links' rx_nss of struct ieee80211_link_sta is
> value 0 in ieee80211_set_associated(), because they are not pass into
> ieee80211_sta_set_rx_nss() in mac80211 except the deflink in
> rate_control_rate_init(). This leads driver get NSS =3D 0 for other links=
.
> Add the ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link(),
> then the other links' rx_nss will be set to the correct value.

This is pretty much true, but I also think it's problematic the way you
phrase it. Software rate control is pretty much, at least currently,
_not_ supported for MLO (and I don't really see how to support it, if
firmware picks the link to transmit on, as it probably should).

Thus, I'm not even sure we should be calling rate_control_rate_init().
Clearly we do today, but it's also obviously wrong for everything except
the call to ieee80211_sta_set_rx_nss().

So while I agree that there's a problem with the RX NSS, I disagree that
this patch is the right way to fix it. Yes, it also fairly obviously
fixes the problem, but it just makes an existing design problem worse.

Please change change the overall design here so that
ieee80211_sta_set_rx_nss() isn't related to rate control at all.

johannes

