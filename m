Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD834B3DFA
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Feb 2022 23:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiBMWYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Feb 2022 17:24:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBMWYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Feb 2022 17:24:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106215468F
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 14:24:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2760B80B9B
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 22:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DC7C004E1;
        Sun, 13 Feb 2022 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644791076;
        bh=rD6gVRjTus8UCiZIuVKbJoQ0i+qpSAAMv7dNa3mNSxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NK0ggFltQo9R710DUZ4PMXjRto5pxSBB3H+Q3IZR3zgSXbnqhaw5oBHsPSQ8Lch8c
         XBrXC4GZds/vdYPAB3qEFGSl0r0WTu1VtolafQFwbC6m1bNKdEAQv6jkp2f01w54hy
         za4+trtM9P6v98kOJbLpQTGMAeIqyo14CZ0TdgHEd1BPippUSF2Um803HIjJoFNLnT
         ogKf4RcnPUwesGacAFzLGixPoRIwis5+xteTiSxU+a3HVUZ+ANNv5nu26TqwcngaGC
         TvC0TSEDGU+omtBZSwjde3RkfUW36XFu3zNmSYwn22pbJc/B+zPTNsaejxcPuJreDP
         RN20mOLf4mIag==
Date:   Sun, 13 Feb 2022 16:24:35 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4] wireless-regdb: Update regulatory rules for South
 Korea (KR)
Message-ID: <YgmFI3MrtZl3jSa9@ubuntu-x1>
References: <20211212152050.25962-1-mans0n@gorani.run>
 <20220130124907.39224-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130124907.39224-1-mans0n@gorani.run>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 30, 2022 at 09:49:07PM +0900, Sungbo Eo wrote:
> This patch is based on MSIT Public Notification 2021-86 ("Unlicensed Radio
> Equipment Established Without Notice"), officially announced on 2021-11-29.
> 
> The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
> part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
> This leads to the following:
> * 5230-5250 @ 20 -> 17 dBm
> * 5210-5250 @ 40 -> 20 dBm
> Here the power limit for >20 MHz bandwidth is also lowered to 17 dBm, as
> it's not possible to set different power limits for different bandwidths
> at the moment.
> 
> Extend the last 5 GHz frequency range to 5850 MHz.
> 
> Wi-Fi 6E is now allowed with the following restrictions:
> * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 2 dBm/MHz PSD
> * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25 mW EIRP
> Here only the former entry is added.
> 
> And also update the regulatory source links.
> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>

Applied, thanks!
