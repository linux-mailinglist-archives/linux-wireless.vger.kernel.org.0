Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2362910672A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 08:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfKVHmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 02:42:18 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:40826
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbfKVHmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 02:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574408537;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=0d4j+4i8t4Q6KnCLblEs0oK3DYXfbyzu6pQ6mAlrbcs=;
        b=cJv7QX0ZcZLvzTT79wK1uk2+pPqjGube6NoPxESFO0ZdymB8gepkbrolgJUWzwM+
        2+EW/+W5BQJ9PSpi7N+LD4HzLDFyoCmOJT5UBNeqsAgxwQY0XtyKcGNnlMnB+p80aAh
        WM2sfBEZMMl1YbE//CeFqlGomq5UCSwALd6a8lr8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574408537;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=0d4j+4i8t4Q6KnCLblEs0oK3DYXfbyzu6pQ6mAlrbcs=;
        b=UKObiu/XfOYlgosIIp8G8y8IltZ6ZpD0kwhqAofmnPdPIPnHry6qx53N+J8j+GUP
        MiDP5Q6Pl/cszpJhVp2Xy34IAryz2dBQkDrJ8EiPi/v8Fj8dXSoor/TDugBTAnhu2ct
        NWWHRylyT43Lw5XqkM2GAlEgaokA1eZCO9c563gY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE45AC367A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com
Subject: Re: [PATCH 0/4] rtlwifi: rtl8192de:  Replace local TX and RX bit manipulation macro
References: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
Date:   Fri, 22 Nov 2019 07:42:17 +0000
In-Reply-To: <20191121214417.29676-1-Larry.Finger@lwfinger.net> (Larry
        Finger's message of "Thu, 21 Nov 2019 15:44:13 -0600")
Message-ID: <0101016e920fc4c8-bafb95c4-05d9-4756-9f8d-0015742e3830-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.22-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> These patches are part of a series intended to replace the bit-manipulation
> macros used to set and read the various descriptors with a set of inline
> routines.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> Kalle,
>
> There is no particular urgency for these patches as they are part of
> a general cleanup.

Good to know, thanks. And these actually just missed v5.5, the merge
window opens on Sunday so I can't take new stuff anymore (fixes are ok,
of course).

-- 
Kalle Valo
