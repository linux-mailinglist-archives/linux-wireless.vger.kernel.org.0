Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB248D176A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJISPc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 14:15:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJISPb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 14:15:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0FEC60E42; Wed,  9 Oct 2019 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570644930;
        bh=kBzzBFlaC5Iw9oPCHzSNE/vmG/GQihsneBOC2YZKEHk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dUda6yspyv8oJqKKl1tMCl/qFA39faw/uUGzAKpgCVlx2RNfoSyHdvGzcv5E0jnnw
         Cjhp+3zotPDWx8EcqpQOg+Mzw+QNnCkqmoDfpe0nuZRjAvc9YEzTBMrr+9bYEbS/4S
         yOXgzgwTEgfUwpNB/YOyIF2UpuUA62R5oQCGZ12w=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1C6B60AFE;
        Wed,  9 Oct 2019 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570644930;
        bh=kBzzBFlaC5Iw9oPCHzSNE/vmG/GQihsneBOC2YZKEHk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dUda6yspyv8oJqKKl1tMCl/qFA39faw/uUGzAKpgCVlx2RNfoSyHdvGzcv5E0jnnw
         Cjhp+3zotPDWx8EcqpQOg+Mzw+QNnCkqmoDfpe0nuZRjAvc9YEzTBMrr+9bYEbS/4S
         yOXgzgwTEgfUwpNB/YOyIF2UpuUA62R5oQCGZ12w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1C6B60AFE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-fixes 2019-10-09
References: <c6f4459b0f0699aae9bd3166c74a538b20f62841.camel@coelho.fi>
Date:   Wed, 09 Oct 2019 21:15:26 +0300
In-Reply-To: <c6f4459b0f0699aae9bd3166c74a538b20f62841.camel@coelho.fi> (Luca
        Coelho's message of "Wed, 09 Oct 2019 13:09:50 +0300")
Message-ID: <87y2xt6b0h.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's a batch of fixes intended for v5.4.  This includes the last 2
> patchsets I sent.  More details about the contents in the tag
> description.
>
> I pushed this to my pending branch and I got results from kbuildbot for the first series, but not to
> the second one yet.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 98d22b01f9f6f85eb8870290006241b316829fd3:
>
>   rt2x00: remove input-polldev.h header (2019-10-08 18:49:22 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git tags/iwlwifi-for-kalle-2019-10-09
>
> for you to fetch changes up to aa0cc7dde17bb6b8cc533bbcfe3f53d70e0dd269:
>
>   iwlwifi: pcie: change qu with jf devices to use qu configuration (2019-10-09 13:01:06 +0300)
>
> ----------------------------------------------------------------
> First batch of fixes intended for v5.4
>
> * fix for an ACPI table parsing bug;
> * a fix for a NULL pointer dereference in the cfg with specific
>   devices;
> * fix the rb_allocator;
> * prevent multiple phy configuration with new devices;
> * fix a race-condition in the rx queue;
> * prevent a couple of memory leaks;
> * fix initialization of 3168 devices (the infamous BAD_COMMAND bug);
> * fix recognition of some newer systems with integrated MAC;
>
> ----------------------------------------------------------------

Pulled to wireless-drivers, thanks Luca.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
