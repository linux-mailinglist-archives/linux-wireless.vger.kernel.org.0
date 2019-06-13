Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD744A1A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfFMSAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 14:00:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46789 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfFMSAp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 14:00:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so23558262qtn.13
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2019 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tIwNNw0MIvdhB1T9U39nTb0nfPhroJFxVNqMIG21pzE=;
        b=vV0nKqzmyW0RtDuWUSVwttrkBEjWgDqYv+Wkpvy3texi45M5Ee+SK/bi27n5mNrHD0
         VeUY1NVDy10pMMlWaymKr0O06Bvk4UenC/hZqCXqC4+Nj+PBBhmFeD3lON4Z3IZXMS9t
         R5/KVzclp9jRJSlBalzUkHP2DrwjmVgHdgVjDqd/AxnP4IuP66C+1FWpJ3nY/QBEoHvL
         3XF3vb1C8lJqlMqWzzlEsuFifhvrbh76ZtvBdAyrRJGmDBOUyP2qciciLkC7AQCG64LF
         bG0/emVOKCJtQIohfWQh3KOvLh+gYmSQ3azF8VT+V34cPe6HK5RvNRCbp/ljpzYxhDiv
         ikeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tIwNNw0MIvdhB1T9U39nTb0nfPhroJFxVNqMIG21pzE=;
        b=G2xrZaceAPhgoNikE67F7khRHWY0nQ+o2LCmCOBIHklVIPLPEII1JfxuIxIgQE/Ns8
         /reVmq0mjsu+BJr9EpWXjfmx4XkYcDrJgLUdYrwMg9Z4Pr2TFapRUZmFCM8txZcbflGk
         cscfL8EsYHie/SS7wixbq/SVrbCNbQu1ZHDA2qKIu9mzXUSp1LkTM+NVnp7qavrqK2a/
         AAxgfieLyVTPB9apojgdVt7OuQCSvQqWoUydxMYiz0EQB3ry3k/n2S7dNAY5h3iVfW4l
         MyeCyQF/i0jQ40PlHAqcIsmfFlbLFhjlLcVAPb8wnFahP5CeejZ7cUa8Koe7KGPC+B+f
         m8Ng==
X-Gm-Message-State: APjAAAW6OPVQ9ifknib25K7fkehgF5cWPhi52K8a35Ru3LPkgj7ZHNAz
        og/jYFcGt2inlYtViOch9JVhL1CHnPyNxlU8H4pjqg==
X-Google-Smtp-Source: APXvYqxBCpIQr9HE8UJ6Ig5KPqk1R7Lx+xm9kbt8svSse71v7eB27zC6+ZJVRu7asR2SZmzTgd9kfZSTTys3y1j/J5w=
X-Received: by 2002:ac8:1a59:: with SMTP id q25mr75832939qtk.76.1560448844160;
 Thu, 13 Jun 2019 11:00:44 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Thu, 13 Jun 2019 11:00:33 -0700
Message-ID: <CAJkfWY4WkeMv3Z+Nh4B0xtErTAi6mVCriURZTjd2Q__gMtaEqA@mail.gmail.com>
Subject: Cleanup of -Wunused-const-variable in drivers/net/wireless/ti/wl18xx/main.c
To:     eliad@wizery.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey all,

I'm looking into cleaning up ignored warnings in the kernel so we can
remove compiler flags to ignore warnings.

There are two unused variables ('wl18xx_iface_ap_cl_limits' and
'wl18xx_iface_ap_go_limits') in drivers/net/wireless/ti/wl18xx/main.c.
These appear to be limits when using p2p devices, yet they are never
used.

Wanted to reach out for the best course of action to fix the warning.

https://github.com/ClangBuiltLinux/linux/issues/530

Thanks,
Nathan Huckleberry
