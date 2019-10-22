Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26B6DFC0B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 04:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfJVCvu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 22:51:50 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:40533 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfJVCvu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 22:51:50 -0400
Received: by mail-io1-f42.google.com with SMTP id p6so10342601iod.7
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 19:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vwHJvn5LlsBsZWMTHEdYg10EePvWqYZi2Mc809hAbx8=;
        b=pUDg4SPAa9Qc8IKn+TsP+71KtKf3jtywyQtoUTXwA2BnwYVUmO20EiBtXsasv3Z0ze
         8c2tp3PYjZZ35oBQh/RzOlt6GMcoz0Uk5IVM+JFz6M9OrF2JzZsbO24j18UsKz0TcjNp
         BCY/hrNoG/MAhyVFGXOjZ7l9PRudxTLxQ6SrMv+G39ta0V+3vODzZbWFQjM7ZxkufwbZ
         aMlmGi23pEPRUYGpkDa2IUf81EJ7+g+yqwBWnv2N4XayHSnSBKfILI+Yyg+xAhlJENKq
         v3FNas/uljUY4KnskA6G2AwpiNmW+7oPC8XoygEZNBUYy6wYumNMsqEplPF4S+aBbUno
         YHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vwHJvn5LlsBsZWMTHEdYg10EePvWqYZi2Mc809hAbx8=;
        b=cJk7WHy5XKXnfqMHsknchurLZc9toTFa0g1a10dGUbkkPLK1cG//zpIi3WIHjFYlmD
         swQe0RxK50tLVH2O+RyxiQv2aSOUvqD0G+3rAcO2g+xRlQey4I4e6Zd5KNxdIGbiix/I
         szcp467AmZF+b1Nf4XJrMHoBE0kE3ZhsN5OyqScParJSdyjkRkktJMSF+G6LdTi9G+R3
         qGwrK3YZ5UMnDyJ3SrTiolmaW6xjdGPufGbASy2DhDLYmIiTFGGpUF1yB4UyqvITAo73
         4wegf2TU5baTDidCEPx7HZOoPdVa5K11sKjhYbN9ExZhh9EbhIj50FRjirZfsbP0TkDA
         2NrA==
X-Gm-Message-State: APjAAAVPqEWGOie9Y/9YXJntSjMy6NWQkhzsB+J6Ko4R5MQ20IuWAKjH
        /SatJ+RRoX6eGjcOzbvFkhzED+ffU06KXhjOu1ORnw58
X-Google-Smtp-Source: APXvYqzZtr9RPiXPPo6lVT9W9YnI0cYdvSmklBcT60Wvyv2TvjTF5Aj83gnltiWOcVWs5e4UVVej0ovHuYx+GtxuZ/Y=
X-Received: by 2002:a02:70c8:: with SMTP id f191mr1496682jac.117.1571712708795;
 Mon, 21 Oct 2019 19:51:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:9c85:0:0:0:0:0 with HTTP; Mon, 21 Oct 2019 19:51:48
 -0700 (PDT)
From:   JH <jupiter.hce@gmail.com>
Date:   Tue, 22 Oct 2019 13:51:48 +1100
Message-ID: <CAA=hcWS_5keJiNJwqpiOh+N49LoNE-pHjkwYSKSN1q=G12z3pw@mail.gmail.com>
Subject: mwifiex Invalid Sched_scan parameters
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am running kernel 4.19.75 LTS on imx6, the WiFi connection is not
stable, sometime it works, sometime it didn't, it could work with some
home WiFi modem, but not with some other WiFi modem. there is a
following error message, do I need to worry about?

[  519.870877] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters

There was no that error message when I ran the kernel 5.1 at the same
device, the WiFi connection was much reliable than kernel 4.19, any
explanation?

The reason we moved from kernel 5.1 back to 4.19 is we want to  use
kernel LTS release, which might not be a good idea.

Appreciate your comments.

Thank you.

Kind regards,

- jupiter
