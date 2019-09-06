Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E4ABA5E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404463AbfIFOKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 10:10:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbfIFOKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 10:10:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C1346115A; Fri,  6 Sep 2019 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779053;
        bh=pZrUubcES+XghCJoDqpsjKdHbbqNAWcea7tZv+3cJls=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PB/QzTq4vvnoX6Ec08VgumK/NnLndObCoK/SP7fODDhk+sZVv003IEVCVWyQTqbUE
         KtLs8oPTj7k/14GeD/m0c74sF5PzLdGUTldcWfOBaLn1n3bzAwMmH6iyNmnHF98wVd
         36ywf3ytQD3nhK8INWpvLMWiy3zWjjBf++Y/xPO0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88E1760770;
        Fri,  6 Sep 2019 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779052;
        bh=pZrUubcES+XghCJoDqpsjKdHbbqNAWcea7tZv+3cJls=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=hnssT2ywZ8Zee38Uk+I6TrEaVUE0ioMAujTXsXuBYJqM9159Z1NtNWJm75iZbz5pD
         TpQ5lrNxY8cQPSndyXx/QPyqy3xTNduh1DY6HWnpEnjPFpdfQ76YclZIrb4qO6ZnGV
         WP4klE3Sg4hK+fhOScfp8Qvci7auySvHpUdTED/8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88E1760770
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix seq_file memory leak
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190904141601.186107-1-weiyongjun1@huawei.com>
References: <20190904141601.186107-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190906141053.0C1346115A@smtp.codeaurora.org>
Date:   Fri,  6 Sep 2019 14:10:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> When using single_open(), single_release() should be used instead
> of seq_release(), otherwise there is a memory leak.
> 
> This is detected by Coccinelle semantic patch.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

eb9affaeff70 rtw88: fix seq_file memory leak

-- 
https://patchwork.kernel.org/patch/11130355/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

