Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF39F4344
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfKHJ3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 04:29:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbfKHJ3k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 04:29:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3667B60FFB; Fri,  8 Nov 2019 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205379;
        bh=k+iIfNwlhzCt1VhzT2VerBgeFgQt/+b4y91tPYbvheI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=o1FA2BSsQC/y1dSWUaYHZM23qNg7rx557vk4ypVoNPWal8OWK+QsiLlysNbZaI45w
         aaZ+CT01MjGokwHVCeamjTFqDuge/TxrH7KOdO+q578yj+CAU4ARXd4WxaxPXW2nPv
         uv+UFymR0WW+PbnwOxSCazRyNTi58mICSsi6lfZc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC2B960A7E;
        Fri,  8 Nov 2019 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205376;
        bh=k+iIfNwlhzCt1VhzT2VerBgeFgQt/+b4y91tPYbvheI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YTjNPOxMfWAsYwvBWYf2aA/nvCXLi0OPOJV9yIoZyEiHSim1P6VrqDxksqhtwoX0P
         rh75HP3V5AeIuKarXFPOJEMQ63rPEeaDs6Sml/snIPnP3kZs5riMKvVOLlP8Rwut6E
         +Aub7kcgoExJBUWvfqPCnSEaPiYVOFu76YQAzKNk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC2B960A7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: add large size for BMI download data for SDIO
References: <20191107100809.17982-1-wgong@codeaurora.org>
Date:   Fri, 08 Nov 2019 11:29:31 +0200
In-Reply-To: <20191107100809.17982-1-wgong@codeaurora.org> (Wen Gong's message
        of "Thu, 7 Nov 2019 18:08:09 +0800")
Message-ID: <877e4awwas.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> Download firmware time cost of SDIO is too long, it is about 480ms,
> add large size 2048 bytes for BMI download for SDIO chip, its time
> cost will reduced to 240ms.
>
> This will optimize the download firmware time cost.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +int ath10k_bmi_large_size_lz_data(struct ath10k *ar, const void *buffer, u32 length)

You are calling this only from bmi.c so in the pending branch I made
this static and renamed to ath10k_bmi_lz_data_large().

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
