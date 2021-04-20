Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8773336518C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 06:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhDTEfg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 00:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDTEff (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 00:35:35 -0400
Received: from mout1.freenet.de (mout1.freenet.de [IPv6:2001:748:100:40::2:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8A7C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 21:35:04 -0700 (PDT)
Received: from [195.4.92.123] (helo=sub4.freenet.de)
        by mout1.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1lYi6E-0002LB-9X
        for linux-wireless@vger.kernel.org; Tue, 20 Apr 2021 06:34:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
        ; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bfs0G4Qvn+cN+RZTBipqOZGRGheTaQInTbaJS+JmIx8=; b=WgYs8xfAC2lphn0ShVHnv7LH77
        XKZuPkdclF5SDgGOUOymXziM6EoT2EqwW0CVds/XQXvXJY0u8aCNRuFySygVrnS4uISJ11ut6/GW0
        bkfvPmFfe+NxcINjiWpSE0zDUrVZSydk+b9BdyFPLF9gKJLGS32UhQiglJ97Dp79XpvRrhIAXoxd2
        iitYfs8k/NGS+WixzJhdLBYi7jXSkOWKqFtm77q/jC3/msnTJrim2NWJKqWgZ5MuXPAYD5C3psuIy
        uoaUKiQv8Rm1ftgIVrdi0oySwlX91SbxP4LVZ9M2Ut2+Y5Vnv2JCPI9YuevKapgZLv5rgCGNmAbTC
        I1vE2cmw==;
Received: from p200300de57147b00505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:5714:7b00:5054:ff:fe15:ac42]:51472 helo=mail.maya.org)
        by sub4.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1lYi6E-0003Us-QT
        for linux-wireless@vger.kernel.org; Tue, 20 Apr 2021 06:34:58 +0200
Received: internal info suppressed
Subject: Re: rtw88 strange killall behaviour with nm
To:     linux-wireless@vger.kernel.org
References: <20210420.063244.1157699536418751229.enometh@meer.net>
From:   =?UTF-8?Q?Klaus_M=c3=bcller?= <kmueller@justmail.de>
Message-ID: <9167fd6d-affa-21d5-bd8d-0fb3d49d38f0@justmail.de>
Date:   Tue, 20 Apr 2021 06:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420.063244.1157699536418751229.enometh@meer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originated-At: 2003:de:5714:7b00:5054:ff:fe15:ac42!51472
X-FNSign: v=2 s=859FF7F4090CCC937F71A97CB7C4FD5CD44BAF6FAB9927A3320C8F9FD500C8B9
X-Scan-TS: Tue, 20 Apr 2021 06:34:58 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20.04.21 at 03:02 Madhu wrote:
> 
> I was using the rtw88 on (lspci: Realtek. RTL8822CE 802.11ac PCIe on a
> Lenovo Thinkbook) fairly normally on gentoo (kernel 5.10.30) with
> netifrc scripts.  Recently I tried to move the scripts to
> networkmanager connection files.

Did you try https://github.com/lwfinger/rtw88


Thanks
Klaus
