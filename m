Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E644260A72
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 07:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgIHFzv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 01:55:51 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:47902
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgIHFzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 01:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599544545;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=y2fsGjSMmSiGzjtinuFdAt/BiH6VpG/mknEx1+oppew=;
        b=hYt+mtYhhn0oWQ3sf/2gTMESGDUWh5JSfYcyaEMEAjgbI7dJ5gZvaaAEl7oFe2q3
        10e8+pEAmEeUIRrF7EPbbh7NGnweYYm1GpMO7NA+8jsmIASj7mNXqPJlwhaYbJqWfav
        o6KD/287D3ZIskUQjh46i8Bahus9BWPNW89BWyOQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599544545;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=y2fsGjSMmSiGzjtinuFdAt/BiH6VpG/mknEx1+oppew=;
        b=RelKfYr/1FSqSumzVaCNHlDPzoabDkAC/f69vcx9vREokHgusTrC4Z2sgyVKNaA3
        Zht+fuqIlEM8484vp8DXwdsaaYTpS5nEM1Fo4ChF0dzPSFNk6uaZecFa+IJLiB67ds4
        vXQaDMo9Twn29vIBCRJILvKLSDJChFbgVl7XTp00=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 899FCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] ath10k: allow dynamic SAR power limits to be
 configured
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1595823458-3926-3-git-send-email-wgong@codeaurora.org>
References: <1595823458-3926-3-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <010101746c48d1eb-9de480bb-d246-4e76-ba29-5e527a427ad3-000000@us-west-2.amazonses.com>
Date:   Tue, 8 Sep 2020 05:55:45 +0000
X-SES-Outgoing: 2020.09.08-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Add support for a vendor command for STATION, the command
> QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS which is already defined in
> git://w1.fi/hostap.git (src/command/qca-vendor.h). This allows user
> space to configure power limits for 2.4 GHz and 5 GHz bands.
> 
> ath10k set pdev parameter WMI_PDEV_PARAM_TXPOWER_LIMIT2G and
> WMI_PDEV_PARAM_TXPOWER_LIMIT5G to firmware, the 2 value will
> be used as one input source to affect the tx power.
> 
> When QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS set to ath10k, it will
> be saved the 2.4G and 5G limit value, If STATION is connected meanwhile,
> then the 2.4G and 5G WMI command will be set to firmware, otherwise
> it will not set to firmware at this moment. When STATION connect
> next time, it will set to firmware.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

The plan is to have a common API for SAR limits, not use vendor API.

Patch set to Rejected.

-- 
https://patchwork.kernel.org/patch/11686327/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

