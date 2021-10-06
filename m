Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497E1423FCE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhJFOJs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 10:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhJFOJr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 10:09:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 505856105A;
        Wed,  6 Oct 2021 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633529275;
        bh=D95Vrcms+Yoi8Ioz1qWrqDjHU3r6PZ2x8C3FThMJW/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNWLw7ACi2OM/iQJ4YFBH8CYm60tLB/vH1aNikY7bpvinMHzkfJMec1+VzYdzJRLx
         AR4ZADjQbRzp0LmWwEi7q13PS7KS5t0Hu4h4gm5A7FbHUf46Q0Amqxbz9jIuKziEPJ
         5bPirVlzYNRXnpZikK06ikx9OWXz7HzM/g2D9IpC+D8A8B/AVe/lPVHweaX0dMUEML
         b0U2VLK7kmM71KV3NMWMGYCNwg2pDYFFxWcC/NfhAY1aXHaHWb7tXV6TNAncjy4P1B
         0zIluUWCV5xZH+J/R850906AmPrvEyXDzXc+35eIq4JR0loHjSCBlW/km2SBRWQ5D6
         RL5xfMZ5/sDcA==
Date:   Wed, 6 Oct 2021 09:07:54 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for South Korea
 (KR)
Message-ID: <YV2tukujds7PodAf@ubuntu-x1>
References: <20210929172728.7512-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929172728.7512-1-mans0n@gorani.run>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 30, 2021 at 02:27:28AM +0900, Sungbo Eo wrote:
> This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
> Equipment Established Without Notice"), officially announced on 2021-01-06.
> 
> Extend the last 5 GHz frequency range to 5850 MHz.
> 
> WiFi 6E is now allowed with the following restrictions:
> * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 250mW EIRP
> * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25mW EIRP
> Here only the former entry is added.
> 
> And also update the regulatory source links.
> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> ---
> I have two questions.
> 
> The regulation has one more restriction:
>   The TX power should not exceed 2.5 mW/MHz
>   when the frequency range includes the whole or a part of 5230-5250 MHz
>   and the bandwidth is equal to or less than 40 MHz.
> That leads to the followings:
>   5230-5250 @ 20 -> 17 dBm
>   5210-5250 @ 40 -> 20 dBm
>   5170-5250 @ 80 -> 23 dBm
> Is it possible to add this rule without lowering the TX power for 80 MHz bandwidth?

I've tried to look at the documents, but much of the information appears
to be in images where machine translation doesn't work, and I haven't
been able to find English versions.

Taking the above at face value, I actually get slightly lower EIRP
values for a PSD of 2.5 mW/MHz (EIRP = PSD + 10 * log(bandwidth)): 16
dBm for 20 MHz and 19 dBm for 40 MHz. We don't currently have any way to
express PSD limits in the database nor a way to express different power
limits for different bandwidths, so it's not possible to comply with the
PSD limits for 20/40 MHz without also lowering the EIRP for 80 MHz.

> And do we need AUTO-BW for 6E channels? I thought it is for merging adjacent frequency ranges.

That is correct. Since there are no adjacent rules, AUTO-BW doesn't make
sense.

Thanks,
Seth
