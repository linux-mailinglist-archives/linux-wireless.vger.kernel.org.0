Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739B0220A2C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 12:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgGOKhq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 06:37:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12646 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728998AbgGOKhq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 06:37:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594809465; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TVurXgj4NUPmZ9Mfbj4tnXuhCejAqUKi6EtAP5OfZHY=;
 b=sCAh6LDWVWCX50G8+sBF3xmp3Li3FmwmeOS9fjdQ1JWL7JuionIfmi3srpnMr7M6JG8lWFRO
 ZpFMlGV1P0JMIGMZqjA0Qy+N0nAGlw4K0IJ7DLhyOeWbFG/c2r6xAkCuAriQxUu6SwCplUse
 WsNAy8IfcoSeEKyWgAW7J53bJR0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f0edc7975eeb235f66aecf8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 10:37:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14FAFC433C9; Wed, 15 Jul 2020 10:37:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 731D0C433CA;
        Wed, 15 Jul 2020 10:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 731D0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rtlwifi: rtl8192cu: Fix deadlock
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200622132113.14508-2-code@reto-schneider.ch>
References: <20200622132113.14508-2-code@reto-schneider.ch>
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     linux-wireless@vger.kernel.org, Larry.Finger@lwfinger.net,
        Reto Schneider <code@reto-schneider.ch>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715103745.14FAFC433C9@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 10:37:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reto Schneider <code@reto-schneider.ch> wrote:

> Prevent code from calling itself indirectly, causing the driver to hang
> and consume 100% CPU.
> 
> Without this fix, the following script can bring down a single CPU
> system:
> ```
> while true; do
>   rmmod rtl8192cu
>   modprobe rtl8192cu
> done
> ```
> 
> Signed-off-by: Reto Schneider <code@reto-schneider.ch>
> ACKed-by: Larry Finger <Larry.Finger@lwfinger.net>

3 patches applied to wireless-drivers-next.git, thanks.

ec89032cd148 rtlwifi: rtl8192cu: Fix deadlock
03128643eb54 rtlwifi: rtl8192cu: Prevent leaking urb
a7f7c15e945a rtlwifi: rtl8192cu: Free ieee80211_hw if probing fails

-- 
https://patchwork.kernel.org/patch/11617759/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

