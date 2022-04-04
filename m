Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980EB4F15CB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351404AbiDDNYj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiDDNYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 09:24:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2646B3DA7D
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Rew0cdTpnke9CgROpUBMb6MHmpkMBoERLKmsDQMqusQ=;
        t=1649078562; x=1650288162; b=pCrHQc0PSXtiwniy1802ZLfp9Eku/fw89cZhMk8uTn4IsAH
        ct4WQVtxZUqcDeDXdIDrGa66lUh+4n0aK77fF9W4bjBQAdWtjmp4NIGsLo6gHPix/yc9VJOmN9jAa
        Jqb9Ld7Ya9j2IlYJPs6QIEjcajhXoUVwj86uqHaJtjp7ESfGI9oE7j/rHE7IQgLuo0bwIshkekyGD
        Bia4Skv6g/HxSRl815yBtfJiwaK4nu6A0I3rZf28O95t4b6++FFJEx4zzmqwEEjl17i1wlgJtTmGW
        JGJlzc/EBcZ9M/KzYP1looiSGBC5ZEwts5FpQZajudlgLrYmL3AyE+Kunr3ZLY/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nbMfH-004tcr-R5;
        Mon, 04 Apr 2022 15:22:39 +0200
Message-ID: <467e7f83270a9b1f8e2b32f27b48607e2c2ff480.camel@sipsolutions.net>
Subject: Re: [RFC v2] mac80211: prepare sta handling for MLO support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 04 Apr 2022 15:22:38 +0200
In-Reply-To: <1648555198-8065-1-git-send-email-quic_srirrama@quicinc.com>
References: <1648555198-8065-1-git-send-email-quic_srirrama@quicinc.com>
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

On Tue, 2022-03-29 at 17:29 +0530, Sriram R wrote:
> Currently in mac80211 each STA object is represented
> using sta_info datastructure with the associated
> STA specific information and drivers access ieee80211_sta
> part of it.
> 
> With MLO (Multi Link Operation) support being added
> in 802.11be standard, though the association is logically
> with a single Multi Link capable STA, at the physical level
> communication can happen via different advertised
> links (uniquely identified by Channel, operating class,
> BSSID) and hence the need to handle multiple link
> STA parameters within a composite sta_info object
> called the MLD STA. The different link STA part of
> MLD STA are identified using the link address which can
> be same or different as the MLD STA address and unique
> link id based on the link vif.
> 
> To support extension of such a model, the sta_info
> datastructure is modified to hold multiple link STA
> objects with link specific params currently within
> sta_info moved to this new structure. Similarly this is
> done for ieee80211_sta as well which will be accessed
> within mac80211 as well as by drivers, hence trivial
> driver changes are expected to support this.
> 
> For current non MLO supported drivers, only one link STA
> is present and link information is accessed via 'deflink'
> member.
> 
> Note for MLO supported drivers:
> In mac80211 ops, the link id can be fetched from the
> passed link vif struct (TBD) and corresponding link STA
> within ieee80211_sta can be accessed. If the vif passed to
> the driver is a MLD vif in any case, it implies all
> the affliated link vif and its link STA needs to
> be handled for the particular mac80211 op.
> 
> In mac80211 for MLO usage, in cases where we need link sta(ex. to
> get MLD STA from link address in 802.11 header) needs a new
> lookup function to search for link sta address, This is TBD.
> For legacy driver too this will work directly since the
> address in sta_info and link_sta_info are same.
> MLD supported drivers need to pass the link id or link
> address and pubsta for ethernet mode to find the link sta.
> Stats are accumulated per link sta and finally aggregated
> if mld sta stats is required. These will be supported along
> with MLO support patches.
> 
> Currently in mac80211, all link STA info are accessed directly
> via deflink. These will be updated to access via link pointers
> indexed by link id with MLO support patches, with link id
> being 0 for non MLO supported cases.
> 

I think this looks fine - want to send it as a PATCH? I think I'll just
apply the spatch directly.

If there's any needed fixups beyond the spatch that might be good to
know too.

johannes
