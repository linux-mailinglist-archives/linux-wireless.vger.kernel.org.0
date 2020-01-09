Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A0135F65
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 18:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgAIReF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 12:34:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43142 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbgAIReE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 12:34:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so6504329qtj.10
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLZ40X4AYSx/4IufI5neDGOXIt1DrkaYWqpJijj50lU=;
        b=YtRa8QvPTdA4j+IGrYzf5ipFgbr/DCJAJVWKc8q8BT+ICZP0hiqMU61CEmmNrt9Kor
         1IedsTdhwZO2biCYk5RspEZKHbssaZuGMTwt1u/nTHu5kT5nnZ8RqSpE8QD/CJybCbMQ
         60ASxWqybxd7rDSd1T7Q9LX9QjO3f0AB9nP/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLZ40X4AYSx/4IufI5neDGOXIt1DrkaYWqpJijj50lU=;
        b=S/WXlR4VeKd18rI923X2uekXUU0jk+HWyz5Ml+mdf3vZi1XhmOglSCt5H17L7RrxqC
         CN94sl5fm3/ItfuLF7DAZPJGzZx2iYs/9Tp4nUlt3MWLioYCFOUygWtHS8gyKkJgSC37
         7BhM5jQ08rIpd+yDg6UyOfljlZ1B/uHdyzYYaa10Fn+W1fTX2Qc+5u6lcjTpQRudrqQc
         26tKXfRCHGXeQNyes15UBA6nxC2k6bQmKE+sFbDxQLS16opu5SueGCaMP09XFhOOkW1q
         Y0rB0CPy1wAGOFTBlGgZvjyWqAlRAQpaEPrFUVCjqdgkwztPDJ8Zbv64WyC23Xpo4+HI
         4pew==
X-Gm-Message-State: APjAAAXFIz2AI0+Ql0FlrV2+wBc/doFSre97VN/jLhYkgt5Olso14Qxc
        S+zwWy0WJnVAnjz1qdftFm3EjT2reBU=
X-Google-Smtp-Source: APXvYqzLnfirYrcv4/ZwAuP/Xye5YRXF0PopqwQggLWJdEU5O+5GtacsqpdnYY6A1sEkPdIZlTrqjA==
X-Received: by 2002:ac8:5143:: with SMTP id h3mr8889863qtn.144.1578591242081;
        Thu, 09 Jan 2020 09:34:02 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id d143sm3330886qke.123.2020.01.09.09.34.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 09:34:01 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id x129so6714335qke.8
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 09:34:00 -0800 (PST)
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr10878417qkc.2.1578591240318;
 Thu, 09 Jan 2020 09:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20191227174055.4923-1-sashal@kernel.org> <20191227174055.4923-8-sashal@kernel.org>
 <CA+ASDXM6UvVCDYGq7gMEai_v3d79Pi_ZH=UFs1gfw_pL_BLMJg@mail.gmail.com> <20200109152925.GF1706@sasha-vm>
In-Reply-To: <20200109152925.GF1706@sasha-vm>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 9 Jan 2020 09:33:49 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPy+K2DGYAy+8pXbDQ3e87Vd+KazsS7JneCc5CHa_NaKA@mail.gmail.com>
Message-ID: <CA+ASDXPy+K2DGYAy+8pXbDQ3e87Vd+KazsS7JneCc5CHa_NaKA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 008/187] mwifiex: fix possible heap overflow
 in mwifiex_process_country_ie()
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        huangwen <huangwenabc@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jan 9, 2020 at 7:29 AM Sasha Levin <sashal@kernel.org> wrote:
> On Mon, Jan 06, 2020 at 02:51:28PM -0800, Brian Norris wrote:
> >I'd recommend holding off until that gets landed somewhere. (Same for
> >the AUTOSEL patches sent to other kernel branches.)
>
> I'll drop it for now, just ping us when the fix is in and we'll get both
> patches queued back up.

I'll try to do that. The maintainer is seemingly busy (likely
vacation), but I'll try to keep this in mind when they get back to me.

Thanks,
Brian
