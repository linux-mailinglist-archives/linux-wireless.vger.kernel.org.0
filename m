Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02343F83BA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 10:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhHZI0q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 04:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhHZI0p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 04:26:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC052C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yRAb8wzgZPM9JDBdvrupwwZip5xyRlAmMzl5arzWrro=;
        t=1629966358; x=1631175958; b=FxyEx9WZp4gMWyigRXEKO2AMBCoz9ETpaD4fITTd2kOcEQt
        cmstCWIwT8p+BWqofYeHJiCpch/2o7YtsD8Ja5SggJ6fk8R75ef6vUpFGngL85Pwnj+bJb2caPiLl
        lWjQFa3UENdpeLjc4oCDelL0G3L8o8r9VKAI2t8gUMGWF5rogdQHvy+0Dv7IylGgXGnNhEah0qN4N
        U1QH2oF2H7SNrUtjtzDmWbo0K4bykvbCP8gO8MfJ4yBa415hfGpob/FN0NzGrls/O8E9KfhK6jG+l
        3xrBKSoyjExWGH4RLvYSDHgn2AVbnGgIdiadNl5cDgysfa80j49h5II2E7LDd38Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJAhu-00G4n4-3k; Thu, 26 Aug 2021 10:25:54 +0200
Message-ID: <101b523a6fe06fea3e1c9642a1bf5e85a9d0e680.camel@sipsolutions.net>
Subject: Re: [PATCH v2 5/8] cfg80211: save power spectral density(psd) of
 regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 10:25:52 +0200
In-Reply-To: <20210820122041.12157-6-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-6-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I was going to apply this and patch 4 squashed, saying:


    cfg80211: regulatory: handle 6 GHz power spectral density (PSD)
    
    6 GHz regulatory domains introduce power spectral density (PSD).
    Allow wiphy-specific regulatory rules to specify these values.

but ...
> 
> +		if (chan->flags & IEEE80211_CHAN_PSD)
> +			chan->psd = min_t(s8, rrule1->psd, rrule1->psd);
> +

This is obviously wrong?

johannes

