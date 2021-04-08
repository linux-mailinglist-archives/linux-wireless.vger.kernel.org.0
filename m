Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEA3582D7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDHMFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhDHMFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:05:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E77DC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:05:43 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUTPp-008zTz-89; Thu, 08 Apr 2021 14:05:41 +0200
Message-ID: <79c9b9c0577e6635f6e2e737f824f5962f25cd20.camel@sipsolutions.net>
Subject: Re: [PATCH v9 1/4] nl80211: add basic multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 08 Apr 2021 14:05:40 +0200
In-Reply-To: <20210310182604.8858-2-alokad@codeaurora.org> (sfid-20210310_192729_695322_E5522196)
References: <20210310182604.8858-1-alokad@codeaurora.org>
         <20210310182604.8858-2-alokad@codeaurora.org>
         (sfid-20210310_192729_695322_E5522196)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
> 
> +/**
> + * struct cfg80211_multiple_bssid - AP settings for multi bssid
> + *
> + * @index: the index of this AP in the multi bssid group.
> + * @count: the total number of multi bssid peer APs.
> + * @parent: non-transmitted BSSs transmitted parents index
> + * @ema: Shall the beacons be sent out in EMA mode.
> + */
> +struct cfg80211_multiple_bssid {
> +	u8 index;
> +	u8 count;
> +	u32 parent;
> +	bool ema;
> +};

Can reorder this to make it smaller: bool before u32), or even u32
element first.

> +/**
> + * struct cfg80211_multiple_bssid_data - Multiple BSSID elements
> + *
> + * @cnt: Number of elements in array %elems.
> + *
> + * @elems: Array of multiple BSSID element(s) to be added into Beacon frames.
> + * @elems.data: Data for multiple BSSID elements.
> + * @elems.len: Length of data.
> + */
> +struct cfg80211_multiple_bssid_data {
> +	u8 cnt;
> +	struct {
> +		u8 *data;
> +		size_t len;
> +	} elems[];
> +};

Why are the elements separate, rather than a single big buffer with all
elements?


> + * @multiple_bssid.max_num_vaps: Maximum number of VAPS supported by the driver

Please use upstream terminology, we don't use the term "VAP" (and "VAPS"
would be wrong anyway, "VAPs").

I'd probably call this "max_interfaces", maybe we'll extend this to
other things (mesh?) later?
> 
> +/**
> + * enum nl80211_multiple_bssid_elems_attributes - Attributes used to pass
> + *	multiple BSSID elements data.
> + *
> + * @__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_INVALID: Invalid
> + *
> + * @NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT: Number of multiple BSSID
> + *	elements (u8).
> + *
> + * @NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA: Array of multiple BSSID elements.
> + */
> +enum nl80211_multiple_bssid_elems_attributes {
> +	__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_INVALID,
> +
> +	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT,
> +	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA,
> 

Can you clarify why this is an array? See also above.


johannes

