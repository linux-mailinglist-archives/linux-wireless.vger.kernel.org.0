Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E004115AB34
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 15:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBLOqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 09:46:33 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43521 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727372AbgBLOqc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 09:46:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581518792; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=E4P4YEdJ/H29ioyeU44Ia7kadIdJKni69TB9XUER2+M=; b=cCY6Go5XjvvMRIH4oqJJvl6bMoh/DZpp4WARWpYSb3mRgy8A9aIEWzQj4Um9ZiQShBzCUwsm
 sh0iSBvaO42FkKbezzZrEZSfqao6B4EgKMaRnJmU272XLBwqGwiresjWf4JBfJq5yS8qFjse
 d0QWLtu4/Cn4MNOV5V8b4CnJMCc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e440fc7.7fc8f167d490-smtp-out-n03;
 Wed, 12 Feb 2020 14:46:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D774C4479F; Wed, 12 Feb 2020 14:46:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68C23C43383;
        Wed, 12 Feb 2020 14:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68C23C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Moulding <dmoulding@me.com>
Cc:     emmanuel.grumbach@intel.com, johannes.berg@intel.com,
        linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        luciano.coelho@intel.com
Subject: Re: [PATCH v2 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices
References: <20200128093107.9740-1-dmoulding@me.com>
        <20200211162450.2493-1-dmoulding@me.com>
Date:   Wed, 12 Feb 2020 16:46:25 +0200
In-Reply-To: <20200211162450.2493-1-dmoulding@me.com> (Dan Moulding's message
        of "Tue, 11 Feb 2020 09:24:50 -0700")
Message-ID: <87d0ajx3r2.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Moulding <dmoulding@me.com> writes:

> This is just a friendly reminder that this patch has been submitted,
> for what looks like a fairly major regression in iwlwifi that impacts
> (as far as I can tell) *all* 3168 devices. The regression is in the
> v5.5.x series and was for a while back-ported to the stable trees, but
> luckily was noticed before the releases were made.
>
> There are at least a few bug reports for this regression:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=206329
> https://bugs.gentoo.org/706810
> https://lkml.org/lkml/2020/2/7/811
> https://bbs.archlinux.org/viewtopic.php?id=252603
>
> The Gentoo maintainers have already applied this patch to their Linux
> sources and marked their bug report "fixed". But it would be really
> nice if we could get this regression fixed in the next stable v5.5.x
> release.

I'll queue this directly to wireless-drivers. Intel folks, are you ok
with this?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
