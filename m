Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BBF149AFE
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 15:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAZOPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 09:15:36 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:34730 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgAZOPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 09:15:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580048135; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xwEt5erSYci6nGIda4Zmwtz4PlN0NRRG70zP8GV0Jr8=; b=r9D6j9Ky19fCR5CEM2GENdzeDAjQL9T+kRk6RuMnihm5Fvbjd65G4fNchtoUHeVHGmzl12Mc
 /eOLWlj7DO7iI9tA8Sh3ycXrayuWKBj9LhwUmdntHG7SpVyRlesBHjWoeXdjwvuN4rh2d8vX
 NltRP8QvPU+GxNFREegJlACfN/M=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d9f07.7f93e722b618-smtp-out-n03;
 Sun, 26 Jan 2020 14:15:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21F37C4479F; Sun, 26 Jan 2020 14:15:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED835C43383;
        Sun, 26 Jan 2020 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED835C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Antti Antinoja <antti@fennosys.fi>
Cc:     linux-wireless@vger.kernel.org, <amitkarwar@gmail.com>,
        <nishants@marvell.com>, <gbhat@marvell.com>,
        <huxinming820@gmail.com>
Subject: Re: mwifiex: exit on error - without calling rcu_read_unlock()
References: <20200126211844.0dd4a761@gail>
Date:   Sun, 26 Jan 2020 16:15:28 +0200
In-Reply-To: <20200126211844.0dd4a761@gail> (Antti Antinoja's message of "Sun,
        26 Jan 2020 21:18:44 +0800")
Message-ID: <87sgk2xq0v.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Antti Antinoja <antti@fennosys.fi> writes:

> Please refer to:
>
> * https://grsecurity.net/the_life_of_a_bad_security_fix
> *
> https://github.com/torvalds/linux/commit/3d94a4a8373bf5f45cf5f939e88b8354dbf2311b#diff-c5e2f17b92b8e8f30306c5dd148d874f
>
> At quick glance it looks to me like the issue really is there: Not
> calling rcu_read_unlock() before return on line 237.

Ganapahti, can you send a fix this for this?

Remember to add to the commit log:

Fixes: 3d94a4a8373b ("mwifiex: fix possible heap overflow in mwifiex_process_country_ie()")

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
