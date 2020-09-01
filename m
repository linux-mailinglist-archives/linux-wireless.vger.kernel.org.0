Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D839258E52
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgIAMkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 08:40:51 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:58644 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727949AbgIAMjS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 08:39:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598963957; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=4BZWAUdP2BV+O/N6ISnmEaCGS3o7RyPMKfE16SuDwv4=; b=KFkf0QsKxQV6hDxgr/892/bBxplZg0lS4FTO3vIh5BniQrjmbocXpkL/3KGLamc8I+zrBE0I
 jMz11lA/M1j/RCGFEAIsgScU+VOyyH361Fkb6hDYYuwFfiZlHQuBqTC9h/37eS7ztNFm1MjJ
 CxSQuEsYLLEDYXADhhdtdrfo/K8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f4e40eabe06707b34767a69 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 12:39:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92071C433CA; Tue,  1 Sep 2020 12:39:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23DD6C433C9;
        Tue,  1 Sep 2020 12:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23DD6C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <kvalo@codeaurora.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ath6kl: wmi: remove set but not used 'rate'
References: <20200831080824.3249197-1-yanaijie@huawei.com>
Date:   Tue, 01 Sep 2020 15:38:58 +0300
In-Reply-To: <20200831080824.3249197-1-yanaijie@huawei.com> (Jason Yan's
        message of "Mon, 31 Aug 2020 16:08:24 +0800")
Message-ID: <871rjl7jtp.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jason Yan <yanaijie@huawei.com> writes:

> This addresses the following gcc warning with "make W=3D1":
>
> drivers/net/wireless/ath/ath6kl/wmi.c: In function
> =E2=80=98ath6kl_wmi_bitrate_reply_rx=E2=80=99:
> drivers/net/wireless/ath/ath6kl/wmi.c:1204:6: warning: variable =E2=80=98=
rate=E2=80=99
> set but not used [-Wunused-but-set-variable]
>  1204 |  s32 rate;
>       |      ^~~~
>
> The variable 'sgi' is alse removed because after 'rate' is removed, it
> is not used too.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Already fixed in ath.git tree.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
