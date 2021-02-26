Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40423266AB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 19:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBZSEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 13:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZSEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 13:04:41 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B37C061574;
        Fri, 26 Feb 2021 10:04:01 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lFhSn-0091en-Ra; Fri, 26 Feb 2021 19:03:42 +0100
Message-ID: <4a997ea7b6625428c21dc3e423e96ee54d6785e2.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/3] lockdep: add lockdep lock state defines
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shuah Khan <skhan@linuxfoundation.org>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Feb 2021 19:03:40 +0100
In-Reply-To: <af1511df953fe49f95953cbc23d86fb7cdaff58d.1614355914.git.skhan@linuxfoundation.org> (sfid-20210226_185441_806149_D5A42553)
References: <cover.1614355914.git.skhan@linuxfoundation.org>
         <af1511df953fe49f95953cbc23d86fb7cdaff58d.1614355914.git.skhan@linuxfoundation.org>
         (sfid-20210226_185441_806149_D5A42553)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> @@ -5475,7 +5476,7 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
>  		/* avoid false negative lockdep_assert_not_held()
>  		 * and lockdep_assert_held()
>  		 */
> -		return -1;
> +		return LOCK_STATE_UNKNOWN;

I'd argue that then the other two return places here should also be
changed.

johannes

