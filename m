Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA65133D5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Apr 2022 14:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiD1Mjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Apr 2022 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiD1Mjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Apr 2022 08:39:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699FAF1E9
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=17Jsefjifj13Rt9a4+dw888xw10yfVDbeOLKOSA8FK4=;
        t=1651149389; x=1652358989; b=dNbIUterPfWwxbKn9unw4luPJkczgbPjCSwbiJNrWq60k16
        vkigxo/9qWRksrVTOnbQb7kfGcKC8z2d9IzffJWS2LdKwGtKvxvNY03KQTMEjaD9J7XIt6BHDATnj
        SF797YjCZlce3lDEdpAgziBaB+h7g7BmoeXotze+jxkpKxuyUwIL0DzVLAy97gbwL3nTyicMT2ldG
        NSmREd08owq6vw26VxCtpysNRvdjRJzzan9VrOhrFlZqPcuZgzX99gRmkBYhoxjMqPqJ0JQ3Q1+tP
        7jRxtNK5rCYEfJpAnMWwtXX7TuY3H+NGH9UztXGMdwuH0TfHD7QeJoQFBGaVmnig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nk3Nj-00GQhn-0D;
        Thu, 28 Apr 2022 14:36:27 +0200
Message-ID: <ff39ff9b6b1a6619ab30118e8a76b43ad2b9a715.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] cfg80211: do some rework towards MLO link APIs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>
Date:   Thu, 28 Apr 2022 14:36:26 +0200
In-Reply-To: <6b40798e349d11e495a6df20ecba479a8357dad2.camel@sipsolutions.net>
References: <20220414145522.116716-1-johannes@sipsolutions.net>
         <f137ca7f-8b59-3368-c666-247f83d80383@quicinc.com>
         <6b40798e349d11e495a6df20ecba479a8357dad2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-04-26 at 09:16 +0200, Johannes Berg wrote:
> 
> > The proposal to have some sort of mapping between local and OTA link
> > will work. So in AP mode, it is OTA link_id but in STA mode, it is
> > local 
> > link_id which does not change the life time of the STA link
> > interface? Will that be still called link_id or something which
> > means 
> > pseudo link_id (something like link_idx?) to avoid confusions with
> > OTA link_id?
> 
> I started calling it link_num later, but that might also be confusing
> and misinterpreted as num_links or so? ...

However, I'm starting to have second thoughts on this.

I do understand the concern that Jouni mentioned, that the device might
roam by itself, and change the underlying links, and you'd have races if
you identify only by the link ID, and that just changed, and so now
you're referring to something else. His suggestion was that we might
need to include the BSSID or the address of the AP MLD, or such, in some
cases. [1]

However, if e.g. roaming is offloaded but the supplicant isn't, then we
really do need the ability to refer to the link ID, e.g. to set the per
link GTK/IGTK/BIGTK after the 4-way-HS (or later 2-way-HS).


So now I'm wondering what we're achieving by having a mapping, if every
component in the system needs to be aware of the mapping?

johannes


[1] Now that I'm writing this, I'll also note that basically such
offloaded MLO-aware roaming basically means all the previous things we
discussed with netdevs or wdevs don't work either?
