Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA583196
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHFMmk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:42:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMmk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:42:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 631BB609F3; Tue,  6 Aug 2019 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095359;
        bh=24n6nGB7UDVWaPSMg6sY88QQSV8btX1iJq3N9SvWV1A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gJusRDoK+UdAhvzI255hp8D3iryf5Q04gztG2PqQYL2OP2e+Tce7APgyOvvJk9Wiy
         RWbnXmtutJ2NXGqCFJ+6Nk6ZfMsofV/raQXBXEyOH4pkezSv9k+nVpTMkKOtQoEJ9Y
         cnpUhcKplcB3we5SrYRJZonLT+ZvgOpRwL+WlABg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15C976038E;
        Tue,  6 Aug 2019 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095359;
        bh=24n6nGB7UDVWaPSMg6sY88QQSV8btX1iJq3N9SvWV1A=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=IxmFcMjBXZNQvPBIlGRaRY4eiOZJulnTiT+80gdYD/7x6+PPUGL4L9JWJp8WSS+jg
         jNEzN+bp788iPhMUbFuK2oUsH4miWaMx8K8xtU6HKUDHu2y9h2RjBaiSK6qJNRFRgw
         L3E6MTfYIdiwEhOfRAtWiOe1oOvS/Zd8c7C4wo0Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15C976038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] rtw88: allow c2h operation in irq context
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1564575767-27557-2-git-send-email-yhchuang@realtek.com>
References: <1564575767-27557-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <sgruszka@redhat.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806124239.631BB609F3@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:42:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Some of the c2h operations are small and can be done
> under interrupt context. For the rest that requires
> more operations or can go sleep, enqueue onto c2h queue.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

3 patches applied to wireless-drivers-next.git, thanks.

0d762f031d70 rtw88: allow c2h operation in irq context
713a30de45a2 rtw88: enclose c2h cmd handle with mutex
4136214f7c46 rtw88: add BT co-existence support

-- 
https://patchwork.kernel.org/patch/11067657/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

