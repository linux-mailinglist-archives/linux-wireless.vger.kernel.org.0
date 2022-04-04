Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9995C4F18DE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378730AbiDDPxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378826AbiDDPxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 11:53:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC54248B
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KLAglIQLC5mZOvfORauLKyjUpYWhLgwb8Wn0QZTaqCo=;
        t=1649087481; x=1650297081; b=bsjPP0zTUo8qeu9iu7N5P2LjGM0Ha2JUc6tkf7EkjyYbkx1
        FgRY82wyEjk26txsEfOO9W9iY/3xD8Gr5qAJBndF0xmVhYn4LpKYcnkk0okudpJL7QOodHhTQbGkp
        iDeK6NYmE2Ha0s+cpXCYu150vBpGiKq51u3WcKZrV1EE3iKLDkwo8xxoJmn+jwbbgo/7gn8bTYAxU
        EtIuC3y/paN87CcVC3+ADF0lA65GtD76qDvGJz3HkAigpMSdSJNFeLABwxi8Bv3dbS5CyOVm9TM7w
        eoViAMOpJ/V85UthTUwc4INHK8OKSPDzjKRlkL3eLsHJctz4DzxuJ8A6Kxa5Hg0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nbOz9-004yIh-Sa;
        Mon, 04 Apr 2022 17:51:20 +0200
Message-ID: <1524068599dffb64456ce5032a0cce834ef2f21f.camel@sipsolutions.net>
Subject: Re: [RFC v2] mac80211: prepare sta handling for MLO support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 04 Apr 2022 17:51:19 +0200
In-Reply-To: <SN6PR02MB43347C8B21DA6B7F3D6F0A92F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1648555198-8065-1-git-send-email-quic_srirrama@quicinc.com>
         <467e7f83270a9b1f8e2b32f27b48607e2c2ff480.camel@sipsolutions.net>
         <SN6PR02MB433476576476A9AA7EAF3F95F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
         <f73b62ea7f04899db5e49c9722e99ba31172f787.camel@sipsolutions.net>
         <SN6PR02MB43347C8B21DA6B7F3D6F0A92F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-04-04 at 15:50 +0000, Sriram R (QUIC) wrote:
> > > Hi Johannes,
> > > > 
> > > > I think this looks fine - want to send it as a PATCH? I think
> > > > I'll
> > > > just apply the spatch directly.
> > > Sure, Let me send out a PATCH shortly.
> > > > 
> > > > If there's any needed fixups beyond the spatch that might be
> > > > good to know
> > too.
> > > So, in this patch (mac80211) I had to manually fix couple of
> > > changes around
> > ADD_STA_STATS, TRACE_EVENT macros.
> > > 
> > > In drivers, only below change was required in addition.
> > > 
> > 
> > Nice! So if you include all the manual bits, you can also leave out
> > mac80211 changes from the spatch if you like, I'll just run the
> > spatch when
> > applying it so we have it on the exact tree snapshot.
> I just sent out the patch version, I'll send v2 with only the manual
> mac80211 changes, so running the spatch on top should help compile
> seamlessly.

You know what, it doesn't matter. I can put the pieces together, no
worries.

johannes
