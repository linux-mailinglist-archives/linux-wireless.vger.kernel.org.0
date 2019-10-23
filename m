Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDED0E175B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390935AbfJWKHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 06:07:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390920AbfJWKHp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 06:07:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D954D60DA5; Wed, 23 Oct 2019 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571825264;
        bh=9t2EYV3Uph1VAii9sfxejDakzTJDzCdH1ttCEXGKUps=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SLkyl/o2f2Uo/J+qLwxRzsBjSM73u1aRXHIMn3faAHbgbwwHm91RmgoI3Epfi6XwA
         R/8eJjEufsL3aHmkfy5HLpSPcYemRhoAl+ntOAk8Rat86am7UvEB5sLBNGNhbzahvM
         R9kh49qkeMklOpu+3PCJfItYOjrGP7cfa7j4WxUA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C2B660B14;
        Wed, 23 Oct 2019 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571825264;
        bh=9t2EYV3Uph1VAii9sfxejDakzTJDzCdH1ttCEXGKUps=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SLkyl/o2f2Uo/J+qLwxRzsBjSM73u1aRXHIMn3faAHbgbwwHm91RmgoI3Epfi6XwA
         R/8eJjEufsL3aHmkfy5HLpSPcYemRhoAl+ntOAk8Rat86am7UvEB5sLBNGNhbzahvM
         R9kh49qkeMklOpu+3PCJfItYOjrGP7cfa7j4WxUA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C2B660B14
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     linux-wireless@vger.kernel.org
Subject: rtl8xxxu: recent sparse warnings
References: <5db0120f.6XzlR4e8kc/qgxwe%lkp@intel.com>
Date:   Wed, 23 Oct 2019 13:07:40 +0300
In-Reply-To: <5db0120f.6XzlR4e8kc/qgxwe%lkp@intel.com> (kbuild test robot's
        message of "Wed, 23 Oct 2019 16:40:47 +0800")
Message-ID: <87imofu64z.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> tree/branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git
> master
> branch HEAD: 0eeb91ade90ce06d2fa1e2fcb55e3316b64c203c rtl8xxxu: fix
> RTL8723BU connection failure issue after warm reboot
>
> Regressions in current branch:
>
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5197:6: sparse:
> sparse: symbol 'rtl8723bu_set_coex_with_type' was not declared. Should
> it be static?
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5248:6: sparse:
> sparse: symbol 'rtl8723bu_update_bt_link_info' was not declared.
> Should it be static?
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5314:6: sparse:
> sparse: symbol 'rtl8723bu_handle_bt_inquiry' was not declared. Should
> it be static?
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5339:6: sparse:
> sparse: symbol 'rtl8723bu_handle_bt_info' was not declared. Should it
> be static?

Chris, I believe these sparse warnings come from your commit:

e542e66b7c2e rtl8xxxu: add bluetooth co-existence support for single antenna

Can you send a follow up patch to fix these, please?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
