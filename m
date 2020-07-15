Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57E92212F1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGOQrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 12:47:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:15277 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgGOQry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 12:47:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594831674; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=0YNgags7lBPRj9aPsnUXN6sVUi5iHlWg3RNlkFMPnIg=;
 b=IIEsFPTF5hQwgPyjBkudDJ60+Rp0W9GsZDIsZ7+Tt68yG6EB7mpNVfGp6SlhWLVGJw7lcWyY
 2nwhaiXTGN4A2JTE7WwItBMz3AtY/FmE7cP/HmZE0Pyj98bzafOWOZvslrHoIHrK1hwhbrdD
 kyqFQ13YLN6+RSSahdnWXDKgCnQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f0f3338512812c070a22a4b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 16:47:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8CED9C43391; Wed, 15 Jul 2020 16:47:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57945C433C9;
        Wed, 15 Jul 2020 16:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57945C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/14 v3] iwlegacy: Check the return value of
 pcie_capability_read_*()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200713175529.29715-3-refactormyself@gmail.com>
References: <20200713175529.29715-3-refactormyself@gmail.com>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715164752.8CED9C43391@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 16:47:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Saheed O. Bolarinwa" <refactormyself@gmail.com> wrote:

> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> On failure pcie_capability_read_dword() sets it's last parameter, val
> to 0. However, with Patch 14/14, it is possible that val is set to ~0 on
> failure. This would introduce a bug because (x & x) == (~0 & x).
> 
> This bug can be avoided without changing the function's behaviour if the
> return value of pcie_capability_read_dword is checked to confirm success.
> 
> Check the return value of pcie_capability_read_dword() to ensure success.
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

9018fd7f2a73 iwlegacy: Check the return value of pcie_capability_read_*()

-- 
https://patchwork.kernel.org/patch/11660739/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

