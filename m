Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85C81A81D4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437988AbgDNPQC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 11:16:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18914 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407293AbgDNPGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 11:06:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586876804; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=uMcF+KDlK+3Q2CkUKTEO61BFIcOZRk8m+cBX00kOaQE=;
 b=ATWCGJ4ABiVRTmQVe3uGHZ/Xt/gmvQY2ZAobYKlrxbDuCOB1ojJs8RLEYYMOg6KRNHmc/h+F
 uehNhCpjh1PO23RMu9h95qeixnjN3T7X9yEcSt2NJteete2MVa5LMndL6O1h48llHYbI2hG5
 BxPSHFU0/+D09Wfzv/GCnNhDbJ0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95d184.7f9b889b2180-smtp-out-n05;
 Tue, 14 Apr 2020 15:06:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02D37C432C2; Tue, 14 Apr 2020 15:06:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F31F5C433CB;
        Tue, 14 Apr 2020 15:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F31F5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] p54usb: add AirVasT USB stick device-id
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200405220659.45621-1-chunkeey@gmail.com>
References: <20200405220659.45621-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Giuseppe Marco Randazzo <gmrandazzo@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414150644.02D37C432C2@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 15:06:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> From: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>
> 
> This patch adds the AirVasT USB wireless devices 124a:4026
> to the list of supported devices. It's using the ISL3886
> usb firmware. Without this modification, the wiki adapter
> is not recognized.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com> [formatted, reworded]

Patch applied to wireless-drivers-next.git, thanks.

63e49a9fdac1 p54usb: add AirVasT USB stick device-id

-- 
https://patchwork.kernel.org/patch/11474885/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
