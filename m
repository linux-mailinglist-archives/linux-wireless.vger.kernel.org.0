Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA491E44C1
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbfJYHo6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 03:44:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbfJYHo5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 03:44:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 310F060FB8; Fri, 25 Oct 2019 07:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571989497;
        bh=jk1eQ/A2AAKcr5SpqzxLaf8WJWf2/Wsnt5wueA9UJRI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZkKOXxLxAg71X/jahR1RKNtfdj+2lbBT+lz9QOnLen7RNw+Mi1YsVd9fFs7Td0lrW
         VBxoAKcXfugOMZijxydVfpagJMTZY9gSDGzlghlLp/Ee2516axXgTzyC/xZlWsdAYz
         q8TYy4QGHUrlA7OxDe2F603wiyC1LIQp8gHHDaK8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5026660FB8;
        Fri, 25 Oct 2019 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571989496;
        bh=jk1eQ/A2AAKcr5SpqzxLaf8WJWf2/Wsnt5wueA9UJRI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SgpYkJuYYpGU+L2qaYe02VlNkWR4gnWkdueZCRRBwTfYQrgiYUbWfEL3XrOFz6ycH
         6tND0D2L2Pe01kAjFnRduNxyWgLFLAImIgOHdYMFZa4RvlGZ4FBJbZUOLSGlU7EWez
         b/Vu1RQXHgeWyPSOvd/I9G9GLzsxRmC77Qv2unvU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5026660FB8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-10-18-2
References: <ab07c633cc356750c6d794ccefef3fb6221acf6b.camel@coelho.fi>
Date:   Fri, 25 Oct 2019 10:44:53 +0300
In-Reply-To: <ab07c633cc356750c6d794ccefef3fb6221acf6b.camel@coelho.fi> (Luca
        Coelho's message of "Fri, 25 Oct 2019 10:20:55 +0300")
Message-ID: <87zhhpp8ui.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the first batch of patches intended for v5.4.  This includes the
> last patchset 2 patchsets I sent.  Usual development work.  More
> details about the contents in the tag description.
>
> In this second version, I have removed all the Change-Id tags that
> accidentally got in, as you mentioned.  Sorry about that.
>
> I pushed this to my pending branch and got results from kbuildbot for a
> previous version but not for the last one yet.  Though there shouldn't
> be any issues, since the changes were trivial.  I'll let you know when
> I get the results.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 89dca86d29b46f2a5f38ea6476cfd441bd205d25:
>
>   rtw88: mark rtw_fw_hdr __packed (2019-10-16 10:35:25 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2019-10-18-2
>
> for you to fetch changes up to 65b9425ce9aa107f758ad0a491af5ef635567315:
>
>   iwlwifi: rx: use new api to get band from rx mpdu (2019-10-25 10:10:28 +0300)
>
> ----------------------------------------------------------------
> Patches intended for v5.5
>
> * Revamp the debugging infrastructure;
> * Some udpdates to FW API commands;
> * Fix max amsdu value calculation;
> * Small updates in the debugging infra;
> * Some new helper functions;
> * A few clean-ups;
> * Other small fixes and improvements;
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
