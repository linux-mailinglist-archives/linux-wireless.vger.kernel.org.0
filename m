Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ACC209CDF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 12:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbgFYK3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 06:29:45 -0400
Received: from out1.migadu.com ([91.121.223.63]:13098 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404076AbgFYK3n (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 06:29:43 -0400
To:     linux-wireless@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=billdietrich.me;
        s=default; t=1593080980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CdeTA/S6q43DsLS/95X0DZ4/tdNe/2lyiYCDxfxztv4=;
        b=iIQvk4OR+l+8Xycw+UaR214+qyxCqDEwJubQJSLL8o3fQWZmyNcZxw8C+uAxMzIng30py4
        vGic08lg0qssXOeK7frTXa1yyXnwZXTaI+gTrSfU3V39XRCQHRooN8y2tqTjvgN436Mq7E
        gw/M65XE1l8DPJZegU2aZAveMhuoDv8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Bill Dietrich <bill@billdietrich.me>
Subject: Bug in driver r8169 for RTL810xE PCI Express Fast Ethernet controller
 ?
Message-ID: <9ab0f00c-5517-af1e-7834-cce1f9e8d577@billdietrich.me>
Date:   Thu, 25 Jun 2020 12:29:39 +0200
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8
X-Spam-Score: 0.90
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Ubuntu GNOME 20.04, kernel "5.4.0-39-generic #43-Ubuntu SMP",
I used fwupdmgr to check the firmware of my devices.
The RTL810xE PCI Express Fast Ethernet controller (driver r8169)
caused an error
"failed to read firmware: Error reading from file: Input/output error".

In output of dmesg, I get:
"r8169 0000:13:00.0: Invalid PCI ROM header signature: expecting 0xaa55,=20
got 0x0000"

I filed a bug report with the fwupd package:
https://github.com/fwupd/fwupd/issues/2197

But they say it looks like the driver is exporting an attribute "rom"
that it actually does not support, or for which it doesn't return valid
data (contents of the firmware).

Is this a driver bug ?=C2=A0 How can I file a bug report ?=C2=A0 Or if someone
else wants to do so for me (I've never filed a kernel or driver bug
report), that would be fine.

Thanks,

Bill Dietrich
bill@billdietrich.me


-- Email domain proudly hosted at https://migadu.com

