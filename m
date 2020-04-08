Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE91A295B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2020 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgDHTeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 15:34:08 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:38360 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgDHTeI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 15:34:08 -0400
Received: by mail-ed1-f53.google.com with SMTP id e5so10229808edq.5
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2020 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NJK0ezxcn73fywezEYO9nJSZ+DrV+nf4fJwQGx6CXHg=;
        b=ld2zOY6qsvba7hgiNXKiMFJiVkmm2Z+s/heTlFKunqbiTcWnr4bBN4Ck4cuK1NNAa9
         DuszJTJVPiPyhRFS3LVjX1ZPg0H0DzXe4COGvL4RiF0hvaLVifXpv6nfHwd9plccqbgE
         jdVIVaC41IslSx7ZZftTXGeNrhya9F69S0ozmeECgy55tZr3//KGtdGvk+zFS1pll0rr
         pu0s/Aq5zx/xZQccmRyfk8d2dGP9e7d6ECotElxcsjUt44zxY6sso0wJ/YORcgE8ieSg
         knnlQXN03NN4fYJDBaO2Z96/Iqh6I/LY84ZOpuaeDFL2XH4NV1msdE2ADYFR395xeqQ0
         UFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NJK0ezxcn73fywezEYO9nJSZ+DrV+nf4fJwQGx6CXHg=;
        b=QDdcehypzeT0C2n1fH5dNUFYeTxhYrOP6KkC7o3ey1M6y9HXMvC7zvyi2sOUrLJdqW
         XtzrMe5XuC9GX1byQIihzzOhYUdVx6OBI4mWlm0f7hWwEmlq8UHWQRJjGKh2dMKbYdiU
         OmaPS4iIFJ0B1o/AoyJSNKiK4yl1in/k6yga2i0Lu0e+f4BhubFix3bjpQ20dKxTMOw0
         qdMpQLQrGB0hJrLAaMRNkx8bFdZr1fZxC118MDXSaQwHxhroZrkY/Yo4tQgF2iU2RWCn
         5M/khPU9HR576rmip1e4mUsDp78x5+eXkyE21SjI9zPfbZp4JqSSilqoCjdtcjt6xcI5
         khQw==
X-Gm-Message-State: AGi0PuYVr0P3D8nOvOz9Qx3jY3lwKQ4/4BMggYwsp/erl8ftJ5bMpel1
        XKF8160Ej8ZSgbmu1JXQ+EZ7AHlWv/Ha58aro2cY2WhT
X-Google-Smtp-Source: APiQypK6aWg7cY6ehtypc6wRUTS9hJHNxuTw/f84ldO6xRYeY0yvsxS7/8GlbJ0RvICGWkCMSYK+q4TXAYv2GK3dNxs=
X-Received: by 2002:aa7:c641:: with SMTP id z1mr1904397edr.161.1586374445744;
 Wed, 08 Apr 2020 12:34:05 -0700 (PDT)
MIME-Version: 1.0
From:   James Prestwood <prestwoj@gmail.com>
Date:   Wed, 8 Apr 2020 12:33:55 -0700
Message-ID: <CAPv5Ue5YVawMHo+o2ie8=N6R7tpKeXdS+p=K44+wjcRAVb2yZQ@mail.gmail.com>
Subject: Is PSK offload now required on fullmac?
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have been doing some testing on brcmfmac (using a Raspi 3) and
cannot get PSK connections to work unless using the PSK offload
feature. In 2018 the offload support was added to wpa_supplicant where
it checks for the extended feature and if its set it includes ATTR_PMK
with CMD_CONNECT. This all works and I have done a similar change to
IWD. My question is, should this work without including ATTR_PMK and
doing EAPoL in userspace? Or is ATTR_PMK now required on brcmfmac?

When I leave out ATTR_PMK to CMD_CONNECT I get a successful connect
event, but then get disconnected within a few seconds with an EAPoL
timeout. This is a locally generated disconnect.

Thanks,
James
