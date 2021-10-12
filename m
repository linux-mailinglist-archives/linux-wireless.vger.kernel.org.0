Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1842A0CD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhJLJQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 05:16:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26838 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235528AbhJLJQx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 05:16:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634030092; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=WVAYj4pWS4vYz8R1uN6oSvdstfUkaZt7waIzqkcgYMk=; b=DYsiWiYu2qHAEYWuECkOeGDo8OC8uaS7034TJ8RoZ9wQW3fiDQDIDcbDaDGh/oYAvza1Xgip
 GK8KYhi1YZELc4PaiTAQn/ChzeBitBYttmKtqWJg0Oil0oxWZGJlESd/ZlxrxPJXzpRlK9K3
 QuzZLS88xNl8/zxwploZlOhJCaI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 616551f18ea00a941f025dbe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Oct 2021 09:14:25
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C60F5C4360D; Tue, 12 Oct 2021 09:14:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 709BEC43460;
        Tue, 12 Oct 2021 09:14:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Oct 2021 17:14:24 +0800
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: Advertise PLATFORM_CAP_PCIE_GLOBAL_RESET in qmi
 msg
Message-ID: <13074ee3556a72cd1f235a493c79f202@codeaurora.org>
X-Sender: bqiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-11 14:30, Kalle Valo wrote:
> Baochen Qiang <bqiang@codeaurora.org> writes:
> 
>> Inform firmware that host is capable of triggering a global reset.
>> This is requested by firmware team.
> 
> Why?
> 
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#answer_to_why

In some scenarios like rmmod/insmod, HW target needs to be completely 
reset. On ARM platforms we can rely on WL_EN pin and other power 
regulators to do this. However on x86 or some third party platforms, 
this has to be done by ath11k host by writing HW register 
PCIE_SOC_GLOBAL_RESET. But the problem is that some HW registers can not 
be cleared/restored. With this flag PLATFORM_CAP_PCIE_GLOBAL_RESET in 
QMI host_cap message, firmware can do some platform specific operations 
to fix this issue.
