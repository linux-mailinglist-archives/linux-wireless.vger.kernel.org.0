Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC72A5E0C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 07:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKDGSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 01:18:46 -0500
Received: from z5.mailgun.us ([104.130.96.5]:13119 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgKDGSp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 01:18:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604470725; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IXjSbdJH+t2L382YZrImo9krqlSvJ9s+LeWhzKjxjJE=;
 b=M7DKR6tPZ7ZqDhBCrsLrnpCUCpumrBK58Nj5sighLtHBkyJrORiwoMXzsd4TzLiwa5Api3Pd
 1N8J0HMrvhF/fT6Ea9sUufNsY0Zwlj+f6w31ATNAJmX3zXpSRyA5SEjALI06W1f5BVqLGH+F
 V3a9c/r6An4gqlDOkhWD/AtcwiM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fa247c1d8a9d167f30fc61c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 06:18:41
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8330C433CB; Wed,  4 Nov 2020 06:18:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4821BC433C6;
        Wed,  4 Nov 2020 06:18:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Nov 2020 14:18:40 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Abhishek Kumar <kuabhs@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Abhishek Kumar <kuabhs@chromium.org>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        ath10k@lists.infradead.org
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <CAB5ih=PtneRW+sU9KbPNgEM8GvPA1rfa87M41fsL=y=VP71Y5Q@mail.gmail.com>
References: <20201030205639.1452712-1-kuabhs@chromium.org>
 <20201031024631.1528113-1-kuabhs@chromium.org>
 <e5302eb0b20339d3f6544652e4034993@codeaurora.org>
 <aba43fb268fe29aecf84bf7e68629dc0de28d0ad.camel@sipsolutions.net>
 <CAB5ih=PtneRW+sU9KbPNgEM8GvPA1rfa87M41fsL=y=VP71Y5Q@mail.gmail.com>
Message-ID: <0d820718ca30962f783fc13f2d9db2bc@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-04 09:17, Abhishek Kumar wrote:
> On Tue, Nov 3, 2020 at 5:15 AM Johannes Berg 
> <johannes@sipsolutions.net> wrote:
>> 
>> On Tue, 2020-11-03 at 10:34 +0800, Carl Huang wrote:
>> > On 2020-10-31 10:46, Abhishek Kumar wrote:
>> > > From: kuabhs@chromium.org
>> > >
>> > > There are few more additional comments here.
>> > > > + * @NL80211_CMD_SET_SAR_SPECS: SAR power limitation configuration is
>> > > > + *     passed using %NL80211_ATTR_SAR_SPEC.
>> > > > + *
>> > >
>> > > This command requires NL80211_ATTR_IFINDEX, probably should be better
>> > > to add
>> > > this in the comment ?
>> > >
>> > Per Johannes's comments, this explicit index is not required. Are you
>> > fine with it?
>> >
>> > Instead, user-space application records the array index when querying
>> > the SAR
>> > capability. When set, the nested array index will be used to set the
>> > power.
>> > This requires user-space has a strict mapping of index. and
>> > NL80211_ATTR_IFINDEX
>> > is to be removed.
>> 
>> Wait, what? The IFINDEX is still required, that identifies the 
>> interface
>> - though it probably shouldn't be required, this should be per wiphy, 
>> so
>> you could also use ATTR_WIPHY_IDX?
>> 
>> You're thinking of ... something
>> else. NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX perhaps?
> 
> Yes, probably the index mapping that you are talking about is using
> NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX .
> 
You're right. I just remembered Johannes's comments to remove
the NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX and made mistake here.


> I think Johannes has already covered most of the comments. I have one
> last one  mentioned below.
> 
>> +nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
>> +                     struct sk_buff *msg)
>> +{
>> +       struct nlattr *sar_capa, *specs, *sub_freq_range;
>> +       u8  num_freq_ranges;
>> +       int i;
>> +
>> +       if (!rdev->wiphy.sar_capa)
>> +               return 0;
>> +
>> +       num_freq_ranges = rdev->wiphy.sar_capa->num_freq_ranges;
>> +
>> +       sar_capa = nla_nest_start(msg, NL80211_ATTR_SAR_SPEC);
>> +       if (!sar_capa)
>> +               return -ENOSPC;
>> +
>> +       if (nla_put_u16(msg, NL80211_SAR_ATTR_TYPE, 
>> rdev->wiphy.sar_capa->type))
>> +               goto fail;
> 
> The nla_put_u16 NL80211_SAR_ATTR_TYPE here uses u16 whereas in the to
> get this property below it uses nla_get_u32 .  I think this should be
> consistent ?
> 
>> +       if (!tb[NL80211_SAR_ATTR_TYPE])
>> +               return -EINVAL;
>> +
>> +       type = nla_get_u32(tb[NL80211_SAR_ATTR_TYPE]);
>> +
>> +       if (!tb[NL80211_SAR_ATTR_SPECS])
>> +               return -EINVAL;
> 
> As mentioned above the get and put for NL80211_SAR_ATTR_TYPE is not 
> consistent.
> 
Correct. Thanks for pointing out and it will be fixed in next version.

> -Abhishek
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
