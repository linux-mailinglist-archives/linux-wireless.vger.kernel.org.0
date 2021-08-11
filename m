Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A583E8E14
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhHKKHt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbhHKKHq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 06:07:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195D6C061765
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dcT2+AM+V1Yjt155WU2LBABRxISl1osjxMEi3eGGvlg=;
        t=1628676442; x=1629886042; b=CtviNlVI9KZUBlaI0JhjcTZEHHh7HsmdmQZd7Gi1rJiFVXl
        Oc6KmKZJkHzejqpd6RA8mqdgr+GCSOIARPfMRm1uH6DtSO809NjEVO+jywHzD/RK8ITfCi/mTkjBU
        yaZNRt9SJpPMJCbhAGrwaC0+2v02tZi+53Cru04k3AlqzowHCIKzC8QE3bA7QAwwQC5RjVlQW6utC
        uLa8tPn4rxHwTsCLctbXZFzHIASKTMIYeCacwd1sH/fWL3we2UErnA3+2G8Ta8zIszyp5be4YYALA
        cV2ZDnLfDphuQ7MZ22QmA8m7/9H2h8klBLj87Humaml9dYYC9clsheH2YR/8TWtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mDl8p-009AGp-1N; Wed, 11 Aug 2021 12:07:19 +0200
Message-ID: <d94af0309a1c7a1dee1841580b5938898426a10b.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Handling driver updated MU-EDCA params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 11 Aug 2021 12:07:18 +0200
In-Reply-To: <000801d78e5b$55d46530$017d2f90$@codeaurora.org>
References: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>
                 <1607468044-31789-2-git-send-email-msinada@codeaurora.org>
         <0f45b43c5a2dd4d0d2839487540611994ec10feb.camel@sipsolutions.net>
         <000801d78e5b$55d46530$017d2f90$@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-08-10 at 19:48 -0700, Muna Sinada wrote:
> Hello Johannes,
> 
> I saw on your review comment that this wrapper is not needed. I wanted
> to confirm with you if it would be ok to call a cfg80211 API from a
> mac80211 based driver, since that is what would be done if this
> wrapper is removed.

Yes, that's fine.

>  Additionally, another reason I have this wrapper is so I can place a
> tracepoint. What are your thoughts about this?
You already have a tracepoint on cfg80211, seems sufficient?

johannes

