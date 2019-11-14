Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2858FC386
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 11:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfKNKDV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 05:03:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKNKDV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 05:03:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2390860D95; Thu, 14 Nov 2019 10:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573725800;
        bh=xERxXGD/z5LwRZl7JWScEXmWLYGLz6DMaOBdKFeqAhg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aVTLzoUeDQo4IKhbFPmdYJA7//FJT8w4GLSEjoC3aA77idAKWP1M/Lwa227wlBmaw
         dV5EqqMyotA3GM0E/TClQQDFA4y5lAjVLsas1pZ4YiXf8UtJgUB7pG6PhKn4IbvV9P
         OLN4vRTVfGJFicxzDsq3hCAkweC7W0OKTD+l0plg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E32960B10;
        Thu, 14 Nov 2019 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573725798;
        bh=xERxXGD/z5LwRZl7JWScEXmWLYGLz6DMaOBdKFeqAhg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=n/q11UGQNr5Tnk8J2Rpit1XgsOofaF4Q4lNzYLXtCA+pVK52QYK14vBTKxES+A0cJ
         fB0hG7nGUUiuRH1eIsV79EyzI2FU8DcxBo5DcOo917dWm89XOxsbgrxyPKIPPo1KiI
         43lxNW1T4DoNKgh87N6Yso8WgrqX1n43ybwM3kCQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E32960B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-11-13-2
References: <f2bc269efbb712d36adf8feff274102d12b1629e.camel@coelho.fi>
Date:   Thu, 14 Nov 2019 12:03:14 +0200
In-Reply-To: <f2bc269efbb712d36adf8feff274102d12b1629e.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 14 Nov 2019 11:03:21 +0200")
Message-ID: <87tv76ojvh.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Hi Kalle,
>
> Here's the updated pull request with the second batch of patches
> intended for v5.4.  This includes the last patchset 2 patchsets I sent. 
> Usual development work.  More details about the contents in the tag
> description.
>
> In this update I have fixed a merge damage in one of the patches.  Since
> I'm using a different machine at the moment, I had the wrong config when
> I tested this tag.  Sorry about that.
>
> I pushed these patches to my pending branch when I sent them out and
> kbuildbot reported success.
>
> Please let me know if there are any issues.

Really sorry but I didn't have time yesterday to do detailed review and
I just noticed that the commit below have Change-Id tags. Can you remove
those and respin, please?

commit 29157a88d13ff980df5d5c68bc619ed22f2f9ba7
Author:     Shahar S Matityahu <shahar.s.matityahu@intel.com>
AuthorDate: Mon Aug 19 16:19:14 2019 +0300
Commit:     Luca Coelho <luciano.coelho@intel.com>
CommitDate: Wed Nov 13 11:12:12 2019 +0200

    iwlwifi: scan: support scan req cmd ver 12
    
    Implement scan request command version 12.
    
    Change-Id: Idc3c9d5d9b4bd2d1738bf8836c27f569b4649a05
    Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

commit cc5e99f8063fd120564d4a27a9e0058bdc910d0e
Author:     Shahar S Matityahu <shahar.s.matityahu@intel.com>
AuthorDate: Mon Aug 19 15:35:10 2019 +0300
Commit:     Luca Coelho <luciano.coelho@intel.com>
CommitDate: Wed Nov 13 11:12:12 2019 +0200

    iwlwifi: scan: make new scan req versioning flow
    
    Implement a new versioning handling flow supported from version 11
    onwards.
    
    Change-Id: Ie10a661317ca2a150122e2ad2a8d4f062a41754e
    Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>


-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
