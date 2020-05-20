Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FC1DB5C4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgETN4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 09:56:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:46892 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgETN4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 09:56:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589983000; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=1f2c/IoPMuBpYr8x0BXg13qmCOpDEFtIr7XsM2sZm6k=; b=QUO+Pub7ayxBdcO0ep6w3GZsPuBfZc7bJfCkmMaf1Buvm9DnS1dBgAs8I77E9rxXireyaLIW
 tm05mYE5QB7HOd5K1oIZvEJdIoMRm9lXLcSAx12NBpmAkO0gpePMJoXTsjZbNMU5SYugwhLp
 0qvu+jdeYF/u6IgaV3sFAKSIp5I=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec53706.7f1287a02b20-smtp-out-n05;
 Wed, 20 May 2020 13:56:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61ECFC433CB; Wed, 20 May 2020 13:56:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D485C433C8;
        Wed, 20 May 2020 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D485C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     John Deere <24601deerej@gmail.com>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv4] ath10k : Fix channel survey dump
References: <1588820612-15884-1-git-send-email-vnaralas@codeaurora.org>
        <bee1439c-de98-dbf0-ee82-88620ecc560a@gmail.com>
        <f3da0683-1e1e-6c67-08bb-2147e745a317@tu-ilmenau.de>
Date:   Wed, 20 May 2020 16:56:15 +0300
In-Reply-To: <f3da0683-1e1e-6c67-08bb-2147e745a317@tu-ilmenau.de> (Markus
        Theil's message of "Wed, 20 May 2020 08:48:48 +0200")
Message-ID: <87eerebthc.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Markus Theil <markus.theil@tu-ilmenau.de> writes:

> I've seen this patch got dropped again from the ath.git pending branch.
> On which hw/firmware combination did it fail to operate?

It's deferred at the moment:

https://patchwork.kernel.org/patch/11532357/

The conclusion from the other thread was not clear for me, so I put it
into deferred and will take a closer look once I have time.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
