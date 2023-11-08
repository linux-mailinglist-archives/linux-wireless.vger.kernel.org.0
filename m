Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989D7E6009
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 22:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKHVhQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 16:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHVhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 16:37:15 -0500
Received: from mxb-1-3d1.seznam.cz (mxb-1-3d1.seznam.cz [IPv6:2a02:598:128:8a00::1000:3d1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8859B2127
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 13:37:12 -0800 (PST)
Received: from email.seznam.cz
        by smtpc-mxb-59df7f4d65-k4z9p
        (smtpc-mxb-59df7f4d65-k4z9p [2a02:598:128:8a00::1000:3d1])
        id 4e1f14c5afa909a3484c48cf;
        Wed, 08 Nov 2023 22:37:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=emailprofi.seznam.cz; s=szn20221014; t=1699479420;
        bh=4Y1BbhTSY/9Ja6explMEjDxVisga0RVjsF8xRyapfoI=;
        h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=a6QZH7yRtjlVu6W4eJDDlXB/lQi3hfsA9uSJONMmeY6d8Z9aUnXl70B42+HjVjS/y
         vQxIoxe+gBOEDxLFNTgalnDsA2BDi9zInuMwiU2s9vGgmmJrbUxVQeCkEYAi5Bxl5/
         l9MhzpE1Wvpd2XEsTXBw/Laqzr5h7TkHLi2cqbaPN5V9QjtP95ei6qQcbK7ioDzdHU
         s7sy7KluXkfyxQIpgQfJhSCVTQ5UjoKu+iIj886GZL0mciR5je9x5DSGS/0KRRGyMD
         7GBNHl3lqZbvvQ2jlhwUT3a7UeWzkmdrt2ECZUCIXh4C6xHjdrOUTxu2OuqZeIIjoq
         l0TBsCsWG5I6w==
Received: from kaj-0955.koleje.cuni.cz
        (kaj-0955.koleje.cuni.cz [78.128.163.196])
        by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
        Wed, 08 Nov 2023 22:36:58 +0100 (CET)
From:   =?utf-8?q?Patrik_V=C3=A1cal?= <patrik@vacal.dev>
To:     <linux-wireless@vger.kernel.org>
Subject: ipw2x00 driver user here
Date:   Wed, 08 Nov 2023 22:36:57 +0100 (CET)
Message-Id: <8fc.6Krdh.6K7Yey8hySX.1bI}zv@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I've just read about removing old wireless drivers in new kernel versions.=

There was also discussion about the ipw2x00 drivers.

Just wanna let you know that I still use my ThinkPad x41 with ipw2200. Ple=
ase don't remove the drivers from the kernel.

Also in case you need to test if the drivers are working on this machine, =
I can test it out.

Have a great day,
Patrik.
