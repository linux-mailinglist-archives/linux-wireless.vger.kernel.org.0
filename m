Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932A3265D14
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgIKJ4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 05:56:41 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:59240
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgIKJ41 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 05:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599818186;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=xcw6hRQLAch8VNhgrocyLwZ8Ck0KQMacj+tGMTKch1w=;
        b=QCqBpvJfyFuoHTL3AHVZOX5zyT1jZHsn7e60afrvNn+YKUI2bzybWgKTLKqbF2EF
        2cE6S/5PL86J38VRCvHHwmywzsx/SBhyALsywIoSLOfovdGyIIt+qkywNUpxEKEiSY6
        WxBmt2ke0EDY054SO1r33sKXImnsWDaCREj8DqXc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599818186;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=xcw6hRQLAch8VNhgrocyLwZ8Ck0KQMacj+tGMTKch1w=;
        b=ij+m4zZW8C+TP2Aedvny9vtfisaUGYbHE0IVF0N6gAD+Omb77scUnd0F/cRcFTud
        u1aB2y9vb1P5u18huZQru5funsK1CUiDDasc8PaKmMEORXauWgsyCfru4pHh7Me2lfC
        wi5Yf6FDLNN3I0Mb4vw2DwCffoCl0/8s31ex3VZ0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 477A4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 1/3] dt: bindings: net: update compatible for ath11k
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <010101746cb6751a-ca300933-1174-4534-a01b-b1dbf1c1f305-000000@us-west-2.amazonses.com>
References: <010101746cb6751a-ca300933-1174-4534-a01b-b1dbf1c1f305-000000@us-west-2.amazonses.com>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <010101747c983db0-a308ddba-c936-49bd-b511-78107c290572-000000@us-west-2.amazonses.com>
Date:   Fri, 11 Sep 2020 09:56:26 +0000
X-SES-Outgoing: 2020.09.11-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> Add IPQ6018 wireless driver support,
> its based on ath11k driver.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

7b5bd15d23c5 dt: bindings: net: update compatible for ath11k
967c1d1131fa ath11k: move target ce configs to hw_params
b129699a0c7b ath11k: add ipq6018 support

-- 
https://patchwork.kernel.org/patch/11762811/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

