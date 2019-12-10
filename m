Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B715A117C90
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 01:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLJAmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 19:42:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34783 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfLJAmI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 19:42:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so1159768qtz.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZSjeR0TOWiNnS13x7P+J574D6JiqVJY1zgnBAULjNw=;
        b=PJ8kvIHhxdpilR3u6wl/8IY1EtKCrX7nvnNxzG93F4VYb0DdI9zX7k/tKrsEYNFAWx
         ZHCkU4ic/S8o+5V0b2KSykdZH41eFLahQ03LIIF+oO99z9NTgtY29VqCW1yyHcn1HMwi
         qHLDkKJTF7fFOVSWXKDSvZC3PMFh2Q125FNLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZSjeR0TOWiNnS13x7P+J574D6JiqVJY1zgnBAULjNw=;
        b=Enb2yPJHG6yUWJOTgY/+AiYexiUrOCpXw7LzwdyYVW6qCgx3crtu3f1GxzaYWEa9Cx
         QLNOPQYk8EqQpoA6iQj2bbASXPAY5SlWY1GQrh50aDICgLTP1AsP5Z1c1s5TdAvabj3x
         g1ANOTlN4twv2z2tw2ntMgyUSTMa2rru/kKpda+uEaZPKuR6SryW3aVZM6AwNE6bn4NZ
         Q8LkROiQWpw0MGIZxpDQUOHlKqOe7565GfkLd/wHEbDN6mKoi0NstAZY8OVERtoH0cYn
         W8FGgVDiElY18x2iB3l7TVD8HSP7Lyo8ui2Yvpp/N+Ph//863kbvumiOSAq/oh7WXwOI
         T3mA==
X-Gm-Message-State: APjAAAV6TJck8MQZWJDdQGojF1tA1o/Fzdli0Kanh+ffcascQcU4N7PH
        wjXNHggOoPqB5gOBbvoIcAqDwLElfYQ=
X-Google-Smtp-Source: APXvYqzYYPSrKHy25bQCpQ5rRXxhANU5uhfQu91OTGDWb04MWFZGZXs2yhfRFvIxumzyd4dci1gHEA==
X-Received: by 2002:aed:3b4e:: with SMTP id q14mr349768qte.196.1575938527321;
        Mon, 09 Dec 2019 16:42:07 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id 40sm466296qtc.95.2019.12.09.16.42.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 16:42:06 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id d71so6977874qkc.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 16:42:06 -0800 (PST)
X-Received: by 2002:a37:9547:: with SMTP id x68mr31715256qkd.206.1575938525894;
 Mon, 09 Dec 2019 16:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20191209235116.142692-1-briannorris@chromium.org>
In-Reply-To: <20191209235116.142692-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 9 Dec 2019 16:41:54 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMszUwnVPNWQ42nPnvfHE9x42vaO76Bk=qs5gD+AYxdMw@mail.gmail.com>
Message-ID: <CA+ASDXMszUwnVPNWQ42nPnvfHE9x42vaO76Bk=qs5gD+AYxdMw@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: start out with BSS type ANY, not STA
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 9, 2019 at 3:52 PM Brian Norris <briannorris@chromium.org> wrote:
> Let's make mwifiex_get_intf_num() give a proper answer, by making its
> initial value the proper uninitialized value -- ANY.

I should have noticed that this function was recently neutered in a
patch which actually fixes the bug I cared about anyway:
7afb94da3cd8 ("mwifiex: update set_mac_address logic")

So the following is probably a better patch now :)

[PATCH] mwifiex: delete unused mwifiex_get_intf_num()
https://lkml.kernel.org/linux-wireless/20191210003911.28066-1-briannorris@chromium.org/T/#u
https://patchwork.kernel.org/patch/11281155/

I'll mark $subject patch as Superseded in Patchwork.

Brian
