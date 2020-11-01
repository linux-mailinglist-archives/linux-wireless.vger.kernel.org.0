Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E982A21CA
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgKAVPy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgKAVPx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:15:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEFC0617A6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 13:15:53 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xdHaYragi0kMAwlvIGHiNDw08UCRAZ3JdpPV0Z6RKXU=;
        b=pn99qOmDkkeV64rs2a6890Nua49kgo/quhiUCaVZAXwu2yZLSNhN0kGvdYb0boMR74kG4O
        VMGhPmga6slKxXHfCV89KTtwD2fEGeP04hvR4jEedLiI+6uGCosnVV8oTijCt4LAtrZcSm
        reDYLQRRq8CrLz3IgkqULxvYv1Xiq6syeodWBxCznWTUQ700Pks741oag/pQa5lcqSvCWz
        3HXXqYxO5fVqtfnq3RCafZyqJM8tmCrNa3wj2kPaBtKShO5Hqc7kn0MqhDk0sysPkqMaZ5
        Wtgi0gIqgfAA5NJb2a/ByjfgGrzYtJWbbzHNTkh6dGId5+WcrmS+iFVEJziGOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xdHaYragi0kMAwlvIGHiNDw08UCRAZ3JdpPV0Z6RKXU=;
        b=3Kf09cdmQrX1U6v6IzEaSIZiBTlDHq/yWlvkzI079i9Jx0Dk5+TecRES0/OuoZKukU0XaI
        48vows8OxFFGGRAA==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] in_interrupt() cleanup, part 2 (wireless)
Date:   Sun,  1 Nov 2020 22:15:28 +0100
Message-Id: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Folks,

in the discussion about preempt count consistency across kernel configurati=
ons:

  https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/

Linus clearly requested that code in drivers and libraries which changes
behaviour based on execution context should either be split up so that
e.g. task context invocations and BH invocations have different interfaces
or if that's not possible the context information has to be provided by the
caller which knows in which context it is executing.

This includes conditional locking, allocation mode (GFP_*) decisions and
avoidance of code paths which might sleep.

In the long run, usage of 'preemptible, in_*irq etc.' should be banned from
driver code completely.

This is part two addressing remaining wireless drivers except for
orinoco-usb.

Sebastian


