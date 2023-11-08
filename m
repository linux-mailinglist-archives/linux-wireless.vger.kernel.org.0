Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914F57E5CD6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjKHSG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHSG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:06:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD9B186
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:06:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA45C433C8;
        Wed,  8 Nov 2023 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699466813;
        bh=ZDpHDGVEFP+bE91rOEdXGu/bEAWDoVUCkXyc/7UOY6E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tOaxwE5s0EKWY7eKOUavVDZadTIn6hx3G+jt1RsSq/WBnNxnaFQN+QIiUDj/SG5WA
         ifxo/x7WObLSoqpyTGmZgqB9M3deGJgN/UKWTypsK4msyMNIzLe+17UH77qvK2ZhpK
         1duhzK2fYSbu1+pXtkHhBSyiek20YxFFVsmQcKVzsfNlZjrcmCjscRWzZuASAVnpOa
         imef0Y48WgEoDVnWmydaMxpmObaMmMMTlMnGn2fxEGQoreyLLxfEnBYB32XfCZLPf4
         RyAEVVBm62Srp6pYb0Wx198yxdno2J7D2XmXiEtDuxnpHSbAWyXRB4J0BEDyaLQvPM
         REgmJ8bTMZT8A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: plfxlc: check for allocation failure in
 plfxlc_usb_wreq_async()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e8d4a19a-f251-4101-a89b-607345e938cb@moroto.mountain>
References: <e8d4a19a-f251-4101-a89b-607345e938cb@moroto.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Srinivasan Raju <srini.raju@purelifi.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946681070.2821494.11583175295083759020.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 18:06:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Check for if the usb_alloc_urb() failed.
> 
> Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied to wireless-next.git, thanks.

40018a8fa9aa wifi: plfxlc: check for allocation failure in plfxlc_usb_wreq_async()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e8d4a19a-f251-4101-a89b-607345e938cb@moroto.mountain/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

