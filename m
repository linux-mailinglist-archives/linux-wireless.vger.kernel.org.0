Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74F2119B6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 03:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGBBlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 21:41:42 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:14910 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgGBBll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 21:41:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593654101; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nmZzLNt53GfKoOAKp8c0Yyn5fSTpsJPmdlJk3vGYkOw=;
 b=qosCaFknyoNGisn2d1gJM+c2WCVsrbIFvlAS0sXYEL23PIe3TmChqOOl5KFX0eFFqWs0y2OR
 S7L7br420OR/IO7zsZonlL2esco9lWChBAoxPJHQrFHuT/DCW/saIWohC0nGb1RKAy5mJ30f
 Mdl53oQ+hP2FnDyXH/KTb9hgN6c=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5efd3b4bfe1db4db89417100 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 01:41:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 695DBC433C6; Thu,  2 Jul 2020 01:41:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38B54C433C8;
        Thu,  2 Jul 2020 01:41:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Jul 2020 18:41:31 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: BUG: HE CAP IE is build on hw without HE support in mesh mode
In-Reply-To: <6d0293f4-20ae-1069-0221-dbc2f7254682@tu-ilmenau.de>
References: <6d0293f4-20ae-1069-0221-dbc2f7254682@tu-ilmenau.de>
Message-ID: <caf404115e5691bd4dfbac29e3e7769e@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-30 07:40, Markus Theil wrote:
> Hi,
> 
> I was able to trigger the following warning with the current
> wireless-testing git as of 2020-06-30.
> wpa_supplicant joins a mesh on ath10k hw without HE support and
> therefore should not run into this warning.
> 
Thanks for reporting the issue. iftype_data is valid for 11ax
devices only. Hence the warning is thrown in 11ac device. Will fix
it asap.

-Rajkumar
