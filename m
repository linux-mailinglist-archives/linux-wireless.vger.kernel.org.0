Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686C91563B9
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2020 11:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgBHKBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Feb 2020 05:01:54 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:23088 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbgBHKBy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Feb 2020 05:01:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581156113; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/SBTFCt5feovn4CmhBdOZ4lah0SiPO21o0fAsCOSEI0=;
 b=osi6L+agucWhOvYucnJqFqsbg+PEm+p6KvLTAqbHT2ISfDZJxRaFRu2dq8c7BuTB/YY0obj8
 1rN8zzVnUU2cyp7evRisqBcJx2VatSs8gegdBlp6yN0T/tSIxJlwra17I+9ZbbL+dIAQJyZJ
 v4oxoppM6Hu/VOLhO5tysiMVA6k=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3e870c.7fcd154b61b8-smtp-out-n02;
 Sat, 08 Feb 2020 10:01:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2194FC43383; Sat,  8 Feb 2020 10:01:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8293DC43383;
        Sat,  8 Feb 2020 10:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8293DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt76: mt7615: fix max_nss in
 mt7615_eeprom_parse_hw_cap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <ca9137b43b2baa1a292922868004369d055a93e4.1581071232.git.lorenzo@kernel.org>
References: <ca9137b43b2baa1a292922868004369d055a93e4.1581071232.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200208100148.2194FC43383@smtp.codeaurora.org>
Date:   Sat,  8 Feb 2020 10:01:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix u8 cast reading max_nss from MT_TOP_STRAP_STA register in
> mt7615_eeprom_parse_hw_cap routine
> 
> Fixes: acf5457fd99db ("mt76: mt7615: read {tx,rx} mask from eeprom")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

d08f3010f4a3 mt76: mt7615: fix max_nss in mt7615_eeprom_parse_hw_cap

-- 
https://patchwork.kernel.org/patch/11370185/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
