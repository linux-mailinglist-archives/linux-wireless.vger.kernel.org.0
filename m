Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6C72E31
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfGXLuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:50:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51978 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbfGXLuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:50:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E109660DB6; Wed, 24 Jul 2019 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969014;
        bh=gt+ADqOh2d7rIcaOLEb4LsHrAeCuWPlDK1YzVUX+rFk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SfNFlddDb2QXInOZFbHcehkjvHqnmLRF7n2SJgKXS9YByj/haaDjk9kMfb5dbhZnm
         kyeymYWyUZCuKJZx6mK6ZXSeNzqkdl7QtjPgx/3fuVnadRhLd7TAeSW7SxhgRlA4XQ
         dy4lNsxYbgI3u1tukvCsPmwgS3JoGI4eRgSIpbXg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F7B660AA8;
        Wed, 24 Jul 2019 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969014;
        bh=gt+ADqOh2d7rIcaOLEb4LsHrAeCuWPlDK1YzVUX+rFk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=iOhZX0ZWMzsc8MLzFRU2dcguzaRBpTcF+nBrYtul03UNCJwwitn0lryZLVfP5JrYa
         UoSbNmJYq9ucFSfwfuEISsMUGVBMRftzzYahAlXTZeFVK2qwEViGbkHFqWdRjUMvUB
         EEDe7Whlgn6H6WK88mId7+iaCqq1h7JtjeBt7L5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F7B660AA8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] brcmfmac: add 160MHz in chandef_to_chanspec()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1562834732-31508-2-git-send-email-arend.vanspriel@broadcom.com>
References: <1562834732-31508-2-git-send-email-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724115014.E109660DB6@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:50:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> The function chandef_to_chanspec() was not handling 160MHz bandwidth
> resulting in wrong encoding of the channel. That resulting in firmware
> rejecting the provided channel specification.
> 
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

3 patches applied to wireless-drivers-next.git, thanks.

f491645f0394 brcmfmac: add 160MHz in chandef_to_chanspec()
011a56a3336a brcmfmac: enable DFS_OFFLOAD extended feature if supported
fa9050927fa8 brcmfmac: allow 160MHz in custom regulatory rules

-- 
https://patchwork.kernel.org/patch/11039449/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

