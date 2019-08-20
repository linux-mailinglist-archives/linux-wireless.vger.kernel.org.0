Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17222961DA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfHTOCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 10:02:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTOCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 10:02:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F3F660A0A; Tue, 20 Aug 2019 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566309735;
        bh=b/dG4qVWE/6aYWd8JtiJbt71mYdz/4im0XiZ0iGFQic=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eic4DuF95TioRP1QS7LQ6DWxsQwwvj1Y81l0dMQUlUhDfEt2axs2UEVsihK92gVxA
         0EsqQB269FASI2VMw7Vshn8XFpZhblererlAVxGI/SoZ94foFlKojWGMDfV3jSnNw6
         0l9eTbY00MdM1LLQM54aJcxwTqqYTx7yK7nKFNjI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30D55602A8;
        Tue, 20 Aug 2019 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566309734;
        bh=b/dG4qVWE/6aYWd8JtiJbt71mYdz/4im0XiZ0iGFQic=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=JiDPrUY9I6iVqYOnNxe3aT8PjDUx/yjYFFQ1FKWjTHYyHph0e9i0jL/hhMP4bllkn
         5q45Si789APVv2khgsiQP4Ywq22S6SthbdeJGEOokkEJEVxb08F7vk/YJUErLHN7Wr
         U4CPwDVVgLmW8EVL0ks2uebVXNgp21xcnd0ubEgU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30D55602A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] iwlwifi: mvm: Allow multicast data frames only when
 associated
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190816125554.8659-2-luca@coelho.fi>
References: <20190816125554.8659-2-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190820140215.2F3F660A0A@smtp.codeaurora.org>
Date:   Tue, 20 Aug 2019 14:02:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Ilan Peer <ilan.peer@intel.com>
> 
> The MAC context configuration always allowed multicast data frames
> to pass to the driver for all MAC context types, and in the
> case of station MAC context both when associated and when not
> associated.
> 
> One of the outcomes of this configuration is having the FW forward
> encrypted multicast frames to the driver with Rx status indicating
> that the frame was not decrypted (as expected, since no keys were
> configured yet) which in turn results with unnecessary error
> messages.
> 
> Change this behavior to allow multicast data frames only when they
> are actually expected, e.g., station MAC context is associated etc.
> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

4 patches applied to wireless-drivers.git, thanks.

50f5604476b2 iwlwifi: mvm: Allow multicast data frames only when associated
884b75696873 iwlwifi: pcie: fix the byte count table format for 22560 devices
17e40e6979aa iwlwifi: pcie: don't switch FW to qnj when ax201 is detected
5a8c31aa6357 iwlwifi: pcie: fix recognition of QuZ devices

-- 
https://patchwork.kernel.org/patch/11097607/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

