Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E5A6A1CC7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjBXNJx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 08:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjBXNJu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 08:09:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7812BD0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 05:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A688EB81C22
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 13:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A913C433EF;
        Fri, 24 Feb 2023 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677244186;
        bh=TQt87WJoZc71sCXZCwRm9Ogf7aXDK+eZBGSxjzToDUU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kbjsYAgeZ2kX3HLwQkzF0cd2tzsn3NcmbNtnFX46GT64+1s6SIEOV7rHE86YqyKn3
         /GObEWqmK8uHPgIEgC/IehdLnbfVebGDhfwJszJ7vGO8Ar5Prs4MqSnon3iRsOGt/4
         j83Om5FwOh8y/Yit/Z6tDRSAfr21H2p7AC0v+a8sZsGK73s3WbtIk51EM27mj+66t/
         OEWiSHdlhfRAflQ3j9jdTuL8JlnmYmuOtVeb9nLM6BvD/2xz7mHL6J5pM+xmirQ0rd
         zaVUp6BGeZbFAwiVYiFjcze8AmD83+P4en4wR+U71sxNoRL0uI4IIOF/cG+3Po6DHS
         orfDbxbFj5W+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wext: Eliminate log spamming in wireless_warn_cfg80211_wext()
References: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
        <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
        <93bc48d2-a692-3709-e323-929600f37646@lwfinger.net>
Date:   Fri, 24 Feb 2023 15:09:41 +0200
In-Reply-To: <93bc48d2-a692-3709-e323-929600f37646@lwfinger.net> (Larry
        Finger's message of "Thu, 23 Feb 2023 17:09:35 -0600")
Message-ID: <87pm9zryzu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 2/23/23 02:12, Johannes Berg wrote:
>> On Wed, 2023-02-22 at 14:49 -0600, Larry Finger wrote:
>>> Commit dc09766c755c {"wifi: wireless: warn on most wireless extension
>>> usage") introduces a warning when wireless extensions are used with
>>> cfg80211 drivers. Although such a warning is desirable, the current
>>> implementation overflows the dmesg buffer with thousands of warnings,
>>> all of which are the same.
>>>
>>
>> What are you seeing them from?
>>
>> This is rate-limited, so not sure why you're getting so many?
>>
>>>   A WARN_ONCE() call is sufficient.
>>
>> I think a WARN is inappropriate (it's a userspace 'issue', not an in-
>> kernel consistency problem), but I guess we could pr_once().
>>
>> But that's not great because it only shows a single application that was
>> still using it, not if there are multiple.
>>
>> Hmm. Not sure what to do. Let's start with "why are you getting it so
>> much". Maybe we can somehow print it less, or try to do per application
>> once, or something.
>
> Johannes,
>
> This patch has a magic number, but it does the job:
>
> diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
> index 13a72b17248e..22a67172a163 100644
> --- a/net/wireless/wext-core.c
> +++ b/net/wireless/wext-core.c
> @@ -637,12 +637,27 @@ void wireless_send_event(struct net_device *      dev,
>  EXPORT_SYMBOL(wireless_send_event);
>
>  #ifdef CONFIG_CFG80211_WEXT
> +
> +#define ARRAY_MAX  15
> +static char name_array[ARRAY_MAX][TASK_COMM_LEN];
> +static int array_count = 0;
> +
>  static void wireless_warn_cfg80211_wext(void)
>  {
>         char name[sizeof(current->comm)];
> +       int i;
>
> -       pr_warn_ratelimited("warning: `%s' uses wireless extensions
> that are deprecated for modern drivers; use nl80211\n",
> -                           get_task_comm(name, current));
> +       get_task_comm(name, current);
> +       for (i = 0; i < array_count; i++) {
> +               if (!strncmp(name, name_array[i], TASK_COMM_LEN))
> +                       return;
> +       }
> +       /* Found new one - print warning and add to array */
> +       strncpy(name_array[array_count], name, TASK_COMM_LEN);
> +       if (array_count < ARRAY_MAX)
> +               array_count++;
> +       pr_warn("warning: `%s' uses wireless extensions that are
> deprecated for modern drivers; use nl80211\n",
> +               name);
>  }
>  #endif

This looks a bit complicated. What about printing the warning once per
boot using pr_warn_once()? That way we would not annoy people too much
but hopefully still motivate the applications to switch to using
nl80211.

> Looking at my log, I do get only one for each application.
>
> finger@localhost:~>dmesg | grep warning | grep nl80211
> [    8.826056] warning: `nspr-2' uses wireless extensions that are
> deprecated for modern drivers; use nl80211
> [   17.212260] warning: `kded5' uses wireless extensions that are
> deprecated for modern drivers; use nl80211
> [   17.252420] warning: `Qt bearer threa' uses wireless extensions
> that are deprecated for modern drivers; use nl80211
> [   22.664380] warning: `akonadi_notes_a' uses wireless extensions
> that are deprecated for modern drivers; use nl80211
> [   23.058001] warning: `akonadi_maildis' uses wireless extensions
> that are deprecated for modern drivers; use nl80211
> [   23.175135] warning: `akonadi_mailmer' uses wireless extensions
> that are deprecated for modern drivers; use nl80211
> [   23.329265] warning: `akonadi_followu' uses wireless extensions
> that are deprecated for modern drivers; use nl80211
> [   24.075119] warning: `akonadi_sendlat' uses wireless extensions
> that are deprecated for modern drivers; use nl80211
>
> I have no idea why most, if not all, of those applications even care
> about wireless. As you can see, I get 8 messages in a relatively short
> time, thus I selected 15 as the size of the array.

Oh man, that's a lot of applications. Are these all KDE or QT
applications, maybe libqt uses Wireless Extensions for something?

Linus also reported that he is seeing spam from google-chrome:

https://lore.kernel.org/all/CAHk-=wjTMgB0=PQt8synf1MRTfetVXAWWLOibnMKvv1ETn_1uw@mail.gmail.com/

So there are a lot more applications using the outdated Wireless
Extension interface as we originally thought. It will take a long time
to get rid of WE usage :(

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
