Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41A65C441
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjACQxB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 11:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbjACQwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 11:52:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92BA11469
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 08:52:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t15so21293754wro.9
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAHWMpHxzFaF/+FV1Srr13hMrad8lyHMwUHuZBakb6s=;
        b=USZzsdvIfChiJva+0AZ5dHqUs94yh9Zn9GQKfsR3QGorETxjGyucLr8mnCjuiF8H0R
         CSxcA+0g86HZkKtmvVODZCJ8b2mZCSjL2RmatgEK17oSCiI2xjIzkO3acXO5Ny4Yd/JJ
         3KwKm1JutgTSrAmB4svq8FQ49cLWDJKkjKgLzNNE9gDQfVp1q3WOIQZp+rJQ7Yk/WPpB
         yoKlGafzc7lEe7tsg0mMPi53Qg1yV3/uah2cUAUc8XmReA6YwA+ZG78AAOyNdu/nnaKs
         kdqwsctwVqDlnQy8bULbWSVe4DaV6ZPhyxHFWpLdr58EnIlIIU/k6MNkfmddrqj5TKfb
         LTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAHWMpHxzFaF/+FV1Srr13hMrad8lyHMwUHuZBakb6s=;
        b=WuVvYwYTutdRJnPVQEHv4QwFP7yWolSUuEzFRa62rY4DyxBnrDF2NylyazwfTPXbuB
         Ef71AULZ9GtiwxZxywmGX6dddnv4Kya6dq8ogIXt6bq6Lo6p7EFBoPAxsDjT3nJlx+TL
         wiLE60c6O9vA5F0avaFKsNqdIaziQlKJAKv+vmLBzxPyZH7X+VU11bapTSO3nsnGCe5T
         CtBikEbyDBasBNT3K9a1xLu0hW5pSQ+Tq4MCFu4IVrVUQWJsxics0hCXKIHKIFAvYR/q
         MHx3t8UmbkOna0Ck++wCFaiXHQFlVjiccy2F3stc8/KTVE5Di5Dd9sZ0FtgynlbqrCDY
         nrRQ==
X-Gm-Message-State: AFqh2krITozn4ef03UVHfAXdiYYJI43Dh+jjI7jWXBDDJsIZ+eVtCfgE
        TuHCYzzV6Jil7RY5K5jQNvMNF82y8JZwEFvK
X-Google-Smtp-Source: AMrXdXuk1ZqzFPgxH6ITIsCvnDE60FNjtdAGNA+8NT4Feu3M54djVmitIhO5pnAhEDAfDKzP/yjU5w==
X-Received: by 2002:adf:e5cd:0:b0:241:fd48:dccd with SMTP id a13-20020adfe5cd000000b00241fd48dccdmr26754725wrn.63.1672764749354;
        Tue, 03 Jan 2023 08:52:29 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d40c7000000b00241cfe6e286sm31770040wrq.98.2023.01.03.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 08:52:28 -0800 (PST)
Date:   Tue, 3 Jan 2023 18:52:18 +0200
From:   Sicelo <absicsz@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: WLAN broken on Nokia N900 with v6.2-rc1
Message-ID: <Y7RdQqBQx58dIMAP@tp440p.steeds.sam>
References: <Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam>
 <a115fbb8-1048-9ae9-fcfb-ac1fd7d33449@wetzel-home.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a115fbb8-1048-9ae9-fcfb-ac1fd7d33449@wetzel-home.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexander

> 
> I do not yet see how switching the driver to iTXQ can cause the observed
> errors. The warnings above happen during scan, which should not be affected
> by the commit above. So I assume for now that's these are just follow up
> issues and something is wrong before the error messages we get...
> 
> But scanning itself is still working for you? You see the networks, just
> joining them is not working, correct?

Yes, although later I found that joining does actually work, but takes
an unusually long time. I later observed that I can even get an IP
address. However, there is 100% packet loss.

Accidentally, I stumbled on the fact that if I turn power saving off,
then it starts working reasonably well. I am not sure what this
observation suggests though.

> Some ideas how to continue debugging the issue for now:
> 
> 1) Enable debugging and share the all logs starting from driver load up
>    and including one connection request.
>    Looks like you must edit drivers/net/wireless/ti/wl1251/wl1251.h and
>    change line 39:
> 	#define DEBUG_LEVEL (DEBUG_NONE)
>    to
> 	#define DEBUG_LEVEL (DEBUG_ALL)
> 
> 2) Keep debugging enabled but undo the change of the commit causing the
>    problem. Remove the line line 1362 added by the problematic commit in
>    drivers/net/wireless/ti/wl1251/main.c:
> 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
>    Connection should work again. Run the same test procedure as above
>    and share the debug log from that. with the logs from 1) and 2) we
>    hopefully get an better idea where the problem really is...
> 
> 3) On top of the debug logs above you can also try what happens when we
>    force the driver to use SW scan only:
>    Add the line we removed for 2) again but remove line 1364 instead:
> 	.hw_scan = wl1251_op_hw_scan,
>    Again share the debug logs
> 

I will do further testing in a couple of weeks when I have time again.
Thank you for the suggestions.

Sicelo
