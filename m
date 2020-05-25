Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED31E096B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbgEYI6D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgEYI6D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 04:58:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B0FC061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 01:58:02 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd8vl-002ara-If; Mon, 25 May 2020 10:57:57 +0200
Message-ID: <695723cd3134d8abf120c886c5d7d5791cae0d03.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/9] cfg80211: Add new channel flag to identify 6GHz
 PSC channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 10:57:56 +0200
In-Reply-To: <05fcfc43f2d59dd549a65a83ab60df60@codeaurora.org>
References: <20200522072431.27601-1-pradeepc@codeaurora.org>
         <20200522072431.27601-2-pradeepc@codeaurora.org>
         <fa1879bf357c091277972b2a370799fdf6192ae3.camel@sipsolutions.net>
         <05fcfc43f2d59dd549a65a83ab60df60@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-22 at 16:46 -0700, Pradeep Kumar Chitrapu wrote:
> IMO, accessing flag would be faster instead of computation, as this info
> is handy (already in cache) when accessing ieee80211_channel.

True.

> However, considering general usage for this info would be only for 
> control
> path, it should be ok to expose function instead of maintaining separate 
> flag.

Yeah, I can't really see where we'd care ... this is used only when we
set up a scan, etc.

> Please let me know your suggestion..

I'll now go and try to consolidate all your changes and ours, we'll see
what falls out.

johannes

