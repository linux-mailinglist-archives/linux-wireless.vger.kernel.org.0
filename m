Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6170945ECF1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 12:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbhKZLwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 06:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhKZLuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 06:50:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B3C08E83B
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 03:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=v4CXiK2VSRy0yStahm2x95iTldgB5PONwlXemVdGswA=;
        t=1637925370; x=1639134970; b=WYiJ5KjKXj1lkOW/iiMcOnK5xw3d3RG+1neB3tbVAcyklC3
        /EyRBSmhFKMFzqSykYcrZkvOgykdK8tolFDDoUQOEy13FTz4RbHH20Ety+oS6GsEQmWl/8z5c0E5h
        4Kp2iOuIvZLACugA6wOr4p3u+CJ9+g+2zTrS1/dErb/inCbLEDxeswRDfht+1xfnrenKXZixYtKsE
        B+QgvdRWhodv8Ou/VTjl8dpgg48Ij5ffzrehLrdjAt0YtIknNscpOOhfw2E3ODiiZG+E9zUvQZcnR
        1w5jDDBXopjT3ewWk32eOkyOj0kLhnunW2mkAd/WtR+IIJK3hKCeKmiHd+L2+byw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mqZD5-0039gv-T5;
        Fri, 26 Nov 2021 12:16:08 +0100
Message-ID: <cce18c617b2a1860ebab329fb1f9077cd1399ec4.camel@sipsolutions.net>
Subject: Re: [v13 3/3] mac80211: MBSSID channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Fri, 26 Nov 2021 12:16:07 +0100
In-Reply-To: <20211006040938.9531-4-alokad@codeaurora.org>
References: <20211006040938.9531-1-alokad@codeaurora.org>
         <20211006040938.9531-4-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-10-05 at 21:09 -0700, Aloka Dixit wrote:
> From: John Crispin <john@phrozen.org>
> 
> Trigger ieee80211_csa_finish() on the non-transmitting interfaces
> when channel switch concludes on the transmitting interface.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> ---
> v13: Replaced list_for_each_entry_safe() by list_for_each_entry()
> 

Uh, ouch. I guess I miscommunicated that.

What I really meant was that the list iteration here:

> +	if (vif->mbssid_tx_vif == vif) {
> +		struct ieee80211_sub_if_data *child;
> +
> +		list_for_each_entry(child, &sdata->local->interfaces,
> list)

does not seem correct, since it's not locked, and you don't have any
guarantees that it's not being modified since the only thing here is
that the vif pointer is coming in valid from the driver?

johannes
