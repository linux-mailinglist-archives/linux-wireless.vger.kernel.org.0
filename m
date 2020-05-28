Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2753A1E5C3A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgE1Jlo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgE1Jlo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:41:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D3C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 02:41:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeF2j-004m86-Mz; Thu, 28 May 2020 11:41:41 +0200
Message-ID: <650d683aeabd94a69bad64ae2a0af45c2fe25cd1.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/11] mac80211: determine chantype from HE operation
 in 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 28 May 2020 11:41:40 +0200
In-Reply-To: <74232fe9a140a15306c04f0509e6c615b8e329de.camel@sipsolutions.net> (sfid-20200527_164156_614875_57253EF5)
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-10-git-send-email-rmanohar@codeaurora.org>
         <74232fe9a140a15306c04f0509e6c615b8e329de.camel@sipsolutions.net>
         (sfid-20200527_164156_614875_57253EF5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-27 at 16:41 +0200, Johannes Berg wrote:
> 
> Hmm. Yes, we just had
> 
> +       case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ:
> +               if (abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0) == 8)
> +                       he_chandef.width = NL80211_CHAN_WIDTH_160;
> +               else
> +                       he_chandef.width = NL80211_CHAN_WIDTH_80P80;
> +               break;
> 
> 
> but that breaks if you don't support 80+80 or 160.
> 
> OTOH, we check this later again, I think, and downgrade if we don't
> support it, so no harm done?
> 
> I think I'd prefer the parsing to be exact, and then downgrade as
> necessary. That makes things a bit simpler.

Except that won't work for mesh.

I actually kinda like this better than what I did, because what I did
required all kinds of contortions with DISABLE_HT/VHT/HE ...

Still checking.

johannes


