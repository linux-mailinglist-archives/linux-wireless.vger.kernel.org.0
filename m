Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB9527C6
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfFYJSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:18:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfFYJSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:18:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30480607C3; Tue, 25 Jun 2019 09:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561454325;
        bh=9Cu5njhTWQcfC2xj4e96SAFWy71IiLVi8xtT+Ik1mso=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RF1UQT7nAIn0Tf1vxjZSd6C1WcSrX1RZBujZEHmbWe7JBqz9v0va6IGVZd+vqGKL0
         7uYB1utlonbKT39WtVjSdMkUNqdP3KimmtN1qvB4RzrnKLoekGUxdLH3MuAJpQQi53
         T3eBEQbCJAV4Ox+Or7Jhf103+yuDHbZt6ZOPAhxM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 538DE60300;
        Tue, 25 Jun 2019 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561454323;
        bh=9Cu5njhTWQcfC2xj4e96SAFWy71IiLVi8xtT+Ik1mso=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fo/J6mjLm5+A3UamKgxCWb1MWKv97ZpL3lngoVW+zLLMQfCH4HdD4ommC48fCca3D
         Wkm7UJQYaR9TQ5dnuKxpD/oB3GSQ3JNxYJ9g6V2c7GRF2x3OQhkZsfxrnuVk/iWKnr
         JhEqoB9uFQ6Oo8Vpv8/PNhMm2vJimL/fOH6mdA4Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 538DE60300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: nl80211 wlcore regression in next
References: <20190625073837.GG5447@atomide.com>
        <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
        <20190625080019.GH5447@atomide.com>
Date:   Tue, 25 Jun 2019 12:18:39 +0300
In-Reply-To: <20190625080019.GH5447@atomide.com> (Tony Lindgren's message of
        "Tue, 25 Jun 2019 01:00:19 -0700")
Message-ID: <87r27irpjk.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Hi,
>
> * Johannes Berg <johannes@sipsolutions.net> [190625 07:47]:
>> On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
>> > Hi,
>> > 
>> > Looks like at least drivers/net/wireless/ti wlcore driver has stopped
>> > working in Linux next with commit 901bb9891855 ("nl80211: require and
>> > validate vendor command policy"). Reverting the commit above makes it
>> > work again.
>> > 
>> > It fails with the warning below, any ideas what goes wrong?
>> 
>> Oops. For some reason, I neglected to check the vendor command usage
>> beyond hwsim.
>> 
>> The patch below should work?
>
> Yeah thanks that fixes the issue for me:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
