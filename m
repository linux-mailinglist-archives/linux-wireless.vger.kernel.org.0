Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D4A6759
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfICL0O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 07:26:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfICL0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 07:26:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBE82607EB; Tue,  3 Sep 2019 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567509972;
        bh=0iPmiPXIui6iWAsOQb8uIccM4cm2k08Ufgtgu3ZZEfk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZFfxJ+rDbqGy3ZJ2xyFAzbQ/BnX1ZIIe6zQK7Nx8MTfRZ1ajSQm6sJL1nf/TZ6P0p
         ogYb91X+2Ab0GpLtksZ7pe0ints6LR1k+qd3C0F7LQ0gP/ev1P3UfaOkiPXGTFJaiQ
         JGK+m09Tc+RYbEU6mzZYDkzLGl3KPGPyMGXiDyIQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73A74607EB;
        Tue,  3 Sep 2019 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567509972;
        bh=0iPmiPXIui6iWAsOQb8uIccM4cm2k08Ufgtgu3ZZEfk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZFfxJ+rDbqGy3ZJ2xyFAzbQ/BnX1ZIIe6zQK7Nx8MTfRZ1ajSQm6sJL1nf/TZ6P0p
         ogYb91X+2Ab0GpLtksZ7pe0ints6LR1k+qd3C0F7LQ0gP/ev1P3UfaOkiPXGTFJaiQ
         JGK+m09Tc+RYbEU6mzZYDkzLGl3KPGPyMGXiDyIQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73A74607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/18] iwlwifi: Set w-pointer upon resume according to SN
References: <20190821133800.23636-1-luca@coelho.fi>
        <20190821133800.23636-6-luca@coelho.fi>
Date:   Tue, 03 Sep 2019 14:26:09 +0300
In-Reply-To: <20190821133800.23636-6-luca@coelho.fi> (Luca Coelho's message of
        "Wed, 21 Aug 2019 16:37:47 +0300")
Message-ID: <87sgpdpqni.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Alex Malamud <alex.malamud@intel.com>
>
> During D3 state, FW may send packets.
> As a result, "write" queue pointer will be incremented by FW.
> Upon resume from D3, driver should adjust its shadows of "write" and "read"
> pointers to the value reported by FW.
>
> 1. Keep TID used during wowlan configuration.
> 2. Upon resume, set driver's "write" and "read" queue pointers
> 	to the value reported by FW.
>
> Signed-off-by: Alex Malamud <alex.malamud@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

A typo in the title, s/w-pointer/q-pointer/ maybe?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
