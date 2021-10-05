Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4767A421E04
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 07:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJEFiq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 01:38:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57545 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhJEFio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 01:38:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633412214; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=SLi+0pWW+gTxZWiHNSEFPqCBenWzFXVN7mEOoe45WUI=; b=sWKK+DK63Xokx9apPfub17kngOYghh6x8P2XCD6phz1YAFDI2mtIQyVqV1Yal1/Dgwx1jwlk
 qpRbWnEeRu6IOJPulIzPEis59prp5PUlUh+TLge4LS/1+10bh3HJTNojXC2Dh9Xxb2FebuMD
 iZOZ5n7CvfzpMTPcFW/SRBT8USQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 615be4768578ef11edb5b202 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 05:36:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4FDCC4360C; Tue,  5 Oct 2021 05:36:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBB9CC4338F;
        Tue,  5 Oct 2021 05:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DBB9CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH] brcmfmac: firmware: Treat EFI nvram ccode=XT the same as ccode=XV
References: <20211003160325.119696-1-hdegoede@redhat.com>
Date:   Tue, 05 Oct 2021 08:36:48 +0300
In-Reply-To: <20211003160325.119696-1-hdegoede@redhat.com> (Hans de Goede's
        message of "Sun, 3 Oct 2021 18:03:25 +0200")
Message-ID: <87fstgghhr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> In some cases the EFI-var stored nvram contains "ccode=ALL", "ccode=XV"
> or "ccode=XT", to specify "worldwide" compatible settings, but these
> ccode-s do not work properly. "ccode=ALL" causes channels 12 and 13 to
> not be available, "ccode=XV" / "ccode=XT" may cause all 5GHz channels
> to not be available.
>
> ccode="ALL" and ccode="XV" where already being replaced with ccode="X2"
> with a bit of special handling for nvram settings coming from an EFI
> variable. Extend this handling to also deal with nvram settings from
> EFI variables which contain "ccode=XT", which has similar issues to
> "ccode=XV".
>
> This fixes 5GHz wifi not working on the HP ElitePad 1000 G2.
>
> This was also tested on a Lenovo Thinkpad 8 tablet which also uses
> "ccode=XT" and this causes no adverse effects there.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

To me worldwide compatible settings mean that channels 12 and 13 should
be disabled, so I'm quite hesitant about this patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
