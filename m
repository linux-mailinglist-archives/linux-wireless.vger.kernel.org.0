Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28BE3D37A8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhGWIoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 04:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbhGWIoQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 04:44:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46340C06175F
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0JdWgOa929mZt9XW51/0loJNuPAWSfmYDepqm0N5wcM=;
        t=1627032290; x=1628241890; b=RMUML8q66iQ3TInmpEkas3IrOu4kU+wmADyjwqW1svj7aJq
        YA4rDcz+M+7ouAdQd/7+75JRzEmHz13VwtqkHPZlCcWSUXQUXNDkSYsWrFeFWb8sUwrcsEolv1xH5
        0klZM020ApQgq+acHgjJ7lMQVagRhFPzGrE3WhG67KQrFuvrS5Nuk6fuVrI+xKSAaj+5wkQI/5sMq
        KJVy+gjm/rgTndRzhCB8ebL4omjoRccnkCDyJE9mbTAC6feHOHvgKMnnvON9p4GeoaXWHQh6v2pbm
        543GtKvsV6SzKMjsd2IDZKkgi0+nyamGBB23+DctUbpZLOI6EbYttN15uVJCd4rw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6rNe-000U0O-EV; Fri, 23 Jul 2021 11:24:45 +0200
Message-ID: <1553c2923cc332acf3da00b49e2d2ac17cc12ba0.camel@sipsolutions.net>
Subject: Re: [PATCH 4/9] cfg80211: add definition for 6G power spectral
 density(psd)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Jul 2021 11:24:44 +0200
In-Reply-To: <20210517201932.8860-5-wgong@codeaurora.org> (sfid-20210517_222029_605505_DDB76CEE)
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-5-wgong@codeaurora.org>
         (sfid-20210517_222029_605505_DDB76CEE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
> 
> + * @IEEE80211_CHAN_PSD: power spectral density (in dBm)
> + *	on this channel.

Do we need that? Which really is just another way of asking

> + * @psd: power spectral density (in dBm)

whether or not 0 is a valid value for this?

> +++ b/include/uapi/linux/nl80211.h
> @@ -4040,6 +4040,7 @@ enum nl80211_sched_scan_match_attr {
>   * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
>   * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
>   * @NL80211_RRF_NO_HE: HE operation not allowed
> + * @NL80211_RRF_PSD: channels has power spectral density value

It doesn't seem like we need this, after all, there must be some kind of
attribute for the PSD, and then its presence/absence already indicates
this?

johannes

