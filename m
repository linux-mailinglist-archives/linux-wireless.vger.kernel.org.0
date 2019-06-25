Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B396254FE8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfFYNLe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:11:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYNLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:11:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 23AD161A89; Tue, 25 Jun 2019 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468293;
        bh=+2UpMqcLGW54KLTCIw1QJtWU/Gfje6EkNK0xBkaLM2I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=e3goeRFmnUIp/N5Q9+rUqbIaaCCplqDetjE/uBaOpLHrGlrQj+OCGpsJClbnaCf9L
         advuP7x13JHlmVOhQnWUCCdc+9FBVCUop082MqhBQzQKvXfXX3qMdhf57bLcuUCIy9
         x9QOI8WD1PmFbJcLNHFrxh3xYFEDKi6EllkOKmmc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 254A461A7A;
        Tue, 25 Jun 2019 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468292;
        bh=+2UpMqcLGW54KLTCIw1QJtWU/Gfje6EkNK0xBkaLM2I=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=e+kT3sTyWdQFL0g14lBsvEYQuw0fJ3hlxGK3PQVKzR3wneGjIVm4flMxMD7IbqOCl
         6MbUGTz6IQI4r8pb2FCALvQVB4R864Agb0xb/KhhyNXbdxlPvB+MC7pzR+XZmb2tfp
         OWny185+tJ8GA49RPZ7tLX8t7Vpx6Fv8sENqBN70=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 254A461A7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: wait for vdev delete response from firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1550411479-32253-1-git-send-email-pillair@codeaurora.org>
References: <1550411479-32253-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625131133.23AD161A89@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:11:32 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> When we add an interface immediately after removing
> the interface the vdev deletion in firmware might not
> have been completed. We need to synchronize the vdev creation
> with the firmware.
> 
> Wait for vdev delete response from firmware when we
> remove an interface.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fe36e70f766e ath10k: wait for vdev delete response from firmware

-- 
https://patchwork.kernel.org/patch/10817047/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

