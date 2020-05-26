Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39331E222A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbgEZMob (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389265AbgEZMob (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 08:44:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FB4C03E96D
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 05:44:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdYwU-003QQT-3X; Tue, 26 May 2020 14:44:26 +0200
Message-ID: <d4e39180f0a8a8b07dc558c9439b66cd2c3aec07.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: enable TKIP when using encapsulation
 offloading
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 May 2020 14:44:25 +0200
In-Reply-To: <1587720951-9222-2-git-send-email-murugana@codeaurora.org> (sfid-20200424_113624_468114_4CC488DE)
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
         <1587720951-9222-2-git-send-email-murugana@codeaurora.org>
         (sfid-20200424_113624_468114_4CC488DE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-24 at 15:05 +0530, Sathishkumar Muruganandam wrote:
> TKIP was disabled on encap offload mode since if TKIP MIC error
> reporting is not capable by the driver using encap offload mode,
> then TKIP countermeasures wont work.
> 
> Enabling back TKIP bring-up in encap offload mode to leave the
> control with the driver to disable hw encap when it is not capable
> of TKIP MIC error reporting.

So how can the driver do TKIP MIC error reporting?

I don't think it can. It doesn't have all the necessary information to
call cfg80211_michael_mic_failure(), as far as I can tell.

I'm not applying this until I see at least the *ability* for drivers to
do it. I mean, I don't really want to worry about your driver's
correctness, but if you then turn around and realize that you *cannot*
actually implement the right behaviour, that's no good either.

johannes

