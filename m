Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A71E5EA4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgE1Lqk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388451AbgE1Lqj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 07:46:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67CC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 04:46:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeGzc-004pfC-7b; Thu, 28 May 2020 13:46:36 +0200
Message-ID: <8dc7ace01aba3243ff99da5554c6e7f5fbc59c52.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/11] mac80211: determine chantype from HE operation
 in 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 28 May 2020 13:46:35 +0200
In-Reply-To: <650d683aeabd94a69bad64ae2a0af45c2fe25cd1.camel@sipsolutions.net> (sfid-20200528_114159_324068_E483B6CC)
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-10-git-send-email-rmanohar@codeaurora.org>
         <74232fe9a140a15306c04f0509e6c615b8e329de.camel@sipsolutions.net>
         (sfid-20200527_164156_614875_57253EF5) <650d683aeabd94a69bad64ae2a0af45c2fe25cd1.camel@sipsolutions.net>
         (sfid-20200528_114159_324068_E483B6CC)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 11:41 +0200, Johannes Berg wrote:
> 
> I actually kinda like this better than what I did, because what I did
> required all kinds of contortions with DISABLE_HT/VHT/HE ...

Actually, that's orthogonal. You had some of that, but not fully ...

This patch is doing almost the same thing we did, except you're taking
the capabilities into account immediately.

I'll go combine them and factor in the STA_DISABLE_BITS you had too, if
needed.

johannes

