Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0646B9DC3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCNSBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCNSBT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 14:01:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E58A76A1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YqwLMW9o8OhbOTeEoKOPmv6Sn3rbg/Vl0O8VJU1FANc=;
        t=1678816874; x=1680026474; b=m4d5yEJ79nglTUmPG6UKlTfoDSBtAcgUBm9mPuy+yhZrx5R
        raPAZLsxazAijgvLkFTrX0kE0a/CJPZRs3RwLNYHF2AGr9aRuGb+ZX5cOTRrkz7hPwpADU7d4t1MQ
        j2Inlczsu5AjfEA8g9RIm8zilgbLxqRGFRjICVX7yHu/pzV32QjQzVGC/u/gaKHGpaNYgoF2MWsXd
        Gy9TPLUsyymf2YVK/w4Oj8Srq6Z4kp1Bfu1lT8CMbL+isA0i/FyGAntuRWj6Bb4/LkpJycltWUavA
        bNd6nb5U9ZEz6tTw4GO5e+m917eULH8vBlxsfmr68fUV/mFGgjjJSBRIrHFYL4rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pc8xR-003Gtv-1y;
        Tue, 14 Mar 2023 19:01:09 +0100
Message-ID: <83bf8289759699bdb1abfb88c85866d4d09b0c1c.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] wifi: mac80211: add LDPC related flags in
 ieee80211_bss_conf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <Ryder.Lee@mediatek.com>
Cc:     Shayne Chen =?UTF-8?Q?=28=E9=99=B3=E8=BB=92=E4=B8=9E=29?= 
        <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?= 
        <Evelyn.Tsai@mediatek.com>
Date:   Tue, 14 Mar 2023 19:01:08 +0100
In-Reply-To: <dec1bb67025467efa3ffe06359f19cf03f81a1fb.camel@mediatek.com>
References: <8d9966c4c1e77cb1ade77d42bdc49905609192e9.1676628065.git.ryder.lee@mediatek.com>
         <1de696aaa34efd77a926eb657b8c0fda05aaa177.1676628065.git.ryder.lee@mediatek.com>
         <3e20bade92b97c7b441f18c7e12e12eaee519481.camel@sipsolutions.net>
         <dec1bb67025467efa3ffe06359f19cf03f81a1fb.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-03-14 at 17:47 +0000, Ryder Lee wrote:
> On Tue, 2023-03-07 at 11:08 +0100, Johannes Berg wrote:
> > On Sat, 2023-02-18 at 01:49 +0800, Ryder Lee wrote:
> > > This is utilized to pass LDPC configurations from user space
> > > (i.e. hostapd) to driver.
> > >=20
> >=20
> > I'm applying this, but could you do me a favour and check that we
> > really
> > don't need to reset this? What if we added a previous BSS with e.g.
> > VHT
> > and then reconfigure the interface to w/o VHT and then the settings
> > might stick?
> >=20
> > More generally, it might be worth checking if we can just memset the
> > entire bss_conf to 0? We already do this for link conf today (always
> > reallocate it) so it should be OK? Same actually goes for client mode
> > so
> > maybe we can generally clean that up?
> >=20
>=20
> I agree, and myabe this is a long standing issue. I think we need a
> fresh start for bss_conf.=20
>=20
> I've seen this case:
> hostapd would pass fils_interval only if (param->fils_interval), so if
> someone tries to disable it by "0" which doesn't work. Kernel should
> ptotect such case.

Yeah, that's another one of those cases ... :(

johannes
