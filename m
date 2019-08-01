Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0437DC5E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfHANPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 09:15:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52920 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfHANPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 09:15:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35BA8609F3; Thu,  1 Aug 2019 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564665336;
        bh=hDR6+ij39p/VmWQYFzPGuYR1eh98EZGRedpmv94ji+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MJyqRcw86SEQtHNWkaITBNwO+j3qzqvzUdxVAeknava5yNTrP87t2ggGdFLmrUA45
         FHUZeVSKXRvJu8jjYNhXjzth87IQkvB1TPmvc/a01ikvNQWIyoxSoeFyylkvyC39Le
         vlLh90sCsgsDGbo3nqvYl3YrXkpFDTsJ9JgH47+E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D5947608A5;
        Thu,  1 Aug 2019 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564665335;
        bh=hDR6+ij39p/VmWQYFzPGuYR1eh98EZGRedpmv94ji+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QiCHBWBLfVJ/EaEkQOhhxvwP3p279ORSFdvjUXo2YY8dVteugdyLHE3xbp0uKDHVU
         fy4IJtUTHWSFpy9G/CAqeqnHqLXl5PwmHus32heQeCIeNJVzE0h5ZPA0qIantr51g0
         3rG1sn4HYfEU4J900KjqnNbNvTSJomSLbH89CvSQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Aug 2019 16:15:35 +0300
From:   Alexei Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH v5 1/2] nl80211: Add support for EDMG channels
In-Reply-To: <4deeee0289e706d5e594d00d987c233fb8fb25b5.camel@sipsolutions.net>
References: <1563194767-4817-1-git-send-email-ailizaro@codeaurora.org>
 <1563194767-4817-2-git-send-email-ailizaro@codeaurora.org>
 <4deeee0289e706d5e594d00d987c233fb8fb25b5.camel@sipsolutions.net>
Message-ID: <8a445e39175f1aaf7cc3eaa6c4474619@codeaurora.org>
X-Sender: ailizaro@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-26 16:29, Johannes Berg wrote:
> Hi Alexei,
> 
> I'm not exactly sure why, but this breaks practically all connectivity
> on 2.4 and 5 GHz channels (at least in hwsim tests).
> 
> Please check and resubmit.

Sorry for this issue, we have run hwsim test through wpa_supplicant and
catch small issue that caused the tests to fail - fix raised.
Can you please share with us how you run the hwsim, you also used the
wpa_supplicant unit tests or some other tool?

> 
> It'd also be good to reformat the commit log a bit, maybe adding
> paragraphs, it's a bit of a "wall of text".

Done.

> 
> Thanks,
> johannes

-- 
Alexei Lazar
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum a
Linux Foundation Collaborative Project
