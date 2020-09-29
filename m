Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93D327BEC6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgI2IEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI2IEk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 04:04:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C1C061755
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 01:04:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kNAcg-00CyHn-0N; Tue, 29 Sep 2020 10:04:30 +0200
Message-ID: <d64adff6e323884b0149049ca02f82958a211e2b.camel@sipsolutions.net>
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap
 power save
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:14 +0200
In-Reply-To: <871rilf2th.fsf@codeaurora.org>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
         <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
         <871rilf2th.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-29 at 10:40 +0300, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
> > > AP power save feature is to save power in AP mode, where AP goes
> > > to power save mode when no stations associate to it and comes out
> > > of power save when any station associate to AP.
> > 
> > Why do you think this requires a vendor command? I mean, that seems like
> > fairly reasonable - even by default - behaviour?
> 
> I have not studied the details, but doesn't AP power save break normal
> functionality? For example, I would guess probe requests from clients
> would be lost. So there's a major drawback when enabling this, right?

Not the way it's described above?

johannes

