Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC840BE6E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 05:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhIODtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 23:49:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59311 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhIODtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 23:49:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631677668; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oqHO6JlbOAOXTUPmmHQQGEh95mrZbQ3CcN3icP5T8lY=;
 b=cpnSg62se9U3YVKFf0NHKYwBsX1kNXxSrwMKQKK069zzsFPu9dsvpKyWLZGYeDkvrGXiyzub
 nIqtBEJkXSP76WKdcJYdQIS1iOypq6aeocwws64nSfHYbAcGeb6QtRVe55s3Bde31rUsmB7+
 vdbNFoSwkucQWYkp3+iKH+ozykg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61416ce3bd6681d8ed4ba0a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Sep 2021 03:47:47
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3A11AC4360C; Wed, 15 Sep 2021 03:47:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 164FCC4338F;
        Wed, 15 Sep 2021 03:47:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Sep 2021 20:47:15 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v11 0/4] multiple bssid and EMA support in AP mode
In-Reply-To: <849e2cf64fbf774fec9c30003e828aaf2d12a6d7.camel@sipsolutions.net>
References: <20210715070745.5033-1-alokad@codeaurora.org>
 <849e2cf64fbf774fec9c30003e828aaf2d12a6d7.camel@sipsolutions.net>
Message-ID: <8263a758863ac8fcd2d4ae6b36668bc8@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-17 03:35, Johannes Berg wrote:
> On Thu, 2021-07-15 at 00:07 -0700, Aloka Dixit wrote:
>> This patchset adds support for multiple BSSID and
>> enhanced multi-BSSID advertisements for AP mode.
>> Individual patches describe the changes in this version.
> 
> How about adding the trivial advertisement to hwsim so we can have some
> tests in hostapd?
> 
> johannes

Hi Johannes,
Yes, I plan to add hwsim advertisement separately once kernel
changes are accepted. Will also add hostapd testcases at the
same time.
Thanks.
