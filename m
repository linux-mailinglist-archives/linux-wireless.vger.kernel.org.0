Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00F31E7CD1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgE2MKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2MKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 08:10:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E976C03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 05:10:53 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jedqa-005Usw-Hu; Fri, 29 May 2020 14:10:48 +0200
Message-ID: <aaa53c3a9cf6788cb653eb574073a1a0bcc5e6bf.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: enable TKIP when using encapsulation
 offloading
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 14:10:47 +0200
In-Reply-To: <7fb606edf1e5c7ab5b1446d637768ee7@codeaurora.org>
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
         <1587720951-9222-2-git-send-email-murugana@codeaurora.org>
         (sfid-20200424_113624_468114_4CC488DE) <d4e39180f0a8a8b07dc558c9439b66cd2c3aec07.camel@sipsolutions.net>
         <7fb606edf1e5c7ab5b1446d637768ee7@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-29 at 17:38 +0530, Sathishkumar Muruganandam wrote:

> > I don't think it can. It doesn't have all the necessary information to
> > call cfg80211_michael_mic_failure(), as far as I can tell.
> 
> Ath11k HW has capability of reporting TKIP MIC error when hw encap is 
> enabled as well, so TKIP encryption shall be enabled.

Maybe so. But it cannot tell wpa_supplicant about MIC errors, and so
that cannot do countermeasures, so something isn't right.

> Shall we have a ieee80211_hw_flags for the driver to advertise TKIP MIC 
> error reporting capability when hw encap is enabled ?
> TKIP bring-up will be disabled for the drivers which doesn't have the 
> capability.

That would be better, since for TKIP it's actually more tricky and
requires more work.

But mostly I was thinking that you should make it possible for ath11k to
actually report the MIC errors up to userspace. Right now I don't think
it can, because it doesn't have the netdev pointer?

johannes

