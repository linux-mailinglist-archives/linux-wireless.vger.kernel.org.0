Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9AB55002
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfFYNOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:14:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfFYNOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:14:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 395956070D; Tue, 25 Jun 2019 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468491;
        bh=XCoX9Dil4UwfqX5wbBt4vZpqhxU4FoaYfE6brIoyU/k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=H7qmR58hT99aG05dNuOI9lGapd2up4dWgH9MFA/nhuhh1odTtjIwMceQTH4gj/GDW
         UJg0DBKAhpa6TpWU3VLDvDTPU3aYupP0rYwRkdRwLZvYJQpqKIQ1zqoEcKjRWeMzOL
         FUjJIJ9S0PqsVOGnaaomVoPQqaC4oXv8dQZnRpOs=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E80FE606DC;
        Tue, 25 Jun 2019 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468490;
        bh=XCoX9Dil4UwfqX5wbBt4vZpqhxU4FoaYfE6brIoyU/k=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=pBTD6yDpjlLRMQBhidbXWeekPKFMgNS4DU7EUmsDtYZEfxC3qS3CdNd09xv4TtjCt
         +83Gyz0K2d2ZrME2qQtBNgsrcsIe/TX1Epm8zydVkvUuyZ5/oMh/2uq69JpKKHqQtR
         gjcRP3OEiYzoUOHnwUvgj6E2mIdTJyon6hU2p4ZE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E80FE606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] ath10k: add support for controlling tx power to a
 station
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1559209638-23887-1-git-send-email-bpothuno@codeaurora.org>
References: <1559209638-23887-1-git-send-email-bpothuno@codeaurora.org>
To:     Balaji Pothunoori <bpothuno@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ashok Raj Nagarajan <arnagara@codeaurora.org>,
        Balaji Pothunoori <bpothuno@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625131451.395956070D@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:14:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Balaji Pothunoori <bpothuno@codeaurora.org> wrote:

> This patch will add the support to control the transmit power for traffic
> to a station associated with the AP.
> 
> Underlying firmware will enforce that the maximum tx power will be based
> on the regulatory requirements. If the user given transmit power is greater
> than the allowed tx power in the given channel, then the firmware will use
> the maximum tx power in the same channel.
> 
> Max and Min tx power values will depends on no of tx chain masks,
> for QCA9984 allowed tx power range values from 6 to 23.
> 
> When 0 is sent to the firmware as tx power, it will revert to the default
> tx power for the station.
> 
> Tested Hardware : QCA9984
> Tested Firmware : 10.4-3.9.0.2-00046
> 
> Co-developed-by: Balaji Pothunoori <bpothuno@codeaurora.org>
> Signed-off-by: Ashok Raj Nagarajan <arnagara@codeaurora.org>
> Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

33410a51468f ath10k: add support for controlling tx power to a station

-- 
https://patchwork.kernel.org/patch/10968517/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

