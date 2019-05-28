Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7942C699
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfE1Me2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:34:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfE1Me2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:34:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E35EF602FA; Tue, 28 May 2019 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046867;
        bh=AUu15BcahMill0fEN4YxXe5WnFeSHbTfKWzuVNisopc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NyL6nBILJcTU0UnF5dgL0aPo56iAvj3ogX0UJE/jgTiia6UNxcQjEbxpPatXWl+Ym
         6ibmlHjth9MrdzeM6VUpw657x+r+OUVtfrvYtdar/hBuki60aiSRdIqJVkf0e+HC7u
         bNFfSUgxaKMd4HHGITvK4osxGFtvnIG0Pb/RDVT0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AF5F6034D;
        Tue, 28 May 2019 12:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046867;
        bh=AUu15BcahMill0fEN4YxXe5WnFeSHbTfKWzuVNisopc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=EqknRri5TFPeJ+wc7dKpXQekZesNgiNC1NK15QDA8ijqeu9FDUQu9Gb2VaDgy1AM9
         SXIr321BlOxmHZHX+MwSm3qe33e/NTQebAsHNR5M88U69mBE3sGmWcgwj8sNYChDGp
         CHy+B6GhhJkQwv0cgEAkCMt4wYVveSaa07blE/hE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AF5F6034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] rtlwifi: 8192de: Reduce indentation and fix coding
 style
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190510080333.3789-2-pkshih@realtek.com>
References: <20190510080333.3789-2-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <colin.king@canonical.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528123427.E35EF602FA@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 12:34:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> This commit doesn't change logic at all. Since indentation is lower, the
> wrapped statements can be put in single line that will become more
> readable.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-drivers-next.git, thanks.

3bde4ed3da38 rtlwifi: 8192de: Reduce indentation and fix coding style
8a7db8b66b40 rtlwifi: 8192de: make tables to be 'static const'
0e7d38132bf8 rtlwifi: 8192de: Fix used uninitialized variables in power tracking
80429a86e3d9 rtlwifi: 8192de: use le32 to access cckswing tables

-- 
https://patchwork.kernel.org/patch/10938337/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

