Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB192436656
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhJUPej (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhJUPei (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 11:34:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0883C061764
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ie2gv88dsVHgt90C1FoqdEni8oAOuvExB71ATz3Cvsk=;
        t=1634830342; x=1636039942; b=DrFkS0oiLlS7je/J4eRkckOObzyGbvzao1YRf6S7HajZpKT
        aMOpfc0P9+dgYEWJ7U9x0aoRcUmYOERrSG9PnFZEM7SNtACz6zQoouAhcxmdwTQ6Raa6GuH0wHdtq
        qw9AmVeR8g1VRRzvk9eKieieepmkJOVCoAjTeG2Gq03XFnFJIwSOqwATPfgDYyzkQAfZIw/tPV9MP
        m2SbkpKND69288RFwahI1X8TGyT0dp8Le17TBp5mkwQYyOMN7KAH4marcFVfwPP234wGFYjr7wX6H
        xWwR22N40seohAe+hlPdr3LKxcbbxSIaRyKJRAbFC6BM2L4RoZfWzs6Zg9oMtxWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mda3J-005K5Y-85;
        Thu, 21 Oct 2021 17:32:21 +0200
Message-ID: <612e80125878bae6fccbb72701381832a8a6029c.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Indicate SA Query procedures offload for AP
 SME device
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <vjakkam@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 21 Oct 2021 17:32:20 +0200
In-Reply-To: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-10-14 at 16:48 +0530, Veerendranath Jakkam wrote:
> Add AP SME device feature flag to advertise that the SA Query procedures
> are handled in driver.
> 
> If this flag is advertised SA Query request or response frames from peers
> are not reported to userspace. Thus userspace components shall skip SA
> Query specific validations.
> 
> Ex: When AP started with Operating Channel Validation(OCV) support and
> channel switch occurs, hostapd starts SA Query timer for OCV enabled
> STAs. Hostapd sends deauth to the STAs which didn't send SA Query
> request before timeout, Hostapd can skip such validations when this flag
> advertised.

So how's that going to work with older hostapd? It'll be offloaded, and
then hostapd doesn't know, so it's still going to disconnect them?

So should be that hostapd also opts in to this driver behaviour?

Also ... it _really_ would be good if there were upstream drivers with
these things ...

johannes

