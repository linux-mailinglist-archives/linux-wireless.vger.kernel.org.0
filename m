Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED77656CA6
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiL0Pmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Dec 2022 10:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiL0Pmx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Dec 2022 10:42:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00DFE4
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 07:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=J67c3rAWPH98VZ86a9tvtc5Mk97oFpLjHkqZdMxqAws=;
        t=1672155772; x=1673365372; b=x8HiWp35+epnt12b7ceYXgEFTAGX8+3xuZAuuXUb4b7cyA4
        yWfRDVZdqypPeJF1WC3V6GoIAUUGWvs2xlNyjwu80Siifz6D9rHt1EDUgGbjI2u0ZLVksM30Cc6ak
        oPcFD2sCKAQqlzkI6EilwuZhydhEu6eMnwm3kDRJvlJqR3RLGuY1sHBw9Fn6sHO+MlkkR3WGrc6Ah
        WdX2FyCTsF6dKIRCkJnxBj9HWsVStPvsMijVpjc8VbCzHdnOzKDwsyoPUJq7kaiWiLCtFLdA/bx+I
        f3zWo61eBjl0Ys3BhnoCP6xH0jmctnrTAfvDttVpRz9neIfihKX38I8BcvBXIBIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pAC6L-0026DQ-2T;
        Tue, 27 Dec 2022 16:42:49 +0100
Message-ID: <a4507149db27f761e0edb228623103711dd9a6fd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Allow NSS change only up to capability
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 27 Dec 2022 16:42:48 +0100
In-Reply-To: <DM6PR02MB4937DDAF64A4880FD81C11CDE9ED9@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <20221018044341.5453-1-quic_ramess@quicinc.com>
         <b763a390dedff804015a540f097bf804ed0e1436.camel@sipsolutions.net>
         <DM6PR02MB4937DDAF64A4880FD81C11CDE9ED9@DM6PR02MB4937.namprd02.prod.outlook.com>
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

On Tue, 2022-12-27 at 08:04 +0000, Rameshkumar Sundaram (QUIC) wrote:
> >=20
> > > +		if (nss <=3D link_sta->pub->rx_nss) {
> > > +			link_sta->pub->rx_nss =3D nss;
> >=20
> > That, however, doesn't seem right. It means that you can only ever
> > reduce
> > the RX NSS, not switch it around within the originally negotiated
> > range.
> >=20
> Not sure if I understood you comment.
> We reset Sta's rx_nss

I don't see where it's being reset?

The way I'm reading this, you check nss<=3Drx_nss and then set rx_nss=3Dnss=
.
I didn't see any code that sets rx_nss higher, but maybe I missed it?

So if say rx_nss is 4, and nss is 2, then we set rx_nss to 2. But now if
the AP wants to switch back to 4, nss will be 4, rx_nss will be 2, and
the change is ignored, no?

johannes
