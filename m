Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2E2C6AC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfE1Mg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:36:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfE1Mg5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:36:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 67FDC60E3E; Tue, 28 May 2019 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559047017;
        bh=WE/Yqx8Y9EhtcRR9URYFkwXfyNSg92M+sFSh9Y1rpvM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iWTWIfngkmuTXfis53F97LOt+DrEZ9m29vMjlfqRzJlvH80jcBN6W383akakDTQ2J
         oL2ShS96vCO+sWiXWtUbGYcd2pWZIqAKstvy7QdQ3lqf352ippnS2mEyEshWgaFDJg
         LSqPR4faoh4ZL+GinDnuAUnHF/YGEjmRijBWGGYk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2BBD6087F;
        Tue, 28 May 2019 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559047003;
        bh=WE/Yqx8Y9EhtcRR9URYFkwXfyNSg92M+sFSh9Y1rpvM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=mbNlk1aYsr9gyZBj/iCh3pF4zaClm4LlZsJqeiBt4TuBUYFNKmEhn7vTTGHCs2juD
         n9+RsyBQXvZ37mlMcX7VoOVLH4YJ6/Y+At2Iu6Y/Sbre74/BRnM4n0rqsE9XqeE+SH
         ca6/jaVKvbSUbQWqpMbN/9KvmtejADqooGnZMW/M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2BBD6087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] rtlwifi: rtl8821ae: Remove unused GET_XXX and SET_XXX
 descriptor macros
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190520172359.9993-2-Larry.Finger@lwfinger.net>
References: <20190520172359.9993-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528123657.67FDC60E3E@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 12:36:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> As the first step in converting from macros that get/set information
> in the RX and TX descriptors, unused macros are being removed.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

4 patches applied to wireless-drivers-next.git, thanks.

7ffe556230b8 rtlwifi: rtl8821ae: Remove unused GET_XXX and SET_XXX descriptor macros
f5678bfe1cdc rtlwifi: rtl8821ae: Replace local bit manipulation macros
bd421dab7515 rtlwifi: rtl8821ae: Convert macros that set descriptor
f7fbb03f2169 rtlwifi: rtl8821ae: Convert inline routines to little-endian words

-- 
https://patchwork.kernel.org/patch/10951971/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

