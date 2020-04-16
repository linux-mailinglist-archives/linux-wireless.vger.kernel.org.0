Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D121ABA21
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439505AbgDPHkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 03:40:04 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:19130 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439257AbgDPHkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 03:40:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587022802; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cBfdv/oMHwQE0oIJj8A62AcKrW1mPvlZxyEt626nsoU=;
 b=Ii7Sd2sQ+nLOiEZ9IuIhJORbmNYdYpL7a6zkCNvHDvcB8XjG6bPr1Sj+PnMbL9FKaAYN3NCo
 tPt1OFYujAUAJ+7kSYxMshpow5KXFDGONhb/IBHzC1DuXUJtMS6GhD6PXF2ntm79Ku7HsvOk
 TTXVltMNPjpTE4NdAXfY57i44zY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e980bc7.7ff82ffe77d8-smtp-out-n03;
 Thu, 16 Apr 2020 07:39:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 775FEC433CB; Thu, 16 Apr 2020 07:39:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B515BC433F2;
        Thu, 16 Apr 2020 07:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B515BC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] rtw88: sar: add SAR of TX power limit
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200207092844.29175-2-yhchuang@realtek.com>
References: <20200207092844.29175-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200416073951.775FEC433CB@smtp.codeaurora.org>
Date:   Thu, 16 Apr 2020 07:39:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> Originally, there are three factors of TX power:
>  1) TX base power, calibrated manually and programmed in efuse.
>  2) By-rate power, an offset to increase power depends on TX rate.
>  3) TX limit power, an offset to contraint the max power.
> 
> So, driver can get the TX power index by using:
>     TX_POWER_IDX = tx_base_power + min(by-rate, limit)
> 
> To take SAR into consideration, we can treat it as another limit of
> the TX power. Then driver can get the TX power by using:
>     TX_POWER_IDX = tx_base_power + min(by-rate, limit, sar)
> 
> Note that the values stored in driver are not presented in dBm, so
> driver needs to also convert the power limit indexes of SAR with
> tx_scale_factor, then get the difference to the TX base power.
> rtw_phy_set_tx_power_sar() will convert the values of SAR power in unit of
> 0.125d Bm (sar_q3) and store them in tx_pwr_sar_{2,5}g[regd][path][rs][ch].
> 
> Since certain SAR tables have single one table that isn't regulatory domain
> specific, parser can apply to all 'regd' or only one domain RTW_REGD_WW
> that SAR TX power limit can be applied no matter which regulatory domain
> is selected. Because driver get 'sar' argument by
> rtw_phy_get_tx_power_limit() with rule
>     sar = is_existing(tx_pwr_sar_{2,5}g[regd]) ? tx_pwr_sar_{2,5}g[regd] :
>           tx_pwr_sar_{2,5}g[RTW_REGD_WW];
> 
> There are various sources of SAR table, but it is expected to adopt only
> one source. So, save current source of rtw_sar_sources to prevent more
> than one source are adopted.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

I'll drop these from my queue now. Please resend once there's a
concensus what interface to use.

7 patches set to Changes Requested.

11370071 [1/8] rtw88: sar: add SAR of TX power limit
11370073 [3/8] rtw88: vndcmd: sar: Apply SAR power limit via vendor command
11370075 [4/8] rtw88: sar: Load static SAR table from ACPI WRDS method
11370083 [5/8] rtw88: sar: Load dynamic SAR table from ACPI methods
11370079 [6/8] rtw88: sar: apply dynamic SAR table to tx power limit
11370081 [7/8] rtw88: sar: add sar_work to poll if dynamic SAR table is changed
11370085 [8/8] rtw88: sar: dump sar information via debugfs

-- 
https://patchwork.kernel.org/patch/11370071/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
