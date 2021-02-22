Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BE3321160
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 08:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBVH2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 02:28:34 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:56692 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBVH2d (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 02:28:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613978892; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=7L59uR8RHoAqyZuTKOtlusC+oyCg2QZVfVkamlNDW08=; b=V98FTASWWsOYzGbeyUD2bP4nmSSXz+KNpAzOsgVAN7+hjxojS/Htyvb8TYv4O4WLApUYlTZg
 jz2EXnoNTKuxix27pvgusoDx/mzLYw7eA0zzdvbdsPepRrZ/r8s6ohQUnIQ+CkqA9ed+GFH9
 WeO3pvq2O27GcOtRlB6VgeJtoQQ=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60335cf2e87943df3082589d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 07:27:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BD7DC43462; Mon, 22 Feb 2021 07:27:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4D1FC433CA;
        Mon, 22 Feb 2021 07:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4D1FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?B?6ZmI5rWp?= <chenhaoa@uniontech.com>
Cc:     tony0620emma <tony0620emma@gmail.com>, davem <davem@davemloft.net>,
        kuba <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        timlee <timlee@realtek.com>, arnd <arnd@arndb.de>
Subject: Re: [PATCH] rtw88: 8822ce: fix wifi disconnect after S3/S4 on HONOR laptop
References: <20210220084602.22386-1-chenhaoa@uniontech.com>
        <878s7jjeeh.fsf@codeaurora.org>
        <1323517535.1654941.1613976259730.JavaMail.xmail@bj-wm-cp-15>
Date:   Mon, 22 Feb 2021 09:27:32 +0200
In-Reply-To: <1323517535.1654941.1613976259730.JavaMail.xmail@bj-wm-cp-15>
 ("
        \=\?utf-8\?B\?6ZmI5rWpIidz\?\= message of "Mon, 22 Feb 2021 14:44:19 +0800
 (CST)")
Message-ID: <874ki4k1ej.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=E9=99=88=E6=B5=A9 <chenhaoa@uniontech.com> writes:

> By git blame command, I know that the assignment of .driver.pm =3D
> RTW_PM_OPS
>
> was in commit 44bc17f7f5b3b("rtw88: support wowlan feature for
> 8822c"),
>
> and another commit 7dc7c41607d19("avoid unused function warnings")
>
> pointed out rtw_pci_resume() and rtw_pci_suspend() are not used at
> all.
>
> So I think it's safe to remove them.
>
> Currently, I find that the rtl8822ce wifi chip and the pci bridge of
> it are not linked by pci
>
> after wake up by `lspci` command.
>
> when I set `pcie_aspm.policy=3Dperformance ` in the GRUB. The machine
> sleep and
>
> wake up normal.So I think when this ops is assignmented,the sleep and
> wake up procedure
>
> may cause pci device not linked.

Please don't use HTML, our lists automatically drop all HTML email.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
