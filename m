Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D13EA510
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Aug 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhHLNC3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Aug 2021 09:02:29 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46092 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236474AbhHLNCZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Aug 2021 09:02:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 8A53555E34D;
        Thu, 12 Aug 2021 13:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628773318; bh=Jq4WMNCDd/fqbEkLHmewjBl5JzHDmbC86CKiyzpiS54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Yl0Llu8xr2aAa+NG2BU8jnzOWnry2U3NEpYTS7yVL9D4NY6ABpNa1E8qV4DYLmtK1
         Igk/ZIj0uLhoCDURy0EuS/uhXoK1CclTdJEzUm+AyaGglV9Csctt2ycn+Yl4+M9/HS
         mbjIjB15pPLmqwatCIKQk+/deRe6LFmFnR5J/K4E=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zk7tElwEQNCn; Thu, 12 Aug 2021 13:01:58 +0000 (UTC)
Received: from www.akkea.ca (li1434-30.members.linode.com [45.33.107.30])
        by node.akkea.ca (Postfix) with ESMTPSA id EBC7C55E344;
        Thu, 12 Aug 2021 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628773318; bh=Jq4WMNCDd/fqbEkLHmewjBl5JzHDmbC86CKiyzpiS54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Yl0Llu8xr2aAa+NG2BU8jnzOWnry2U3NEpYTS7yVL9D4NY6ABpNa1E8qV4DYLmtK1
         Igk/ZIj0uLhoCDURy0EuS/uhXoK1CclTdJEzUm+AyaGglV9Csctt2ycn+Yl4+M9/HS
         mbjIjB15pPLmqwatCIKQk+/deRe6LFmFnR5J/K4E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Aug 2021 06:01:57 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     kernel@puri.sm, Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH v2 3/3] brcmfmac: add patch ram for bluetooth
In-Reply-To: <e8c3a3b0-17c6-ac85-7a14-5c100288341a@broadcom.com>
References: <20210811152804.2379405-1-angus@akkea.ca>
 <20210811152804.2379405-4-angus@akkea.ca>
 <d7d7fa89-916e-203a-8e7d-07cf88aa3fd1@broadcom.com>
 <e8c3a3b0-17c6-ac85-7a14-5c100288341a@broadcom.com>
Message-ID: <ca5ce64ffb9055eb0cace59caa973bad@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On 2021-08-12 04:42, Arend van Spriel wrote:
> On 8/12/2021 1:40 PM, Arend van Spriel wrote:
>> On 8/11/2021 5:28 PM, Angus Ainslie wrote:
>>> Bluetooth on the BCM43752 needs a patchram file to function 
>>> correctly.
>> 
>> this patch is dealing with bluetooth so you should add the proper 
>> mailing list.
> 
> ...and the 'brcmfmac:' prefix in the subject is inappropriate. It
> should  be 'btbcm:' instead.
> 

Thanks for looking at the patches I'll fix them up for v3.

Angus

> Regards,
> Arend
