Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A0260A3D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 07:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgIHFnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 01:43:11 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:41672
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728531AbgIHFnG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 01:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599543785;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=X3Ta7jxOFA+EjtY0N2rZzMQAHngY/WbCfr2e6T5ZDZE=;
        b=BoLJxJcJC2+WCODw0c59ZnQtuBMBQvSxqz6sMH/2tFLEOeWWmekzja7mI2aM1b8w
        LkelL/q/OOoND2jER1KsR7TNH1a+3EN5Rxds84IH3Yd+9mAMTeJOy2KoGJ1Nx7359p8
        YWX6mjeObm43L7UyG2jYlPLranSCGoXtmi9TzOMU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599543785;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=X3Ta7jxOFA+EjtY0N2rZzMQAHngY/WbCfr2e6T5ZDZE=;
        b=D7+ST11GwHOGiEuORTdRwP1SgYa20E3Iuy9pBHYJm9JNopRtHaMhAm1il/Q4id01
        A5fGiqRZ1eVb4Sh+2l4XQp/BVHWgMdLmSLCl9YvUHkAT+ozj9N+jBnSr8RXNQCJJump
        VDU4QrmNSHXaMUl4pxvqAm/CtlvPEvH8yIMwawc0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BEF2C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] dt: bindings: Add new regulator as optional property
 for
 WCN3990
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
References: <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <010101746c3d3841-1d9fea9b-b289-4fed-bffa-3b348536d69e-000000@us-west-2.amazonses.com>
Date:   Tue, 8 Sep 2020 05:43:05 +0000
X-SES-Outgoing: 2020.09.08-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Add an additional regulator supply as an optional
> property for WCN3990.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

8f1553694551 dt: bindings: Add new regulator as optional property for WCN3990
9e69fe31ca9a ath10k: Add support for chain1 regulator supply voting

-- 
https://patchwork.kernel.org/patch/11628309/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

