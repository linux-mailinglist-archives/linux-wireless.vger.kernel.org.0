Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C611CE21B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgEKR7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 13:59:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:47349 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbgEKR7Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 13:59:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589219963; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5aXebcZJuDYlRRGCTVoQmJ3tVogsWCDXYtgBFHy+GQg=; b=VeK4gTO/FJHJgBOrf0QmhfyjLT+wD74861lVEkEBaUninpPcNY3XDAn4+hk9NpMF0th5n3kR
 uCCGHqKNxlXrU9GYILdLmroqufNKo0pNp8K40bBqH29sLSod85G/f9d8Ac4JPJizx+LANXzZ
 IJPQv4w6gyi8wyZFZMtnOqtsatQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb99277.7f50564a26c0-smtp-out-n05;
 Mon, 11 May 2020 17:59:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCA2CC433CB; Mon, 11 May 2020 17:59:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 615CFC433F2;
        Mon, 11 May 2020 17:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 615CFC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] ath11k: Add PCI client driver for QCA6390 chipset
References: <20200508085850.23363-1-govinds@codeaurora.org>
        <20200508085850.23363-2-govinds@codeaurora.org>
Date:   Mon, 11 May 2020 20:59:14 +0300
In-Reply-To: <20200508085850.23363-2-govinds@codeaurora.org> (Govind Singh's
        message of "Fri, 8 May 2020 14:28:47 +0530")
Message-ID: <87h7wm4akt.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> writes:

> QCA6390 is PCI based 11ax chipset, add
> pci client driver for QCA6390 target.
>
> Signed-off-by: Govind Singh <govinds@codeaurora.org>

This patch had multiple problems, most important ones were:

* a break missing in ath11k_pci_probe()

* it's not possible to have static variables in .h files, I fixed by
  moving the ring variables to core.c in a separate patch:

  https://patchwork.kernel.org/patch/11541355/

* this patch didn't link (at least when compiling as modules), I fixed
  those by adding missing EXPORT_SYMBOL() macros

Please double check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=44a28b572070f578914367dc2469cef48ece13f4

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
