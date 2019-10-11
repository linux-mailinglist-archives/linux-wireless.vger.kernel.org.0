Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223F4D3B3F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfJKId4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 04:33:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJKIdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 04:33:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C011060AA8; Fri, 11 Oct 2019 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570782834;
        bh=JYWPR3LzvWjcDpMpzfmkiNQeMdbcCBhWZvYVl3wjHS4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bwJf6uNvmr2ok0HrhaeEOfG9iR/0GAIctzLDsVW/AmsoFpk6ANOVxoGBbzbONedRt
         XJxnkr+WYXGQqYABn8MkroGQgEALRAEhH9G3X9/J6MlWf7yjWctznrAfo/mWnqXDS/
         fvhbnUns6xp58AVGvrJewIRnGL/IGNtAU9Z6nhv4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E09A660112;
        Fri, 11 Oct 2019 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570782834;
        bh=JYWPR3LzvWjcDpMpzfmkiNQeMdbcCBhWZvYVl3wjHS4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=hHSdPsSB2P59un1Op/e79GYZ1ITp0bv9giQLqTZOnbpXEEz4T4WGXGvNEpRYB3L0t
         IE9SWgjk0DhJRWyZK0LjsAtxKhMA+u3T5XUWzEiU6q5EguHpe6AqpPdrbRHXALrHvs
         CFLl9QNADnWa6W2tF3kicjZp2MTVj5eFHCn8Rm1U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E09A660112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: check data ack rssi enabled/disabled in htt rx
 event
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1561707084-10021-1-git-send-email-bpothuno@codeaurora.org>
References: <1561707084-10021-1-git-send-email-bpothuno@codeaurora.org>
To:     Balaji Pothunoori <bpothuno@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Abhishek Ambure <aambure@codeaurora.org>,
        Balaji Pothunoori <bpothuno@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191011083354.C011060AA8@smtp.codeaurora.org>
Date:   Fri, 11 Oct 2019 08:33:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Balaji Pothunoori <bpothuno@codeaurora.org> wrote:

> For all data packets transmitted, host gets htt tx completion event. Some QCA9984
> firmware releases support WMI_SERVICE_TX_DATA_ACK_RSSI, which gives data
> ack rssi values to host through htt event of data tx completion. Data ack rssi
> values are valid if A0 bit is set in HTT rx message. So enable the feature also
> for QCA9884.
> 
> Tested HW: QCA9984
> Tested FW: 10.4-3.9.0.2-00044
> 
> Signed-off-by: Abhishek Ambure <aambure@codeaurora.org>
> Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
> [kvalo@codeaurora.org: improve commit log]
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

cc78dc3b7906 ath10k: enable transmit data ack RSSI for QCA9884

-- 
https://patchwork.kernel.org/patch/11021495/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

