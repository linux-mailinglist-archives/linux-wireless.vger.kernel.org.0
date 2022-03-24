Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6355E4E61DB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 11:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbiCXKi7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCXKi6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 06:38:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C874C9AE4A
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=va1oP4T7WdMOkd/Kw/kULCNEZrp5uyYAnnzOUTTlClA=;
        t=1648118246; x=1649327846; b=fp/dnvKq6c7eLdZTiV3xDGjwB2OveRGjaD6A4vUu590q7GJ
        Vr6GvROCH7GVqxT3ziusXtiRPOiN4o1hyDHdIe+xtMO34x/x4x+XGL+v/qywKjMXNxCrfhqyPAqhY
        eJbo3zFqCZ4LNq/EjK4ZHK4O8Elu2twZ8tVOE24QxJfcO3jhqd/s+sqPojjd3QWvV1vhaHhkZQttB
        8+bJwZkPyf7kQmGn0NmAeK+KKTiXNHdElKGYf2VYUYJ8v4nxfwcuFSL8NF3HopAGONVSGOT4mj4PD
        gR3Mjfnq9pAgQ9U2FJWdZ904n44RwOhnpoDiXoCnc36ynJnqyafbuhHylF5+Oplw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nXKqK-00HTGM-Jo;
        Thu, 24 Mar 2022 11:37:24 +0100
Message-ID: <1b1976bd936be8530cac9a55726382450f691e3f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/4] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 24 Mar 2022 11:37:23 +0100
In-Reply-To: <20220323191640.31230-2-quic_alokad@quicinc.com>
References: <20220323191640.31230-1-quic_alokad@quicinc.com>
         <20220323191640.31230-2-quic_alokad@quicinc.com>
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


> + * @ru_punct_bitmap: RU puncturing bitmap. Each bit represents a 20 MHz channel
> + *	with lowest bit corresponding to the smallest frequency. Bit set to 1
> + *	indicates that the channel is punctured, otherwise the channel is active
> + * @ru_punct_bitmap_supp_he: Indicates whether RU puncturing bitmap validation
> + *	should include OFDMA bitmaps.
>   */
>  struct cfg80211_chan_def {
>  	struct ieee80211_channel *chan;
> @@ -750,6 +755,8 @@ struct cfg80211_chan_def {
>  	u32 center_freq2;
>  	struct ieee80211_edmg edmg;
>  	u16 freq1_offset;
> +	u16 ru_punct_bitmap;
> +	bool ru_punct_bitmap_supp_he;

I don't feel we finished the discussion on why it should be in the
chandef.

On the one hand, I can see how you argue that it's a part of how the
channel is defined, after all, this is now in a sense different from the
non- or differently-punctured channel since some parts of it are "gone".

This makes saying that two chandefs are only identical if also their
puncturing matches completely sensible, as seen in the changed
implementation of cfg80211_chandef_identical().


On the other hand, however, I don't think this makes a lot of sense with
mac80211's channel contexts, and especially not in a client-side
implementation. If you were to e.g. have two simultaneous connections to
two different APs on the "same" channel but different puncturing
configuration, I'm not convinced it makes sense to treat that as
requiring two entirely separate channel contexts and have to go to
powersave on one AP to receive on the other etc.? At least from my
(Intel HW) POV that doesn't make much sense.

As a result, we treat the puncturing more of a bss_conf type thing, and
we indeed have a patch to do that for the client side, which I should
get sent out so we can have a better discussion about both sides.


But honestly part of that probably is that I don't really entirely
understand the need for puncturing in the first place.


(and also, you included all kinds of random other things in these
patches, specifically in nl80211.h, so there's no way I can apply them
as is anyway)

johannes
