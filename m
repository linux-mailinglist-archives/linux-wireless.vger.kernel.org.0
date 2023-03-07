Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C476ADB6A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCGKI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 05:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGKIY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 05:08:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDA93CE34
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 02:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RlWB/D9k1qwKsQ+RK0fIddhmn+ijgdb9pn4HbzaBGP4=;
        t=1678183704; x=1679393304; b=d7myOeJzTau5ZQgk5+V+Ko8YEsKA7cWiRoPkSr04PqILe3D
        BWDcO67NmFu02nrjaeRHkzdhCPo5QjKWL7WgrPqmTXtKnu0N65ZyQDiZOUWoVyIrgLq6iXM8fNLo8
        2wmFx60fd4uQU5RIzxFfUfKo8A/qtj+190iCyDNDEty1/X8yQqm6F53ErDfROG1Z3MwRsdqU6fhrG
        owr+ValI6IWx1lbUGk429axawElipDlaoumPgYNi3GbY1oGqk+VaxoNrPSTooLBOyNV9dZy51V5eC
        Pe+k9Q/p1uRWN/fRDUOVWo0khJJWZw3riTC2h2hIo8ePTGkd7ZWSn6EmHD6mVj+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pZUF2-00EI4T-38;
        Tue, 07 Mar 2023 11:08:21 +0100
Message-ID: <3e20bade92b97c7b441f18c7e12e12eaee519481.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] wifi: mac80211: add LDPC related flags in
 ieee80211_bss_conf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Tue, 07 Mar 2023 11:08:20 +0100
In-Reply-To: <1de696aaa34efd77a926eb657b8c0fda05aaa177.1676628065.git.ryder.lee@mediatek.com>
References: <8d9966c4c1e77cb1ade77d42bdc49905609192e9.1676628065.git.ryder.lee@mediatek.com>
         <1de696aaa34efd77a926eb657b8c0fda05aaa177.1676628065.git.ryder.lee@mediatek.com>
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

On Sat, 2023-02-18 at 01:49 +0800, Ryder Lee wrote:
> This is utilized to pass LDPC configurations from user space
> (i.e. hostapd) to driver.
>=20

I'm applying this, but could you do me a favour and check that we really
don't need to reset this? What if we added a previous BSS with e.g. VHT
and then reconfigure the interface to w/o VHT and then the settings
might stick?

More generally, it might be worth checking if we can just memset the
entire bss_conf to 0? We already do this for link conf today (always
reallocate it) so it should be OK? Same actually goes for client mode so
maybe we can generally clean that up?

johannes
