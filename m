Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292746F262
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhLIRrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:47:18 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52710 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbhLIRrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:47:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 21F67CE2788
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8602AC004DD;
        Thu,  9 Dec 2021 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071808;
        bh=I83CQb/ibuEVnt+IEDLl9+ht7ZHvXZrH38RcSDi0N8w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KtjC5r0qS1hCnAcu0F5AjrPlCTBjL3BL9BKDPJwqX4QxAQkCZvRxsr99YII/bKMcX
         UFwFAbgBK/IYE+mJhoZ62IJwrLnENBl0uVx9T05D7becAnFYiUtelxwVzUIr/uwzON
         egECooQ5urHyEq16bZK2YasAj21p34u9KUbNR5wlTFF9ewDUFiNuVNh8tYt+4PvMrC
         Sd3epUCtUbvo1fmsUUnusNqi8McXQ0WuYelQ0ntu4lT0iffPCWL41k5uYQJGdNBEm8
         tbxr7QhAQkCAZ/FBpsK+RiE62QSeVqCWy7wQw3VlC5g7K/o+GwfNFYw+UZqwVMCFcN
         WFPTGTHZbAeWQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/15] ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 19:43:24 +0200
In-Reply-To: <20211026111913.7346-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:18:58 -0400")
Message-ID: <87lf0tvflv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> It introduced some new concept:
> power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
> power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
> power spectral density(psd)
>
> This patchset is to implement the new rules for 6 GHz band in
> ath11k.
>
> ath11k parsed the reg rules from new wmi event
> WMI_REG_CHAN_LIST_CC_EXT_EVENTID and parse the
> transmit power envelope element in beacon of AP
> and then set new wmi cmd WMI_VDEV_SET_TPC_POWER_CMDID
> to firmware when connect to 6G AP, also support backward
> compatibility with firmware which not support new wmi
> cmd WMI_VDEV_SET_TPC_POWER_CMDID.

Looked good to me, had only minor nitpicks.

> It depends on the patches of mac80211/ieee80211/cfg80211
> ad below links:
>
> ieee80211: add definition of regulatory info in 6 GHz operation information
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1ef61825469b874920f4afb889e1a92353680ff
>
> ieee80211: add definition for transmit power envelope element
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad31393b98e4addbc5f1ccc484bfbb8d07c92056
>
> mac80211: parse transmit power envelope element
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0345850ad770c5164bf6d4a0aa0c40ef2419cb0
>
> mac80211: use ieee802_11_parse_elems() in ieee80211_prep_channel()
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=37123c3baaee4d6a189ad4abad804770d4a607e8
>
> ieee80211: add power type definition for 6 GHz
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=405fca8a946168e71c04b82cc80727c3ea686e08
>
> mac80211: add parse regulatory info in 6 GHz operation information
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=cb751b7a57e50d356ec8fc7712c245a05515e787
>
> mac80211: save transmit power envelope element and power constraint
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=63214f02cff9ebd57be00e143de12107c66f5394
>
> [v5] cfg80211: save power spectral density(psd) of regulatory rule
> https://patchwork.kernel.org/project/linux-wireless/patch/20210928085211.26186-1-wgong@codeaurora.org/

To reduce number of conflicts I recommend submitting the next version
only after all the dependencies have landed to ath-next. And remember to
--base, it makes it easier for me to apply patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
