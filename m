Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6C2D1D69
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 23:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgLGWgZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 17:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgLGWgZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 17:36:25 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F421C061794
        for <linux-wireless@vger.kernel.org>; Mon,  7 Dec 2020 14:35:45 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id j12so14091344ota.7
        for <linux-wireless@vger.kernel.org>; Mon, 07 Dec 2020 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+pv/UHsHKrSwmAAHtSaItWMksLe4gf20uaCHA3y49Ro=;
        b=CQxca2Ga/1ZWY3aIWI57A0Kipzen4dMpI289NWq2X8rksvQZUEMxsWoBSC82/R/a/E
         JPsWfKhzWbSTGzuPIGmBtYZ/Qz7+B5mpgvglSeTYmhlwAHOq2cGeqOSYqL21ldafDYre
         P0YfYuxWcMpEUOt4c0ou1JCekJJjXoUflfoqfeHezaQ6EWYMImqbcj7PQUBPNLqvaG5Y
         /K2rNuWBX9tTbQUrbqfeUp4NtIiH5Ry6boPdkLBANko9VeaPQk+E8PX3vOBW0rmZ5Cu+
         dlpXWOwLeFpP24ILBUhK9lUaY/S2wBwQ+DSCwQsMb70Y9LAHanCGXF4NFG6oLllUZ9PW
         e0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+pv/UHsHKrSwmAAHtSaItWMksLe4gf20uaCHA3y49Ro=;
        b=foFidtU69IfGnlf+CbsmhlqWall4pxQ9YKJbJpB0iEsA6IzW+7RqBNGO79gSEu9w2A
         QbjdOtYDMfwx+xHPeG1BWi8owyAzcZM0P2bIGCV4jlY1JMDTpafni76TN+lVWS3MKj0f
         4kw6Rh6SAfEGkJrKKpZIQamn4d4mwojJeCrR3xchTUF7RBuK0FZPiSEOrDPgS94oW4uU
         Iw3VTdTCi5bQL16Ysje9LqxII7//2z7xA3swFSmTN1cwiEelrIHfDdOXcs/nzMVLcoIp
         mQnZkBTAwwTZi0BizfiKyHsOvMir1ITSZ0ZibzlnVame40LubROBvTPfvEHEQyclRxw9
         4PWQ==
X-Gm-Message-State: AOAM530S7B90xW8DWGq/6IR8JLWZ3MnGJqhBi0dt4eoJR9Axv90/HKzS
        y+W9/RBtf0h6EmZhEz1eB5gZ5nsmWC20Fgg8VU0iLrP0lug=
X-Google-Smtp-Source: ABdhPJxIK9gyb1vnYW/T3cQ4iMQklSJ4bXedMXg16Syd3lLpDr5dLmqanRAjvReoRfyKJETLJd9IXXgBn17sb1NognI=
X-Received: by 2002:a9d:4b17:: with SMTP id q23mr11668339otf.157.1607380544173;
 Mon, 07 Dec 2020 14:35:44 -0800 (PST)
MIME-Version: 1.0
From:   Sugandh Huthanahally Mohan <sugandhgowda@gmail.com>
Date:   Mon, 7 Dec 2020 23:35:32 +0100
Message-ID: <CAD_iCC-ZiraO-j6N7RuHweVZxBQ8AGpfwyDgs3n5jn3O9AH4tw@mail.gmail.com>
Subject: Using FTM in iw
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello All,

I am trying to measure RTT between AP and STA using iw utility.I am
not finding any specific documentation on doing this.
Can anyone please describe how to measure RTT between AP and STA using
iw command?


Thanks,
Sugandh
