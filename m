Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0461E591B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 09:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgE1Hlw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1Hlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 03:41:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB482C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 00:41:51 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeDAh-004iR7-Rs; Thu, 28 May 2020 09:41:47 +0200
Message-ID: <6a606d4e32d6eb00b33f5ce8ad44a71994640c7d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 01/11] cfg80211: use only HE capability to set
 prohibited flags in 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Vamsi Krishna <vamsin@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org
Date:   Thu, 28 May 2020 09:41:46 +0200
In-Reply-To: <0fa1c07811796add4a6a23c81cbafe41@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <7f2a2a382c42b7285b9ad1eeac4e8060bc8d897a.camel@sipsolutions.net>
         <0fa1c07811796add4a6a23c81cbafe41@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-27 at 16:32 -0700, Rajkumar Manoharan wrote:
> 
> > However, looking at D6.0, maybe we do need some checks of the HE
> > capability?
> > 
> > > +			if (!(he_cap->he_cap_elem.phy_cap_info[0] &
> > > +			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
> > > +				return false;
> > 
> > Looks like even D6.0 still changed something in this area...
> > 
> > Evidently our patch just assumed that in 6 GHz all of this is 
> > supported,
> > but the spec doesn't support that theory :-)
> > 
> IIUC the same bits are applicable for both 5 GHz & 6 GHz. I understand 
> the macro doesn't capture both.

Yeah, I think you're right. I looked at D6.0 (though there seems to be
D6.1?) but I couldn't quite 

> > Can you respin this with D6.0 taken into account?
> > 
> Let me check again and respin after your series. Does it sound good?

Ok. I'll include our more limited code in the series for now then, and
we can make changes to that after we're on the same page.

Thanks,
johannes

