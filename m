Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B1154F8D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfFYNCe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:02:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfFYNCd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:02:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8582F608A5; Tue, 25 Jun 2019 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467752;
        bh=goyYnP7cy9ipwr1KfMe6m/clr8EHIElroEeXKJsdJfc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JG21v+zjk3kqYzQF2gVFpo7X+fkwF0+mtIVUpB8KB00hNYtX24sBNWB2ahXeiuo21
         WrC8zZhbl2orzADeSc2wiyN0f+PHlnhQIrGfXzu3GYSvNG3bixz0Eashd2SZzrbZA1
         6MSpAJnKdrSEuBWQqxvNJG6PN3SQPy3Sw4wQ49YE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E59BE601B4;
        Tue, 25 Jun 2019 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467751;
        bh=goyYnP7cy9ipwr1KfMe6m/clr8EHIElroEeXKJsdJfc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=B2V+cB6nj33RpaDjy7APHFG83RyGsW9OkR77WdH6hG7d/o7E/1FOUn8tFl4Bv5jvO
         tPt/T2wkolZ0S5LS2bVxeclGVg0XwHQ5QDHQdTwyuaQE27LXgaBLiHUg8Re3CKAmrd
         1Gib72gS7qW19WmO78wHcaI4eYrS6O2y+gSOSRys=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E59BE601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: fix failure to set multiple fixed rate
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1559117608-11117-1-git-send-email-miaoqing@codeaurora.org>
References: <1559117608-11117-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625130232.8582F608A5@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:02:32 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> Currently, below fixed rate commands are broken,
> iw wlanx set bitrates legacy-<2.4|5> ht-mcs-<2.4|5> vht-mcs-<2.4|5> \
> <NSS:MCSx>
> iw wlanx set bitrates legacy-<2.4|5> <legacy rate> ht-mcs-<2.4|5> \
> vht-mcs-<2.4|5> <NSS:MCSx>
> 
> There are two methods to set fixed rate, both failed,
> - Use vdev fixed rate command
>   This command only support one single rate, but it's broken due to
>   mac80211 change commit e8e4f5280ddd ("mac80211: reject/clear user
>   rate mask if not usable"), which requires user to specify at least
>   one legacy rate. So we can't use this command to set ht/vht single
>   rate any more.
> - Use peer_assoc command
>   This command can update rx capability for multiple rates, it will
>   work fine for ht mcs rates, as each supported mcs can be advertised
>   in ht_mcs index mask. But this will not work with vht rates because,
>   as per the vht mcs capability advertisement, there are only two bits
>   to indicate the supported mcs. E.g. only support 0-7, 0-8, 0-9.
> 
> So introduced new WMI command: WMI_PEER_PARAM_FIXED_RATE. After peer
> assoc, the peer fixed rate cmd will work for that specific peer.
> Remaining peers will use auto rate. If both vdev fixed rate and peer
> fixed rates are given, peer fixed rate will take effect to peers for
> which this cmd is given. Remaining peers in that vdev, will use vdev
> fixed rate.
> 
> Tested HW: QCA9984
> Tested FW: 10.4-3.9.0.2-00035
> 
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

8b97b055dc9d ath10k: fix failure to set multiple fixed rate

-- 
https://patchwork.kernel.org/patch/10966425/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

