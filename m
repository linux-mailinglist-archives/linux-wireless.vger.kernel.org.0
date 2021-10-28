Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55843DD3D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJ1JAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 05:00:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30374 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhJ1JAp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 05:00:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635411498; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=4KROLv/TfRY+ImU5mU/rR3OKISGBN52NI3Dxegicnhs=; b=RzsktHgLbEZ0fAr4+034hV6efSToct/Cwmv40eMuT8NN0qQ9E7295dhZCvnSTkbpD0kUJy5v
 +uT+TNPRIZcWMzB0oFtF2bYULN1IoBBzGcD9fZmP8/qvBnVRIp8GtAOZT4A0hkgKyqL6FXHW
 lRkT0FPJSysZrjxY9bGwTzp0EHk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 617a662a648aeeca5cfe3c3c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 08:58:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5444C43460; Thu, 28 Oct 2021 08:58:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4B59C4338F;
        Thu, 28 Oct 2021 08:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E4B59C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem subsystem
References: <20211016234609.1568317-1-chunkeey@gmail.com>
Date:   Thu, 28 Oct 2021 11:58:13 +0300
In-Reply-To: <20211016234609.1568317-1-chunkeey@gmail.com> (Christian
        Lamparter's message of "Sun, 17 Oct 2021 01:46:09 +0200")
Message-ID: <87ee855xwa.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> ATH10K chips are used it wide range of routers,
> accesspoints, range extenders, network appliances.
> On these embedded devices, calibration data is often
> stored on the main system's flash and was out of reach
> for the driver.
>
> To bridge this gap, ath10k is getting extended to pull
> the (pre-)calibration data through nvmem subsystem.
> To do this, a nvmem-cell containing the information can
> either be specified in the platform data or via device-tree.
>
> Tested with:
>         Netgear EX6150v2 (IPQ4018 - pre-calibration method)
>         TP-Link Archer C7 v2 (QCA9880v2 - old calibration method)
>
> Cc: Robert Marko <robimarko@gmail.com>
> Cc: Thibaut VAR=C3=88NE <hacks@slashdirt.org>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>
> v1 -> v2:
> 	- use %zu and %u in the format string for size_t
>           and u32 types (catched by the "kernel test robot").
> 	- reworded commit message + successfully tested on QCA9880v2
>
> I placed the nvmem code in front of the current "file" method
> (firmware_request). Reason is that this makes it easier for me
> to test it. If needed it can be moved to a different place.

Looks good to me. Before I apply this, I want to mention to that I have
had a long in my deferred queue related two patchsets:

https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86=
-1-ansuelsmth@gmail.com/
https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86=
-2-ansuelsmth@gmail.com/

https://patchwork.kernel.org/project/linux-wireless/patch/20200918181104.98=
-1-ansuelsmth@gmail.com/
https://patchwork.kernel.org/project/linux-wireless/patch/20200918181104.98=
-2-ansuelsmth@gmail.com/

Christian, we don't need those anymore, right? Expect the first patch
maybe.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
