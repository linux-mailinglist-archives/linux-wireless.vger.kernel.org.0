Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDA682877
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjAaJPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjAaJOv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:14:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F8172B
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wHpyEmUDwtWILP/PZi9ibazx/yx6gRrjsYE8DG/i8M4=;
        t=1675156349; x=1676365949; b=r/8Z6OEnIJ6/YlsYMt6J1uUv8iQrfAo+s55BcaF7XhZBPtK
        qmHA06rgqgkqolCOjfVSF0Qd2ThE8/53j+CJpfY4KuKFnjBgw/UavFzIsHoAaFeH+pUuHzSU8SZSE
        3lDizwn1wUXDWUVDQ/uVSnmE2p579/NORbyxE8Fw2pxr7oMehBv0KRqvyHC9c/vDhS+EB26m5wkWa
        u5BGbiLq5fmXoeiZdulGkWDz8SKxqrEpQROELFFO6EY4vw1sWic4A5a7UPXWuUs/+hgDP6329ZNL5
        ayEfNzPyB1e9VHD5IuZrxdfsCdoI3BE1EB2EknTMZNI799u5v7TIKQ5/rzV9ru/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pMmgc-00Gulb-2T;
        Tue, 31 Jan 2023 10:12:18 +0100
Message-ID: <958c5e666aaab3b18065c1e1c140c9ea34f2229c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: call reg_notifier for self managed
 wiphy from driver hint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 31 Jan 2023 10:12:17 +0100
In-Reply-To: <31632d31-8c98-081f-bcf4-0966efe1256a@quicinc.com>
References: <20221214093937.14987-1-quic_wgong@quicinc.com>
         <0881ee1d0ae43ae18ab4b71ec8b5fd62263bbb69.camel@sipsolutions.net>
         <31632d31-8c98-081f-bcf4-0966efe1256a@quicinc.com>
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

On Tue, 2023-01-31 at 14:07 +0800, Wen Gong wrote:
> On 1/19/2023 9:52 PM, Johannes Berg wrote:
> > On Wed, 2022-12-14 at 04:39 -0500, Wen Gong wrote:
> > > Currently the regulatory driver does not call the regulatory callback
> > > reg_notifier for self managed wiphys. Sometimes driver needs cfg80211
> > > to calculate the info of ieee80211_channel such as flags and power,
> > > and driver needs to get the info of ieee80211_channel after hint of
> > > driver, but driver does not know when calculation of the info of
> > > ieee80211_channel become finished, so add notify to driver after
> > > reg_process_self_managed_hint() from cfg80211 is a good way, then
> > > driver could get the correct info in callback of reg_notifier.
> > Seems reasonable - but maybe unexpected to some drivers, perhaps it
> > should be opt-in?
> >=20
> > Though I guess not many drivers actually use this infrastructure in the
> > first place?
>=20
> Yes, I will add a new flag such as WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER=20
> for this driver.
>=20
> is it ok?

Sounds OK.

johannes
