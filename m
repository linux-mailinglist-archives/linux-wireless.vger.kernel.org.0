Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30C278816
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfG2JN4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 05:13:56 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:41243 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfG2JN4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 05:13:56 -0400
Received: by mail-lj1-f176.google.com with SMTP id d24so57833659ljg.8
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=agilox-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=bZ9hp09xAqzb78yPOPj7pHQCKSpsksu8YkSbYDHfW4A=;
        b=i0OZylYiONW03Q8FTODNOlMFdximDnSBtm3IVvABVmN3QgAQvCyNelhT7DNaEthLC3
         rrf5PvRdd/9nzLqnQ7DL8GqiVNcC7p9oyYPd3wURQ3hnRUhijZQa7AIspoZC27t8mAQ8
         uGTaSDvgCAZMZa8csImLkDr7txPvIztAek/B+GQfT6mISACnhSntO46RwJ/Eq4w+/odj
         nLao1wZtXNDCf7xVsYM/Tk3OO+LZARqnAnwO7Ttus5RDQWszy7DSUOSHK8SZspjc+YFK
         Y9qS6NkqRZsmZu57yIEOixSei3XSyS2tx/Hv8KGudwtI+1Rw/r9t+UwgFby2KOhApw7R
         /LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bZ9hp09xAqzb78yPOPj7pHQCKSpsksu8YkSbYDHfW4A=;
        b=SzZGNR+4kpsZFr+Uy+0wPWThyFWoQkKVofH8AVzHW0sVRz20y2LTNISWsHxQJy+vI7
         h2AWBnaeEs1NY0DoZZfneN0CXXaoG/D9RglpDzr8+rGv9xNNWyxGjM7WLDi3lpNvpDyg
         EqSDN89JfRfrrXglC+exnORR3sSUs9UNpF9t50CxVUVSm6I4zZ7QGfkp+BmWMkmhIb3o
         yiVG1QOd0NQ2DJX6ntHOObxAZqWru9y3kBO30nU41WYPHWmbJUdJEcEZTLkXp9h1RRAX
         E8Chc16bQ71PqPdrAr+zzldo8zPExR2r2AlciZkxYD3EROLJswEVmoVlT/KRG4Y+gTTj
         AGyQ==
X-Gm-Message-State: APjAAAW+kkPo66YIAELNSXs4czUZjSUxNBWA19RFu5BazCM7Dsad+gEl
        U8xqiwz8r6FlrHsTUDcCKJMyMegPC/UAyQu7+QBTeMhjKcw=
X-Google-Smtp-Source: APXvYqyT5DNekMvPulGSO9yaAEdeCcFrKSA/s9G8BngNUJPK5+49S8qkYyu4q5vN+yTUZoPRyvBkoGx9A79aUfpO48c=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr46260194ljk.152.1564391633806;
 Mon, 29 Jul 2019 02:13:53 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Redlinger <lukas.redlinger@agilox.net>
Date:   Mon, 29 Jul 2019 11:13:37 +0200
Message-ID: <CAN5HydqLuX=gg-j6kn_nzTTvxgKxdYaB3ZviVH_+ZD694pHJoQ@mail.gmail.com>
Subject: ath10k: Fix channel info parsing for non tlv target
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My x86_64 system with Arch Linux 5.2.2 and a Compex WLE600VX card is
filling the log with "ath10k_pci 0000:01:00.0: failed to parse chan
info event: -71".

WiFi in general works, but wavemon is struggling as some packets seem
to be incomplete.
This seems to be the fix: https://patchwork.kernel.org/patch/10844513/

How/when will i get mainline? Can I speed up the process somehow?

Thanks,
Lukas
