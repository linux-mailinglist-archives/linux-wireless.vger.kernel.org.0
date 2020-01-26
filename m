Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B652C149CCD
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 21:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgAZUXa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 15:23:30 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:56966 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgAZUXa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 15:23:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580070209; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+eZvrmtCrapPDrDuqhWitxmJ2H8paSKabKmsxKe/HxU=;
 b=IJdNQUHR5In7MocCIaM+fv7ZfcNmnAc9Ok5lhpmQH4NuCCiLxpEiPs/mTrJje3WzE2iwlCQp
 B2+cuzqM64SWen2xf90wc85obq+JZLIDJJFf4Z1KF4SLoiVzlAyTyhKRDz5dg2lU9X9dr1aM
 bD4txB/Zr/ajBxSqy3RAyGPk3Hs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2df53c.7f93edf260a0-smtp-out-n03;
 Sun, 26 Jan 2020 20:23:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30EE2C433CB; Sun, 26 Jan 2020 20:23:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1A00C433CB;
        Sun, 26 Jan 2020 20:23:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jan 2020 01:53:21 +0530
From:   vjakkam@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] cfg80211: Enhance the AKM advertizement to support per
 interface.
In-Reply-To: <5290eda7dee50997e7fa5bb5976256b024f7e94e.camel@sipsolutions.net>
References: <20200117113507.13503-1-vjakkam@codeaurora.org>
 <20200126112113.19542-1-vjakkam@codeaurora.org>
 <5290eda7dee50997e7fa5bb5976256b024f7e94e.camel@sipsolutions.net>
Message-ID: <89bad215ed8dbf917a9583c572298c7d@codeaurora.org>
X-Sender: vjakkam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-26 23:02, Johannes Berg wrote:
> On Sun, 2020-01-26 at 16:51 +0530, Veerendranath Jakkam wrote:
>> 
>> +
>> +	nested = nla_nest_start(msg, NL80211_ATTR_IFTYPE_AKM_SUITES);
>> +	if (!nested)
>> +		return -ENOBUFS;
>> +
>> +	for (i = 0; i < rdev->wiphy.num_iftype_akm_suites; i++) {
>> +		nested_akms = nla_nest_start(msg, i + 1);
>> +		if (!nested_akms)
>> +			return -ENOBUFS;
>> +
>> +		iftype_akms = &rdev->wiphy.iftype_akm_suites[i];
>> +
>> +		if (nl80211_put_iftypes(msg, NL80211_ATTR_SUPPORTED_IFTYPES,
>> +					iftype_akms->iftypes_mask))
>> +			return -ENOBUFS;
>> +
>> +		if (nla_put(msg, NL80211_ATTR_AKM_SUITES,
> 
> Using the top-level attributes inside the nesting makes things
> unnecessarily difficult to understand and take far more memory to 
> parse,
> IMHO it'd be better to define a new set of inner attributes
> NL80211_IFTYPE_AKM_ATTR_IFTYPES, ..._SUITES or so.
> 
> johannes

Thanks, I will correct this in v4 as per suggestion

veeru
