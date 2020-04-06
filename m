Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCD19FD38
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDFSce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 14:32:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37597 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSce (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 14:32:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so812734ljd.4
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHBkh6A4QmQ1QdQQaoYlIySdrjTmck6qGDvL47/amQE=;
        b=FmOQwQfiBPsvFAmUfDhBRZcBTAF089WWQzMPjbkAlQT4qhhyExFnrLpDaplTHToeio
         jWZQM2LyqBrl9AslEpGHT0ypYql+DCtm3yLYY70kohY0WPJefiTSTHxUa+KU/b3rDESf
         w6vIIwZjqDAGwAAX8qsm6AlYVuhd95T1keoS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHBkh6A4QmQ1QdQQaoYlIySdrjTmck6qGDvL47/amQE=;
        b=GXhay7kmSd97JEwkclJ2SzNeAJq/JVO/uoaJ/Q+ZDj3oj4cLWxabNUFLL8UyMY84EN
         uOCyfO0UpJjgSc0TLuaUfH1jHWyZV1ZGOVMvBLDWcIEpmC1iBm2BK2YzGURs4nziUEcU
         48AUnN85D8vbTO9bZ4b/7ynX+BGpKKOrNlFUV9UrGsw36oN6+JZHiWuQadNs5mTCsk82
         6AoaQZsnOM4oyH6UPU0NH98bYiWaARCXV4ZSGi4PoypfuVQQEFPcjykOZt56NDyRcydj
         GoH4ZF9o6LmoE59MOO8cY1iwageEUprGuxIAybUPI1rivFUOndZ3Qb1j01nrozd9AJNc
         OvXw==
X-Gm-Message-State: AGi0PuZ6fvzR0XTZ44Tfi3i5vJGAtRoVWXZh3Er83xTlFlRWIiYacu06
        a+XpNLs86jwBXXSuvNX6xq+OZwg2TU8=
X-Google-Smtp-Source: APiQypLJcXGWe1nc+uPjRuqdUGqrNiE/18CKCsmFi9iwh5cxklgoOD+i5SN7+UsF6QPaBEF4RFQMcA==
X-Received: by 2002:a2e:7a0b:: with SMTP id v11mr359719ljc.120.1586197951406;
        Mon, 06 Apr 2020 11:32:31 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a26sm10226997ljn.22.2020.04.06.11.32.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 11:32:30 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w145so316523lff.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 11:32:30 -0700 (PDT)
X-Received: by 2002:a19:550a:: with SMTP id n10mr6689123lfe.143.1586197949980;
 Mon, 06 Apr 2020 11:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200406074705.25022-1-yhchuang@realtek.com>
In-Reply-To: <20200406074705.25022-1-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 6 Apr 2020 11:32:18 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM3ZBB53LWWdZQj+adi0LZ4bN5=R1yRju4HV9K+3NLMOQ@mail.gmail.com>
Message-ID: <CA+ASDXM3ZBB53LWWdZQj+adi0LZ4bN5=R1yRju4HV9K+3NLMOQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: add more check for wowlan pattern
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        timlee@realtek.com, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Johannes

On Mon, Apr 6, 2020 at 12:47 AM <yhchuang@realtek.com> wrote:
> Previously the mask of wowlan pattern is not checked,
> and it may lead to wrong pattern match. We fix it and
> add wildcard type for the pattern whose DA is not masked.
> Besides, if user pattern is an invalid type for us,
> show the error in kernel log, and then wowlan will
> not work.
...
> --- a/drivers/net/wireless/realtek/rtw88/wow.c
> +++ b/drivers/net/wireless/realtek/rtw88/wow.c
> @@ -74,6 +74,9 @@ static void rtw_wow_pattern_write_cam_ent(struct rtw_dev *rtwdev, u8 id,
>         case RTW_PATTERN_UNICAST:
>                 wdata |= BIT_WKFMCAM_UC | BIT_WKFMCAM_VALID;
>                 break;
> +       case RTW_PATTERN_WILDCARD:
> +               wdata |= BIT_WKFMCAM_VALID;
> +               break;
>         default:
>                 break;

I take it by the calling code, that you should never reach this
default case, and if you do, you're programming a non-working pattern,
right? Might it deserve a call to WARN() or similar?

>         }
> @@ -131,17 +134,47 @@ static u16 rtw_calc_crc(u8 *pdata, int length)
>         return ~crc;
>  }
>
> -static void rtw_wow_pattern_generate(struct rtw_dev *rtwdev,
> -                                    struct rtw_vif *rtwvif,
> -                                    const struct cfg80211_pkt_pattern *pkt_pattern,
> -                                    struct rtw_wow_pattern *rtw_pattern)
> +static int rtw_wow_pattern_get_type(struct rtw_vif *rtwvif,
> +                                   const u8 *pattern, u8 da_mask)
> +{
> +       u8 da[ETH_ALEN];
> +       u8 type;
> +
> +       ether_addr_copy_mask(da, pattern, da_mask);
> +
> +       /* Each pattern is divided into different kinds by DA address
> +        *  a. DA is broadcast address
> +        *  b. DA is multicast address
> +        *  c. DA is unicast address same as dev's mac address
> +        *  d. DA is unmasked. Also called wildcard type.
> +        *  e. Others is invalid type.
> +        */

So I take it that (e) is "looks like unicast, but the user didn't
provide the whole DA, or the DA isn't ours"? It feels to me like
that's still something actionable, in some cases. Cases:
(1) partial mask, matching
(2) partial mask, non-matching
(3) full mask, non-matching
I'm not totally sure about (2) and (3), but that feels to me like
something we don't really expect to accept anyway -- should this be
rejected in the higher-level API?
For (1), it seems like it would probably be reasonable to still
interpret this as unicast? I know that might not strictly follow what
the user asked, but it feels pretty close -- and I also don't believe
that it's wise to mostly-silently (yes, you added kernel logging; but
this still doesn't get fed back to the user-space caller) drop the
wake-pattern request.

Alternatively, if you're going to strictly reject stuff like this,
then maybe you need to add a cfg80211 driver validity callback, so you
can reject patterns up front. I think Johannes suggested this was a
possibility before.

Brian

> +       if (!da_mask)
> +               type = RTW_PATTERN_WILDCARD;
> +       else if (is_broadcast_ether_addr(da))
> +               type = RTW_PATTERN_BROADCAST;
> +       else if (is_multicast_ether_addr(da))
> +               type = RTW_PATTERN_MULTICAST;
> +       else if (ether_addr_equal(da, rtwvif->mac_addr) &&
> +                (da_mask == GENMASK(5, 0)))
> +               type = RTW_PATTERN_UNICAST;
> +       else
> +               type = RTW_PATTERN_INVALID;
> +
> +       return type;
> +}
