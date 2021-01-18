Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AA2FAC45
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 22:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437859AbhARVLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 16:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388877AbhARVKi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 16:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611004147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRu+4fjUNV4j7WF9rBOha65f9F3VebQfanWyObjLWHc=;
        b=fbWTJGBj3Yrv4qxzRlsqniDJDlKIlyRX72hXVpcYYDX01WWaByXsL0rTKYuWWYwSGYLiNo
        tZeOTtUwW2hLGBNppIjwL1Icmw0jJyhk2C/gT1pQ/CeMzAY8YhpYlrOEy5bTpxLifjFZlM
        2pxSTKHoCdJJ766Y8Fnwqd4sg3Wniq0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-BnodU3BxNiKylUNtRiw2XA-1; Mon, 18 Jan 2021 16:09:06 -0500
X-MC-Unique: BnodU3BxNiKylUNtRiw2XA-1
Received: by mail-ed1-f72.google.com with SMTP id f4so2513493eds.5
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jan 2021 13:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRu+4fjUNV4j7WF9rBOha65f9F3VebQfanWyObjLWHc=;
        b=PQLY8QAzpcwXxbbBz0oVw+94Q3LXvY5JoKtRmjsi+K8yd4I9c6mqgNUFp2Id6ykp9E
         vvCZzlbJY/SXgdY5fmB1yyc9yqR4JXPEwSnmNHiFY9ZDqPCFNIFog7v+qUG1MAmh3AxY
         vWNjJ8g5p9byXc1K7G1eFLPKXihdxAa7PiYquGP8mEVmMqmqL5YjtFYKsXU1E/vLPXok
         CkPhJkAeZ7KODj/fvlB2x4ClRJQO8e9iyRqN/Y05OK00ERMSHdCo2Q6/kjXF10O1TZd7
         eicvsQ3ye4iqippCOoJvWRXYIeUEVQmI+sOC9AnVDAjQY7AmuOAH6jURwZXWfrOtMAEH
         OP8A==
X-Gm-Message-State: AOAM533eq8VbPTATl0qHWbDpRRCb9QDqNbuTSSE5yMfcoQi/dYHLYQjY
        4p+phr7q4s63tplTTSYgTn39AGg6eIZgVbvMG1p2GjI5SyoL3IZuGEB2zJP27Ys2O7MoYAltp9V
        Y0UhnLb8TF5NNXwrN0FYLmXT2Hk0=
X-Received: by 2002:a17:906:48f:: with SMTP id f15mr997091eja.392.1611004144653;
        Mon, 18 Jan 2021 13:09:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHW6WBucH1SRSE0CdG+9v/ERqwCCoxS+YMlDBKT4TwHLyE0uiCnKJ8orXYLts7p7VnQ1x+OQ==
X-Received: by 2002:a17:906:48f:: with SMTP id f15mr997084eja.392.1611004144467;
        Mon, 18 Jan 2021 13:09:04 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id m26sm4865344ejr.54.2021.01.18.13.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 13:09:03 -0800 (PST)
Subject: Re: [PATCH] cfg80211: Fix "suspicious RCU usage in
 wiphy_apply_custom_regulatory" warning/backtrace
To:     "Peer, Ilan" <ilan.peer@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20210104170713.66956-1-hdegoede@redhat.com>
 <BN7PR11MB2610DDFBC90739A9D1FAED52E9D10@BN7PR11MB2610.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <391ac436-9981-0f12-6e00-7a1bbe4d5c20@redhat.com>
