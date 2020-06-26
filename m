Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8420B8A2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 20:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgFZSte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 14:49:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23674 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFZStd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 14:49:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593197372; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=ngROJ/2w2XFc9NxoIGxpr+0+OqWMvWdIv4xbcHTgnlc=; b=QIusmmCM61swb0tP4a217ygj3wWduXHcDGcEgsTKl73Sofpw/c+obXkShDkGo/bdlD2qbE+3
 1mtu9bGC/19MfvwkVPVerFs2d2lUWaeR6c+fHwfkaObjqcNJ3Tt3OxVfoPJ2Xthx8WH54P4o
 YEtfIjwrPIa0GtjiCkOoypw1H2U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ef643385866879c763d70c7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:49:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72812C433CB; Fri, 26 Jun 2020 18:49:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [183.83.71.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 314E2C433C6;
        Fri, 26 Jun 2020 18:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 314E2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Ben Greear'" <greearb@candelatech.com>,
        <ath10k@lists.infradead.org>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1593195100-24654-1-git-send-email-pillair@codeaurora.org> <1593195100-24654-3-git-send-email-pillair@codeaurora.org> <69ea745d-8d7c-6220-ad0e-f70ffa3e242a@candelatech.com>
In-Reply-To: <69ea745d-8d7c-6220-ad0e-f70ffa3e242a@candelatech.com>
Subject: RE: [PATCH 2/2] ath10k: Skip wait for delete response if firmware is down
Date:   Sat, 27 Jun 2020 00:19:23 +0530
Message-ID: <000001d64bea$84b3ba90$8e1b2fb0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNiuYBFzypkjFclSJoPOKbq85JhQHwsTFgAYEyKP6o4S/gAA==
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Ben Greear <greearb@candelatech.com>
> Sent: Friday, June 26, 2020 11:57 PM
> To: Rakesh Pillai <pillair@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] ath10k: Skip wait for delete response if firmware
is
> down
> 
> 
> 
> On 06/26/2020 11:11 AM, Rakesh Pillai wrote:
> > Currently the driver waits for response from the
> > firmware for all the delete cmds, eg: vdev_delete,
> > peer delete. If the firmware is down, these wait
> > will always timeout and return an error.
> >
> > Also during subsytems recovery, any attempt to
> > send a WMI cmd to the FW will return the -ESHUTDOWN
> > status, which when returned to mac80211, can cause
> > unnecessary warnings to be printed on to the console,
> > as shown below
> >
> > [ 2559.529565] Call trace:
> > [ 2559.532214]  __sta_info_destroy_part2+0x160/0x168 [mac80211]
> > [ 2559.538157]  __sta_info_flush+0x124/0x180 [mac80211]
> > [ 2559.543402]  ieee80211_set_disassoc+0x130/0x2c0 [mac80211]
> > [ 2559.549172]  ieee80211_mgd_deauth+0x238/0x25c [mac80211]
> > [ 2559.554764]  ieee80211_deauth+0x24/0x30 [mac80211]
> > [ 2559.559860]  cfg80211_mlme_deauth+0x258/0x2b0 [cfg80211]
> > [ 2559.565446]  nl80211_deauthenticate+0xe4/0x110 [cfg80211]
> > [ 2559.571064]  genl_rcv_msg+0x3a0/0x440
> > [ 2559.574888]  netlink_rcv_skb+0xb4/0x11c
> > [ 2559.578877]  genl_rcv+0x34/0x48
> > [ 2559.582162]  netlink_unicast+0x14c/0x1e4
> > [ 2559.586235]  netlink_sendmsg+0x2f0/0x360
> > [ 2559.590317]  sock_sendmsg+0x44/0x5c
> > [ 2559.593951]  ____sys_sendmsg+0x1c8/0x290
> > [ 2559.598029]  ___sys_sendmsg+0xa8/0xfc
> > [ 2559.601840]  __sys_sendmsg+0x8c/0xd0
> > [ 2559.605572]  __arm64_compat_sys_sendmsg+0x2c/0x38
> > [ 2559.610468]  el0_svc_common+0xa8/0x160
> > [ 2559.614372]  el0_svc_compat_handler+0x2c/0x38
> > [ 2559.618905]  el0_svc_compat+0x8/0x10
> >
> > Skip the wait for delete response from the
> > firmware if the firmware is down. Also return
> > success to the mac80211 calls when the peer delete
> > cmd fails with return status -ESHUTDOWN.
> >
> > Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/mac.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/mac.c
> b/drivers/net/wireless/ath/ath10k/mac.c
> > index dc7befc..7ac6549 100644
> > --- a/drivers/net/wireless/ath/ath10k/mac.c
> > +++ b/drivers/net/wireless/ath/ath10k/mac.c
> > @@ -701,7 +701,8 @@ static void
> ath10k_wait_for_peer_delete_done(struct ath10k *ar, u32 vdev_id,
> >  	unsigned long time_left;
> >  	int ret;
> >
> > -	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map))
> {
> > +	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map)
> &&
> > +	    test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
> 
> Don't you mean !test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
> ???
> 
> Or maybe I'm just mis-reading your patch?

Hi Ben,
Yes, it should be !test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)).
I will send out a v2.


> 
> Thanks,
> Ben
> 
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

