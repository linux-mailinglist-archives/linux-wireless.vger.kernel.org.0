Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3605E15FE1C
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2020 12:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgBOLS6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Feb 2020 06:18:58 -0500
Received: from mail.schafweide.org ([185.45.112.52]:39864 "EHLO
        mail.schafweide.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgBOLS6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Feb 2020 06:18:58 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Feb 2020 06:18:58 EST
Received: from [IPv6:2a07:59c6:eeff:20:d66:7892:f4ef:c5b1] (unknown [IPv6:2a07:59c6:eeff:20:d66:7892:f4ef:c5b1])
        by mail.schafweide.org (Postfix) with ESMTPSA id F40B78340103;
        Sat, 15 Feb 2020 12:12:58 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=schafweide.org;
        s=default; t=1581765179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvCzgyNYynzhT4qlUIcKQ8MynIRzSIrZhqV2yM/oHck=;
        b=xCX+/aCIlH443ef8Azz1Aj8qKr96uO6U4OORaASM1a0vBmOFlkWH3ZbieMHMq81v541Di/
        tM5K7SWux++dRUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schafweide.org;
        s=rsa; t=1581765179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvCzgyNYynzhT4qlUIcKQ8MynIRzSIrZhqV2yM/oHck=;
        b=xeXGDGs0Mz+Ixki3UFcW2nVNvfQx24DwwdqiTcqSaVYi/ShI8Uwn9lf2q0Sgy/iIQl5i6V
        8PLDjb7BriArqa7k0bQ0AhqROU/crtn4Rx8Dc1MH93zHoDKW42ybxxCRao4HnW86UMnXwX
        OxkgPTlFFfKnXBek0zyVZ0DR4YkMeBI=
Subject: Re: [rtw88] Linux 5.6-rc1 / RTL8822BE WiFi adapter
To:     Tobias Predel <tobias.predel@gmail.com>
References: <20200214214134.GA12764@t2b3>
Cc:     linux-wireless@vger.kernel.org
From:   Bjoern Franke <bjo@schafweide.org>
Message-ID: <c76d37cc-2cab-a8f2-e570-a444c06ad020@schafweide.org>
Date:   Sat, 15 Feb 2020 12:12:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214214134.GA12764@t2b3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> Is the provided firmware file in the linux-firmware tree still
> compatible with the driver code?
> 
> I would be very glad if someone could look into this.

I'm just wondering why these issues do not appear with lwfinger's rtw88 
branch[1]. lwfinger mentioned several times that his module is mostly 
the same as the kernel one.

But with the "official" one I often got connection losses or bad throughput.

Kind Regards
Bjoern


[1]https://aur.archlinux.org/packages/rtlwifi_new-rtw88-dkms/
