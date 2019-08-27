Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C779E54B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfH0KEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 06:04:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfH0KE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 06:04:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A7C3611BE; Tue, 27 Aug 2019 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566900268;
        bh=mKpU5ukQpG6xrPPNu7zxQ/8rKR28a4u1rfmuS6oZCKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JTF6S9AmpNr5ouKcSHU0BibXx4iYspj14ler8tmdLkvg3LYfiYR/6zakZyzVgC8Br
         b5L6hmEeV58gVWUpXYwgGiPDhmvhDxmFK298pttNMKvenjBXr3L+EbGxmgHAbY2+nr
         k2IEpWKyor6sX2m5nl7jWDGCiCz8k15Z+AutA7xc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2EBE7611BF;
        Tue, 27 Aug 2019 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566900267;
        bh=mKpU5ukQpG6xrPPNu7zxQ/8rKR28a4u1rfmuS6oZCKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V2sQStDLFK36TxSrONAP4t5GIMVbyLnZgb3T/CD1Bj93s8yK+AuKfaaWCcUgemxVv
         ugybbW+CRhI7T0ffX3LSay6+B9R1Kt0an4jlUtNyoseGXvrvCjnfQHx6FwJbn8KkdG
         ZPaT9hFG2uNnSuW/vpPVZ1Mvjq0JmrkHiy7FgKW4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Aug 2019 15:34:27 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 10/49] ath11k: add debug.c
In-Reply-To: <18655975.RomJW5s5WE@bentobox>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <4441194.D8eDD6Tzdi@bentobox>
 <6622b83f754404ec05b9442027757c5e@codeaurora.org>
 <18655975.RomJW5s5WE@bentobox>
Message-ID: <f93b9c98fcfb9a910c3efc04d11d5aa0@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-27 15:23, Sven Eckelmann wrote:
> On Tuesday, 27 August 2019 11:04:23 CEST Anilkumar Kolli wrote:
> [...]
>> > Yes, but it shouldn't kill the complete system.
>> >
>> This will not kill the whole system, This will crash target and we 
>> have
>> mechanism to recover the system.
>> 
>> Hope u have generated the crash with below patch,
>> https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches/019-ath11k-disable-q6-recovery-to-crash-kernel.patch?h=win_ap.1.0
>> 
>> Please remove this patch to see the target recover after the crash.
> 
> John also pointed me to this patch yesterday and I have now removed it.
> 
> But the wifi hardware doesn't recover after issuing an assert. All(?) 
> firmware
> request will just timeout:
> 
>     [ 1093.114530] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1093.114555] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1093.118903] ath11k c000000.wifi1: Failed to set dtim period for
> VDEV 0: -11
>     [ 1096.124532] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1096.124554] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1096.128902] ath11k c000000.wifi1: Failed to set CTS prot for 
> VDEV: 0
>     [ 1099.134527] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1099.134547] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1099.138895] ath11k c000000.wifi1: Failed to set preamble for 
> VDEV: 0
>     [ 1102.144526] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1102.144546] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1102.148894] ath11k c000000.wifi1: failed to set mgmt tx rate -11
>     [ 1105.154526] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1105.154547] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1105.158895] ath11k c000000.wifi1: failed to set beacon tx rate 
> -11
>     [ 1114.164529] ath11k c000000.wifi1: wmi command 16387 timeout
>     [ 1114.164553] ath11k c000000.wifi1: failed to send 
> WMI_PDEV_SET_PARAM cmd
>     [ 1114.168899] ath11k c000000.wifi1: Failed to set beacon mode for 
> VDEV: 0
>     [ 1117.174527] ath11k c000000.wifi1: wmi command 28675 timeout
>     [ 1117.174550] ath11k c000000.wifi1: failed to send 
> WMI_BCN_TMPL_CMDID
>     [ 1117.178899] ath11k c000000.wifi1: failed to submit beacon
> template command: -11
>     [ 1117.185231] ath11k c000000.wifi1: failed to update bcn template: 
> -11
>     [ 1120.184524] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1120.184545] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1120.188893] ath11k c000000.wifi1: Failed to set dtim period for
> VDEV 0: -11
>     [ 1123.194527] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1123.194548] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1123.198895] ath11k c000000.wifi1: Failed to set CTS prot for 
> VDEV: 0
>     [ 1126.204526] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1126.204547] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1126.208894] ath11k c000000.wifi1: Failed to set preamble for 
> VDEV: 0
>     [ 1129.214527] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1129.214548] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1129.218897] ath11k c000000.wifi1: failed to set mgmt tx rate -11
>     [ 1132.224525] ath11k c000000.wifi1: wmi command 20488 timeout
>     [ 1132.224546] ath11k c000000.wifi1: failed to send 
> WMI_VDEV_SET_PARAM_CMDID
>     [ 1132.228894] ath11k c000000.wifi1: failed to set beacon tx rate 
> -11
> 
> ath11k must be unloaded + loaded again to fix this problem.
> 

Could you plz try removing below patch?
https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches/072-ath11k-print-stats-on-crash.patch?h=win_ap.1.0

-- 
Thanks
Anil.
