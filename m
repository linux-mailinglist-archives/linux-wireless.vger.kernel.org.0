Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF471C8255
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 08:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEGGQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 02:16:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:54580 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgEGGP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 02:15:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588832157; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=8tdYvc/Ysg+HCDbSIsv9tXxZGN5x8N74gSEsCb6EWiw=; b=fz89A360JTPfeBdECIkq0MO+QRFxMSAIedSOIKeBtUbJRi7zmWsvtW6nVq1LRMk2UVvvMwBL
 bsXpjd+/aVklo9k18x6Kfr64lgm7Xxmz1LNVbsYVkXBmDLh+koELW5IU/VDGAG+0wIOSMzuv
 0gJiK+1sOokNmAAoW50HZGDkx9g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3a794.7f2214f54260-smtp-out-n01;
 Thu, 07 May 2020 06:15:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1B21C433D2; Thu,  7 May 2020 06:15:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [183.83.68.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CE2AC433F2;
        Thu,  7 May 2020 06:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CE2AC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   <pillair@codeaurora.org>
To:     "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1588667015-25490-1-git-send-email-pillair@codeaurora.org> <875zd88ei8.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <875zd88ei8.fsf@kamboji.qca.qualcomm.com>
Subject: RE: [PATCH v2] ath10k: Remove msdu from idr when management pkt send fails
Date:   Thu, 7 May 2020 11:45:42 +0530
Message-ID: <000001d62436$f253f230$d6fbd690$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJNqVSadgw8XSq3avDEjUfHwl9lpQGgpyrrp6AVlFA=
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,
Yes, The change you did is correct and better.
So should I be sending a v3 for this patch ?

Thanks,
Rakesh Pillai.

> -----Original Message-----
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Thursday, May 7, 2020 11:37 AM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k@lists.infradead.org; linux-wireless@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] ath10k: Remove msdu from idr when management
> pkt send fails
> 
> Rakesh Pillai <pillair@codeaurora.org> writes:
> 
> > Currently when the sending of any management pkt
> > via wmi command fails, the packet is being unmapped
> > freed in the error handling. But the idr entry added,
> > which is used to track these packet is not getting removed.
> >
> > Hence, during unload, in wmi cleanup, all the entries
> > in IDR are removed and the corresponding buffer is
> > attempted to be freed. This can cause a situation where
> > one packet is attempted to be freed twice.
> >
> > Fix this error by rmeoving the msdu from the idr
> > list when the sending of a management packet over
> > wmi fails.
> >
> > Tested HW: WCN3990
> > Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> >
> > Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference
> support over wmi")
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> 
> [...]
> 
> > --- a/drivers/net/wireless/ath/ath10k/wmi-ops.h
> > +++ b/drivers/net/wireless/ath/ath10k/wmi-ops.h
> > @@ -133,6 +133,7 @@ struct wmi_ops {
> >  	struct sk_buff *(*gen_mgmt_tx_send)(struct ath10k *ar,
> >  					    struct sk_buff *skb,
> >  					    dma_addr_t paddr);
> > +	int (*cleanup_mgmt_tx_send)(struct ath10k *ar, struct sk_buff
> *msdu);
> >  	struct sk_buff *(*gen_dbglog_cfg)(struct ath10k *ar, u64
> module_enable,
> >  					  u32 log_level);
> >  	struct sk_buff *(*gen_pktlog_enable)(struct ath10k *ar, u32 filter);
> > @@ -442,6 +443,15 @@ ath10k_wmi_get_txbf_conf_scheme(struct ath10k
> *ar)
> >  }
> >
> >  static inline int
> > +ath10k_wmi_cleanup_mgmt_tx_send(struct ath10k *ar, struct sk_buff
> *msdu)
> > +{
> > +	if (!ar->wmi.ops->cleanup_mgmt_tx_send)
> > +		return -EOPNOTSUPP;
> > +
> > +	return ar->wmi.ops->cleanup_mgmt_tx_send(ar, msdu);
> > +}
> > +
> > +static inline int
> >  ath10k_wmi_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
> >  			dma_addr_t paddr)
> >  {
> > @@ -457,8 +467,11 @@ ath10k_wmi_mgmt_tx_send(struct ath10k *ar,
> struct sk_buff *msdu,
> >
> >  	ret = ath10k_wmi_cmd_send(ar, skb,
> >  				  ar->wmi.cmd->mgmt_tx_send_cmdid);
> > -	if (ret)
> > +	if (ret) {
> > +		/* remove this msdu from idr tracking */
> > +		ath10k_wmi_cleanup_mgmt_tx_send(ar, msdu);
> >  		return ret;
> > +	}
> 
> I missed that this call was in wmi-ops.h, but the idea is that file
> should be just a dumb wrapper and not have any logic. So I moved this to
> mac.c, the functionality should be the same but please do check my
> changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=m
> aster-pending&id=71195d2244ed812c73dc617f7536566400f7ce87
> 
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches
