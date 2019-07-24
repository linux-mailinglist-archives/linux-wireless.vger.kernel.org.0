Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42972E39
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfGXLxc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:53:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfGXLxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:53:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1FF6D60364; Wed, 24 Jul 2019 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969211;
        bh=TOQo6XT631PxVxKd3qrQhIHtvrPLQxxUTLLRFeKArvk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jZybo3oCet0MMlH6H1QOKNsU6z5yd+Ax0ntQqyLO2N0hKs5vYsheshAq86bxmkJ26
         4lGjYKgJ+SLtPRgZqtWS657GcHkZvW9rc4giqiIczNHvlRJdThIjUvcWZ4p+T8uoka
         aYRBJs5tNLeIfgQN+svhniqX4gn/q1lWbNpysfqI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E70C260214;
        Wed, 24 Jul 2019 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969210;
        bh=TOQo6XT631PxVxKd3qrQhIHtvrPLQxxUTLLRFeKArvk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Ma2KLVZK8iPY8GRIAiD7duAFfoeXozRWxDaTWfu40vJEJZj0otBGgPW+yusss9Sge
         Mm2FH7AMAK1fURZCZWMIlHDX75oRo/i+EEUq0yXRg+9DT870KKXMr3UjS4mRbNEg29
         UdNKWq3+AbQweZvJJG93PaOD0MpOVYM/+Oc4MoC0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E70C260214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: debug: dump tx power indexes in use
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1563254900-9219-1-git-send-email-yhchuang@realtek.com>
References: <1563254900-9219-1-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724115331.1FF6D60364@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:53:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Add a read entry in debugfs to dump current tx power
> indexes in use for each path and each rate section.
> The corresponding power bases, power by rate, and
> power limit are also included.
> 
> Also this patch fixes unused function warning.
> 
> Fixes: b741422218ef ("rtw88: refine flow to get tx power index")
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

8812022cb2fd rtw88: debug: dump tx power indexes in use

-- 
https://patchwork.kernel.org/patch/11045263/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

