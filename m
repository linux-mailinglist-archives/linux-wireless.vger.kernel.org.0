Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828D6358AFD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhDHRKg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 13:10:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23153 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhDHRK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 13:10:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617901816; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=V4ljIdzLVj1HYPN0cJQzTeicIbt0mXQO9I9/ovGLnLQ=;
 b=YsrUGbw3RZ/XyypbAONh+76jNqDJgPdND/o3sisVtZHijvfoaXXeszlijCnPSX79UWqlu8l/
 W+jyM0+t5q2dopo9PREAwBon5AUJwth+KKE1QWcjD5qjTRGidsxvP2RPnJas5clfMTZegTpC
 qC+dZjihr9Aaq88XOSwjJ5xBWmM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606f38e98807bcde1db59903 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 17:10:01
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E506FC43218; Thu,  8 Apr 2021 17:10:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCEFBC43464;
        Thu,  8 Apr 2021 17:09:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Apr 2021 10:09:58 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v9 1/4] nl80211: add basic multiple bssid support
In-Reply-To: <79c9b9c0577e6635f6e2e737f824f5962f25cd20.camel@sipsolutions.net>
References: <20210310182604.8858-1-alokad@codeaurora.org>
 <20210310182604.8858-2-alokad@codeaurora.org>
 (sfid-20210310_192729_695322_E5522196)
 <79c9b9c0577e6635f6e2e737f824f5962f25cd20.camel@sipsolutions.net>
Message-ID: <7b078e1b3aea52b3449b3f8398c084ef@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-08 05:05, Johannes Berg wrote:
> On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
>> 
>> +/**
>> + * struct cfg80211_multiple_bssid - AP settings for multi bssid
>> + *
>> + * @index: the index of this AP in the multi bssid group.
>> + * @count: the total number of multi bssid peer APs.
>> + * @parent: non-transmitted BSSs transmitted parents index
>> + * @ema: Shall the beacons be sent out in EMA mode.
>> + */
>> +struct cfg80211_multiple_bssid {
>> +	u8 index;
>> +	u8 count;
>> +	u32 parent;
>> +	bool ema;
>> +};
> 
> Can reorder this to make it smaller: bool before u32), or even u32
> element first.
> 

Will do.

>> +/**
>> + * struct cfg80211_multiple_bssid_data - Multiple BSSID elements
>> + *
>> + * @cnt: Number of elements in array %elems.
>> + *
>> + * @elems: Array of multiple BSSID element(s) to be added into Beacon 
>> frames.
>> + * @elems.data: Data for multiple BSSID elements.
>> + * @elems.len: Length of data.
>> + */
>> +struct cfg80211_multiple_bssid_data {
>> +	u8 cnt;
>> +	struct {
>> +		u8 *data;
>> +		size_t len;
>> +	} elems[];
>> +};
> 
> Why are the elements separate, rather than a single big buffer with all
> elements?
> 
> 

This is for EMA AP where each element will hold different
non-transmitted profiles. While copying elements in
ieee80211_assign_beacon(), all are copied one by one.
However during beacon generation in __ieee80211_beacon_get(),
only the element at a given index is actually added.
Hence separate elements.

>> + * @multiple_bssid.max_num_vaps: Maximum number of VAPS supported by 
>> the driver
> 
> Please use upstream terminology, we don't use the term "VAP" (and 
> "VAPS"
> would be wrong anyway, "VAPs").
> 
> I'd probably call this "max_interfaces", maybe we'll extend this to
> other things (mesh?) later?
>> 

Will change.

>> +/**
>> + * enum nl80211_multiple_bssid_elems_attributes - Attributes used to 
>> pass
>> + *	multiple BSSID elements data.
>> + *
>> + * @__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_INVALID: Invalid
>> + *
>> + * @NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT: Number of multiple BSSID
>> + *	elements (u8).
>> + *
>> + * @NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA: Array of multiple BSSID 
>> elements.
>> + */
>> +enum nl80211_multiple_bssid_elems_attributes {
>> +	__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_INVALID,
>> +
>> +	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT,
>> +	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA,
>> 
> 
> Can you clarify why this is an array? See also above.
> 
> 
> johannes

Array to pass separate MBSSID elements for EMA which will
hold different profiles in the same MBSSID set.
