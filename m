Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C981B6D06
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 07:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgDXFJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 01:09:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18717 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgDXFI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 01:08:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587704939; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0nI7OysQJvgHWmiwkHjh4EDeXgMIoYnVdqFHq2xSfew=; b=B9gkSgUJDyvXcwl075tKGBmcZoIiJKidgJe5pZFdtCJcAKem0mxzVwZcdV0h0AvYfPtRtRng
 QnjtI1wYfk5I3Gt1QpGyWCnHNl5BPV4PuBSCPe6WVfzOS3Q5RCofBfIG68nVi/dHPmbVbMWB
 FKHfJzSAI/EuCB1Vl0L7Fl2xU0A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea27455.7f54fa20f110-smtp-out-n02;
 Fri, 24 Apr 2020 05:08:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B1AAC433D2; Fri, 24 Apr 2020 05:08:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12A95C433CB;
        Fri, 24 Apr 2020 05:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12A95C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: bugzilla.kernel.org / networking_wireless@kernel-bugs.osdl.org
References: <CA+ASDXMghcm-g8uWr2rJOmAOkYocWGCvXKtqs171TQ52DZXmPw@mail.gmail.com>
Date:   Fri, 24 Apr 2020 08:08:33 +0300
In-Reply-To: <CA+ASDXMghcm-g8uWr2rJOmAOkYocWGCvXKtqs171TQ52DZXmPw@mail.gmail.com>
        (Brian Norris's message of "Thu, 23 Apr 2020 15:42:34 -0700")
Message-ID: <875zdpjwry.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> Does anybody actually triage/manage the Wireless component on
> bugzilla.kernel.org?
> https://bugzilla.kernel.org/describecomponents.cgi?product=Networking

To my knowledge only iwlwifi folks follow bugzilla, not much else. I
certainly don't have time for it. I think there should be a big fat
warning that it's not the recommended way to report bugs, just so that
people don't have false expectations.

> It's ostensibly managed by networking_wireless@kernel-bugs.osdl.org,
> but I get the impression that list (and really, the entire domain...)
> has been dead for a long time.
>
> Related: does anybody care to fix that up? I've found a few useful bug
> reports there recently, and it would be nice if the community could
> proactively handle those, instead of leaving it there as the
> equivalent of /dev/null.
>
> If no one else volunteers, I'd probably at least try to stick my email
> in there somewhere [1], so I can manage state (e.g., close issues that
> are already fixed).

If you have the time go for it :)

> [1] I guess I'd have to ask kernel.org admins?

Yeah, I suppose helpdesk@kernel.org can help with that.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
