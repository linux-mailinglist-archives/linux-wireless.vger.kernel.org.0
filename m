Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5479CA6719
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfICLKt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 07:10:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfICLKs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 07:10:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA5B96085C; Tue,  3 Sep 2019 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567509047;
        bh=e46f/sfYUU6gRuBxbtyHzspyeyBgrkeiKivLylKM4uY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iX767W1HwQDkW3eZ6JnX8+VoS1fGWIPc30e0WiE+Wc+6PplKj3/vQNPapOr+WNRGK
         kbOgA7VetoMgTiVi/NeAXdndLAAzIuyoMocnOrb0Q8cp+jZ/Yu1udBU7rb1qr16lx4
         pkS256rIJcIJ+ynw7GuYxgWg/XoZYO5IyiTRlZtg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF2CA602A9;
        Tue,  3 Sep 2019 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567509047;
        bh=e46f/sfYUU6gRuBxbtyHzspyeyBgrkeiKivLylKM4uY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iX767W1HwQDkW3eZ6JnX8+VoS1fGWIPc30e0WiE+Wc+6PplKj3/vQNPapOr+WNRGK
         kbOgA7VetoMgTiVi/NeAXdndLAAzIuyoMocnOrb0Q8cp+jZ/Yu1udBU7rb1qr16lx4
         pkS256rIJcIJ+ynw7GuYxgWg/XoZYO5IyiTRlZtg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF2CA602A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <jano.vesely@gmail.com>,
        <linux@endlessm.com>, <briannorris@chromium.org>,
        <gojun077@gmail.com>, <drake@endlessm.com>, <davem@davemloft.net>,
        <jian-hong@endlessm.com>
Subject: Re: [PATCH rebased 0/2] rtw88: pci: interrupt routine improvement
References: <1567502047-24102-1-git-send-email-yhchuang@realtek.com>
Date:   Tue, 03 Sep 2019 14:10:42 +0300
In-Reply-To: <1567502047-24102-1-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Tue, 3 Sep 2019 17:14:05 +0800")
Message-ID: <871rwxr5xp.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> This patch set includes two patches to improve PCI interrupt routine.
> One is to reduce HW IRQ time, the other is to enable MSI.
>
> The patches can be found at:
> https://patchwork.kernel.org/patch/11114043/
> https://patchwork.kernel.org/patch/11126007/
>
> They were rebased properly to resolve conflicts.

In the future, please use version markings ("v2", "v3" etc) in the
Subject and not something like "rebased". This makes my life easier as I
can immeaditely see what is the latest version I should take.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
