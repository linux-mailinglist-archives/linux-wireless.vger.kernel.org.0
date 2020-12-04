Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965E92CF344
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 18:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgLDRmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 12:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgLDRmG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 12:42:06 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7399C0613D1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 09:41:25 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id k26so7058305oiw.0
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgO+S9e5Bnsz1sxnIpjL+6jprmVcbPbUp42LasvErio=;
        b=a6bakiRdnwAiaFO36Bn3bRv5hhfxCDcga/QLEeuI0lHq45darLQ94yvaH1jc2FmWJb
         +D+TbbBesFUd18/Wfwsobb/Ner3YN8ZH1YQUQ94OfwoNNHqfJDiUDRQ8hT3CoZCmJee1
         1r7AccrRREIRqME1InS2if0eKm2koUpk7SqWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgO+S9e5Bnsz1sxnIpjL+6jprmVcbPbUp42LasvErio=;
        b=SWH4tkZnKQ63Sjpc+Cyj33Sykij13/Rvc9T17AoZxtFmprSRLd4pARdKnFjHtaOFhb
         GJYBgNq1fROcZAYal5fs4IFDpVGrggjb8W/yNBnHh3bgg1wYB+NX2jyzJZZ0v0RnIX6K
         KB3g/bAN0piQRcqZUuC+KkZC/je521Zhf8cOplUTdcS9MgIRs30RhddfrIBraZMZw34n
         23ZZwi4BuyT8poFNy4GE90sI71xZ+cTsJE8OI8HmFYVec49R1KDZm9boHE8tDRk6C0al
         LXIXeeAXLQu8Q/Qt1xQw1F9zLwn5ksIvgp0NfEEsqCshcjgbAAFF+gG2zsBc98u3PI3Q
         YD5A==
X-Gm-Message-State: AOAM531HqYOunXixByDaxGn2ehBGC9fQ3WFsZ94RrW5C4j3XOfkL/moJ
        csptD4gJbLNvgrwaZdax3zKoaRHxH7WZgQ==
X-Google-Smtp-Source: ABdhPJxFETf3knOloBTpjdl+zRDp++NaRfQxKCt9O3FCWU2C6S0zh5QOlSPLMJdRZlJLQmlvDz6vQA==
X-Received: by 2002:aca:3305:: with SMTP id z5mr3929512oiz.34.1607103685004;
        Fri, 04 Dec 2020 09:41:25 -0800 (PST)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id u63sm769823oia.50.2020.12.04.09.41.23
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:41:24 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id w9so1556844ooh.13
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 09:41:23 -0800 (PST)
X-Received: by 2002:a4a:7055:: with SMTP id b21mr4405853oof.66.1607103683340;
 Fri, 04 Dec 2020 09:41:23 -0800 (PST)
MIME-Version: 1.0
References: <X8pSc4CnDcskUVvE@mwanda>
In-Reply-To: <X8pSc4CnDcskUVvE@mwanda>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 4 Dec 2020 09:41:10 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOed0i-cT5es4tNTtRAuyWRz1+93p83tDdt4WLndwcr3A@mail.gmail.com>
Message-ID: <CA+ASDXOed0i-cT5es4tNTtRAuyWRz1+93p83tDdt4WLndwcr3A@mail.gmail.com>
Subject: Re: [bug report] rtw88: coex: add feature to enhance HID coexistence performance
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ku920601@realtek.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 4, 2020 at 7:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The patch 5b2e9a35e456: "rtw88: coex: add feature to enhance HID
> coexistence performance" from Nov 26, 2020, leads to the following
> static checker warning:
>
>         drivers/net/wireless/realtek/rtw88/coex.c:2099 rtw_coex_action_bt_a2dp_hid()
>         error: uninitialized symbol 'interval'.

Patch is already proposed:
https://lore.kernel.org/linux-wireless/20201203175142.1071738-1-colin.king@canonical.com/
[PATCH][next] rtw88: coex: fix missing unitialization of variable 'interval'

Brian
