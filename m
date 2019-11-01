Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F8EC15A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 11:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfKAKqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 06:46:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbfKAKqL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 06:46:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9085160B10; Fri,  1 Nov 2019 10:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572605170;
        bh=mD17HMiTAqwNMwUmwiWnT9qZRY7Cxuz5B66kJb27Jw8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=esid/7l385E1dloDm5OUnnnl3BvWFqxUZPFkAdcxQsz96LU6kK5Hg40Vranp7zM0N
         lx4el9S6mfscBm54aZy7RaDlz+7RITjXfCygPtPSFZQsxIeKH1m2Fa8r6s9E68cWaB
         uU1Xcr0u8P2ennSsxwlnEI6vvpYCVNr+m/nhCTnw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (176-93-46-192.bb.dnainternet.fi [176.93.46.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F5CB60AD7;
        Fri,  1 Nov 2019 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572605170;
        bh=mD17HMiTAqwNMwUmwiWnT9qZRY7Cxuz5B66kJb27Jw8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=esid/7l385E1dloDm5OUnnnl3BvWFqxUZPFkAdcxQsz96LU6kK5Hg40Vranp7zM0N
         lx4el9S6mfscBm54aZy7RaDlz+7RITjXfCygPtPSFZQsxIeKH1m2Fa8r6s9E68cWaB
         uU1Xcr0u8P2ennSsxwlnEI6vvpYCVNr+m/nhCTnw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F5CB60AD7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Eduardo Abinader <eduardoabinader@gmail.com>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wcn36xx: fix typo
References: <20191101095200.5778-1-eduardoabinader@gmail.com>
Date:   Fri, 01 Nov 2019 12:46:06 +0200
In-Reply-To: <20191101095200.5778-1-eduardoabinader@gmail.com> (Eduardo
        Abinader's message of "Fri, 1 Nov 2019 10:52:00 +0100")
Message-ID: <871rur27td.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Eduardo Abinader <eduardoabinader@gmail.com> writes:

> ---
>  drivers/net/wireless/ath/wcn36xx/hal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

s-o-b missing, please read:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#signed-off-by_missing

-- 
Kalle Valo
