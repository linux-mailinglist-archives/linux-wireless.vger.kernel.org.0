Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9F3B18B4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWLTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 07:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFWLTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 07:19:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98CC061574
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 04:16:47 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lw0s5-00AXaj-0H; Wed, 23 Jun 2021 13:16:41 +0200
Message-ID: <f14e6e6b81978ace4580774981a7e032b4001182.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/3] nl80211: Add support for beacon tx mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Wed, 23 Jun 2021 13:16:40 +0200
In-Reply-To: <1623164855-15910-2-git-send-email-mkenna@codeaurora.org> (sfid-20210608_171052_201356_8AEA5406)
References: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
         <1623164855-15910-2-git-send-email-mkenna@codeaurora.org>
         (sfid-20210608_171052_201356_8AEA5406)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

First, I'd like to see some input from other vendors - is this useful?

I have no objections to it and it comes with an in-kernel driver, so I'm
inclined to accept it, but maybe we should have other modes, etc.?


> + * @NL80211_ATTR_BEACON_TX_MODE: used to configure the beacon tx mode as
> + *      staggered mode = 1 or burst mode = 2 in %NL80211_CMD_START_AP or
> + *      %NL80211_CMD_JOIN_MESH from user-space.


This should refer to the enum, not the hard-coded constants.
> 
> +/**
> + * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
> + *      Used to configure beacon staggered mode or beacon burst mode.
> + */
> +enum nl80211_beacon_tx_mode {


That's missing kernel-doc, and you also don't specify what default
means. Why is it even here?

> +	[NL80211_ATTR_BEACON_TX_MODE] = NLA_POLICY_RANGE(NLA_U32, 1,
2),

That really also needs to use the enum, not hard-coded constants...

johannes

