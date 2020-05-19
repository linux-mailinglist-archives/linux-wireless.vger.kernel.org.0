Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2951DA2CC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgESUgP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESUgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 16:36:12 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC677C08C5C0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 13:36:12 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id e10so415876vsp.12
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ocApQ62zmqcnkVU3n8VWQNIXG5B1jainUDzkBZVXX8=;
        b=YWt5XHdneSXm1vSWZtz4IUp78CqJd+zdNXxPAglc6lnpbqK6z/U8yjR1QKGSUjY6Xb
         rZDEuZnjHSAzOw2aIePPPe084VmJSETiXfWfJfOwxc09vvfzdQXi8ge4GeagleK+88mQ
         ZAsd1eGeL5Zj7A7XbgUSvwQpC49nItfkCaqyoR2rQ2mAoZswd/LByNSm5CcUOaYIWXeu
         hFBpr6lGSlnTMB7Y0pZMxN4+U2lc3Sskac7k8hTQpltt/qeJM5+hRZrB+q7R5nVtpnSq
         TQTcFrV07mOdX0wPOjI6elrwtDyhcltr2B6AwU5wR90pMMG/AXqfUVCCdu0NXyG3NM5A
         ryZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ocApQ62zmqcnkVU3n8VWQNIXG5B1jainUDzkBZVXX8=;
        b=ofHeLvN+3Y6+gallbcMahyMj6p4fYjyZ6zssIKSBqHP0g7g+hVc5LwGDYcBVGoaEKO
         uGONLxWgRt6uEr4ZYMM795H7qfbYlviu/xHHy2JSMixJQYdrXzaz171Eiz5ml0uwmT9T
         8559FzaNXIyOp5Pu+PDRm4u4+odT2heXevalHB5ddVcqEXudWw2+smetUoE5z5Fe2DMO
         wVpBcKOMX6eOrSFVsK8cWTS+FuhldFTPe15oFoXUY+apHqVThGJuEPSmIsWejhyhpTdn
         3EFN8fYzP720TrZ62uGnVdmMa+53Oqgs501Owu+Qpsb8YK3zLXyp1GhmQhtfeHtdyyHG
         zeTA==
X-Gm-Message-State: AOAM5303a/XQByUL+Qb4ZQS5TSZGNoPTkEbcW8qCxMBm9HBZPgGbNPN4
        g0Pktv7FtC1FtehxbSNFSUtWlVbLNerRRjuz2FTiPElGtw==
X-Google-Smtp-Source: ABdhPJw7M31B+UoJl4JHRcdQ1yO/BWl99lEl5cWQYNxVqzLPIRVDc10abHApnX6HHgjdCWEaanWf+I1TU+vPvp0vUsA=
X-Received: by 2002:a67:f64a:: with SMTP id u10mr899668vso.202.1589920571798;
 Tue, 19 May 2020 13:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net>
In-Reply-To: <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 19 May 2020 21:36:00 +0100
Message-ID: <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     b43-dev@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Larry,

On Tue, 19 May 2020 at 21:30, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
>  From other drivers, it appears that handling WPA3 might be as simple as setting
> MFP_CAPABLE in the hardware capabilities. Please try this patch:

Fantastic, thanks for the quick reply! I will do it ASAP and get back to you.

> I have no way of testing other than to compile.

No problem, I have two different revisions of b43 cards to test (on
x86 and ppc32 machines). :)

Thanks a lot,
Rui
