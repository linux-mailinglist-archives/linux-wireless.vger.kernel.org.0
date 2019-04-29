Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404A6E54C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfD2Otr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:49:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfD2Otr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:49:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D5E660134; Mon, 29 Apr 2019 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549386;
        bh=3vJP8OAvsIMdfwwgjadMzhPbTsAnYAw/jnCOUsKYxSA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MlRYh2y9yDP471kMH9i0eJtbD05NLuRaFBjiVrYg5FEZ/j8UgXUA1GZ59f33I31HI
         y8WJrqdrJTaOhzR5o5xyt86ejxnT4fLNo8sStT4bu8nL4qcxJNFkbOM5o+VeHlqqGo
         e9GbeAoBT/Y9kVBPN9qN9apHUL94HT2ukXKGoFos=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 693EC6028C;
        Mon, 29 Apr 2019 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549386;
        bh=3vJP8OAvsIMdfwwgjadMzhPbTsAnYAw/jnCOUsKYxSA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ZT+j8k2gBeK9xAXQPMJHoKA5txfjA6yxr1CSariMd1hkYjBUW5LI6qp2HoH7XNcwS
         oQ+JL3G9hQ5Le3vSaDFIwZnXpdV4IBf9opCGIvE7lsgLhjvK7lMV960ZJL1bWeZ2XR
         i+PfF6rD6vFhorPSAiI25GWcu03Fjbm+k3QSkRPs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 693EC6028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath6kl: add some bounds checking
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190404085651.GC20193@kadam>
References: <20190404085651.GC20193@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429144946.9D5E660134@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:49:46 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "ev->traffic_class" and "reply->ac" variables come from the network
> and they're used as an offset into the wmi->stream_exist_for_ac[] array.
> Those variables are u8 so they can be 0-255 but the stream_exist_for_ac[]
> array only has WMM_NUM_AC (4) elements.  We need to add a couple bounds
> checks to prevent array overflows.
> 
> I also modified one existing check from "if (traffic_class > 3) {" to
> "if (traffic_class >= WMM_NUM_AC) {" just to make them all consistent.
> 
> Fixes: bdcd81707973 (" Add ath6kl cleaned up driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5d6751eaff67 ath6kl: add some bounds checking

-- 
https://patchwork.kernel.org/patch/10885299/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

