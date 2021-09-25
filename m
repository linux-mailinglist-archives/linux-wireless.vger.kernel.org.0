Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4D417F92
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 06:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhIYEUM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 00:20:12 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:48480 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhIYEUL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 00:20:11 -0400
X-Greylist: delayed 1823 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Sep 2021 00:20:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=G6L6M
        I94StYQ1FKd4nLBQOZ8gkFOV+FuvhL6iGB9Pxc=; b=lkoJygoqdrz+zTqtMzDdv
        isT1BSmebzds1RwFjNPyQBer5NI+37vmxBNkxVlMv+KrY/DpC9U/5qzGZJmi/eye
        00+bojJ3UHT5fagRU6Z0H7nMU63Cdw631VTGkM5f+jbBd3Wu3vzKFjWGuBC9LViZ
        IG0zrQwZOURzpkB+C9oJoM=
Received: from omenarch.localnet (unknown [101.229.125.14])
        by smtp9 (Coremail) with SMTP id NeRpCgBHD3n6m05hXE9Rcw--.31335S2;
        Sat, 25 Sep 2021 11:48:10 +0800 (CST)
From:   andy200511@126.com
To:     linux-wireless@vger.kernel.org
Subject: Authentication Failure when target WiFi's signal strength is below 40% (rtw89)
Date:   Sat, 25 Sep 2021 11:48:09 +0800
Message-ID: <2931264.cLPqxE5pUp@omenarch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CM-TRANSID: NeRpCgBHD3n6m05hXE9Rcw--.31335S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFW7uw43GF13JF43WF1xZrb_yoWxCwb_ur
        WxJFn5Xr9rZr4kKan2kr4ftr1Fg3yxKr9Yvry8trsxCa4DZwn3CF17Wryfur1kG395tr9r
        Wry3Xwn5Zr4IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU87ku7UUUUU==
X-Originating-IP: [101.229.125.14]
X-CM-SenderInfo: pdqg5jyqqviia6rslhhfrp/1tbi5hoZa1pEBwJXrwAAst
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, dear Realtek engineers:
I am a user of the RTL8852AE card with the rtw89 kernel driver's unofficial DKMS 
module AUR package (https://aur.archlinux.org/packages/rtw89-dkms-git/). I 
have experienced some issue of authentication when I tried to connect to a 
5Ghz WiFi when its signal strength is below 40%. The specific problem is even 
when I give the correct password, the system keeps asking me to provide the 
password again (using KDE's NetworkManager, unsure if it is related and have 
not yet tested with other wifi managers). This issue solves when I move closer 
to my router to gain more signal strength.
Here is the output of dmesg:
http://fars.ee/00U7


