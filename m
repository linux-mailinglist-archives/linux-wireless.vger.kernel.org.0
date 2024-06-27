Return-Path: <linux-wireless+bounces-9654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAD91A440
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB34B21CCB
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B3148313;
	Thu, 27 Jun 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An4EoEJG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97862145B13
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485238; cv=none; b=IPmX0TKpSsCEN8txwC2Ahyx7ijeWpEtx/p5Nm0S2o2oF+CMafRnXhM7idTRoIBceOK8jW0VoiTC36qGj/9XXXKi6CxZTvdlgqO0wsAXDvBdaKntuobu0/VKI1d0lD3IqJKQ4AEqq9hXupPpVFyDqIuLcLgOxe91aJs+IcYRlW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485238; c=relaxed/simple;
	bh=9zd7UPmSQBZxNz6VkgeBKlQwDk0cYq8owSRhAhNHh7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqQGjqAV5xcpLfOvrUXqlZ+O1WlhAWez0XqYPKP3u+AVWA/32Z2IQXPqSzz7TAwyYObX7cJmOn8Hybh4ezRJuLlEzCyluG4EZokvP8jnaeGRCsYkTYyyKMcftLPaTThGHSiE7eSHTwc0jm+3+mL0vNCOW/ZasSsK69QiuNsXo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An4EoEJG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7066cba4ebbso3544028b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719485236; x=1720090036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6weZCoGkC8VPJ5Cz6/sLBrI0zoEPTf9kcE1sd3WDwJ0=;
        b=An4EoEJGfEHZ2EMhyhBxhlE0fA6+s5BR/J/NE6pmLzAxz6lQGTXu3DKc4SCYbkCVMW
         v6VJD49KROAadgPV8/NNH97sGWWSvSFK1X8NZ7AZd/PUJuGSFb1L0YsKTMiWNVE6fjsr
         XTfOKGpwPNp4hvnO1x0ltFWT/3r+Jj8OIyB+HurFq3vnbWrv8Mls9oR8srzJOoAcOXo0
         zsBSyjVogdQDi0iW7qLYg5qAupBFThk0BmFR5OzWtcekskhmY0MYAfjKeRVvC4fWwOfl
         yCrit5aEPyPsTbSnSx0DyZppW6yeFDM6EbVuJ+E5UQiu/C+NSSYAEUfIT0WMjpkQcL5W
         m5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485236; x=1720090036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6weZCoGkC8VPJ5Cz6/sLBrI0zoEPTf9kcE1sd3WDwJ0=;
        b=JfRUnh9aexRs897Mnm+THCS5+vvfryr/urtQlyXSfNlDIs2J+yCsPSkRgmYlzfLn50
         oSwTe9t31CdmC8kYGULxcMbv0yC2qwlcQ5jMAm87bRmGWxuWc/cXw7SeDNiekpR6Ti4H
         kJH/tV8RoM4eHccG9duF1+Rg7ufDUcTcRmq9zhXIL8WeHWIC1o43HJDaqG1gXVLX4d+N
         6T+RzqDb4xwOEqBWEtBwk0Kbdz8X8/9C3k0PUbBOngI2K0oLIN0ovy6Rq7xvwKEVd6E6
         Uj61M9+E+w0PPoJB6I8S1q9X24qeKD+XZlD/4d6HAjRXUL0qEvA9+y+4FqzGGlOdvfSM
         C16w==
X-Gm-Message-State: AOJu0YzKOBrpCIJfgzzNp6aNbowGMojpxh/4zXC/lyy4IUwBBba7HrDr
	STAjuQvI0tGj2RoTiT5jBot+mLdf1Sp72t44272wUfGScP21QED6a9ISLMQLSCYBf0o/DcvXxxv
	7sK6XLAb8IqmgrSILfUuT7HODFbU=
X-Google-Smtp-Source: AGHT+IE2Zs2D8E9X/lxdxI9jqWm7ougLIHUAgqmR3AxkdmwFDIGvS0x2n38/xKZ/xMGNO6c85VIbBvIkFgYgkcxc7Qo=
X-Received: by 2002:a62:fb07:0:b0:704:14b9:105 with SMTP id
 d2e1a72fcca58-7066e538954mr11875774b3a.13.1719485235773; Thu, 27 Jun 2024
 03:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627103936.4a7cd28f3136.I328a219e45f2e2724cd52e75bb9feee3bf21a463@changeid>
In-Reply-To: <20240627103936.4a7cd28f3136.I328a219e45f2e2724cd52e75bb9feee3bf21a463@changeid>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 27 Jun 2024 12:47:03 +0200
Message-ID: <CAOiHx=kKuGWhEQrtRXx5HJqR46D8o34ug8iXrc0nBkCFiZzjPw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>, 
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 27 Jun 2024 at 10:40, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> This flag is annoying because it puts a lot of logic into mac80211
> that could just as well be in the driver (only iwlmvm uses it) and
> the implementation is also broken for MLO.
>
> Remove the flag in favour of calling drv_mgd_prepare_tx() without
> any conditions even for the deauth-while-assoc case. The drivers
> that implement it can take the appropriate actions, which for the
> only user of DEAUTH_NEED_MGD_TX_PREP (iwlmvm) is a bit more tricky
> than the implementation in mac80211 is anyway, and all others have
> no need and can just exit if info->was_assoc is set.
>
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++++----
>  .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 ++
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +++
>  .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 ++
>  include/net/mac80211.h                        | 22 ++++-----------
>  net/mac80211/debugfs.c                        |  1 -
>  net/mac80211/main.c                           |  3 --
>  net/mac80211/mlme.c                           | 28 ++++---------------
>  8 files changed, 25 insertions(+), 49 deletions(-)
>

(snip)

> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 3d207d79d11f..3804a5fa4a2a 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -3521,6 +3521,10 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>         u64 changed = 0;
>         struct ieee80211_prep_tx_info info = {
>                 .subtype = stype,
> +               .was_assoc = true,
> +               .link_id = sdata->vif.active_links ?
> +                               __ffs(sdata->vif.active_links) :
> +                               0,

Shouldn't the else be -1?

>         };
>
>         lockdep_assert_wiphy(local->hw.wiphy);
> @@ -3569,29 +3573,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>
>         /* deauthenticate/disassociate now */
>         if (tx || frame_buf) {
> -               /*
> -                * In multi channel scenarios guarantee that the virtual
> -                * interface is granted immediate airtime to transmit the
> -                * deauthentication frame by calling mgd_prepare_tx, if the
> -                * driver requested so.
> -                */
> -               if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP)) {
> -                       for (link_id = 0; link_id < ARRAY_SIZE(sdata->link);
> -                            link_id++) {
> -                               struct ieee80211_link_data *link;
> -
> -                               link = sdata_dereference(sdata->link[link_id],
> -                                                        sdata);
> -                               if (!link)
> -                                       continue;
> -                               if (link->u.mgd.have_beacon)
> -                                       break;
> -                       }
> -                       if (link_id == IEEE80211_MLD_MAX_NUM_LINKS) {
> -                               info.link_id = ffs(sdata->vif.active_links) - 1;

Here it would be ffs(0) - 1, which is -1, not 0.

Regards,
Jonas

