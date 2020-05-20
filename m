Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A901DC12D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 23:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgETVQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgETVQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 17:16:25 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D3C061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 14:16:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id c16so4987185iol.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CBPEVlbLexZfBvLawhXL/xGPcx2sgG/hLTPjMdMQtAo=;
        b=ZjZugB3fBuPtinAR7YnzsnTjv23SMke9GUvI+Nsi6r142wnOszXz1BsLJU4CfiGP12
         fOm4w6iVR4TLfkMRyXwp3L6Xv7IshRASanUaaAi3aEfeqXXhWHZiCUKYXP9qUPwiEPZm
         r7joCe4MAIVhBHAXFYQkSm5pajLnXvajPBbUSeNyL6rS9I3MHPbXGXQQXwWznpNdp89u
         29gVOiDwHinv8zjVyUfP2UrRsJMy2hEf3GoSf6LFR3p+/62KLlpu6V2WggD3OR9EhHwv
         0n3gdRLplY2/TtgX1NZ6LNtrFg0o7ANXUymTIvtnJcFfrpqDgZsJiQAkOSVZSgaUi8pk
         e84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CBPEVlbLexZfBvLawhXL/xGPcx2sgG/hLTPjMdMQtAo=;
        b=YAZLNbukqT/oDob/IZpu0h2gcLWtY6GQ7sbirfhsU1pmf3iR+ODjb7ePCul1oqtZWU
         7ASBz27/2omcfDrMIMJd+7W5EjMgPUCG4gu7MlFuVUNfXybxoZjiJJBfgjWLHx4k2DNf
         Sdsy53+z3onNc1Ufk6Q3EouXpGJc06k4u7rygoXukgD+6EQgFDmgB2XQClhvFWhcElaR
         fO8wqO64MV8B1JwdYymLOx8LxDEvPkP8AN1XEBLGycODa8RGD9LQRaJQ+pE1ei4Fr+eg
         TadJ/LipreUzZ8i6WjkN/8iuyh8CTH4B8mRweRh2M7JQ45M5X+PimKrBNkKta1FYwSRB
         zAKg==
X-Gm-Message-State: AOAM532TdgTbAV1IY3jclk4n6oBIxMpiMJMyU2KdA8BdSg9aW9xfNEn2
        gk/uO3mFKDCIC8EO5KqxZ4xqjlYbMvgyAcrL28eX9hfsSY85Bw==
X-Google-Smtp-Source: ABdhPJzVLdgzFSIooRw2ZsygOd5CZyh/NaAy5Oa/9xzxEacdubUcoC0Iv0sYM7iP7BtqHpgZozl3YBMw2BQE0e8/P8Y=
X-Received: by 2002:a05:6638:bc4:: with SMTP id g4mr987209jad.55.1590009383702;
 Wed, 20 May 2020 14:16:23 -0700 (PDT)
MIME-Version: 1.0
From:   Ahmed Kamal <email.ahmedkamal@googlemail.com>
Date:   Wed, 20 May 2020 23:16:12 +0200
Message-ID: <CANzjMX45rf28H9jPwqc0Qdo=S1uHipiUd7FoO+17Gr+WB9bq7w@mail.gmail.com>
Subject: Request for Update regulatory rules for Egypt (EG)
To:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

This is a request to update Egypt (EG) according to:
https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx

Sorry this is not a patch. Also, I'm not subscribed to either list, so
not sure if this will work. A confirmation reply, would be
appreciated. Regards!
