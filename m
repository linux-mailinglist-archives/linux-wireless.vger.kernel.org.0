Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA2EAC98
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfJaJgS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 05:36:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfJaJgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 05:36:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1310160A23; Thu, 31 Oct 2019 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572514577;
        bh=ElpHY+Pw9KljO9ycv8UWQZ6MM4ZLSnXJZHKG7Oz0lVs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TG0m/7QFITD5tQmmFINnrMt39Ms/2qp3n+WRleDnZ3dhUU9Fpnn6c/OPY/IMhOlIy
         +zSPTzlTHxKvx0EUTuRwZljCNCVPGdwsMlN8KQR4a6YmZ4ZThApbSCUJY9hMqvDzHJ
         CDyWR9SJaaWNBzwll7dFOUxX7j/AbIklya+Vh6IY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2149B60927;
        Thu, 31 Oct 2019 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572514575;
        bh=ElpHY+Pw9KljO9ycv8UWQZ6MM4ZLSnXJZHKG7Oz0lVs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YH39skNbBlQgpF9XkRtvBYpar+AanvXexmbH5KRKfmYX3g1YNovInYEV8g+nAm+E5
         MpjxqYf/gcvUXgqQ0K2Uw3ZdyRT8zgnGhmTltm7pBNJwGFNg64UV/nVqIpEmdvuXwA
         0rt45R9DlXh9tcQ0DhTPG6xmgzzPZXSjI1SVuekU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2149B60927
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>,
        Tova Mussai <tova.mussai@intel.com>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with the wireless-drivers tree
References: <20191031111242.50ab1eca@canb.auug.org.au>
Date:   Thu, 31 Oct 2019 11:36:11 +0200
In-Reply-To: <20191031111242.50ab1eca@canb.auug.org.au> (Stephen Rothwell's
        message of "Thu, 31 Oct 2019 11:13:03 +1100")
Message-ID: <87pnid1cl0.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Today's linux-next merge of the wireless-drivers-next tree got a
> conflict in:
>
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>
> between commit:
>
>   3d206e6899a0 ("iwlwifi: fw api: support new API for scan config cmd")
>
> from the wireless-drivers tree and commit:
>
>   65b9425ce9aa ("iwlwifi: rx: use new api to get band from rx mpdu")
>
> from the wireless-drivers-next tree.

Thanks, the resolution looked simple enough so I'm not taking any extra
actions because of this (for example merging wireless-drivers to
wireless-drivers-next etc).

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
