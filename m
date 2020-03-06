Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B8417B6C0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 07:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgCFGeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 01:34:14 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:18135 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbgCFGeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 01:34:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583476454; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Xa2/rGglSjQqLiBjNfmyOdtgMqNZ1rc/kYTlcrSKm6A=; b=LBp26aA/VmLJ1rL7lxq7JsfDzLp417BedntX23A3Sxhuow9OiqxD13LKG7U+n4H4no5+WdHp
 NS5/zoTZLOZSghAY7E0MErcI3vRS6kyjQIIIj/pLGh6lOw+c/vU6OwW14WzIOn2ILt28uzlm
 hfreAienQcmStnbPPQEowNQ3ioc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e61eedb.7f2ecc2a3260-smtp-out-n02;
 Fri, 06 Mar 2020 06:34:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B74FEC4479F; Fri,  6 Mar 2020 06:34:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B845C43383;
        Fri,  6 Mar 2020 06:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B845C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org,
        dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, edumazet@google.com,
        jasowang@redhat.com, mkubecek@suse.cz, hayeswang@realtek.com,
        doshir@vmware.com, pv-drivers@vmware.com, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, gregkh@linuxfoundation.org,
        merez@codeaurora.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] wil6210: reject unsupported coalescing params
References: <20200306010602.1620354-1-kuba@kernel.org>
        <20200306010602.1620354-8-kuba@kernel.org>
Date:   Fri, 06 Mar 2020 08:33:55 +0200
In-Reply-To: <20200306010602.1620354-8-kuba@kernel.org> (Jakub Kicinski's
        message of "Thu, 5 Mar 2020 17:06:02 -0800")
Message-ID: <8736amouuk.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> Set ethtool_ops->supported_coalesce_params to let
> the core reject unsupported coalescing parameters.
>
> This driver did not previously reject unsupported parameters.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

As this goes to net-next:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
