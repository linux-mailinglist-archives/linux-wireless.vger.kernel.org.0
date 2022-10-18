Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66EC602793
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJRIxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJRIxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 04:53:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F65D1D318
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mZMYrdJe0ak55MfkV9WDpQoDddT502UmBNyt8pPDbA4=;
        t=1666083218; x=1667292818; b=hfbxZfJVfMVj56T2a+9FNJe9O5eAINFbrtZa6VeDZic7UgQ
        aAqT1XllHdAwzlTnipgyunsuap5ckDYuJLcAi8Fii8QwJT2zqsBi5SzSZ0l6danMbHszmNxkZzlza
        6ctsEeug6YJUb4KC8ZLwAfnCcQU4rYgZ+3By5MyFod91o9waUNBdR4XdTnlFzL1rI0BQHV05cpoTM
        NURDxpphtOUteUsmVDUIMhLO8Dxz8tDEmb8/n0hf2Nb3EPVMdPij6tX2unHgxfCyo4oxHwdRJOvzs
        HH2VKOS6wyNRNIYeNTu/VAYn6micMvAKb9asuMUdWZwq3UUw8dD8t/WON3jOYa9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1okiLv-00A6G2-2b;
        Tue, 18 Oct 2022 10:53:36 +0200
Message-ID: <d0994456d3a9ea00b5cc472df7822d53d189399e.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Tue, 18 Oct 2022 10:53:34 +0200
In-Reply-To: <bd6545a8-57a3-5849-52d5-c1a449ab1712@quicinc.com>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
         <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
         <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
         <3483d05c1d5a39b9243b54d9f28450344a897655.camel@sipsolutions.net>
         <bd6545a8-57a3-5849-52d5-c1a449ab1712@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Tue, 2022-10-18 at 16:52 +0800, Wen Gong wrote:
> On 10/18/2022 4:50 PM, Johannes Berg wrote:
> > On Tue, 2022-10-18 at 16:47 +0800, Wen Gong wrote:
> > > > +	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
> > > > +		/* FIXME: should be for each link */
> > > > +		trace_drv_link_info_changed(local, sdata, 0, changed);
> > > > +		if (local->ops->link_info_changed)
> > > > +			local->ops->link_info_changed(&local->hw, &sdata->vif,
> > > > +						      0, changed);
> > > I think you/someone will change here later for the "/* FIXME: should =
be
> > > for each link */", right?
> > Maybe. I'm not actually sure it's really needed, it depends how we use
> > this in the future.
> >=20
> > > It lead error/kernel crash as below while reconfig single MLO link wh=
ich
> > > link id is 2.
> > > When test with single MLO link which link id is 0, not found
> > > error/kernel crash.
> > I'm not surprised, I just worked on fixing reconfig in the last few
> > days, will post it after some more review/testing.
> Thanks.
> > So I think that might not need changes *here*, but rather a proper FW
> > restart. Which I haven't tested in AP mode though -- was the crash in A=
P
> > mode?
> It is crash in station mode.

try this?

https://p.sipsolutions.net/0652bbbbe350b126.txt

johannes
