Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD83109B4C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 10:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfKZJge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 04:36:34 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:49274
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbfKZJge (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 04:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574760993;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:Message-ID;
        bh=WqnlfxtF6WQ1UXwO3jQwpAJI3jcfSkzxdr2oXhs+rWY=;
        b=fdjuwSr2ILutvO8JZqgkFTH5VZb4AvomA4TUh2XKRxtHWWEi0MIWi+m9hkGnWEU5
        M71ms4lIC5qgTt2iYR4GS+cL6vZlaH1Ojhf5KY58KRop7HOcSqbH7EBw+j9sgcHPLwB
        6kp5o+tgZM1Xh/JJkSTrob0KF+A3rrYXvlbcJuHA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574760993;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:Message-ID:Feedback-ID;
        bh=WqnlfxtF6WQ1UXwO3jQwpAJI3jcfSkzxdr2oXhs+rWY=;
        b=PPILBJhpYGmbZjE6IcMFCkEecK5QuvyKnBZdMZKnaa6WNXGGI2dqsXpG3B+Kc5zj
        goxZHdubiOYJAuhv/rQT5gE3V+rGZj7XE50T2cYpXFYlqkG0b0awFQTJ0ypnOi61kO1
        1u1fD5ut/AE7Z2Tcld7FBaTFFGzZwNRqGApAh68E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Nov 2019 09:36:33 +0000
From:   wgong@codeaurora.org
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: RE: [EXT] [PATCH] ath10k: enable firmware log by default for sdio
Message-ID: <0101016ea711d2bc-858b382e-5145-4365-bf8c-332eb6e87b82-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.11.26-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Wen Gong
> Sent: Friday, November 8, 2019 5:19 PM
> To: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] [PATCH] ath10k: enable firmware log by default for sdio

Hi Kalle,

I found this patch has removed from pending branch, and not in ath-next 
branch.
It is in pending branch before.
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=497363abab79eac916f2e2c6f9ab2b9bb4aa4b11
