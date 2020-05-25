Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F921E0BF9
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbgEYKiz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 06:38:55 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13927 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389777AbgEYKiz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 06:38:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590403134; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=lFsr8nIACUM6UgmDa1xekMARHxnlRL7EhwzL3mtLwqY=; b=fJy+PwUIu+ofwdpqbbUZsYHJjlSiQ1dqLOq6OIZ6gtt9Vi0FYC4K9px8y5Z3g3CicsKK8LGF
 IcahHYpAEQ2Ogoeal9XrHe052LOmEFv0lLTORXT/vHa4gyI+4b+eAfCy4S3kKbzhj/hEt+zt
 TcEZqncp/oiuRjde1tkH74V2kp8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ecba03e9d4cf4d3ef43d85f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 May 2020 10:38:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECDC6C43391; Mon, 25 May 2020 10:38:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27801C433C9;
        Mon, 25 May 2020 10:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27801C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: Re: [PATCH 07/11] mmc: sdio: Move SDIO IDs from ath6kl driver to common include file
References: <20200522144412.19712-1-pali@kernel.org>
        <20200522144412.19712-8-pali@kernel.org>
Date:   Mon, 25 May 2020 13:38:46 +0300
In-Reply-To: <20200522144412.19712-8-pali@kernel.org> ("Pali \=\?utf-8\?Q\?Roh\?\=
 \=\?utf-8\?Q\?\=C3\=A1r\=22's\?\= message
        of "Fri, 22 May 2020 16:44:08 +0200")
Message-ID: <87blmc9u4p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Also replace generic MANUFACTURER macros by proper SDIO IDs macros.
>
> Check for "AR6003 or later" is slightly modified to use SDIO device IDs.
> This allows removal of all custom MANUFACTURER macros from ath6kl.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Acked-by: Kalle Valo <kvalo@codeaurora.org>

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
