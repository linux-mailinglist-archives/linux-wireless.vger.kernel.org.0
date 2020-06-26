Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59220B954
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgFZTcy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 15:32:54 -0400
Received: from mon2.sibername.com ([162.144.51.228]:56532 "EHLO
        mon1.sibername.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgFZTcx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 15:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E6r3CUCbrO4IhnYRkTE+e9pWhAgTmJuguOMlWynyBTM=; b=rguxwNvD7z8I6q7acRDHArTd4t
        MO5VJTM2SE+8Vtdq/8fE4m3VaXJ8BFsX/MG9cSqZJQv4Tcm3RrIfX9u1PBSZ2srIUO8Fz2CC5qias
        FKVwf3vgWjrkLvHWPKIC6sNh3Xy4Khf6u9yFpsc+O5azwX/zrMNGxvxVlIpW6nzY0DH7fTSlVlFB+
        LrUh67jMoERTJ6zXq+bG4Kwta9iwAhBglfTidd4tJBpBIHste59KSSKQwsCUJ1ELCfpv1AUKqGa+6
        qJLleMIh4ZJocl4iwqKe6sARKj6X4hszRzM+4qm1ZcNEggexQXA6pw4mGzXTqWH95hyrLiqh8Zukm
        4gcoIbTA==;
Received: from 216-58-17-101.cpe.distributel.net ([216.58.17.101]:46804 helo=[192.168.1.4])
        by montreal.sibername.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bjlockie@lockie.ca>)
        id 1jou5g-005kuy-Li
        for linux-wireless@vger.kernel.org; Fri, 26 Jun 2020 15:32:52 -0400
From:   James <bjlockie@lockie.ca>
Subject: Alfa AWUS036ACM (Mediatek MT7612U) AP problem
To:     linux-wireless@vger.kernel.org
Message-ID: <ba64416e-d34b-9bdd-d482-6ea722e3d6b9@lockie.ca>
Date:   Fri, 26 Jun 2020 15:32:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - montreal.sibername.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: montreal.sibername.com: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: montreal.sibername.com: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have an Alfa AWUS036ACM (Mediatek MT7612U).
My AP keeps dieing.
The error:
mt76x2u: error: mt76x02u_mcu_wait_resp failed with -110
seems to be common.

I use it with a build of a OpenWrt on a Raspberry Pi 4 (Broadcom BCM2711 
SoC, ARM Cortex-A72 processor (64bit)).
Linux OpenWrt 5.4.48 #0 SMP Thu Jun 25 00:36:19 2020 aarch64 GNU/Linux
Loading modules backported from Linux version v5.7-rc3-0-g6a8b55ed4056

# lsmod | grep mt76
cfg80211              339968  5 
mt76x02_usb,mt76x02_lib,mt7603e,mt76,mac80211
mac80211              589824  7 
mt76x2u,mt76x2e,mt76x02_usb,mt76x02_lib,mt7603e,mt76_usb,mt76
mt76                   45056  7 
mt76x2u,mt76x2e,mt76x2_common,mt76x02_usb,mt76x02_lib,mt7603e,mt76_usb
mt76_usb               24576  2 mt76x2u,mt76x02_usb
mt7603e                53248  0
mt76x02_lib            61440  4 mt76x2u,mt76x2e,mt76x2_common,mt76x02_usb
mt76x02_usb            20480  1 mt76x2u
mt76x2_common          20480  2 mt76x2u,mt76x2e
mt76x2e                20480  0
mt76x2u                20480  0

I bought a powered USB3 hub and removed a USB3 cable in case that is 
related but the problem is still there.

I've been documenting my problems:
https://github.com/openwrt/mt76/issues/405#
Are any of the tracebacks useful?

I found this:
https://github.com/openwrt/mt76/issues/403
>
>
>       *LorenzoBianconi *commented on May 10
>
> @petrkalosthis conditions is used to reset the device in case of 
> necessary (it is in the vendor sdk). You can try to comment it out and 
> see what happen
>
I downloaded 
https://d86o2zu8ugzlg.cloudfront.net/mediatek-craft/drivers/MT7612U_DPO_LinuxSTA_3.0.0.1_20140718.tar.bz2
and there is no "mcu_wait_resp".

I also found this:
https://github.com/raspberrypi/linux/issues/3014


What 80211.ac USB adapter has the best (most open and compatible) now 
(or likely) linux kernel support?