Date:   Mon, 18 Jan 2021 22:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <BN7PR11MB2610DDFBC90739A9D1FAED52E9D10@BN7PR11MB2610.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 1/5/21 10:24 AM, Peer, Ilan wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Monday, January 04, 2021 19:07
>> To: Johannes Berg <johannes@sipsolutions.net>; David S . Miller
>> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Rojewski,
>> Cezary <cezary.rojewski@intel.com>; Pierre-Louis Bossart <pierre-
>> louis.bossart@linux.intel.com>; Liam Girdwood
>> <liam.r.girdwood@linux.intel.com>; Jie Yang <yang.jie@linux.intel.com>;
>> Mark Brown <broonie@kernel.org>
>> Cc: Hans de Goede <hdegoede@redhat.com>; linux-
>> wireless@vger.kernel.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; alsa-devel@alsa-project.org; Peer, Ilan
>> <ilan.peer@intel.com>
>> Subject: [PATCH] cfg80211: Fix "suspicious RCU usage in
>> wiphy_apply_custom_regulatory" warning/backtrace
>>
>> Commit beee24695157 ("cfg80211: Save the regulatory domain when setting
>> custom regulatory") adds a get_wiphy_regdom call to
>> wiphy_apply_custom_regulatory. But as the comment above
>> wiphy_apply_custom_regulatory says:
>> "/* Used by drivers prior to wiphy registration */"
>> this function is used by driver's probe function before the wiphy is registered
>> and at this point wiphy->regd will typically by NULL and calling
>> rcu_dereference_rtnl on a NULL pointer causes the following
>> warning/backtrace:
>>
>> =============================
>> WARNING: suspicious RCU usage
>> 5.11.0-rc1+ #19 Tainted: G        W
>> -----------------------------
>> net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
>>
>> other info that might help us debug this:
>>
>> rcu_scheduler_active = 2, debug_locks = 1
>> 2 locks held by kworker/2:0/22:
>>  #0: ffff9a4bc104df38 ((wq_completion)events){+.+.}-{0:0}, at:
>> process_one_work+0x1ee/0x570
>>  #1: ffffb6e94010be78 ((work_completion)(&fw_work->work)){+.+.}-{0:0},
>> at: process_one_work+0x1ee/0x570
>>
>> stack backtrace:
>> CPU: 2 PID: 22 Comm: kworker/2:0 Tainted: G        W         5.11.0-rc1+ #19
>> Hardware name: LENOVO 60073/INVALID, BIOS 01WT17WW 08/01/2014
>> Workqueue: events request_firmware_work_func Call Trace:
>>  dump_stack+0x8b/0xb0
>>  get_wiphy_regdom+0x57/0x60 [cfg80211]
>>  wiphy_apply_custom_regulatory+0xa0/0xf0 [cfg80211]
>>  brcmf_cfg80211_attach+0xb02/0x1360 [brcmfmac]
>>  brcmf_attach+0x189/0x460 [brcmfmac]
>>  brcmf_sdio_firmware_callback+0x78a/0x8f0 [brcmfmac]
>>  brcmf_fw_request_done+0x67/0xf0 [brcmfmac]
>>  request_firmware_work_func+0x3d/0x70
>>  process_one_work+0x26e/0x570
>>  worker_thread+0x55/0x3c0
>>  ? process_one_work+0x570/0x570
>>  kthread+0x137/0x150
>>  ? __kthread_bind_mask+0x60/0x60
>>  ret_from_fork+0x22/0x30
>>
>> Add a check for wiphy->regd being NULL before calling get_wiphy_regdom
>> (as is already done in other places) to fix this.
>>
>> wiphy->regd will likely always be NULL when
>> wiphy->wiphy_apply_custom_regulatory
>> gets called, so arguably the tmp = get_wiphy_regdom() and
>> rcu_free_regdom(tmp) calls should simply be dropped, this patch keeps the
>> 2 calls, to allow drivers to call wiphy_apply_custom_regulatory more then
>> once if necessary.
>>
>> Cc: Ilan Peer <ilan.peer@intel.com>
>> Fixes: beee24695157 ("cfg80211: Save the regulatory domain when setting
>> custom regulator")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  net/wireless/reg.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/wireless/reg.c b/net/wireless/reg.c index
>> bb72447ad960..9254b9cbaa21 100644
>> --- a/net/wireless/reg.c
>> +++ b/net/wireless/reg.c
>> @@ -2547,7 +2547,7 @@ static void handle_band_custom(struct wiphy
>> *wiphy,  void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
>>  				   const struct ieee80211_regdomain *regd)  {
>> -	const struct ieee80211_regdomain *new_regd, *tmp;
>> +	const struct ieee80211_regdomain *new_regd, *tmp = NULL;
>>  	enum nl80211_band band;
>>  	unsigned int bands_set = 0;
>>
>> @@ -2571,7 +2571,8 @@ void wiphy_apply_custom_regulatory(struct wiphy
>> *wiphy,
>>  	if (IS_ERR(new_regd))
>>  		return;
>>
>> -	tmp = get_wiphy_regdom(wiphy);
>> +	if (wiphy->regd)
>> +		tmp = get_wiphy_regdom(wiphy);
>>  	rcu_assign_pointer(wiphy->regd, new_regd);
>>  	rcu_free_regdom(tmp);
> 
> This only fixes the first case where the pointer in NULL and does not handle the wrong RCU usage in other cases.
> 
> I'll prepare a fix for this.

Any luck with this? This is a regression in 5.11, so this really should
be fixed in a future 5.11-rc and the clock is running out.

Regards,

Hans

