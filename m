Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D37D44AD8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfFMSil (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 14:38:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSik (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 14:38:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so25932pgn.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2019 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqHHtC1aUYYcuDQQmQy2d8+zInltORn4D214p9u4Soo=;
        b=AUmGr6HPljRrEKOVPNUT+vGODeHxYxjbxHXly1C7pwUYHd+aRhdHOSLU/guQy997Ms
         uOw6Y6xz6qbzXkQZOKWMDKnoQq28lEgiRvvY23RdIFFx1BAsLLBsIEhTNTZyZMrzw3Nr
         NGmsFR7Q0OyUqRBkC270MO0Cg3OGDKhqk7Ilw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqHHtC1aUYYcuDQQmQy2d8+zInltORn4D214p9u4Soo=;
        b=RGzpOhHPKaMna+jqRuzOWgUgcVU23UhwKkv94nSQWvv0osjJh6tcuzUjIIhj3MZ+Sn
         hBs9UxrUsPKgNjQigZ9MpqUAvgcuOq3k6+vMvb6uzEP0DNH08Xhc5Bh26YosT54hYj0/
         jRBDxGlgWL8dCOSwZsBToppkG6UICdJuq+4g+dyc4voIVGVmcGv7MQWzMXDPQGae+K7x
         JFEpRghwyanzb6nNN/uwG63N4Y1a9qKhTtlCvuW3Jqymxj4ac8HeWy0ldAv6k3tX66G1
         5QIEj1RixMoObX93QD9zQpaYl8QiYHusIlwhE+4egLFpLYYZvgT90WAsmWibBe5cWAoz
         XXGA==
X-Gm-Message-State: APjAAAUJfY/9cn3Cye/ZebKSA7SWyrZzjBvzTRnm3s7i9a6GVo66UtIX
        oSSz3aP89OpOfTMP4PhPhRg33g==
X-Google-Smtp-Source: APXvYqzXR0jnGD89mb7aHaclZ4VBtzLIVjp3lYtPBUw7PIzSvUnulauIPdjes9Nkbw9Ymjl5VwlB+A==
X-Received: by 2002:a63:2b92:: with SMTP id r140mr32345457pgr.363.1560451120092;
        Thu, 13 Jun 2019 11:38:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 5sm341591pfh.109.2019.06.13.11.38.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:38:39 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:38:37 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, huangwen@venustech.com.cn,
        Solar Designer <solar@openwall.com>,
        Marcus Meissner <meissner@suse.de>
Subject: Re: [PATCH 2/2] mwifiex: Abort at too short BSS descriptor element
Message-ID: <20190613183835.GA16432@google.com>
References: <20190529125220.17066-1-tiwai@suse.de>
 <20190529125220.17066-3-tiwai@suse.de>
 <20190613174938.GA260350@google.com>
 <s5hmuile4mg.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hmuile4mg.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 13, 2019 at 08:12:39PM +0200, Takashi Iwai wrote:
> On Thu, 13 Jun 2019 19:49:40 +0200,
> Brian Norris wrote:
> > On Wed, May 29, 2019 at 02:52:20PM +0200, Takashi Iwai wrote:
> > > --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> > > @@ -1269,6 +1269,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
> > >  			break;
> > >  
> > >  		case WLAN_EID_FH_PARAMS:
> > > +			if (element_len + 2 < sizeof(*fh_param_set))
> > 
> > "element_len + 2" would be much more readable as "total_ie_len". (Same for
> > several other usages in this patch.) I can send such a patch myself as a
> > follow-up I suppose.
> 
> Yes, please.

I'll wait until we straighten out the other (potentially) real bug.
Don't want to make needless conflicts.

> > > +				return -EINVAL;
> > >  			fh_param_set =
> > >  				(struct ieee_types_fh_param_set *) current_ptr;
> > >  			memcpy(&bss_entry->phy_param_set.fh_param_set,
> > 
> > [...]
> > 
> > > @@ -1349,6 +1361,9 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
> > >  			break;
> > >  
> > >  		case WLAN_EID_VENDOR_SPECIFIC:
> > > +			if (element_len + 2 < sizeof(vendor_ie->vend_hdr))
> > 
> > Why 'sizeof(vendor_ie->vend_hdr)'? The (mwifiex-specific compare with the
> > ieee80211.h generic struct ieee80211_vendor_ie) ieee_types_vendor_header struct
> > includes the 'oui_subtype' and 'version' fields, which are not standard
> > requirements for the vendor header (in fact, even the 4th byte of the
> > OUI -- "oui_type" -- doesn't appear to be in the 802.11 specification).
> > So it looks to me like you might be rejecting valid vendor headers (that
> > we should just be skipping) that might have vendor-specific content with
> > length 0 or 1 bytes.
> > 
> > It seems like we should only be validating the standard pieces (e.g., up to the
> > length/OUI), and only after an appropriate OUI match, *then* validating the rest of
> > the vendor element (the pieces we'll use later).
> 
> Hm, right, that looks too strict.  Instead we need to check right
> before both memcmp()'s of OUI.

I think this is the right place for one check (the memcmp() is right
after this line anyway) -- the minimum length just should be smaller.

e.g.:

sizeof(struct ieee80211_vendor_ie) // this is still technically 1 byte too large I think
or
offsetof(struct ieee80211_vendor_ie, oui_type) // not sure if this is the cleanest...

If it's smaller than that, we can still say -EINVAL.

Then, we can go with:

if (element_len < sizeof(wpa_oui)
	continue;

or similar.

So, I might say:

	/* Vendor IEs must at least contain the OUI. */
	if (total_ie_len < offsetof(struct ieee80211_vendor_ie, oui_type))
		return -EINVAL;

	/* If the IE still isn't long enough, it's not a match. */
	if (element_len < sizeof(wpa_oui))
		continue;

Brian
