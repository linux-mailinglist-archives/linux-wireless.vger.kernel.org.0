Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611444C8A7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfFTHuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 03:50:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfFTHuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 03:50:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 748D76087F; Thu, 20 Jun 2019 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561017023;
        bh=IEVhErU8ZXfs+BmJmEQeSmps4wX2Kyp3PRoRO86Lc8o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Vr10K66ZwRd2HqAZ/a6cYur3TZH0DvdIDYBwrXZTrdctjfJmnS1dsC/lZDtWF9Usc
         P2ZjOinA3hoFAE0DMEbluaYaJQYgpWH/xVMNVnocwzsIWz//0gMiBX9leQLPUOXuD2
         nEJV0H38PvTrnaexBWT8j8agV2eg3mRPhyMQvwxg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7905E602A9;
        Thu, 20 Jun 2019 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561017023;
        bh=IEVhErU8ZXfs+BmJmEQeSmps4wX2Kyp3PRoRO86Lc8o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Vr10K66ZwRd2HqAZ/a6cYur3TZH0DvdIDYBwrXZTrdctjfJmnS1dsC/lZDtWF9Usc
         P2ZjOinA3hoFAE0DMEbluaYaJQYgpWH/xVMNVnocwzsIWz//0gMiBX9leQLPUOXuD2
         nEJV0H38PvTrnaexBWT8j8agV2eg3mRPhyMQvwxg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7905E602A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] nl80211: Update uapi for CMD_FRAME_WAIT_CANCEL
References: <20190619223606.4575-1-denkenz@gmail.com>
Date:   Thu, 20 Jun 2019 10:50:20 +0300
In-Reply-To: <20190619223606.4575-1-denkenz@gmail.com> (Denis Kenzior's
        message of "Wed, 19 Jun 2019 17:36:04 -0500")
Message-ID: <87a7ecu24j.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> writes:

> 1c38c7f2 added the possibility of NL80211_CMD_FRAME_WAIT_CANCEL
> being sent whenever the off-channel wait time associated with a
> CMD_FRAME completes.  Document this in the uapi/linux/nl80211.h file.

The preferred format for referencing commits is:

Commit 1c38c7f22068 ("nl80211: send event when CMD_FRAME duration
expires") added...

-- 
Kalle Valo
