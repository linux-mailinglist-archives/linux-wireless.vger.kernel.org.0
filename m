Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D831FF0B5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfD3Gua (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 02:50:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3Gu3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 02:50:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D98C7608D4; Tue, 30 Apr 2019 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556607028;
        bh=DeQAAB1pw1IdME6koTSG0g2smPYIGndmCo1Y+2IerV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AVdf+3lWzWgkcGXhXQ8bRLAh/HniuwIQ4auXjsQvblrtt8vAWC1h04jaPpkAqzY0H
         lJ6Uc8SAx6++YFjCzGXNouzPoZqPQk0QHo87BL0BLt6/EjHQ+TN3UuUM0r8eij8i7L
         27lNSRzwQQV5QNCnPbc/xuLpZPD/jXnPOY8YUR+c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 37526602F3;
        Tue, 30 Apr 2019 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556607028;
        bh=DeQAAB1pw1IdME6koTSG0g2smPYIGndmCo1Y+2IerV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AVdf+3lWzWgkcGXhXQ8bRLAh/HniuwIQ4auXjsQvblrtt8vAWC1h04jaPpkAqzY0H
         lJ6Uc8SAx6++YFjCzGXNouzPoZqPQk0QHo87BL0BLt6/EjHQ+TN3UuUM0r8eij8i7L
         27lNSRzwQQV5QNCnPbc/xuLpZPD/jXnPOY8YUR+c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Apr 2019 23:50:28 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Srini Kode <skode@qti.qualcomm.com>,
        Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V2 3/3] ath11k: add TWT support
In-Reply-To: <20190426094150.18078-4-john@phrozen.org>
References: <20190426094150.18078-1-john@phrozen.org>
 <20190426094150.18078-4-john@phrozen.org>
Message-ID: <a71b6e5a4e60500c2d7cfa94563b0a5a@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-04-26 02:41, John Crispin wrote:
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c
> b/drivers/net/wireless/ath/ath11k/mac.c
> index 8bb4ff82fb6f..a38c101e0140 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1938,6 +1938,13 @@ static void ath11k_bss_info_changed(struct
> ieee80211_hw *hw,
>  		ath11k_mac_txpower_recalc(ar);
>  	}
> 
> +	if (changed & BSS_CHANGED_TWT) {
> +		if (info->twt_responder || info->twt_responder)
> 
typo? two twt_responder checks?

-Rajkumar
