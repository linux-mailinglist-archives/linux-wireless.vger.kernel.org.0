Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDBD463401
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 13:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbhK3MUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbhK3MUA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 07:20:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FA6C061574
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 04:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cfQB8kpiUSYfBmijtvJZ+QjTA17mKXMbku6bMkjkomI=;
        t=1638274601; x=1639484201; b=sP2QHjtN0yfFFf/3+f5K77zJgvtjyll94wKQGE8VOborujE
        eFj95wZ/pz4kph/epmmxaql3A3FREoPue3zb4L5sA2NCzkrjNQb7J2+NSkCVoWholUGRg4iSH22yR
        QJU3lWDhDps+mgp2jv2jqhLTS2jiFHTsRzDVA7bCU+98BIwlonfWahTY5HxAgTrfKwQ2sLXoBOBNs
        DN2WE1Qt7bIeOXObc+Ac5B/XbvP/3dWfIja2/iJG+W0RC5cbuYBBkdDWSJ/NqgHKDWQUHQ2fnSCcu
        /BK862Foe2w1KCQ304tyKCbPoJTCaXc5OhxYtkFMNNJTVjLj3RQ6EaxCaJOdXbtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ms23l-004uU8-59;
        Tue, 30 Nov 2021 13:16:33 +0100
Message-ID: <e1e6a44581a711750d205f5d7f1ee68faf3e07aa.camel@sipsolutions.net>
Subject: Re: iwlwifi suspicous RCU usage warnings with kernel 5.15 and
 5.16-rc3
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chris Murphy <lists@colorremedies.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 30 Nov 2021 13:16:32 +0100
In-Reply-To: <CAJCQCtStsk8_a+p819g4WJf0hJAokJiMeEeouaMpw8ar5_PH8g@mail.gmail.com>
References: <348f1b9c-f1b4-8a01-873f-9749f1070808@redhat.com>
         <CAJCQCtStsk8_a+p819g4WJf0hJAokJiMeEeouaMpw8ar5_PH8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-11-29 at 15:12 -0500, Chris Murphy wrote:
> On Mon, Nov 29, 2021 at 7:39 AM Hans de Goede <hdegoede@redhat.com> wrote:
> > 
> > Hi All,
> > 
> > Since kernel 5.15 (IIRC) I've been getting a suspicous RCU usage warning
> > from the iwlwifi driver when running a kernel with checks for this enabled.
> > 
> > Note this is the 2nd or 3th time this happens now, can we please get
> > some CI checks for these (assuming there is some iwlwifi CI already) ?
> 
> I mentioned it back in October ...
> https://lore.kernel.org/linux-wireless/CAJCQCtR28JZaqNC053jEpoZGN37kRK9ReYX0Kt8+ukRGnO5z_Q@mail.gmail.com/
> 
> And it's still happening with 5.16-rc3 out today.
> 

We have this code:

static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
{
        int ret;

        rtnl_lock();
        mutex_lock(&mvm->mutex);


but internally we already have

static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
{
...
        rtnl_lock();
        wiphy_lock(mvm->hw->wiphy);
        mutex_lock(&mvm->mutex);


so that's surely the issue - Luca, do you already have any patches for
this out? It was internally through a merge, so no explicit change, and
I guess upstream I forgot when doing the RTNL work?

johannes
