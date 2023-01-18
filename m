Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BCF671EB7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 15:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjAROA4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 09:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjAROAP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 09:00:15 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFAF78565
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HaxmU9RbaH4pDTEJIYc9pHNHQnX/yMAKEG8Amasc/08=;
        t=1674048861; x=1675258461; b=Vd9BZJOl1QxktL0x+EZEh3H6OSf2GRaGe6h8Gb8udra6xUU
        Ow0Co8VjiBXZG3SlaE6xZPBmj2cPIh8bRP9/t+vrrgV44MwY3oxT6L52EfU++wLcVu0rvpxDCkGjM
        FFUnlTMxqxh/t71mAGFgz79J45DRaA83yWjNOqeVE7OPqHb6LxHV7WMLJvjS+iyLerolyepLoGmZg
        eekNHM0qXXJVZu8+GTTtN1NXstppY6YBRVkI9bCf/+vuNaa34VoEK6uG4RhLPCGCl5EIFXvivA2vO
        9Jo5PXJJP8UeP1qBxXcEIRsWqHzZTjXxKS0aiAvT7Iw96yqRtmMU1El8k04wNnCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pI8a2-005c8P-11;
        Wed, 18 Jan 2023 14:34:18 +0100
Message-ID: <f4daeb2ded6c7ea16432a64209b0722a02ea7513.camel@sipsolutions.net>
Subject: Re: Why does HT/VHT/HE/EHT depend on WMM?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 14:34:17 +0100
In-Reply-To: <ffe143aa29161635530d4c0e6cea866f4c41267a.camel@gmail.com>
References: <ffe143aa29161635530d4c0e6cea866f4c41267a.camel@gmail.com>
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

On Fri, 2022-12-16 at 16:17 -0800, James Prestwood wrote:
> Hi,
>=20
> I noticed this bit of code which disables HT/VHT/HE/EHT if the AP
> doesn't support WMM:
>=20
> net/mac80211/mlme.c:ieee80211_mgd_assoc()
>=20
> /* also disable HT/VHT/HE/EHT if the AP doesn't use WMM */
> if (!bss->wmm_used) {
> 	conn_flags |=3D IEEE80211_CONN_DISABLE_HT;
> 	conn_flags |=3D IEEE80211_CONN_DISABLE_VHT;
> 	conn_flags |=3D IEEE80211_CONN_DISABLE_HE;
> 	conn_flags |=3D IEEE80211_CONN_DISABLE_EHT;
> 	netdev_info(sdata->dev, "disabling HT/VHT/HE as WMM/QoS is not
> supported by the AP\n");
> }
>=20
> It seems suspicious that 802.11 features would depend on a wifi-
> alliance spec. Usually its the other way around.
>=20
> I can see no such limitation set in 802.11 or the WMM spec, so I wonder
> why this was done? If someone could educate me on why I'd be happy to
> update the comment.
>=20

It depends on QoS data frames being usable.

Which in turn technically depends on being a QoS-STA in the IEEE spec,
but in practice nobody implements the required signalling for that and
uses the WMM signalling instead. We don't (and probably don't really
want to since it'd be pointless) implemented spec-QoS instead or in
addition to WMM.

johannes
