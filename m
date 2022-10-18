Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69D602788
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiJRIuj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 04:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJRIua (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 04:50:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F51474C7
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iczZLwrjd7qnO0JGrmafBUJ/nSM8K8ORSyalNpGMBFs=;
        t=1666083016; x=1667292616; b=xJc84HYqaaXRirWdc272vPUoQ6i946B69Ng3p3vYF6h3Jhm
        oq9ehJ0ZZ7pTb77sN7C2NARxeAeC3nRARtl+4EYfTirnAGC8RGNXa7XBsud3k4fihW7fictyN3I6T
        xpgwUBep6uxQ3iT1xgw7ShZQBXYwtY6vJH0Q7eL2mubaZvSvKlS6kE+DPLV5SHB8EtnpKrE+HVHD4
        2x8OgomFmlDWJoL1Ynndg0pd/9z4mv2hhEDhfSLYGNcKrKMAd/dJRAhfSTg83vN26BNryRwwyKdgy
        gJUs77mHdNPpsAYmGw/CFfr6PrFGr4jvHyLylcxCzO02tjZCY1CbEPOs3JzfEPYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1okiIe-00A6BU-0z;
        Tue, 18 Oct 2022 10:50:12 +0200
Message-ID: <3483d05c1d5a39b9243b54d9f28450344a897655.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Tue, 18 Oct 2022 10:50:11 +0200
In-Reply-To: <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
         <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
         <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
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

On Tue, 2022-10-18 at 16:47 +0800, Wen Gong wrote:
>=20
> > +	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
> > +		/* FIXME: should be for each link */
> > +		trace_drv_link_info_changed(local, sdata, 0, changed);
> > +		if (local->ops->link_info_changed)
> > +			local->ops->link_info_changed(&local->hw, &sdata->vif,
> > +						      0, changed);
>=20
> I think you/someone will change here later for the "/* FIXME: should be=
=20
> for each link */", right?

Maybe. I'm not actually sure it's really needed, it depends how we use
this in the future.

> It lead error/kernel crash as below while reconfig single MLO link which=
=20
> link id is 2.
> When test with single MLO link which link id is 0, not found=20
> error/kernel crash.

I'm not surprised, I just worked on fixing reconfig in the last few
days, will post it after some more review/testing.

So I think that might not need changes *here*, but rather a proper FW
restart. Which I haven't tested in AP mode though -- was the crash in AP
mode?

johannes
