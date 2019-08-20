Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC62E964A0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfHTPfg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:35:36 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:35669 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbfHTPfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:35:33 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 11:35:32 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 00BB03F723;
        Tue, 20 Aug 2019 17:28:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gQ0hbAbfz335; Tue, 20 Aug 2019 17:28:46 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B29173F6F6;
        Tue, 20 Aug 2019 17:28:45 +0200 (CEST)
Date:   Tue, 20 Aug 2019 17:28:45 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org
Subject: Re: rt2800: Commit 710e6cc1595e breaks ID 148f:3070 RT2870/RT3070
 USB wifi
Message-ID: <20190820152845.GA14444@sx9>
References: <20190820112050.GA35458@sx9>
 <20190820112730.GB2227@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190820112730.GB2227@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks, Stanislaw,

> Hi, I've recently sent the patch that should fix the problem:
> https://lore.kernel.org/linux-wireless/1566213607-6723-1-git-send-email-sgruszka@redhat.com/T/#u

Indeed, that patch fixes the breakage.

Fredrik
