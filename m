Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429E254F6F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfFYM4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:56:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfFYM4m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:56:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 347B0601E7; Tue, 25 Jun 2019 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467401;
        bh=FTPTJcuABQER6lKniScqhPccKzGnG+MXaGguW45oagg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QSiYlBRKB4Hv8AnGJHYknXb0zK0/iZeMK1+s2gwENOToiViBl1nixYF98Xyz2Z174
         Gt7Hmr3eAjAeVYEIbT5ICntK+9sHMKr9m+s+VOVOzt2whHqmhCGaNJlX/6j3T7BwUk
         /T11D50Fq+Ephd/pKIYUwWwyMOf+fiJcwgJ/63H4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 604B960300;
        Tue, 25 Jun 2019 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467400;
        bh=FTPTJcuABQER6lKniScqhPccKzGnG+MXaGguW45oagg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=AMsOKW0frEvliFqXooRtEoMC5u8hmXYuifdQsCM85ZOnF0A4xxVm6UbYFuAyvIUDt
         YC/EHdzZ6uiD6NqJL0QIqfC6srSedR9yyMgB7yQK04M9VEfc9giJKuP/JG/UMWwFky
         kxJ76+bYdvSYeMlsdxhJsqEBTIbFCsOQzSKy5+L4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 604B960300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: enabling tx stats support over pktlog
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1557759187-23910-1-git-send-email-bpothuno@codeaurora.org>
References: <1557759187-23910-1-git-send-email-bpothuno@codeaurora.org>
To:     Balaji Pothunoori <bpothuno@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Balaji Pothunoori <bpothuno@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625125641.347B0601E7@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 12:56:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Balaji Pothunoori <bpothuno@codeaurora.org> wrote:

> For QCA988X target, pktlog gives details of the tx bitrate
> which is used in the driver for station info.
> 
> Enabling pktlog by default will cause more interrupts
> in target to host CE pipe, which can impact more CPU usage
> for targets ex:WCN3990 and also not required for all other
> platforms (eg: WCN3990), for getting tx bitrate.
> 
> Enable pktlog only for QCA988X based on hardware params.
> 
> Tested HW : WCN3990
> Tested FW : WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Fixes: e8123bb74c4e ("ath10k: add per peer tx stats support for 10.2.4")
> Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4fa42adebe5b ath10k: enabling tx stats support over pktlog

-- 
https://patchwork.kernel.org/patch/10941167/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

