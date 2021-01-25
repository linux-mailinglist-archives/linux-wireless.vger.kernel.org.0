Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CBF302E66
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 22:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbhAYVxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 16:53:41 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:35377 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733095AbhAYVxc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 16:53:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611611591; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KscB0GPHQ0ehYJeRFAeSeXcjWOC16Fmsc5gIQdGttuY=;
 b=i58pwgUB9U1EpsWCVKfXtgNy2+L+DYSFiGpvU0tsp9mttDHoE2YzVvxZxlBbkGYdALiljbZh
 yiG2odc9Tw/SmU1oYEfvUs9qy6hr/dWAfpzA/C+Sh7MogRTekna9IV886Miw3pCuXMBs1jQt
 mWhJdAotmUtFxpCOP7uKinXNy5o=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 600f3da32c36b2106dd15834 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 21:52:35
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87FA8C433CA; Mon, 25 Jan 2021 21:52:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 586CDC433C6;
        Mon, 25 Jan 2021 21:52:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Jan 2021 13:52:33 -0800
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] nl80211: Commands for FILS discovery and unsolicited
 broadcast probe response
In-Reply-To: <ca7281ce-70bb-d1e2-3ec2-f07d91145c04@broadcom.com>
References: <20210120005229.32582-1-alokad@codeaurora.org>
 <20210120005229.32582-2-alokad@codeaurora.org>
 <ca7281ce-70bb-d1e2-3ec2-f07d91145c04@broadcom.com>
Message-ID: <430f10a576b8490f73827f800c87f58c@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-01-20 02:10, Arend van Spriel wrote:
> On 20-01-2021 01:52, Aloka Dixit wrote:
>> This change moves the FILS discovery and unsolicited probe response
>> configurations to new netlink commands instead of during beacon set 
>> up.
>> It allows modification of transmission parameters such as time 
>> interval
>> dynamically.
> 
> Why not have both, ie. support initial setup through START_AP and
> allow modifications with new command or an existing one. Maybe we
> should consolidate to what has been discussed in thread about AP power
> save [1].
> 
> Regards,
> Arend
> 
> [1]
> https://patchwork.kernel.org/project/linux-wireless/patch/1598257589-19091-1-git-send-email-vnaralas@codeaurora.org/

Hi Arend,
FILS discovery and especially unsolicited probe response templates are 
big. Sometimes send_and_recv() returns error due to memory 
unavailability during wpa_driver_nl80211_set_ap() depending on how many 
interfaces, which elements are added. Moving these to separate commands 
resolves this issue along with more control over the time interval 
during run-time.
Thanks.
