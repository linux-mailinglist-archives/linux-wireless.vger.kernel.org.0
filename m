Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD90109877
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 06:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfKZFVg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 00:21:36 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:45928
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfKZFVf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 00:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574745695;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=Q30J46XsTfdEK32DLeFx32uQEy6aKHBQkOg8LyiaJ/g=;
        b=jMSromTT4wGbqvBiGV93nCwO+mEMc/kpNfK+oxlkEx/08v4q682z65gDD5nH/B+h
        Z4ch9CCOMF2a689j2ycXc+Qu5A/4xll8f5G9XON8Mvq1U7lhxqooMrQtTLs9Vfuu03o
        UfqSK3kfugjZIo9KXsAWZlVzScJjjceg0bj74P40=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574745695;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=Q30J46XsTfdEK32DLeFx32uQEy6aKHBQkOg8LyiaJ/g=;
        b=EIbQegTp2O8Hd3lnLMdaKslAzKw+hR8KmFAAGM74WfSmjJeK0AczEMBbj2quSchB
        z86dssDXpivxLrUTyrfiZdyakR/gV/d5ZDUqRcAF/FzC3XXPBKQwBxRwzir9b7rqlDf
        +V7TCDdI1OCsBwDjQPPHhexy6WZq11nUBSeR2+AI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC332C447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mt76: Off by one in mt76_calc_rx_airtime()
References: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
Date:   Tue, 26 Nov 2019 05:21:35 +0000
In-Reply-To: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain> (Dan Carpenter's
        message of "Tue, 26 Nov 2019 07:49:56 +0300")
Message-ID: <0101016ea6286267-0ecbbd3d-bc20-4e42-9f86-34f3d8fc41b6-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.26-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> The sband->bitrates[] array has "sband->n_bitrates" elements so this
> check needs to be >= instead of > or we could read beyond the end of the
> array.
>
> These values come from when we call mt76_register_device():
>
> 	ret = mt76_register_device(&dev->mt76, true, mt7603_rates,
> 				   ARRAY_SIZE(mt7603_rates));
>
> Here sband->bitrates[] is mt7603_rates[] and ->n_bitrates is the
> ARRAY_SIZE()
>
> Fixes: 5ce09c1a7907 ("mt76: track rx airtime for airtime fairness and survey")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Should I queue this to v5.5?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
