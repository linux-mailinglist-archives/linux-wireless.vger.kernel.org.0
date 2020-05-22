Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188AA1DF0B2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgEVUjF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbgEVUjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 16:39:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18471C061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 13:39:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jcERU-000zXL-Jj; Fri, 22 May 2020 22:38:57 +0200
Message-ID: <fa1879bf357c091277972b2a370799fdf6192ae3.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/9] cfg80211: Add new channel flag to identify 6GHz
 PSC channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 May 2020 22:38:54 +0200
In-Reply-To: <20200522072431.27601-2-pradeepc@codeaurora.org>
References: <20200522072431.27601-1-pradeepc@codeaurora.org>
         <20200522072431.27601-2-pradeepc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-22 at 00:24 -0700, Pradeep Kumar Chitrapu wrote:
> 6GHz channels are divided into preferred scanning channels(PSC)
> and non-PSC channels. One in every four 20MHz channels is a PSC.
> Spec mandates to use only PSC channels as primary channels for
> setting up BSS on 6GHz only AP.
> 
> The set of 20 MHz channels in the 6 GHz band, with channel center
> frequency, ch_a = Channel starting frequency – 55 + 80 × n (MHz)
> are referred to as preferred scanning channels (PSCs) where,
> n = 1, …, 15 as per IEEE P802.11ax/D6.0.
> 
> This flag also will be used when making scanning decision on
> 6GHz channels.

Is there much value in exposing this as a *flag*?

We have a similar patch, but it just adds the function and everyone who
cares can call it. Do we really need to precalculate that?

johannes


