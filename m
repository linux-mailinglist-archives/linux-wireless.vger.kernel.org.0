Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BBB916FF
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfHROBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 10:01:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHROBe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 10:01:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F500623CE; Sun, 18 Aug 2019 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566136893;
        bh=7CWn53UGAWZvFjAmJIeL2A5YORTZGR6YykH+3wpX5AI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Kj6OqWPvebTv2BSBa20RCmpWn6VlB63cEzluu78W2OWmn88rsKsevyUDfHA5WVubv
         1XbbfWZTJ+JX70JbHypG3H1wf942+khX1S3S/53NX5L1PXedo56qU06LeZKeZfFPOS
         EMD2M5GVC0z/5+Y7et9O5KfvRhwUNl4UCYKPdVnM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76A7F6231A;
        Sun, 18 Aug 2019 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566136892;
        bh=7CWn53UGAWZvFjAmJIeL2A5YORTZGR6YykH+3wpX5AI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LwgXtwGb+yBFjN4Bsn1tsdi1uRQoDS+iipXa3I7bHiie3x3x4HxxEhN9C6gFNkdE1
         npinODXTRrmmZniMkv6CTV2cJcMGePbMZmvVYxQ12sUeN5D5+31Ol11QJP/RZDzFEp
         YMd3u9Qddax9nzvomiY9AnjtHOcpjzxY91qJoG/8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76A7F6231A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 12/22] iwlwifi: mvm: start to remove the code for d0i3
References: <20190817065200.9701-1-luca@coelho.fi>
        <20190817065200.9701-13-luca@coelho.fi>
Date:   Sun, 18 Aug 2019 17:01:29 +0300
In-Reply-To: <20190817065200.9701-13-luca@coelho.fi> (Luca Coelho's message of
        "Sat, 17 Aug 2019 09:51:50 +0300")
Message-ID: <87y2zqa7ye.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> This is only the very start, much more work is needed.
> Remove the places where we check iwl_mvm_is_d0i3_supported
> but leave all the refs, those will be removed in a different
> patch.
>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

It would be good to explain _why_ you are removing d0i3 support. Basend
on the cover letter apparently it's broken but there's no detailed
information.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
