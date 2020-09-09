Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078CA262887
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIIH1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 03:27:06 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:47520
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgIIH1D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 03:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599636423;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=cmqFT3PAcztcvALtRQSGtKjbxrz7OuPiszNQsmcX+fs=;
        b=m6hVITHdGyc4b89HPo++O3gsFcsVcWcEE9fYrTpudH5mb6axqv8wNh4ShbbFyvCi
        WWSwnejxhuC94yeptChdmaM/c8g7WAEu6pUn+gmR7LT5y3NTcLp3iRnlga2w2YUQp2k
        emp76NFII3yXtUvmJ7Ke/fkeNKNIZevTC9jMY0J0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599636423;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=cmqFT3PAcztcvALtRQSGtKjbxrz7OuPiszNQsmcX+fs=;
        b=QpWXXuEXD3S2op37pBbz/XYqoS5sdHFc97/JgKiqJ6yH95LHIt4n2Nj4nPtghBoN
        xIxcVwp9+myYygG9dIXUfCL2fgpdEmYLcaGWlBHhjFsi/dvozDb7UG1tfwNcK7P3USW
        y8CHf5rmDbZWmZ/99edRrtlcb8nUeXoI2l06yn8A=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9065FC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8723ae: Delete a stray tab
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200905124758.GB183976@mwanda>
References: <20200905124758.GB183976@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <0101017471c2c0d1-407bc407-d1d8-41a6-b6a8-3c17f5ac4659-000000@us-west-2.amazonses.com>
Date:   Wed, 9 Sep 2020 07:27:02 +0000
X-SES-Outgoing: 2020.09.09-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This line is indented too far.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers-next.git, thanks.

587231ee81d6 rtlwifi: rtl8723ae: Delete a stray tab

-- 
https://patchwork.kernel.org/patch/11759069/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

