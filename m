Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB070711332
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjEYSHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYSHP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 14:07:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7C10D8
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2GDCas6rHFTYHyZNTEV2dfITJGih9s/r4h1Kzmr/hMk=;
        t=1685038007; x=1686247607; b=g38VMkZZBkmh/HoKFgT6hPXRORdcnoyHzotZ3z+qGWTc2rr
        c8RGoh11qJnJTmptsxDStip8frizN168ZLADjLfu9Xm1zWP3mTTR6eAhNV/gHquP2j9qxCzVjC6xs
        c7mdk4dITEhohtafJ9p2q0FrM1JG+HInzVSsp0EOTzMDnpvH4RJFDzMvO+tOm48J1wzb/CvnP+1SH
        a3vJmcjJdKb6KWYwa0KPhprEoBs4g9MmsJfTEZSR3o8fDyytFhrUi4OoI7pd+9a/HNEm5vSx8fXj6
        0dlgcPQ9toWbm8LpDCC0S0LF5BwyBdPFRQDs6w/MaGq6F9N7xg7eIP/i/upa0rbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q2FL8-003OWq-0U;
        Thu, 25 May 2023 20:05:30 +0200
Message-ID: <fa9429cb8d24c9bb4b810c423b150aefe116148c.camel@sipsolutions.net>
Subject: Re: Question about power save
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 25 May 2023 11:05:27 -0700
In-Reply-To: <c385be75-71db-6265-1a6c-24eca64e5d7f@lwfinger.net>
References: <c385be75-71db-6265-1a6c-24eca64e5d7f@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

> One of the users of an rtw8821ce found an increase of power usage from 27=
2 mW in=20
> kernel 5.19.13 to 579 mW in kernel 6.2.8. If he reverted commit 28977e790=
b5d=20
> ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS"), =
the=20
> original power usage is restored.

Yeah, I think I saw the report, but I'm travelling and didn't have that
much time to reply.


> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -1787,7 +1787,8 @@ void ieee80211_recalc_ps(struct ieee80211_local *lo=
cal)
>          int count =3D 0;
>          int timeout;
>=20
> -       if (!ieee80211_hw_check(&local->hw, SUPPORTS_PS)) {
> +       if (!ieee80211_hw_check(&local->hw, SUPPORTS_PS) ||
> +           ieee80211_hw_check(&local->hw, SUPPORTS_DYNAMIC_PS)) {
>                  local->ps_sdata =3D NULL;
>                  return;
>          }
>=20
> The driver in question has both SUPPORTS_PS and SUPPORTS_DYNAMIC_PS set, =
thus=20
> this patch enables the dependent part of this test. Is this what was inte=
nded?=20
> If so, then rtw88 is not supporting DYNAMIC_PS correctly.

I didn't really have time to analyze this ... In mac80211.h we say:

 * Dynamic powersave is simply supported by mac80211 enabling and disabling
 * PS based on traffic. Driver needs to only set %IEEE80211_HW_SUPPORTS_PS
 * flag and mac80211 will handle everything automatically. Additionally,
 * hardware having support for the dynamic PS feature may set the
 * %IEEE80211_HW_SUPPORTS_DYNAMIC_PS flag to indicate that it can support
 * dynamic PS mode itself. The driver needs to look at the
 * @dynamic_ps_timeout hardware configuration value and use it that value
 * whenever %IEEE80211_CONF_PS is set. In this case mac80211 will disable
 * dynamic PS feature in stack and will just keep %IEEE80211_CONF_PS
 * enabled whenever user has enabled powersave.


but maybe the issue is that now CONF_PS isn't set any more?

johannes
