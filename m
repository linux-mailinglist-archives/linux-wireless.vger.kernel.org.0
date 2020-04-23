Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2081B55BB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgDWHek (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWHek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 03:34:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B546C03C1AB
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 00:34:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so5130482ljl.6
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nH+zYjlvWP3Qo5orh796NHnCHvpiRUmXtBzvtTbcFcE=;
        b=LVsNLptl4nB4LOLOaiGrH4RSyUJn61OIsD0obcDL/JRHZooBbLgar/q7RrUBhZUjzK
         ugGBfY3wsdiTy/UQpgcNMEHuchurnffz3Y48rEVDcJyzh07ypmD61oQ1HxAAKnQXqZUz
         cRUd8UTc8mjl9uq+v0HnWmXYAgOdUEdT5FQYKBdM/4vLD4d/9h9VaZkDa7GhO6eIHazi
         rsWYIhV4dQxLofUUYW/BewkevImnHnKe0qD+fCvqio8e7XAjlrnxpoSjnIkioOeZAuPp
         IM6YMOrYkvx1gxh28IIt2m/XkjuA8sOwimPRjl3J2ncpG/gRKo8uxUFhgQ8/x/K3JUEO
         TNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nH+zYjlvWP3Qo5orh796NHnCHvpiRUmXtBzvtTbcFcE=;
        b=fAGmh9VTkDY8+TArrEDI+HDuqSsfPJBSy7Zq/sLHzA7w3HyElOFyhcj9E5BDRnga2Y
         L2SndsMzIyxsmnJR8w2tkYFB1WUgxZKB7min3I2fcMEo39CJASkl/ndkc2gUFKev4vO9
         qVnatcXZM1in72aqfdJkRFd1zeC5ITvLLiHWlRgPzmT3F8wOKTnEgFYyTUtmceboQS2a
         //wajqaPk79xXL4hBqSo4M4o61n7w8Uf7cRhss+WGcXUu6TR6f8JYKx1VURskO1SHHBF
         /3oKfM4uOdlrjeVQdcjiK8LTqJuTpvesNUBojWMIEN1WNYVMC4b+4dffg/OVLhKZ7QMl
         bKDQ==
X-Gm-Message-State: AGi0PubcMtPXsvHIKl78OvUnmF5hm8VXuRaPa4TTL9DMJa0cFF/RLhGd
        Y5vJZEQASy1dktpWIWHIVuA0LVFrx/4NxJ5byKdmPn2VGyQ=
X-Google-Smtp-Source: APiQypIdrR8UY3vfI2VgyhmAUWxs0CgrmVtuB+bsGJNcjLN3F+T2pObZ8r+NNF/YOBjeU6Oqz5SKi/rk9DKxGPPrv3c=
X-Received: by 2002:a05:651c:230:: with SMTP id z16mr1545818ljn.185.1587627277913;
 Thu, 23 Apr 2020 00:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <c304ad9c-f404-d22e-de74-9398da3ebfc3@hauke-m.de>
In-Reply-To: <c304ad9c-f404-d22e-de74-9398da3ebfc3@hauke-m.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 23 Apr 2020 13:04:26 +0530
Message-ID: <CAFA6WYN3FbqTivGJTfXtHsMjXNPXW+P4MZWiCL14utF2sHkeYg@mail.gmail.com>
Subject: Re: Commit "mac80211: fix race in ieee80211_register_hw()" breaks
 mac80211 debugfs
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>, stable <stable@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 23 Apr 2020 at 02:29, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
> Hi,
>
> Since commit 52e04b4ce5d0 ("mac80211: fix race in
> ieee80211_register_hw()") the debugfs entries for mac80211 drivers are
> broken.
> https://git.kernel.org/linus/52e04b4ce5d03775b6a78f3ed1097480faacc9fd
>
> Felix reported that the file /sys/kernel/debug/ieee80211/phy0/rc is now
> located at /sys/kernel/debug/rc.
>
> Before this commit we had the following flow:
> 1. wiphy_register()
>   -> creates /sys/kernel/debug/ieee80211/phy0/
>   -> fill rdev->wiphy.debugfsdir pointer
> 2. ieee80211_init_rate_ctrl_alg()
>   -> call rate_control_alloc()
>     -> use rdev->wiphy.debugfsdir pointer to
>        create /sys/kernel/debug/ieee80211/phy0/rc/
>
> This works like expected.
>
>
> With the commit the flow in ieee80211_register_hw() is the other way around:
> 2. ieee80211_init_rate_ctrl_alg()
>   -> call rate_control_alloc()
>     -> use rdev->wiphy.debugfsdir pointer (now NULL) to
>        create /sys/kernel/debug/rc/
> 2. wiphy_register()
>   -> creates /sys/kernel/debug/ieee80211/phy0/
>   -> fill rdev->wiphy.debugfsdir pointer
>

Thanks for the detailed report. I missed to notice this hidden debugfs
dependency on "wiphy_register()". To address this issue, I think it's
reasonable to move creation of wiphy debugfs directory during
allocation of wiphy device as per following change (untested though):

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 341402b..239e9ff 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -473,6 +473,10 @@ struct wiphy *wiphy_new_nm(const struct
cfg80211_ops *ops, int sizeof_priv,
                }
        }

+       /* add to debugfs */
+       rdev->wiphy.debugfsdir = debugfs_create_dir(wiphy_name(&rdev->wiphy),
+                                                   ieee80211_debugfs_dir);
+
        INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
        INIT_LIST_HEAD(&rdev->beacon_registrations);
        spin_lock_init(&rdev->beacon_registrations_lock);
@@ -903,10 +907,6 @@ int wiphy_register(struct wiphy *wiphy)
        list_add_rcu(&rdev->list, &cfg80211_rdev_list);
        cfg80211_rdev_list_generation++;

-       /* add to debugfs */
-       rdev->wiphy.debugfsdir = debugfs_create_dir(wiphy_name(&rdev->wiphy),
-                                                   ieee80211_debugfs_dir);
-
        cfg80211_debugfs_rdev_add(rdev);
        nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);

With this change we can remove this hidden debugfs dependency. Please
give it a try and let me know if it works for you.

-Sumit

>
> This patch was backported to multiple stable kernel versions:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=a8ce3412e8a22279e1bdc81c3c2bacd3785c1577
>
> Hauke
