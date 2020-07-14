Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6748C21ED34
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGNJut (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:50:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51875 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgGNJur (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:50:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594720247; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4vzJbMhp8IQfFnR1TpqusTcbANp0YTZrLYXPD6Mh7WA=;
 b=SrcVopH4ChkB78DtkrczeeEwgmRsC0jnsQOa/4PyVOA58HrzucSTnJvDgcSXBXEiY91UoZ6m
 N4h9FL5PJO+74AAFeWPnessbXJekh6mXZJ8p4K9+vDqOzQsZfD2Lb3DoYWU9JwoO14jTbWVb
 TaFcn4Vs/sYhT/h68ZXxbNpf8j0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f0d7fe310127684905acdd0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:50:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3FB8C43391; Tue, 14 Jul 2020 09:50:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A034C433CA;
        Tue, 14 Jul 2020 09:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A034C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] brcmfmac: set state of hanger slot to FREE when
 flushing PSQ
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200624091608.25154-2-wright.feng@cypress.com>
References: <20200624091608.25154-2-wright.feng@cypress.com>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714095026.A3FB8C43391@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 09:50:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> wrote:

> When USB or SDIO device got abnormal bus disconnection, host driver
> tried to clean up the skbs in PSQ and TXQ (The skb's pointer in hanger
> slot linked to PSQ and TSQ), so we should set the state of skb hanger slot
> to BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb.
> In brcmf_fws_bus_txq_cleanup it already sets
> BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb, therefore we add the
> same thing in brcmf_fws_psq_flush to avoid following warning message.
> 
>    [ 1580.012880] ------------   [ cut here ]------------
>    [ 1580.017550] WARNING: CPU: 3 PID: 3065 at
> drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c:49
> brcmu_pkt_buf_free_skb+0x21/0x30 [brcmutil]
>    [ 1580.184017] Call Trace:
>    [ 1580.186514]  brcmf_fws_cleanup+0x14e/0x190 [brcmfmac]
>    [ 1580.191594]  brcmf_fws_del_interface+0x70/0x90 [brcmfmac]
>    [ 1580.197029]  brcmf_proto_bcdc_del_if+0xe/0x10 [brcmfmac]
>    [ 1580.202418]  brcmf_remove_interface+0x69/0x190 [brcmfmac]
>    [ 1580.207888]  brcmf_detach+0x90/0xe0 [brcmfmac]
>    [ 1580.212385]  brcmf_usb_disconnect+0x76/0xb0 [brcmfmac]
>    [ 1580.217557]  usb_unbind_interface+0x72/0x260
>    [ 1580.221857]  device_release_driver_internal+0x141/0x200
>    [ 1580.227152]  device_release_driver+0x12/0x20
>    [ 1580.231460]  bus_remove_device+0xfd/0x170
>    [ 1580.235504]  device_del+0x1d9/0x300
>    [ 1580.239041]  usb_disable_device+0x9e/0x270
>    [ 1580.243160]  usb_disconnect+0x94/0x270
>    [ 1580.246980]  hub_event+0x76d/0x13b0
>    [ 1580.250499]  process_one_work+0x144/0x360
>    [ 1580.254564]  worker_thread+0x4d/0x3c0
>    [ 1580.258247]  kthread+0x109/0x140
>    [ 1580.261515]  ? rescuer_thread+0x340/0x340
>    [ 1580.265543]  ? kthread_park+0x60/0x60
>    [ 1580.269237]  ? SyS_exit_group+0x14/0x20
>    [ 1580.273118]  ret_from_fork+0x25/0x30
>    [ 1580.300446] ------------   [ cut here ]------------
> 
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

2 patches applied to wireless-drivers-next.git, thanks.

fcdd7a875def brcmfmac: set state of hanger slot to FREE when flushing PSQ
2fa8085fc6da brcmfmac: set pacing shift before transmitting skb to bus

-- 
https://patchwork.kernel.org/patch/11622711/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

