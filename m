Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE335050C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 11:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfFXJB7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 05:01:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfFXJB6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 05:01:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8548D60A00; Mon, 24 Jun 2019 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561366917;
        bh=E9fqnXxcKT6YUNdWdNfr+WisxuiVl4ljHHUq0KSHV7I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NLOSybysEXadtkiC/m3KUROavL1PbAJ0xLRY24wNR6LRvC7fCgHzskIrAFH3aVQB6
         g8IJ3uD0NFNheaO6gpnV1wEA6jtZ/DIfVKJk6qn7bxYvhD72Heo1ry/1sWYhLGa0sx
         5Ggwuyqfoa9/kIZ8NrfCBBFRjHC5ZTY8Io6rihOI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FD90607C3;
        Mon, 24 Jun 2019 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561366917;
        bh=E9fqnXxcKT6YUNdWdNfr+WisxuiVl4ljHHUq0KSHV7I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NLOSybysEXadtkiC/m3KUROavL1PbAJ0xLRY24wNR6LRvC7fCgHzskIrAFH3aVQB6
         g8IJ3uD0NFNheaO6gpnV1wEA6jtZ/DIfVKJk6qn7bxYvhD72Heo1ry/1sWYhLGa0sx
         5Ggwuyqfoa9/kIZ8NrfCBBFRjHC5ZTY8Io6rihOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FD90607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     yegorslists@googlemail.com
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH] Add SPDX identifiers
References: <20190620130148.1674-1-yegorslists@googlemail.com>
Date:   Mon, 24 Jun 2019 12:01:53 +0300
In-Reply-To: <20190620130148.1674-1-yegorslists@googlemail.com>
        (yegorslists@googlemail.com's message of "Thu, 20 Jun 2019 15:01:48
        +0200")
Message-ID: <871rzjtkzi.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

yegorslists@googlemail.com writes:

> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> Software Package Data Exchange identifiers help to detect source file
> licenses and hence simplify the FOSS compliance process.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

For patches to iw it's good practise to prefix the title with "iw: ",
that way people can immediately see for which component it is. But no
need to resend because of this.

-- 
Kalle Valo
