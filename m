Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B1972774
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 07:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGXFms (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 01:42:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGXFms (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 01:42:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30C2B60FEE; Wed, 24 Jul 2019 05:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563946967;
        bh=PYmMgHLnn+uS7jujuUNMhQgsfBPjg7Apw2qRKsODwtw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S6tdKK/HAbePn7PBt6q3TLMXoswhLLKUnN//11XPgPJOZ4CL7e8jnvJSf4xk1qnAh
         RGJ9HK1xekEvolSBrIXQe3zFk28oDkYEDff5NdPpUd2B/6ryl56I/Gdu85FPeGAtob
         LGoQdCRT8/SVdayf0QPy14/8L84KMn6lK+SJziCw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A850601B4;
        Wed, 24 Jul 2019 05:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563946965;
        bh=PYmMgHLnn+uS7jujuUNMhQgsfBPjg7Apw2qRKsODwtw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ujzks8hqcut3npyNE+zk6Ir34P/fblLHXvBzASjtwSIfl4bFHzH4Dk/YUsZpmEUkM
         RiUeL67mlVfrRnC9HrQ3cKXulAXdZE6LfZHOvHroGo8YqlSS+9h85J7mFyLIw23uLP
         L+VIKQAx8HqkBLvRMPb1ZP8OjwflzakJ35aoE8J4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A850601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     maowenan <maowenan@huawei.com>
Cc:     <amitkarwar@gmail.com>, <nishants@marvell.com>,
        <gbhat@marvell.com>, <huxinming820@gmail.com>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [net-next] mwifiex: use eth_broadcast_addr() to assign broadcast address
References: <20190710072524.65953-1-maowenan@huawei.com>
        <609fa4ae-7210-7758-c8ff-1b06492356e1@huawei.com>
Date:   Wed, 24 Jul 2019 08:42:42 +0300
In-Reply-To: <609fa4ae-7210-7758-c8ff-1b06492356e1@huawei.com>
        (maowenan@huawei.com's message of "Wed, 24 Jul 2019 09:32:13 +0800")
Message-ID: <878sso0yzx.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

maowenan <maowenan@huawei.com> writes:

> gentle ping...

I don't apply patches during the merge window, so you just have to wait
untill I'll open wireless-drivers-next. And this for
wireless-drivers-next, not net-next.

-- 
Kalle Valo
