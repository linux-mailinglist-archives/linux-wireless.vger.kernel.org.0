Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C587C1E0F8D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390794AbgEYNdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 09:33:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39138 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388794AbgEYNdf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 09:33:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id d7so13803821ote.6;
        Mon, 25 May 2020 06:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3iZXQVOrAzTRalMEWpzyXuGfM2DVDNSP7yRTGMprno=;
        b=csR0DAp0JE0lKdsnc9OCrIPH84KeaYSn5TBcvYM9k/ZF+ge8S8cm+QKj2ohQm4WTRw
         ewBeCpomccCrEBjdEfz+EeABYxjG/l0/PFkkxcGzfID6P18f5mSNef3eK5mTVf5hsS5o
         ew6lOAwZwqls0LRUPKc5w39L45k6vgDm6KLgkj5oKi4HvjfMWLsNvn4fDtATXKMmjwkQ
         eB6TMyMCTYPgP1nG3tlvHGYun2VJjt/eA9H05RosD+tfMindc/wNN4eL5E+7t59/hMnZ
         ncVUBDoS4uCv+sWJQ4t+OBbvFNHvYhP3Iicnf9ZwJwc1hTyKYn9wV+gCcWromYn9DNO+
         cu5A==
X-Gm-Message-State: AOAM531BS6rAFeHKAKLWNldE63/1MknodaxhXZAGh2Fg6JIIibq+u+pK
        187XEGb+1r0IeIC0ZMBV0p3WRjZW5YRYlINO4hA=
X-Google-Smtp-Source: ABdhPJxH53sSQQ6MgkCscPJLy6R+m/Ffo7n4UaokQzcM2BtXNS/a2/B/Xn5yLGNX8exhkr0lIHwWS3e7Q7DJIU8Q1a0=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr21110123otc.262.1590413614201;
 Mon, 25 May 2020 06:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200430063229.6182-1-rui.zhang@intel.com> <20200430063229.6182-2-rui.zhang@intel.com>
In-Reply-To: <20200430063229.6182-2-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 15:33:23 +0200
Message-ID: <CAJZ5v0j1Nehwq5eCVBo7StJ=vxBKpO454ywkVJmVRD=MQOVu=w@mail.gmail.com>
Subject: Re: [PATCH 1/6] iwlwifi: use thermal_zone_device_update() for
 temperature change
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        andrzej.p@collabora.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        luca@coelho.fi
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 30, 2020 at 8:29 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> thermal_notify_framework() is an obsolete API, and iwlwifi is the only
> user of it.
> Convert iwlwifi driver to use thermal_zone_device_update() instead.

IMO it is rather hard to figure out what is going to change
functionally, from the driver's perspective, after this change.

In particular, is user space going to notice any change?  If so, then
what kind of change can it see?

> Note that, thermal_zone_device_update() is able to handle the crossed
> threshold by comparing the current temperature with every trip point, so
> ths_crossed variant in iwl_mvm_temp_notif() is probably not needed.
>
> It is still left there in this patch, in case the debug information is
> still needed.

Well, it should be possible to figure this out just from the code ...

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> index 418e59b..6344b6b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -203,9 +203,8 @@ void iwl_mvm_temp_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
>
>         if (mvm->tz_device.tzone) {
>                 struct iwl_mvm_thermal_device *tz_dev = &mvm->tz_device;
> -
> -               thermal_notify_framework(tz_dev->tzone,
> -                                        tz_dev->fw_trips_index[ths_crossed]);
> +               thermal_zone_device_update(tz_dev->tzone,
> +                                          THERMAL_EVENT_UNSPECIFIED);
>         }
>  #endif /* CONFIG_THERMAL */
>  }
> --
> 2.7.4
>
