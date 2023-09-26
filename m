Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039E7AE982
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjIZJpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjIZJpt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 05:45:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E6FBE
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cKtdQqDRUJj7y/VLgZzxcJrmVo/eQVJf4ZnkNLE6taM=;
        t=1695721542; x=1696931142; b=lZAke8xHmlH8AdciDVEhtzCd2nvkYAAnhCctv5NlTNHrZ2y
        0Upg/k7Ix6vDBDiVcEEavcG9XgN3tP/WblFu0Or24QDPpG4mMxQBLkwpZOIYxaoIo7r2Ain/C3v5M
        7Pd3GXMGmUspHHdlz9OmrvT2c/U6v92hbsy3+Inz5KYMlyrMCQfUxY/eq3p6aQlI2x/ZOhb+/Wgpy
        Z/X4mEkjbff3rvthk9M2ddNBbKV/ECIvOsqn5dwyB0ELugHbiTVfHc1HQilfprXt/wOjyiIyjNWWi
        0EjOju0ePZm4S9Ok56hKskFe4XXP4cCfDe1MoH1DJVoSWeD7qAG8MYoFNd6MWszg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ql4dN-005Rpq-16;
        Tue, 26 Sep 2023 11:45:37 +0200
Message-ID: <4dac29f3844309fb62afe6acd4c4ebd379b0a194.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: mac80211: add support to allow driver to
 generate local link address for station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 Sep 2023 11:45:36 +0200
In-Reply-To: <d23b617e-5ca0-e721-0c2a-fcca8942efef@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
         <20230906103458.24092-2-quic_wgong@quicinc.com>
         <cd762f33b1c15566237c85f1e265ee8a00006f5c.camel@sipsolutions.net>
         <d23b617e-5ca0-e721-0c2a-fcca8942efef@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Fri, 2023-09-15 at 16:11 +0800, Wen Gong wrote:
> On 9/13/2023 4:55 PM, Johannes Berg wrote:
> > On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
> [...]
> > Maybe after all this explanation, all we need is a flag "reuse MLD
> > address for assoc link"?
>=20
> yes. It is similar as I said before here:
>=20
> https://lore.kernel.org/linux-wireless/b9c6d022-12c3-a696-c4b9-cb14a6d30a=
45@quicinc.com/
>=20
> >=20
> >=20
> > > +		ret =3D drv_generate_link_addr(sdata->local, sdata,
> > > +					     link_id, link->conf->addr);
> > > +		if (ret)
> > > +			eth_random_addr(link->conf->addr);
> > should probably refactor this into a separate function though.
> OK.
> >=20
> > I'm also not sure how the driver even knows that a link it's being aske=
d
> > to get the address for *is* the assoc link? Do you want to rely on that
> > being the first address handed out?
> Current I used (vif->valid_links=3D=3D0) check for assoc link. When
> drv_generate_link_addr() called for the assoc link, vif->valid_links
> is 0, and it is not 0 for other links.

That seems a bit questionable?

Well then again, what do you want for AP mode? Anyway you can still
distinguish, and if we later need to change an internal API that's not
the end of the world either ...

So OK, I guess we can live with this, just would like to see it wrapped
up into a single function.

johannes
