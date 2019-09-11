Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878CCB01A6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfIKQ3E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 12:29:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42813 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfIKQ3E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 12:29:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id c17so6641064qtv.9
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nhm2A4+trtXOBveeEgcpKh0Vl3WCV4JO8R3DNc1eMD8=;
        b=Yr1hXO9qIWkhaw6vTPU6VqTL071P0K26Xw5NEXg436EvqR50evoMpJbIO20fy0Csbk
         36PXIJGjHpIYBeVDJ5/wnKcvuS4xNIV6d8QIFVaQTYgk6xfU5eQh/RQOKX1qNlCEVp74
         Hn5ESTlsZYNr+iBV76WSyVoSowcd7oLMyh6XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nhm2A4+trtXOBveeEgcpKh0Vl3WCV4JO8R3DNc1eMD8=;
        b=A68JII0ir/gsbzTXhe0UB/sWyAoJFolM6emWD27HiaxAb5WfJ/kA9kNBAgqawFpTzg
         yzsPUOZsmXtYBunlABPKhWYNVuJHQnewKWdJCGW/AdkWElUjNdV1yt3BsLiOIlKXXcel
         L1Z+/0Nw17ugZ0QUlrTqbuoAMaRc/51x3AxOdt296CzS8c3QwAz46seMFFA2PpuH4Elt
         yQ+I5caTD8ug0Lq/r8U+tZnYHfYI5oK99WLhlvdu1ibq000xSff6i5HFAGy5yFbAlWuP
         lLysp9WSVWQ+FfK9peyWMtGURf0/83zsIWvxdi0NCDlEjxtoRB8J1Jw7tDAouft9MamE
         Nyiw==
X-Gm-Message-State: APjAAAUOYSPaqnRtnM/io/16elRxThNxC4CyFOO5axtbQawy2cNkvYn4
        29U2/8L74etNVD3OkXRoPPr2AHznv5y5WMYCjrKD8IPQ
X-Google-Smtp-Source: APXvYqxcw1SDBgThrX4w1cgNkqATCf/34KloCTyHR2ji+wEk0Td5PlwM1Qxe4gnZK/qC1qVWTu/2wujmIUGn/YzOHFc=
X-Received: by 2002:ac8:689a:: with SMTP id m26mr27268982qtq.309.1568219343487;
 Wed, 11 Sep 2019 09:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <1568188529-14653-1-git-send-email-aaron.komisar@tandemg.com>
In-Reply-To: <1568188529-14653-1-git-send-email-aaron.komisar@tandemg.com>
From:   Peter Oh <peter.oh@eero.com>
Date:   Wed, 11 Sep 2019 09:28:51 -0700
Message-ID: <CALhWmc2qPf-qCrx3JdejkOi-SQnURnehF43byCk-nZtCDWoJ3Q@mail.gmail.com>
Subject: Re: [PATCH] Can't scan on ETSI domains when operating ch is DFS
To:     Aaron Komisar <aaron.komisar@tandemg.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 11, 2019 at 12:59 AM Aaron Komisar
<aaron.komisar@tandemg.com> wrote:
>
> In non-ETSI reg domains scan is blocked when operating channel is a DFS ch.
> For ETSI domains, however, once DFS channel is marked as available afer
> the CAC, this channel will remain available even after leaving this channel.
> Therefore a new CAC will not be required when scan is done.
>
> In cfg80211 scan is not blocked for ETSI reg domains.
> This patch enables scan in mac80211 as well when operating channel is a radar
> channel for ETSI reg domains.
>
> Signed-off-by: Aaron Komisar <aaron.komisar@tandemg.com>
> ---
>  include/net/cfg80211.h | 8 ++++++++
>  net/mac80211/scan.c    | 6 ++++--
>  net/wireless/reg.c     | 1 +
>  net/wireless/reg.h     | 8 --------
>  4 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 5253e7f667bd..5349898ed3e6 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5546,6 +5546,14 @@ const struct ieee80211_reg_rule *freq_reg_info(struct wiphy *wiphy,
>  const char *reg_initiator_name(enum nl80211_reg_initiator initiator);
>
>  /**
> + * regulatory_pre_cac_allowed - if pre-CAC allowed in the current dfs domain
> + * @wiphy: wiphy for which pre-CAC capability is checked.
> +
> + * Pre-CAC is allowed only in ETSI domain.
> + */
> +bool regulatory_pre_cac_allowed(struct wiphy *wiphy);
> +
> +/**
>   * DOC: Internal regulatory db functions
>   *
>   */
> diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
> index adf94ba1ed77..812ff820844b 100644
> --- a/net/mac80211/scan.c
> +++ b/net/mac80211/scan.c
> @@ -523,7 +523,8 @@ static int ieee80211_start_sw_scan(struct ieee80211_local *local,
>  static bool ieee80211_can_scan(struct ieee80211_local *local,
>                                struct ieee80211_sub_if_data *sdata)
>  {
> -       if (ieee80211_is_radar_required(local))
> +       if (ieee80211_is_radar_required(local) &&
> +           !regulatory_pre_cac_allowed(local->hw.wiphy))
"pre-CAC allowed" doesn't mean that you can use the channel without CAC is done.
>                 return false;
>
>         if (!list_empty(&local->roc_list))
> @@ -630,7 +631,8 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
>
>         lockdep_assert_held(&local->mtx);
>
> -       if (local->scan_req || ieee80211_is_radar_required(local))
> +       if (local->scan_req || (ieee80211_is_radar_required(local) &&
> +           !regulatory_pre_cac_allowed(local->hw.wiphy)))
>                 return -EBUSY;
>
>         if (!ieee80211_can_scan(local, sdata)) {
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index 5311d0ae2454..50d3242c4985 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -3883,6 +3883,7 @@ bool regulatory_pre_cac_allowed(struct wiphy *wiphy)
>
>         return pre_cac_allowed;
>  }
> +EXPORT_SYMBOL(regulatory_pre_cac_allowed);
>
>  void regulatory_propagate_dfs_state(struct wiphy *wiphy,
>                                     struct cfg80211_chan_def *chandef,
> diff --git a/net/wireless/reg.h b/net/wireless/reg.h
> index 504133d76de4..dc8f689bd469 100644
> --- a/net/wireless/reg.h
> +++ b/net/wireless/reg.h
> @@ -156,14 +156,6 @@ bool regulatory_indoor_allowed(void);
>  #define REG_PRE_CAC_EXPIRY_GRACE_MS 2000
>
>  /**
> - * regulatory_pre_cac_allowed - if pre-CAC allowed in the current dfs domain
> - * @wiphy: wiphy for which pre-CAC capability is checked.
> -
> - * Pre-CAC is allowed only in ETSI domain.
> - */
> -bool regulatory_pre_cac_allowed(struct wiphy *wiphy);
> -
> -/**
>   * regulatory_propagate_dfs_state - Propagate DFS channel state to other wiphys
>   * @wiphy - wiphy on which radar is detected and the event will be propagated
>   *     to other available wiphys having the same DFS domain
> --
> 2.11.0
>
