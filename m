Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F89033CB00
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 02:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCPBuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 21:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhCPBuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 21:50:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43173C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 18:50:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id 7so9646534wrz.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 18:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=UiG7iUHeeWfZgnU4Yr5XhY6iZ/10gTbC7AqpcVdFh1g=;
        b=O4oIeATi+YHDQxfBUOA9e9FF42I1hHLVt/raXOdgGWYAZZfOO13njc0BV8qstTzIEj
         KDz82e+V/GZ9cfRBknEQavzlksSxjWOhAJJngjEs7l49SYHEb9t7+vUWTrGB5FUcmknD
         vhb03zj5aWrejoorT5wwUTx8RL4Rmx2cCfKp1vEylhiH6KFGUvgquWes+O3XlLvoN98f
         +tQP64QtFRJmwA4FRY2hXS1xP6DryJhsD2nmfjUcffma/2ulSzdZrMr0/AN7bPt79toI
         Rf/OwYR1R3lFY/MkILKHfAxpJG+4VpsXx1AMh5JzpcxC2FnodRSHNKLj/VR/gjekaWXN
         /grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UiG7iUHeeWfZgnU4Yr5XhY6iZ/10gTbC7AqpcVdFh1g=;
        b=cZhq+KgUdo1OuIf/cZq/ePi9yuqYuOxWqZ/DwH7LQSVzDp+bJrJczzFK09p4+h4rwY
         B7Ns5z+H6nmbwAlUmMsusFbJFkIV6RsoXprgT1B6G3O7fLgAvMME4mr7N3Yw4mDI4/jI
         PjJqIz/8AjocG3aiNS33MX6fXyupUknLISe8dYLAGo9zmra63ugsuj7uI8KON39mUgBI
         kVSztPt3tkCD8s+40lWZaVPsDVmjFbI2aiJSaxQF9F+FsPXcUbd1o4D8dGEPPBgkj2nI
         TebvA1sH9NY9gmOpD/dalgYgSFlOk0Uwzl5WF4gr8KWgFJaVRLuVPxWLaK49puMz2iPe
         +n7Q==
X-Gm-Message-State: AOAM532PJN3vAZNvjFlQl53sHkjNg8n/9lhG4aVQSUS3g5anJra2HTm5
        AWuIcl9e4OJzyH1qfblxf6+HjR13yIUqOXycSWqkzw7I404MaO4w
X-Google-Smtp-Source: ABdhPJxq1ObWYAqOeFbCDzQZvluNV7dtvPisn934Xy31Yg2vTv+Ugk7sW8BywGwkPReJsyaddMdxQnf0UszWbDPjsYQ=
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr2245087wrx.236.1615859400918;
 Mon, 15 Mar 2021 18:50:00 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 15 Mar 2021 19:49:45 -0600
Message-ID: <CAJCQCtRuZ0hACdwH1N23OZrxEVyM2W9gn_O4wZRcFSq_74Gkqg@mail.gmail.com>
Subject: iwlwifi, WARNING at kernel/softirq.c:178 __local_bh_enable_ip
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm getting a warning, new with kernel 5.12-rc3

[   14.156547] WARNING: CPU: 0 PID: 766 at kernel/softirq.c:178
__local_bh_enable_ip+0x97/0xd0

This is with Intel Corporation Wireless 8260, and firmware version
36.ad812ee0.0 8000C-36.ucode

Bug contains complete dmesg attached;
https://bugzilla.kernel.org/show_bug.cgi?id=212297

Thanks,


-- 
Chris Murphy
