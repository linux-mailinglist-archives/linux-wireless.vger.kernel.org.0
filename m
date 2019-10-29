Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B41E8C54
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 17:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbfJ2QA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 12:00:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390121AbfJ2QA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 12:00:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72E8460DD4; Tue, 29 Oct 2019 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572364858;
        bh=SoGts15CP7/jtKwmryUnyKSzLpoAF3NDTeTG7pGv84Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=H5IfK37PqwZjQVDtVi5zjqGK7g9cE4Z3KE7AIlfHnDlZW1XaMGP6m0WXSRMFVh9Ok
         Y2KEeMzICnIz8NpIHy+9bmk2sQzEtUxXtMbT33OlQPgmePILwamH7qKn8Gwafkhue9
         oW8Nxnt3CBViVJ9PFRJrbFjbW8sQ+WH74EOf8tbQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7993F60DE9;
        Tue, 29 Oct 2019 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572364854;
        bh=SoGts15CP7/jtKwmryUnyKSzLpoAF3NDTeTG7pGv84Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Cuk3g8cqNC0E6p8r1v7jPTwTd7p7G0OvU/8icB4cEwyCG6RRjIgoAsCe6Y0S075ft
         WCf4js9EEE3IzlWZpcpCbH0Epaws55gOmyxW05vHTqO5d+EEubBvwaoyAbL+9TXo4O
         ch0KRnR02V6ieyUx1ZV9Q7IipGqbTwpHjaXnGX9g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7993F60DE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.4 v2] iwlwifi: fw api: support new  API for scan config cmd
References: <20191029154720.26477-1-luca@coelho.fi>
Date:   Tue, 29 Oct 2019 18:00:50 +0200
In-Reply-To: <20191029154720.26477-1-luca@coelho.fi> (Luca Coelho's message of
        "Tue, 29 Oct 2019 17:47:20 +0200")
Message-ID: <87sgnb35jh.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Ayala Beker <ayala.beker@intel.com>
>
> The API was reduced to include only knowledge currently needed by the
> FW scan logic, the rest is legacy.  Support the new, reduced version.
>
> Using the old API with newer firmwares (starting from
> iwlwifi-*-50.ucode, which implements and requires the new API version)
> causes an assertion failure similar to this one:
>
> [    2.854505] iwlwifi 0000:00:14.3: 0x20000038 | BAD_COMMAND
>
> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>
> In v2:
>
>   * Expand the commit message to explain what the problem is.

Perfect, thanks!

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
