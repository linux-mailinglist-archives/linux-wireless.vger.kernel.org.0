Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA51CFC27
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfJHOQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 10:16:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHOQo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 10:16:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A4B86083C; Tue,  8 Oct 2019 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570544203;
        bh=wY3uCbfExhWdGiVOJc3VQuqFQOcWO/pO4PVULMO2ohg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mv/Nv4IVfHfZVaFafMIrG4CNXkmdLtzOA/Vo4b4Movky/ts0gWf+B1sipqjclbDeN
         7O9C8+swXKACEYHY7140IKK2M6UfRDLmWa+/N2rs2m0beTuqNFK1WPK6cuaipgTYID
         Yun9uDnzsrQ0kxO9/6sHk0tGXhiRwDczc3szDXww=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 793A1602DC;
        Tue,  8 Oct 2019 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570544201;
        bh=wY3uCbfExhWdGiVOJc3VQuqFQOcWO/pO4PVULMO2ohg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NfWuXIldId6otIBDDg+L28kATfCurGBJ062Ui4NCDFSMLPsg266qU8T8ktUNvr3A1
         yUvZGsOZ0wuOL0h8XIbGLKLIosTYJ74mC70MU0xUM+dnIHrSkS1uRCP5LHxM9GjDRg
         jRnODVKWtpXH1KkrMtvIlH2eYsW2hEg015tHaglo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 793A1602DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Guy Mishol <guym@ti.com>, linux-wireless@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv2] wlcore: fix race for WL1271_FLAG_IRQ_RUNNING
References: <20191007172800.64249-1-tony@atomide.com>
        <20191008140556.GZ5610@atomide.com>
Date:   Tue, 08 Oct 2019 17:16:36 +0300
In-Reply-To: <20191008140556.GZ5610@atomide.com> (Tony Lindgren's message of
        "Tue, 8 Oct 2019 07:05:56 -0700")
Message-ID: <87h84j7263.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [191007 17:29]:
>> We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), and test
>> for it in wlcore_runtime_resume(). But WL1271_FLAG_IRQ_RUNNING currently
>> gets cleared too early by wlcore_irq_locked() before wlcore_irq() is done
>> calling it. And this will race against wlcore_runtime_resume() testing it.
>> 
>> Let's set and clear IRQ_RUNNING in wlcore_irq() so wlcore_runtime_resume()
>> can rely on it. And let's remove old comments about hardirq, that's no
>> longer the case as we're using request_threaded_irq().
>> 
>> This fixes occasional annoying wlcore firmware reboots stat start with
>> "wlcore: WARNING ELP wakeup timeout!" followed by a multisecond latency
>> when the wlcore firmware gets wrongly rebooted waiting for an ELP wake
>> interrupt that won't be coming.
>> 
>> Note that I also suspect some form of this issue was the root cause why
>> the wlcore GPIO interrupt has been often configured as a level interrupt
>> instead of edge as an attempt to work around the ELP wake timeout errors.
>
> So this fixed a reproducable test case where loading some webpages
> often produced ELP timeout errors. But looks like I'm still seeing ELP
> timeouts elsewhere. So best to wait on this one. Something is still
> wrong with the ELP timeout handling.

Ok, I'll drop this then. Please send v3 once you think the patch is
ready to be applied.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
