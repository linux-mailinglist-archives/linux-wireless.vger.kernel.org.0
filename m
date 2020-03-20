Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160B118CACA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCTJtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 05:49:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTJtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 05:49:23 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jFEH0-0000vL-B6; Fri, 20 Mar 2020 10:49:02 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     tglx@linutronix.de
Cc:     arnd@arndb.de, balbi@kernel.org, bhelgaas@google.com,
        bigeasy@linutronix.de, dave@stgolabs.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        kurt.schwemmer@microsemi.com, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, logang@deltatee.com,
        mingo@kernel.org, mpe@ellerman.id.au, netdev@vger.kernel.org,
        oleg@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org
Subject: [PATCH 0/5] Remove mm.h from arch/*/include/asm/uaccess.h
Date:   Fri, 20 Mar 2020 10:48:51 +0100
Message-Id: <20200320094856.3453859-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200318204408.010461877@linutronix.de>
References: <20200318204408.010461877@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following mini-series removes linux/mm.h from the asm/uaccess.h of
the individual architecture. The series has been compile tested with the
defconfig and additionally for ia64 with the "special" allmodconfig
supplied by the bot. The regular allmod for the architectures does not
compile (even without the series).

Sebastian


