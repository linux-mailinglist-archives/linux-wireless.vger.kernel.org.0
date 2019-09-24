Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C278BC2A2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 09:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfIXH3r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 03:29:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfIXH3q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 03:29:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A6A660A60; Tue, 24 Sep 2019 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569310186;
        bh=ZQHvXAAvun/iyn5uhmzjBkfJfbkFM3xTxI3LqFhJM+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iw8R4wmlYulfyUDDUS9sUdF8h0FSIcxx1kc7Q3zcfIB0FWYWpmSt/KpZPtAYWtfeZ
         cA81VNgIX4TGdNLIcmphBfKia0b1Jc1bOmMkpzBFlSvSv/UqmJ0JJrCJvZgGcfxB9S
         1tL1+GeTtzH1GQ1cJYTL4ico2Q8yYX7LbHkEtO3M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CC06B60397;
        Tue, 24 Sep 2019 07:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569310185;
        bh=ZQHvXAAvun/iyn5uhmzjBkfJfbkFM3xTxI3LqFhJM+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4oqLPSt8/sFXt14eWYouqvSCFfemRcLbIHSygmBQLctVEp1Jg0uQRbNDU6UE5tKN
         79L4jH2WuwRxeRMyQtGCB8hg6wnMR6vRFRCsAXx3cEjXG1rEqFtRXuQfEx6K10GiEs
         fd/NvyOY9WB6lRXrjiEE55tgRDsNJgmXlVmcdVVc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Sep 2019 15:29:45 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 0/2] add fw coredump for sdio when firmware assert
In-Reply-To: <878sqe5jxw.fsf@codeaurora.org>
References: <1569241055-30816-1-git-send-email-wgong@codeaurora.org>
 <878sqe5jxw.fsf@codeaurora.org>
Message-ID: <5808a2de48a8dd42f973906a0f6891bf@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-24 13:42, Kalle Valo wrote:
patch v4 sent.
> So please rebase and resend.
