Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4D315BB47
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgBMJNp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:13:45 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:30687 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729531AbgBMJNp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:13:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581585224; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=I0F+gbBFBV5WZp+TvcC9LoqqGdIyYBihFUDZGmFWmUA=; b=tRWFdYTMh7UJTHMSREOda3d/kmCS4HkgzkDsGcSqtcxGE/5a5PK6oW6JP72hYgtElZkRXIGY
 dU0D5DBHpKA9/RKXIkD2+1ngpJv0SkxXTtDCEHq8Qo0dH6pxUMuo1xQRSExbYmw340D1L8GD
 KMaIpljDUdaiyHd6RJIvK6rvcnA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e451347.7f5db60adf48-smtp-out-n02;
 Thu, 13 Feb 2020 09:13:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91FF2C447A2; Thu, 13 Feb 2020 09:13:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95C24C43383;
        Thu, 13 Feb 2020 09:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95C24C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     linux-wireless@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        James Cao <zheng.cao@nxp.com>, Cathy Luo <xiaohua.luo@nxp.com>
Subject: Re: [PATCH] mwifiex: change license text from MARVELL to NXP
References: <1581524230-10212-1-git-send-email-ganapathi.bhat@nxp.com>
Date:   Thu, 13 Feb 2020 11:13:37 +0200
In-Reply-To: <1581524230-10212-1-git-send-email-ganapathi.bhat@nxp.com>
        (Ganapathi Bhat's message of "Wed, 12 Feb 2020 21:47:10 +0530")
Message-ID: <877e0qx326.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <ganapathi.bhat@nxp.com> writes:

> As of 6-DEC-2019, NXP has acquired Marvell=E2=80=99s Wireless business
> unit. This change is to update the license text accordingly.
>
> Signed-off-by: James Cao <zheng.cao@nxp.com>
> Signed-off-by: Cathy Luo <xiaohua.luo@nxp.com>
> Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>

[...]

> --- a/drivers/net/wireless/marvell/mwifiex/11ac.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11ac.c
> @@ -1,10 +1,10 @@
>  /*
> - * Marvell Wireless LAN device driver: 802.11ac
> + * NXP Wireless LAN device driver: 802.11ac
>   *
> - * Copyright (C) 2013-2014, Marvell International Ltd.
> + * Copyright 2011-2020 NXP
>   *
> - * This software file (the "File") is distributed by Marvell Internation=
al
> - * Ltd. under the terms of the GNU General Public License Version 2, Jun=
e 1991
> + * This software file (the "File") is distributed by NXP
> + * under the terms of the GNU General Public License Version 2, June 1991
>   * (the "License").  You may use, redistribute and/or modify this File in
>   * accordance with the terms and conditions of the License, a copy of wh=
ich
>   * is available by writing to the Free Software Foundation, Inc.,

Relate to this, it would be really nice if you could switch mwifiex to
use SPDX tags, it's so much more maintainer friendly:

https://www.kernel.org/doc/html/latest/process/license-rules.html

But that should be done in a separate patch, no need to change this
patch.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
