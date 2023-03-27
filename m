Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349C36C9EE1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjC0JFl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjC0JFB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 05:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1C1720
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KT+V6uIG4ofrfprd41e/+KLeNMkaEY3gPnoiagZ5l4w=;
        t=1679907866; x=1681117466; b=CgSLou82k6iXXdP4vty4y5tuL7Cfli6urZDOzNf5uSjiuO9
        wLUSyNbVOApcyKIUFZkwVaYVDNHXFmDeMpC1zeWsVSj9fElm2/XEpaiuh/jYHkAZOD8VMqNuC8Ewn
        Rvk9Y19v8VxNlFgV2SFce4oRuNi0333+Ux2592kDtOpRAVz452yrD25Xw1oODKRRmdBJFK/AH6AXp
        rcrnGN/s1qHQl9cJiMDMy92SAFL9P28ppLPMAP+rLVl32aUCVHfguBSboy/0Lr0afJM5xxkWOrkZf
        ixcQFP4bB8aGWrpYvgWa4BB6wFn7EF3wxxFi0ghByYpwxVuZ6g+XItfk8YOglWaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pgim7-00FcYR-33;
        Mon, 27 Mar 2023 11:04:24 +0200
Message-ID: <a20e39027ca0b89cae2259d35ff19d03c3c6951a.camel@sipsolutions.net>
Subject: Re: [PATCH 24/27] wifi: mac80211: implement link switching
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Mon, 27 Mar 2023 11:04:23 +0200
In-Reply-To: <31b91fad-bd14-b6e1-8abe-fceb66085ecb@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
         <ca5177fe-3b9f-2309-9afd-1d5e827540f7@quicinc.com>
         <50719d34bc48d816d00b56d3d9efdb59e3e51a16.camel@sipsolutions.net>
         <31b91fad-bd14-b6e1-8abe-fceb66085ecb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-03-27 at 16:40 +0800, Wen Gong wrote:
> >=20
> > > > +	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
> > > > +		struct ieee80211_link_data *link;
> > > > +
> > > > +		link =3D sdata_dereference(sdata->link[link_id], sdata);
> > > > +
> > > > +		ret =3D ieee80211_link_use_channel(link, &link->conf->chandef,
> > > > +						 IEEE80211_CHANCTX_SHARED);
> > > For the 1st link of MLO connection/NON-MLO connetion, ieee80211_link_=
use_channel() is called before drv_change_sta_link(),
> > > And now it is after drv_change_sta_link(), May I know is it also has =
some design here?
> > Hmm, probably not really, at least I don't remember anything about that=
.
> >=20
> > Not sure it makes a huge difference? But I suppose we could change it, =
I
> > don't really see why not either.
> Not huge difference, I have made little change in lower-driver to match=
=20
> that. So it is OK now.

OK. Still maybe we should change it for consistency? I can try that
later with our driver.

johannes

