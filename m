Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD4AA39E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbfIEM6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 08:58:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57220 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfIEM6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 08:58:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40F066085C; Thu,  5 Sep 2019 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567688328;
        bh=SVm1xOC+6yoRDmuNHC0o7z9gkaB5p3fWnHJ6QbO85UU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JtvXigEw1r+Dueatd3lGzlpTIfodkLhohP3p4N9t9PV78bfCcA39dgGyNGxBnKq2u
         VsdKXS71dMkfUbz50t7DQOYbrObq0ftqiCB6URwWdHeaWFXeLr4T+9Qj5jMxUaXGx6
         qjudbA9ZuXYbiLrNhkcKwg1WJSJQBjBtSEuChpxU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BA546013C;
        Thu,  5 Sep 2019 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567688327;
        bh=SVm1xOC+6yoRDmuNHC0o7z9gkaB5p3fWnHJ6QbO85UU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VEaFOVjZzKJ4RZH68izomToIgoCKvK0BfhNO1nMo6C3/HSkd9qOWVwjRcEnWBkZ5k
         jpMWoD/cU589U2JN1Oz8+ZVpNJVsZYPKRI/I6xQuhkbQHuGVYPxqqlraH1Q/YaK85k
         C1EQA8s7UmvYE9Wk73TSx5RsftIZEWgSdOmhpXOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BA546013C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/18] iwlwifi: Set w-pointer upon resume according to SN
References: <20190821133800.23636-1-luca@coelho.fi>
        <20190821133800.23636-6-luca@coelho.fi>
        <87sgpdpqni.fsf@kamboji.qca.qualcomm.com>
        <183bb8fceadadebc688bf3419321b5700df001fd.camel@coelho.fi>
Date:   Thu, 05 Sep 2019 15:58:44 +0300
In-Reply-To: <183bb8fceadadebc688bf3419321b5700df001fd.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 05 Sep 2019 15:56:01 +0300")
Message-ID: <87sgpalx17.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Tue, 2019-09-03 at 14:26 +0300, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>> 
>> > From: Alex Malamud <alex.malamud@intel.com>
>> > 
>> > During D3 state, FW may send packets.
>> > As a result, "write" queue pointer will be incremented by FW.
>> > Upon resume from D3, driver should adjust its shadows of "write" and "read"
>> > pointers to the value reported by FW.
>> > 
>> > 1. Keep TID used during wowlan configuration.
>> > 2. Upon resume, set driver's "write" and "read" queue pointers
>> > 	to the value reported by FW.
>> > 
>> > Signed-off-by: Alex Malamud <alex.malamud@intel.com>
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> 
>> A typo in the title, s/w-pointer/q-pointer/ maybe?
>
> This means "write pointer" because that's the one that is incremented
> during WoWLAN.  The feature was called update write pointer or
> something, that's where it comes from.

Ok.

> Do you want me to reword the subject?

Nah, I was just curious because I couldn't figure out what that
"w-pointer" means and saw q-ptr (something like that) in the code.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
