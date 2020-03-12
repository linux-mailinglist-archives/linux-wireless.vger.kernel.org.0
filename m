Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E2F1831B6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCLNiC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:38:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18010 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLNiB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:38:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020281; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sgx+DJOXfjnZQSU/697ARQnX0tUKbL0dk7d7TL+aHY4=;
 b=jfREtbJz4qAR2681MpN6l2marUvo/HzES6f33Hw04GKMtN573kYds2sd1CSoN3p+6pp/Mwf5
 6I9jlrKnVx8W2YtJG5HLFj+cVdCv03nkuZcAVRgU+L9qny/iwx3s8MaX+N77rZUpy3amyDry
 oQdTu6LTNK6ys7FEMISLe8RwwEw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3b39.7f11920d57a0-smtp-out-n04;
 Thu, 12 Mar 2020 13:38:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14E25C433BA; Thu, 12 Mar 2020 13:38:00 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0591C433D2;
        Thu, 12 Mar 2020 13:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0591C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtl8188eu: Add rtw_led_enable module parameter
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <869a61437edb52d60721ac8b2a7cccc43e3b0fb4.camel@hadess.net>
References: <869a61437edb52d60721ac8b2a7cccc43e3b0fb4.camel@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312133800.14E25C433BA@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:38:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bastien Nocera <hadess@hadess.net> wrote:

> Make it possible to disable the LED, as it can be pretty annoying
> depending on where it's located.
> 
> See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> out-of-tree version.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Please use "staging: " prefix for staging patches, easier for me to filter that
way.

-- 
https://patchwork.kernel.org/patch/11413973/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
