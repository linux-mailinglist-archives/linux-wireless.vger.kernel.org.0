Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98779EBB8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjIMOz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjIMOz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:55:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E095B3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rqdKdv0py5w0mkXoURgBBSm3ANbbd3mQQapbU76S2t4=;
        t=1694616954; x=1695826554; b=nj7MIgA3l4THI9gwhy/qgykYLoFvrLMNakO6LDQi9iJfkul
        mIUNuIM0NiJd211Oeuc0XqF9IPWMJaIb3lcA3qyz/PWEtHwXlV0ibK8gdPr7DLjw1mV1XFVPqmS10
        2H8lTrcVwaMmAtVcSs6IqPRaYtK3D85RAPTqjUPrSDE7QY+NJ5txIxOJCADEFkijNMR1ghA5vccmP
        najdLMLpkr2oXAaS9TSc2BiR+U+fnImzlUxsJx0PX+y5WO6Et96F/w5XKsZDD1QQwe4sdJ642Sw+d
        pBMxcmQuW5a34sRj+ERmREUohEqI6X2yGNVLfl2UtHsmL/IjY52E6sDwf9qK5RXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgRHT-00F3MO-0A;
        Wed, 13 Sep 2023 16:55:51 +0200
Message-ID: <51d4c1a8fe45366b4c3f2baf490ba64d8cced56f.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support
 for all power modes
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Sep 2023 16:55:49 +0200
In-Reply-To: <efa43e0a-9ef1-4989-0a45-dc6425d9b96b@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
         <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
         <efa43e0a-9ef1-4989-0a45-dc6425d9b96b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-09-13 at 18:35 +0800, Wen Gong wrote:
>=20
> This patch "[PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density
> (PSD) of the regulatory rule" does not have relation with concurrency.
> Because it only add a field "s8 psd" into struct ieee80211_reg_rule
> and ieee80211_channel. The psd value is same with other field such as
> max_reg_power.
>=20
> max_reg_power is also different value for AP and station mode in db.txt=
=20
> here:
> for example:
> "country TW: DFS-FCC" and "country US: DFS-FCC"
> # 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
> https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.g=
it/tree/db.txt#n1785
>=20
> So could you merge the "[PATCH v3 2/9] wifi: cfg80211: save Power Spectra=
l
> Density (PSD) of the regulatory rule" firstly?


Well, arguing with the regdb is kind of a bad thing because it reminds
me that nobody ever cares about it anymore ... maybe we should just give
up on it?

I mean, clearly, if you actually cared your patch here would come with
additions to the regdb format (which aren't even that hard now) which
then the wireless-regdb could actually use rather than the comment,
right?

So really all you've achieved right now is again reminding me how little
you really care about upstream?

johannes
