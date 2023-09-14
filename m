Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E530C7A055C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjINNTW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbjINNSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 09:18:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244502107
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 06:18:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7DDC433C7;
        Thu, 14 Sep 2023 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694697489;
        bh=oRdTkO1Bg/J6QPqLOcvJSa1zSAhMOHyLWami5YtJwr4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hh7lNoQ07hRSM49MuXmbmXOOkReaKt+F8pAZS6gPziDZMMC+NQUDMMkW6oxj6lW6v
         KJUf45C5/2pIot22CPhpTzY8UnITh14sfz5rPk0MphnqP8H9gv30oumhk1BoF/SFvy
         QGCikFHJHQnLL8q5gdHCXmhcGCx3fBeKnEVOsP4rMUqblCdJyaQqOLSiMzYhojicQM
         gpL1lMealSNvB8XKFUCe+HkA1Werz3zbpU1OvIpC4mKW1nwltLPUz/BTOxTAvIDbhP
         d5F014rkjOzPICJ6llg0T5eMCRKD8d+4GmmQIIlUGnN1KqdT1RYGJwVyv+C2gvY1FI
         6cqA1Yw+a31mw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v6] wifi: cfg80211: save power spectral density(psd) of
 regulatory rule
References: <20230914082026.3709-1-quic_wgong@quicinc.com>
Date:   Thu, 14 Sep 2023 16:18:06 +0300
In-Reply-To: <20230914082026.3709-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Thu, 14 Sep 2023 04:20:26 -0400")
Message-ID: <87bke4dhbl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> 6 GHz regulatory domains introduces Power Spectral Density (PSD).
> The PSD value of the regulatory rule should be taken into effect
> for the ieee80211_channels falling into that particular regulatory
> rule. Save the values in the channel which has PSD value and add
> nl80211 attributes accordingly to handle it.
>
> Co-developed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
> V6: change per johannes.
>    1. rebased to ath-202308030925
>    2. remove change in parse_reg_rule() which is for CRDA

It's a bit risky to use my ath.git master branch as the baseline for
cfg80211 and mac80211 patches, for example it doesn't have the latest
locking rework yet.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
