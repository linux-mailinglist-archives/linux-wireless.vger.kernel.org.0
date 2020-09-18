Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A626FB27
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRLIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRLIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 07:08:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A5C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 04:08:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJEFi-006DG9-75; Fri, 18 Sep 2020 13:08:30 +0200
Message-ID: <35408120e5133a4a170922af6bc33e21198c693c.camel@sipsolutions.net>
Subject: Re: mac80211: fix xmit callback when hwencap enable
From:   Johannes Berg <johannes@sipsolutions.net>
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Sep 2020 13:08:29 +0200
In-Reply-To: <1597219503-18295-1-git-send-email-ppranees@codeaurora.org>
References: <1597219503-18295-1-git-send-email-ppranees@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-08-12 at 13:35 +0530, P Praneesh wrote:
> Since transmit control port uses same callback for both
> (ieee80211_subif_start_xmit) ethernet mode and native
> wifi mode, which causes authentication issue (M2 Handshake failure)
> in ethernet mode with encryption(psk2+ccmp).
> This will also be an issue for hw/fw which doesn't support per
> packet tx/rx encap/decap.
> 
> Added hardware encap check to filter out ethernet mode
> packets to follow ieee80211_subif_start_xmit_8023 path.

This has some major conflicts with Felix's work, please check if that is
already fixing the issue. I think it is.

johannes

