Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F6C116B76
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 11:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLIKuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 05:50:55 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:58726
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbfLIKuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 05:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575888654;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=5OgJrbBPzFfmVnI+vT491gjd0jnCl2RbAg05uA8CcE8=;
        b=c/XSp4/qoX7i97Mx7JbYx0TlPY4BuNKL/0TyRloLiaAXTtpaUtxwAiIK9S5bHq1b
        k2XjQUpsulL6JxiLmZ/Wwj5jyxjj/eb4r3sFfmRPftuSP8pDiZj3vai1sUyZ5fYiivC
        1ejsO/iUMxJL8b7FciooIjIn9x3HpYPHaEE1Bgmc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575888653;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=5OgJrbBPzFfmVnI+vT491gjd0jnCl2RbAg05uA8CcE8=;
        b=XHdXBigLveXmsGucp7ezYpWabK+mAPV1/OE9ua6m3qRyMDUyl4mMPveWoEjhzw3Y
        jwl+c3mWGq8EyLtPjzNHpYnTA/niKym5psy72lB50hLPsZkGm1YvA6h706JK41aR0p1
        hdPj9Ms9TVAljuNKJMmf8UaDK/fFpKlpMTr0OBzg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB1B8C3480B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Hari Nagalla <hnagalla@gmail.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        maitalm@ti.com
Subject: Re: [[PATCH wireless-drivers] 1/1] wlcore: mesh: Add support for RX Boradcast Key
References: <20191208132058.5588-1-hnagalla@gmail.com>
Date:   Mon, 9 Dec 2019 10:50:53 +0000
In-Reply-To: <20191208132058.5588-1-hnagalla@gmail.com> (Hari Nagalla's
        message of "Sun, 8 Dec 2019 07:20:57 -0600")
Message-ID: <0101016eea488d3a-64ccb68a-991f-427c-871f-984df06040fb-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.09-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hari Nagalla <hnagalla@gmail.com> writes:

> From: Maital Hahn <maitalm@ti.com>
>
> In order to support authentication of equals peers,
> need to save RX Broadcast key per peer (on top of 1 TX broadcast key
> and unicast key per peer).
>
>
> Signed-off-by: Maital Hahn <maitalm@ti.com>
> Acked-by: Guy Mishol <guym@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@gmail.com>

As this a new feature, and not fixing a serious issue, I think this
should go to wireles-drivers-next, not wireless-drivers. Agree?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
