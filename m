Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28C1155D2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 17:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFQyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 11:54:21 -0500
Received: from mail.schafweide.org ([185.45.112.52]:52648 "EHLO
        mail.schafweide.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfLFQyV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 11:54:21 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Dec 2019 11:54:20 EST
Received: from [IPv6:2a07:59c6:eeff:20:ad03:27fd:6840:662f] (unknown [IPv6:2a07:59c6:eeff:20:ad03:27fd:6840:662f])
        by mail.schafweide.org (Postfix) with ESMTPSA id 2F7C32A392C
        for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2019 17:48:34 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=schafweide.org;
        s=default; t=1575650915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=owKIjhIxBTZS4DpEV27wCw0FEzuUwa7mFHHe+m9V5MM=;
        b=Pq6G+4Gh2Uhc2f4T61mc2edi2lHEFL0pWLOyTwccKx9H5V08PW2uZdpkp5vCsXwBlMnKlV
        ObSVMFxHkMMiqTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schafweide.org;
        s=rsa; t=1575650915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=owKIjhIxBTZS4DpEV27wCw0FEzuUwa7mFHHe+m9V5MM=;
        b=w8qBAxAL2m4XQTR6QWkguIAF29jCxiGLtxbRb98X08WweflX35gkJsYfQ6gycEb6pHQssu
        xw+6j9mAOpfLHnJVEnYHp5PzMz7cGO6Bku1WoubRtHCx+Pq8oJPoEW5+iFFZq09RWXkjkW
        5cxMyQYdTGPH9z5e/m3gsGvGpLhw/2U=
To:     linux-wireless@vger.kernel.org
From:   Bjoern Franke <bjo@schafweide.org>
Subject: Realtek 8822BE: r8822be vs. rtwpci (mainline / lwfinger)
Message-ID: <50038b2f-8b90-d803-0377-2c19cc7ad78e@schafweide.org>
Date:   Fri, 6 Dec 2019 17:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-LU
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm a little confused about the status of the modules for the Realtek 
8822BE.

Once, there was r8822be which had some issues, but worked more or less 
reliable. Then came rtw88/rtwpci and in my Thinkpad A275 it is hardly 
usable. According to the router, a 390Mbit AC connection exists, but 
downloads drop to 70-100kb/s. The TX-Bitrate is stuck at 6.5Mbit and the 
rx drop misc counter increases nearly every second from time to time - 
while being at the same place all the time, 5m away from the router, a 
FritzBox 7590.

In contrast to the mainline module, lwfingers module does not have the 
TX-Bitrate-stuck issue and the connection drops are more rarely.

I switched to the 4.19 LTS kernel and r8822be gets a 866Mbit AC 
connection with 200-300Mbit througput, which is somehow impressive 
compared to the 50kbit-40Mbit of rtwpci. In addition, it shows that the 
issues seem not to be caused by interferences, as here are only 3 5Ghz 
wifis.

Can I do something to improve the situation regarding rtwpci?

Best Regards
Bjoern
