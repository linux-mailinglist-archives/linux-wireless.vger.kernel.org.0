Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BFC48644
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfFQO5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 10:57:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQO5j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 10:57:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 71B78619ED; Mon, 17 Jun 2019 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560783458;
        bh=4onSF4OQiL7OoUDuLJCDfUq7FXpM98SZ2CdgO0mJlSg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ic98rx1jipgFE6NQ8TLvYymmaOwX2dyL87jUUDwBO937OZVA5BcmT4aijaifVpyCf
         QscsWAptTZtHLnVn6tvn746NGUzaOetv3VVndoBGO/kc9V3srVKqKk95QkcjbuvY3+
         ZlwC0Bt7EOSrd/AMqvdnhrG4Nflo/O6DsguFjHLI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9FFF6118F;
        Mon, 17 Jun 2019 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560783457;
        bh=4onSF4OQiL7OoUDuLJCDfUq7FXpM98SZ2CdgO0mJlSg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GXTApqQxwbYx5kOJO617Mm2iEJwg+G6iLl63eS1Csb+ZenbqMSD6fD2jx/IqKIpbn
         /dRb374PdzkfqlXx7D159R4IVxFyxO/Ukh4r2hSBgu2f4llXPf421K57jsmtOQGLuX
         uSXigMsd5Jh1UzT6FjBwBqKwdWqR2vuj2vu5rvy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9FFF6118F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-wireless@vger.kernel.org
Subject: Re: [mac80211-next:master 17/20] drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3317:3: error: 'const struct rate_control_ops' has no member named 'remove_sta_debugfs'; did you mean 'add_sta_debugfs'?
References: <201906142122.HSTAYprn%lkp@intel.com>
        <20190614143359.GA11550@kroah.com>
        <330312ef061715d2beba89d0337bfe1a6698f36e.camel@sipsolutions.net>
Date:   Mon, 17 Jun 2019 17:57:33 +0300
In-Reply-To: <330312ef061715d2beba89d0337bfe1a6698f36e.camel@sipsolutions.net>
        (Johannes Berg's message of "Fri, 14 Jun 2019 16:58:39 +0200")
Message-ID: <87muigtg2q.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-06-14 at 16:33 +0200, Greg Kroah-Hartman wrote:
>
>> Did you apply my "[PATCH 3/5] iwlwifi: dvm: no need to check return
>> value of debugfs_create function" patch also to this tree?  The 5th
>> patch in the series depended on it :(
>
> Yeah, my bad, sorry about that. I was not paying attention to the "5/5"
> in patchwork, and the other patches got assigned to other maintainers so
> I didn't see them there.
>
> I've dropped the patch for now, until that's all sorted out. Or maybe
> Kalle will just take them all together.

Maybe it's easier that you just wait for other patches to trickle down
your tree?

-- 
Kalle Valo
