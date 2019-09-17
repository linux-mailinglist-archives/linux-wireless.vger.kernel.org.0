Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF86B5009
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfIQOKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 10:10:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfIQOKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 10:10:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5E4A61570; Tue, 17 Sep 2019 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729453;
        bh=Xk7dfjNLZQgR9IBaMaMsVlGhXbY3AXcfDb6MCqDIqx8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LpbXuhrP6N6tjgbH7OEBDrdFaeFKDvd2FBtA5GN3aqApIeZFrbvCNhncbYhL0ewMR
         xqheY5ccG2ZAXa8y0Q5HpmpwKRoA/tdHsot+IlRjHL29OQa8ENPUCq4SLRT/Rbr7LX
         jqOxgP/iaaqjPE/yPFVsJz1cNaKzYQd931rhosi0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A6D6614BF;
        Tue, 17 Sep 2019 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729453;
        bh=Xk7dfjNLZQgR9IBaMaMsVlGhXbY3AXcfDb6MCqDIqx8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=i1ZeLKgeRartYsS0SCzpA2IuC4hLJRzZ7tFt/F7TKL+pZM8/NUj/Ni6JL5ar1Gwwg
         BisR10a9pwsBkDe04xq5PISkhE1u9xAYVVg0Sjkf9GDPSUvEUEN1vevT2B5OgK+5v6
         b4j1ajFhR/ra1SQ+ZZLoC3mvUazzQqwrsjrycyow=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A6D6614BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: revalidate the msa region coming from firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190731114220.22830-1-govinds@codeaurora.org>
References: <20190731114220.22830-1-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190917141053.A5E4A61570@smtp.codeaurora.org>
Date:   Tue, 17 Sep 2019 14:10:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> driver sends QMI_WLFW_MSA_INFO_REQ_V01 QMI request to firmware
> and in response expects range of addresses and size to be mapped.
> Add condition to check whether addresses in response falls
> under valid range otherwise return failure.
> 
> Testing: Tested on WCN3990 HW
> Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c41305993ff5 ath10k: revalidate the msa region coming from firmware

-- 
https://patchwork.kernel.org/patch/11067547/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

