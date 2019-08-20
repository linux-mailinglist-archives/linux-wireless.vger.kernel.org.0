Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813D395D4D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 13:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfHTL0K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 07:26:10 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:58992 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTL0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 07:26:10 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 07:26:09 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 6337A3F549;
        Tue, 20 Aug 2019 13:20:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -0.5
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 tagged_above=-999 required=6.31
        tests=[BAYES_05=-0.5] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gwe7ckDjgjLZ; Tue, 20 Aug 2019 13:20:51 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 5CFFB3F226;
        Tue, 20 Aug 2019 13:20:51 +0200 (CEST)
Date:   Tue, 20 Aug 2019 13:20:50 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org
Subject: rt2800: Commit 710e6cc1595e breaks ID 148f:3070 RT2870/RT3070 USB
 wifi
Message-ID: <20190820112050.GA35458@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stanislaw,

Commit 710e6cc1595e ("rt2800: do not nullify initialization vector data")
breaks USB device 006: ID 148f:3070 Ralink Technology, Corp. RT2870/RT3070
Wireless Adapter. No particular error messages are produced, but its
interface becomes unreachable. Reverting this commit in 5.3.0-rc5 solves
the problem.

Fredrik
