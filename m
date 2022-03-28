Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6977E4E9138
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiC1J2S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiC1J2Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 05:28:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DAA53A4A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=l4zHrg+VvY6z7NJpxAn2hNXJpQZYfDuFP+eY2tT9H0k=;
        t=1648459596; x=1649669196; b=LF7+zLEVetkuV1a2cIVrCXRJf/BAdOvwdklRwcf/YpL2be3
        hGUTr6/ipsAOZ48r+SqtDMXulUbi/fqQQsxUs3jdMW7AUqezWefzZ6fyMD92Xv0PD0Cqa2GsIZAR1
        IMdPEWPIy5mpYNtFlYDdZjR7mEr1U6LW4Q+FxckctI5HZ5zLO//1USdqix4sD2pqP2P0c0bDTC6Nt
        ioeRDvf95BiJgqeiFNIP/EtyKhQivWvOWpPIioghp1k0XrpSgPkOh/M9+749eN80XV67S1bBXC80b
        6ETCt6jHDhczMSoPYn1LqPp2BXgzdCrGF18dyTwXqoME/AkkQmM7zRiwgKbdienA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nYldx-001WLN-Dn;
        Mon, 28 Mar 2022 11:26:33 +0200
Message-ID: <644dd3e9fdb893245e4a31d681cb534f5197e968.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: prepare sta handling for MLO support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "vkthiagu@gmail.com" <vkthiagu@gmail.com>,
        Aaron Komisar <akomisar@maxlinear.com>,
        "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Jouni Malinen <j@w1.fi>
Date:   Mon, 28 Mar 2022 11:26:32 +0200
In-Reply-To: <SN6PR02MB433497C4F6E9BD97294488C5F71D9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1648194497-15848-1-git-send-email-quic_srirrama@quicinc.com>
         <20abb029438166d02b5fb47093ea857671fa86e8.camel@sipsolutions.net>
         <SN6PR02MB433497C4F6E9BD97294488C5F71D9@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> 
> Sure, the contents of the link sta (link_sta_info or
> ieee80211_link_sta) needs to be definitely revisited.
> This RFC was to mainly conclude on the approach of splitting the
> sta_info, ieee80211_sta structs
> and how we access the link sta related info within them. I'll relook
> into the contents and add any
> link related info to link structs in next version and we can review
> that part again if any more info
> requires to be moved.

OK, that's fair.

> > > +     lsinfo = kzalloc(sizeof(*lsinfo), gfp);
> > > +     if (!lsinfo)
> > > +             goto free;
> > > +
> > > +     lsta = kzalloc(sizeof(*lsta), gfp);
> > > +     if (!lsta)
> > > +             goto free;
> > 
> > I did start wondering if we wouldn't want to move struct
> > link_sta_info to
> > mac80211.h as well, though I'm not sure what else we'd have to move,
> > and not
> > have to allocate all of these separately?
> I didn’t get this point correctly, Do you mean to merge link_sta_info
> and ieee80211_link_sta structs
> so as to avoid these two allocs?

Yes, kind of, I meant different things later as my thinking evolved over
the course of writing the email :)

> > Though if we follow them through pointers, we can still allocate
> > them in the
> > same memory chunk (just add the sizes).
> Do you mean something like,
> lsinfo = kzalloc(sizeof(*lsinfo) + sizeof(*lsta), gfp);
> lsta = (u8 *)lsinfo + sizeof(*lsinfo);
> 
> This seems fine I guess and helps to do away with the second
> kzalloc(). Can we go with this?

Need to be careful with alignment there, but otherwise yes?

> > Not sure we need to optimise anything here though.
> > 
> > Or maybe in addition or instead we should allocate an *array* of
> > links?
> > But of course only however many we actually need, regardless of
> > which ones
> > are actually active.
> The array of link pointers are already allocated as part of struct
> ieee80211_sta and struct sta_info, right?
> Did I misunderstood?

Correct. I meant that we should probably know how many links we need up
front, so we could allocate

	n_links * (sizeof(*lsinfo) + sizeof(*lsta))

kind of.

But then again that might be more complicated?


We might be allocating a lot of these - so maybe it'd be worthwile to
get a kmem cache? But we can also do that later.


> This 'deflink' approach looks very neat, Thanks. I'll update in next
> version.

:)

> > 
> Yes, this change would be part of MLO support changes.

Makes sense, so let's just update the commit message for now.

> 

Thanks,
johannes
