Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF76A69DF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfICNab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:30:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfICNab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:30:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5686E60592; Tue,  3 Sep 2019 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517430;
        bh=g42NlNJI+hsdcPYmWIDPfGm2cRsjwuTD2+C8vpUkwUU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BQt2UfWsgTPcE+r084EZSBJFLQCnRIULoV1XFBYhwqwF+sJyFei5Cvpu6e/G2SOdt
         FcZh6TenaDtRrWpqD+RRebgke0NaeM8Cv9GH/U2fqYMEcUfTC/MIelgGRH0JNusy1o
         wWpgsfhN9QbZIjXOjKFRKYCE6Cmn1/mrU+73GLeo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E83CF602BA;
        Tue,  3 Sep 2019 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517430;
        bh=g42NlNJI+hsdcPYmWIDPfGm2cRsjwuTD2+C8vpUkwUU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=oZHCdgPEXy6ZyBA8kLW7FKRVTZP9ptOq4PxikpLVqvi9gs8r9J/SEZBSJUcay//Hx
         tSOCEn6/HD5ImNOY8y4Dlg/XLpZPPGQmKFw7qdKiOnrbHCCaKUhhbmNNtTg3Cp50/J
         oaPTLx8U1BDUCXai9fIJaou3QS6388BIj6q4P4SU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E83CF602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtlwifi: rtl_pci: Fix memory leak when hardware init
 fails
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190826220344.7084-1-Larry.Finger@lwfinger.net>
References: <20190826220344.7084-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903133030.5686E60592@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:30:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> If the call to hw_init() fails for any of the drivers, the driver will
> leak memory that was allocated in BT coexistence setup. Technically, each
> of the drivers should have done this free; however placing it in rtl_pci
> fixes all the drivers with only a single patch.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

8cc782cd997d rtlwifi: rtl_pci: Fix memory leak when hardware init fails

-- 
https://patchwork.kernel.org/patch/11115745/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

