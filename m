Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D204E2F5C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404036AbfJXKsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 06:48:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391340AbfJXKsW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 06:48:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C776C602DF; Thu, 24 Oct 2019 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571914101;
        bh=HvQo5UXy1E/mep6qtl/EvO49cQsF+lfjnJQRvD0/dKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OSNt4EdP8ojUPznDDXNKJS/mY6tfM+Pq8vaWYFzKHShTQSRMGz5TqzhjjiOzHP1Zk
         WV7+u/RExyDAb+xmGlXQrNgxIrw5lWQSn1BFlj0h2tqv75I0QEmVFs5gogfLEhtLQ/
         7tRBvxkKu7tp8/yXtxYLisA0sTwFVvV8OpZUcBDc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 30813606CF;
        Thu, 24 Oct 2019 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571914101;
        bh=HvQo5UXy1E/mep6qtl/EvO49cQsF+lfjnJQRvD0/dKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OSNt4EdP8ojUPznDDXNKJS/mY6tfM+Pq8vaWYFzKHShTQSRMGz5TqzhjjiOzHP1Zk
         WV7+u/RExyDAb+xmGlXQrNgxIrw5lWQSn1BFlj0h2tqv75I0QEmVFs5gogfLEhtLQ/
         7tRBvxkKu7tp8/yXtxYLisA0sTwFVvV8OpZUcBDc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 18:48:21 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for
 sdio
In-Reply-To: <87h83ysbjy.fsf@kamboji.qca.qualcomm.com>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
 <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
 <87h83ysbjy.fsf@kamboji.qca.qualcomm.com>
Message-ID: <73e2d996575023b14c24665b2607a5b3@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-24 18:05, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:

> As you can see I also changed the macro to a function, as I prefer C
> over CPP :) And changed ATH10K_HTC_FLAG_BUNDLE_MASK to use GENMASK().
> 
yes.
> But this only compiled tested, please do properly test the patches from
> pending branch and let me know if I broke something:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=afd85ca1b086695cfd26bf484442eaf3bccb6bdd
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4225b4d50a4f6a1159dc3316d068398f1b5edb57
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=911e0fc846cfc46fb4ccd1d223cb153681ff05bd

I will test the 3 patches.
