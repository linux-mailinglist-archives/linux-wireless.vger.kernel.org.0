Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0752A22706A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGTVgz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 17:36:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:46509 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgGTVgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 17:36:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595281014; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hrUxiaN0+bJDpV8mVbjuXDvVJj5OSPVWBWcrtVvpfBY=;
 b=hT/HfTS8ljc4JDSB/tOgEfsd11MgbtOhQpc50eBfwicIpx4qt1N2507vuZ/zYKsm3WzTNY+g
 CC3QwhuOmCuvBHCmUfV9kzy7uDIhTlKorLRwcTYpDq8wUCfv8s7qmWzc/PneTRLR4tHatsBa
 eYuubvEjusmt92vPtXcow+nJ/0Q=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5f160e727c8ca473a8295802 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 21:36:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E36E9C433CB; Mon, 20 Jul 2020 21:36:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E4C4C433C9;
        Mon, 20 Jul 2020 21:36:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jul 2020 14:36:49 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Unsolicited broadcast probe resp support
In-Reply-To: <8b8a5ec5-52e3-50e8-08e6-dc2ee20ec1bf@broadcom.com>
References: <20200715230514.26792-1-alokad@codeaurora.org>
 <8b8a5ec5-52e3-50e8-08e6-dc2ee20ec1bf@broadcom.com>
Message-ID: <7ced7462e3093c77831481663c92b971@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-16 02:35, Arend Van Spriel wrote:
> On 7/16/2020 1:05 AM, Aloka Dixit wrote:
>> Unsolicited broadcast probe response tranmission is used for in-band
>> discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior 
>> for
>> fast passive scanning).
>> 
>> v3: Rebased. Removed check for 6Ghz, drivers should add that check.
> 
> I have not seen any comments in v2 so could you motivate this removal.
> It is a sanity check that is always needed so doing it in the nl80211
> api seems the proper place.
> 
> Regards,
> Arend

Hi Arend,
I found that if any application sends 
NL80211_ATTR_UNSOL_BCAST_PROBE_RESP with 
NL80211_UNSOL_BCAST_PROBE_RESP_INT=0 (which means disable) for 2.4/5GHz, 
the check here resulted in AP not being brought up.
Technically disabling this feature for 2.4/5GHz is not required as it is 
disabled by default but it should not cause issues if done so 
explicitly. Hence I removed the check here so that drivers can decide to 
use/ignore this attribute.
