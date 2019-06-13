Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447DA449EA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfFMRto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 13:49:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44834 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFMRto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 13:49:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so12277664pfe.11
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2019 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LzgyfsvEtBTTVp2aw+kthmHkof6+WN9bJz/AqEtH3XI=;
        b=dJ4GyS90eO7rnpIgk+n4LB0mTuo1h8T8E7a6mm8yLWfEKnJCJhl90TCrwHnAfEFlHi
         GQm5pxR9Uxss1E0ph9mseo5Fzg7QiJbmlZZ3V+fNtH/kr3H1muOZyYvorkOhEgMd7vUb
         rRF9svbiAdz+5bv7C9YhxyfyfLZBhzaz4LTdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LzgyfsvEtBTTVp2aw+kthmHkof6+WN9bJz/AqEtH3XI=;
        b=EPgr+QKV4Ol8OIXUBjObbs6Wfdu4YgrNFKfWEg7ZXR1SaoQaE4rMnCGP3m+gVJPvJO
         A3crvy4I+016OOfWBqH0zCMXCZZlP72AAf5g/vdxy3/TCrSGdZLGmGpoiHXDk1IgZM47
         5yUmO7/npA8xJI8wocVGopjTFpe92SAPkg9ouv7vvoSWu5VjSGj15MPGO+vwzNTK2MGH
         mt8XUu9kqbW4oO17G9IBLZhV4g7wwH9AluznrHKI+ZOq1V7PZ3y7qZeVh3xmnhimN2aj
         SrUst/mnb8PRMVi0okr1jOebPJV5yq0zKxunrMUBncXLF66HfZCw+4c2YZmIxqcvuwNJ
         XJeA==
X-Gm-Message-State: APjAAAVgnXljOBN7kpifSbcfwDLBmo48RwWWlW5we9c+mW1dsW16a2/V
        rJv5wF3rW/MXqJx+RbzcehCZezLsTc4=
X-Google-Smtp-Source: APXvYqy1W3i62fN8gF/ze2WGXFrH5cY3UDeToUEJdl+ZPDjJxDWCsI9NOhetINuBHX+60Ovhnr/vNA==
X-Received: by 2002:a17:90a:9385:: with SMTP id q5mr6678541pjo.126.1560448183458;
        Thu, 13 Jun 2019 10:49:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id m5sm508550pjl.24.2019.06.13.10.49.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 10:49:42 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:49:40 -0700
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
Message-ID: <20190613174938.GA260350@google.com>
References: <20190529125220.17066-1-tiwai@suse.de>
 <20190529125220.17066-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529125220.17066-3-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Takashi,

On Wed, May 29, 2019 at 02:52:20PM +0200, Takashi Iwai wrote:
> Currently mwifiex_update_bss_desc_with_ie() implicitly assumes that
> the source descriptor entries contain the enough size for each type
> and performs copying without checking the source size.  This may lead
> to read over boundary.
> 
> Fix this by putting the source size check in appropriate places.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/scan.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index 64ab6fe78c0d..c269a0de9413 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -1269,6 +1269,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  			break;
>  
>  		case WLAN_EID_FH_PARAMS:
> +			if (element_len + 2 < sizeof(*fh_param_set))

"element_len + 2" would be much more readable as "total_ie_len". (Same for
several other usages in this patch.) I can send such a patch myself as a
follow-up I suppose.

> +				return -EINVAL;
>  			fh_param_set =
>  				(struct ieee_types_fh_param_set *) current_ptr;
>  			memcpy(&bss_entry->phy_param_set.fh_param_set,

[...]

> @@ -1349,6 +1361,9 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
>  			break;
>  
>  		case WLAN_EID_VENDOR_SPECIFIC:
> +			if (element_len + 2 < sizeof(vendor_ie->vend_hdr))

Why 'sizeof(vendor_ie->vend_hdr)'? The (mwifiex-specific compare with the
ieee80211.h generic struct ieee80211_vendor_ie) ieee_types_vendor_header struct
includes the 'oui_subtype' and 'version' fields, which are not standard
requirements for the vendor header (in fact, even the 4th byte of the
OUI -- "oui_type" -- doesn't appear to be in the 802.11 specification).
So it looks to me like you might be rejecting valid vendor headers (that
we should just be skipping) that might have vendor-specific content with
length 0 or 1 bytes.

It seems like we should only be validating the standard pieces (e.g., up to the
length/OUI), and only after an appropriate OUI match, *then* validating the rest of
the vendor element (the pieces we'll use later).

Brian

> +				return -EINVAL;
> +
>  			vendor_ie = (struct ieee_types_vendor_specific *)
>  					current_ptr;
>  
> -- 
> 2.16.4
> 
