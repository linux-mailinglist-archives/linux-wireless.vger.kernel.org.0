Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F68E9DC0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 15:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfJ3OlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 10:41:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3OlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 10:41:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F22460F7A; Wed, 30 Oct 2019 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572446476;
        bh=P8MYYQytn2vSJ2+zEKhFEfL52NqDsCg8n9kpdRcrf10=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=O8mbkVODr+gJi/YRxx/yahzmr6QM5SDSd/YQSDGfGeaYr7Rs0O3NJ5J0RccZaAIzU
         isLGORQATpz3hnF+02h4axMNbng2uQ2WmZYfo4gmCF2UWNuSLt6sDMP3uY2ONY8HF/
         ddV689rwSBvcZoj3kUBnDJdVJ8jNJWwX6xy+xd9I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACCE860B7F;
        Wed, 30 Oct 2019 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572446476;
        bh=P8MYYQytn2vSJ2+zEKhFEfL52NqDsCg8n9kpdRcrf10=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=O8mbkVODr+gJi/YRxx/yahzmr6QM5SDSd/YQSDGfGeaYr7Rs0O3NJ5J0RccZaAIzU
         isLGORQATpz3hnF+02h4axMNbng2uQ2WmZYfo4gmCF2UWNuSLt6sDMP3uY2ONY8HF/
         ddV689rwSBvcZoj3kUBnDJdVJ8jNJWwX6xy+xd9I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACCE860B7F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bassem Fahmy <bassem@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Chip debug tool
References: <CAEirPfz4FEtuRH8VST0ehtQtttPpFJFrZLDb9v7heUAb8EA2tw@mail.gmail.com>
Date:   Wed, 30 Oct 2019 16:41:13 +0200
In-Reply-To: <CAEirPfz4FEtuRH8VST0ehtQtttPpFJFrZLDb9v7heUAb8EA2tw@mail.gmail.com>
        (Bassem Fahmy's message of "Wed, 30 Oct 2019 06:48:39 +1100")
Message-ID: <8736fae1o6.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bassem Fahmy <bassem@morsemicro.com> writes:

> Hi
> Our systems team is asking to develop a chip debug tool to be able to
> test, calibrate and tweak every bit of the chip from user space
> (something similar to Broadcom's WL tool). The tool would later be
> stripped out and passed to customers to help them tweak specific
> features.
>
> The tool needs to be easy for the firmware and RF team to add extra
> command, by adding some definitions in the user space tool and a
> matching response in the firmware (no driver recompilation).
>
> Based on this, I can think of few of options
> - nl80211: to overload NL80211_CMD_TESTMODE or NL80211_CMD_VENDOR or
> - nl80211: to create a new set of commands. These options don't seem
> to have a chance to go back upstream though.
>
> Another option is to use debugfs. In this case however, all the
> commands would go to a single node, and the driver which would blindly
> pass data to/from the chip. This is to avoid recompiling the driver
> every time a new command is added.
>
> Just wondering what is the proper (recommended way) for this. Any
> ideas, directions?

NL80211_CMD_TESTMODE was added exactly for this kind of use in mind
(used by RF/HW engineers and not by regular users), I recommend using
it.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
