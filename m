Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC215AD02
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLQR3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 11:17:29 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:39980 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgBLQR3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 11:17:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581524249; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NJPf8Xz62EeXU4aN3MP59q86/OV5j8n6CyNmIdhqrMQ=;
 b=a74M4pmIJKQoQhssAh/vc2PeTmYEbUBVx86NkPDODN3N3UzRURyrkzbtjEG1J7LZcFatd6HG
 0XLHSET8gV2uVze7PLOasT+z59PIyehpNkKV/CwrjeyA9FOE0qvepv4zedF2P0TSCTKvN0nN
 9Xb8KxzETL/FsavPl6lFxHXivn0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e442514.7fa7370df810-smtp-out-n01;
 Wed, 12 Feb 2020 16:17:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B211C4479F; Wed, 12 Feb 2020 16:17:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF0B9C43383;
        Wed, 12 Feb 2020 16:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF0B9C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] qtnfmac: use MAJOR.MINOR format for firmware
 protocol
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200127104634.7248-2-sergey.matyukevich.os@quantenna.com>
References: <20200127104634.7248-2-sergey.matyukevich.os@quantenna.com>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200212161723.8B211C4479F@smtp.codeaurora.org>
Date:   Wed, 12 Feb 2020 16:17:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> wrote:

> From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
> 
> Use MAJOR.MINOR format for QLink firmware protocol. MAJOR part is
> incremented when backward compatibility is broken. Normally this
> part should not be incremented unless there is a good reason for
> that. MINOR part is incremented each time when new features are
> added to qlink.h, e.g. new TLVs, events, commands. These changes
> should not break backward compatibility. For instance, older
> firmware versions may not be able to parse new flags or send new
> types of events, but this does not impact normal system operations.
> 
> As part of initialization sequence, driver requests protocol version
> from firmware and refuses to start in case there is a mismatch in MAJOR
> part of the version.
> 
> Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

10 patches applied to wireless-drivers-next.git, thanks.

a3ebb0335c54 qtnfmac: use MAJOR.MINOR format for firmware protocol
310cd5dd5070 qtnfmac: pass hardware capabilities in TLV element
e70cf22bc7b2 qtnfmac: merge PHY_PARAMS_GET into MAC_INFO
bc5db734c1c4 qtnfmac: drop QTN_TLV_ID_NUM_IFACE_COMB TLV type
601ce21ff88d qtnfmac: implement extendable channel survey dump
0d18a9c0a387 qtnfmac: pass max scan SSIDs limit on per-radio basis
8b0b5f1ba9e0 qtnfmac: cleanup alignment in firmware communication protocol
5edadc5a3f11 qtnfmac: update channel switch command to support 6GHz band
501c3be1ec3c qtnfmac: drop unnecessary TLVs from scan command
946d077a4256 qtnfmac: fix potential Spectre vulnerabilities

-- 
https://patchwork.kernel.org/patch/11352415/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
