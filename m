Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6944C900
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfFTIIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 04:08:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfFTIIT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 04:08:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF37B606FC; Thu, 20 Jun 2019 08:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561018098;
        bh=oK9uzS161Q+xdz/bUXINrcc5NtRcnMlSQ9QCjf2wfSA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HR3B+qZg3rg0NGKfZiFb2aHKVV3VYfb8rE7taL2IpW/2+J62/tOF84CEhwxMQnDGu
         Nkq2oflJo+vynNAavHeLpJLOsObNTFjJdqRIUhl1KGix+Moi6KKRCQIe1g6Y8qLZzD
         E+i13giRNjobrPxmdqgQtfs34UkoEGFmawkvHM+k=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 731DD606FC;
        Thu, 20 Jun 2019 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561018098;
        bh=oK9uzS161Q+xdz/bUXINrcc5NtRcnMlSQ9QCjf2wfSA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HR3B+qZg3rg0NGKfZiFb2aHKVV3VYfb8rE7taL2IpW/2+J62/tOF84CEhwxMQnDGu
         Nkq2oflJo+vynNAavHeLpJLOsObNTFjJdqRIUhl1KGix+Moi6KKRCQIe1g6Y8qLZzD
         E+i13giRNjobrPxmdqgQtfs34UkoEGFmawkvHM+k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 731DD606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>
Subject: Re: [PATCH 09/11] mwifiex: update set_mac_address logic
References: <1560352331-16898-1-git-send-email-gbhat@marvell.com>
        <MN2PR18MB2637F76B11A51E34A8586208A0EC0@MN2PR18MB2637.namprd18.prod.outlook.com>
Date:   Thu, 20 Jun 2019 11:08:15 +0300
In-Reply-To: <MN2PR18MB2637F76B11A51E34A8586208A0EC0@MN2PR18MB2637.namprd18.prod.outlook.com>
        (Ganapathi Bhat's message of "Wed, 12 Jun 2019 15:18:04 +0000")
Message-ID: <875zp0u1ao.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <gbhat@marvell.com> writes:

> This change is correct one, but I missed changing the .patch file name before sending. Let me know if this needs to be resend.

I don't understand your comment. Are you saying that even if this is
marked as "9/11" this was supposed to submitted as a single patch? If
that's the case, no need to resend.

-- 
Kalle Valo
