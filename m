Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3B519DB8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348578AbiEDLS3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 07:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347697AbiEDLS2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 07:18:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453726110
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iUj47hOsQY4WwZXF5zIQ8HlvN/uG2gB6rA9TwZr7GM8=;
        t=1651662893; x=1652872493; b=e9vEulpkclEh6bdomp3B8O2QXZsrfgtgPO03a4pznFa1Rgl
        QniwHuZBl88kTtuwQrmTEaGqRAAYzmieQ1lfPrHzw68AGEIx1c4HSu9YpfNQ6MXy+9vsvIzrp9x/s
        onRKosLYw3lkOfH1kEEcl04zytNl1edXO3sSx/EagNd7lxUKhNyNKCl+CtlEbdEWExkBCXpVxHOyQ
        /n5tokt6fS0pl5WSaCx27UJJewBf21IqXdB7DjPfyfi1P2B4fXOCGtcHxw3CbZaWWwe4QXPs0azyX
        oj6O9VQmekIfDOPt8yikEda/Yas3XjmaSs7+VX/Zr7slZ5JYpeaJ+GjzRpZxTbfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmCy3-0020xz-Nw;
        Wed, 04 May 2022 13:14:51 +0200
Message-ID: <1c08cc9fca6e0a5f8fe02c7324a28ea2ad818354.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/3] nl80211: Extended ROC support for 40-80 MHz
 bandwidth
From:   Johannes Berg <johannes@sipsolutions.net>
To:     P Praneesh <quic_ppranees@quicinc.com>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Date:   Wed, 04 May 2022 13:14:50 +0200
In-Reply-To: <1647857797-19749-2-git-send-email-quic_ppranees@quicinc.com>
References: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
         <1647857797-19749-2-git-send-email-quic_ppranees@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Mon, 2022-03-21 at 15:46 +0530, P Praneesh wrote:
> Replace struct ieee80211_channel with struct cfg80211_chan_def in
> remain on channel apis, because the channel width information is
> needed to handle centre frequency of 80MHz, and it is available
> in cfg80211_chan_def. Also, add SUPPORTS_EXT_REMAIN_ON_CHAN feature
> flag check before driver ops call.

Couple of more things ...

   1. Please split this into cfg80211 / mac80211, many of the changes
      are related to mac80211, but also many related to cfg80211 only
      (all the fullmac drivers), so I think it'd be nicer to have it as
      two separate patches.
      
   2. You're not exposing _any_ such capability to userspace, so when
      userspace requests a wider channel but not supported, it's
      silently ignored for all the cfg80211 drivers. OTOH, for mac80211
      drivers, you reject a wider channel. This can move up to cfg80211.
      
   3. Why limit (per the commit message, not sure about the code) to 40
      and 80 MHz, rather than allowing any bandwidth? Maybe somebody
      would want to use even smaller bandwidth (5/10)? Perhaps drivers
      should expose a bitmap of permitted bandwidths (rather than a
      single flag indicating support)?
      
   4. At least in the brcmfmac, mwifiex and wilc1000 cases, not only do
      you ignore the bandwidth, but you even pretend in
      ready_on_channel() that you used it ... that seems even worse than
      just ignoring. Also, in some of those cases you send it as higher
      BW in the ready event, but lower BW in the expired event ...
      
   5. (I don't want to know what happens in that staging driver ...)


johannes
