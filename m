Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFAC58796
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0Qtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 12:49:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0Qtv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 12:49:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0EE176038E; Thu, 27 Jun 2019 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561654190;
        bh=8JZkDFu2jtzrh0ldksJ2xJXeoAvy1jIExffeCyNuRTk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NWXC7MKj7KX6AsKC2tc417ca6gaJrqpfVjXUJfNX34YnVUYG+bD/4XjfPF6ECsG/a
         GBRRAk2hLLBYiP96UbWq/cvgup1dikrK8g3l1MEHypmAea6HED9ybXqC7K5cYiuupt
         6F5QAPoj9ELNjSnTCVEERHB41RhhrIm5AdJXyjO8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A29E60159;
        Thu, 27 Jun 2019 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561654189;
        bh=8JZkDFu2jtzrh0ldksJ2xJXeoAvy1jIExffeCyNuRTk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=nzVqLoff9jhWb78toT0f9jQ8Adnzo2z5C/KKL09GMAH9H98orrq+2Nya/M7gH5Unb
         EFAYxeZl18kJSr+YO+Wp+VQ5dcuqKPhk0HAhkEB60J4zRFsv0toL1eyL0xIK6R/2Hw
         KAcmG0RglE9f12XfuiR5gCLOs4uIPbmgdLKseck0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A29E60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 wireless-drivers] mt76: usb: fix rx A-MSDU support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <7d93cba766b5a0220c86fa900f9d29048d67e02c.1560607085.git.lorenzo@kernel.org>
References: <7d93cba766b5a0220c86fa900f9d29048d67e02c.1560607085.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sgruszka@redhat.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627164950.0EE176038E@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 16:49:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Commit f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes
> for rx") breaks A-MSDU support. When A-MSDU is enable the device can
> receive frames up to q->buf_size but they will be discarded in
> mt76u_process_rx_entry since there is no enough room for
> skb_shared_info. Fix the issue reallocating the skb and copying in the
> linear area the first 128B of the received frames and in the frag_list
> the remaining part
> 
> Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

2a92b08b1855 mt76: usb: fix rx A-MSDU support

-- 
https://patchwork.kernel.org/patch/10997119/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

