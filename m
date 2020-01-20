Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B43142C24
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 14:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgATNeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 08:34:08 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:55428 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgATNeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 08:34:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579527247; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3/luni3J7ScBx0bY1SZF2X8ybATefN1wEs60Hdbp9to=;
 b=KkYBO5TUv9Dr+PguB1Vw8SAokSCPHUrUYDMVktnG68j2Yr0uz/aPVw2+O7Jlvqh7chvHzzxo
 HmJzbGmpbnNWIN0eK/gvPnF91I9/GRduCd+yNxNf0M39ytnahdPddsnO+gqQiSl5DxNOhyjF
 lJK/aK9jTas3hX6ou6IEfaXwfWA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e25ac4a.7f1bdf197768-smtp-out-n02;
 Mon, 20 Jan 2020 13:34:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A006C433A2; Mon, 20 Jan 2020 13:34:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5573C433CB;
        Mon, 20 Jan 2020 13:34:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 21:34:00 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <CAMrEMU8DmXBGGU-WNd9bQAVVkHF6SCO7c_wv+dyH9D7KFOB8jw@mail.gmail.com>
References: <20200108031957.22308-1-wgong@codeaurora.org>
 <20200108031957.22308-2-wgong@codeaurora.org>
 <CAMrEMU-UTtxJ-eMoNEBONXJCTpaZCcGc8Mu34wqQNXkpVz=gJA@mail.gmail.com>
 <55ab2d64e78d51a9da587f276899e08b@codeaurora.org>
 <a1950ee2cb8dd9fc10e7d31bf18c9c95@codeaurora.org>
 <CAMrEMU8DmXBGGU-WNd9bQAVVkHF6SCO7c_wv+dyH9D7KFOB8jw@mail.gmail.com>
Message-ID: <7ad4db8ea256a823778edf89b2a1b2fc@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-20 17:38, Justin Capella wrote:
> Ok thanks. I am still trying to familiarize myself with ath10k. A
> couple things come to mind:
> 
> firstly recently there was a patch that set stations back to
> associated during recovery, do you know if the branch you're working
> against includes that? I will try to figure that out myself but it's
> at least worth considering.
> 
can you give the patch link or patch?

> If I remember correctly, the sdio rx involves peeking and checking to
> see if the frame/packet continues/has more. In the case of firmware
> recovery/reconfig I think current code enables all sorts of debug
> pktlog stuff, historically it was maybe used as a hack to check for hw
> changes... But I mention it because I think what might be happening in
> some cases is fw crash follows a frame that would continue/extend,
> which is messing with the content and act_len (maybe?)
does it have relation with this patch?
> 
> I also noticed that with aggregation I wind up getting a
> deauth/dissasoc followed by mlme delete sta/peer/key.
> 
does it have relation with this patch?
> I think a retry count could be useful but what do you think of maybe
> using an event / timeout?
> 
does it have relation with this patch?

> 
> 
