Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D621919FA15
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgDFQ0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 12:26:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42344 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729061AbgDFQZ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 12:25:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586190359; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3GqqMefz6xkh7pZzhl1Z381IcHiOKqY0rOLB278udJM=;
 b=PAI6rAUBqCG926zKFGMRI4l9GpYiOWau0PeuBS82KL6365GbkyHr0+75ncpRUOwkevvFz5KI
 99pyoazPe1Uc4bDEGgebORpgga4vvEETfPwIX4Z7Ui5cztHZnh9rp2kAuIpAhfdmMRcEKTPb
 tVohLMqUutgdrxy0KorvaqGT9TU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b580c.7f3f30e4d3e8-smtp-out-n05;
 Mon, 06 Apr 2020 16:25:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 828ECC43637; Mon,  6 Apr 2020 16:25:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D833C433D2;
        Mon,  6 Apr 2020 16:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D833C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] ath10k: enable VHT160 and VHT80+80 modes
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585574792-719-1-git-send-email-ssreeela@codeaurora.org>
References: <1585574792-719-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Lei Wang <leiwa@codeaurora.org>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Rick Wu <rwu@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200406162548.828ECC43637@smtp.codeaurora.org>
Date:   Mon,  6 Apr 2020 16:25:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> Set right channel frequencies in VHT160 mode according to the VHT160
> interoperability workaround added as part of IEEE Std 802.11™-2016 in
> "Table 9-252—VHT Operation Information subfields", band_center_freq2
> corresponds to CCFS1 in Table 9-253. Previous implementation
> (band_center_freq2 = 0 for VHT160) is only deprecated.
> 
> Enable VHT80+80 mode and set the proper peer RX nss value for VHT160 and
> VHT80+80 mode.
> 
> Based on patches by Sebastian Gottschall:
> 
> https://lkml.kernel.org/r/20180704095444.662-1-s.gottschall@dd-wrt.com
> 
> https://lkml.kernel.org/r/20180704120519.6479-1-s.gottschall@dd-wrt.com
> 
> Tested: qca9984 with firmware ver 10.4-3.10-00047
> 
> Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Co-developed-by: Rick Wu <rwu@codeaurora.org>
> Signed-off-by: Rick Wu <rwu@codeaurora.org>
> Signed-off-by: Lei Wang <leiwa@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

3db24065c2c8 ath10k: enable VHT160 and VHT80+80 modes
795def8b14ff ath10k: enable radar detection in secondary segment

-- 
https://patchwork.kernel.org/patch/11465505/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
