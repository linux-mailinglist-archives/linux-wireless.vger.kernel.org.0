Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796C869823A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 18:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBORfI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 12:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBORfH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 12:35:07 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7B7DB5
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9AXJuCaXJEyUZLD5x7msrVhjTKmunuVp3q/Olzo3bto=;
        t=1676482505; x=1677692105; b=jOqLbpSBE/h0/R0K71gTlgAZ+abeSC0T88EmEqWMKAAUJw2
        kkLdViPkq+X+F9oaSWRTP8N7APg+bB7Xio/CfMbb+EnYWQ8OeCKSfuA65d15TGuauKT1RVbaWblsJ
        QEQiHR9R3bjUj07NGc7rZTJvdR5NoxD6EJZ7Iq9B8bXJs2XHZZ3r3/gE0mG2rAX55eDew+ztfcnbL
        IFAyWGy/BJByKLF4XSw9mbLL2aY25T7N4fcyxEy+g7oV4i77PzNFdcPQF0n5gzdVzn4/NSqlc+Cwb
        KqaygsJsyvXn9VRSkZGnyUKPX2HXZFFXGhRG4oDLgN/UYj2NptPOwBrE+bS73fAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSLgJ-00D9Id-0K;
        Wed, 15 Feb 2023 18:34:59 +0100
Message-ID: <65670cf42abc593502e9f7bafc56c1d0360d5631.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/3] wifi: cfg80211: add support to enable/disable
 bss color collision detection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>
Date:   Wed, 15 Feb 2023 18:34:58 +0100
In-Reply-To: <20230201065638.25990-2-quic_ramess@quicinc.com>
References: <20230201065638.25990-1-quic_ramess@quicinc.com>
         <20230201065638.25990-2-quic_ramess@quicinc.com>
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

On Wed, 2023-02-01 at 12:26 +0530, Rameshkumar Sundaram wrote:
> As per 802.11ax-2021, STAs shall process BSS Color Change Announcement
> (BCCA) from AP and switch to new color, but some STAs aren't processing
> BCCA from AP and not doing color switch, causing them to drop data
> frames from AP post color change.

Hmm. We had this bug in EHT. Should we really allow this? It's a station
bug, why bother?

> Provide an option to disable color collision detection and therefore
> not to do BCCA to mitigate the same from AP. If it's required in case
> where STA supports BCCA handling, then it can enabled in AP using this
> option.

This could be rewritten a bit, not entirely clear to me. "enabled" is
more like "disabled"? Or no? Confusing.

> + * @NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLED: is BSS
> + * color collision detection disabled.

please use a tab to indent the second line like elsewhere

> +	he_bss_color->collision_detection_enabled =3D
> +		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLE=
D]);

Is it really worth to have one side say "enabled" and the other
"disabled"?

johannes
